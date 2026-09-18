Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0285A50E591;
	Fri, 18 Sep 2026 16:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789747329; cv=none; b=VfzQJipZYnPzYYivwoxIid+xsFE+qBMxoygvwxr4MvGRgfBKLQvZDWgXLLfHs1YYCxzlBj504qoM1aZ1nYNybJ0PnFyOVs26DALj+gmlQeBP8ze2y/Q44alhPc8B8M+Ev+WBkixLa0ITC+jAsfK4YML7GeWwLMIz8v0n3Tj3PV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789747329; c=relaxed/simple;
	bh=NgpRlUCBb1cyNe/Rmt9/vlr0EXiWLH0BChEoZVTvsRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VpJMbA4nY35xipcIXRDxDELsBDymGryA96qDwX/jNBLV6CcI7MehipDJ7TZbQjlDARn74G2gpd1iOQjzP2hNFRiQhhmhOogt3LNC2Lf820jdYT5Jzvv7WkbfgtEmeFTT1foSAbXDpp20NjHAq/2CpM4Oib3/DNCm3UPXxwsHLTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=uHnnH4X1; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="uHnnH4X1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1789747327; x=1821283327;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NgpRlUCBb1cyNe/Rmt9/vlr0EXiWLH0BChEoZVTvsRQ=;
  b=uHnnH4X11YbNljZ3ycI4AMdRChAavj5HrUcHVEFGPfVfzvdQs/HX1jSM
   EcxDGLCYk0ZkLV0mrvMACxgmC3hON7nkbYFCl8B2zm6F9VTY8KX4SgbWi
   cE5/7DFLMf+TQLzb0lJDgc0mjlwwrPolmCjS6HxC+NyYHCg3S3d2Q1Qo9
   Woqq5X7KEjaVCn+6D7UwPc9F6cQYcFSO11VhuUrkCwQuygVx97HWGdHpN
   IaGsbDU3J8WxYPJvzbSJ8yv3FxgeikqcYk1BNY3NQntIIA7gYJvVNBr+b
   Q1CLTPMumQ5Y76dBlnKF5eV8MJiQNPtuuLzp0y7Rk4ilbgxwtYcQptGAx
   g==;
X-CSE-ConnectionGUID: 6uv6AMQ+Sb+/My+66I2/fA==
X-CSE-MsgGUID: 56yVwT2aSbmEU2fpE1JRNA==
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="73896983"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Sep 2026 09:02:06 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 18 Sep 2026 09:02:06 -0700
Received: from [10.171.248.88] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 18 Sep 2026 09:02:03 -0700
Message-ID: <ab5b83a9-7ac3-4a0e-bb81-491e3c509b85@microchip.com>
Date: Fri, 18 Sep 2026 18:02:02 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] mmc: sdhci-of-at91: add option to keep clocks
 enabled
To: Robert Marko <robert.marko@sartura.hr>
CC: <ulfh@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<adrian.hunter@intel.com>, <ehristev@kernel.org>,
	<linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<luka.perkov@sartura.hr>
References: <20260907132617.1198548-1-robert.marko@sartura.hr>
 <20260907132617.1198548-3-robert.marko@sartura.hr>
 <bfcd57f8-ffca-4a44-a84f-12c46cb9fe76@microchip.com>
 <CA+HBbNFQH-hTnqBOEAau2dP1+zKNsHDBcQA9dC5ofx2U5cbFDw@mail.gmail.com>
Content-Language: en-US, fr
From: Aubin Constans <aubin.constans@microchip.com>
In-Reply-To: <CA+HBbNFQH-hTnqBOEAau2dP1+zKNsHDBcQA9dC5ofx2U5cbFDw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit

On 15/09/2026 13:31, Robert Marko wrote:
> On Mon, Sep 14, 2026 at 3:46 PM Aubin Constans
> <aubin.constans@microchip.com> wrote:
>>
>> Hi Robert,
>>
>> On 07/09/2026 15:25, Robert Marko wrote:
>>> sdhci_at91_set_clks_presets() both enables the controller clocks and
>>> programs its capabilities and preset registers. This prevents callers from
>>> restoring the registers without changing the clock enable counts.
>>>
>>> Move clock enablement to callers and add a SoC data flag for controllers
>>> that must keep their clocks enabled. Use it in the runtime PM paths while
>>> keeping register restoration separate from clock enablement.
>>
>> This change has been required for the SAMA7G54 MPU already, and implemented by
>> two complementary commits:
>>
>> https://github.com/linux4microchip/linux/commit/763a3c05c8f9d0feb279c6f308fa5d48d14e07d3
>> https://github.com/linux4microchip/linux/commit/b5bbc888fb39471d46fe0a4ff28f69533c265dd0
>>
>> At least they have been validated by test campaigns.
>> If that existing work seemed OK for you and the LAN969x, then I could squash
>> these two commits and submit the result.
> 
> Hi Aubin,
> Yeah, I originally used those in our tree as well before trying to
> simplify things for upstreaming.
> 
> Regards,
> Robert
> 

To follow up on that patch, I have just submitted the original work,
ported to tag next-20260917:

https://lore.kernel.org/linux-mmc/20260918153414.909333-1-aubin.constans@microchip.com/

Hope it will make easier to support the LAN969x, notably.

Regards,
Aubin

>>>
>>> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
>>>
>>>    drivers/mmc/host/sdhci-of-at91.c | 39 +++++++++++++++++++-------------
>>>    1 file changed, 23 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
>>> index 7c4ac65f247d..b7e2a89da348 100644
>>> --- a/drivers/mmc/host/sdhci-of-at91.c
>>> +++ b/drivers/mmc/host/sdhci-of-at91.c
>>> @@ -38,6 +38,7 @@
>>>    struct sdhci_at91_soc_data {
>>>           const struct sdhci_pltfm_data *pdata;
>>>           bool baseclk_is_generated_internally;
>>> +       bool keep_clks_on;
>>>           unsigned int divider_for_baseclk;
>>>    };
>>>
>>> @@ -164,7 +165,7 @@ static const struct of_device_id sdhci_at91_dt_match[] = {
>>>    };
>>>    MODULE_DEVICE_TABLE(of, sdhci_at91_dt_match);
>>>
>>> -static int sdhci_at91_set_clks_presets(struct device *dev)
>>> +static void sdhci_at91_set_clks_presets(struct device *dev)
>>>    {
>>>           struct sdhci_host *host = dev_get_drvdata(dev);
>>>           struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>> @@ -174,7 +175,6 @@ static int sdhci_at91_set_clks_presets(struct device *dev)
>>>           unsigned int                    gck_rate, clk_base_rate;
>>>           unsigned int                    preset_div;
>>>
>>> -       clk_prepare_enable(priv->hclock);
>>>           caps0 = readl(host->ioaddr + SDHCI_CAPABILITIES);
>>>           caps1 = readl(host->ioaddr + SDHCI_CAPABILITIES_1);
>>>
>>> @@ -222,11 +222,6 @@ static int sdhci_at91_set_clks_presets(struct device *dev)
>>>           preset_div = DIV_ROUND_UP(gck_rate, 50000000) - 1;
>>>           writew(SDHCI_AT91_PRESET_COMMON_CONF | preset_div,
>>>                  host->ioaddr + SDHCI_PRESET_FOR_DDR50);
>>> -
>>> -       clk_prepare_enable(priv->mainck);
>>> -       clk_prepare_enable(priv->gck);
>>> -
>>> -       return 0;
>>>    }
>>>
>>>    static int sdhci_at91_suspend(struct device *dev)
>>> @@ -254,9 +249,11 @@ static int sdhci_at91_runtime_suspend(struct device *dev)
>>>           if (host->tuning_mode != SDHCI_TUNING_MODE_3)
>>>                   mmc_retune_needed(host->mmc);
>>>
>>> -       clk_disable_unprepare(priv->gck);
>>> -       clk_disable_unprepare(priv->hclock);
>>> -       clk_disable_unprepare(priv->mainck);
>>> +       if (!priv->soc_data->keep_clks_on) {
>>> +               clk_disable_unprepare(priv->gck);
>>> +               clk_disable_unprepare(priv->hclock);
>>> +               clk_disable_unprepare(priv->mainck);
>>> +       }
>>>
>>>           return 0;
>>>    }
>>> @@ -269,14 +266,23 @@ static int sdhci_at91_runtime_resume(struct device *dev)
>>>           int ret;
>>>
>>>           if (priv->restore_needed) {
>>> -               ret = sdhci_at91_set_clks_presets(dev);
>>> -               if (ret)
>>> -                       return ret;
>>> +               if (!priv->soc_data->keep_clks_on)
>>> +                       clk_prepare_enable(priv->hclock);
>>> +
>>> +               sdhci_at91_set_clks_presets(dev);
>>> +
>>> +               if (!priv->soc_data->keep_clks_on) {
>>> +                       clk_prepare_enable(priv->mainck);
>>> +                       clk_prepare_enable(priv->gck);
>>> +               }
>>>
>>>                   priv->restore_needed = false;
>>>                   goto out;
>>>           }
>>>
>>> +       if (priv->soc_data->keep_clks_on)
>>> +               goto out;
>>> +
>>>           ret = clk_prepare_enable(priv->mainck);
>>>           if (ret) {
>>>                   dev_err(dev, "can't enable mainck\n");
>>> @@ -344,9 +350,10 @@ static int sdhci_at91_probe(struct platform_device *pdev)
>>>                   return dev_err_probe(&pdev->dev, PTR_ERR(priv->gck),
>>>                                        "failed to get multclk\n");
>>>
>>> -       ret = sdhci_at91_set_clks_presets(&pdev->dev);
>>> -       if (ret)
>>> -               return ret;
>>> +       clk_prepare_enable(priv->hclock);
>>> +       sdhci_at91_set_clks_presets(&pdev->dev);
>>> +       clk_prepare_enable(priv->mainck);
>>> +       clk_prepare_enable(priv->gck);
>>>
>>>           priv->restore_needed = false;
>>>
>>> --
>>> 2.55.0
>>
> 
> 
> --
> Robert Marko
> Staff Embedded Linux Engineer
> Sartura d.d.
> Lendavska ulica 16a
> 10000 Zagreb, Croatia
> Email: robert.marko@sartura.hr
> Web: www.sartura.hr

