From: Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH v2] mmc: sdhci-esdhc-imx: allow 1.8V modes without
 100/200MHz pinctrl states
Date: Thu, 05 Jul 2018 09:18:24 +0200
Message-ID: <9d97f252b0ee435cd03dad18ac076b33@agner.ch>
References: <20180704150745.21003-1-stefan@agner.ch>
 <AM0PR04MB42115AFEC34B115F185C087680400@AM0PR04MB4211.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AM0PR04MB42115AFEC34B115F185C087680400@AM0PR04MB4211.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "A.s. Dong" <aisheng.dong@nxp.com>
Cc: adrian.hunter@intel.com, ulf.hansson@linaro.org, Bough Chen <haibo.chen@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>, michael@amarulasolutions.com, rmk+kernel@armlinux.org.uk, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 05.07.2018 04:40, A.s. Dong wrote:
>> -----Original Message-----
>> From: Stefan Agner [mailto:stefan@agner.ch]
>> Sent: Wednesday, July 4, 2018 11:08 PM
>> To: adrian.hunter@intel.com; ulf.hansson@linaro.org
>> Cc: Fabio Estevam <fabio.estevam@nxp.com>; Bough Chen
>> <haibo.chen@nxp.com>; A.s. Dong <aisheng.dong@nxp.com>;
>> michael@amarulasolutions.com; rmk+kernel@armlinux.org.uk; linux-
>> mmc@vger.kernel.org; linux-kernel@vger.kernel.org; Stefan Agner
>> <stefan@agner.ch>
>> Subject: [PATCH v2] mmc: sdhci-esdhc-imx: allow 1.8V modes without
>> 100/200MHz pinctrl states
>>
>> If pinctrl nodes for 100/200MHz are missing, the controller should not select
>> any mode which need signal frequencies 100MHz or higher.
>> To prevent such speed modes the driver currently uses the quirk flag
>> SDHCI_QUIRK2_NO_1_8_V. This works nicely for SD cards since 1.8V signaling
>> is required for all faster modes and slower modes use 3.3V signaling only.
>>
>> However, there are eMMC modes which use 1.8V signaling and run below
>> 100MHz, e.g. DDR52 at 1.8V. With using SDHCI_QUIRK2_NO_1_8_V this
>> mode is prevented. When using a fixed 1.8V regulator as vqmmc-supply the
>> stack has no valid mode to use. In this tenuous situation the kernel
>> continuously prints voltage switching errors:
>>   mmc1: Switching to 3.3V signalling voltage failed
>>
> 
> From current code, the NO_1_8_V quirk seems like only affect sd card.
> The 1.8v timing is still allowed for eMMC 1_8V DDR.
> See below:
>         if ((mmc->caps & (MMC_CAP_UHS_SDR12 | MMC_CAP_UHS_SDR25 |
>                           MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_SDR104 |
>                           MMC_CAP_UHS_DDR50 | MMC_CAP_1_8V_DDR)) ||
>             (mmc->caps2 & (MMC_CAP2_HS200_1_8V_SDR | MMC_CAP2_HS400_1_8V)))
>                 host->flags |= SDHCI_SIGNALING_180;


	if (host->quirks2 & SDHCI_QUIRK2_NO_1_8_V) {
		host->caps1 &= ~(SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_SDR50 |
				 SDHCI_SUPPORT_DDR50);
		/*
		 * The SDHCI controller in a SoC might support HS200/HS400
		 * (indicated using mmc-hs200-1_8v/mmc-hs400-1_8v dt property),
		 * but if the board is modeled such that the IO lines are not
		 * connected to 1.8v then HS200/HS400 cannot be supported.
		 * Disable HS200/HS400 if the board does not have 1.8v connected
		 * to the IO lines. (Applicable for other modes in 1.8v)
		 */
		mmc->caps2 &= ~(MMC_CAP2_HSX00_1_8V | MMC_CAP2_HS400_ES);
		mmc->caps &= ~(MMC_CAP_1_8V_DDR | MMC_CAP_UHS);
	}

I think it is restricted due to cleared MMC_CAP_1_8V_DDR.

> 
> Due to i have no board to try that case, can you please help detail
> more on how the
> eMMC DDR52 is blocked due to that quirk?

You can just use any board with a eMMC and add a fixed regulator and
claim that vqmmc is at 1.8V, the stack won't notice :-)

    reg_1p8v: regulator-1p8v {
        compatible = "regulator-fixed";
        regulator-name = "1P8V";
        regulator-min-microvolt = <1800000>;
        regulator-max-microvolt = <1800000>;
        regulator-always-on;
    };

    &usdhc3 {
        pinctrl-names = "default";
        pinctrl-0 = <&pinctrl_usdhc3>;
        ...
        vqmmc-supply = <&reg_1p8v>;
        ...
    };

--
Stefan


> 
>> Avoid using SDHCI_QUIRK2_NO_1_8_V and prevent faster modes by altering
>> the SDHCI capability register. With that the stack is able to select 1.8V modes
>> even if no faster pinctrl states are available:
>>   # cat /sys/kernel/debug/mmc1/ios
>>   ...
>>   timing spec:    8 (mmc DDR52)
>>   signal voltage: 1 (1.80 V)
>>   ...
>>
>> Link:
>> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Flkml
>> .kernel.org%2Fr%2F20180628081331.13051-1-
>> stefan%40agner.ch&amp;data=02%7C01%7Caisheng.dong%40nxp.com%7Ca
>> 32bdbdb4e854ed1a49008d5e1bfeae2%7C686ea1d3bc2b4c6fa92cd99c5c30163
>> 5%7C0%7C0%7C636663136759720275&amp;sdata=%2F2gJ%2BA0fHCzzUehD7
>> 9knsfy3WMj4Okp%2BcxXB70MI5y8%3D&amp;reserved=0
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> ---
>>  drivers/mmc/host/sdhci-esdhc-imx.c | 21 +++++++++------------
>>  1 file changed, 9 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-
>> esdhc-imx.c
>> index 20a420b765b3..e96d969ab2c3 100644
>> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
>> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
>> @@ -312,6 +312,15 @@ static u32 esdhc_readl_le(struct sdhci_host *host,
>> int reg)
>>
>>  			if (imx_data->socdata->flags & ESDHC_FLAG_HS400)
>>  				val |= SDHCI_SUPPORT_HS400;
>> +
>> +			/*
>> +			 * Do not advertise faster UHS modes if there are no
>> +			 * pinctrl states for 100MHz/200MHz.
>> +			 */
>> +			if (IS_ERR_OR_NULL(imx_data->pins_100mhz) ||
>> +			    IS_ERR_OR_NULL(imx_data->pins_200mhz))
>> +				val &= ~(SDHCI_SUPPORT_SDR50 |
>> SDHCI_SUPPORT_DDR50
>> +					 | SDHCI_SUPPORT_SDR104 |
>> SDHCI_SUPPORT_HS400);
>>  		}
>>  	}
>>
>> @@ -1157,18 +1166,6 @@ sdhci_esdhc_imx_probe_dt(struct
>> platform_device *pdev,
>>
>> 	ESDHC_PINCTRL_STATE_100MHZ);
>>  		imx_data->pins_200mhz = pinctrl_lookup_state(imx_data-
>> >pinctrl,
>>
>> 	ESDHC_PINCTRL_STATE_200MHZ);
>> -		if (IS_ERR(imx_data->pins_100mhz) ||
>> -				IS_ERR(imx_data->pins_200mhz)) {
>> -			dev_warn(mmc_dev(host->mmc),
>> -				"could not get ultra high speed state, work on
>> normal mode\n");
>> -			/*
>> -			 * fall back to not supporting uhs by specifying no
>> -			 * 1.8v quirk
>> -			 */
>> -			host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
>> -		}
>> -	} else {
>> -		host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
>>  	}
>>
>>  	/* call to generic mmc_of_parse to support additional capabilities */
>> --
>> 2.18.0
