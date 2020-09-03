Return-Path: <SRS0=lwnd=CM=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185BBC43461
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Sep 2020 08:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCC6B2176B
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Sep 2020 08:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VSkCGrMZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbgICILh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 3 Sep 2020 04:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728255AbgICIKx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Sep 2020 04:10:53 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD22C061249
        for <linux-mmc@vger.kernel.org>; Thu,  3 Sep 2020 01:10:52 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id q124so581358vkb.8
        for <linux-mmc@vger.kernel.org>; Thu, 03 Sep 2020 01:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zIKaB5S0qzt1j0qrP3RfGo4Ng5m6tD5YBvW+p6cBWpo=;
        b=VSkCGrMZk9uqiovnuB3gCxlXpkc7tTawunYl4GuvwlwGaTWeRnkpX7DC8IgCu+aIK7
         quL7hVQZ0FJ8ccYYng/AUAgBPBeJulmZg6wiq2nLWIXRbeTiOMfIkPtNOiu+UPUYehnl
         wM4L/kWPhjBjy/2lgY5aYsl/LVJWPLHBzOYqb3V6l2AcG27k5Ho9tDPCZsCXLCR3NyhV
         YV1llI8naBDHt585QE2OFKGdyi6zmOwfUcyYKTKRZyywRMHXca2hUUZ8RqP+XicOaD83
         Gj3GPCHq0iXlVm4H9pappL+i2GtA3oo11nLBC7Rq+Fa2OJQ/TUIzy0FYmmmKkyStXTil
         Mnlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zIKaB5S0qzt1j0qrP3RfGo4Ng5m6tD5YBvW+p6cBWpo=;
        b=fEK5DWWZnY1PAR/Qxx7LSVEZFcOtVOYaevYlTQxNOXJ8uSlwUluQ7uGT9LgPZeJ2kg
         G/9VkOPdwJbmhZcEmg+0PnQbBOej1uxfaGZmQXmQZfwnh+YqSwycTTFQH6QAyKQX5M2J
         gL3r0MsRD1MR5Jsp0MEuaS7f+2T11i2EZwepWf8MEBK5aHlaRrRy4DzqQodmC9N7Ujmt
         Eh4LjlsSWdl/EKy+3kNcMWSLnA6dnbBgYXcJnhaiQGv73GsNC5k0wQPJpVCO8tKL0elo
         RKXS8eYJ6z8W7lK5ALhTOGtl7fLvVMQAu+KAwMaszrme4kP2H+uw9dydC6TBNQ2J4C6B
         wEWg==
X-Gm-Message-State: AOAM533dR4jha+dKovMCegpGLVSESNTnnFxLY7FcYbMEJwQzaV7j2l8J
        3Az/xzF/tPIEBDLOgODDFIAYlw1zWQrKEbf0em6T1Q==
X-Google-Smtp-Source: ABdhPJxfAPAkxGsAxNbyrIBprTd99bTvdjLzQF9t7lNgAVPgtFBvQhAsLzJxujDDxAJ7NOa99qGNjuKVubA2UYhu8rE=
X-Received: by 2002:a05:6122:10ca:: with SMTP id l10mr868318vko.15.1599120651296;
 Thu, 03 Sep 2020 01:10:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200903012029.25673-1-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20200903012029.25673-1-chris.packham@alliedtelesis.co.nz>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 3 Sep 2020 10:10:13 +0200
Message-ID: <CAPDyKFpMOKs9t4O73XWZiZhb+6wNh=BL5t-jhej7nxCocbq7NA@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-of-esdhc: Don't walk device-tree on every interrupt
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "yinbo.zhu" <yinbo.zhu@nxp.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 3 Sep 2020 at 03:20, Chris Packham
<chris.packham@alliedtelesis.co.nz> wrote:
>
> Commit b214fe592ab7 ("mmc: sdhci-of-esdhc: add erratum eSDHC7 support")
> added code to check for a specific compatible string in the device-tree
> on every esdhc interrupat. Instead of doing this record the quirk in
> struct sdhci_esdhc and lookup the struct in esdhc_irq.
>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Applied for fixes, and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
> I found this in passing while trying to track down another issue using ftrace.
> I found it odd that I was seeing a lot of calls to __of_device_is_compatible()
> coming from esdhc_irq() (the fact that this interrupt is going off on my board
> is also odd, but that's a different story).
>
> Changes in v2:
> - add quirk_trans_complete_erratum to struct sdhci_esdhc so all the dt handling
>   is taken care of in esdhc_init.
>
>  drivers/mmc/host/sdhci-of-esdhc.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index 7c73d243dc6c..45881b309956 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -81,6 +81,7 @@ struct sdhci_esdhc {
>         bool quirk_tuning_erratum_type2;
>         bool quirk_ignore_data_inhibit;
>         bool quirk_delay_before_data_reset;
> +       bool quirk_trans_complete_erratum;
>         bool in_sw_tuning;
>         unsigned int peripheral_clock;
>         const struct esdhc_clk_fixup *clk_fixup;
> @@ -1177,10 +1178,11 @@ static void esdhc_set_uhs_signaling(struct sdhci_host *host,
>
>  static u32 esdhc_irq(struct sdhci_host *host, u32 intmask)
>  {
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct sdhci_esdhc *esdhc = sdhci_pltfm_priv(pltfm_host);
>         u32 command;
>
> -       if (of_find_compatible_node(NULL, NULL,
> -                               "fsl,p2020-esdhc")) {
> +       if (esdhc->quirk_trans_complete_erratum) {
>                 command = SDHCI_GET_CMD(sdhci_readw(host,
>                                         SDHCI_COMMAND));
>                 if (command == MMC_WRITE_MULTIPLE_BLOCK &&
> @@ -1334,8 +1336,10 @@ static void esdhc_init(struct platform_device *pdev, struct sdhci_host *host)
>                 esdhc->clk_fixup = match->data;
>         np = pdev->dev.of_node;
>
> -       if (of_device_is_compatible(np, "fsl,p2020-esdhc"))
> +       if (of_device_is_compatible(np, "fsl,p2020-esdhc")) {
>                 esdhc->quirk_delay_before_data_reset = true;
> +               esdhc->quirk_trans_complete_erratum = true;
> +       }
>
>         clk = of_clk_get(np, 0);
>         if (!IS_ERR(clk)) {
> --
> 2.28.0
>
