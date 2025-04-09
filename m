Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20A41BF33F;
	Wed,  9 Apr 2025 17:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744218735; cv=none; b=h2eLx/u7VG4kVWokFldKLLsrtc8D64uoZsI2Gmib2W8rKfj2pbg5CGMNXeorzSVK4YyzsdOhJ4PbiJ6ahLyXf9O3tlZg5zZLBG7nZ0d7Wj8YyRzdV0Pbp7SVCOLbmFUtAsm9asSJCF5QJBTVbIXuNVCNFfnItvZmuRw8i1ks7kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744218735; c=relaxed/simple;
	bh=NJ9nqQ/HqQW6VWoTACnv0h1lTMjSzqiuotglz3ecV5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LreMHgw+qUrilQ2tKOZ6huzsaXTxWmpbpsOXsYySHIlJtYRsHOUadhSXfdg2krAa1lnVavSq/u0sPSMRFlxAjZZpDF1bQJQEWyvRo9ELwb70R+eYv1DdV9H8hdQR6S0wnDtpaWk3Rchi0ITgO5uRm+ykEjWvk5ni4VD8MjqXJYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=rH4pr9On; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rH4pr9On"
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 539HC0gs1039348
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Apr 2025 12:12:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1744218720;
	bh=HbxbbpJvLSMYgoAwnYVbl8Z4STLCfUPAEMIdO8+NPWo=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=rH4pr9On7+jdfgCM6LGDnGpwcF9J3hp/+HjCVrI8Iheg3bZuAfUvkf5V0Jbk1/L0v
	 zLU6s4FT5GF7pI5TvErYpQonILW20pgss+OY1xvcim02mtFVt10VA4pKUUeGp9upAP
	 gFgF0S6gboQqxgTEZzfae3yFkDpecUy+Vsma3TOI=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 539HC0W1080987
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 9 Apr 2025 12:12:00 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 9
 Apr 2025 12:11:59 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 9 Apr 2025 12:11:59 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 539HBxKZ001640;
	Wed, 9 Apr 2025 12:11:59 -0500
Message-ID: <ceb7869a-2bdd-4a13-ad63-6f29bb8a2ab9@ti.com>
Date: Wed, 9 Apr 2025 12:11:59 -0500
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PENDING: mmc: sdhci*: Add set_hs_ena to sdhci_ops
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: Adrian Hunter <adrian.hunter@intel.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Josua Mayer <josua@solid-run.com>,
        Moteen
 Shah <m-shah@ti.com>
References: <20250407222702.2199047-1-jm@ti.com>
 <20250407222702.2199047-2-jm@ti.com>
 <CAPDyKFqx-G4NynanFWrspz7-uXXF74RfjcU-Sw2nq2JhL3LPuQ@mail.gmail.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <CAPDyKFqx-G4NynanFWrspz7-uXXF74RfjcU-Sw2nq2JhL3LPuQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Ulf,

On 4/9/25 7:48 AM, Ulf Hansson wrote:
> On Tue, 8 Apr 2025 at 00:27, Judith Mendez <jm@ti.com> wrote:
>>
>> This patch adds set_hs_ena call to sdhci_ops so that host
>> controller drivers have the option to implement a custom
>> callback for SDHCI_CTRL_HISPD control.
>>
>> On TI devices (for HS modes and legacy mode), timing was closed on
>> half cycle timing. If any of HIGH_SPEED_ENA, UHS_MODE_SELECT, or
>> V1P8_SIGNAL_ENA is set for these modes, host controller switches to
>> full cycle timing which may cause read/write failures and/or cqe error
>> logs.
>>
>> So add set_hs_ena() to sdhci_ops so each host controller driver
>> can implement their own .set_hs_ena callback.
>>
>> Also add sdhci_am654_set_hs_ena to sdhci_am654 driver and only set
>> HIGH_SPEED_ENA, for modes > MMC_TIMING_SD_HS.
>>
>> Signed-off-by: Judith Mendez <jm@ti.com>
> 
> What does "PENDING" mean or compared to "PATCH"? I guess you want some
> review and test of this - or there anything else?

So sorry, I meant to remove this PENDING tag, will remove for v2.
Review would be just fine.

> 
>> ---
>>   drivers/mmc/host/sdhci.c       | 55 +++++++++++++++++++++-------------
>>   drivers/mmc/host/sdhci.h       |  2 ++
>>   drivers/mmc/host/sdhci_am654.c | 16 ++++++++++
> 
> I think it would be better to split this up in two parts. One for
> sdhci and one for sdhci_am654

Sure no problem. Thanks
.
> 
> Other than that I am going to defer to Adrian to see what he thinks about this.
> 
> Kind regards
> Uffe
> 
>>   3 files changed, 53 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 5f78be7ae16d7..3a878cf0c59b9 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -2355,6 +2355,27 @@ static bool sdhci_presetable_values_change(struct sdhci_host *host, struct mmc_i
>>                 (sdhci_preset_needed(host, ios->timing) || host->drv_type != ios->drv_type);
>>   }
>>
>> +void sdhci_set_hs_ena(struct sdhci_host *host, unsigned char timing)
>> +{
>> +       u8 ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
>> +
>> +       if (timing == MMC_TIMING_SD_HS ||
>> +           timing == MMC_TIMING_MMC_HS ||
>> +           timing == MMC_TIMING_MMC_HS400 ||
>> +           timing == MMC_TIMING_MMC_HS200 ||
>> +           timing == MMC_TIMING_MMC_DDR52 ||
>> +           timing == MMC_TIMING_UHS_SDR50 ||
>> +           timing == MMC_TIMING_UHS_SDR104 ||
>> +           timing == MMC_TIMING_UHS_DDR50 ||
>> +           timing == MMC_TIMING_UHS_SDR25)
>> +               ctrl |= SDHCI_CTRL_HISPD;
>> +       else
>> +               ctrl &= ~SDHCI_CTRL_HISPD;
>> +
>> +       sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
>> +}
>> +EXPORT_SYMBOL_GPL(sdhci_set_hs_ena);
>> +
>>   void sdhci_set_ios_common(struct mmc_host *mmc, struct mmc_ios *ios)
>>   {
>>          struct sdhci_host *host = mmc_priv(mmc);
>> @@ -2436,23 +2457,6 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>              !sdhci_presetable_values_change(host, ios))
>>                  return;
>>
>> -       ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
>> -
>> -       if (!(host->quirks & SDHCI_QUIRK_NO_HISPD_BIT)) {
>> -               if (ios->timing == MMC_TIMING_SD_HS ||
>> -                    ios->timing == MMC_TIMING_MMC_HS ||
>> -                    ios->timing == MMC_TIMING_MMC_HS400 ||
>> -                    ios->timing == MMC_TIMING_MMC_HS200 ||
>> -                    ios->timing == MMC_TIMING_MMC_DDR52 ||
>> -                    ios->timing == MMC_TIMING_UHS_SDR50 ||
>> -                    ios->timing == MMC_TIMING_UHS_SDR104 ||
>> -                    ios->timing == MMC_TIMING_UHS_DDR50 ||
>> -                    ios->timing == MMC_TIMING_UHS_SDR25)
>> -                       ctrl |= SDHCI_CTRL_HISPD;
>> -               else
>> -                       ctrl &= ~SDHCI_CTRL_HISPD;
>> -       }
>> -
>>          if (host->version >= SDHCI_SPEC_300) {
>>                  u16 clk, ctrl_2;
>>
>> @@ -2468,7 +2472,12 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>                          sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
>>                  }
>>
>> -               sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
>> +               if (!(host->quirks & SDHCI_QUIRK_NO_HISPD_BIT)) {
>> +                       if (host->ops->set_hs_ena)
>> +                               host->ops->set_hs_ena(host, ios->timing);
>> +                       else
>> +                               sdhci_set_hs_ena(host, ios->timing);
>> +               }
>>
>>                  if (!host->preset_enabled) {
>>                          /*
>> @@ -2510,8 +2519,14 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>
>>                  /* Re-enable SD Clock */
>>                  host->ops->set_clock(host, host->clock);
>> -       } else
>> -               sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
>> +       } else {
>> +               if (!(host->quirks & SDHCI_QUIRK_NO_HISPD_BIT)) {
>> +                       if (host->ops->set_hs_ena)
>> +                               host->ops->set_hs_ena(host, ios->timing);
>> +                       else
>> +                               sdhci_set_hs_ena(host, ios->timing);
>> +               }
>> +       }
>>   }
>>   EXPORT_SYMBOL_GPL(sdhci_set_ios);
>>
>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>> index cd0e35a805427..ebecb49792ca1 100644
>> --- a/drivers/mmc/host/sdhci.h
>> +++ b/drivers/mmc/host/sdhci.h
>> @@ -704,6 +704,7 @@ struct sdhci_ops {
>>          void            (*set_timeout)(struct sdhci_host *host,
>>                                         struct mmc_command *cmd);
>>          void            (*set_bus_width)(struct sdhci_host *host, int width);
>> +       void            (*set_hs_ena)(struct sdhci_host *host, unsigned char timing);
>>          void (*platform_send_init_74_clocks)(struct sdhci_host *host,
>>                                               u8 power_mode);
>>          unsigned int    (*get_ro)(struct sdhci_host *host);
>> @@ -857,6 +858,7 @@ int sdhci_get_ro(struct mmc_host *mmc);
>>   void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq);
>>   int sdhci_request_atomic(struct mmc_host *mmc, struct mmc_request *mrq);
>>   void sdhci_set_bus_width(struct sdhci_host *host, int width);
>> +void sdhci_set_hs_ena(struct sdhci_host *host, unsigned char timing);
>>   void sdhci_reset(struct sdhci_host *host, u8 mask);
>>   bool sdhci_do_reset(struct sdhci_host *host, u8 mask);
>>   void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing);
>> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
>> index f75c31815ab00..67a64de4972c9 100644
>> --- a/drivers/mmc/host/sdhci_am654.c
>> +++ b/drivers/mmc/host/sdhci_am654.c
>> @@ -429,6 +429,19 @@ static int sdhci_am654_execute_tuning(struct mmc_host *mmc, u32 opcode)
>>          return 0;
>>   }
>>
>> +static void sdhci_am654_set_hs_ena(struct sdhci_host *host, unsigned char timing)
>> +{
>> +       u8 ctrl = 0;
>> +
>> +       if (timing > MMC_TIMING_SD_HS) {
>> +               sdhci_set_hs_ena(host, timing);
>> +       } else {
>> +               ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
>> +               ctrl &= ~SDHCI_CTRL_HISPD;
>> +               sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
>> +       }
>> +}
>> +
>>   static u32 sdhci_am654_cqhci_irq(struct sdhci_host *host, u32 intmask)
>>   {
>>          int cmd_error = 0;
>> @@ -578,6 +591,7 @@ static const struct sdhci_ops sdhci_am654_ops = {
>>          .get_timeout_clock = sdhci_pltfm_clk_get_max_clock,
>>          .set_uhs_signaling = sdhci_set_uhs_signaling,
>>          .set_bus_width = sdhci_set_bus_width,
>> +       .set_hs_ena = sdhci_am654_set_hs_ena,
>>          .set_power = sdhci_set_power_and_bus_voltage,
>>          .set_clock = sdhci_am654_set_clock,
>>          .write_b = sdhci_am654_write_b,
>> @@ -608,6 +622,7 @@ static const struct sdhci_ops sdhci_j721e_8bit_ops = {
>>          .get_timeout_clock = sdhci_pltfm_clk_get_max_clock,
>>          .set_uhs_signaling = sdhci_set_uhs_signaling,
>>          .set_bus_width = sdhci_set_bus_width,
>> +       .set_hs_ena = sdhci_am654_set_hs_ena,
>>          .set_power = sdhci_set_power_and_bus_voltage,
>>          .set_clock = sdhci_am654_set_clock,
>>          .write_b = sdhci_am654_write_b,
>> @@ -632,6 +647,7 @@ static const struct sdhci_ops sdhci_j721e_4bit_ops = {
>>          .get_timeout_clock = sdhci_pltfm_clk_get_max_clock,
>>          .set_uhs_signaling = sdhci_set_uhs_signaling,
>>          .set_bus_width = sdhci_set_bus_width,
>> +       .set_hs_ena = sdhci_am654_set_hs_ena,
>>          .set_power = sdhci_set_power_and_bus_voltage,
>>          .set_clock = sdhci_j721e_4bit_set_clock,
>>          .write_b = sdhci_am654_write_b,
>> --
>> 2.49.0
>>

