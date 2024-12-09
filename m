Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19546215183
	for <linux-mmc@vger.kernel.org>; Mon,  9 Dec 2024 08:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733732107; cv=none; b=EhSO0i5xNJT6co/cHXaRUBcXL+DVofam7Zl1wigS/kNsWZgzfeKkCXnIeKjGopkS99tiDqLzu00IgNcXhrIfJzuw1A8PH5ZMalz/LYm5TDgQ1MhcIT0K/eiGAGbzMghpVfFykiq0yZnxLNKhg8d2lVLtLj6CAdpXfM1AWvCmGtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733732107; c=relaxed/simple;
	bh=NwZOERGYTuG+WnIaj2E+IQlJZ2V6uLL3tMPxPTKqHUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aw2igNLJwTkCEP3ie0N1bIFaM371jq+RRNWbAEwyO/XEAThWdUTTXyMQwiz4Iz69RdsWe1zIBu9g+GYepgf6P03r05iUOKMlTHccb0p2KrQmKf1igGLXL3vfmUTn5ZWcz7K7aweuKr+RuzwZdlvpMg9OWFRC3maY2PtKuP0qA50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jJ8JJqGy; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jJ8JJqGy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733732105; x=1765268105;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NwZOERGYTuG+WnIaj2E+IQlJZ2V6uLL3tMPxPTKqHUA=;
  b=jJ8JJqGyKQ8BuTO5i1ly9muRW9o7Y8r9u9A5/EkOyqW90c/qDWHKgau0
   2jA9d0TKue3oU+1jTcS0m9RuvOxdajnor8l9pEDK0/KxOJHPChx5OuuJ/
   hIja5x+GB/roHRlDbZ9XYDuLQ26WH1l7NbdLMSDr4yg3qoYS8bM2noOVa
   LzTjQ+uhEhlBmRaIeTXq9Uue2LbOBLkMpxaEesxNKQT9c2D9gZnB9A1XX
   Ex1MRZRdSFt/QcapW6iHY4bQQbqy5fB4Rl1q4hYb5pxe1Xz0twWT9PvlS
   20odm4ICif1pLt0iq5xz/pr/SOAtTie4pHfS7I8wxr/31wKzv8FUKxxqn
   A==;
X-CSE-ConnectionGUID: Q5PCWtNfSs+UUccHQ0QM8A==
X-CSE-MsgGUID: h5swo1dJSfGD5LRXa2bgJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11280"; a="51432718"
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="51432718"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 00:13:58 -0800
X-CSE-ConnectionGUID: BARcyTOvQ7q7ORA6YgriZg==
X-CSE-MsgGUID: 0HqZp3eDRyySYmncFpVUKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="95086470"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.245.89.141])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 00:13:57 -0800
Message-ID: <fe7d3b1e-1e87-49f2-806b-513bd214c854@intel.com>
Date: Mon, 9 Dec 2024 10:13:52 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-of_dwcmshc: Change to dwcmshc_phy_init for
 reusing codes
To: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org
References: <CGME20241204100508epcas1p2cc54ed287df5a361536b68971bca48f6@epcas1p2.samsung.com>
 <20241204100507.330025-1-jh80.chung@samsung.com>
 <36d8b897-e8d0-4262-b60b-a5510e93c6ff@intel.com>
 <052501db476a$1c1d0150$545703f0$@samsung.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <052501db476a$1c1d0150$545703f0$@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/12/24 01:05, Jaehoon Chung wrote:
> 
> 
>> -----Original Message-----
>> From: Adrian Hunter <adrian.hunter@intel.com>
>> Sent: Thursday, December 5, 2024 10:17 PM
>>
>> On 4/12/24 12:05, Jaehoon Chung wrote:
>>> dwcmshc_phy_1_8v_init and dwcmshc_phy_3_3v_init differ only by a few
>>> lines of code. This allow us to reuse code depending on voltage.
>>>
>>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>>> ---
>>>  drivers/mmc/host/sdhci-of-dwcmshc.c | 69 +++++------------------------
>>>  1 file changed, 12 insertions(+), 57 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
>>> index 7ea3da45db32..87bc32d13cc0 100644
>>> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
>>> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
>>> @@ -328,11 +328,15 @@ static void dwcmshc_request(struct mmc_host *mmc, struct mmc_request *mrq)
>>>  	sdhci_request(mmc, mrq);
>>>  }
>>>
>>> -static void dwcmshc_phy_1_8v_init(struct sdhci_host *host)
>>> +static void dwcmshc_phy_init(struct sdhci_host *host)
>>>  {
>>>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>>  	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
>>>  	u32 val;
>>> +	u32 rxsel = PHY_PAD_RXSEL_3V3;
>>
>> Nicer to order local variables by descending line length when
>> possible i.e.
>>
>> 	u32 rxsel = PHY_PAD_RXSEL_3V3;
>> 	u32 val;
>>
>>> +
>>> +	if (host->flags & SDHCI_SIGNALING_180 || priv->flags & FLAG_IO_FIXED_1V8)
>>
>> 'host->flags & SDHCI_SIGNALING_180' only means 1.8V signaling
>> is supported, so this looks strange. Can you clarify this?
> 
> AFAIK, SDHCI_SIGNALING_180 is to check if its IP(Host controller) supports 1.8V as you mentioned.
> The previous function (dwcmshc_phy_1_8v_init) is called in sdhci.c. through host->ops->voltage_switch().
> I couldn't find any other place where its function is called.
> 
> When ios->signal_voltage is set to MMC_SIGNAL_VOLTAGE_180, dwcmshc_pyh_1_8v_init is called.
> 
> In the switch statement, if '(!(host->flags & SDHCI_SIGNALING_180))' evaluates to true, it returns -EINVAL.
> 
> So I think that there are only two possible scenarios involving "SDHCI_SIGNALING_180 or FLAG_IO_FIXED_1V8".

A third possibility is host->flags has both MMC_SIGNAL_VOLTAGE_180
and SDHCI_SIGNALING_330, and FLAG_IO_FIXED_1V8 is false.
What should it do then?

> 
> To clarify this, I will change to if (!!(host->flags & SDHCI_SIGNALING_180) || priv->flags & FLAG_IO_FIXED_1V8).
> 
> And if my understanding is something wrong, let me know, plz.
> 
> Additionally, I have tested on LicheePi4A.
> 
>>
>>> +		rxsel = PHY_PAD_RXSEL_1V8;
>>>
>>>  	/* deassert phy reset & set tx drive strength */
>>>  	val = PHY_CNFG_RSTN_DEASSERT;
>>> @@ -353,7 +357,7 @@ static void dwcmshc_phy_1_8v_init(struct sdhci_host *host)
>>>  	sdhci_writeb(host, val, PHY_SDCLKDL_CNFG_R);
>>>
>>>  	/* configure phy pads */
>>> -	val = PHY_PAD_RXSEL_1V8;
>>> +	val = rxsel;
>>>  	val |= FIELD_PREP(PHY_PAD_WEAKPULL_MASK, PHY_PAD_WEAKPULL_PULLUP);
>>>  	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CTRL_P);
>>>  	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N);
>>> @@ -365,65 +369,20 @@ static void dwcmshc_phy_1_8v_init(struct sdhci_host *host)
>>>  	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N);
>>>  	sdhci_writew(host, val, PHY_CLKPAD_CNFG_R);
>>>
>>> -	val = PHY_PAD_RXSEL_1V8;
>>> +	val = rxsel;
>>>  	val |= FIELD_PREP(PHY_PAD_WEAKPULL_MASK, PHY_PAD_WEAKPULL_PULLDOWN);
>>>  	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CTRL_P);
>>>  	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N);
>>>  	sdhci_writew(host, val, PHY_STBPAD_CNFG_R);
>>>
>>>  	/* enable data strobe mode */
>>> -	sdhci_writeb(host, FIELD_PREP(PHY_DLLDL_CNFG_SLV_INPSEL_MASK, PHY_DLLDL_CNFG_SLV_INPSEL),
>>> -		     PHY_DLLDL_CNFG_R);
>>> +	if (host->flags & SDHCI_SIGNALING_180 || priv->flags & FLAG_IO_FIXED_1V8)
>>> +		sdhci_writeb(host, FIELD_PREP(PHY_DLLDL_CNFG_SLV_INPSEL_MASK,
>>> +					PHY_DLLDL_CNFG_SLV_INPSEL), PHY_DLLDL_CNFG_R);
>>
>> Perhaps slightly more readable to use a variable e.g.
> 
> Okay. I will update. It was kept the previous code.
> 
> Best Regards,
> Jaehoon Chung
> 
>>
>> 	/* enable data strobe mode */
>> 	if (???) {
>> 		u8 sel = FIELD_PREP(PHY_DLLDL_CNFG_SLV_INPSEL_MASK, PHY_DLLDL_CNFG_SLV_INPSEL);
>>
>> 		sdhci_writeb(host, sel, PHY_DLLDL_CNFG_R);
>> 	}
>>
>>>
>>>  	/* enable phy dll */
>>>  	sdhci_writeb(host, PHY_DLL_CTRL_ENABLE, PHY_DLL_CTRL_R);
>>> -}
>>> -
>>> -static void dwcmshc_phy_3_3v_init(struct sdhci_host *host)
>>> -{
>>> -	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>> -	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
>>> -	u32 val;
>>> -
>>> -	/* deassert phy reset & set tx drive strength */
>>> -	val = PHY_CNFG_RSTN_DEASSERT;
>>> -	val |= FIELD_PREP(PHY_CNFG_PAD_SP_MASK, PHY_CNFG_PAD_SP);
>>> -	val |= FIELD_PREP(PHY_CNFG_PAD_SN_MASK, PHY_CNFG_PAD_SN);
>>> -	sdhci_writel(host, val, PHY_CNFG_R);
>>> -
>>> -	/* disable delay line */
>>> -	sdhci_writeb(host, PHY_SDCLKDL_CNFG_UPDATE, PHY_SDCLKDL_CNFG_R);
>>> -
>>> -	/* set delay line */
>>> -	sdhci_writeb(host, priv->delay_line, PHY_SDCLKDL_DC_R);
>>> -	sdhci_writeb(host, PHY_DLL_CNFG2_JUMPSTEP, PHY_DLL_CNFG2_R);
>>> -
>>> -	/* enable delay lane */
>>> -	val = sdhci_readb(host, PHY_SDCLKDL_CNFG_R);
>>> -	val &= ~(PHY_SDCLKDL_CNFG_UPDATE);
>>> -	sdhci_writeb(host, val, PHY_SDCLKDL_CNFG_R);
>>> -
>>> -	/* configure phy pads */
>>> -	val = PHY_PAD_RXSEL_3V3;
>>> -	val |= FIELD_PREP(PHY_PAD_WEAKPULL_MASK, PHY_PAD_WEAKPULL_PULLUP);
>>> -	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CTRL_P);
>>> -	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N);
>>> -	sdhci_writew(host, val, PHY_CMDPAD_CNFG_R);
>>> -	sdhci_writew(host, val, PHY_DATAPAD_CNFG_R);
>>> -	sdhci_writew(host, val, PHY_RSTNPAD_CNFG_R);
>>> -
>>> -	val = FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CTRL_P);
>>> -	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N);
>>> -	sdhci_writew(host, val, PHY_CLKPAD_CNFG_R);
>>> -
>>> -	val = PHY_PAD_RXSEL_3V3;
>>> -	val |= FIELD_PREP(PHY_PAD_WEAKPULL_MASK, PHY_PAD_WEAKPULL_PULLDOWN);
>>> -	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_P_MASK, PHY_PAD_TXSLEW_CTRL_P);
>>> -	val |= FIELD_PREP(PHY_PAD_TXSLEW_CTRL_N_MASK, PHY_PAD_TXSLEW_CTRL_N);
>>> -	sdhci_writew(host, val, PHY_STBPAD_CNFG_R);
>>>
>>> -	/* enable phy dll */
>>> -	sdhci_writeb(host, PHY_DLL_CTRL_ENABLE, PHY_DLL_CTRL_R);
>>>  }
>>>
>>>  static void th1520_sdhci_set_phy(struct sdhci_host *host)
>>> @@ -433,11 +392,7 @@ static void th1520_sdhci_set_phy(struct sdhci_host *host)
>>>  	u32 emmc_caps = MMC_CAP2_NO_SD | MMC_CAP2_NO_SDIO;
>>>  	u16 emmc_ctrl;
>>>
>>> -	/* Before power on, set PHY configs */
>>> -	if (priv->flags & FLAG_IO_FIXED_1V8)
>>> -		dwcmshc_phy_1_8v_init(host);
>>> -	else
>>> -		dwcmshc_phy_3_3v_init(host);
>>> +	dwcmshc_phy_init(host);
>>>
>>>  	if ((host->mmc->caps2 & emmc_caps) == emmc_caps) {
>>>  		emmc_ctrl = sdhci_readw(host, priv->vendor_specific_area1 + DWCMSHC_EMMC_CONTROL);
>>> @@ -1163,7 +1118,7 @@ static const struct sdhci_ops sdhci_dwcmshc_th1520_ops = {
>>>  	.get_max_clock		= dwcmshc_get_max_clock,
>>>  	.reset			= th1520_sdhci_reset,
>>>  	.adma_write_desc	= dwcmshc_adma_write_desc,
>>> -	.voltage_switch		= dwcmshc_phy_1_8v_init,
>>> +	.voltage_switch		= dwcmshc_phy_init,
>>>  	.platform_execute_tuning = th1520_execute_tuning,
>>>  };
>>>
> 
> 
> 

