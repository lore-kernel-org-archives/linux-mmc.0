Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.153.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795720982;
	b=FOhGNZiVqNsEImaSMiEN1NxqMstW6VeWG8MyzCeCkRYerlzd8MRafkIK0/rrwU4Pyp17
	 AUyraRgOyvVEsl9BVfTivu4LY50VKIAZc8oqKq2CDWp3fx3vQSNYobir0rV1/9KU3h5ZD
	 xQur1NXrPA3ncNNbtxk4ewMgqz9oQphcSsJpo+XbvCNpOZTlngBLHJn08PM5/QTFqYcET
	 +228kWaEMaU4H3yN4SPR/LNfCuCwrKumGLyNO7g79kYcbjnZUJ0hWupBExrvSD79+b4XY
	 tBwNp6ZufWKmhNDy01A9SqgE0Z4OAKDz8FoKPny9Y0w9HMLhhAa06Vq0DJGE5wP+8jQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795720982;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:CC:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Ekt6tnrn/MHafXwRue82TAoQjyGGfHrJVwDqnP/rOOA=;
	b=MMahW1V8lcDMEJfwEO/4Drrxd9JhHJ7t1n0Pbx5m9TLDkqPeh6TPyND4N4o/2V29Y34p
	 +vA0D5rdbRtcqGZGzTNE04MzyUurNH75O79mA6S0wtJMbRPjcWQ+Zo5F+i1xQZVCF4gf5
	 8zdgU+8qiqi6acxlvbJN/It1bRw9lADqCc0uTU+WkyKjlTy+fL6zjYr4xdSpGx7A+ti2a
	 2guqegsuYC6Mbv0WAu32oMrZQ4UHXYztO88hrF1st+M5RCpfVVNz6a5zwxrLmPysGN3Fd
	 rl/jbO/DW8CLVsRylLa0qe6+havM6doi7Mp7EJ2vLXExkH/6uJDMjgxDFlbS941NRNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=YBG5lFvW;
	arc=none smtp.remote-ip=68.232.153.233
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F7C606A321;
	Thu, 26 Nov 2026 19:23:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76F7C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=YBG5lFvW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1795720981; x=1827256981;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=a63giE3GAEyRJi+/cgl4pN/fgQ5g8XlafoOBN2jenWk=;
  b=YBG5lFvWjMnoN7zm3H1cA1Ebf0Tcs2Sf+EsCg7NtRTV5kYDP/v+IJJSm
   Vz6kfpCj8aNoxAnDBgwAq3x5AU8kkubPS1q/7aCXjla3lb9iWIIwM9EC8
   ALiUTUxWtBdjLUQbFgdEp8dxK774Kj7dtgaRBhm+P8ZxBO5lWjPSLO6js
   YBqUqR+qxd6e1aGo6XdKSvNyHKjubayoQzvArEDZXk6QnwzSifVf920N9
   9jC31whnUKw9Cwqiw8+EuJ6wvdw75pE/X440gStO6LU/DS+Yj1YiQ/Fix
   v303TCu/J9GCNNt1he3pIGvetABdlWpLRc7FH8ApdPdUqR/+r1tMHOMM4
   g==;
X-CSE-ConnectionGUID: cJrWm9LpRQuGanb6V7fX1A==
X-CSE-MsgGUID: Goy6/coFQxW6BjWfnMMW3Q==
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="67110987"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Nov 2026 12:23:00 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 26 Nov 2026 12:23:00 -0700
Received: from [10.171.248.17] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Thu, 26 Nov 2026 12:22:57 -0700
Message-ID: <78626de7-84b4-4a96-9f50-0e2fbb8bf20c@microchip.com>
Date: Thu, 26 Nov 2026 20:22:56 +0100
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mmc: sdhci-of-at91: disable selectively clocks on pm
 runtime
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
CC: Ulf Hansson <ulfh@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
	Eugen Hristev <ehristev@kernel.org>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>, Romain Sioen <romain.sioen@microchip.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>, Ludovic Desroches
	<ludovic.desroches@microchip.com>, Robert Marko <robert.marko@sartura.hr>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Ryan Wanner
	<ryan.wanner@microchip.com>, <linux-mmc@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20261014202619.715573-1-aubin.constans@microchip.com>
 <CAPx+jO-fyYy9ZX_O9UQ-tSnOG7LCd0rZ8SNn307hFWLbUAqBRw@mail.gmail.com>
Content-Language: en-US, fr
From: Aubin Constans <aubin.constans@microchip.com>
In-Reply-To: <CAPx+jO-fyYy9ZX_O9UQ-tSnOG7LCd0rZ8SNn307hFWLbUAqBRw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit

On 29/10/2026 12:31, Ulf Hansson wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On Wed, Oct 14, 2026 at 10:28 PM Aubin Constans
> <aubin.constans@microchip.com> wrote:
>>
>> From: Claudiu Beznea <claudiu.beznea@microchip.com>
>>
>> SDMMC run-time clock disabling is not supported in newer SoCs, including
>> SAMA7G54, SAMA7D65 and LAN969x.
> 
> That sounds a bit vague to me. Exactly why can't the clocks be
> disabled? It seems like the clocks are still being used on these newer
> SoCs.

Disabling the SDMMC input clocks in sdhci_at91_runtime_suspend() starts by
disabling "multclk", also referred to as gck, and that may trigger the
"GCLK cannot be stopped" silicon erratum [1].

On theory, doing a SDHCI_RESET_ALL register reset before stopping gck is a
workaround to the erratum.
However, as of writing, it has not been confirmed whether the above erratum
is the only one issue to consider if the input clocks get paused.

Would that explanation make the change acceptable as a step to support the
newer SoCs?

[1] [DS80001016] https://onlinedocs.microchip.com/oxy/GUID-CFE060D6-6076-46C0-B8FD-60B6DA382A42-en-US-11/GUID-3205B886-CA92-4E43-9495-A4B882B5DBE0.html

> 
>>
>> Make the clock disabling scenario conditional:
>> - still enabled for the sama5d2 and sam9x60 compatibles (which are all
>>    those implemented at present),
>> - otherwise avoided by default, for subsequent SoC families.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
>> [Romain: Fix unbalanced clock activation/deactivation]
>> Co-developed-by: Romain Sioen <romain.sioen@microchip.com>
>> Signed-off-by: Romain Sioen <romain.sioen@microchip.com>
>> [Aubin: Rebase before sama7g5 support and edit the commit msg]
>> Signed-off-by: Aubin Constans <aubin.constans@microchip.com>
>> Tested-by: Robert Marko <robert.marko@sartura.hr>
> 
> Kind regards
> Uffe
> 
>> ---
>> Changes in v2:
>> - Edit the commit msg to say the patch prepares SAMA7G54/SAMA7D65/LAN969x
>>    SoC support w/o immediate change.
>>    Also, move and summarize Romain's own commit msg close to its sign-off.
>> - Restore Claudiu's author and sign-off email to the microchip.com address
>>    he had upon writing the patch.
>> - Link to v1: https://lore.kernel.org/r/20260918153414.909333-1-aubin.constans@microchip.com
>>
>>   drivers/mmc/host/sdhci-of-at91.c | 36 ++++++++++++++++++++++++--------
>>   1 file changed, 27 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
>> index 7c4ac65f247d..399856643e57 100644
>> --- a/drivers/mmc/host/sdhci-of-at91.c
>> +++ b/drivers/mmc/host/sdhci-of-at91.c
>> @@ -39,6 +39,7 @@ struct sdhci_at91_soc_data {
>>          const struct sdhci_pltfm_data *pdata;
>>          bool baseclk_is_generated_internally;
>>          unsigned int divider_for_baseclk;
>> +       bool pm_runtime_disable_clks;
>>   };
>>
>>   struct sdhci_at91_priv {
>> @@ -149,12 +150,14 @@ static const struct sdhci_pltfm_data sdhci_sama5d2_pdata = {
>>   static const struct sdhci_at91_soc_data soc_data_sama5d2 = {
>>          .pdata = &sdhci_sama5d2_pdata,
>>          .baseclk_is_generated_internally = false,
>> +       .pm_runtime_disable_clks = true,
>>   };
>>
>>   static const struct sdhci_at91_soc_data soc_data_sam9x60 = {
>>          .pdata = &sdhci_sama5d2_pdata,
>>          .baseclk_is_generated_internally = true,
>>          .divider_for_baseclk = 2,
>> +       .pm_runtime_disable_clks = true,
>>   };
>>
>>   static const struct of_device_id sdhci_at91_dt_match[] = {
>> @@ -164,7 +167,7 @@ static const struct of_device_id sdhci_at91_dt_match[] = {
>>   };
>>   MODULE_DEVICE_TABLE(of, sdhci_at91_dt_match);
>>
>> -static int sdhci_at91_set_clks_presets(struct device *dev)
>> +static int sdhci_at91_set_clks_presets(struct device *dev, bool start_clks)
>>   {
>>          struct sdhci_host *host = dev_get_drvdata(dev);
>>          struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> @@ -174,7 +177,14 @@ static int sdhci_at91_set_clks_presets(struct device *dev)
>>          unsigned int                    gck_rate, clk_base_rate;
>>          unsigned int                    preset_div;
>>
>> -       clk_prepare_enable(priv->hclock);
>> +       /*
>> +        * Manage clock prepare/enable procedure depending on if the board
>> +        * support runtime clock disabling and if we come from the probing
>> +        * or restoring procedure (for backup+self refresh).
>> +        */
>> +       if (start_clks)
>> +               clk_prepare_enable(priv->hclock);
>> +
>>          caps0 = readl(host->ioaddr + SDHCI_CAPABILITIES);
>>          caps1 = readl(host->ioaddr + SDHCI_CAPABILITIES_1);
>>
>> @@ -223,8 +233,11 @@ static int sdhci_at91_set_clks_presets(struct device *dev)
>>          writew(SDHCI_AT91_PRESET_COMMON_CONF | preset_div,
>>                 host->ioaddr + SDHCI_PRESET_FOR_DDR50);
>>
>> -       clk_prepare_enable(priv->mainck);
>> -       clk_prepare_enable(priv->gck);
>> +       /* Same clock management as for hclock */
>> +       if (start_clks) {
>> +               clk_prepare_enable(priv->mainck);
>> +               clk_prepare_enable(priv->gck);
>> +       }
>>
>>          return 0;
>>   }
>> @@ -254,9 +267,11 @@ static int sdhci_at91_runtime_suspend(struct device *dev)
>>          if (host->tuning_mode != SDHCI_TUNING_MODE_3)
>>                  mmc_retune_needed(host->mmc);
>>
>> -       clk_disable_unprepare(priv->gck);
>> -       clk_disable_unprepare(priv->hclock);
>> -       clk_disable_unprepare(priv->mainck);
>> +       if (priv->soc_data->pm_runtime_disable_clks) {
>> +               clk_disable_unprepare(priv->gck);
>> +               clk_disable_unprepare(priv->hclock);
>> +               clk_disable_unprepare(priv->mainck);
>> +       }
>>
>>          return 0;
>>   }
>> @@ -269,7 +284,7 @@ static int sdhci_at91_runtime_resume(struct device *dev)
>>          int ret;
>>
>>          if (priv->restore_needed) {
>> -               ret = sdhci_at91_set_clks_presets(dev);
>> +               ret = sdhci_at91_set_clks_presets(dev, priv->soc_data->pm_runtime_disable_clks);
>>                  if (ret)
>>                          return ret;
>>
>> @@ -277,6 +292,9 @@ static int sdhci_at91_runtime_resume(struct device *dev)
>>                  goto out;
>>          }
>>
>> +       if (!priv->soc_data->pm_runtime_disable_clks)
>> +               goto out;
>> +
>>          ret = clk_prepare_enable(priv->mainck);
>>          if (ret) {
>>                  dev_err(dev, "can't enable mainck\n");
>> @@ -344,7 +362,7 @@ static int sdhci_at91_probe(struct platform_device *pdev)
>>                  return dev_err_probe(&pdev->dev, PTR_ERR(priv->gck),
>>                                       "failed to get multclk\n");
>>
>> -       ret = sdhci_at91_set_clks_presets(&pdev->dev);
>> +       ret = sdhci_at91_set_clks_presets(&pdev->dev, true);
>>          if (ret)
>>                  return ret;
>>
>> --
>> 2.43.0
>>

