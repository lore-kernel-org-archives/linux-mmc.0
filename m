Received: from mail-m3274.qiye.163.com (mail-m3274.qiye.163.com [220.197.32.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125CD238D52
	for <linux-mmc@vger.kernel.org>; Tue, 21 Oct 2025 11:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761047995; cv=none; b=tCNC4DlJhtpJrIvNi2YPeavj0dqsuReZipm0xyE3ZOzVGP3WG0F3A2dHLSIhTXL+10gCVxMuMkUc3KqADmF+qO/6QvaPpBngK6Q2upyAe2dn0NsFD3915CDVBXsIfQb7oc3BRMfukuOC5LVgmY0YzA6glM5+vMTY5pn7zVPKeig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761047995; c=relaxed/simple;
	bh=Qv+crT7u+WpTvIftDisfEcmp0w9YwTRsUxqqbADtLTI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=B+jIOY+kxF4Yp+DFxmP3IRkb3H+ibO5HYgz1FKLrNntthxNDBFSI535UGHWi+0vJ3+vpfRT8gXbKiWGiH9vkO6mCulZDj5w1fT56Kr22v5X3O62ztGy/v2kWP1NsEQ5TKRSGuCKhCGW/OHNQchhHUC5O9IiYX0OAq7v5VL3nB6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=KJxUVaek; arc=none smtp.client-ip=220.197.32.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="KJxUVaek"
Received: from [172.16.12.129] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 26aa4dd4d;
	Tue, 21 Oct 2025 19:59:48 +0800 (GMT+08:00)
Message-ID: <15d92d15-6c48-40ca-bae4-5d08ed2e60b8@rock-chips.com>
Date: Tue, 21 Oct 2025 19:59:46 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Adrian Hunter <adrian.hunter@intel.com>,
 linux-rockchip@lists.infradead.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH] mmc: sdhci-of-dwcmshc: Change DLL_STRBIN_TAPNUM_DEFAULT
 to 0x4
To: Ulf Hansson <ulf.hansson@linaro.org>
References: <1760924981-52339-1-git-send-email-shawn.lin@rock-chips.com>
 <CAPDyKFoKZTcFsLvtWqqXsxDmDZpSg2jvAw=U8xn56vzKFSiXag@mail.gmail.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <CAPDyKFoKZTcFsLvtWqqXsxDmDZpSg2jvAw=U8xn56vzKFSiXag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a06a3c8f209cckunm80246634699b03
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0gdH1ZJTR0aShlMGEpPHhpWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=KJxUVaek3O1yZHxSuTnafUH+h+4htjGBjF70g+rlxvusNvGZa64yTqtHKcR6FstJYpe1pxBMh9KbtrHbxxj5/7QmBKJrn9ojw0fTBOsi+02a5dOMDuoDECDPTSpx+TTJsRjNvOYLV8sYe2lIe7fbYzRc1i2+FadUHGP2A/yCTuM=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=cvrw4pJc2J92Y+nymL28QbdmQxOGzCdHFwATQ2Xx/Tc=;
	h=date:mime-version:subject:message-id:from;

在 2025/10/21 星期二 18:18, Ulf Hansson 写道:
> On Mon, 20 Oct 2025 at 03:50, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>>
>> strbin signal delay under 0x8 configuration is not stable after massive
>> test. The recommandation of it should be 0x4.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
> Do we need a fixes/stable-tag here too?
> 

Yes, we do.

Fixes: 08f3dff799d4 ("mmc: sdhci-of-dwcmshc: add rockchip platform support")

But I'd like to hold it for a while as I asked some other folks to test
this patch asap too . So let's wait to see if it also solves their
problems.

> Kind regards
> Uffe
> 
>> ---
>>
>>   drivers/mmc/host/sdhci-of-dwcmshc.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
>> index eebd453..5b61401 100644
>> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
>> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
>> @@ -94,7 +94,7 @@
>>   #define DLL_TXCLK_TAPNUM_DEFAULT       0x10
>>   #define DLL_TXCLK_TAPNUM_90_DEGREES    0xA
>>   #define DLL_TXCLK_TAPNUM_FROM_SW       BIT(24)
>> -#define DLL_STRBIN_TAPNUM_DEFAULT      0x8
>> +#define DLL_STRBIN_TAPNUM_DEFAULT      0x4
>>   #define DLL_STRBIN_TAPNUM_FROM_SW      BIT(24)
>>   #define DLL_STRBIN_DELAY_NUM_SEL       BIT(26)
>>   #define DLL_STRBIN_DELAY_NUM_OFFSET    16
>> --
>> 2.7.4
>>
>>
> 

