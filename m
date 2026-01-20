Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C262C2340
	for <linux-mmc@vger.kernel.org>; Tue, 20 Jan 2026 18:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768934357; cv=none; b=LcElwp07PE+B3lFNmJHCdshUlaqk9Zhlck4/iZyRYv2p5V9b8LD4RYtcoOR64aZp2/ROvIwwDacJdLlnt39o6k1eivGh6exQDt11GAMo1v5NvMzCZ5f2za2H9m2VCJbaHUh945cLNHMIdVyrJG3Uj/X1NXHfYfy48gaGosRfK1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768934357; c=relaxed/simple;
	bh=xrY69wmIKc7aobZglNVfDsftlxrFJdNVc2TiaBpSEDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zy4GQRerPOHdo+0kVhgbJAMNWjrc2l6ioTuRlGWZQWZj3zbNGINaTf9EpKwRIcx4mOraHgkv2cthk17DnDB5HcPWarPWvteJKwa5VeklcpdcAJKZJSTspnknNLN0HgYaJQh0DVyVHhS99LHIWpg0Ha0q2KXoz5ZJvsAQKt3qszs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Zlm6HyiS; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Zlm6HyiS"
Message-ID: <79349439-97ea-4147-961e-63cd6a5bfd68@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768934343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Han09Jh4jiXzSruYuj/qCe993x0+mxiP2QO6E7k7pUM=;
	b=Zlm6HyiSz3CsKr0mB8+CoCZok3AzY+qNLSSovkISavZdHDWtgiX4DMzRC+qhplwUMTfCOn
	FDwNJQZIkp3jg1mY9ycyVRQcbBkOK6YACVFX3RT5xvpOXjs3jHP12fZqGVwWLNp7fzMHA9
	MqrBsw/Ud50qTSFUd3f8kvegUPDBMgc=
Date: Tue, 20 Jan 2026 10:38:59 -0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] mmc: rtsx: reset power state on suspend
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Ricky Wu <ricky_wu@realtek.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260105060236.400366-1-matthew.schwartz@linux.dev>
 <20260105060236.400366-2-matthew.schwartz@linux.dev>
 <CAPDyKFo-2TcU6MPZpeEU7kPx4tOLG4ekEFyZnzy1qeH09MTNfQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Matthew Schwartz <matthew.schwartz@linux.dev>
In-Reply-To: <CAPDyKFo-2TcU6MPZpeEU7kPx4tOLG4ekEFyZnzy1qeH09MTNfQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/20/26 4:41 AM, Ulf Hansson wrote:
> On Mon, 5 Jan 2026 at 07:02, Matthew Schwartz
> <matthew.schwartz@linux.dev> wrote:
>>
>> When rtsx_pci suspends, the card reader hardware powers off but the sdmmc
>> driver's prev_power_state remains as MMC_POWER_ON. This causes sd_power_on
>> to skip reinitialization on the next I/O request, leading to DMA transfer
>> timeouts and errors on resume 20% of the time.
> 
> The mmc core should power-off the card, via the ->set_ios() callback
> before the rtsx_pci suspends. In other words, the mmc core should have
> set MMC_POWER_OFF.
> 
> That said, there seems to be something wrong in
> drivers/mmc/host/rtsx_pci_sdmmc.c's ->set_ios(), if that isn't tracked
> correctly. The parent device/driver, rtsx_pci should not need to
> inform that the power to the card is removed, as that should be known
> already by the rtsx_pci_sdmmc driver.

Ah, I see what you mean now, I think it should be fixed in rtsx_pci_sdmmc
too.

These already seem to be in char-misc-next, so I think I need to wait
until those hit upstream and then revert as a part of a v2 patch? If I revert
from char-misc-next I'm worried the commit id won't match once it gets merged
into master.

Thanks,
Matt

> 
>>
>> Add a power_off slot callback so the PCR can notify the sdmmc driver
>> during suspend. The sdmmc driver resets prev_power_state, and sd_request
>> checks this to reinitialize the card before the next I/O.
>>
>> Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
>> ---
>>  drivers/misc/cardreader/rtsx_pcr.c |  9 +++++++++
>>  drivers/mmc/host/rtsx_pci_sdmmc.c  | 22 ++++++++++++++++++++++
>>  include/linux/rtsx_common.h        |  1 +
>>  3 files changed, 32 insertions(+)
>>
>> diff --git a/drivers/misc/cardreader/rtsx_pcr.c b/drivers/misc/cardreader/rtsx_pcr.c
>> index f9952d76d6ed..f1f4d8ed544d 100644
>> --- a/drivers/misc/cardreader/rtsx_pcr.c
>> +++ b/drivers/misc/cardreader/rtsx_pcr.c
>> @@ -1654,6 +1654,7 @@ static int __maybe_unused rtsx_pci_suspend(struct device *dev_d)
>>         struct pci_dev *pcidev = to_pci_dev(dev_d);
>>         struct pcr_handle *handle = pci_get_drvdata(pcidev);
>>         struct rtsx_pcr *pcr = handle->pcr;
>> +       struct rtsx_slot *slot = &pcr->slots[RTSX_SD_CARD];
>>
>>         dev_dbg(&(pcidev->dev), "--> %s\n", __func__);
>>
>> @@ -1661,6 +1662,9 @@ static int __maybe_unused rtsx_pci_suspend(struct device *dev_d)
>>
>>         mutex_lock(&pcr->pcr_mutex);
>>
>> +       if (slot->p_dev && slot->power_off)
>> +               slot->power_off(slot->p_dev);
>> +
>>         rtsx_pci_power_off(pcr, HOST_ENTER_S3, false);
>>
>>         mutex_unlock(&pcr->pcr_mutex);
>> @@ -1772,12 +1776,17 @@ static int rtsx_pci_runtime_suspend(struct device *device)
>>         struct pci_dev *pcidev = to_pci_dev(device);
>>         struct pcr_handle *handle = pci_get_drvdata(pcidev);
>>         struct rtsx_pcr *pcr = handle->pcr;
>> +       struct rtsx_slot *slot = &pcr->slots[RTSX_SD_CARD];
>>
>>         dev_dbg(device, "--> %s\n", __func__);
>>
>>         cancel_delayed_work_sync(&pcr->carddet_work);
>>
>>         mutex_lock(&pcr->pcr_mutex);
>> +
>> +       if (slot->p_dev && slot->power_off)
>> +               slot->power_off(slot->p_dev);
>> +
>>         rtsx_pci_power_off(pcr, HOST_ENTER_S3, true);
>>
>>         mutex_unlock(&pcr->pcr_mutex);
>> diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
>> index 792ebae46697..74ee8623ad4e 100644
>> --- a/drivers/mmc/host/rtsx_pci_sdmmc.c
>> +++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
>> @@ -47,6 +47,7 @@ struct realtek_pci_sdmmc {
>>  };
>>
>>  static int sdmmc_init_sd_express(struct mmc_host *mmc, struct mmc_ios *ios);
>> +static int sd_power_on(struct realtek_pci_sdmmc *host, unsigned char power_mode);
>>
>>  static inline struct device *sdmmc_dev(struct realtek_pci_sdmmc *host)
>>  {
>> @@ -821,6 +822,15 @@ static void sd_request(struct work_struct *work)
>>
>>         rtsx_pci_start_run(pcr);
>>
>> +       if (host->prev_power_state == MMC_POWER_OFF) {
>> +               err = sd_power_on(host, MMC_POWER_ON);
>> +               if (err) {
>> +                       cmd->error = err;
>> +                       mutex_unlock(&pcr->pcr_mutex);
>> +                       goto finish;
>> +               }
>> +       }
>> +
>>         rtsx_pci_switch_clock(pcr, host->clock, host->ssc_depth,
>>                         host->initial_mode, host->double_clk, host->vpclk);
>>         rtsx_pci_write_register(pcr, CARD_SELECT, 0x07, SD_MOD_SEL);
>> @@ -1524,6 +1534,16 @@ static void rtsx_pci_sdmmc_card_event(struct platform_device *pdev)
>>         mmc_detect_change(host->mmc, 0);
>>  }
>>
>> +static void rtsx_pci_sdmmc_power_off(struct platform_device *pdev)
>> +{
>> +       struct realtek_pci_sdmmc *host = platform_get_drvdata(pdev);
>> +
>> +       if (!host)
>> +               return;
>> +
>> +       host->prev_power_state = MMC_POWER_OFF;
>> +}
>> +
>>  static int rtsx_pci_sdmmc_drv_probe(struct platform_device *pdev)
>>  {
>>         struct mmc_host *mmc;
>> @@ -1556,6 +1576,7 @@ static int rtsx_pci_sdmmc_drv_probe(struct platform_device *pdev)
>>         platform_set_drvdata(pdev, host);
>>         pcr->slots[RTSX_SD_CARD].p_dev = pdev;
>>         pcr->slots[RTSX_SD_CARD].card_event = rtsx_pci_sdmmc_card_event;
>> +       pcr->slots[RTSX_SD_CARD].power_off = rtsx_pci_sdmmc_power_off;
>>
>>         mutex_init(&host->host_mutex);
>>
>> @@ -1587,6 +1608,7 @@ static void rtsx_pci_sdmmc_drv_remove(struct platform_device *pdev)
>>         pcr = host->pcr;
>>         pcr->slots[RTSX_SD_CARD].p_dev = NULL;
>>         pcr->slots[RTSX_SD_CARD].card_event = NULL;
>> +       pcr->slots[RTSX_SD_CARD].power_off = NULL;
>>         mmc = host->mmc;
>>
>>         cancel_work_sync(&host->work);
>> diff --git a/include/linux/rtsx_common.h b/include/linux/rtsx_common.h
>> index da9c8c6b5d50..f294f478f0c0 100644
>> --- a/include/linux/rtsx_common.h
>> +++ b/include/linux/rtsx_common.h
>> @@ -32,6 +32,7 @@ struct platform_device;
>>  struct rtsx_slot {
>>         struct platform_device  *p_dev;
>>         void                    (*card_event)(struct platform_device *p_dev);
>> +       void                    (*power_off)(struct platform_device *p_dev);
>>  };
>>
>>  #endif
>> --
>> 2.52.0
>>
> 
> Kind regards
> Uffe

