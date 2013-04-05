From: Kevin Liu <keyuan.liu@gmail.com>
Subject: Re: core: negotiate ocr during resume
Date: Fri, 5 Apr 2013 16:33:42 +0800
Message-ID: <CADz5_gKbDh6Q6H=CJf8ZeH_t9gQ4J_L+wtJghVDo7tep2N4qYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:64011 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750837Ab3DEIdm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Apr 2013 04:33:42 -0400
Received: by mail-ob0-f179.google.com with SMTP id vb8so3471125obc.10
        for <linux-mmc@vger.kernel.org>; Fri, 05 Apr 2013 01:33:42 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Prasanna NAVARATNA <prasanna.navaratna@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-owner@vger.kernel.org] On Behalf Of Prasanna NAVARATNA
> Sent: Thursday, April 04, 2013 10:35 PM
> To: linux-mmc@vger.kernel.org
> Subject: mmc: core: negotiate ocr during resume
>
> From f43005e05f1e9d93705ec6b3ab98cfa5215c1896 Mon Sep 17 00:00:00 2001
> From: Prasanna NAVARATNA <prasanna.navaratna@broadcom.com>
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
> @@ -910,6 +910,10 @@ static int mmc_sd_init_card(struct mmc_host *host, u32
> ocr,
>         BUG_ON(!host);
>         WARN_ON(!host->claimed);
>
> +       /* Negotiate OCR with oldcard->ocr */
> +       if (oldcard)
> +               ocr &= oldcard->ocr;
> +

I think there are several issues here:
1. with this patch the vmmc voltage should still be 3.3v after resume
back since the vmmc voltage is updated in set_ios which depend on
mmc_select_voltage. But mmc_select_voltage didn't notice your ocr
update.
2. you didn't handle the special case that the card is changed to a
new card during suspended. So the ocr may be different here.
3. mmc.c and sdio.c should also be updated besides sd.c.

I have another old version of this patch attached below for your reference:

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index aaed768..f3c7b33 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1351,6 +1351,7 @@ void mmc_power_off(struct mmc_host *host)
         * Reset ocr mask to be the highest possible voltage supported for
         * this mmc host. This value will be used at next power up.
         */
+       host->ocr_bak = host->ocr;
        host->ocr = 1 << (fls(host->ocr_avail) - 1);

        if (!mmc_host_is_spi(host)) {
@@ -2491,7 +2492,6 @@ int mmc_resume_host(struct mmc_host *host)
        if (host->bus_ops && !host->bus_dead) {
                if (!mmc_card_keep_power(host)) {
                        mmc_power_up(host);
-                       mmc_select_voltage(host, host->ocr);
                        /*
                         * Tell runtime PM core we just powered up the card,
                         * since it still believes the card is powered off.
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index e6e3911..a8e81d2 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -882,7 +882,9 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
                        err = -ENOENT;
                        goto err;
                }
-
+               /* restore ocr for the same card */
+               if (host->ocr_bak && (host->ocr_bak != host->ocr))
+                       host->ocr = mmc_select_voltage(host, host->ocr_bak);
                card = oldcard;
        } else {
                /*
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 3dafb54..2eea1ae 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -908,7 +908,9 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
        if (oldcard) {
                if (memcmp(cid, oldcard->raw_cid, sizeof(cid)) != 0)
                        return -ENOENT;
-
+               /* restore ocr for the same card */
+               if (host->ocr_bak && (host->ocr_bak != host->ocr))
+                       host->ocr = mmc_select_voltage(host, host->ocr_bak);
                card = oldcard;
        } else {
                /*
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 2273ce6..f66cc9a 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -594,6 +594,11 @@ static int mmc_sdio_init_card(struct mmc_host
*host, u32 ocr,
                err = mmc_send_io_op_cond(host, host->ocr, &ocr);
                if (err)
                        goto err;
+               if (oldcard) {
+                       /* restore ocr for the same card */
+                       if (host->ocr_bak && (host->ocr_bak != host->ocr))
+                               host->ocr = mmc_select_voltage(host,
host->ocr_bak);
+               }
        }

        /*
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index a90ea7b..ae5533e 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -285,6 +285,7 @@ struct mmc_host {

        struct mmc_ios          ios;            /* current io bus settings */
        u32                     ocr;            /* the current OCR setting */
+       u32                     ocr_bak;        /* save current OCR setting */

        /* group bitfields together to minimize padding */
        unsigned int            use_spi_crc:1;

Thanks
Kevin

>         err = mmc_sd_get_cid(host, ocr, cid, &rocr);
>         if (err)
>                 return err;
> @@ -1185,6 +1189,9 @@ int mmc_attach_sd(struct mmc_host *host)
>                 ocr &= ~MMC_VDD_165_195;
>         }
>
> +       /* Save the card OCR */
> +       host->card->ocr = ocr;
> +
>         host->ocr = mmc_select_voltage(host, ocr);
>
>         /*
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index f31725b..1bbec2f 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -273,6 +273,7 @@ struct mmc_card {
>         u32                     raw_cid[4];     /* raw card CID */
>         u32                     raw_csd[4];     /* raw card CSD */
>         u32                     raw_scr[2];     /* raw card SCR */
> +       u32                     ocr;            /* card OCR */
>         struct mmc_cid          cid;            /* card identification */
>         struct mmc_csd          csd;            /* card specific */
>         struct mmc_ext_csd      ext_csd;        /* mmc v4 extended card
> specific */
> --
> 1.7.6
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
