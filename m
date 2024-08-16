Received: from mail-m127166.xmail.ntesmail.com (mail-m127166.xmail.ntesmail.com [115.236.127.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E677A13B286;
	Fri, 16 Aug 2024 08:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.236.127.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723798784; cv=none; b=HYqxLXGd+tMLU5QFoF2IbD5vPdyIOTy5TFXtHQShoaTpaT9T3Fr3chKOe+z6E4vm7RH3yAjjRq4bMOpl4r5CrjmzxfJmCNTgVCxVgcf7P0TWVnmwdWOj86QcllCDjOuluMOreVqK6Xq2mN7YoUpU/cFvP60ePsqEkjzzmBIQoFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723798784; c=relaxed/simple;
	bh=Xm3fx8Xa4ANe/iABtyTd5CMBETIZxfcy+1hfSJGJ0ys=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kMNhZ+1xUjqKzAjKQ+4ZOgnw5vG+1fkxv94UdEW21+dWNiRDhvRqMNO2hcLtni2/A2JAYXIyN2k41b+O2+w5Y5oVb1oI+vl52iMC3qPViIorE8eXJyGrrHnllZEd49gmDL9ihLKDGir24trLrYo2+fa5rZ840sXk8Cy4Zuj91Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=J1UE/ruN; arc=none smtp.client-ip=115.236.127.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="J1UE/ruN"
DKIM-Signature: a=rsa-sha256;
	b=J1UE/ruNV7QGyM0y41B5pMuLmVchxWYjJmDqZINeHWDXSansizu6IXSpjUkqLTeg0zS80Lun+gWCHGetcKil7Fke8S4LBE+E9/7vJnGaLhogGWazpVCLFnj7bym4QBZTzXHPIc/4FgWcBAQluFsWtl6xSPjbmdHvK2V2bcaruyA=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=iL3g7hzaLQ+rrYtLHSAvIW1379wSOIx3YsifSBddCrY=;
	h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.45] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTPA id E30FD4601FE;
	Fri, 16 Aug 2024 08:43:48 +0800 (CST)
Message-ID: <2517e284-88d0-4cf3-97cf-55567f35eb82@rock-chips.com>
Date: Fri, 16 Aug 2024 08:43:48 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Ulf Hansson <ulf.hansson@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v3 2/3] mmc: dw_mmc-rockchip: Add v2 tuning support
To: Detlev Casanova <detlev.casanova@collabora.com>,
 linux-kernel@vger.kernel.org
References: <20240814223555.3695-1-detlev.casanova@collabora.com>
 <20240814223555.3695-3-detlev.casanova@collabora.com>
 <5dc82aa2-82a0-4778-b598-88775d5f791c@rock-chips.com>
 <2742918.mvXUDI8C0e@trenzalore>
Content-Language: en-GB
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <2742918.mvXUDI8C0e@trenzalore>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkNMSVZPShlLSx5OGUMaTx9WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSE
	JVSktLVUpCS0tZBg++
X-HM-Tid: 0a9158a4051103aekunme30fd4601fe
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6KyI6OTo6CDIrSzoCNiktTFY#
	MVEKFA9VSlVKTElITE1CS0hLSENIVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUhCSE43Bg++

在 2024/8/15 21:23, Detlev Casanova 写道:
> On Wednesday, 14 August 2024 20:55:37 EDT Shawn Lin wrote:
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
>>> ---
>>>
>>>    drivers/mmc/host/dw_mmc-rockchip.c | 49 ++++++++++++++++++++++++++++++
>>>    1 file changed, 49 insertions(+)
>>>
>>> diff --git a/drivers/mmc/host/dw_mmc-rockchip.c
>>> b/drivers/mmc/host/dw_mmc-rockchip.c index b07190ba4b7ac..367633f4e8892
>>> 100644
>>> --- a/drivers/mmc/host/dw_mmc-rockchip.c
>>> +++ b/drivers/mmc/host/dw_mmc-rockchip.c
> 
> [...]
> 
>>>    		
>>>    		priv->default_sample_phase = 0;
>>>
>>> +	priv->use_v2_tuning =
>>> +		of_device_is_compatible(host->dev->of_node,
>>> +					"rockchip,rk3576-dw-
> mshc");
>>> +
>>
>> v2 is a kind of software decision instead of hardware dependency.
>> So in theory, any SoC can claim to use it via DT.
> 
> Yes but from my tests, only rk3576 won't work without it. So it makes sense to
> only use v2 for this SoC (and other future ones not supported yet)
> 

However from both of the IC design POV and the test from my side,
we just need internal phase support patch, and rk3576 could
work.

>>
>>>    	priv->drv_clk = devm_clk_get(host->dev, "ciu-drive");
>>>    	if (IS_ERR(priv->drv_clk))
>>>    	
>>>    		dev_dbg(host->dev, "ciu-drive not available\n");
> 
> 
> Detlev.
> 
> 
