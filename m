Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD832904;
	Sat, 22 Jun 2024 09:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719047732; cv=none; b=M9MAG8GB99Sazg6e8MmSzTRgZs2VHmt3bM9y0yOrFmwDk9/FDy255NkfGPhCG7l/uB2oYXgrGcus5YB3RYFJobYF4RhfwMJB/Qy44bAELfxA0ExLYD5zwAurlyyDCyQhPXwCCs5BK+U5Mq4etbCGCq8baNcp6Dq1BiAomswn66s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719047732; c=relaxed/simple;
	bh=QGmovqxe/ZZvpyV8EpE1WhgzuX8/X+ep9bNe33O6b7k=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=mSXjtOlvq9C3zbP8hXLcdIO/tQJo3+j3MtpoXqmX1PO1K1xjW9OON9jLsYuS1jaQ1E33ZEmGvf1slOIo42uxdfsqiqNbgCMjj5xsCanXInMLGQtoXDPpUjoMuBcshn+Sz8W1RIV7GMeG2kxYGOfM9ERx+YFOoxU10lN+ody28Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B6NaVLXc; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6NaVLXc"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fa07e4f44eso4714005ad.2;
        Sat, 22 Jun 2024 02:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719047730; x=1719652530; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E+Wro17/2T3M6H3Hb7/cNYPT10OFFiTg+saReZEKGL8=;
        b=B6NaVLXcWO+TNJ8InKGSth5xkCIM8kkUw6DrZJdpPVd479dLkQrkI5G8AEsRLG4G6V
         61LUMs6tJjYPgE5NZYJ+yYiwSz4tP4Ug0Hhj8lGx2Qu4MJXEZmRh6Y1ZHaK/sjn4BrVy
         PL+WIdvswJHkLzNx2FlHblw9lOZK9KuUtrBEhtPw/RUYUYcZ9kefNIQTEtHY4lkapkR9
         wfo10+3/ZdAo69Kki0YfhGvgMkuWdSw7dm55/bhban6giqFdpZF8b3WDZroG1cnU3ICb
         J9QzyKL8hY3TEW9gv13cRCthSF8V8KNuFpsf+ijTchDjlcDQI8sQArVkeu9KVWbXTNHQ
         y77w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719047730; x=1719652530;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E+Wro17/2T3M6H3Hb7/cNYPT10OFFiTg+saReZEKGL8=;
        b=b6k5ApM/rrkKO5REE9Tym7oMdNJG6wmmRIGKI8p4hnPdJk5JX8PsKI2Dbeg6g7/W8l
         CWMxZkeB4geoAA22BRZE3TbMTm+sv0lcKvTcoo/Q+Wa1pddElBo/uUgkgQZjMIeirVx9
         ifhQsJ4Bg2qNkhG3J1Ev1BqGsZ0gZOtA/lTDqJudxDyCnKYNWioAAwLFUZ4+FOU4ULfw
         5MJqDzPaMSEymuE4GypFOgvhivB3eDHhQx1EYf7gUSFSq+Nr91bYmM2bIZWhPQ7oi/V9
         tXPh+LkBFVbjqYtBe4lU4/EstAPMlFm07R/gpdHaP7rWkB5X10+jKxmXOnq0SIC8nvzq
         f3Pg==
X-Forwarded-Encrypted: i=1; AJvYcCUlB8xTYDOcuaClDZ3euTyw5sGZZKgOGTiKO/gUJlG1DNiaq43nAcooUNjX6gDTWIzzNoXyGFHNhsw7ga5mx5AzY2MKhM/NvcFoDecTYudIvCMLGhD2eNx0OyNy6GMIC+/2hkh7ET3PqpJrimh+QE7N2uzKp/XSBcvrSHxxynla7XXZVQ==
X-Gm-Message-State: AOJu0YznxKFSbxse/UBRB1amY2SpGqJUDqjy9+TTGkMc8aEbuffSH5QC
	s30t3umVNcxB95m+kSmU6alNmT7jTY7JxpghtmiRpvz3ZLUELydf
X-Google-Smtp-Source: AGHT+IFCAGCzvCfBKH6kQY85vrf8JsQcixQ15Dk3MpSL0kWK12ZJS4GFjOJTc01K7wzCRuSgudiSZg==
X-Received: by 2002:a17:903:191:b0:1f9:ccd0:2abb with SMTP id d9443c01a7336-1f9ccd02d58mr85004575ad.58.1719047730306;
        Sat, 22 Jun 2024 02:15:30 -0700 (PDT)
Received: from [172.19.1.51] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb9bffdasm26812535ad.237.2024.06.22.02.15.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Jun 2024 02:15:29 -0700 (PDT)
Message-ID: <3c4e0d8f-8d1e-4667-87c3-f070f3649a2c@gmail.com>
Date: Sat, 22 Jun 2024 17:15:24 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Shan-Chun Hung <shanchun1218@gmail.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-of-ma35d1: Add Novoton MA35D1 SDHCI driver
To: Philipp Zabel <p.zabel@pengutronix.de>, ulf.hansson@linaro.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 adrian.hunter@intel.com, pbrobinson@gmail.com, serghox@gmail.com,
 mcgrof@kernel.org, prabhakar.mahadev-lad.rj@bp.renesas.com,
 forbidden405@outlook.com, tmaimon77@gmail.com, andy.shevchenko@gmail.com,
 linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com
References: <20240619054641.277062-1-shanchun1218@gmail.com>
 <20240619054641.277062-3-shanchun1218@gmail.com>
 <bd0e85f42ef74f6f927020cbee6879351d1c3e9e.camel@pengutronix.de>
Content-Language: en-US
In-Reply-To: <bd0e85f42ef74f6f927020cbee6879351d1c3e9e.camel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Philipp,

Thanks for your review.

On 2024/6/21 下午 07:45, Philipp Zabel wrote:
> On Mi, 2024-06-19 at 13:46 +0800, Shan-Chun Hung wrote:
>> This adds the SDHCI driver for the MA35 series SoC. It is based upon the
>> SDHCI interface, but requires some extra initialization.
>>
>> Signed-off-by: schung<schung@nuvoton.com>
>> ---
>>   drivers/mmc/host/Kconfig           |  13 ++
>>   drivers/mmc/host/Makefile          |   1 +
>>   drivers/mmc/host/sdhci-of-ma35d1.c | 297 +++++++++++++++++++++++++++++
>>   3 files changed, 311 insertions(+)
>>   create mode 100644 drivers/mmc/host/sdhci-of-ma35d1.c
>>
> [...]
>> diff --git a/drivers/mmc/host/sdhci-of-ma35d1.c b/drivers/mmc/host/sdhci-of-ma35d1.c
>> new file mode 100644
>> index 000000000000..7714a5ab463d
>> --- /dev/null
>> +++ b/drivers/mmc/host/sdhci-of-ma35d1.c
>> @@ -0,0 +1,297 @@
> [...]
>> +static int ma35_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct sdhci_pltfm_host *pltfm_host;
>> +	struct sdhci_host *host;
>> +	struct ma35_priv *priv;
>> +	int err;
>> +	u32 extra, ctl;
>> +
>> +	host = sdhci_pltfm_init(pdev, &sdhci_ma35_pdata,
>> +				sizeof(struct ma35_priv));
>> +	if (IS_ERR(host))
>> +		return PTR_ERR(host);
>> +
>> +	/*
>> +	 * extra adma table cnt for cross 128M boundary handling.
>> +	 */
>> +	extra = DIV_ROUND_UP_ULL(dma_get_required_mask(&pdev->dev), SZ_128M);
>> +	if (extra > SDHCI_MAX_SEGS)
>> +		extra = SDHCI_MAX_SEGS;
>> +	host->adma_table_cnt += extra;
>> +	pltfm_host = sdhci_priv(host);
>> +	priv = sdhci_pltfm_priv(pltfm_host);
>> +
>> +	if (dev->of_node) {
>> +		pltfm_host->clk = devm_clk_get(&pdev->dev, NULL);
>> +		if (IS_ERR(pltfm_host->clk)) {
>> +			err = PTR_ERR(pltfm_host->clk);
>> +			dev_err(&pdev->dev, "failed to get clk: %d\n", err);
>> +			goto free_pltfm;
>> +		}
>> +		err = clk_prepare_enable(pltfm_host->clk);
>> +		if (err)
>> +			goto free_pltfm;
>> +	}
>> +
>> +	err = mmc_of_parse(host->mmc);
>> +	if (err)
>> +		goto err_clk;
>> +
>> +	priv->rst = devm_reset_control_get(&pdev->dev, NULL);
> Please use devm_reset_control_get_exclusive() instead.
>
> regards
> Philipp
OK, I will fix it.

Best Regards

Shan-Chun

