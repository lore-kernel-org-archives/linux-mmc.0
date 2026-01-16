Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79BF284B3E
	for <linux-mmc@vger.kernel.org>; Fri, 16 Jan 2026 17:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768584358; cv=none; b=CC3FiIbj0sjzVzreqUh/FGI5x2hBXe8O1QSQbHn584yTFW3g9Vl7SVsVdUSoUe4v5jqWKVyuDzIZUoMK8okXzC2HchShwmaZ6MNt87FRJfo0rweyb+1Ab+NvRjKoxCGL9Pw0iln3WtDcHzqTz4jxru8Si8e3MpJSEzDY/alla5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768584358; c=relaxed/simple;
	bh=8tGtHxtwAhKePrcuqM7/GNAqYotG86BvGTahvc5QCQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UvldF/pmlLO1SV1fw1yQ9ST3/zp29IAIs1m8F8lizaeXpjTpDC7KFoW5Ny18R5xz2psbL/JjTAHYTSd/9FgnAroVbqN6UptGYmk+R7awiDKSvzl4Cmeki3tanUTTWv/W40rG5vPdJAZ9FTbhh3AcwxwBKRX24AqoyiQsz1UgElA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=P5OmPmGf; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="P5OmPmGf"
Message-ID: <d21955d1-afb3-4a72-bf69-b8e4b6ca2a70@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768584353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yr40KJp4jGbhVHTnJr9YxV6SDqCfpFZSsSPIT9pU+JM=;
	b=P5OmPmGfvMhOlYitVkrazNd0C8N4bZJQ4MFfrpJU7InPsXPsnlOj0c6QI38PZnEuWdosQy
	2X5kmkRa5/qJvjZZq5LIj49XeGqjwuXQmx0KRn+D232MmfjZOPn5G7/f5OUIgdrbBI4Vyu
	kFY89Kt4M9SBUYavyR3s7YqW0G5SvHw=
Date: Fri, 16 Jan 2026 09:24:53 -0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mmc: rtsx_pci_sdmmc: implement sdmmc_card_busy function
To: Ricky WU <ricky_wu@realtek.com>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20251229204526.2850803-1-matthew.schwartz@linux.dev>
 <220bd61b3ab743b492632764a38f95f0@realtek.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Matthew Schwartz <matthew.schwartz@linux.dev>
In-Reply-To: <220bd61b3ab743b492632764a38f95f0@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 1/15/26 2:23 AM, Ricky WU wrote:
> Hi Matthew,
> 
> Thanks for working on this patch.
> 
> We’ve tested this change on our platforms and can confirm that adding the
> card_busy() callback does resolve the
> “cannot verify signal voltage switch” issue for us 👍.
> 
> That said, while reviewing the change we noticed a potential redundancy in
> the existing driver logic. In sdmmc_switch_voltage() we already perform
> explicit DAT line stabilization checks via
> sd_wait_voltage_stable_1() and sd_wait_voltage_stable_2().
> 
> Once card_busy() is implemented and used by the MMC core during the
> voltage-switch verification phase, these two stabilization steps appear to
> be partially overlapping with what the core now validates via
> card_busy(). In our testing, with card_busy() present, the stable_1 /
> stable_2 logic no longer seems strictly necessary and could likely be
> simplified or removed with some adjustment.
> 
> From a process point of view, we’re not sure which approach you’d prefer:
> 
> Land your patch as-is first, and then we can follow up with a separate
> cleanup/modification patch to adjust sdmmc_switch_voltage(), or
> 
> We can prepare an additional patch that builds on top of yours and share
> it with you for review, so the changes can be aligned together.

Hi Ricky,

Let's go with this method.

Thanks!
Matt

> 
> Please let us know which option you think makes more sense for upstream, or
> if you’d prefer a different approach.
> 
> Thanks again for the fix and for looking into this driver.
> 
> Best regards,
> Ricky
> 
>> rtsx_pci_sdmmc does not have an sdmmc_card_busy function, so any voltage
>> switches cause a kernel warning, "mmc0: cannot verify signal voltage switch."
>>
>> Copy the sdmmc_card_busy function from rtsx_pci_usb to rtsx_pci_sdmmc to
>> fix this.
>>
>> Fixes: ff984e57d36e ("mmc: Add realtek pcie sdmmc host driver")
>> Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
>> ---
>>  drivers/mmc/host/rtsx_pci_sdmmc.c | 41
>> +++++++++++++++++++++++++++++++
>>  1 file changed, 41 insertions(+)
>>
>> diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c
>> b/drivers/mmc/host/rtsx_pci_sdmmc.c
>> index dc2587ff8519..4db3328f46df 100644
>> --- a/drivers/mmc/host/rtsx_pci_sdmmc.c
>> +++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
>> @@ -1306,6 +1306,46 @@ static int sdmmc_switch_voltage(struct mmc_host
>> *mmc, struct mmc_ios *ios)
>>         return err;
>>  }
>>
>> +static int sdmmc_card_busy(struct mmc_host *mmc) {
>> +       struct realtek_pci_sdmmc *host = mmc_priv(mmc);
>> +       struct rtsx_pcr *pcr = host->pcr;
>> +       int err;
>> +       u8 stat;
>> +       u8 mask = SD_DAT3_STATUS | SD_DAT2_STATUS | SD_DAT1_STATUS
>> +       | SD_DAT0_STATUS;
>> +
>> +       mutex_lock(&pcr->pcr_mutex);
>> +
>> +       rtsx_pci_start_run(pcr);
>> +
>> +       err = rtsx_pci_write_register(pcr, SD_BUS_STAT,
>> +                                     SD_CLK_TOGGLE_EN |
>> SD_CLK_FORCE_STOP,
>> +                              SD_CLK_TOGGLE_EN);
>> +       if (err)
>> +               goto out;
>> +
>> +       mdelay(1);
>> +
>> +       err = rtsx_pci_read_register(pcr, SD_BUS_STAT, &stat);
>> +       if (err)
>> +               goto out;
>> +
>> +       err = rtsx_pci_write_register(pcr, SD_BUS_STAT,
>> +                                     SD_CLK_TOGGLE_EN |
>> +SD_CLK_FORCE_STOP, 0);
>> +out:
>> +       mutex_unlock(&pcr->pcr_mutex);
>> +
>> +       if (err)
>> +               return err;
>> +
>> +       /* check if any pin between dat[0:3] is low */
>> +       if ((stat & mask) != mask)
>> +               return 1;
>> +       else
>> +               return 0;
>> +}
>> +
>>  static int sdmmc_execute_tuning(struct mmc_host *mmc, u32 opcode)  {
>>         struct realtek_pci_sdmmc *host = mmc_priv(mmc); @@ -1418,6
>> +1458,7 @@ static const struct mmc_host_ops realtek_pci_sdmmc_ops = {
>>         .get_ro = sdmmc_get_ro,
>>         .get_cd = sdmmc_get_cd,
>>         .start_signal_voltage_switch = sdmmc_switch_voltage,
>> +       .card_busy = sdmmc_card_busy,
>>         .execute_tuning = sdmmc_execute_tuning,
>>         .init_sd_express = sdmmc_init_sd_express,  };
>> --
>> 2.52.0
> 

