Return-Path: <SRS0=SyG0=7A=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6436DC433DF
	for <linux-mmc@archiver.kernel.org>; Mon, 18 May 2020 11:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41EFB206D4
	for <linux-mmc@archiver.kernel.org>; Mon, 18 May 2020 11:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bhIr6KoP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgERLYD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 18 May 2020 07:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbgERLYD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 18 May 2020 07:24:03 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9613C05BD09
        for <linux-mmc@vger.kernel.org>; Mon, 18 May 2020 04:24:01 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id 36so3306972uaf.9
        for <linux-mmc@vger.kernel.org>; Mon, 18 May 2020 04:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4NrexrNb88DzhWjg1accwpxlE36qK5WbdKw5yFdpiOY=;
        b=bhIr6KoP/7JDIFZg1/+ZJ7uB6Eo9CU1AHTOjy0RHtzeKoIXN4B8VDJFJfXceiP6WPI
         5KoDw0IKcM7T9T2Y1Tpv1T9izX6ADCWSKvxniWt3I47DFWSkEzd+E6rlQzNSPud8gv0A
         ptjAyBqcVVoGuFxzS3hJf6RB8vD0ZPhOmdWuy68O9hXNmoGOwxfHkQRKhN8RJBIg9HWd
         ifb7HH0WM+H1evmtDuSa7Tuuno0O5JpT3i5UOsmcFdmJumgoStOIi7p5avLb22xSDROE
         ILTz9YQKvwc/+ZdSj/PAojpBHM4Snyc6S9t6s1h+xrEzqK08DK1y+6gJ6JodWtXtCvju
         983g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4NrexrNb88DzhWjg1accwpxlE36qK5WbdKw5yFdpiOY=;
        b=nyKgCOVVa3hHB2hhhTe3tXFxNLRORU0Gx2fLTlTBHghw1yuBpfpk3eCSoYgmNCsnmh
         T3ji30fcQBa06dpsj8A2Vh3EqIaZNP7rOsW3QzHmTldIDeQOWqiF/QwHvI4VGizPX1Vv
         Ma57OzvLhxddHw+TT5TPXlFpMLjJY0vGeMpAfkqqlJXRlOT7b5eGX6l57iFe8hC4YZYL
         W2TZKlMaRPrSpQjIqJaSWd0NoF2ES+4NWqev+NRmZrqmAEHLAkxspSefOrXMPDKTqKY1
         tgnomry5/oOo3VndBa2YBxxsptlBsgL5AJMtAC01WH6NkbNKARoOQ5d5Nuv3USdqj2cG
         7A3w==
X-Gm-Message-State: AOAM5304aWI8P7BLjLoy57Vo6OHSRQ/xhb57iY9ao5vc9gPsSJG0A1oq
        AbWG238e7+IuiUt4ooP9LM+/7J1AEz+ml+dBERX/qQ==
X-Google-Smtp-Source: ABdhPJwQhXupbBSuJ+hHwMN84vnYBg4shImkGSdF0QuDl2EYLw84KTUNHMpMakjTHXlNhtlZdKXb8AP0fPGmjtmCvzg=
X-Received: by 2002:a9f:26e2:: with SMTP id 89mr10991422uay.104.1589801041024;
 Mon, 18 May 2020 04:24:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200517222907.1277787-1-martin.blumenstingl@googlemail.com> <20200517222907.1277787-2-martin.blumenstingl@googlemail.com>
In-Reply-To: <20200517222907.1277787-2-martin.blumenstingl@googlemail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 18 May 2020 13:23:24 +0200
Message-ID: <CAPDyKFpPXNB6mvovCH73BbtvKS=GPpUoBxn_0_EfbudebjZDWg@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: host: meson-mx-sdhc: don't use literal 0 to
 initialize structs
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 18 May 2020 at 00:29, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Kbuild test robot reports the following warning in lines 56 and 87 of
> drivers/mmc/host/meson-mx-sdhc-clkc.c:
>   Using plain integer as NULL pointer
>
> Drop the integer value from the struct initialization to fix that
> warning. This will still ensure that the compiler will zero out the
> struct so it's in a well-defined state.
>
> Fixes: 53ded1b676d199 ("mmc: host: meson-mx-sdhc: new driver for the Amlogic Meson SDHC host")
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/meson-mx-sdhc-clkc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/meson-mx-sdhc-clkc.c b/drivers/mmc/host/meson-mx-sdhc-clkc.c
> index ab0d6c68a078..e1f29b279123 100644
> --- a/drivers/mmc/host/meson-mx-sdhc-clkc.c
> +++ b/drivers/mmc/host/meson-mx-sdhc-clkc.c
> @@ -53,7 +53,7 @@ static int meson_mx_sdhc_clk_hw_register(struct device *dev,
>                                          const struct clk_ops *ops,
>                                          struct clk_hw *hw)
>  {
> -       struct clk_init_data init = { 0 };
> +       struct clk_init_data init = { };
>         char clk_name[32];
>
>         snprintf(clk_name, sizeof(clk_name), "%s#%s", dev_name(dev),
> @@ -84,7 +84,7 @@ static int meson_mx_sdhc_gate_clk_hw_register(struct device *dev,
>  int meson_mx_sdhc_register_clkc(struct device *dev, void __iomem *base,
>                                 struct clk_bulk_data *clk_bulk_data)
>  {
> -       struct clk_parent_data div_parent = { 0 };
> +       struct clk_parent_data div_parent = { };
>         struct meson_mx_sdhc_clkc *clkc_data;
>         int ret;
>
> --
> 2.26.2
>
