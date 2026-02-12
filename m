Received: from mail-m15590.qiye.163.com (mail-m15590.qiye.163.com [101.71.155.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640C729D297;
	Thu, 12 Feb 2026 10:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770893116; cv=none; b=oS+klJMTKS4s2kBnWaEqGWrjFrXv69qlrnxSmJmS8abLCblh5B0/nnvgu6rPQj8iGuGyVBghkS7lsOSPui0zB5Y+SCYZ0RWZd/t5YD18GUoTeLLQnKwomHQNjvifBgiyhTvdWJ7FBVWwpNWHwpoiGB73iSc6gRCLF0m23AiiYsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770893116; c=relaxed/simple;
	bh=0ZuZJsbubu1mQp2OIurzEABXpjL9pB+HslqalqPNR28=;
	h=Cc:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=eQfIE/fgle+pu+r11LZ51la9UDW7Z9YalQnsB6pLf5G4Ey3wGd0iDDj7CxgIUZboo4CqOoPD0305LNdJUgV77PJ7/iXpzDYyL0+sCv2qkXnclNiowT7QR3KrSJ7XV7zpoRVw5qWSOHAf1bRtFG9pAHob2Vxy7VZxNJaEUkNgXa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=DgEQMcU3; arc=none smtp.client-ip=101.71.155.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="DgEQMcU3"
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 33faa7800;
	Thu, 12 Feb 2026 18:45:04 +0800 (GMT+08:00)
Cc: shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, hy50.seo@samsung.com, kwangwon.min@samsung.com
Subject: Re: [PATCH] drivers: dw_mmc: Replace devm_clk_get with
 devm_clk_get_optional
To: "ping.gao" <ping.gao@samsung.com>, ulf.hansson@linaro.org,
 jh80.chung@samsung.com, sebastian.reichel@collabora.com
References: <CGME20260123085150epcas5p42f2cc04843ae7657380b2968261246cb@epcas5p4.samsung.com>
 <20260212103627.3677417-1-ping.gao@samsung.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <a1e0ad87-a657-0e45-2701-d23cbfe8d523@rock-chips.com>
Date: Thu, 12 Feb 2026 18:45:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260212103627.3677417-1-ping.gao@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9c5174545c09cckunmd920d1121f3390
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUtLSVZMHR1CSU0ZTkhKS05WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=DgEQMcU396lv3Iw/7JVodO1bBa0Tf8QE/FF9dkegNpdQDD9eGef6q6WStGgwT8AEprc0lEg9W4DJHmTogpQryVDr5i6YIZw6FpR9yBcj4qpWW42IOrrmjhxneqUQBXo/a09s9Dp/TqZ6TQCDG7GNGYafq5izUeYbAP0AssJTYm8=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=tePzdhnMX98i53d3zPbT3U3A3gRzRp+Y4bv1BAKPP24=;
	h=date:mime-version:subject:message-id:from;



在 2026/02/12 星期四 18:36, ping.gao 写道:
> 在 2026/01/23 星期五 18:56, shawn lin 写道:
> 
> 

...

> 
> 
> 1.  I think "synopsys-dw-mshc.yaml" needn't change , because biu must be set for hisilicon, they will set rate for biu_clk
> 

No, otherwise you can't pass the dtschema checking.

> 
> 2.  we should add another patch for hisilicon like below, do you agree?
> 
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> 

Please check it in dw_mmc-k3 code.

> 
> index 6bcc1e7233c0..7a2149435894 100644
> 
> 
> --- a/drivers/mmc/host/dw_mmc.c
> 
> 
> +++ b/drivers/mmc/host/dw_mmc.c
> 
> 
> @@ -3383,6 +3383,17 @@ int dw_mci_probe(struct dw_mci *host)
> 
> 
>                          return ret;
> 
> 
> 
> 
> 
>          } else {
> 
> 
> +               const char *compatible_str = NULL;
> 
> 
> +
> 
> 
> +               if (of_property_read_string(host->dev->of_node, "compatible",
> 
> 
> +                       &compatible_str) == 0) {
> 
> 
> +                       if (strstr(compatible_str, "hisilicon")) {
> 
> 
> +                               if (!host->biu_clk) {
> 
> 
> +                                       dev_err(host->dev, "biu clock not available ,it must be set\n");
> 
> 
> +                                       return -EINVAL;
> 
> 
> +                               }
> 
> 
> +                       }
> 
> 
> +               }
> 
> 
>                  ret = clk_prepare_enable(host->biu_clk);
> 
> 
>                  if (ret) {
> 
> 
>                          dev_err(host->dev, "failed to enable biu clock\n");
> 
> 
> --
> 
> 
> could you please give me some advice? thanks.
> 
> 
> Gaoping
> 
> 
> 
> 
> 
>>>    	if (IS_ERR(host->biu_clk)) {
> 
> 
>>>    		dev_dbg(host->dev, "biu clock not available\n");
> 
> 
>>>    		ret = PTR_ERR(host->biu_clk);
> 
> 
>>>
> 
> 
> 
> 
