Received: from mail-m1973196.qiye.163.com (mail-m1973196.qiye.163.com [220.197.31.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CA031B117;
	Fri, 23 Jan 2026 06:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769151217; cv=none; b=IddZ/290/vMSc8mTa/6jKfiCS6SuXZgArlnpoUTh8g6pT3+IzAPw2nLAJtnpvOrE3Gv/rkWgTdarEWvE0Nb/R58mDYnLTLB0o9ZWXe4TSrDaIy3nBKmyPtBX0C5LO34ZPcaKGLhll2LUPmnGpBhD1DBVKGD3OLtC1VfkvGUasmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769151217; c=relaxed/simple;
	bh=6LUwwmwztLUjSDZq1YEuRoX0MroxWAMBlYIvltVfvNg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=T0QcQG8SALEb+nRzCbk7WQpza8Hr6dHluUAmPWHFBVmEllj8gW00eRc+o4Vt/LSdqiBM/vJBuPSkS63jZdDRDf7L9DdfNo+lo3atafyJvvM6Kn+t46cM0OPcJ4Kld9BIoIT05HbQdbJ0p4wQdR35vCn+U6l4z17s5EkSi+D7OKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=YTO3Vo/c; arc=none smtp.client-ip=220.197.31.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="YTO3Vo/c"
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 31b4a530a;
	Fri, 23 Jan 2026 14:48:15 +0800 (GMT+08:00)
Message-ID: <2531d1ef-2450-4479-b32e-b9c861ffadd1@rock-chips.com>
Date: Fri, 23 Jan 2026 14:48:14 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, jh80.chung@samsung.com,
 sebastian.reichel@collabora.com, linux-mmc@vger.kernel.org,
 ulf.hansson@linaro.org, linux-kernel@vger.kernel.org, hy50.seo@samsung.com,
 kwangwon.min@samsung.com
Subject: Re: [PATCH] drivers: mmc: Replace manual
 devm_clk_get/clk_prepare_enable with devm_clk_get_optional_enabled
To: "ping.gao" <ping.gao@samsung.com>
References: <CGME20260123054113epcas5p26e6418eb49d2caa8e3ad048d14386189@epcas5p2.samsung.com>
 <20260123054527.4151947-1-ping.gao@samsung.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20260123054527.4151947-1-ping.gao@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9be99c567309cckunmc86b751a195e5e
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQx0eGFYZSUsYT0tLHh0YT0NWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpOTE
	pVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=YTO3Vo/cTl0+ruF3Gm+owbiMuYjpJBy5hb0fWRp10k53B+Kqp0p4Db4Dlfu/icuLtYmQGSTb1BLiGslQ4lIhzOMSm+8eEJJvo646f4w1CQ9OLFBC9Ijx/Ypw5GpssKG9aC0zlG/i8vDoqpzc01Y4QiLfN6EKF/4PRPD6GZNTA2g=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=oew3EVh7JfF8+84rw/TVugGeLDHqJZfIAe4RibowC1s=;
	h=date:mime-version:subject:message-id:from;

在 2026/01/23 星期五 13:45, ping.gao 写道:
> By using , we:
> - Automatically handle optional clocks (return NULL if not present).
> - Ensure the clock is enabled upon acquisition.
> This change reduces code complexity and improves reliability.
> 

The commit tile should be:

mmc: dw_mmc: Replace....

> before biu_clk in dwmmc driver devm_clk_get fail, but it's ERR_PTR,
> not null,it will panic when call clk_prepare
> log is below:

----8<----

> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 61f6986f15ef..18981d010b62 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -3375,20 +3375,10 @@ int dw_mci_probe(struct dw_mci *host)
>   					     "platform data not available\n");
>   	}
>   
> -	host->biu_clk = devm_clk_get(host->dev, "biu");
> -	if (IS_ERR(host->biu_clk)) {
> -		dev_dbg(host->dev, "biu clock not available\n");
> -		ret = PTR_ERR(host->biu_clk);
> -		if (ret == -EPROBE_DEFER)
> -			return ret;
> -
> -	} else {
> -		ret = clk_prepare_enable(host->biu_clk);
> -		if (ret) {
> -			dev_err(host->dev, "failed to enable biu clock\n");
> -			return ret;
> -		}
> -	}
> +	host->biu_clk = devm_clk_get_optional_enabled(host->dev, "biu");

This won't work, as biu_clk will automatically be disabled, unprepared
and freed when dwmmc host is unbound from the bus. Given we need to
control biu_clk in runtime, you could just use devm_clk_get_optional,
it will return NULL which serves as a dummy clk, if biu isn't present.
Then clk_prepare_enable/clk_disable_unprepare for biu_clk is safe to
bail out internally.

> +	ret = PTR_ERR_OR_ZERO(host->biu_clk);
> +	if (ret)
> +		return dev_err_probe(host->dev, ret, "failed to get biu clock\n");
>   
>   	host->ciu_clk = devm_clk_get(host->dev, "ciu");
>   	if (IS_ERR(host->ciu_clk)) {

