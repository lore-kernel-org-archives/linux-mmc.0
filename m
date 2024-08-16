Received: from mail-m12818.netease.com (mail-m12818.netease.com [103.209.128.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EAFB647;
	Fri, 16 Aug 2024 00:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.209.128.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723769993; cv=none; b=W0EfTPEdXluofww3xKI5vJjdFeCbPnRqccapDoLFG/K6T2oYn1rxlc6qymoO/0ai8cfAKogPj4T06kuVr1vB2NVPoQ5gTeKzYo4oifQWy0Dd/knb8fJ0Ytoys7sfAqAFyBjzGHI4I5VuwvtIMVu+7/3mteYnfqwxb0j5/H72F9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723769993; c=relaxed/simple;
	bh=XwerIgFAHBD+vtSqyfGLdrUSAg9gAWh6kuP/68feRGw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HwfHmiVAgn5R3Z1fUAv2sG8ulhT7XemZ/+CXlZ7gpII0E93MvUaSEFXCtJCX7zuJdfz1I5pC0z3+LKYyxOtxbAnxGb1BxPVtemIc0SD4sy8LoNxZ9LYOmLxJQ3iXkCfxxh9ekJ6TWWQ4E7nBLSPPo4c37pgtzliK2wKgagRuBe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=GkzPlGex; arc=none smtp.client-ip=103.209.128.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="GkzPlGex"
DKIM-Signature: a=rsa-sha256;
	b=GkzPlGexYR9mpFJHzYzoQkPk0Qui3j39k078hHjhz3E2/FF8QFws9/w9CFsYwMj+L1D5FtMQQMaU03vbG16Dyz3Ottual4Ym9JDQa4CommpbGI+/l6hYDRl0GtZrRCgntsPXyBs2cuHCuu8iEjR1d2qVpNzlNTAFYc4G7iDJl44=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=u2bY45nOuxIO29yl3xiZLYWOFNM2Z13NxlwmREOfWz8=;
	h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.45] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 5EE434601F5;
	Fri, 16 Aug 2024 08:41:59 +0800 (CST)
Message-ID: <87304544-b223-4825-86a3-d0fd9eff0afe@rock-chips.com>
Date: Fri, 16 Aug 2024 08:41:59 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Ulf Hansson <ulf.hansson@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>,
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 kernel@collabora.com
Subject: Re: [PATCH v3 2/3] mmc: dw_mmc-rockchip: Add v2 tuning support
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Detlev Casanova <detlev.casanova@collabora.com>, linux-kernel@vger.kernel.org
References: <20240814223555.3695-1-detlev.casanova@collabora.com>
 <20240814223555.3695-3-detlev.casanova@collabora.com>
 <5dc82aa2-82a0-4778-b598-88775d5f791c@rock-chips.com>
 <18146801.MNNF8PUAaN@diego>
Content-Language: en-GB
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <18146801.MNNF8PUAaN@diego>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUpMSlZMSU9DQx4eTRlNTh9WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a9158a258f203aekunm5ee434601f5
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NBQ6Hjo4AjIwKDorGDZMARYS
	LzFPCUtVSlVKTElITE1DQklLTEJIVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQU9KSEI3Bg++

Hi Heiko,

在 2024/8/15 21:17, Heiko Stübner 写道:
> Am Donnerstag, 15. August 2024, 02:55:37 CEST schrieb Shawn Lin:
>> Hi Detlev
>>
>> 在 2024/8/15 6:34, Detlev Casanova 写道:
>>> From: Shawn Lin <shawn.lin@rock-chips.com>
>>>
>>> v2 tuning will inherit pre-stage loader's phase settings for the first
>>> time, and do re-tune if necessary.
>>> Re-tune will still try the rough degrees, for instance, 90, 180, 270,
>>> 360 but continue to do the fine tuning if sample window isn't good
>>> enough.
>>>
>>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>>> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> 
>>> @@ -277,6 +322,10 @@ static int dw_mci_rk3288_parse_dt(struct dw_mci *host)
>>>    					&priv->default_sample_phase))
>>>    		priv->default_sample_phase = 0;
>>>    
>>> +	priv->use_v2_tuning =
>>> +		of_device_is_compatible(host->dev->of_node,
>>> +					"rockchip,rk3576-dw-mshc");
>>> +
>>
>> v2 is a kind of software decision instead of hardware dependency.
>> So in theory, any SoC can claim to use it via DT.
> 
> which actually makes it unsuitable for dt. >

Understood.

> Devicetree describes hardware-properties and should _not_ be used for
> software configuration.
> 
>  From the comment above, I assume the rk3576 does not need that feature
> and can just work with the regular tuning?

Yep, your are right.

> 
> So there are two routes for the immediate future:
> (1) rk3576 _needs_ that feature, then going with the compatible is fine
> 
> (2) rk3576 does not need absolutely need that feature, then I'd expect
> the basic rk3576 to first come without, as I'd expect a lot more explanation
> on why it is actually needed, and which cases it does improve.
> The commit message does not really explain that much about why this
> is a great/needed feature and which areas it does improve.
> 

Vote for the 2nd. rk3576 just need
[PATCH v3 3/3] mmc: dw_mmc-rockchip: Add internal phase support


> 
> Heiko
> 
> 
