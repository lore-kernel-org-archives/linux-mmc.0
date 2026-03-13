Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAE033D6EF
	for <linux-mmc@vger.kernel.org>; Fri, 13 Mar 2026 02:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773367882; cv=none; b=mXP4RFAApMqTwfKXB0HyNZX6nC5FawYjt+JYEcnOekYnxdY7f2rCAs21AzANUGxYeR5KL0u7zcKjeF5YN+NlSeH11vzsKivDFDiIbjXkEZuUv6oOR4eb7KPWiHR3uuWBrU3oz87GyTxbPScBu9xTY76oNzqz34WI9J4gJ3PprNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773367882; c=relaxed/simple;
	bh=RSpI5mgb1yoUxUO+9x3NR4eORKKeMfGrKutMKIfftTY=;
	h=Cc:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Z4zBEa0Jozl9pABJmo+4qaAymx8oWti4czbGrwttYYH1O/8PCDWTd52gpYhcZ/QlvmUOOnfCeizlHcWV36LdGPjgQpyNIue/O+tUU9PrA3iEl2BDYQfPedm+6Om/IyaLeMv7nI1IQsaPZ7dE33tfIaFV0qq0u0ZkVA1Yx2nBpzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NqNZ/fYv; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NqNZ/fYv"
Cc: shawn.lin@linux.dev, "robh@kernel.org" <robh@kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773367868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HuEhyZFpP+9EK3OXp1onxc8W2xg/K2y8UAgguHKPX0E=;
	b=NqNZ/fYv+xvZT/gjAl6Ka4iEzhJZ8tDjSJEtC872cedyGjDQmPxwzYbOnqgvD7fVogaJDl
	B04jVkwM+f3SsNXmyd1YDqEChXcbDRuuJ1y7y+USCgicrTvOJZ+hSk8BLfbBJ/ab5PiYdO
	AUGJqoY/8KqBUPTv95IMbM28VcfjHsA=
Subject: Re: [PATCH v3 2/2] mmc: sdhci-of-dwcmshc: Add HPE GSC eMMC support
To: "Hawkins, Nick" <nick.hawkins@hpe.com>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
 "jszhang@kernel.org" <jszhang@kernel.org>
References: <20260311181112.1700667-1-nick.hawkins@hpe.com>
 <20260311181112.1700667-3-nick.hawkins@hpe.com>
 <c4271da0-87c9-d7c2-db46-e7ed7f5e4fdf@linux.dev>
 <DM4PR84MB19274AAA6B344A850A1824958844A@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shawn Lin <shawn.lin@linux.dev>
Message-ID: <76c61887-8e75-15cd-73f7-bbe3ea859472@linux.dev>
Date: Fri, 13 Mar 2026 10:10:53 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <DM4PR84MB19274AAA6B344A850A1824958844A@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2026/03/13 星期五 3:25, Hawkins, Nick 写道:
> Hi Shawn, thank you for your input.
> 
> See below:
> 
>> -----Original Message-----
>> From: Shawn Lin <shawn.lin@linux.dev>
>> Sent: Thursday, March 12, 2026 3:25 AM
>> To: Hawkins, Nick <nick.hawkins@hpe.com>; ulf.hansson@linaro.org; adrian.hunter@intel.com; jszhang@kernel.org
>> Cc: shawn.lin@linux.dev; robh@kernel.org; krzk+dt@kernel.org; conor+dt@kernel.org; shawn.lin@rock-chips.com; linux-mmc@vger.kernel.org; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH v3 2/2] mmc: sdhci-of-dwcmshc: Add HPE GSC eMMC support
> 
> 
>>> +static int dwcmshc_hpe_gsc_init(struct device *dev, struct sdhci_host *host,
>>> +				struct dwcmshc_priv *dwc_priv)
>>> +{
>>> +	struct regmap *soc_ctrl;
>>> +	int ret;
>>> +
>>> +	/* Disable cmd conflict check and configure auto-tuning */
>>> +	dwcmshc_hpe_vendor_specific(host);
>>> +
>>> +	/* Look up the GXP sysreg syscon for MSHCCS access */
>>> +	soc_ctrl = syscon_regmap_lookup_by_phandle(dev->of_node, "hpe,gxp-sysreg");
>>> +	if (IS_ERR(soc_ctrl)) {
>>> +		dev_err(dev, "failed to get hpe,gxp-sysreg syscon\n");
>>> +		return PTR_ERR(soc_ctrl);
>>> +	}
>>> +
>>> +	/* Set SCGSyncDis (bit 18) to disable sync on HS200 RX delay lines */
>>> +	ret = regmap_update_bits(soc_ctrl, HPE_GSC_MSHCCS_OFFSET,
>>> +				HPE_GSC_MSHCCS_SCGSYNCDIS,
>>> +				HPE_GSC_MSHCCS_SCGSYNCDIS);
>>> +	if (ret) {
>>> +		dev_err(dev, "failed to set SCGSyncDis in MSHCCS\n");
>>> +		return ret;
>>> +	}
>>> +
>>> +	sdhci_enable_v4_mode(host);
> 
>> Sorry, I overlooked this part when in v2. But we enable it in
>> dwcmshc_probe() based on the capabilities, isn't it? Unless your
>> hardware didn't set SDHCI_CAN_64BIT_V4 but actually it does support
>> it? Then it perhaps should be a quirk, although we in general would like
>> to avoid more quirks... It depends on Adrian.
> 
>> Btw, unlated to your patch, but th1520 did it the same way... Hmm
> 
> The GSC's IP is configured with a 32-bit DMA AXI
> interface, so SDHCI_CAN_64BIT_V4 (caps bit 27) is not set by the
> hardware. However, the controller still requires Host V4 mode
> (HOST_CTRL2_R bit 12) to be enabled. Since dwcmshc_probe()
> only calls sdhci_enable_v4_mode() when SDHCI_CAN_64BIT_V4
> is set, the explicit call in dwcmshc_hpe_gsc_init() is necessary.

Okay, this aligns with previous assumption. So, we should either handle 
it via a quirk in the probe function and remove the call here, or simply 
add a comment to explain the context. This depends on Adrian's 
preference. I have no further questions. Thanks

> 
> Thanks,
> 
> -Nick H
> 
> 
>   
> 
