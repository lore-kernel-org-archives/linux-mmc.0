Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CFB18560A;
	Wed, 10 Jul 2024 13:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720617514; cv=none; b=VL9nsMrsc/O/y1mLTD3to2yZnCF6R8YBqlk9tZrx6cIivT8awvxUEEa3Oc86tCsg+2GG/bi/xI/oX483ycSutYcMI8lc7KzdCQJ6JRqrgXKK9RsSgZof7vMx9tExlIP6FTdU4wGP5Hx3N8/oQdDbwqmg3tM4DprBKxt1Qef/C8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720617514; c=relaxed/simple;
	bh=Xn7qVGu2+Og/sESzeFPW+xXM33yfy6MRu9O9WvJxqmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uXevUtpxViTWRg124qugZaf+glO7xNPiHzHMJi8gC9/yA69IkF4M6JYsEYWaOfzn22jHsQYtR+Xv42YlOzS78bPV9kvn9lDQAnji14U2Pe8wVyASw/jbIepzDTothRR7abo6bRPZHSE3M2W4MKFSfgyVPZLubhnWSfidiuRWzYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EVWo1ydm; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EVWo1ydm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720617512; x=1752153512;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Xn7qVGu2+Og/sESzeFPW+xXM33yfy6MRu9O9WvJxqmQ=;
  b=EVWo1ydmh5VM7H37DKN6b/q/fCZVHM59/hAyGTeyeDN3Skeav0qM2QK/
   HLZKv6kzL9TgG6dxw4//ncCo9lO2ad4Wdtnbk7w9cfYg0ehGU8pIazT18
   EFv1tPCQgreKdhy6BhiF23Y9jBZ1EA89do4VhDM7ahR4hvOl0EFlp45tU
   YJwJq93ZwCyg4o4axZZu9qsxzX/s2G2u/dvZ9fauaxwYNg01cr60EE15v
   Xx5SJKuVwDhpSbFvW65mwavNXACLG3HY7CWhnTUbN1tsiQLboujLK+4wP
   6EiOdTs6Pr0w+dwQTZotvxWXvHBZqzHDiwnGR9YMIuAlb53MOFNJ712pC
   A==;
X-CSE-ConnectionGUID: 3DAXja3RTVKHOcaPA6nqXA==
X-CSE-MsgGUID: 5wrrmlXLQcG0/TcCjrpZvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="35471835"
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="35471835"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 06:18:31 -0700
X-CSE-ConnectionGUID: Bh9vM9kMSd2HfyPwpYBwRg==
X-CSE-MsgGUID: XNcAoN5JTF6g6wg3808MxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="52605703"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.49.253])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 06:18:28 -0700
Message-ID: <8b5bf7d6-8dfa-463b-a2ae-fa74a3e5ba73@intel.com>
Date: Wed, 10 Jul 2024 16:18:23 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] mmc: sdhci-esdhc-imx: obtain the 'per' clock rate
 after its enablement
To: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>,
 Haibo Chen <haibo.chen@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, s32@nxp.com
References: <20240708121018.246476-1-ciprianmarian.costea@oss.nxp.com>
 <20240708121018.246476-3-ciprianmarian.costea@oss.nxp.com>
 <dbd73f2b-54ab-4832-9610-a4bc70e3b9f2@intel.com>
 <7d851eb6-ef8e-480a-9b5a-8cb67d6adf8b@oss.nxp.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <7d851eb6-ef8e-480a-9b5a-8cb67d6adf8b@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/07/24 15:50, Ciprian Marian Costea wrote:
> On 7/10/2024 3:33 PM, Adrian Hunter wrote:
>> On 8/07/24 15:10, Ciprian Costea wrote:
>>> The I.MX SDHCI driver assumes that the frequency of the 'per' clock
>>> can be obtained even on disabled clocks, which is not always the case.
>>>
>>> According to 'clk_get_rate' documentation, it is only valid
>>> once the clock source has been enabled.
>>
>> The kerneldoc comment for clk_get_rate() says
>>
>>     Can be called regardless of the clock enabledness
>>
>> which sounds like the opposite.  Please clarify.
>>
> 
> Hello Adrian,
> 
> My observation was based on the following [1] 'clk_get_rate()' documentation.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/clk.h#n720
> 
> Best Regards,
> Ciprian

Yes, that is clear.

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> 
>>>
>>> Signed-off-by: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
>>> ---
>>>   drivers/mmc/host/sdhci-esdhc-imx.c | 8 +++++++-
>>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
>>> index 21d984a77be8..8f0bc6dca2b0 100644
>>> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
>>> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
>>> @@ -1709,7 +1709,6 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>>>       }
>>>         pltfm_host->clk = imx_data->clk_per;
>>> -    pltfm_host->clock = clk_get_rate(pltfm_host->clk);
>>>       err = clk_prepare_enable(imx_data->clk_per);
>>>       if (err)
>>>           goto free_sdhci;
>>> @@ -1720,6 +1719,13 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>>>       if (err)
>>>           goto disable_ipg_clk;
>>>   +    pltfm_host->clock = clk_get_rate(pltfm_host->clk);
>>> +    if (!pltfm_host->clock) {
>>> +        dev_err(mmc_dev(host->mmc), "could not get clk rate\n");
>>> +        err = -EINVAL;
>>> +        goto disable_ahb_clk;
>>> +    }
>>> +
>>>       imx_data->pinctrl = devm_pinctrl_get(&pdev->dev);
>>>       if (IS_ERR(imx_data->pinctrl))
>>>           dev_warn(mmc_dev(host->mmc), "could not get pinctrl\n");
>>
> 

