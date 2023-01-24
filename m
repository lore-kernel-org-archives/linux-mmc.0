Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBBFDC54EAA
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Jan 2023 12:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233586AbjAXM5k (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Jan 2023 07:57:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233448AbjAXM5j (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Jan 2023 07:57:39 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C859D1
        for <linux-mmc@vger.kernel.org>; Tue, 24 Jan 2023 04:57:38 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id f3so11234220pgc.2
        for <linux-mmc@vger.kernel.org>; Tue, 24 Jan 2023 04:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fr4KQQd0av587thkWcqiU+Za+8udTGNRZMwYOL7Y2/Q=;
        b=SdB2vEz9t1i6Jd6VoxHoWc+WYdwGEvjzyfDeyT8fMbppjAOyhPFCG8J3qwWA3RlStY
         WjzzMooHZODOnuLKc2dfjCU2xL4Kj1AySQWnAhDZuiTOBFubI6EXyOidLFBfbwK0cNYE
         yQDJJgfjOcdhawuJpORU0wDvu4uAumvx+pBTbmruoxSBKdfkxOQcRGL1zONdZKtTOUwW
         w9FtSQyjqiF8tzZcExB5QwdsjqAKVBbNZkSbQ4GJx6AGMTPzRis7dPGxAJCgExWVX7BS
         57mhsCKb1MsYrWcRHeL0CsraL6QC4H7LwKpInNnP25gWnGf3jFoCunJ1fOOnZwyzlVGU
         mnrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fr4KQQd0av587thkWcqiU+Za+8udTGNRZMwYOL7Y2/Q=;
        b=pmI5qiQd5EW0Aafob17vRaRkSxaNxDpLdUg8t7mKsMDfDFQSn3kC8NVspE/rWwP8JU
         l5tAiKbEboo3XpMk6XCbWxxO4UvDjCICoJ10HxzsPPWp1wGaIf6MUH5QSrTZt6UVYu7y
         630JKHBd/owe96IaNCB8RrhmSanyxTTJlK0lPnwpF3lMcD1iiXlDNzf6uBnXKdTDHrdI
         fE4vDzcoar4IUvTR1K/LriBh9lD4FgmHwd82XsoKPRp6Us6ZJLCvrWD40gYEERFdb6Nk
         TI8+W8MLP9j8jvh9p7/rZXXchlXeCch32DyeDWbZGUt2cZciCuN0qNMv6eAOJcgQU5qC
         e4Yg==
X-Gm-Message-State: AFqh2krXbHInRBAgxhY6zK5bsuo8eu1WC83RggduQMaSPMSI588geJd1
        e0ka6rijt2pO7/yY0c8RJ2/y+4djvL+lSQvRJonnFg==
X-Google-Smtp-Source: AMrXdXvkN9YYuOhNy7Pn87HY9J17Dsp0qFPMH4QoCWLcBCqcx2wECVReSw2pyQKhY7YZhBMpUParhwflBFFndj/9W3k=
X-Received: by 2002:a62:e80a:0:b0:58d:982a:f1ea with SMTP id
 c10-20020a62e80a000000b0058d982af1eamr2518752pfi.28.1674565057932; Tue, 24
 Jan 2023 04:57:37 -0800 (PST)
MIME-Version: 1.0
References: <20230116194401.20372-1-doug@schmorgal.com>
In-Reply-To: <20230116194401.20372-1-doug@schmorgal.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 24 Jan 2023 13:57:00 +0100
Message-ID: <CAPDyKFreULXcPPo54fLMZO8tQB=9mKrtrf3QWe=55SoXK3cg0A@mail.gmail.com>
Subject: Re: [PATCH v5 0/8] mmc: sdhci-pxav2: Add support for PXA168
To:     Doug Brown <doug@schmorgal.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 16 Jan 2023 at 20:44, Doug Brown <doug@schmorgal.com> wrote:
>
> This is a revival of an earlier patch series from 2013 to add support
> for the PXA168 SDHC controller, with an additional SDIO IRQ errata fix.
> It also cleans up the clock naming to be consistent with the existing DT
> schema shared with the pxav3 driver (in a backwards-compatible way).
>
> Here is the original patch series this is based on:
> https://lore.kernel.org/linux-mmc/1363544206-3671-1-git-send-email-tanmay.upadhyay@einfochips.com/
>
> Note that I left out the platform_specific_completion and clock gating
> changes from the original patches. They both seemed controversial, and
> don't seem necessary based on my testing. I've been running this code on
> a PXA168 for months without any issues.
>
> Changes in v5:
> - Fix missing assignment to ret in core clock patch found by test robot
>
> Changes in v4:
> - Rebase on latest mmc/next to fix conflict with DT binding
>
> Changes in v3:
> - Use OF match data rather than of_match_device and of_device_is_compatible
> - Simplify some instances of pdev->dev that could have just been "dev"
> - Handle EPROBE_DEFER when getting the clock
> - Use devm_clk_get_optional_enabled for the core clock (it's simpler)
> - Clear sdio_mrq before calling mmc_request_done
> - Small tweaks to devicetree binding requested by Krzysztof
>
> Changes in v2:
> - Fix mistakes in devicetree binding
> - Use cleaner code for pxav1_readw suggested by Adrian
> - Switch to request_done() and irq() for SDIO workaround CMD0 handling
>
> Doug Brown (8):
>   mmc: sdhci-pxav2: add initial support for PXA168 V1 controller
>   mmc: sdhci-pxav2: enable CONFIG_MMC_SDHCI_IO_ACCESSORS
>   mmc: sdhci-pxav2: add register workaround for PXA168 silicon bug
>   mmc: sdhci-pxav2: change clock name to match DT bindings
>   mmc: sdhci-pxav2: add optional core clock
>   mmc: sdhci-pxav2: add SDIO card IRQ workaround for PXA168 V1
>     controller
>   mmc: sdhci-pxav2: add optional pinctrl for SDIO IRQ workaround
>   dt-bindings: mmc: sdhci-pxa: add pxav1
>
>  .../devicetree/bindings/mmc/sdhci-pxa.yaml    |  19 ++-
>  drivers/mmc/host/Kconfig                      |   1 +
>  drivers/mmc/host/sdhci-pxav2.c                | 154 ++++++++++++++++--
>  3 files changed, 160 insertions(+), 14 deletions(-)
>

Applied for next, thanks!

Kind regards
Uffe
