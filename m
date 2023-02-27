Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD45CC64ED6
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Feb 2023 14:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjB0O5T (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 27 Feb 2023 09:57:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjB0O5T (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Feb 2023 09:57:19 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DA5526B
        for <linux-mmc@vger.kernel.org>; Mon, 27 Feb 2023 06:57:18 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id x34so6452343pjj.0
        for <linux-mmc@vger.kernel.org>; Mon, 27 Feb 2023 06:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fMWRWsx+NX+ZsoBdeAksgis3WCgc+mV0ObFhcVdcQt8=;
        b=kf+IMnpHKi2YohvVX3jI9exE0YcLnVPKVbiWhYA0UsaOt3gj0DslKbWmTeAJF+deBn
         meF+9izukLixfjd9BAswfCNqywEex2kf9QA/qhU+V9kPWfK1QM/Z5nIKkPlfSJdGt/Zs
         62ZV4eVachhOHvjCfu+QEoUGqRT7hhbk3Q8s0lPpd2/p+XoGLvfU3jwu2Ke5wb/n5SG4
         imntlpnh8xUOpTeKpRfzwHPcVUuumEOHH/Zs42uN3TrVRiA5xTA5Xccd1OUgpGEFzNQz
         d+fbSrwCyN7xcjU/bJE8aNXI83hY4vEOKzwwQc84FjnNMU0YJz+fTC+7CLznLtASAs3M
         aDsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fMWRWsx+NX+ZsoBdeAksgis3WCgc+mV0ObFhcVdcQt8=;
        b=2yyJAR3PEJRJ/nsSqqWS7NYdBCdmgcNyCgBfCpEbxx5GViTUqv1f1C8WryuXLmTxen
         lR2svJJedggBRy7kR01wX8KLtD/4caQ22yHrPrr1YBGsniiPeNI+x9/DyYAAmpkfNKCZ
         dhFoJqomvZCoTJVp9yiMtYGNEFsl9kDJGVvTB6Jt8hGPPuX6i+VvrJp2lzpAJpkogzfM
         6g3mbUA2jKf6DybralktODsY8HoHY3ZmkVkhzduw8h6TRFfwY5aFfDr8fM1AKdHqm0xa
         t3AnsMz6mw6lZHXpFGY64Xu7ovf2zCak6WxEchAnqMEKiDegJdyQoLETP9bJq1EpzOdN
         I9CA==
X-Gm-Message-State: AO0yUKVafk+6T7i3vP7lBz8NdgB7JvGokYMz6YTMh/dfbD/3DjVcoL8w
        OMlcB1TJle2yCvvMUUbddNV7M2LVyo1D9Uobx0fRRg==
X-Google-Smtp-Source: AK7set/cIdRiYJnqStSeE4iB/dHP9Z6P3eJh8irZ4IU0wViUJxA8Hd4ovr+/3O68jVXLLarklUF2irVjnaHo0Uj/7rE=
X-Received: by 2002:a17:903:48e:b0:19a:e617:34ff with SMTP id
 jj14-20020a170903048e00b0019ae61734ffmr6114366plb.11.1677509837733; Mon, 27
 Feb 2023 06:57:17 -0800 (PST)
MIME-Version: 1.0
References: <20230223141402.23979-1-swati.agarwal@amd.com>
In-Reply-To: <20230223141402.23979-1-swati.agarwal@amd.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 27 Feb 2023 15:56:41 +0100
Message-ID: <CAPDyKFoGmHpdt5UckyDTWQSK7OmZ789g9Owz7sPP4VJ6ezJbsQ@mail.gmail.com>
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

I guess we need to update the DT bindings too?

Kind regards
Uffe

>
> Signed-off-by: Swati Agarwal <swati.agarwal@amd.com>
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
