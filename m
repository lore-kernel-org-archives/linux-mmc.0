Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F8AC61DA4
	for <linux-mmc@archiver.kernel.org>; Thu,  9 Mar 2023 15:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjCIPFH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 9 Mar 2023 10:05:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231923AbjCIPEg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Mar 2023 10:04:36 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C1C6A9E4
        for <linux-mmc@vger.kernel.org>; Thu,  9 Mar 2023 07:02:40 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 132so1200176pgh.13
        for <linux-mmc@vger.kernel.org>; Thu, 09 Mar 2023 07:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678374160;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rzsJZdpZ7LPDoQfu9o9lW5gjnwOdZ6t+X4Prhh6Xwh8=;
        b=czM7cHYNWrkijeBV8VGOp7J3iol/R2pmJj5w+DjZF+eADrJovmHWPb2EhP1KZG8e/G
         ZJmEC/RkA3Q1UGvqmrmOZDwWpq9N/+uim1BfEpp3eOb6G30OkPC/EgS7nrZWaSNLHEiZ
         4rLBJdU/RpNn5kaddwjfzdFZRkF5z3QheH2rwo39cX4zccSfHZFRNoHwLFnuu/JXxYqg
         89oTgAeGvxcadtlxYCMw8UrbWpqCvXyEK7FeN2OOezV/8mPw9siUXUyevPdEKS/MicLk
         lWj/SClhiDYTgbQGGF3wcnXcrdTSAIwEhpdvjmF62Zgv4USje1OpSK5JEoA8mw9zFAIT
         B6Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678374160;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rzsJZdpZ7LPDoQfu9o9lW5gjnwOdZ6t+X4Prhh6Xwh8=;
        b=nZPIltJaxBBLbv92Ly5KlT2oolBO6IfudImYHEuxXjzZDe2cG0nsXC5h3GceyP3DRc
         COv2PAUIHGw2cARFb5QdRgFRxfidxc53W3it3f7g5GTaLZn2xsb0/jQ3zWol6XS/aX3t
         UVTULgZiIelNRQT1Foqb/BC8LQp5BniNL4uUWN0WGFeH1JYIG8GcKKYb32oiTMqH7t+L
         ooGl8Vb6f9ostk8TtJSG1vuYgxPid55yttNDRJ06I2u+37Qatmd0Eek0c9kJiOCv/5ln
         DXC5bkCjxo8SgGVgeK713iuocciFdjgZkJlz2nlbHd9YvlGYcfBGCtvlPdIxXXz6s5A8
         TMfw==
X-Gm-Message-State: AO0yUKW8eeDi7EFbL2wj4QnkFsdZ76kOVMrxwdPYBSvI0DDPHF0p0Ut7
        fPYuMUYe1JkBFwLawsmVdsxLPkgv7TiZHKKjx0JePg==
X-Google-Smtp-Source: AK7set/pg4ofM8YOtb7sDX31eSeRHJ4g+nh8yNyQMFWWgiMSTk2nHzbzts0k3Xa71amPJpu/lX7Qb7fMUm1R0Du6DvM=
X-Received: by 2002:a63:f91d:0:b0:502:fd12:83ce with SMTP id
 h29-20020a63f91d000000b00502fd1283cemr7999126pgi.5.1678374160137; Thu, 09 Mar
 2023 07:02:40 -0800 (PST)
MIME-Version: 1.0
References: <20230223141402.23979-1-swati.agarwal@amd.com>
In-Reply-To: <20230223141402.23979-1-swati.agarwal@amd.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 9 Mar 2023 16:02:03 +0100
Message-ID: <CAPDyKFpSOs-xuQOssxPYrQPp=_qsAMem+LGYyqwSAkKqKXb7MQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-arasan: Add support to request the "gate" clock
To:     Swati Agarwal <swati.agarwal@amd.com>
Cc:     adrian.hunter@intel.com, michal.simek@xilinx.com,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, git@amd.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 23 Feb 2023 at 15:14, Swati Agarwal <swati.agarwal@amd.com> wrote:
>
> Add support to read the optional "gate" clock property and request the
> clock which will be used to ungate the DLL clock.
>
> For Xilinx platforms which has DLL module, dll clock must be
> ungated/enabled when SD controller operates at higher frequencies like 50
> MHz, 100 MHz and 200 MHz. This will be done by explicitly requesting gate
> clock from the driver.
>
> Signed-off-by: Swati Agarwal <swati.agarwal@amd.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 4eebbf801b41..1fd7528c14fc 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -1870,6 +1870,7 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>         int ret;
>         struct device_node *node;
>         struct clk *clk_xin;
> +       struct clk *clk_dll;
>         struct sdhci_host *host;
>         struct sdhci_pltfm_host *pltfm_host;
>         struct device *dev = &pdev->dev;
> @@ -1943,6 +1944,12 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>                 goto clk_dis_ahb;
>         }
>
> +       clk_dll = devm_clk_get_optional_enabled(dev, "gate");
> +       if (IS_ERR(clk_dll)) {
> +               ret = dev_err_probe(dev, PTR_ERR(clk_dll), "failed to get dll clk\n");
> +               goto clk_disable_all;
> +       }
> +
>         if (of_property_read_bool(np, "xlnx,fails-without-test-cd"))
>                 sdhci_arasan->quirks |= SDHCI_ARASAN_QUIRK_FORCE_CDTEST;
>
> --
> 2.17.1
>
