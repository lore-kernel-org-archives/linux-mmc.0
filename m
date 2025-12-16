Received: from mail-m1973171.qiye.163.com (mail-m1973171.qiye.163.com [220.197.31.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885023570B1
	for <linux-mmc@vger.kernel.org>; Tue, 16 Dec 2025 12:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765886551; cv=none; b=TmZFLz760P9cNsC5wBeof617yneFLJs6/sXy47Q68TxtgePu5pvTYJvTwElGkgJ82R7YZvlowar5P8L6QirbPvmO7QIlbnLRyR8OaUta15ZRUWTRibzShrLqeJzBTmR9vZUnao5VrgtvLezGHD4yjXOzxhot1wjHgz/k8U13awI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765886551; c=relaxed/simple;
	bh=tdGRGx3EdoCIdpK6F7HHHORXIqehWNgiMoT6I9tGX2o=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=V89AJWZhrRr29RzCHA/XR8WxKN6uTomnH5RxrwecO39boW587a7sf6Dv5TQvZQCHUM4rT+j8JpX9l8DPvpUXwKDkGmttQtSa4kUk/bKChUR/k/9m85obpH6WXyGJax6GXz0+r5rhdw1c9fcG7vdrVYZyvm7cj+jCiTjgpRZXyCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=gibNTtGu; arc=none smtp.client-ip=220.197.31.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="gibNTtGu"
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2d591aa76;
	Tue, 16 Dec 2025 09:52:19 +0800 (GMT+08:00)
Message-ID: <f3b2252c-45c4-4dd2-a211-5a720c59fd5c@rock-chips.com>
Date: Tue, 16 Dec 2025 09:52:18 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org,
 Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2 03/13] mmc: dw_mmc: Remove vqmmc_enabled from struct
 dw_mci and user helpers from core
To: Ulf Hansson <ulf.hansson@linaro.org>
References: <1764116093-5430-1-git-send-email-shawn.lin@rock-chips.com>
 <1764116093-5430-4-git-send-email-shawn.lin@rock-chips.com>
 <CAPDyKFq8EzMtCVnmXvwMuH9f46ii9HN8wFurMRAYMzpMa+Cyxw@mail.gmail.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <CAPDyKFq8EzMtCVnmXvwMuH9f46ii9HN8wFurMRAYMzpMa+Cyxw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9b24dbbc8e09cckunmadbd3f0b386262
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkNKS1ZKTE1PSR0YGB1MSB9WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=gibNTtGuqtnKV09N+uuoUSV0xFAOJvavkkZyZ0EYp4nISw20U+jpC5Ph6CdvMCYwtcVJeODZcvmwa9zcjQTlncImJBETAK/sKoiCoEXkcZnctyQWvp71noh2BtPOwYdhyDIFCqLlq1GIj8fKQE1p0ekaMVyzVCwJfTQhZ179T3I=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=FklxjSfYD0dPbFpleQoAYLT8tFyBvyEtxKtbeOUGS4A=;
	h=date:mime-version:subject:message-id:from;

Hi Ulf,

在 2025/12/15 星期一 22:30, Ulf Hansson 写道:
> On Wed, 26 Nov 2025 at 01:16, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>>
>> commit 51da2240906c ("mmc: dw_mmc: use mmc_regulator_get_supply to handle regulators")
>> introduced tracking of vqmmc_enabled. Currently, mmc_regulator_enable_vqmmc() and
>> mmc_regulator_disable_vqmmc() well record the status of vqmmc, so use these two helpers
>> to remove vqmmc_enabled locally. And also remove the if(!IS_ERR..) check before calling
>> mmc_regulator_set_ocr() as mmc_regulator_set_ocr() already checks if vqmmc is correct.
>>
>> This patch is tested on RK3588s EVB1 with TF cards with both vqmmc present or not.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> ---
>>
>> Changes in v2:
>> - Use helpers from regulator.c and remove check for mmc_regulator_set_ocr.
>>
>>   drivers/mmc/host/dw_mmc.c | 41 ++++++++++-------------------------------
>>   drivers/mmc/host/dw_mmc.h |  2 --
>>   2 files changed, 10 insertions(+), 33 deletions(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index 2d81d021..1c352d2 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -1424,15 +1424,12 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>
>>          switch (ios->power_mode) {
>>          case MMC_POWER_UP:
>> -               if (!IS_ERR(mmc->supply.vmmc)) {
>> -                       ret = mmc_regulator_set_ocr(mmc, mmc->supply.vmmc,
>> -                                       ios->vdd);
>> -                       if (ret) {
>> -                               dev_err(slot->host->dev,
>> -                                       "failed to enable vmmc regulator\n");
>> -                               /*return, if failed turn on vmmc*/
>> -                               return;
>> -                       }
>> +               ret = mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, ios->vdd);
>> +               if (ret) {
>> +                       dev_err(slot->host->dev,
>> +                               "failed to enable vmmc regulator\n");
>> +                       /*return, if failed turn on vmmc*/
>> +                       return;
>>                  }
> 
> Perhaps make the above a separate change? It seems independent of the
> changes below, right?

Sure, will make it into a separate patch.

> 
>>                  set_bit(DW_MMC_CARD_NEED_INIT, &slot->flags);
>>                  regs = mci_readl(slot->host, PWREN);
>> @@ -1440,25 +1437,7 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>                  mci_writel(slot->host, PWREN, regs);
>>                  break;
>>          case MMC_POWER_ON:
>> -               if (!slot->host->vqmmc_enabled) {
>> -                       if (!IS_ERR(mmc->supply.vqmmc)) {
>> -                               ret = regulator_enable(mmc->supply.vqmmc);
>> -                               if (ret < 0)
>> -                                       dev_err(slot->host->dev,
>> -                                               "failed to enable vqmmc\n");
>> -                               else
>> -                                       slot->host->vqmmc_enabled = true;
>> -
>> -                       } else {
>> -                               /* Keep track so we don't reset again */
>> -                               slot->host->vqmmc_enabled = true;
>> -                       }
>> -
>> -                       /* Reset our state machine after powering on */
>> -                       dw_mci_ctrl_reset(slot->host,
>> -                                         SDMMC_CTRL_ALL_RESET_FLAGS);
>> -               }
>> -
>> +               mmc_regulator_enable_vqmmc(mmc);
>>                  /* Adjust clock / bus width after power is up */
>>                  dw_mci_setup_bus(slot, false);
>>
>> @@ -1470,13 +1449,13 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>                  if (!IS_ERR(mmc->supply.vmmc))
>>                          mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
>>
>> -               if (!IS_ERR(mmc->supply.vqmmc) && slot->host->vqmmc_enabled)
>> -                       regulator_disable(mmc->supply.vqmmc);
>> -               slot->host->vqmmc_enabled = false;
>> +               mmc_regulator_disable_vqmmc(mmc);
>>
>>                  regs = mci_readl(slot->host, PWREN);
>>                  regs &= ~(1 << slot->id);
>>                  mci_writel(slot->host, PWREN, regs);
>> +               /* Reset our state machine after powering off */
>> +               dw_mci_ctrl_reset(slot->host, SDMMC_CTRL_ALL_RESET_FLAGS);
> 
> Previously this was done together with enabling the vqmmc, a few lines
> above. The corresponding code was introduced in commit d1f1dd86006c
> "mmc: dw_mmc: Give a good reset after we give power". It's not exactly
> clear why the reset is needed at this particular point though.
> 
> That said, at least we need to mention that we are moving the reset to
> the power-off phase and explain why in the commit message. Perhaps
> even better would be to preserve the old behaviour in the first step
> and then make this change being separate on top? Not sure if that
> makes sense though.

That doesn't work once we remove tracking of vqmmc status, because it
will reset several times when enumerating, which mess up the IP status
machine. That said, preserving the old behaviour breaks the bisectable.

The commit introduced this, is to slove failures on rk3288. The commit
message said "vqmmc may actually be connected to the IP block in the SoC
vqmmc may actually be connected to the IP block in the SoC" which
doesn't clearly point out the fact is vqmmc is used for IO block
associated with dw controller only . The reason is probably that when SD
is removed during I/O, cutting off vqmmc in MMC_POWER_OFF phase will
confuse the controller as its status machine refers to several IO 
status, such as MC busy, so the controller could run into an unexpected
state and could not enumerate cards correctly the next time. I vaguely
remember​ there was a gap between Doug upstreamed it and Rockchip
downstream kernel reset it on card-removal path. So I think either to
reset it on MMC_POWER_ON phase or to reset it on MMC_POWER_OFF phase
should work. I would keep it and explain that in commit message. Does 
this approach sound good to you?



> 
>>                  break;
>>          default:
>>                  break;
>> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
>> index b4ceca0..6faa63b 100644
>> --- a/drivers/mmc/host/dw_mmc.h
>> +++ b/drivers/mmc/host/dw_mmc.h
>> @@ -121,7 +121,6 @@ struct dw_mci_dma_slave {
>>    * @push_data: Pointer to FIFO push function.
>>    * @pull_data: Pointer to FIFO pull function.
>>    * @quirks: Set of quirks that apply to specific versions of the IP.
>> - * @vqmmc_enabled: Status of vqmmc, should be true or false.
>>    * @irq_flags: The flags to be passed to request_irq.
>>    * @irq: The irq value to be passed to request_irq.
>>    * @sdio_id0: Number of slot0 in the SDIO interrupt registers.
>> @@ -228,7 +227,6 @@ struct dw_mci {
>>          void (*pull_data)(struct dw_mci *host, void *buf, int cnt);
>>
>>          u32                     quirks;
>> -       bool                    vqmmc_enabled;
>>          unsigned long           irq_flags; /* IRQ flags */
>>          int                     irq;
>>
>> --
>> 2.7.4
>>
> 
> Kind regards
> Uffe
> 

