Return-Path: <SRS0=vd7C=2A=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F1FBC2D0BF
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Dec 2019 13:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75B7D20652
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Dec 2019 13:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vFmxC2HF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbfLJNKZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 10 Dec 2019 08:10:25 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:45438 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbfLJNKY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Dec 2019 08:10:24 -0500
Received: by mail-vs1-f67.google.com with SMTP id l24so12933557vsr.12
        for <linux-mmc@vger.kernel.org>; Tue, 10 Dec 2019 05:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NSgXLY7zn19iKGK0lMSKicsXOogf2N1V6mwuOTacvso=;
        b=vFmxC2HFI6hes3oDbNBxlB7e0dsTQISm/o7uGplKJlNntWAXykRoxseuGeOWfL8Nrc
         oG/p72shYHiyVdWlxhO6k5FJoVVYtEOnQ/oOwC1IZJYxMaWvcP9KLStM+w8/cndN9zGi
         tLT7zg6pSYI3ur0g9WtUFtQtQU4uP4H/wZKJxmCd2NXJOgwuAC2T9xrpNdmIN4Z8gdGj
         XKfjT2CUSFAeSc1gdurBT2wT8zd69Q5XzAmAnFSayl3eHVccd5j3BxNiM84OJ6xYV4D/
         n7vm3UR105hvKvKJnwuyoHOxI80UpeLwS00vidyxYxpm4iIf8BL0L0qHrd8F262G0OUI
         YzCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NSgXLY7zn19iKGK0lMSKicsXOogf2N1V6mwuOTacvso=;
        b=XI0miil7hgUiYu0VpURg+5his1Jvjcq6pNhv1KIAjeh0/Yivnq40er+1D/IvmLXARl
         2NqaTJhW1KRc2LZkQWdIRhgdNMoTd8UNEQ9R9EjXS5DCRqTSCEyJmtr52q0mT4RTnlvu
         Alv+DsnEW19lwcdNmHc9hdbLtiWkGmfsuBVFX4CXDg1cdGD/flxMAK15+eDBhJMoqbAr
         jJgTp6eutpZsMnqysWMKJw3j8XSPK9UGA8ELsbxgi3pq8ro1joHvPBT+g4MyDklk3ZGo
         SAmeS54kXTq5T5x6/X1Dogs6iaYmKPe/ns0Y+aquoHwm5XN3qQvdO/bAxcu4oYIc3Omh
         9bkw==
X-Gm-Message-State: APjAAAXJYe85gxHk1b/jI3C83iIZUZrGoA1pD10b0AH+KOLgLoFPSNLI
        M4PiyoUHulHL7yQGsRH/qKkG9mFGe2IACHZBns8Y1Q==
X-Google-Smtp-Source: APXvYqxJRyVUMS3rG+TK07GWx93zHpQLUw1qnfmkvDmlYwKOM2YcUVvarh+8ZagtE16HG1PSCyMugCWFPdBpVnbG1W8=
X-Received: by 2002:a05:6102:5d1:: with SMTP id v17mr24811015vsf.200.1575983423704;
 Tue, 10 Dec 2019 05:10:23 -0800 (PST)
MIME-Version: 1.0
References: <20191203194859.917-1-wsa@the-dreams.de>
In-Reply-To: <20191203194859.917-1-wsa@the-dreams.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 10 Dec 2019 14:09:47 +0100
Message-ID: <CAPDyKFrngFAOUF0QN7+yjAyo3XxS9asT0Q5350i8K9h2TBavwQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: renesas_sdhi: remove whitelist for internal DMAC
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 3 Dec 2019 at 20:49, Wolfram Sang <wsa@the-dreams.de> wrote:
>
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> We know now that there won't be Gen3 SoCs with both, SYS-DMAC and
> internal DMAC. We removed the blacklisting for SYS-DMAC already, so we
> can remove the whitelisting for internal DMAC, too. This makes adding
> new SoCs easier. We keep the quirk handling, of course.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/renesas_sdhi_internal_dmac.c | 23 ++++---------------
>  1 file changed, 4 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> index 68fb39a74b8b..47ac53e91241 100644
> --- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> +++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> @@ -298,38 +298,23 @@ static const struct tmio_mmc_dma_ops renesas_sdhi_internal_dmac_dma_ops = {
>   * Whitelist of specific R-Car Gen3 SoC ES versions to use this DMAC
>   * implementation as others may use a different implementation.
>   */
> -static const struct soc_device_attribute soc_whitelist[] = {
> -       /* specific ones */
> +static const struct soc_device_attribute soc_dma_quirks[] = {
>         { .soc_id = "r7s9210",
>           .data = (void *)BIT(SDHI_INTERNAL_DMAC_ADDR_MODE_FIXED_ONLY) },
>         { .soc_id = "r8a7795", .revision = "ES1.*",
>           .data = (void *)BIT(SDHI_INTERNAL_DMAC_ONE_RX_ONLY) },
>         { .soc_id = "r8a7796", .revision = "ES1.0",
>           .data = (void *)BIT(SDHI_INTERNAL_DMAC_ONE_RX_ONLY) },
> -       /* generic ones */
> -       { .soc_id = "r8a774a1" },
> -       { .soc_id = "r8a774b1" },
> -       { .soc_id = "r8a774c0" },
> -       { .soc_id = "r8a77470" },
> -       { .soc_id = "r8a7795" },
> -       { .soc_id = "r8a7796" },
> -       { .soc_id = "r8a77965" },
> -       { .soc_id = "r8a77970" },
> -       { .soc_id = "r8a77980" },
> -       { .soc_id = "r8a77990" },
> -       { .soc_id = "r8a77995" },
>         { /* sentinel */ }
>  };
>
>  static int renesas_sdhi_internal_dmac_probe(struct platform_device *pdev)
>  {
> -       const struct soc_device_attribute *soc = soc_device_match(soc_whitelist);
> +       const struct soc_device_attribute *soc = soc_device_match(soc_dma_quirks);
>         struct device *dev = &pdev->dev;
>
> -       if (!soc)
> -               return -ENODEV;
> -
> -       global_flags |= (unsigned long)soc->data;
> +       if (soc)
> +               global_flags |= (unsigned long)soc->data;
>
>         dev->dma_parms = devm_kzalloc(dev, sizeof(*dev->dma_parms), GFP_KERNEL);
>         if (!dev->dma_parms)
> --
> 2.20.1
>
