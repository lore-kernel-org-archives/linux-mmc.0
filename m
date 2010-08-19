From: David Vrabel <david.vrabel@csr.com>
Subject: [PATCH 2/2] mmc: avoid getting CID on SDIO-only cards
Date: Thu, 19 Aug 2010 14:09:31 +0000
Message-ID: <1282226971-3649-1-git-send-email-david.vrabel@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:51921 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751553Ab0HSOJj (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 19 Aug 2010 10:09:39 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mmc@vger.kernel.org, David Vrabel <david.vrabel@csr.com>

The introduction of support for SD combo cards breaks the initializatio=
n
of all CSR SDIO chips. The GO_IDLE (CMD0) in mmc_sd_get_cid() causes
CSR chips to be reset (this is non-standard behavior).

When initializing an SDIO card check for a combo card by using the
memory present bit in the R4 response to IO_SEND_OP_COND (CMD5).  This
avoids the call to mmc_sd_get_cid() on an SDIO-only card.

Acked-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
Signed-off-by: David Vrabel <david.vrabel@csr.com>
---
Andrew, this is a regression in 2.6.36-rc1.  Please queue for 2.6.36.
---
 drivers/mmc/core/sdio.c  |    5 ++---
 include/linux/mmc/sdio.h |    2 ++
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index bd2755e..f332c52 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -362,9 +362,8 @@ static int mmc_sdio_init_card(struct mmc_host *host=
, u32 ocr,
 		goto err;
 	}
=20
-	err =3D mmc_sd_get_cid(host, host->ocr & ocr, card->raw_cid);
-
-	if (!err) {
+	if (ocr & R4_MEMORY_PRESENT
+	    && mmc_sd_get_cid(host, host->ocr & ocr, card->raw_cid) =3D=3D 0)=
 {
 		card->type =3D MMC_TYPE_SD_COMBO;
=20
 		if (oldcard && (oldcard->type !=3D MMC_TYPE_SD_COMBO ||
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

