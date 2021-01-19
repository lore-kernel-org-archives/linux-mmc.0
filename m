Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1E3C43217
	for <linux-mmc@archiver.kernel.org>; Tue, 19 Jan 2021 18:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57A26230FE
	for <linux-mmc@archiver.kernel.org>; Tue, 19 Jan 2021 18:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389648AbhASOtZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 19 Jan 2021 09:49:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387946AbhASNoN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Jan 2021 08:44:13 -0500
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23623C061757
        for <linux-mmc@vger.kernel.org>; Tue, 19 Jan 2021 05:43:29 -0800 (PST)
Received: by mail-ua1-x936.google.com with SMTP id a16so352633uad.9
        for <linux-mmc@vger.kernel.org>; Tue, 19 Jan 2021 05:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iN6LdNddtCPvRlGXitGPbToLS1CEl0fCsvQKN0BpriY=;
        b=m785Q8QxruIQgi3wqou/VxiBLJ/MVprrsoEl26S11OjFrdkVNeBiBSQzbWq5wc3Bnk
         WebjUhGaBZup0HmRhG1iHJWgPSiFnLZyBzGWNI20XYsn0k5hKcZiKhImt7Ma53urQp36
         Ks0JtGiJq+9ofbOLlSzc0kEaziHNjCAEr7Sz5mI5NogFbrmG7T7P87zGcBBsxFuKgqRL
         UkP3EvyYE72XCvWqmms377Treyd3hnNcDperSD7wzNJ6RWRciyYfh7wdpACYJEJSpEs9
         Xt1aHHTKD5GTRaT1mnwWEyAqr2PoRhM3/wJJgFlU3SZldkU0vszqgdYfJurQCU0hPcoJ
         2VRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iN6LdNddtCPvRlGXitGPbToLS1CEl0fCsvQKN0BpriY=;
        b=dGqg2nL+SkT3LahdiBszWKPgd8rGRW3QVyMJkusuZ8zZW2rFO8DoGFE3rgtmbY5VuN
         gn32Q0qJQjwmNEYXNKySQjJ/YOHAfC0ho9JdJGu7Netct5HkF6SL/4xpRlT8Pza9AypX
         i2XusANi8n0lgDIMqNSXRch8SiM39619LScZIG/lfhmw/QN/gpr863u/v0aRdSkgZ4BN
         XBWMOMA68E/BfBfM8C2gbxl+zYPcFKKl1XaWx2mK8RWA+nrscz4oUCGM2+cpqwVqfDmc
         Ab2HgVA/+h53VHcWDia7ZGVu14u2hU2UGTVyv00iNtL7pdAvZNCfX0tCScdQl2pnq7Kw
         FNfA==
X-Gm-Message-State: AOAM530PA9o5KJd3G3gv7JpagXlWMm3VNBDZjL7/U+AxBl9bmUIAebA4
        3CmQgmbKtYzE6/0YVb/jmGYn8plH4+Kp3RxmQMG8JA==
X-Google-Smtp-Source: ABdhPJy8YfW3TY12bJa5OWZwiU4SCjJkJNpC1EcV4z3zof+egZ29HsMFioSINO1T9lcPwSbYO0VGk61l1zVyHuRcmlQ=
X-Received: by 2002:a9f:204e:: with SMTP id 72mr2102277uam.19.1611063808290;
 Tue, 19 Jan 2021 05:43:28 -0800 (PST)
MIME-Version: 1.0
References: <20210114152700.21916-1-muhammad.husaini.zulkifli@intel.com>
In-Reply-To: <20210114152700.21916-1-muhammad.husaini.zulkifli@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 19 Jan 2021 14:42:52 +0100
Message-ID: <CAPDyKFrzg-mXTEQUd2oZiiSvbn29O+AGDC0VVDjbSQo6YOji8A@mail.gmail.com>
Subject: Re: [PATCH v1 0/9] mmc: sdhci-of-arasan: Add UHS-1 support for Keem
 Bay SOC
To:     Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        Rashmi.A@intel.com, mahesh.r.vaidya@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 14 Jan 2021 at 16:28, Muhammad Husaini Zulkifli
<muhammad.husaini.zulkifli@intel.com> wrote:
>
> Hi,
>
> This patch series adds Ultra High Speed(UHS-1) Bus Speed Mode Support for Keem Bay SoC SD Card.
> Summary of each patches as per below:
>
> Patch 1: Use of_device_get_match_data() helper to get the match-data.
> Patch 2: Convert to use np pointer instead of using pdev->dev.of_node.
> Patch 3: Add struct device *dev in probe func(), so that dev pointer can be widely use in probe to make code more readable.
> Patch 4: Change from dev_err to dev_err_probe() to avoid spamming logs when probe is deferred.
> Patch 5: Export function to be use by device driver to configure i/o voltage rail output which communicate with Trusted Firmware.
> Patch 6: Update phy and regulator supply for Keem Bay SoC.
> Patch 7: Add DT Binding for Keem Bay SoC SD Regulator.
> Patch 8: Add SD Regulator driver to support Keem Bay SoC. This is to model using standard regulator abstraction during voltage operation
> as for Keem Bay SoC, i/o voltage rail need to be configure by setting specific bit in the AON_CFG1 Register.
> AON_CFG1 Register is a secure register. Direct access to AON_CFG1 register will cause firewall violation in secure system.
> Patch 9: Add Ultra High Speed (UHS-1) Support for Keem Bay SOC. For Keem Bay hardware, two regulators are been used to change the I/O bus line voltage which are "vqmmc-supply" and "sdvrail-supply".
>
> All of these patches was tested with Keem Bay evaluation module board.
>
> Kindly help to review this patch set.
>
> Muhammad Husaini Zulkifli (9):
>   mmc: sdhci-of-arasan: use of_device_get_match_data()
>   mmc: sdhci-of-arasan: Convert to use np instead of pdev->dev.of_node
>   mmc: sdhci-of-arasan: Add structure device pointer in probe function
>   mmc: sdhci-of-arasan: Use dev_err_probe() to avoid spamming logs
>   firmware: keembay: Add support for Trusted Firmware Service call
>   dt-bindings: mmc: Update phy and regulator supply for Keem Bay SOC
>   dt-bindings: regulator: keembay: Add DT binding documentation
>   regulator: keembay: Add regulator for Keem Bay SoC
>   mmc: sdhci-of-arasan: Add UHS-1 support for Keem Bay SOC
>
>  .../devicetree/bindings/mmc/arasan,sdhci.yaml |   7 +-
>  .../bindings/regulator/keembay-regulator.yaml |  36 ++
>  drivers/mmc/host/sdhci-of-arasan.c            | 313 ++++++++++++++++--
>  drivers/regulator/Kconfig                     |  10 +
>  drivers/regulator/Makefile                    |   1 +
>  drivers/regulator/keembay-sd-regulator.c      | 112 +++++++
>  include/linux/firmware/intel/keembay.h        |  82 +++++
>  7 files changed, 532 insertions(+), 29 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/regulator/keembay-regulator.yaml
>  create mode 100644 drivers/regulator/keembay-sd-regulator.c
>  create mode 100644 include/linux/firmware/intel/keembay.h
>
> --
> 2.17.1
>

Applied patch 1 to patch 4. I assume you will be respinning the rest?

Thanks and kind regards
Uffe
