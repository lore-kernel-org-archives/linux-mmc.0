Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B586C433FE
	for <linux-mmc@archiver.kernel.org>; Wed, 27 Apr 2022 21:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbiD0Vww (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 27 Apr 2022 17:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiD0Vwv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Apr 2022 17:52:51 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8180EA27DC;
        Wed, 27 Apr 2022 14:49:39 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id z5-20020a17090a468500b001d2bc2743c4so2793718pjf.0;
        Wed, 27 Apr 2022 14:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Bb29L+lWQnjBZGrDCL4rnMfyCvERMlWX1G9CDanEUqA=;
        b=i5fBa9T5GBWPMk2Y/a1x3hgBzs1eC5u3QxXb4/yVA8ndf+pBw6Re3MCdocm5UhqqED
         sSWv7Gjnm7KVLBhU9IVtG2EfvJiGHCKC7G9uTW5F6aqjNvMl/qQhIgalEnkI9YElwJLX
         UCTtPqRE/vC+GK2yc54AkUADlYsn8lZLv9ZLVOKyBaMIQNv3U0M+DzNoEu1Vd8L9HUJz
         m5KnrXGF7iEMy5rTw3la0fFq+r9q3z/4/RuBhB08jBAtowTjLpcE/ObRs8L5e9CqDUaq
         elCm3HIEAfnZL6W53FY//qXHZJgdl83gPK1ibLbwH0ilW0ySUrUO/GPzB9DjCAm2Psfu
         5Hmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Bb29L+lWQnjBZGrDCL4rnMfyCvERMlWX1G9CDanEUqA=;
        b=mgHZazG4hs7xBqwZYP6NuqXacM8QL2nUXzQ3C74HFpMmBYEpeVm+fa3Hzpthc+rYin
         752ypDgFCUJpFwcESKeoc0WbDPGdslgW6EqiLuG+ego0/0WUQuOBNJRCfrw1vvBC5mnY
         O2AKAaZ/Fzrrhva+AtdaSaG0xYiDhd8EwhJY/leBOD3lPU48QpGhWMlBJhgFWGn94WDd
         ouIjP6PNL1ST6JysLwHtoCRcNr8+iyNGVVSFwv80zAiS5SFumZNM4cZo08zWdnhF0QZp
         mD2RjrPgbnrZd3NB6XGbwzggvQJqUVUlHFpn4sl8w5vix4eOJrgFvWfZbTm6N3GUwWgI
         25FA==
X-Gm-Message-State: AOAM531HwdUNNT7or4TGFr4ZnoToQoY/uP4RRK4QciZCg3gTdTM4RDox
        A0b/Hqv9/xwpPSwX+6/1Xh4=
X-Google-Smtp-Source: ABdhPJzsHMf7KlYf06Jxw73myWqsPrl/MI9vOoMGa8sHuK7wENnhdAxv7+9iN3iiicCHBBv3+6xajA==
X-Received: by 2002:a17:902:d5c3:b0:154:c472:de80 with SMTP id g3-20020a170902d5c300b00154c472de80mr30302580plh.87.1651096179009;
        Wed, 27 Apr 2022 14:49:39 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id s5-20020a17090a6e4500b001d899a28d1esm3874136pjm.4.2022.04.27.14.49.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 14:49:38 -0700 (PDT)
Message-ID: <a4638e5c-bc2a-8250-c6ca-a9727ee43daf@gmail.com>
Date:   Wed, 27 Apr 2022 14:49:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 4/4] mmc: sdhci-brcmstb: Add ability to increase max
 clock rate for 72116b0
Content-Language: en-US
To:     Kamal Dasu <kdasu.kdev@gmail.com>, ulf.hansson@linaro.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, alcooperx@gmail.com
Cc:     bcm-kernel-feedback-list@broadcom.com, adrian.hunter@intel.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220427180853.35970-1-kdasu.kdev@gmail.com>
 <20220427180853.35970-5-kdasu.kdev@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220427180853.35970-5-kdasu.kdev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 4/27/22 11:08, Kamal Dasu wrote:
> From: Al Cooper <alcooperx@gmail.com>
> 
> The 72116B0 has improved SDIO controllers that allow the max clock
> rate to be increased from a max of 100MHz to a max of 150MHz. The
> driver will need to get the clock and increase it's default rate
> and override the caps register, that still indicates a max of 100MHz.
> The new clock will be named "sdio_freq" in the DT node's "clock-names"
> list. The driver will use a DT property, "clock-frequency", to
> enable this functionality and will get the actual rate in MHz
> from the property to allow various speeds to be requested.
> 
> Signed-off-by: Al Cooper <alcooperx@gmail.com>
> Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
> ---
>   drivers/mmc/host/sdhci-brcmstb.c | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
> index 683d0c685748..51a23e9f4535 100644
> --- a/drivers/mmc/host/sdhci-brcmstb.c
> +++ b/drivers/mmc/host/sdhci-brcmstb.c
> @@ -250,6 +250,7 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
>   	struct sdhci_pltfm_host *pltfm_host;
>   	const struct of_device_id *match;
>   	struct sdhci_brcmstb_priv *priv;
> +	u32 base_clock_hz = 0;
>   	struct sdhci_host *host;
>   	struct resource *iomem;
>   	struct clk *clk;
> @@ -330,6 +331,30 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
>   	if (match_priv->flags & BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT)
>   		host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
>   
> +	/* Change the base clock frequency if the DT property exists */
> +	if (device_property_read_u32(&pdev->dev, "max-frequency",
> +				     &base_clock_hz) == 0) {
> +		struct clk *master_clk;
> +		u32 actual_clock_mhz;
> +
> +		master_clk = devm_clk_get(&pdev->dev, "sdio_freq");
> +		if (IS_ERR(master_clk)) {
> +			dev_warn(&pdev->dev,
> +				 "Clock for \"sdio_freq\" was not found\n");
> +		} else {
> +			clk_set_rate(master_clk, base_clock_hz);

It seems to me that you should enable the clock before getting its rate, 
otherwise this may not return a valid rate. You might also consider 
reducing the indentation a little bit by using a label.
-- 
Florian
