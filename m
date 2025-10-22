Received: from mail-m3278.qiye.163.com (mail-m3278.qiye.163.com [220.197.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7CE1E0DFE
	for <linux-mmc@vger.kernel.org>; Wed, 22 Oct 2025 00:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761093908; cv=none; b=arjV9qPUAbaLAOR20rsYCUAAXzeA8bcn82RiAPvttSV1McvXXpuBWiAFrqbJtPlRscre/K2WzSuYetkHCWXh2UHBXe7IS15bb6KPgOngxqbedep8hg/jP5oI6/wBnvK8O/yohc3trLnRI0czMfSvmRNriqhNKpMR/Ayb4EV9Fdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761093908; c=relaxed/simple;
	bh=Dqfvos4lbXbNvafZ15q/VZq27hl/rmJxoZ0rzrP4gFQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UyT1hx4D6UA95bXNN3FagLPLC721/n7hPtAZjXdQEg3ri3lPCiwTZZysJUuUg06LL2yTBZ/IByFRTMaU6MsOvEgNmrDdmU2azrwlxHgdNGf/9Anb1hjfhiSYEvbuZjV7L4MmwrJA04XNf+o7AozThl5MF+ffbNDO+WboLIi9XWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=H6SDK0mk; arc=none smtp.client-ip=220.197.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="H6SDK0mk"
Received: from [172.16.12.129] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 26b656875;
	Wed, 22 Oct 2025 08:39:53 +0800 (GMT+08:00)
Message-ID: <7a1e7da3-226a-4ee9-a3f8-fa4051f833ad@rock-chips.com>
Date: Wed, 22 Oct 2025 08:39:49 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Adrian Hunter <adrian.hunter@intel.com>,
 linux-rockchip@lists.infradead.org, linux-mmc@vger.kernel.org,
 Hugh Cole-Baker <sigmaris@gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-dwcmshc: Change DLL_STRBIN_TAPNUM_DEFAULT
 to 0x4
To: Dragan Simic <dsimic@manjaro.org>, Ulf Hansson <ulf.hansson@linaro.org>
References: <1760924981-52339-1-git-send-email-shawn.lin@rock-chips.com>
 <1066e578-f543-4233-b556-ae458c9327a1@gmail.com>
 <84a6b292-868d-c202-6e60-28f21390cc09@manjaro.org>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <84a6b292-868d-c202-6e60-28f21390cc09@manjaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a095ba8b909cckunm7b21616170c274
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUlIQlZNH09JShpDHkgdTk5WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=H6SDK0mkxM20sW3T7dPYlGrULNknEI0veGQeZIlyUo1MxbT1s4Nal1aF1cnSW5UiArz9AxXLiPpf051zbe74L6jmhFdzDTsV2sLfOd5sXXQaxXvGjBJ0/UZ4X2KmXQ4hUu09GfSiO6hvyA/ViyVCBsUNn9b/yHLkneZEHub9+5Y=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=MhuVrIb5PU98+HkpNJ24nNLmeJaLKAXov2SZm29nDKU=;
	h=date:mime-version:subject:message-id:from;


在 2025/10/22 星期三 4:24, Dragan Simic 写道:
> Hello Hugh and Shawn.
> 
> On Tuesday, October 21, 2025 22:04 CEST, Hugh Cole-Baker <sigmaris@gmail.com> wrote:
>> On 20/10/2025 02:49, Shawn Lin wrote:
>>> strbin signal delay under 0x8 configuration is not stable after massive
>>> test. The recommandation of it should be 0x4.
>>>
>>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>>> ---
>>>
>>>   drivers/mmc/host/sdhci-of-dwcmshc.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
>>> index eebd453..5b61401 100644
>>> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
>>> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
>>> @@ -94,7 +94,7 @@
>>>   #define DLL_TXCLK_TAPNUM_DEFAULT	0x10
>>>   #define DLL_TXCLK_TAPNUM_90_DEGREES	0xA
>>>   #define DLL_TXCLK_TAPNUM_FROM_SW	BIT(24)
>>> -#define DLL_STRBIN_TAPNUM_DEFAULT	0x8
>>> +#define DLL_STRBIN_TAPNUM_DEFAULT	0x4
>>>   #define DLL_STRBIN_TAPNUM_FROM_SW	BIT(24)
>>>   #define DLL_STRBIN_DELAY_NUM_SEL	BIT(26)
>>>   #define DLL_STRBIN_DELAY_NUM_OFFSET	16
>>
>> This patch gets the Foresee A3A444 eMMC on my NanoPC-T6 board to work reliably
>> in HS400 Enhanced Strobe mode; before this patch it would suffer from I/O
>> errors in HS400 mode as discussed in the other thread [1].
>>
>> Tested-by: Hugh Cole-Baker <sigmaris@gmail.com>

Thanks for testing and comfirming it works as expected.
I think this patch also need to be backported. So Ulf,
could you please help add fixes tag if the patch looks good
to you, to avoid a v2 just for adding this. :)

Fixes: 08f3dff799d4 ("mmc: sdhci-of-dwcmshc: add rockchip platform 
support")

> 
> Those are great results, thanks for the testing, Hugh!  Of course,
> huge thanks to Shawn for fixing the root cause of the issue, which
> avoided the need for having a questionable HS200 quirk described
> in the above-mentioned linux-rockchip thread. [1]
> 
>> [1]: https://lore.kernel.org/linux-rockchip/52537005-b8a3-c202-770c-599efc6a4d17@manjaro.org/T/
> 
> 

