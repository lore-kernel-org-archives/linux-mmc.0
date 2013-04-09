From: Prasanna NAVARATNA <prasanna.navaratna@gmail.com>
Subject: Re: mmc: core: negotiate ocr during resume
Date: Tue, 9 Apr 2013 08:43:27 +0000 (UTC)
Message-ID: <loom.20130409T103912-743@post.gmane.org>
References: <loom.20130404T163258-423@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:59610 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935524Ab3DIInp (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 9 Apr 2013 04:43:45 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkm-linux-mmc@m.gmane.org>)
	id 1UPU9U-0006jq-UP
	for linux-mmc@vger.kernel.org; Tue, 09 Apr 2013 10:43:41 +0200
Received: from 202.122.18.226 ([202.122.18.226])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Tue, 09 Apr 2013 10:43:40 +0200
Received: from prasanna.navaratna by 202.122.18.226 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Tue, 09 Apr 2013 10:43:40 +0200
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Prasanna NAVARATNA <prasanna.navaratna <at> gmail.com> writes:

> 
> From f43005e05f1e9d93705ec6b3ab98cfa5215c1896 Mon Sep 17 00:00:00 2001
> From: Prasanna NAVARATNA <prasanna.navaratna <at> broadcom.com>
> Date: Thu, 4 Apr 2013 19:55:19 +0530
> Subject: [PATCH] mmc: core: negotiate ocr during resume
> 
> Save the card ocr into struct mmc_card when read from sd card and
> negotiate ocr mask during mmc_sd_init_card with host->ocr & card->ocr.
> ---
>  drivers/mmc/core/sd.c    |    7 +++++++
>  include/linux/mmc/card.h |    1 +
>  2 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 9e645e1..8ee27e8 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
>  <at>  <at>  -910,6 +910,10  <at>  <at>  static int 
mmc_sd_init_card(struct mmc_host *host, u32 
> ocr,
>  	BUG_ON(!host);
>  	WARN_ON(!host->claimed);
> 
> +	/* Negotiate OCR with oldcard->ocr */
> +	if (oldcard)
> +		ocr &= oldcard->ocr;
> +
>  	err = mmc_sd_get_cid(host, ocr, cid, &rocr);
>  	if (err)
>  		return err;
>  <at>  <at>  -1185,6 +1189,9  <at>  <at>  int mmc_attach_sd(struct 
mmc_host *host)
>  		ocr &= ~MMC_VDD_165_195;
>  	}
> 
> +	/* Save the card OCR */
> +	host->card->ocr = ocr;
> +
>  	host->ocr = mmc_select_voltage(host, ocr);
> 
>  	/*
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index f31725b..1bbec2f 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
>  <at>  <at>  -273,6 +273,7  <at>  <at>  struct mmc_card {
>  	u32			raw_cid[4];	/* raw card CID */
>  	u32			raw_csd[4];	/* raw card CSD */
>  	u32			raw_scr[2];	/* raw card SCR */
> +	u32			ocr;		/* card OCR */
>  	struct mmc_cid		cid;		/* card identification */
>  	struct mmc_csd		csd;		/* card specific */
>  	struct mmc_ext_csd	ext_csd;	/* mmc v4 extended card 
> specific */

New Patch Set updated as below :-
------------------------------

>From 306c151cb5b217ff7c622a769df120b14153c25a Mon Sep 17 00:00:00 2001
From: Prasanna NAVARATNA <prasanna.navaratna@broadcom.com>
Date: Thu, 4 Apr 2013 19:55:19 +0530
Subject: [PATCH] mmc: core: proper ocr negotiation during resume

Save the card ocr into struct mmc_card when read from card
during initialization of sd/mmc/sdio.
Druing mmc_resume_host, supply saved card's ocr to
mmc_select_voltage so as to negotiate voltage appropriately.
---
 drivers/mmc/core/core.c  |    1 +
 drivers/mmc/core/mmc.c   |    3 +++
 drivers/mmc/core/sd.c    |    3 +++
 drivers/mmc/core/sdio.c  |    3 +++
 include/linux/mmc/card.h |    1 +
 5 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index ad7decc..e61b5ab 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2680,6 +2680,7 @@ int mmc_resume_host(struct mmc_host *host)
 	if (host->bus_ops && !host->bus_dead) {
 		if (!mmc_card_keep_power(host)) {
 			mmc_power_up(host);
+			host->ocr = host->card ? host->card->ocr : host-
>ocr;
 			mmc_select_voltage(host, host->ocr);
 			/*
 			 * Tell runtime PM core we just powered up the card,
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 0cbd1ef..9b4b3a5 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1566,6 +1566,9 @@ int mmc_attach_mmc(struct mmc_host *host)
 		ocr &= ~0x7F;
 	}
 
+	/* Save the card OCR */
+	host->card->ocr = ocr;
+
 	host->ocr = mmc_select_voltage(host, ocr);
 
 	/*
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 9e645e1..965504b 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -1185,6 +1185,9 @@ int mmc_attach_sd(struct mmc_host *host)
 		ocr &= ~MMC_VDD_165_195;
 	}
 
+	/* Save the card OCR */
+	host->card->ocr = ocr;
+
 	host->ocr = mmc_select_voltage(host, ocr);
 
 	/*
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index aa0719a..3f9e08d 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -1090,6 +1090,9 @@ int mmc_attach_sdio(struct mmc_host *host)
 		ocr &= ~0x7F;
 	}
 
+	/* Save the card OCR */
+	host->card->ocr = ocr;
+
 	host->ocr = mmc_select_voltage(host, ocr);
 
 	/*
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index f31725b..1bbec2f 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -273,6 +273,7 @@ struct mmc_card {
 	u32			raw_cid[4];	/* raw card CID */
 	u32			raw_csd[4];	/* raw card CSD */
 	u32			raw_scr[2];	/* raw card SCR */
+	u32			ocr;		/* card OCR */
 	struct mmc_cid		cid;		/* card identification */
 	struct mmc_csd		csd;		/* card specific */
 	struct mmc_ext_csd	ext_csd;	/* mmc v4 extended card 
specific */
-- 
1.7.6

Please review

