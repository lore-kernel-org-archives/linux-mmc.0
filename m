From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: core: prepend 0x to hex numbers in sysfs
Date: Thu, 23 Nov 2017 14:28:24 +0100
Message-ID: <CAPDyKForkLBLn059w1HJh8TCZTAim8RY3GF=ic5ot+_zEh6UzQ@mail.gmail.com>
References: <20171116113000.25044-1-bst@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:45430 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751479AbdKWN2Z (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Nov 2017 08:28:25 -0500
Received: by mail-it0-f67.google.com with SMTP id x13so10117859iti.4
        for <linux-mmc@vger.kernel.org>; Thu, 23 Nov 2017 05:28:25 -0800 (PST)
In-Reply-To: <20171116113000.25044-1-bst@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Bastian Stender <bst@pengutronix.de>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Bojan Prtvar <prtvar.b@gmail.com>, Jungseung Lee <js07.lee@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Sascha Hauer <kernel@pengutronix.de>

On 16 November 2017 at 12:30, Bastian Stender <bst@pengutronix.de> wrote:
> The sysfs entries "pre_eol_info" and "ocr" were missing the 0x prefix
> to identify them as hex formatted.
>
> Fixes: 5fb06af7a33b ("mmc: core: Extend sysfs with OCR register")
> Fixes: 46bc5c408e4e ("mmc: core: Export device lifetime information through sysfs")
> Signed-off-by: Bastian Stender <bst@pengutronix.de>

Bastian, would you mind splitting this into two patches. I need that
to be able to add correct stable tags to each of them.

Kind regards
Uffe

> ---
>  drivers/mmc/core/mmc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 36217ad5e9b1..bad5c1bf4ed9 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -780,7 +780,7 @@ MMC_DEV_ATTR(manfid, "0x%06x\n", card->cid.manfid);
>  MMC_DEV_ATTR(name, "%s\n", card->cid.prod_name);
>  MMC_DEV_ATTR(oemid, "0x%04x\n", card->cid.oemid);
>  MMC_DEV_ATTR(prv, "0x%x\n", card->cid.prv);
> -MMC_DEV_ATTR(pre_eol_info, "%02x\n", card->ext_csd.pre_eol_info);
> +MMC_DEV_ATTR(pre_eol_info, "0x%02x\n", card->ext_csd.pre_eol_info);
>  MMC_DEV_ATTR(life_time, "0x%02x 0x%02x\n",
>         card->ext_csd.device_life_time_est_typ_a,
>         card->ext_csd.device_life_time_est_typ_b);
> @@ -790,7 +790,7 @@ MMC_DEV_ATTR(enhanced_area_offset, "%llu\n",
>  MMC_DEV_ATTR(enhanced_area_size, "%u\n", card->ext_csd.enhanced_area_size);
>  MMC_DEV_ATTR(raw_rpmb_size_mult, "%#x\n", card->ext_csd.raw_rpmb_size_mult);
>  MMC_DEV_ATTR(rel_sectors, "%#x\n", card->ext_csd.rel_sectors);
> -MMC_DEV_ATTR(ocr, "%08x\n", card->ocr);
> +MMC_DEV_ATTR(ocr, "0x%08x\n", card->ocr);
>  MMC_DEV_ATTR(cmdq_en, "%d\n", card->ext_csd.cmdq_en);
>
>  static ssize_t mmc_fwrev_show(struct device *dev,
> --
> 2.11.0
>
