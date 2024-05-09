Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF7E13B5A9;
	Thu,  9 May 2024 08:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715242903; cv=none; b=qK3t+8rr9A3vpB1G+QQcwXC1TegAfnadSko3nh3euQ7knZe8cHBUNYHgACCpIfMqiWHE8w9HfHnNS2mRuckmmGSuZHpaomi128m6rvpvXpk1E1nAyCgm+KphRB6iPKsjlQJZ1E68FsUdpGS/qjcjP0pqpr5jSwjdhlF7+hdoj8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715242903; c=relaxed/simple;
	bh=bgDLzxpYitnFqSBkidhPvmb7A8VF+kvubgyIU2MFg0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=T82L4Zd25nnVoERcRe46VSVjM0FQUV6AJL/4S3lryhx7ZaueUuXIz4e/hFyPlHQoEr0O+Uqe8lIZzgxfl6A9gaC3KN0c5Ae4FR0fiKvXGlWDhRi87/6MIv3iuq8i8X+zhs6cJFa2wGWar44dnJBIBGnDk9XofRWfi4OEBr9SmP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sx1qPmbk; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sx1qPmbk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715242902; x=1746778902;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=bgDLzxpYitnFqSBkidhPvmb7A8VF+kvubgyIU2MFg0g=;
  b=Sx1qPmbk7c+xdTC2smjOeJdfyELeISbORiRnbNiQP3UHqIeDOCcc9zuZ
   UVPYeUp7XND6zlwhznxYcWD9rKhuRkrtTvZHO2Ufnleuwpx6+o/y/zLLf
   fmSKPcs7hzDc8tnh+AkYBZYsRDbocXkTcyGbz4HgWd8gRqtKPJKHSMhfH
   hS3vyfEhomN21aK9bqJ+vWw0V2boz5/pxrvnCIxG5dY9wI8i4RghfX9Cs
   AFcspf/B7Q+h2+Vn2jX5h+J//TYd2MlcClYXfFjHAxaPSXyHhVSapx3CB
   cOA142EK5hmWsHR9CfFMqAivOXJU7NsTsWEPYLSBiOIk5Cnr+iy5ABSeN
   w==;
X-CSE-ConnectionGUID: EsycnyROQS6/TWLL2lvC6Q==
X-CSE-MsgGUID: CE8fm41dSJGUoGbdpRXJ/A==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="22550983"
X-IronPort-AV: E=Sophos;i="6.08,147,1712646000"; 
   d="scan'208";a="22550983"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 01:21:41 -0700
X-CSE-ConnectionGUID: bBIbfyPmRDytOOx14qdCmA==
X-CSE-MsgGUID: faG8c/p9TD2G7pIk/O9Vdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,147,1712646000"; 
   d="scan'208";a="29095902"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.34.226])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 01:21:38 -0700
Message-ID: <c460081e-b74f-4e09-a666-def047b8e587@intel.com>
Date: Thu, 9 May 2024 11:21:32 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] mmc: sdhci-of-dwcmshc: add callback functions for
 dwcmshc_priv
To: Chen Wang <unicorn_wang@outlook.com>, Chen Wang <unicornxw@gmail.com>,
 ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, jszhang@kernel.org, dfustini@baylibre.com,
 yifeng.zhao@rock-chips.com, shawn.lin@rock-chips.com, chao.wei@sophgo.com,
 haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com, tingzhu.wang@sophgo.com,
 guoren@kernel.org, inochiama@outlook.com
References: <cover.1714270290.git.unicorn_wang@outlook.com>
 <5bb708cc830684676dede5f44ee22c7fd03300b7.1714270290.git.unicorn_wang@outlook.com>
 <ed900af1-f090-49a9-bc7e-363a28a4ac2b@intel.com>
 <MA0P287MB282273829FCBA4BE58BD9CC2FEE62@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <MA0P287MB282273829FCBA4BE58BD9CC2FEE62@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/05/24 05:17, Chen Wang wrote:
> 
> On 2024/4/29 15:08, Adrian Hunter wrote:
>> On 28/04/24 05:32, Chen Wang wrote:
>>> From: Chen Wang <unicorn_wang@outlook.com>
>>>
>>> The current framework is not easily extended to support new SOCs.
>>> For example, in the current code we see that the SOC-level
>>> structure `rk35xx_priv` and related logic are distributed in
>>> functions such as dwcmshc_probe/dwcmshc_remove/dwcmshc_suspend/......,
>>> which is inappropriate.
>>>
>>> The solution is to abstract some possible common operations of soc
>>> into virtual members of `dwcmshc_priv`. Each soc implements its own
>>> corresponding callback function and registers it in init function.
>>> dwcmshc framework is responsible for calling these callback functions
>>> in those dwcmshc_xxx functions.
>>>
>>> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
>>> ---
>>>   drivers/mmc/host/sdhci-of-dwcmshc.c | 152 +++++++++++++++++-----------
>>>   1 file changed, 91 insertions(+), 61 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
>>> index 39edf04fedcf..525f954bcb65 100644
>>> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
>>> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
>>> @@ -214,6 +214,10 @@ struct dwcmshc_priv {
>>>       void *priv; /* pointer to SoC private stuff */
>>>       u16 delay_line;
>>>       u16 flags;
>>> +
>>> +    void (*soc_postinit)(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv);
>>> +    int (*soc_clks_enable)(struct dwcmshc_priv *dwc_priv);
>>> +    void (*soc_clks_disable)(struct dwcmshc_priv *dwc_priv);
>> Normally the ops would be part of platform data.  For example,
>> sdhci-of-arasan.c has:
>>
>>     struct sdhci_arasan_of_data {
>>         const struct sdhci_arasan_soc_ctl_map *soc_ctl_map;
>>         const struct sdhci_pltfm_data *pdata;
>>         const struct sdhci_arasan_clk_ops *clk_ops;
>>     };
>>
>> And then:
>>
>>     static struct sdhci_arasan_of_data sdhci_arasan_rk3399_data = {
>>         .soc_ctl_map = &rk3399_soc_ctl_map,
>>         .pdata = &sdhci_arasan_cqe_pdata,
>>         .clk_ops = &arasan_clk_ops,
>>     };
>>     etc
>>
>>     static const struct of_device_id sdhci_arasan_of_match[] = {
>>         /* SoC-specific compatible strings w/ soc_ctl_map */
>>         {
>>             .compatible = "rockchip,rk3399-sdhci-5.1",
>>             .data = &sdhci_arasan_rk3399_data,
>>         },
>>         etc
>>
>> So, say:
>>
>> struct dwcmshc_pltfm_data {
>>     const struct sdhci_pltfm_data *pltfm_data;
>>     void (*postinit)(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv);
>>     int  (*clks_enable)(struct dwcmshc_priv *dwc_priv);
>>     void (*clks_disable)(struct dwcmshc_priv *dwc_priv);
>> }
>>
>> Or if the ops are mostly the same, it might be more convenient to
>> have them in their own structure:
>>
>> struct dwcmshc_pltfm_data {
>>     const struct sdhci_pltfm_data *pltfm_data;
>>     const struct dwcmshc_ops *ops;
>> }
> 
> hi, Adrian,
> 
> I thought about it for a while, and I would like to continue discussing this issue as follows.
> 
> I feel like it would be simpler to put it at the dwcmshc_priv level based on the ops involved in the code so far. Judging from the SOCs currently supported by dwcmshc, the ops I abstracted only operate data below the dwcmshc_priv level, and these ops are not used by most SOCs.
> - postinit: only required by rk35xx
> - init: involves rk35xx and th1520, and the new soc(sg2042) I want to add.
> - clks_enable/clks_disable: only rk35xx and the sg2042 I want to add
> 
> In particular, for dwcmshc_suspend/dwcmshc_resume, we have already obtained dwcmshc_priv. If ops is to be placed at the platformdata level, we have to use device_get_match_data to obtain data again, which feels a bit unnecessary.
> 
> What do you think?

In sdhci-of-arasan.c, ops are copied from platform data to
driver private data e.g.

static int sdhci_arasan_probe(struct platform_device *pdev)
{
	...
	struct sdhci_arasan_data *sdhci_arasan;
	const struct sdhci_arasan_of_data *data;

	data = of_device_get_match_data(dev);
	if (!data)
		return -EINVAL;
	...
	sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
	...
	sdhci_arasan->clk_ops = data->clk_ops;


Alternatively, a pointer could be put in driver private data
to point to platform data.

