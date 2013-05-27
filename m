From: Peter Turczak <peter@turczak.de>
Subject: [RFC/PATCH]: mmc: card/core: support password locked cards
Date: Mon, 27 May 2013 10:41:03 +0200
Message-ID: <3B0B2667-A242-4337-96EC-3925AB4EC18F@turczak.de>
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Content-Type: multipart/signed; boundary="Apple-Mail=_CB9FC49C-5C44-45E8-9AB3-9A992F378292"; protocol="application/pgp-signature"; micalg=pgp-sha1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from netconsequence.de ([85.214.40.104]:40604 "EHLO
	mx.netconsequence.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757272Ab3E0Iu2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 27 May 2013 04:50:28 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Ulf Hansson <ulf.hansson@stericsson.com>, Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org


--Apple-Mail=_CB9FC49C-5C44-45E8-9AB3-9A992F378292
Content-Type: multipart/mixed;
	boundary="Apple-Mail=_C6F19185-8173-4C21-A82F-49AED4A1776E"


--Apple-Mail=_C6F19185-8173-4C21-A82F-49AED4A1776E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hi there,

while testing some features of sd cards, i found out, that the linux =
kernel does not currently support cards properly that are locked by =
password.
According to the publicly available SD card specification all SD cards =
seem to support this locking mechanism and i have seen cards in the wild =
using it.

When using a locked SD card in a linux machine using the mmc layer, =
probing the card leads to errors because most commands related to the =
actual storage are unavailable in a locked SD card.

Therefore I propose to add a basic support for locked cards in the =
kernel. The user space applications might take care of unlocking the =
card afterwards. When a card has been unlocked it stays unlocked until =
cycling it, reset commands won't lock it again.

My questions are:
1. Should a card that is locked be visible via /dev/mmcblkX?=20
 I think it should be, in order to be able to issue an unlock command.
2. What should read/write operations return on a locked card EPERM, =
EACCESS or something else?
3. Should locking/unlocking be done via a special ioctl command, as the =
card needs to be rescanned anyways?=20
4. How to cleanly initiate a rescan from userspace if answer to 3 is no? =
Currently I issue a reset command to the card which forces to kernel to =
fail issuing CMD13 and therefore reinitialize it, not too nice honestly.

See my proof-of-concept patch attached, it is not meant to be perfect =
but to show my point.

Best regards,
  Peter

--Apple-Mail=_C6F19185-8173-4C21-A82F-49AED4A1776E
Content-Disposition: attachment;
	filename=mmc_locked.patch
Content-Type: application/octet-stream;
	name="mmc_locked.patch"
Content-Transfer-Encoding: 7bit

--- linux-3.8.7.orig/drivers/mmc/card/block.c	2013-04-12 18:52:28.000000000 +0200
+++ linux-3.8.7/drivers/mmc/card/block.c	2013-05-27 10:05:58.000630168 +0200
@@ -761,7 +761,7 @@
 	u32 status, stop_status = 0;
 	int err, retry;
 
-	if (mmc_card_removed(card))
+	if (mmc_card_removed(card) || mmc_card_locked(card))
 		return ERR_NOMEDIUM;
 
 	/*
@@ -1363,6 +1363,7 @@
 			areq = &mq->mqrq_cur->mmc_active;
 		} else
 			areq = NULL;
+
 		areq = mmc_start_req(card->host, areq, (int *) &status);
 		if (!areq)
 			return 0;
@@ -1453,7 +1454,7 @@
 	return 1;
 
  cmd_abort:
-	if (mmc_card_removed(card))
+	if (mmc_card_removed(card) || mmc_card_locked(card))
 		req->cmd_flags |= REQ_QUIET;
 	while (ret)
 		ret = blk_end_request(req, -EIO, blk_rq_cur_bytes(req));
@@ -1586,6 +1587,13 @@
 	if (area_type & MMC_BLK_DATA_AREA_RPMB)
 		md->disk->flags |= GENHD_FL_NO_PART_SCAN;
 
+	/* If SD/MMC is locked, any read operation will fail
+	 * so there is no point in doing a partition scan
+	 * until the device is unlocked.
+	 */
+	if (mmc_card_locked(card))
+		md->disk->flags |= GENHD_FL_NO_PART_SCAN;
+
 	/*
 	 * As discussed on lkml, GENHD_FL_REMOVABLE should:
 	 *
@@ -1652,6 +1660,7 @@
 		 */
 		size = card->csd.capacity << (card->csd.read_blkbits - 9);
 	}
+
 
 	md = mmc_blk_alloc_req(card, &card->dev, size, false, NULL,
 					MMC_BLK_DATA_AREA_MAIN);
@@ -1877,9 +1886,10 @@
 
 	string_get_size((u64)get_capacity(md->disk) << 9, STRING_UNITS_2,
 			cap_str, sizeof(cap_str));
-	pr_info("%s: %s %s %s %s\n",
+	pr_info("%s: %s %s %s %s %s\n",
 		md->disk->disk_name, mmc_card_id(card), mmc_card_name(card),
-		cap_str, md->read_only ? "(ro)" : "");
+		cap_str, md->read_only ? "(ro)" : "",
+		mmc_card_locked(card) ? "(locked)" : "");
 
 	if (mmc_blk_alloc_parts(card, md))
 		goto out;
--- linux-3.8.7.orig/drivers/mmc/core/sd.c	2013-04-12 18:52:28.000000000 +0200
+++ linux-3.8.7/drivers/mmc/core/sd.c	2013-05-27 10:04:56.568770589 +0200
@@ -796,8 +796,30 @@
 	bool reinit)
 {
 	int err;
+	int status;
 
-	if (!reinit) {
+	/*
+	 * Test if card is locked
+	 */
+	err = mmc_send_status(card, &status);
+	if (err)
+		return err;
+
+	if (status & R1_CARD_IS_LOCKED)
+		mmc_card_set_locked(card);
+	else {
+		/* If card used to be locked, this is _not_ an reinit! */
+		if (mmc_card_locked(card))
+			reinit = false;
+
+		mmc_card_clr_locked(card);
+	}
+
+	/*
+	 * If card is locked or already initialized, do not try to
+	 * set it up further .
+	 */
+	if (!reinit && !mmc_card_locked(card)) {
 		/*
 		 * Fetch SCR from card.
 		 */
--- linux-3.8.7.orig/include/linux/mmc/card.h	2013-04-12 18:52:28.000000000 +0200
+++ linux-3.8.7/include/linux/mmc/card.h	2013-05-27 10:03:39.828834488 +0200
@@ -233,6 +233,7 @@
 #define MMC_CARD_REMOVED	(1<<7)		/* card has been removed */
 #define MMC_STATE_HIGHSPEED_200	(1<<8)		/* card is in HS200 mode */
 #define MMC_STATE_DOING_BKOPS	(1<<10)		/* card is doing BKOPS */
+#define MMC_STATE_LOCKED	(1<<11)		/* card is password protected */
 	unsigned int		quirks; 	/* card quirks */
 #define MMC_QUIRK_LENIENT_FN0	(1<<0)		/* allow SDIO FN0 writes outside of the VS CCCR range */
 #define MMC_QUIRK_BLKSZ_FOR_BYTE_MODE (1<<1)	/* use func->cur_blksize */
@@ -395,6 +396,7 @@
 #define mmc_card_ext_capacity(c) ((c)->state & MMC_CARD_SDXC)
 #define mmc_card_removed(c)	((c) && ((c)->state & MMC_CARD_REMOVED))
 #define mmc_card_doing_bkops(c)	((c)->state & MMC_STATE_DOING_BKOPS)
+#define mmc_card_locked(c)	((c)->state & MMC_STATE_LOCKED)
 
 #define mmc_card_set_present(c)	((c)->state |= MMC_STATE_PRESENT)
 #define mmc_card_set_readonly(c) ((c)->state |= MMC_STATE_READONLY)
@@ -408,6 +410,8 @@
 #define mmc_card_set_removed(c) ((c)->state |= MMC_CARD_REMOVED)
 #define mmc_card_set_doing_bkops(c)	((c)->state |= MMC_STATE_DOING_BKOPS)
 #define mmc_card_clr_doing_bkops(c)	((c)->state &= ~MMC_STATE_DOING_BKOPS)
+#define mmc_card_set_locked(c)	((c)->state |= MMC_STATE_LOCKED)
+#define mmc_card_clr_locked(c)	((c)->state &= ~MMC_STATE_LOCKED)
 
 /*
  * Quirk add/remove for MMC products.

--Apple-Mail=_C6F19185-8173-4C21-A82F-49AED4A1776E--

--Apple-Mail=_CB9FC49C-5C44-45E8-9AB3-9A992F378292
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0.19 (Darwin)

iEYEARECAAYFAlGjHCIACgkQzYoxuB8OwDkikQCcDCzWJwCm/egcMnfvV+fveAdT
6tYAoJSPMSw0lT1Xe1kp3IaA4BX51GS4
=CV3F
-----END PGP SIGNATURE-----

--Apple-Mail=_CB9FC49C-5C44-45E8-9AB3-9A992F378292--
