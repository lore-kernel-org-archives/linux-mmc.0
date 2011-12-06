From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: asdf
Date: Tue, 6 Dec 2011 11:08:59 +0300
Message-ID: <20111206080842.GA10021@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:36720 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932242Ab1LFIJW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Dec 2011 03:09:22 -0500
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kyungmin Park <kyungmin.park@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org

There is a new gcc warning in this function:

drivers/mmc/card/block.c:836:18: warning: =E2=80=98arg=E2=80=99 may be =
used uninitialized in this function [-Wuninitialized]

   810          /* The sanitize operation is supported at v4.5 only */
   811          if (mmc_can_sanitize(card)) {
   812                  err =3D mmc_switch(card, EXT_CSD_CMD_SET_NORMAL=
,
   813                                  EXT_CSD_SANITIZE_START, 1, 0);

1) arg is uninitialized here.  mmc_switch() can return -EIO.

   814                  goto out;
   815          }
   816 =20
   817          from =3D blk_rq_pos(req);
   818          nr =3D blk_rq_sectors(req);
   819 =20
   820          if (mmc_can_trim(card) && !mmc_erase_group_aligned(card=
, from, nr))
   821                  arg =3D MMC_SECURE_TRIM1_ARG;
   822          else
   823                  arg =3D MMC_SECURE_ERASE_ARG;
   824  retry:
   825          if (card->quirks & MMC_QUIRK_INAND_CMD38) {
   826                  err =3D mmc_switch(card, EXT_CSD_CMD_SET_NORMAL=
,
   827                                   INAND_CMD38_ARG_EXT_CSD,
   828                                   arg =3D=3D MMC_SECURE_TRIM1_AR=
G ?
                                         ^^^

3) uninitialized.

   829                                   INAND_CMD38_ARG_SECTRIM1 :
   830                                   INAND_CMD38_ARG_SECERASE,
   831                                   0);
   832                  if (err)
   833                          goto out;
   834          }
   835          err =3D mmc_erase(card, from, nr, arg);
   836          if (!err && arg =3D=3D MMC_SECURE_TRIM1_ARG) {
   837                  if (card->quirks & MMC_QUIRK_INAND_CMD38) {
   838                          err =3D mmc_switch(card, EXT_CSD_CMD_SE=
T_NORMAL,
   839                                           INAND_CMD38_ARG_EXT_CS=
D,
   840                                           INAND_CMD38_ARG_SECTRI=
M2,
   841                                           0);
   842                          if (err)
   843                                  goto out;
   844                  }
   845                  err =3D mmc_erase(card, from, nr, MMC_SECURE_TR=
IM2_ARG);
   846          }
   847  out:
   848          if (err =3D=3D -EIO && !mmc_blk_reset(md, card->host, t=
ype))
   849                  goto retry;

2) We could maybe hit the goto retry here if the reset works.

regards,
dan carpenter
