From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: Add in support to expose PRV for v4 MMCs
Date: Thu, 28 Feb 2013 09:49:47 +0100
Message-ID: <CAPDyKFqEngnDuRpXoMj4FMFmr5Zm0eguBjphoFwSM6=_F2dNRA@mail.gmail.com>
References: <1361996357-9925-1-git-send-email-bhthompson@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:50721 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754382Ab3B1Itt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Feb 2013 03:49:49 -0500
Received: by mail-lb0-f173.google.com with SMTP id gf7so1191348lbb.18
        for <linux-mmc@vger.kernel.org>; Thu, 28 Feb 2013 00:49:48 -0800 (PST)
In-Reply-To: <1361996357-9925-1-git-send-email-bhthompson@chromium.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Bernie Thompson <bhthompson@chromium.org>
Cc: linux-mmc@vger.kernel.org, olof@lixom.net, Chris Ball <cjb@laptop.org>

On 27 February 2013 21:19, Bernie Thompson <bhthompson@chromium.org> wrote:
> The JEDEC MMC v4 spec defines a new PRV value in place of the original
> fwrev and hwrev specified in v1. We can expose this in the kernel to enable
> user space to more easily determine the product revision of a given MMC.
>
> Signed-off-by: Bernie Thompson <bhthompson@chromium.org>
> ---
>  Documentation/mmc/mmc-dev-attrs.txt | 1 +
>  drivers/mmc/core/mmc.c              | 3 +++
>  include/linux/mmc/card.h            | 1 +
>  3 files changed, 5 insertions(+)
>
> diff --git a/Documentation/mmc/mmc-dev-attrs.txt b/Documentation/mmc/mmc-dev-attrs.txt
> index 0d98fac..189bab0 100644
> --- a/Documentation/mmc/mmc-dev-attrs.txt
> +++ b/Documentation/mmc/mmc-dev-attrs.txt
> @@ -22,6 +22,7 @@ All attributes are read-only.
>         manfid                  Manufacturer ID (from CID Register)
>         name                    Product Name (from CID Register)
>         oemid                   OEM/Application ID (from CID Register)
> +       prv                     Product Revision (from CID Register) (SD and MMCv4 only)
>         serial                  Product Serial Number (from CID Register)
>         erase_size              Erase group size
>         preferred_erase_size    Preferred erase size
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index c8f3d6e..d584f7c 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -96,6 +96,7 @@ static int mmc_decode_cid(struct mmc_card *card)
>                 card->cid.prod_name[3]  = UNSTUFF_BITS(resp, 72, 8);
>                 card->cid.prod_name[4]  = UNSTUFF_BITS(resp, 64, 8);
>                 card->cid.prod_name[5]  = UNSTUFF_BITS(resp, 56, 8);
> +               card->cid.prv           = UNSTUFF_BITS(resp, 48, 8);
>                 card->cid.serial        = UNSTUFF_BITS(resp, 16, 32);
>                 card->cid.month         = UNSTUFF_BITS(resp, 12, 4);
>                 card->cid.year          = UNSTUFF_BITS(resp, 8, 4) + 1997;
> @@ -627,6 +628,7 @@ MMC_DEV_ATTR(hwrev, "0x%x\n", card->cid.hwrev);
>  MMC_DEV_ATTR(manfid, "0x%06x\n", card->cid.manfid);
>  MMC_DEV_ATTR(name, "%s\n", card->cid.prod_name);
>  MMC_DEV_ATTR(oemid, "0x%04x\n", card->cid.oemid);
> +MMC_DEV_ATTR(prv, "0x%x\n", card->cid.prv);
>  MMC_DEV_ATTR(serial, "0x%08x\n", card->cid.serial);
>  MMC_DEV_ATTR(enhanced_area_offset, "%llu\n",
>                 card->ext_csd.enhanced_area_offset);
> @@ -645,6 +647,7 @@ static struct attribute *mmc_std_attrs[] = {
>         &dev_attr_manfid.attr,
>         &dev_attr_name.attr,
>         &dev_attr_oemid.attr,
> +       &dev_attr_prv.attr,
>         &dev_attr_serial.attr,
>         &dev_attr_enhanced_area_offset.attr,
>         &dev_attr_enhanced_area_size.attr,
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 61b2c30..f31725b 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -17,6 +17,7 @@
>  struct mmc_cid {
>         unsigned int            manfid;
>         char                    prod_name[8];
> +       unsigned char           prv;
>         unsigned int            serial;
>         unsigned short          oemid;
>         unsigned short          year;
> --
> 1.8.1.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
