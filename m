Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3FF73459;
	Tue, 10 Sep 2024 17:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725988228; cv=none; b=jjcO/lh89AtOCGoKCDqtNyib0CSpUWLBrVRaGcTa1pSqLBiQu5zUvuihURIBwDOBYDs24J7K/4cICZy6qv2MF7ZDKWMaBZx7cKvc6a9RAjwb74lY9cjZc2ytTGjYHqkUZJP7SHf3sI4xbCPBEzK+c6KZoeI+YgVKy92+8YTCQKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725988228; c=relaxed/simple;
	bh=qn75JlB9eUlF0Q/91xlRmmh5y/0GsnO8NMq45Lyx5s4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=js3Jh7Rd14vUOnfZaQoVFpR5uonHaXTnxdcLd/ByT57HgAIdFpeqTzbnYPTwibbcqJcOtKyTHAaEFxjlkhB7o+y7qcGPNrl9XRI/b+rEruOSCQA5S2ou8bb3e1e/2Lo+vJwsd0B7P7aHJu/DlqMErbkC9gn4I8LK5gX2c9DGTYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eVXF7eJ9; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eVXF7eJ9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725988226; x=1757524226;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qn75JlB9eUlF0Q/91xlRmmh5y/0GsnO8NMq45Lyx5s4=;
  b=eVXF7eJ9fLQ899hunvljnDLHGJVTzlQV3GVHhfmRQ9/EBT11m79qvf0t
   CpnUNumwUUpFmyN3xlK5EfsY7sxNlF6UbxcQ2p2xhoCqncXxL5NIawWfA
   jRiZp4ubQRw0acZSLYzZe1hKfXIkihTQNTwCVvGDbOR/B7/32/xxtUXQv
   SHuKROL6r6/Ms0lkH+nt6HXKXv9JxzNyKL8oWDUPorkyBGD81oT10nsSb
   xQzODonQR8y7bQ856Gq4yxK/A9q++XnwGhxDnaBTF96MWHYYvz7QOnKwd
   lyOZyzbJOFbt5rZ8e+c2H7r0wj7WVPetuRqXLdHHICc7734eA7acWm53e
   g==;
X-CSE-ConnectionGUID: q4k5emsVQk2Brfspak+a2w==
X-CSE-MsgGUID: 4bvp8I5wS/uXnEV8m7C8BQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="24855294"
X-IronPort-AV: E=Sophos;i="6.10,217,1719903600"; 
   d="scan'208";a="24855294"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 10:10:26 -0700
X-CSE-ConnectionGUID: oDLmhEqmSjiPj1wIee/ciw==
X-CSE-MsgGUID: 3BVIq00/QNG/iZniTg2f+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,217,1719903600"; 
   d="scan'208";a="71477208"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.245.115.59])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 10:10:24 -0700
Message-ID: <b154b9b3-cb74-4a51-953c-d4328f992898@intel.com>
Date: Tue, 10 Sep 2024 20:10:17 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mmc: sdhci_am654: Add
 sdhci_am654_start_signal_voltage_switch
To: Judith Mendez <jm@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240906175032.1580281-1-jm@ti.com>
 <068093ed-1ab5-40d6-b709-cd6810825ba3@intel.com>
 <cce6ec2f-3293-4f08-a965-76dece0ddfab@ti.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <cce6ec2f-3293-4f08-a965-76dece0ddfab@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/09/24 17:30, Judith Mendez wrote:
> Hi Adrian,
> 
> On 9/9/24 1:26 AM, Adrian Hunter wrote:
>> On 6/09/24 20:50, Judith Mendez wrote:
>>> The sdhci_start_signal_voltage_switch function sets
>>> V1P8_SIGNAL_ENA by default after switching to 1v8 signaling.
>>> V1P8_SIGNAL_ENA determines whether to launch cmd/data on neg
>>> edge or pos edge of clock.
>>>
>>> Due to some eMMC and SD failures seen across am62x platform,
>>> do not set V1P8_SIGNAL_ENA by default, only enable the bit
>>> for devices that require this bit in order to switch to 1v8
>>> voltage for uhs modes.
>>>
>>> Signed-off-by: Judith Mendez <jm@ti.com>
>>> ---
>>>   drivers/mmc/host/sdhci_am654.c | 86 ++++++++++++++++++++++++++++++++++
>>>   1 file changed, 86 insertions(+)
>>>
>>> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
>>> index 0aa3c40ea6ed8..fb6232e56606b 100644
>>> --- a/drivers/mmc/host/sdhci_am654.c
>>> +++ b/drivers/mmc/host/sdhci_am654.c
>>> @@ -155,6 +155,7 @@ struct sdhci_am654_data {
>>>       u32 tuning_loop;
>>>     #define SDHCI_AM654_QUIRK_FORCE_CDTEST BIT(0)
>>> +#define SDHCI_AM654_QUIRK_SET_V1P8_ENA BIT(1)
>>
>> It would be better for the quirk to represent the deviation
>> from normal i.e.
>>
>> #define SDHCI_AM654_QUIRK_SUPPRESS_V1P8_ENA BIT(1)
>>
>>>   };
>>>     struct window {
>>> @@ -356,6 +357,79 @@ static void sdhci_j721e_4bit_set_clock(struct sdhci_host *host,
>>>       sdhci_set_clock(host, clock);
>>>   }
>>>   +int sdhci_am654_start_signal_voltage_switch(struct mmc_host *mmc,
>>> +                        struct mmc_ios *ios)
>>
>> Simpler to call sdhci_start_signal_voltage_switch() for the normal
>> case e.g.
> 
> This is simpler, so sure will use thanks.
> 
>>
>> static int sdhci_am654_start_signal_voltage_switch(struct mmc_host *mmc, struct mmc_ios *ios)
>> {
>>     struct sdhci_host *host = mmc_priv(mmc);
>>     struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>     struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
>>
>>
>>     if ((sdhci_am654->quirks & SDHCI_AM654_QUIRK_SUPPRESS_V1P8_ENA) &&
>>         ios->signal_voltage == MMC_SIGNAL_VOLTAGE_180) {
>>         ret = mmc_regulator_set_vqmmc(mmc, ios);
>>         if (ret < 0) {
>>             pr_warn("%s: Switching to 1.8V signalling voltage failed\n",
>>                 mmc_hostname(mmc));
>>             return -EIO;
>>         }
>>         return 0;
>>     }
>>
>>     return sdhci_start_signal_voltage_switch(mmc, ios);
>> }
>>
>>> +{
>>> +    struct sdhci_host *host = mmc_priv(mmc);
>>> +    struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>> +    struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
>>> +    u16 ctrl;
>>> +    int ret;
>>> +
>>> +    if (host->version < SDHCI_SPEC_300)
>>> +        return 0;
>>> +
>>> +    switch (ios->signal_voltage) {
>>> +    case MMC_SIGNAL_VOLTAGE_330:
>>> +        if (!(host->flags & SDHCI_SIGNALING_330))
>>> +            return -EINVAL;
>>> +
>>> +        ctrl &= ~SDHCI_CTRL_VDD_180;
>>> +        sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
>>> +
>>> +        if (!IS_ERR(mmc->supply.vqmmc)) {
>>> +            ret = mmc_regulator_set_vqmmc(mmc, ios);
>>> +            if (ret < 0) {
>>> +                pr_warn("%s: Switching to 3.3V signalling voltage failed\n",
>>> +                    mmc_hostname(mmc));
>>> +                return -EIO;
>>> +            }
>>> +        }
>>> +
>>> +        usleep_range(5000, 5500);
>>> +
>>> +        ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
>>> +        if (!(ctrl & SDHCI_CTRL_VDD_180))
>>> +            return 0;
>>> +
>>> +        pr_warn("%s: 3.3V regulator output did not become stable\n",
>>> +            mmc_hostname(mmc));
>>> +
>>> +        return -EAGAIN;
>>> +
>>> +    case MMC_SIGNAL_VOLTAGE_180:
>>> +        if (!(host->flags & SDHCI_SIGNALING_180))
>>> +            return -EINVAL;
>>> +
>>> +        if (!IS_ERR(mmc->supply.vqmmc)) {
>>> +            ret = mmc_regulator_set_vqmmc(mmc, ios);
>>> +            if (ret < 0) {
>>> +                pr_warn("%s: Switching to 1.8V signalling voltage failed\n",
>>> +                    mmc_hostname(mmc));
>>> +                return -EIO;
>>> +            }
>>> +        }
>>> +
>>> +        if (sdhci_am654->quirks & SDHCI_AM654_QUIRK_SET_V1P8_ENA) {
>>> +            ctrl |= SDHCI_CTRL_VDD_180;
>>> +            sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
>>> +
>>> +            ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
>>> +            if (ctrl & SDHCI_CTRL_VDD_180)
>>> +                return 0;
>>> +
>>> +            pr_warn("%s: 1.8V regulator output did not become stable\n",
>>> +                mmc_hostname(mmc));
>>> +
>>> +            return -EAGAIN;
>>> +        }
>>> +        return 0;
>>> +
>>> +    default:
>>> +        return 0;
>>> +    }
>>> +}
>>> +
>>>   static u8 sdhci_am654_write_power_on(struct sdhci_host *host, u8 val, int reg)
>>>   {
>>>       writeb(val, host->ioaddr + reg);
>>> @@ -801,6 +875,8 @@ static int sdhci_am654_get_of_property(struct platform_device *pdev,
>>>                       struct sdhci_am654_data *sdhci_am654)
>>>   {
>>>       struct device *dev = &pdev->dev;
>>> +    struct device_node *np = dev->of_node;
>>> +    struct device_node *node;
>>>       int drv_strength;
>>>       int ret;
>>>   @@ -844,6 +920,15 @@ static int sdhci_am654_get_of_property(struct platform_device *pdev,
>>>       if (device_property_read_bool(dev, "ti,fails-without-test-cd"))
>>>           sdhci_am654->quirks |= SDHCI_AM654_QUIRK_FORCE_CDTEST;
>>>   +    node = of_parse_phandle(np, "vmmc-supply", 0);
>>> +
>>> +    if (node) {
>>> +        node = of_parse_phandle(np, "vqmmc-supply", 0);
>>> +
>>> +        if (!node)
>>> +            sdhci_am654->quirks |= SDHCI_AM654_QUIRK_SET_V1P8_ENA;
>>> +    }
>>
>> It would be simpler without 'np' and 'node'.  Not sure
>> what the rule is meant to be, but it could be something like:
>>
>>     if (of_parse_phandle(dev->of_node, "vmmc-supply", 0) &&
>>         of_parse_phandle(dev->of_node, "vqmmc-supply", 0)
>>         sdhci_am654->quirks |= SDHCI_AM654_QUIRK_SUPPRESS_V1P8_ENA;
> 
> My issue with this is that I also need the quirk (SDHCI_AM654_QUIRK_SUPPRESS_V1P8_ENA) for eMMC. DT node for eMMC does
> not include vmmc and vqmmc supplies. That is why I had the quirk logic
> inverted.

Ideally there would be a more direct way to distinguish eMMC, but
otherwise, having both supplies or neither would be:

	if (!!of_parse_phandle(dev->of_node, "vmmc-supply", 0) ==
	    !!of_parse_phandle(dev->of_node, "vqmmc-supply", 0))
		sdhci_am654->quirks |= SDHCI_AM654_QUIRK_SUPPRESS_V1P8_ENA;


> 
> This patch fixes timing issues with both eMMC and SD. (:
> 
> ~ Judith
> 
> 
>>
>>> +
>>>       sdhci_get_of_property(pdev);
>>>         return 0;
>>> @@ -940,6 +1025,7 @@ static int sdhci_am654_probe(struct platform_device *pdev)
>>>           goto err_pltfm_free;
>>>       }
>>>   +    host->mmc_host_ops.start_signal_voltage_switch = sdhci_am654_start_signal_voltage_switch;
>>>       host->mmc_host_ops.execute_tuning = sdhci_am654_execute_tuning;
>>>         pm_runtime_get_noresume(dev);
>>>
>>> base-commit: cf6444ba528f043398b112ac36e041a4d8685cb1
>>
>>
> 

