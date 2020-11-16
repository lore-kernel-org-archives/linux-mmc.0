Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0353CC83D49
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Nov 2020 12:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D86D20855
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Nov 2020 12:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jVRee76x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729442AbgKPLlq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Nov 2020 06:41:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728662AbgKPLlq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Nov 2020 06:41:46 -0500
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA201C0613CF
        for <linux-mmc@vger.kernel.org>; Mon, 16 Nov 2020 03:41:45 -0800 (PST)
Received: by mail-vk1-xa41.google.com with SMTP id m184so3634123vkb.9
        for <linux-mmc@vger.kernel.org>; Mon, 16 Nov 2020 03:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2lOdbwlpCkQ/U9b3AI8byk39FYQ+zSfYd4xMBl2NASE=;
        b=jVRee76xd/vj7nXCbI+BMQETz21ek9rOn5KYwlEgY8rR7BwA15GOWS/WjjTQdHOr/L
         jUFPM9gMGsb2ja5/vP0MD6Cu1HL8aBPFeE7/sEEB1TBN94P7zs6yMRe8yAz5WYI32eT/
         mxfxhgJHsKXS37zoW9tG03L2y8KDDQYANGkj4ipDQhWvU1IPXyPK2rwBrgc15JQFTYZm
         yEdQYbWcEdXbTVZ0upCd/wRj1ZmWWlPZcBLfx1Pt6kfV+iwitXgSftXc4VS8TwUV/yNf
         AEUNT12cbenYntn9bjKSjVCVwFHH7wS6NVXt0cx+djYtAjiu4PPC3oc1TAWMOzcVOGCe
         gjbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2lOdbwlpCkQ/U9b3AI8byk39FYQ+zSfYd4xMBl2NASE=;
        b=H+dnXeDBetANE+HVZ8jOP9D3cp6DcXPDUyiGSrAM35OPXl3qSY6PtNEU4Lr9P0IrdU
         Lj92m+RBhHNyBF/Z9uDCe0jILJIw+1c4s2sYCBl7WFASZheO6IyAyTjMfoF+i1IshOtt
         4drS9tuMQTu1yH2e2Mfppn1f7EReyoFnnX2yaOE3CKI+BG9kVpT3jAzTuzRKWbF7fE49
         NUNKp2HcFnCMlPKE/PmfXjq2Lh1qvVvyQc0dq/bnInbbRIto2KDnpmOkqdGRjV+Ly0iY
         uI/CamQ5w+2wKc6odO0nyrEi9/ZqMJ1saXaYq7Jt0g9/dTuou1gdZrt28raB0HPeuJ0L
         ttLQ==
X-Gm-Message-State: AOAM533NVHDHurDGEPlucayQPRc5ocb6g2CVbQHvJxFNdKv0OVSJgn3C
        Dx2HhZlfuQbvqXVKZNapbEHJHCob8RpYQFbgRGOH7Q==
X-Google-Smtp-Source: ABdhPJyF+H/3JuvG1rFtW0kdG+BQsvxK9WRDn/noF2Wj5TJ7U/U1fEbxZ4IGsVFZ+argIC1nTyuv7vbjE+bp1pyH1+Q=
X-Received: by 2002:a1f:41cc:: with SMTP id o195mr6992899vka.15.1605526904953;
 Mon, 16 Nov 2020 03:41:44 -0800 (PST)
MIME-Version: 1.0
References: <20201106120933.7190-1-muhammad.husaini.zulkifli@intel.com> <20201106120933.7190-2-muhammad.husaini.zulkifli@intel.com>
In-Reply-To: <20201106120933.7190-2-muhammad.husaini.zulkifli@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 16 Nov 2020 12:41:08 +0100
Message-ID: <CAPDyKFrq0Wsc7bNS0QPMitNqpkzK87VAuTnjDqrqTrVDGCwxgg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] mmc: sdhci-of-arasan: Specify .clk_ops for Keem
 Bay SOC
To:     "Zulkifli, Muhammad Husaini" <muhammad.husaini.zulkifli@intel.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        "David E. Box" <david.e.box@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 6 Nov 2020 at 05:10, <muhammad.husaini.zulkifli@intel.com> wrote:
>
> From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
>
> Commit 16ada730a759 ("mmc: sdhci-of-arasan: Modify clock operations handling")
> introduces platform specific SDHCI clock operation.
>
> This patch declares the clock operation for Keem Bay.
> Add clk_ops for SD, EMMC and SDIO operations.

The above commit message doesn't really tell why or what goes on here.
Can please try to clarify that.

>
> Fixes: 36c6aadaae86 ("mmc: sdhci-of-arasan: Add support for Intel Keem Bay")

Is $subject patch fixing a bug/regression?

Kind regards
Uffe

>
> Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 829ccef87426..012d52e1abee 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -1199,16 +1199,19 @@ static struct sdhci_arasan_of_data sdhci_arasan_versal_data = {
>  static struct sdhci_arasan_of_data intel_keembay_emmc_data = {
>         .soc_ctl_map = &intel_keembay_soc_ctl_map,
>         .pdata = &sdhci_keembay_emmc_pdata,
> +       .clk_ops = &arasan_clk_ops,
>  };
>
>  static struct sdhci_arasan_of_data intel_keembay_sd_data = {
>         .soc_ctl_map = &intel_keembay_soc_ctl_map,
>         .pdata = &sdhci_keembay_sd_pdata,
> +       .clk_ops = &arasan_clk_ops,
>  };
>
>  static struct sdhci_arasan_of_data intel_keembay_sdio_data = {
>         .soc_ctl_map = &intel_keembay_soc_ctl_map,
>         .pdata = &sdhci_keembay_sdio_pdata,
> +       .clk_ops = &arasan_clk_ops,
>  };
>
>  static const struct of_device_id sdhci_arasan_of_match[] = {
> --
> 2.17.1
>
