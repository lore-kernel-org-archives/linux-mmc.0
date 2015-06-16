From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: core: Do not set mmc voltage to 1.8V when
 'no-1-8-v' is present
Date: Tue, 16 Jun 2015 11:31:50 +0200
Message-ID: <CAPDyKFotVdm5vDwjqUw=cD9jmRU86ZBbq1c-qmiFa4Yj2JivxQ@mail.gmail.com>
References: <1434227067-9600-1-git-send-email-festevam@gmail.com>
	<CAPDyKFq29S3K0sxCkUHO=QO0MqM0PskcjoM62EZysNc19SxP6w@mail.gmail.com>
	<CAOMZO5CSvYHNwmeRsSJ+KYfAkisX+_2DePawd6AWHP-ANErq5Q@mail.gmail.com>
	<CAOMZO5Amb9hR=DOxd_wynwqc3Dfo0rLfdJS-dkKiOqB89PyMwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f171.google.com ([209.85.220.171]:35496 "EHLO
	mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932374AbbFPJbv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Jun 2015 05:31:51 -0400
Received: by qkbp125 with SMTP id p125so1472103qkb.2
        for <linux-mmc@vger.kernel.org>; Tue, 16 Jun 2015 02:31:51 -0700 (PDT)
In-Reply-To: <CAOMZO5Amb9hR=DOxd_wynwqc3Dfo0rLfdJS-dkKiOqB89PyMwQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Dong Aisheng <aisheng.dong@freescale.com>, Kevin Lemoi <kevin.lemoi@savant.com>, Otavio Salvador <otavio@ossystems.com.br>, Sascha Hauer <kernel@pengutronix.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, linux-mmc <linux-mmc@vger.kernel.org>, Fabio Estevam <fabio.estevam@freescale.com>

On 15 June 2015 at 14:49, Fabio Estevam <festevam@gmail.com> wrote:
> On Mon, Jun 15, 2015 at 9:23 AM, Fabio Estevam <festevam@gmail.com> wrote:
>> Hi Ulf,
>>
>> On Mon, Jun 15, 2015 at 9:08 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>
>>> What card (eMMC, SD, MMC) and which host driver is being used here?
>>
>> It is an eMMC and the host driver is sdhci-esdhc-imx.c.
>>
>>>> --- a/drivers/mmc/core/host.c
>>>> +++ b/drivers/mmc/core/host.c
>>>> @@ -527,6 +527,8 @@ int mmc_of_parse(struct mmc_host *host)
>>>>                 host->caps2 |= MMC_CAP2_HS400_1_8V | MMC_CAP2_HS200_1_8V_SDR;
>>>>         if (of_find_property(np, "mmc-hs400-1_2v", &len))
>>>>                 host->caps2 |= MMC_CAP2_HS400_1_2V | MMC_CAP2_HS200_1_2V_SDR;
>>>> +       if (of_find_property(np, "no-1-8-v", &len))
>>>> +               host->caps2 |= MMC_CAP_3_3V_ONLY_DDR;
>>>
>>> Do you intend to use 3.3V as the I/O voltage level for an eMMCs
>>> running in DDR mode? Isn't that violation of the eMMC spec?
>>
>> Yes, I would like to use 3.3V as the I/O voltage level for an eMMC in DDR mode.
>>
>> This was the behaviour prior to 312449efd16bb0, which I would like to
>> keep so that our custom board based on mx6sl could work. It works fine
>> with 3.14 kernel, but not on 4.1-rc due to the fact that the board
>> cannot provide 1.8V level, hence 'no-1-8-v' property is passed in the
>> device tree. With this patch applied 3.3V is applied and the eMMC can
>> successfully operate in 3.3V DDR mode.

I had a closer look, should have done that before.

I think we need to decide what "no-1-8-v" should be used for.
Currently the DT documentation is unclear and depending on what SDHCI
variant, the binding has different purpose. It's a mess!

sdhci-pltfm + sdhci-esdhc-imx use the "no-1-8-v" DT binding to enable
the SDHCI_QUIRK2_NO_1_8_V. The sdhci driver uses this quirk to mask
the bus speed modes for SD UHS cards.

In this regards, consider the two below options.

1) We have DT bindings for SD UHS speed modes, which somehow makes the
"no-1-8-v" binding redundant (or deprecated).

2) If you can model the VCCQ power supply as as a regulator, you could
use regulator_is_supported_voltage() API to find out similar
information used to set SDHCI_QUIRK2_NO_1_8_V. In fact, sdhci already
does that to mask MMC_CAP2_HSX00_1_2V, unless 1.2V is supported.

In a third case, sdhci-pxav3 use the "no-1-8-v" DT binding to mask
SDHCI_CAN_VDD_180/SDHCI_CAN_VDD_330, which seems wrong, as it has
nothing to do with the power to the card (VMMC). It's also used it to
mask MMC_CAP_1_8V_DDR.

The summary, is that I would rather see us to move away from using the
"no-1-8-v" DT binding and use the proper SD UHS bus speed modes
binding instead.

>
> Also, looked at the eMMC spec and the only restriction I saw about
> using 3.3V voltage is with HS200 or HS400 devices:
>
> "VCCQ (I/O) 3.3 V range is not supported in either HS200 or HS400 devices"

You are correct! We should add a MMC_CAP_3V_DDR for this and a
corresponding DT binding.

Then we need to teach mmc_select_hs_ddr() and mmc_select_card_type()
about the above new possible configuration.

Kind regards
Uffe
