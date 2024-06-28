Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3A2558B9;
	Fri, 28 Jun 2024 07:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719561030; cv=none; b=oG0lwZorJG1TyQFdY6vMLEoLE3MHY241REu1jJv6DbRPRZz1HeSRR1LFrcJsqd3fMVkMOhhOGi/A+QALe6wJeZEDz+vgKGL8bFR7VsDTFa6EKBjI47KO4g3mAg+Y0npqU7u8FIDXICFx0YiTTjWeYasLvhKeFKqXTJ28lfxEx6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719561030; c=relaxed/simple;
	bh=kpNKN5IrnV1df46CTDwJWgiWoENWRsYsWyLgRfk3dY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QZt6M+/nlPGchf9vLfeTXJJf4jytpibt80KamKFvoAZgN2uMB+LrVAm9JhJ0sGOELb9Sic7XENZozYpfyaH2bKUIulw+m5e2UaazqpMmvxlkI8T4vKezJSAlAnhkCz1OaNoEJH3APClEo5WkAb93P1iJH8mBt3KiQGJpohoSv3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lFT7dJ7D; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFT7dJ7D"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-701f227c256so167993a34.3;
        Fri, 28 Jun 2024 00:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719561028; x=1720165828; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4Ut43npliJLjCO5SImS5MkBvEx66ZUngy2TmpPvYaKw=;
        b=lFT7dJ7D/6qUihLdUx83jTQbSnUVb3kiiPXNBsVNSenjpvW3+uyoljt62S16YxzhIT
         /eJBFPu68L2psKjyaRn8f7CbWq2hcwMbs7O2rFPOfnNaIKXf63EAaGCAnzyU0S29WvGv
         UrDoiqIndVtT8aiAD2WgpuuiGVRHvv/w+KE9XOZ0w5G1r5cFpgX1OMbbQiaewJi3Pt58
         fuvQZwDpapY1NBNTe/wGjBaoTRRA+wFqMH9+D1TL7cPs3K0d4kfZx/fnbdzbln3faIgV
         zHfAzRs64MvghavtdQEYTuptqVfBpWcIjYM2olafg7AlJ2k+6vrVp0jW8uzacllh5PJ5
         ZUcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719561028; x=1720165828;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Ut43npliJLjCO5SImS5MkBvEx66ZUngy2TmpPvYaKw=;
        b=hl+elCtEpmf0sFooB3UoIezz/H/fsQkzNcmA8J3kxaH5w4ORoMeXNWCLSEtal8ZxOj
         pTAqeecBOYrRrdXw4+pURZHraUBwxmHRyWHyAJv+Wko0lKl7qxQk8Ue0NEsp+si7zHWn
         vY92usu9UqmuMSQjeGIn0oT/yaCieso4NLQ+r65doorLxsP4T/2RkSCGLFI5MEWdCq2R
         VcqUQjS8M0vuBVFtOLJHL6ANWq8vJUPamKofGDOhNQP14dDPpVHQfLkhcztksWi4fqvE
         m4Gh/9tOFedxGF8wjb05BnMq+31GAp1C77Cr22inmMGoubVX6ZtKxyP2/I9JILydmOyR
         QOng==
X-Forwarded-Encrypted: i=1; AJvYcCWar9fc7zBTk8XGgB7tucEsBi9WJKMGexoAK6W1arrWtj/yZxqYDlHnrtBdICALVRrECC2XT8S2Utby6fwUZTKgfWut7vk8naxsaXG99VewIdcsJZWcs3xTVHI3GFuVhYEQg3/2AcF9OSZY/SFoYdAOkqryUgF966rqoJvXqeHnyNQzog==
X-Gm-Message-State: AOJu0YxyKnUh+SFd5VHSAeS8AJJca6XcZYtaEfp1l1AXB8/ZEXBwQwt7
	rWlqoq0mJEvE7EUAGYjKSoMMukhnHGG+lFeiZjnGwHHqszh2/0Gs
X-Google-Smtp-Source: AGHT+IG81TXv6cpLvn9mvPZPAsNd0RQHEY0Ddu8BPsGbU1z/qydncY5VMcfNUGc+bNg5CBr8gzQCLg==
X-Received: by 2002:a05:6358:310a:b0:19f:436b:f6b0 with SMTP id e5c5f4694b2df-1a23fafaf3dmr1881852955d.4.1719561028040;
        Fri, 28 Jun 2024 00:50:28 -0700 (PDT)
Received: from [172.19.1.51] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c6a3139f1sm810210a12.20.2024.06.28.00.50.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jun 2024 00:50:27 -0700 (PDT)
Message-ID: <d5875415-07a6-475c-959a-4703f5d4e559@gmail.com>
Date: Fri, 28 Jun 2024 15:50:22 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] mmc: sdhci-of-ma35d1: Add Nuvoton MA35D1 SDHCI
 driver
To: Krzysztof Kozlowski <krzk@kernel.org>, ulf.hansson@linaro.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 adrian.hunter@intel.com, p.zabel@pengutronix.de, pbrobinson@gmail.com,
 serghox@gmail.com, mcgrof@kernel.org,
 prabhakar.mahadev-lad.rj@bp.renesas.com, forbidden405@outlook.com,
 tmaimon77@gmail.com, andy.shevchenko@gmail.com,
 linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com
References: <20240626094900.581552-1-shanchun1218@gmail.com>
 <20240626094900.581552-3-shanchun1218@gmail.com>
 <0cc0aab1-f7bf-4a87-af5a-22cf842fbf80@kernel.org>
Content-Language: en-US
From: Shan-Chun Hung <shanchun1218@gmail.com>
In-Reply-To: <0cc0aab1-f7bf-4a87-af5a-22cf842fbf80@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Krzysztof,

Thanks for your review.

On 2024/6/28 下午 03:31, Krzysztof Kozlowski wrote:
> On 26/06/2024 11:49, Shan-Chun Hung wrote:
>> Add the SDHCI driver for the MA35D1 platform. It is based upon the
>> SDHCI interface, but requires some extra initialization.
>>
>
>> +static int ma35_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct sdhci_pltfm_host *pltfm_host;
>> +	struct sdhci_host *host;
>> +	struct ma35_priv *priv;
>> +	int err;
>> +	u32 extra, ctl;
>> +
>> +	host = sdhci_pltfm_init(pdev, &sdhci_ma35_pdata, sizeof(struct ma35_priv));
>> +	if (IS_ERR(host))
>> +		return PTR_ERR(host);
>> +
>> +	err = devm_add_action_or_reset(dev, ma35_sdhci_pltfm_free, pdev);
>> +	if (err)
>> +		return dev_err_probe(dev, err, "Failed to register sdhci_pltfm_free action\n");
>> +
>> +	/* Extra adma table cnt for cross 128M boundary handling. */
>> +	extra = DIV_ROUND_UP_ULL(dma_get_required_mask(dev), SZ_128M);
>> +	extra = min(extra, SDHCI_MAX_SEGS);
>> +
>> +	host->adma_table_cnt += extra;
>> +	pltfm_host = sdhci_priv(host);
>> +	priv = sdhci_pltfm_priv(pltfm_host);
>> +
>> +	pltfm_host->clk = devm_clk_get_optional_enabled(dev, NULL);
>> +	if (IS_ERR(pltfm_host->clk))
>> +		return dev_err_probe(dev, IS_ERR(pltfm_host->clk), "failed to get clk\n");
> Ykes, you cannot return IS_ERR.
I will fix it to PTR_ERR.
>> +
>> +	err = mmc_of_parse(host->mmc);
>> +	if (err)
>> +		return err;
>> +
>> +	priv->rst = devm_reset_control_get_exclusive(dev, NULL);
>> +	if (IS_ERR(priv->rst))
>> +		return dev_err_probe(dev, PTR_ERR(priv->rst), "failed to get reset control\n");
>> +
>
> Best regards,
> Krzysztof

Best Regards,

Shan-Chun

