Received: from mail-m15590.qiye.163.com (mail-m15590.qiye.163.com [101.71.155.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AB114B96E
	for <linux-mmc@vger.kernel.org>; Wed, 12 Nov 2025 00:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762908627; cv=none; b=kX3x4e/iIcS2w2u3gYle7KZCUTusL9zb4VZKO53BMWafz8RnmuF8nReuJgYeatOnyQ1i4V60JJxBZY2zv9G76FwI/B8DHKYOW4hITzhJsdH44/9h+d3qP31TRj+O7CuBXjm+MAoL57Htwru0H91FG3aYyMD1akiFcfZ59ODKKlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762908627; c=relaxed/simple;
	bh=VD2HQkDIoUwAlI5in2p7gYxjpZegdkYrHJ1uXTHYx+g=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=S5DF9cDAJuCBWexkQr1ad9JoM1sY5/rbDtBAfGYLjdTSSQTBCMEZjP0mwWcVesgkeLzht40pFoAr/Xlye/S2x6ULMd2+OvIX8cAVeUO5DtNtA4qqEHDU6+zPbdyhMibDfKg9NJ74A2ApmQPMBq47eJXhCiA3XTAb77Wu01EKyZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=PsQTZqQS; arc=none smtp.client-ip=101.71.155.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="PsQTZqQS"
Received: from [192.168.61.151] (unknown [110.83.51.2])
	by smtp.qiye.163.com (Hmail) with ESMTP id 293f3b332;
	Wed, 12 Nov 2025 08:45:07 +0800 (GMT+08:00)
Message-ID: <fcc9262c-5bd8-4f96-971c-c61ae8cbde69@rock-chips.com>
Date: Wed, 12 Nov 2025 08:45:03 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, linux-rockchip@lists.infradead.org,
 linux-mmc@vger.kernel.org
Subject: Re: [PATCH] mmc: dw_mmc-rockchip: Add memory clock auto-gating
 support
To: Ulf Hansson <ulf.hansson@linaro.org>
References: <1762242094-55346-1-git-send-email-shawn.lin@rock-chips.com>
 <CAPDyKFpLp--cn4T3ifL8zB=GqptHZtnRH+V8Z370LNsj7n3wNA@mail.gmail.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <CAPDyKFpLp--cn4T3ifL8zB=GqptHZtnRH+V8Z370LNsj7n3wNA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a7585ff7809cckunm76d3f66889b5b
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZSkpKVklLSkgdShgaGkNKGlYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSktVQ0hVTkpVSVlXWRYaDxIVHRRZQVlPS0hVSktJT09PSFVKS0tVSk
	JLS1kG
DKIM-Signature: a=rsa-sha256;
	b=PsQTZqQSj6zIF7BYo9SF9V8MSEx/vgmafUz9qE+hy+KkYq2i0wsj2Hx3HgWfhI6EccN5e0WObJIatfrXqVJxhsTDGQvYFDwjnK8F1oiYRIx3OoRrR7XGjgNexr8BdIjJ96RDA0KCy4weHovbZOW0JiPPKXNque6yFlWcvrIAJTs=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=73MhxFMtGE6PyMsXPLivPnSyiulfE+bRi+dlziNMDyU=;
	h=date:mime-version:subject:message-id:from;

在 2025/11/12 星期三 0:55, Ulf Hansson 写道:
> On Tue, 4 Nov 2025 at 08:41, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>>
>> Per design recommendations, the memory clock can be gated when there
>> is no in-flight transfer, which helps save power. This feature is
>> introduced alongside internal phase support, and this patch enables it.
> 
> Just to make sure, does this work if the controller is used for SDIO
> and has SDIO irqs enabled?
> 
> Or perhaps that is taken care of in dw_mci_prepare_sdio_irq()?
> 

Yes, it works for SDIO case too.

>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
> Kind regards
> Uffe
> 
>> ---
>>
>>   drivers/mmc/host/dw_mmc-rockchip.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
>> index 6813549..62c68cd 100644
>> --- a/drivers/mmc/host/dw_mmc-rockchip.c
>> +++ b/drivers/mmc/host/dw_mmc-rockchip.c
>> @@ -19,6 +19,8 @@
>>   #define RK3288_CLKGEN_DIV              2
>>   #define SDMMC_TIMING_CON0              0x130
>>   #define SDMMC_TIMING_CON1              0x134
>> +#define SDMMC_MISC_CON                 0x138
>> +#define MEM_CLK_AUTOGATE_ENABLE                BIT(5)
>>   #define ROCKCHIP_MMC_DELAY_SEL         BIT(10)
>>   #define ROCKCHIP_MMC_DEGREE_MASK       0x3
>>   #define ROCKCHIP_MMC_DEGREE_OFFSET     1
>> @@ -470,6 +472,7 @@ static int dw_mci_rk3576_parse_dt(struct dw_mci *host)
>>
>>   static int dw_mci_rockchip_init(struct dw_mci *host)
>>   {
>> +       struct dw_mci_rockchip_priv_data *priv = host->priv;
>>          int ret, i;
>>
>>          /* It is slot 8 on Rockchip SoCs */
>> @@ -494,6 +497,9 @@ static int dw_mci_rockchip_init(struct dw_mci *host)
>>                          dev_warn(host->dev, "no valid minimum freq: %d\n", ret);
>>          }
>>
>> +       if (priv->internal_phase)
>> +               mci_writel(host, MISC_CON, MEM_CLK_AUTOGATE_ENABLE);
>> +
>>          return 0;
>>   }
>>
>> --
>> 2.7.4
>>
> 

