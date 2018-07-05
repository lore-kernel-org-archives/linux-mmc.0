From: Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH 1/3] mmc: sdhci-esdhc-imx: get rid of support_vsel
Date: Thu, 05 Jul 2018 13:16:31 +0200
Message-ID: <318c0d9a93679df5abddeeef499f95c4@agner.ch>
References: <20180628081331.13051-1-stefan@agner.ch>
 <20180628081331.13051-2-stefan@agner.ch>
 <AM0PR04MB42119E8C29A48E9CDA0F116F80400@AM0PR04MB4211.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AM0PR04MB42119E8C29A48E9CDA0F116F80400@AM0PR04MB4211.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "A.s. Dong" <aisheng.dong@nxp.com>
Cc: adrian.hunter@intel.com, ulf.hansson@linaro.org, Fabio Estevam <fabio.estevam@nxp.com>, Bough Chen <haibo.chen@nxp.com>, michael@amarulasolutions.com, rmk+kernel@armlinux.org.uk, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 05.07.2018 04:52, A.s. Dong wrote:
>> -----Original Message-----
>> From: Stefan Agner [mailto:stefan@agner.ch]
>> Sent: Thursday, June 28, 2018 4:13 PM
>> To: adrian.hunter@intel.com; ulf.hansson@linaro.org
>> Cc: Fabio Estevam <fabio.estevam@nxp.com>; Bough Chen
>> <haibo.chen@nxp.com>; A.s. Dong <aisheng.dong@nxp.com>;
>> michael@amarulasolutions.com; rmk+kernel@armlinux.org.uk; linux-
>> mmc@vger.kernel.org; linux-kernel@vger.kernel.org; Stefan Agner
>> <stefan@agner.ch>
>> Subject: [PATCH 1/3] mmc: sdhci-esdhc-imx: get rid of support_vsel
>>
>> The field support_vsel is currently only used in the device tree case. Get rid
>> of it. No change in behavior.
>>
> 
> I'm not sure if it's quite necessary to remove it as it's used to bypass
> 100Mhz above pad settings look up which is meaningless if user claims
> no 1-8 v support.
> 
> If you remove it, probably you still need better check the quirk for
> Pad state look up.

There should be really no change in behavior, just simplifying code:

If no-1-8-v is set, SDHCI_QUIRK2_NO_1_8_V will be set in any case.

If no-1-8-v is not set, SDHCI_QUIRK2_NO_1_8_V will be set depending on
whether pinctrl states are available

This has been the case before and after this change.

--
Stefan

> 
> Regards
> Dong Aisheng
> 
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> ---
>>  drivers/mmc/host/sdhci-esdhc-imx.c          | 8 ++------
>>  include/linux/platform_data/mmc-esdhc-imx.h | 2 --
>>  2 files changed, 2 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-
>> esdhc-imx.c
>> index 6f444731754d..20a420b765b3 100644
>> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
>> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
>> @@ -1145,18 +1145,14 @@ sdhci_esdhc_imx_probe_dt(struct
>> platform_device *pdev,
>>  			     &boarddata->tuning_start_tap);
>>
>>  	if (of_find_property(np, "no-1-8-v", NULL))
>> -		boarddata->support_vsel = false;
>> -	else
>> -		boarddata->support_vsel = true;
>> +		host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
>>
>>  	if (of_property_read_u32(np, "fsl,delay-line", &boarddata-
>> >delay_line))
>>  		boarddata->delay_line = 0;
>>
>>  	mmc_of_parse_voltage(np, &host->ocr_mask);
>>
>> -	/* sdr50 and sdr104 need work on 1.8v signal voltage */
>> -	if ((boarddata->support_vsel) && esdhc_is_usdhc(imx_data) &&
>> -	    !IS_ERR(imx_data->pins_default)) {
>> +	if (esdhc_is_usdhc(imx_data) && !IS_ERR(imx_data->pins_default))
>> {
>>  		imx_data->pins_100mhz = pinctrl_lookup_state(imx_data-
>> >pinctrl,
>>
>> 	ESDHC_PINCTRL_STATE_100MHZ);
>>  		imx_data->pins_200mhz = pinctrl_lookup_state(imx_data-
>> >pinctrl,
>> diff --git a/include/linux/platform_data/mmc-esdhc-imx.h
>> b/include/linux/platform_data/mmc-esdhc-imx.h
>> index 7daa78a2f342..640dec8b5b0c 100644
>> --- a/include/linux/platform_data/mmc-esdhc-imx.h
>> +++ b/include/linux/platform_data/mmc-esdhc-imx.h
>> @@ -34,7 +34,6 @@ enum cd_types {
>>   * @cd_gpio:	gpio for card_detect interrupt
>>   * @wp_type:	type of write_protect method (see wp_types enum above)
>>   * @cd_type:	type of card_detect method (see cd_types enum above)
>> - * @support_vsel:  indicate it supports 1.8v switching
>>   */
>>
>>  struct esdhc_platform_data {
>> @@ -43,7 +42,6 @@ struct esdhc_platform_data {
>>  	enum wp_types wp_type;
>>  	enum cd_types cd_type;
>>  	int max_bus_width;
>> -	bool support_vsel;
>>  	unsigned int delay_line;
>>  	unsigned int tuning_step;       /* The delay cell steps in tuning
>> procedure */
>>  	unsigned int tuning_start_tap;	/* The start delay cell point in tuning
>> procedure */
>> --
>> 2.18.0
