From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: reset tuning circuit when power on
 mmc card
Date: Tue, 18 Apr 2017 12:38:05 +0300
Message-ID: <d8e3f7b2-73b1-e656-f03d-b56473c24f12@intel.com>
References: <1492429538-14996-1-git-send-email-haibo.chen@nxp.com>
 <c5c8cd17-4849-6e14-0c8d-9d2825b3af32@intel.com>
 <AM4PR0401MB2324A03EEAB26B094490055F90190@AM4PR0401MB2324.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:51594 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755313AbdDRJnr (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 18 Apr 2017 05:43:47 -0400
In-Reply-To: <AM4PR0401MB2324A03EEAB26B094490055F90190@AM4PR0401MB2324.eurprd04.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Bough Chen <haibo.chen@nxp.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "A.S. Dong" <aisheng.dong@nxp.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 18/04/17 11:16, Bough Chen wrote:
>> -----Original Message-----
>> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
>> owner@vger.kernel.org] On Behalf Of Adrian Hunter
>> Sent: Tuesday, April 18, 2017 3:16 PM
>> To: Bough Chen <haibo.chen@nxp.com>; ulf.hansson@linaro.org; A.S. Dong
>> <aisheng.dong@nxp.com>
>> Cc: linux-mmc@vger.kernel.org
>> Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: reset tuning circuit when power
>> on mmc card
>>
>> On 17/04/17 14:45, Haibo Chen wrote:
>>> USDHC tuning circuit should be reset before every time card
>>> enumeration or re-enumeration.
>>>
>>> SD3.0 card need tuning. For SDR104 card, when system suspend in
>>> standby mode, and then resume back, the IO timing is still
>>> SDR104(tuned) which may result in card re-enumeration fail in low card
>>> speed(400khz) for some cards. And we did meet the issue that in
>>> certain probability, SDR104 card meet mmc command CRC/Timeout error
>>> when send CMD2 during mmc bus resume.
>>>
>>> This patch reset the tuning circuit when the ios timing is
>>> MMC_TIMING_LEGACY/MMC_TIMING_MMC_HS/MMC_TIMING_SD_HS,
>> which means both
>>> mmc_power_up() and mmc_power_off() will reset the tuning circuit.
>>>
>>> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
>>> ---
>>>  drivers/mmc/host/sdhci-esdhc-imx.c | 26 ++++++++++++++++++++++++++
>>>  1 file changed, 26 insertions(+)
>>>
>>> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c
>>> b/drivers/mmc/host/sdhci-esdhc-imx.c
>>> index abad67a..8960833 100644
>>> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
>>> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
>>> @@ -889,6 +889,28 @@ static void esdhc_set_strobe_dll(struct sdhci_host
>> *host)
>>>  	}
>>>  }
>>>
>>> +static void esdhc_reset_tuning(struct sdhci_host *host) {
>>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>> +	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
>>> +	u16 ctrl;
>>> +
>>> +	/* Rest the tuning circurt */
>>> +	if (esdhc_is_usdhc(imx_data)) {
>>> +		if (imx_data->socdata->flags & ESDHC_FLAG_MAN_TUNING) {
>>> +			ctrl = readl(host->ioaddr + ESDHC_MIX_CTRL);
>>> +			ctrl &= ~ESDHC_MIX_CTRL_SMPCLK_SEL;
>>
>> So ESDHC_MIX_CTRL_SMPCLK_SEL is bit-23 but ctrl is 16-bit?
>>
> 
> The bit-23 of both register ESDHC_MIX_CTRL and SDHCI_ACMD12_ERR is named ESDHC_MIX_CTRL_SMPCLK_SEL ,  define whether tuned clock or fixed clock is used to sample data.
> The bit-23 of register ESDHC_MIX_CTRL works when STD_TUNING_EN is 0, which means use MAN tuning.
> The bit-23 of register SDHCI_ACMD12_ERR works when STD_TUNING_EN is set.

I meant it looks very weird to try to change bit-23 in a 16-bit variable.
Should 'ctrl' be u32?

> 
>>> +			ctrl &= ~ESDHC_MIX_CTRL_FBCLK_SEL;
>>> +			writel(ctrl, host->ioaddr + ESDHC_MIX_CTRL);
>>> +			writel(0 << 8, host->ioaddr +
>> ESDHC_TUNE_CTRL_STATUS);
>>
>> 0 << 8 is still zero.
> 
> Yes, this code want to clear the bit8~bit14 of register ESDHC_TUNE_CTRL_STATUS
> Here is the define of these bits in RM:
> [14-8] DLY_CELL_SET_PRE[6:0]  Set the number of delay cells on the feedback clock between the feedback clock and CLK_PRE.

I just meant use 0 not 0 << 8.

> 
> Haibo
>>
>>> +		} else if (imx_data->socdata->flags &
>> ESDHC_FLAG_STD_TUNING) {
>>> +			ctrl = readl(host->ioaddr + SDHCI_ACMD12_ERR);
>>> +			ctrl &= ~ESDHC_MIX_CTRL_SMPCLK_SEL;
>>> +			writel(ctrl, host->ioaddr + SDHCI_ACMD12_ERR);
>>> +		}
>>> +	}
>>> +}
>>> +
>>>  static void esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned
>>> timing)  {
>>>  	u32 m;
>>> @@ -932,6 +954,10 @@ static void esdhc_set_uhs_signaling(struct
>> sdhci_host *host, unsigned timing)
>>>  		host->ops->set_clock(host, host->clock);
>>>  		esdhc_set_strobe_dll(host);
>>>  		break;
>>> +	case MMC_TIMING_LEGACY:
>>> +	default:
>>> +		esdhc_reset_tuning(host);
>>> +		break;
>>>  	}
>>>
>>>  	esdhc_change_pinstate(host, timing);
>>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in the
>> body of a message to majordomo@vger.kernel.org More majordomo info at
>> http://vger.kernel.org/majordomo-info.html
> 

