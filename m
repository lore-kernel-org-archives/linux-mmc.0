Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51AB6C433F5
	for <linux-mmc@archiver.kernel.org>; Tue, 26 Oct 2021 17:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27ECD60F9D
	for <linux-mmc@archiver.kernel.org>; Tue, 26 Oct 2021 17:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234907AbhJZRP4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 26 Oct 2021 13:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236010AbhJZRPz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Oct 2021 13:15:55 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CA5C061745
        for <linux-mmc@vger.kernel.org>; Tue, 26 Oct 2021 10:13:31 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id c28so192963lfv.13
        for <linux-mmc@vger.kernel.org>; Tue, 26 Oct 2021 10:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=adv3DrwpkGGcBynbCZO162xm2hRyNhR/LtXPfxRRi2c=;
        b=Q72mLxkFvHZe5KYX3sirINKTZoIt5iabZr6TrRHELzPlCcQUBWdWQGpGEkM9WJMppX
         /olRSlp5+JyE5jje1Fui+MEFgSIsxEnOskfI0h+vrRb5jqJWZQRdbF8ztZXRH//RPm73
         mN4AvNDXDfCy5dluaC6v+U0iIOId6urJj3c/QKH8L2FnFSolspILU6xmfQxL9HjDdzRh
         z32YTqHEDbvvJzn4X2+bNxPQ7nt44PYqAzu8RQ8ZTktQAqA2+EEOZk16c/3aDvAaVJqM
         CUjT7TNiMcNLqybffNhejLLm573rKF0IyqJGVOwDdCrltHFoqslHGdwoElpbzaBMnzxj
         G4zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=adv3DrwpkGGcBynbCZO162xm2hRyNhR/LtXPfxRRi2c=;
        b=HzkvSHntrhJ7AHPSxsQiCiysRcnLn3vzeob4bTxg3SWvaIYC5y6Q26Gk5tOp9Fpl0v
         Xk8mAIi6wtHvsXwnvZFPz/WLzaKWwtYi/x95BSD+DFg9NWaBCbq5IXjWD+KT8+kgZD4h
         bGDhYpEKxNRv4ep7i9AkBhf9ErHXNtSYlSAOYuI7wnzSUmVuGHTHReBSPmc3hoqo2Gum
         HbyIrOzN54W3SCr0T7JBZvz9C2vbS0zE0UVOLacj9P5c0wtr5HX77Di52wattAucdKyV
         xfBSXe3r/P5Vv6KC0ne1vz/l1ud3sHdrLbiObzIWbfWCYCMdmTOl/Gl+9Li3MifL0+vt
         orCg==
X-Gm-Message-State: AOAM533LH4Bf/0yqYrkNS9AFHpyFmDqJXrcFNb9lyc7vOX/EzujSe/5F
        KypOa/gxhp403erwLZdbxVf1ZaiDOTlf0Mn7kqw7Ag==
X-Google-Smtp-Source: ABdhPJxmfm4vxU3hKAAcuoV4xXuInXZ7bkNH4ezbrLDeV7I5CjJYCi5kL5SjIkfEIaLt2GOC0ZhHd4/hE+z2xqwEThI=
X-Received: by 2002:ac2:44c3:: with SMTP id d3mr20699654lfm.184.1635268409288;
 Tue, 26 Oct 2021 10:13:29 -0700 (PDT)
MIME-Version: 1.0
References: <8ecc5c79c1dd0627d570ede31e18c860786cacca.1633519499.git.hns@goldelico.com>
In-Reply-To: <8ecc5c79c1dd0627d570ede31e18c860786cacca.1633519499.git.hns@goldelico.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 26 Oct 2021 19:12:52 +0200
Message-ID: <CAPDyKFraMXqC9OBeUTpm=bxjrFZTCopV3ZJQf1TRsA8UeTWdTA@mail.gmail.com>
Subject: Re: [RFC] mmc: core: transplant ti,wl1251 quirks from to be retired omap_hsmmc
To:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Jerome Pouiller <Jerome.Pouiller@silabs.com>
Cc:     Avri Altman <avri.altman@wdc.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bean Huo <beanhuo@micron.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

+ Jerome

On Wed, 6 Oct 2021 at 13:25, H. Nikolaus Schaller <hns@goldelico.com> wrote:
>
> The TiWi 5 WiFi module needs special setup of the sdio
> interface before it can be probed.
>
> So far, this is done in omap_hsmmc_init_card() in omap_hsmmc.c
> which makes it useable only if connected to omap devices
> which use the omap_hsmmc. The OpenPandora is the most promient
> example.
>
> There are plans to switch to a newer sdhci-omap driver and
> retire omap_hsmmc. Hence this quirk must be reworked or moved
> somewhere else. Ideally to some location that is not dependent
> on the specific SoC mmc host driver.
>
> Analysis has shown that omap_hsmmc_init_card() is called
> through the host->ops->init_card hook which itself
> is called in three generic locations:
>
> mmc_init_card()
> mmc_sd_init_card()
> mmc_sdio_init_card()
>
> All these functions share a call to mmc_select_card() shortly
> after running the init hook and therefore I assume that
> a good place transplanting the special wl1251 handling is
> mmc_select_card() - unless we want to copy and maintain the
> code to three different places.
>
> After this quirk has been moved there, we can remove
> omap_hsmmc_init_card() in omap_hsmmc.c in a separate patch.
> Indeed the plan is to remove omap_hsmmc.c completely.
>
> A future development path to generalize could be to make
> the code not depend on compatible = "ti,wl1251" but check
> for optional device tree properties (non-std-sdio, bus width,
> vendor, device, blksize, max_dtr, ocr) which can be defined
> for any child device of the mmd/sd port needing such special
> setup.

I wouldn't go that path, simply because it may look like we encourage
vendors to deviate from the SDIO spec. :-)

At least for now, matching on the compatible string and applying card
quirks makes perfect sense to me.

>
> Related-to: commit f6498b922e57 ("mmc: host: omap_hsmmc: add code for special init of wl1251 to get rid of pandora_wl1251_init_card")
> Related-to: commit 2398c41d6432 ("omap: pdata-quirks: remove openpandora quirks for mmc3 and wl1251")
> Related-to: commit f9d50fef4b64 ("ARM: OMAP2+: omap3-pandora: add wifi support")
> Tested-by: H. Nikolaus Schaller <hns@goldelico.com> # on OpenPandora
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>

As a matter of fact, the similar problem that you are looking to
address (applying card quirks based on DT compatibility strings), is
partly being taken care of in another series [1], being discussed
right now. I think the solution for the ti,wl1251 should be based upon
that too. Please have a look and see if you can play with that!?

Kind regards
Uffe

[1]
[RFC PATCH 0/2] mmc: allow to rely on the DT to apply quirks
https://lore.kernel.org/lkml/20211014143031.1313783-1-Jerome.Pouiller@silabs.com/

> ---
>  drivers/mmc/core/mmc_ops.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index 0c54858e89c0..6f9b96be9fe6 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -7,6 +7,7 @@
>
>  #include <linux/slab.h>
>  #include <linux/export.h>
> +#include <linux/of.h>
>  #include <linux/types.h>
>  #include <linux/scatterlist.h>
>
> @@ -107,6 +108,35 @@ static int _mmc_select_card(struct mmc_host *host, struct mmc_card *card)
>
>  int mmc_select_card(struct mmc_card *card)
>  {
> +       if (card->type == MMC_TYPE_SDIO || card->type == MMC_TYPE_SD_COMBO) {
> +               struct device_node *np = card->host->parent->of_node;
> +
> +               /*
> +                * REVISIT: should be made more general
> +                * e.g. by expanding the DT bindings of child nodes to
> +                * optionally provide this information:
> +                * Documentation/devicetree/bindings/mmc/mmc-card.txt
> +                */
> +
> +               np = of_get_compatible_child(np, "ti,wl1251");
> +               if (np) {
> +                       /*
> +                        * We have TI wl1251 attached to this mmc. Pass this
> +                        * information to the SDIO core because it can't be
> +                        * probed by normal methods.
> +                        */
> +
> +                       dev_info(card->host->parent, "found wl1251\n");
> +                       card->quirks |= MMC_QUIRK_NONSTD_SDIO;
> +                       card->cccr.wide_bus = 1;
> +                       card->cis.vendor = 0x104c;
> +                       card->cis.device = 0x9066;
> +                       card->cis.blksize = 512;
> +                       card->cis.max_dtr = 24000000;
> +                       card->ocr = 0x80;
> +                       of_node_put(np);
> +               }
> +       }
>
>         return _mmc_select_card(card->host, card);
>  }
> --
> 2.33.0
>
