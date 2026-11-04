Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.209.128.80
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793756433;
	b=V/SCaMr9b1nIvg9PvL8wvMxJ8lVbLtLdXB5+vkPuH2a+FiPK7qWDMaJil54yNzf3nN1t
	 KDMeT9enZwBBg+dI3GA3QTsCk6daP7jCEx85ce01Or/LDBJlm9B1wm5kCvFcjFpWluLth
	 sU7oTSTIPyBNqZICmPbfygxvydeBuFokyfjmP6O8JFLTFt11TgR9UUwWZ61Cc68rDAPGJ
	 id984jOGI+/ZBRRXl8OVH/ht2sxzoq0XFRCS/cHGpbkfYX3fGZBi9DEebifyjQYelEnfe
	 w6IlE2H8jVFzlU3+1UcG0A1gzGAsrC+fyEHMDjmFWdNLJRkI9G+xTxgndIqf3887w+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793756433;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:Cc:
	 Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:X-HM-Spam-Status:
	 DKIM-Signature;
	bh=BBLFv8CAPvGyOaS7NIuvWQkrby9cqP5XdAtYurscD64=;
	b=PWjSWAFpKCJP2e3A1YYrXAoCXARuYrKNANGWdlsjEAkZNv3Izy4KqwvKxRu5w8tY4mpR
	 AnK7V6Kc1xFsoHDmXRyFJp+yh8o8XpfL8NHJCCn78HN69BlL/9+oaFIpY11jOvf+nDLRD
	 Z6tRA3X7IbBCqHeUNhMAI6LuAkhWq0PBwhJAeTozRz+n6GjTHlQX8k6Wiy02Ar+VyjBYk
	 ZDN/GY2ddazR+EXZuif8lrBIr3OoYXx9WUMRiigjEDR3Re4ATek3D/Tobqzf7RwcNq644
	 lf+dLRkZ3RjjOA52utWnsnDsq9TcbwUrTaXCwyW0UI/0izCALMpv8/YBOobe3eSk9TQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rock-chips.com;
	spf=pass smtp.mailfrom=rock-chips.com;
	dkim=pass header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=VZCLpxAt;
	arc=none smtp.remote-ip=103.209.128.80
Received: from mail-m12880.netease.com (mail-m12880.netease.com [103.209.128.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66048606A31B;
	Wed,  4 Nov 2026 01:40:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66048606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=VZCLpxAt
Received: from [172.16.12.48] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 53662fd09;
	Wed, 4 Nov 2026 09:40:21 +0800 (GMT+08:00)
Message-ID: <35d05298-9e72-4b7d-bb2d-832f44725d82@rock-chips.com>
Date: Wed, 4 Nov 2026 09:40:20 +0800
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] mmc: sdhci-of-dwcmshc: Set CQHCI command idle time
 for StarFive JHB100
To: Adrian Hunter <adrian.hunter@intel.com>,
 Changhuang Liang <changhuang.liang@starfivetech.com>,
 Asutosh Das <quic_asutoshd@quicinc.com>,
 Ritesh Harjani <ritesh.list@gmail.com>, Ulf Hansson <ulfh@kernel.org>
References: <20261014121222.31385-1-changhuang.liang@starfivetech.com>
 <20261014121222.31385-3-changhuang.liang@starfivetech.com>
 <1db96e86-8f70-4b72-a2e4-a251c41fb1e3@intel.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <1db96e86-8f70-4b72-a2e4-a251c41fb1e3@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1a436db4d03a4kunm61756b23625ca
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaHkwaVhkdT00aSB5NS0NPGlYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=VZCLpxAtHVkVgMs+b8MhEH4S/yVJjpmQ1xfnVjVN17gldTCOtn6i63MNfh8gOObCcQuDrGF6GT9Ex/2Ct9OpK/yy5uLCHNkEFj/BZOr+FkVVCDfW9S7nw8tneuKhTz9pY0u5STFGYb8ODkk6cpW9LXzUpS/qiOu9wOGQ8mfrF5A=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=BBLFv8CAPvGyOaS7NIuvWQkrby9cqP5XdAtYurscD64=;
	h=date:mime-version:subject:message-id:from;

在 2026/10/31 星期六 0:45, Adrian Hunter 写道:
> + Shawn
> 
> On 14/10/2026 15:12, Changhuang Liang wrote:
>> Add a cqhci_host_ops for the StarFive JHB100 platform that sets the
>> CQHCI command idle time (CIT) to 320 ns during pre_enable.
>>
>> Setting the command idle time improves eMMC performance on this
>> platform. Before/after dd results:
>>
>> before:
>> dd if=/dev/mmcblk0 of=/dev/null bs=1M count=800
>> 838860800 bytes (839 MB, 800 MiB) copied, 9.38511 s, 89.4 MB/s
>> dd if=/dev/zero of=/dev/mmcblk0 bs=1M count=800
>> 838860800 bytes (839 MB, 800 MiB) copied, 12.2127 s, 68.7 MB/s
>>
>> after:
>> dd if=/dev/mmcblk0 of=/dev/null bs=1M count=800
>> 838860800 bytes (839 MB, 800 MiB) copied, 3.19472 s, 263 MB/s
>> dd if=/dev/zero of=/dev/mmcblk0 bs=1M count=800
>> 838860800 bytes (839 MB, 800 MiB) copied, 10.7587 s, 78.0 MB/s
>>
>> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
>> ---
>>   drivers/mmc/host/sdhci-of-dwcmshc.c | 22 ++++++++++++++++++++++
>>   1 file changed, 22 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
>> index 249055f14162..36628b44f78b 100644
>> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
>> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
>> @@ -283,6 +283,8 @@
>>   #define PHY_DELAY_CODE_SD		0x55
>>   #define PHY_DELAY_CODE_SDIO		0x29
>>   
>> +/* CIT for the JHB100 SoC */
>> +#define JHB100_CQHCI_CIT_NS	320
>>   struct rk35xx_priv {
>>   	struct reset_control *reset;
>>   	u8 txclk_tapnum;
>> @@ -2340,6 +2342,25 @@ static const struct sdhci_ops starfive_jhb100_ops = {
>>   	.platform_execute_tuning = th1520_execute_tuning,
>>   };
>>   
>> +static void dwcmshc_starfive_jhb100_pre_enable(struct mmc_host *mmc)
>> +{
>> +	struct cqhci_host *cq_host = mmc->cqe_private;
>> +	int ret;
>> +
>> +	ret = cqhci_set_cmd_idle_time(cq_host, JHB100_CQHCI_CIT_NS);
> 
> Currently doing this from ->pre_enable() leaves a gap.  It needs:
> 
> diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
> index a466cd88b043..e1bf6d50e8eb 100644
> --- a/drivers/mmc/host/cqhci-core.c
> +++ b/drivers/mmc/host/cqhci-core.c
> @@ -283,6 +283,9 @@ static void __cqhci_enable(struct cqhci_host *cq_host)
>   
>   	cqhci_set_irqs(cq_host, 0);
>   
> +	if (cq_host->ops->pre_enable)
> +		cq_host->ops->pre_enable(mmc);
> +
>   	cqcfg |= CQHCI_ENABLE;
>   
>   	cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
> 
> which is probably:
> 
> Fixes: 79cf71c0b177 ("mmc: sdhci-of-dwcmshc: reduce CIT for better performance")
> 
> Shawn?
> 

The window between CQHCI_ENABLE and the first request has no queued
commands for the idle timer to apply to, and pre_enable() re-runs on
every cqe_off -> cqe_on transition (recovery, resume), so the value gets
rewritten even if the registers were reset in between.

You are right that __cqhci_enable() does not touch CQHCI_SSC1. It only
programs CQHCI_CFG, CQHCI_TDLBA/TDLBAU, CQHCI_SSC2 and CQHCI_CTL, so
today the CIT write lands just before the first request and the default
value in the idle window is harmless.

I agree the value belongs in struct cqhci_host and should be programmed
from __cqhci_enable() when it is non-zero, as you suggested.

> 
> Going forward, it would probably be simpler to put 'cit' in
> struct cqhci_host and write it, if it is not 0, in __cqhci_enable()
> e.g.
> 
> diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
> index a466cd88b043..d5f8b427e1f8 100644
> --- a/drivers/mmc/host/cqhci-core.c
> +++ b/drivers/mmc/host/cqhci-core.c
> @@ -279,6 +279,14 @@ static void __cqhci_enable(struct cqhci_host *cq_host)
>   	cqhci_writel(cq_host, upper_32_bits(cq_host->desc_dma_base),
>   		     CQHCI_TDLBAU);
>   
> +	if (cq_host->cit) {
> +		u32 ssc1 = cqhci_readl(cq_host, CQHCI_SSC1);
> +
> +		ssc1 &= ~CQHCI_SSC1_CIT_MASK;
> +		ssc1 |= FIELD_PREP(CQHCI_SSC1_CIT_MASK, cq_host->cit);
> +		cqhci_writel(cq_host, ssc1, CQHCI_SSC1);
> +	}
> +
>   	cqhci_writel(cq_host, cq_host->rca, CQHCI_SSC2);
>   
>   	cqhci_set_irqs(cq_host, 0);
> 
>> +	if (ret)
>> +		dev_warn_once(mmc_dev(mmc),
>> +			      "failed to set CQE command idle time: %d\n", ret);
>> +}
>> +
>> +static const struct cqhci_host_ops starfive_jhb100_cqhci_ops = {
>> +	.enable			= dwcmshc_sdhci_cqe_enable,
>> +	.disable		= sdhci_cqe_disable,
>> +	.pre_enable		= dwcmshc_starfive_jhb100_pre_enable,
>> +	.dumpregs		= dwcmshc_cqhci_dumpregs,
>> +	.set_tran_desc		= dwcmshc_set_tran_desc,
>> +};
>> +
>>   static int dwcmshc_starfive_jhb100_init(struct device *dev, struct sdhci_host *host,
>>   					struct dwcmshc_priv *dwc_priv)
>>   {
>> @@ -2412,6 +2433,7 @@ static const struct dwcmshc_pltfm_data sdhci_dwcmshc_jhb100_pdata = {
>>   		.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
>>   		.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
>>   	},
>> +	.cqhci_host_ops = &starfive_jhb100_cqhci_ops,
>>   	.init = dwcmshc_starfive_jhb100_init,
>>   	.deinit = dwcmshc_starfive_jhb100_deinit,
>>   };
> 
> 

