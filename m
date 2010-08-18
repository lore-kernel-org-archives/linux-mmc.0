From: David Vrabel <david.vrabel@csr.com>
Subject: [PATCH] mmc: avoid getting CID on SDIO-only cards
Date: Wed, 18 Aug 2010 17:29:04 +0000
Message-ID: <1282152544-21275-1-git-send-email-david.vrabel@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:54293 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750938Ab0HRR33 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 18 Aug 2010 13:29:29 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mmc@vger.kernel.org, David Vrabel <david.vrabel@csr.com>, =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>

The introduction of support for SD combo cards breaks the initializatio=
n
of all CSR SDIO chips. The GO_IDLE (CMD0) in mmc_sd_get_cid() causes
CSR chips to be reset (this is non-standard behavior).

When initializing an SDIO card check for a combo card by using the
memory present bit in the R4 response to IO_SEND_OP_COND (CMD5).  This
avoids the call to mmc_sd_get_cid() on an SDIO-only card.

Cc: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
Signed-off-by: David Vrabel <david.vrabel@csr.com>
---
Andrew, this is a regression in 2.6.36-rc1.  Please queue for 2.6.36 if
Micha=C5=82 acks it.
---
 drivers/mmc/core/sdio.c  |    8 +++++---
 include/linux/mmc/sdio.h |    2 ++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index bd2755e..cc34523 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -362,11 +362,13 @@ static int mmc_sdio_init_card(struct mmc_host *ho=
st, u32 ocr,
 		goto err;
 	}
=20
-	err =3D mmc_sd_get_cid(host, host->ocr & ocr, card->raw_cid);
-
-	if (!err) {
+	if (ocr & R4_MEMORY_PRESENT) {
 		card->type =3D MMC_TYPE_SD_COMBO;
=20
+		err =3D mmc_sd_get_cid(host, host->ocr & ocr, card->raw_cid);
+		if (err)
+			goto remove;
+
 		if (oldcard && (oldcard->type !=3D MMC_TYPE_SD_COMBO ||
 		    memcmp(card->raw_cid, oldcard->raw_cid, sizeof(card->raw_cid)) !=
=3D 0)) {
 			mmc_remove_card(card);
diff --git a/include/linux/mmc/sdio.h b/include/linux/mmc/sdio.h
index 329a8fa..245cdac 100644
--- a/include/linux/mmc/sdio.h
+++ b/include/linux/mmc/sdio.h
@@ -38,6 +38,8 @@
  *      [8:0] Byte/block count
  */
=20
+#define R4_MEMORY_PRESENT (1 << 27)
+
 /*
   SDIO status in R5
   Type
--=20
1.6.3.3

