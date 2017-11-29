From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 1/2] mmc: core: prepend 0x to pre_eol_info entry in sysfs
Date: Wed, 29 Nov 2017 11:03:52 +0100
Message-ID: <CAPDyKFqNsuYk_KbHEwNxKhnWuxfLmcxzP3r9sF8FWg286c4inw@mail.gmail.com>
References: <20171128082407.22303-1-bst@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:39094 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752412AbdK2KDx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 29 Nov 2017 05:03:53 -0500
Received: by mail-it0-f68.google.com with SMTP id 68so3439716ite.4
        for <linux-mmc@vger.kernel.org>; Wed, 29 Nov 2017 02:03:53 -0800 (PST)
In-Reply-To: <20171128082407.22303-1-bst@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Bastian Stender <bst@pengutronix.de>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Bojan Prtvar <prtvar.b@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Jungseung Lee <js07.lee@samsung.com>, Sascha Hauer <kernel@pengutronix.de>

On 28 November 2017 at 09:24, Bastian Stender <bst@pengutronix.de> wrote:
> The sysfs entry "pre_eol_info" was missing the 0x prefix to identify it
> as hex formatted.
>
> Fixes: 46bc5c408e4e ("mmc: core: Export device lifetime information through sysfs")
> Signed-off-by: Bastian Stender <bst@pengutronix.de>

Thanks, applied for fixes!

I added a stable tag and also took the liberty of amending the change
to cover SD-cards (as that was also a part of the commit you fix).

Kind regards
Uffe

> ---
> Changes since (implicit) v1 ("mmc: core: prepend 0x to hex numbers in sysfs"):
>   - split into two patches, each fixing its introducing commit (as
>       requested by Ulf Hansson)
>
> Changes since v2:
>   - commit messages were accidentally swapped, fix it
>   - fix typo in commit message
> ---
>  drivers/mmc/core/mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 36217ad5e9b1..b935ad895701 100644
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
> --
> 2.11.0
>
