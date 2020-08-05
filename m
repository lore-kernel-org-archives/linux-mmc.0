Return-Path: <SRS0=eJC8=BP=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 924CAC433DF
	for <linux-mmc@archiver.kernel.org>; Wed,  5 Aug 2020 06:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F6CA2076E
	for <linux-mmc@archiver.kernel.org>; Wed,  5 Aug 2020 06:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eQkJBpVb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgHEGgA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 5 Aug 2020 02:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbgHEGf7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Aug 2020 02:35:59 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B22C061756
        for <linux-mmc@vger.kernel.org>; Tue,  4 Aug 2020 23:35:59 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id o25so13555882uar.1
        for <linux-mmc@vger.kernel.org>; Tue, 04 Aug 2020 23:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o6gPXt+uk5/TlbUXeERLV3ad4JBuwS7RGuma4v5K6/I=;
        b=eQkJBpVbAzUdfJSt0GqbDtXdaXhMFGVnNOZSAO4WKgc0Dd1HBvdfyDS3Lvmq7vn01S
         vedcWrpS/jJ0nbG/5Pgs4aJbGJAWIPX6BM3R939hEZG5puY2GLd/D0fVan0Hqe9eqBvo
         gCXKTTYEV2aLSdffg6HGWLPhKSVNxDMiVYIdgDSuY7hYf6deZKIzg3dJZ92KYHoSYGfG
         WspXAu8tNdYwigAjYLg2DF2PGZxFuBF50vDwrCnjBbBksR8YYLvCfGWJ+7XE8A5rzkls
         JghP3nH+Lo35yduxOFVtFbXhOid1yeh/icVZbpQt+XpEgi572x5HwL/fzaKN1LwziBc0
         JMPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o6gPXt+uk5/TlbUXeERLV3ad4JBuwS7RGuma4v5K6/I=;
        b=DokZweSEzckxC8P/zdNGEqF79Lo2/2/OvmNQF6wlFr1qYm0DkZ7naqgHJWxTlDm9cr
         5Wa32OiRbR31v0lR7LbdJ0F1v5ykIAw2mRkGoOD5D/0CFFfhWEMSF57cdplLGdTSqIqu
         0/OzKfcjwKbXP6dukwXzTIxPUrvRy6HqdJiSq2U2NOLI9G5H6QpfkvsxWBo3453aHvND
         bVCHLr1q+ADCQO4rLCBT5q+wyIwOtyDcKoH839Ql89PNji6umi8abZV3ptR6BpVN9ng0
         aHTyD77i2iA+0kFuvJQD/aRZvX3hW7Ari2QI7LgtVIGoREiwenE+wlnbNn0idw66D+tH
         TRPw==
X-Gm-Message-State: AOAM530UToPPdFCw2POsjyZTURpJicz0yonhJYcmPdmZGrWMdxnICgFw
        //y3t3tQ9TcJWssY9VCb3QVW6bmZltdAqjrfyO+uZ6JCeqBMIw==
X-Google-Smtp-Source: ABdhPJzjSkiQg75G4g6cwvJbyXmGdAkUrdZMJZd5+6jMNawHKdK/iClMiz7zEIunIwcyTI8SazyfjPTJAlfEct5i5PU=
X-Received: by 2002:ab0:6049:: with SMTP id o9mr994620ual.19.1596609358312;
 Tue, 04 Aug 2020 23:35:58 -0700 (PDT)
MIME-Version: 1.0
References: <1594753953-62980-1-git-send-email-manish.narani@xilinx.com>
In-Reply-To: <1594753953-62980-1-git-send-email-manish.narani@xilinx.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 5 Aug 2020 08:35:21 +0200
Message-ID: <CAPDyKFpAn0eeN-KmtxGL9W+15ZWb6wMdGFu75ndCWy-ymV0=AA@mail.gmail.com>
Subject: Re: [PATCH] mmc: host: sdhci-of-arasan: fix timings allocation code
To:     Manish Narani <manish.narani@xilinx.com>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        git@xilinx.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 14 Jul 2020 at 21:12, Manish Narani <manish.narani@xilinx.com> wrote:
>
> The initial code that was adding delays was doing a cast over undefined
> memory. This meant that the delays would be all gibberish.
>
> This change, allocates all delays on the stack, and assigns them from the
> ZynqMP & Versal macros/phase-list. And then finally copies them over the
> common iclk_phase & oclk_phase variables.
>
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>

Applied for next (a while ago), thanks!
Kind regards
Uffe



> ---
>  drivers/mmc/host/sdhci-of-arasan.c |   25 ++++++++++++++-----------
>  1 files changed, 14 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index db9b544..90e42d1 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -1025,7 +1025,6 @@ static void arasan_dt_read_clk_phase(struct device *dev,
>  static void arasan_dt_parse_clk_phases(struct device *dev,
>                                        struct sdhci_arasan_clk_data *clk_data)
>  {
> -       int *iclk_phase, *oclk_phase;
>         u32 mio_bank = 0;
>         int i;
>
> @@ -1037,28 +1036,32 @@ static void arasan_dt_parse_clk_phases(struct device *dev,
>         clk_data->set_clk_delays = sdhci_arasan_set_clk_delays;
>
>         if (of_device_is_compatible(dev->of_node, "xlnx,zynqmp-8.9a")) {
> -               iclk_phase = (int [MMC_TIMING_MMC_HS400 + 1]) ZYNQMP_ICLK_PHASE;
> -               oclk_phase = (int [MMC_TIMING_MMC_HS400 + 1]) ZYNQMP_OCLK_PHASE;
> +               u32 zynqmp_iclk_phase[MMC_TIMING_MMC_HS400 + 1] =
> +                       ZYNQMP_ICLK_PHASE;
> +               u32 zynqmp_oclk_phase[MMC_TIMING_MMC_HS400 + 1] =
> +                       ZYNQMP_OCLK_PHASE;
>
>                 of_property_read_u32(dev->of_node, "xlnx,mio-bank", &mio_bank);
>                 if (mio_bank == 2) {
> -                       oclk_phase[MMC_TIMING_UHS_SDR104] = 90;
> -                       oclk_phase[MMC_TIMING_MMC_HS200] = 90;
> +                       zynqmp_oclk_phase[MMC_TIMING_UHS_SDR104] = 90;
> +                       zynqmp_oclk_phase[MMC_TIMING_MMC_HS200] = 90;
>                 }
>
>                 for (i = 0; i <= MMC_TIMING_MMC_HS400; i++) {
> -                       clk_data->clk_phase_in[i] = iclk_phase[i];
> -                       clk_data->clk_phase_out[i] = oclk_phase[i];
> +                       clk_data->clk_phase_in[i] = zynqmp_iclk_phase[i];
> +                       clk_data->clk_phase_out[i] = zynqmp_oclk_phase[i];
>                 }
>         }
>
>         if (of_device_is_compatible(dev->of_node, "xlnx,versal-8.9a")) {
> -               iclk_phase = (int [MMC_TIMING_MMC_HS400 + 1]) VERSAL_ICLK_PHASE;
> -               oclk_phase = (int [MMC_TIMING_MMC_HS400 + 1]) VERSAL_OCLK_PHASE;
> +               u32 versal_iclk_phase[MMC_TIMING_MMC_HS400 + 1] =
> +                       VERSAL_ICLK_PHASE;
> +               u32 versal_oclk_phase[MMC_TIMING_MMC_HS400 + 1] =
> +                       VERSAL_OCLK_PHASE;
>
>                 for (i = 0; i <= MMC_TIMING_MMC_HS400; i++) {
> -                       clk_data->clk_phase_in[i] = iclk_phase[i];
> -                       clk_data->clk_phase_out[i] = oclk_phase[i];
> +                       clk_data->clk_phase_in[i] = versal_iclk_phase[i];
> +                       clk_data->clk_phase_out[i] = versal_oclk_phase[i];
>                 }
>         }
>
> --
> 1.7.1
>
