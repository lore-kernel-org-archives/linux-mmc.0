Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1D684A5B;
	Wed, 10 Jul 2024 09:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720603574; cv=none; b=rACnbm6IOg6uFbFKV+GNff8WjgO6nCjDv7RzoAyCY/mejfO2Ik/am9f0txcnzj5wV5Hx6RksrmI+m7jwaaN4zgBrezTBqarI0bwaCp633I7FenYiLoawjLMnpJ8pde/U2rjglFP2imbdKdQ9H39E23U6VIc6meYxD0nJLqvgAk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720603574; c=relaxed/simple;
	bh=EzM+QQuPvXYqipkCKXA/ADx49Lc0KveRdc2IsyP5wb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZBJL5XfaNIym/b7jLXBA7JDfPuwufBQPSkUK1i6SywRuvG1YQBCbe4DkxNzwKhzxn3ESHIS2OE4z9DFUIoB+xKxaN2EjlypUMr3KxDArq7w4G3oMeTFISrXAx7qmhZlifsWft3Ndv7QtGMYoqoQxRQd+TgIAMJV/zfDVc88kzZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gmM0zSHW; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gmM0zSHW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720603572; x=1752139572;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EzM+QQuPvXYqipkCKXA/ADx49Lc0KveRdc2IsyP5wb0=;
  b=gmM0zSHWvaQEKp/BXTO4iGyqw+I0nwFKFVL6NbuLKHVSN/k9yUfxp8S4
   dovhvgm46imsc9Zb0E/vBRuxK0vsMHtSY6PRlMCR13dqdV6fylcPE6mVL
   ydvQddJiCHj9DIBnqutkkzJhRmCQjG+EPV0DX4XdBQ2M4CT5lNpw+fdTO
   RnR/+Q5A6Mnprw7JvLsbwwO8MjUj5a/JtYxcszamuXRFAgapU7FnvP+rr
   HHhrTsQdTeatRpwfkcZsluN5Z8L+YIX+eKwQ+8QEkbZcusDuhXt0gIVxD
   LGw7nEopTA88aEAfQSuUxra+kDNz0ncsVooCmIQn318+JH2W4WCjlq5Em
   Q==;
X-CSE-ConnectionGUID: s0v9eu3RQl6Gae2SX0oP3Q==
X-CSE-MsgGUID: dHBQIe/+QXGY9vaudgVSwg==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="18017238"
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; 
   d="scan'208";a="18017238"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 02:26:11 -0700
X-CSE-ConnectionGUID: qvEQbwiDT9qu8ZygTKhhrA==
X-CSE-MsgGUID: zuQvFWvCRFi3E4z3B1FB/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; 
   d="scan'208";a="48057791"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.49.253])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 02:26:10 -0700
Message-ID: <ed01edf2-f3d6-4a93-884d-08525ddaac03@intel.com>
Date: Wed, 10 Jul 2024 12:26:04 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-pxav3: Fix potential NULL dereference in
 sdhci_pxav3_probe
To: Ma Ke <make24@iscas.ac.cn>, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240710070039.318658-1-make24@iscas.ac.cn>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240710070039.318658-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/07/24 10:00, Ma Ke wrote:
> In sdhci_pxav3_probe(), mv_mbus_dram_info() returns NULL if
> CONFIG_PLAT_ORION macro is not defined. Fix this bug by adding NULL check.

Looks like mv_conf_mbus_windows() in sdhci-pxav3.c already checks
for NULL i.e.

static int mv_conf_mbus_windows(struct platform_device *pdev,
				const struct mbus_dram_target_info *dram)
{
	int i;
	void __iomem *regs;
	struct resource *res;

	if (!dram) {
		dev_err(&pdev->dev, "no mbus dram info\n");
		return -EINVAL;
	}


> 
> Fixes: aa8165f91442 ("mmc: sdhci-pxav3: do the mbus window configuration after enabling clocks")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
>  drivers/mmc/host/sdhci-pxav3.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
> index 3af43ac05825..ac89cb2eb9f6 100644
> --- a/drivers/mmc/host/sdhci-pxav3.c
> +++ b/drivers/mmc/host/sdhci-pxav3.c
> @@ -375,6 +375,7 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
>  	struct sdhci_host *host = NULL;
>  	struct sdhci_pxa *pxa = NULL;
>  	const struct of_device_id *match;
> +	const struct mbus_dram_target_info *dram;
>  	int ret;
>  
>  	host = sdhci_pltfm_init(pdev, &sdhci_pxav3_pdata, sizeof(*pxa));
> @@ -406,7 +407,12 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
>  		ret = armada_38x_quirks(pdev, host);
>  		if (ret < 0)
>  			goto err_mbus_win;
> -		ret = mv_conf_mbus_windows(pdev, mv_mbus_dram_info());
> +		dram = mv_mbus_dram_info();
> +		if (!dram) {
> +			ret = 0;
> +			goto err_mbus_win;
> +		}
> +		ret = mv_conf_mbus_windows(pdev, dram);
>  		if (ret < 0)
>  			goto err_mbus_win;
>  	}

