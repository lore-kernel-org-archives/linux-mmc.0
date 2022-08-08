Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 687C5C25B06
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Aug 2022 09:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbiHHJVE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 8 Aug 2022 05:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237716AbiHHJVD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Aug 2022 05:21:03 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B9B2718
        for <linux-mmc@vger.kernel.org>; Mon,  8 Aug 2022 02:21:01 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id f20so11737147lfc.10
        for <linux-mmc@vger.kernel.org>; Mon, 08 Aug 2022 02:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=KbDeu52KPmgVgu/lw0Cv2B69kyTMziYKw+U1DuKuJDs=;
        b=WqwLYVk0xB8vhuj0dKOaK4G9IX3Xl8gM7IWXOndZUKRgBU619KUKKu1j+YI4WEv5z+
         KSha6lUp3LOO7XAEdX7FIAG8HGUftfNq7Yh5ijqv7QmKgpSP+lfBTj8EC4Dx6bJtS1Cr
         CKqvY9FJOuTXBkrHnbwN6nj2wZ/3RoaAbjEn7JCrMy9wd3V/OKHGF6J+leCEqTNR/8Bg
         YGqwLYSVq9QgUr05wdH9BBMIOAKF7Ppc70v4W76iD/9lTSLRb5v1gVSD/gjVxJt/cFuf
         uQeVaLIb/L2HxojDLZNenprZAlMKg+RvTHkJpAb4NEPQlQeGMj6OLhihgOnkOh4lmEYu
         QMcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KbDeu52KPmgVgu/lw0Cv2B69kyTMziYKw+U1DuKuJDs=;
        b=1zbxiTx9r/1+mY0x5DsuaxpO7z2E9EZlKD286MX+kwvlJh8HlPaBqY9QP6ONL0mb+p
         eoaVRmmUvNQOe3TcEhaXdaZTxzsEZU9WcCp3/22W9EMlGseG8noTIf51SDgbNdzYRUf/
         QXFbOGdg6ypIBNu/G8E5VhYOXjRKfGV81wV3L84jh3+utbxcgnptHHW8qkWKPYdfHVPz
         i5b2wRAj9OLETKFTtpUP/T47/2mjmEGMao2vYm2vYv7r4NUFwq5R6t1jS/Q0f5WmxRrD
         BLuDztDdXAtZxK4pLXVp14MFZUGSw+Sz580z+MPZSh+C6fGKFEvGU2FuKdBM0NByjG7m
         CJFQ==
X-Gm-Message-State: ACgBeo2KQcf6NWWvpQCFIZpN9T1bqtsD/vYjBq8HEBrCtVLSf8WhLHFG
        OMgN37JuJTTrMOgRlwzFPq8VIg==
X-Google-Smtp-Source: AA6agR4fDMob8SbCSrNCdZBei8wfMJcs9MEi4sll4cCqXkEGDBLdssLAhUGAwm8qqaga/vUu4R3NFQ==
X-Received: by 2002:ac2:5324:0:b0:48b:9643:3838 with SMTP id f4-20020ac25324000000b0048b96433838mr3907673lfh.373.1659950458721;
        Mon, 08 Aug 2022 02:20:58 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id j9-20020a2e8249000000b0025e66a771efsm1294660ljh.136.2022.08.08.02.20.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 02:20:57 -0700 (PDT)
Message-ID: <9fd7fcfd-16fb-0f3a-238d-bd6f97026277@linaro.org>
Date:   Mon, 8 Aug 2022 12:20:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 2/3] mmc: sdhci-xenon: Try to fix 2G address limitation on
 AC5 SoC
Content-Language: en-US
To:     Vadym Kochan <vadym.kochan@plvision.eu>,
        Hu Ziji <huziji@marvell.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Elad Nachman <enachman@marvell.com>
References: <20220806085818.9873-1-vadym.kochan@plvision.eu>
 <20220806085818.9873-3-vadym.kochan@plvision.eu>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220806085818.9873-3-vadym.kochan@plvision.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 06/08/2022 11:58, Vadym Kochan wrote:
> There is a limitation on AC5 SoC that Xenon SDHC can address only
> first 2GB of memory. Turning to the SDMA mode to use the bounce_buffer
> causes ext_csd recognition to fail on init.
> 
> Using of swiotlb=force also does not help as it is allocated at the
> end of the memory.
> 
> So it was decided to use reserved-memory as a bounce buffer in case
> if the board has more than 2G of memory, or turn on the PIO
> mode if such memory region does not exist in the device-tree.
> 
> It was tested that this approach is 1.5 times faster than PIO.
> 
> Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
> ---
>  drivers/mmc/host/sdhci-xenon.c | 36 ++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
> index 08e838400b52..fbbd1a045002 100644
> --- a/drivers/mmc/host/sdhci-xenon.c
> +++ b/drivers/mmc/host/sdhci-xenon.c
> @@ -14,8 +14,10 @@
>  #include <linux/acpi.h>
>  #include <linux/delay.h>
>  #include <linux/ktime.h>
> +#include <linux/mm.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/of_reserved_mem.h>
>  #include <linux/pm.h>
>  #include <linux/pm_runtime.h>
>  
> @@ -486,6 +488,31 @@ static void xenon_sdhc_unprepare(struct sdhci_host *host)
>  	xenon_disable_sdhc(host, sdhc_id);
>  }
>  
> +static int xenon_ac5_probe(struct sdhci_host *host)
> +{
> +	struct device *dev = mmc_dev(host->mmc);
> +	struct sysinfo si;
> +	int err;
> +
> +	si_meminfo(&si);
> +
> +	if ((si.totalram * si.mem_unit) > SZ_2G) {
> +		struct device_node *dma_bounce_np;
> +
> +		dma_bounce_np = of_parse_phandle(dev->of_node,
> +						 "marvell,ac5-sdhci-dma-bounce-pool", 0);

No. Undocumented property. Please document all bindings, not only pieces.

> +		err = of_reserved_mem_device_init_by_idx(dev, dma_bounce_np, 0);
> +		of_node_put(dma_bounce_np);
> +		if (err) {
> +			dev_warn(dev, "Disabling DMA because of 2GB DMA access limit and missing DMA bounce region\n");
> +			host->quirks |= SDHCI_QUIRK_BROKEN_ADMA;
> +			host->quirks |= SDHCI_QUIRK_BROKEN_DMA;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static int xenon_probe(struct platform_device *pdev)
>  {
>  	struct sdhci_pltfm_host *pltfm_host;
> @@ -531,6 +558,12 @@ static int xenon_probe(struct platform_device *pdev)
>  			if (err)
>  				goto err_clk;
>  		}
> +
> +		if (of_device_is_compatible(dev->of_node, "marvell,ac5-sdhci")) {

Don't code compatible comparing in the driver. This is done by matching,
only once. You should use driver data/variant type.

> +			err = xenon_ac5_probe(host);
> +			if (err)
> +				goto err_clk_axi;
> +		}
>  	}
>  
>  	err = mmc_of_parse(host->mmc);
> @@ -570,6 +603,7 @@ static int xenon_probe(struct platform_device *pdev)
>  	pm_runtime_put_noidle(&pdev->dev);
>  	xenon_sdhc_unprepare(host);
>  err_clk_axi:
> +	of_reserved_mem_device_release(&pdev->dev);
>  	clk_disable_unprepare(priv->axi_clk);
>  err_clk:
>  	clk_disable_unprepare(pltfm_host->clk);
> @@ -591,6 +625,7 @@ static int xenon_remove(struct platform_device *pdev)
>  	sdhci_remove_host(host, 0);
>  
>  	xenon_sdhc_unprepare(host);
> +	of_reserved_mem_device_release(&pdev->dev);
>  	clk_disable_unprepare(priv->axi_clk);
>  	clk_disable_unprepare(pltfm_host->clk);
>  
> @@ -682,6 +717,7 @@ static const struct of_device_id sdhci_xenon_dt_ids[] = {
>  	{ .compatible = "marvell,armada-ap807-sdhci", .data = (void *)XENON_AP807},
>  	{ .compatible = "marvell,armada-cp110-sdhci", .data =  (void *)XENON_CP110},
>  	{ .compatible = "marvell,armada-3700-sdhci", .data =  (void *)XENON_A3700},
> +	{ .compatible = "marvell,ac5-sdhci", .data = (void *)XENON_AP806},

It's not the same.

>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, sdhci_xenon_dt_ids);


Best regards,
Krzysztof
