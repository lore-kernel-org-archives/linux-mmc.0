From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 2/2] mmc: core: prepend 0x to OCR entry in sysfs
Date: Wed, 29 Nov 2017 11:03:46 +0100
Message-ID: <CAPDyKFrKpLV9atAKcK8nP_SnkNt1rJ8U1ZpmW_Y=_WyhR81enA@mail.gmail.com>
References: <20171128082407.22303-1-bst@pengutronix.de> <20171128082407.22303-2-bst@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:40614 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752412AbdK2KDr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 29 Nov 2017 05:03:47 -0500
Received: by mail-it0-f67.google.com with SMTP id f190so3428055ita.5
        for <linux-mmc@vger.kernel.org>; Wed, 29 Nov 2017 02:03:47 -0800 (PST)
In-Reply-To: <20171128082407.22303-2-bst@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Bastian Stender <bst@pengutronix.de>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Bojan Prtvar <prtvar.b@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Jungseung Lee <js07.lee@samsung.com>, Sascha Hauer <kernel@pengutronix.de>

On 28 November 2017 at 09:24, Bastian Stender <bst@pengutronix.de> wrote:
> The sysfs entry "ocr" was missing the 0x prefix to identify it as hex
> formatted.
>
> Fixes: 5fb06af7a33b ("mmc: core: Extend sysfs with OCR register")
> Signed-off-by: Bastian Stender <bst@pengutronix.de>

Thanks, applied for fixes and added a stable tag. Actually this one
didn't apply to my fixes branch, but I fixed up the trivial conflict.

Kind regards
Uffe

> ---
> Changes since (implicit) v1 ("mmc: core: prepend 0x to hex numbers in sysfs"):
>   - split into two patches, each fixing its introducing commit (as
>     requested by Ulf Hansson)
>
> Changes since v2:
>   - commit messages were accidentally swapped, fix it
> ---
>  drivers/mmc/core/mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index b935ad895701..bad5c1bf4ed9 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
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
