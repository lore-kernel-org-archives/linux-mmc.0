From: Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH] sdhci-esdhc-imx: fix bus-width for 1-bit operation.
Date: Wed, 02 Nov 2016 09:40:02 -0700
Message-ID: <a96c51d622e802cb01052699e7c6f1c7@agner.ch>
References: <1478015905-31262-1-git-send-email-leogveiga@gmail.com>
 <CAA+hA=SMgEM_UVt2=3-Kx23fG0epMJv3mt7ZEPo=Eo5ib7Lj=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAA+hA=SMgEM_UVt2=3-Kx23fG0epMJv3mt7ZEPo=Eo5ib7Lj=w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dong Aisheng <dongas86@gmail.com>
Cc: "Leonardo G. Veiga" <leogveiga@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, raul.munoz@toradex.com, leonardo.veiga@toradex.com, Haibo Chen <haibo.chen@nxp.com>
List-Id: linux-mmc@vger.kernel.org

On 2016-11-02 01:42, Dong Aisheng wrote:
> Hi Leonardo,
> 
> On Tue, Nov 1, 2016 at 11:58 PM, Leonardo G. Veiga <leogveiga@gmail.com> wrote:
>> From: Leonardo Graboski Veiga <leonardo.veiga@toradex.com>
>>
>> The 1-bit operation mode, enabled by seeting the 'bus-width' property of
>> the device tree 'esdhc' node to <1>, not work while using SD card.
>>
>> The behavior is only noticed when only the data pin 0 is connected to the
>> hardware. A series of kernel errors are printed to the console, all of them
>> returning the following error message followed by some explanation:
>> mmcblk0: error -84 transferring data
>>
>> If four data lines are connected, it ignores the device-tree
>> property and works in 4-bit mode of operation without errors. The hardware
>> used for testing does not support 8-bit mode.
>>
>> Check the 'bus-width' property and if set to <1>, enable the
>> SDHCI_QUIRK_FORCE_1_BIT_DATA quirk.
>>
>> Signed-off-by: Leonardo Graboski Veiga <leonardo.veiga@toradex.com>
>> ---
>>  drivers/mmc/host/sdhci-esdhc-imx.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
>> index c9fbc4c3..88d7d22 100644
>> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
>> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
>> @@ -1003,6 +1003,10 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
>>                 host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
>>         }
>>
>> +       if (!of_property_read_u32(np, "bus-width", &boarddata->max_bus_width)
>> +               && boarddata->max_bus_width == 1)
>> +               host->quirks |= SDHCI_QUIRK_FORCE_1_BIT_DATA;
>> +
> 
> This looks like a common SDHCI driver issue that it assumes the default
> bus-width as 4 bit if no SDHCI_QUIRK_FORCE_1_BIT_DATA specified.
>         if (!(host->quirks & SDHCI_QUIRK_FORCE_1_BIT_DATA))
>                 mmc->caps |= MMC_CAP_4_BIT_DATA;
> 
> And I'm not sure Andrian or Ulf would like to see people keep using this quirk.
> IMHO we probably could totally remove it since bus-width already tells
> what the driver needs.

Hm, I see what you are saying, the problem is that the core
(sdhci_setup_host) falls back to 4-bit if SDHCI_QUIRK_FORCE_1_BIT_DATA
is not set... Removing that should be fine for DT enabled SDHC drivers,
since mmc_of_parse sets MMC_CAP_4_BIT_DATA. But not sure about drivers
which parse dt on their own or still support platform data.... Those
might rely on MMC_CAP_4_BIT_DATA being set by default...

--
Stefan



> 
> Andrian & Ulf,
> Comments?
> 
>>         /* call to generic mmc_of_parse to support additional capabilities */
>>         ret = mmc_of_parse(host->mmc);
>>         if (ret)
>> --
>> 2.7.4
>>
> 
> Regards
> Dong Aisheng
