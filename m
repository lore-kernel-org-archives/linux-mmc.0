From: "Subhash Jadavani" <subhashj@codeaurora.org>
Subject: RE: [PATCH V5] mmc: core: eMMC 4.5 Power Class Selection Feature
Date: Mon, 5 Dec 2011 12:09:41 +0530
Message-ID: <000301ccb318$adb9be40$092d3ac0$@org>
References: <1316790707-12012-1-git-send-email-girish.shivananjappa@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:48865 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751287Ab1LEGjr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Dec 2011 01:39:47 -0500
In-Reply-To: <1316790707-12012-1-git-send-email-girish.shivananjappa@linaro.org>
Content-language: en-us
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Girish K S' <girish.shivananjappa@linaro.org>, linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, kgene.kim@samsung.com, patches@linaro.org, linux-samsung-soc@vger.kernel.org

Hi Girish,

> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> owner@vger.kernel.org] On Behalf Of Girish K S
> Sent: Friday, September 23, 2011 8:42 PM
> To: linux-mmc@vger.kernel.org
> Cc: cjb@laptop.org; kgene.kim@samsung.com; patches@linaro.org; linux-
> samsung-soc@vger.kernel.org; Girish K S
> Subject: [PATCH V5] mmc: core: eMMC 4.5 Power Class Selection Feature
> 
> This patch adds the power class selection feature available
> for mmc versions 4.0 and above.
> During the enumeration stage before switching to the lower
> data bus, check if the power class is supported for the
> current bus width. If the power class is available then
> switch to the power class and use the higher data bus. If
> power class is not supported then switch to the lower data
> bus in a worst case.
> 
> Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
> ---
> Changes in v1:
>         This version modifies the power_class_select function
> prototype.
>         During device enumeration, when the host tries to read the
> extended
>         csd register after switching to higher bus width, the read
> fails at
>         higher bus width. So the power_class_select function is
> modified to
>         reuse the extended csd register values read with 1 bit bus
> width.
> 
> Changes in v2:
>         This patch version removes some checkpatch error
> 
> Changes in v3:
>         updated with review comments made by chris ball. patch
> generated
>         by rebasing to chris balls mmc-next branch.
> 
> Changes in v4:
>         updated with review comments.
> 
> Changes in v5:
>         Replace break statement with appropriate return error value in
> 	drivers/mmc/core/mmc.c for unsupported voltage range.
> 
>  drivers/mmc/core/mmc.c  |   96
> +++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mmc/mmc.h |   14 +++++++
>  2 files changed, 110 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 7adc30d..c2334d6 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -532,6 +532,86 @@ static struct device_type mmc_type = {
>  };
> 
>  /*
> + * Select the PowerClass for the current bus width
> + * If power class is defined for 4/8 bit bus in the
> + * extended CSD register, select it by executing the
> + * mmc_switch command.
> + */
> +static int mmc_select_powerclass(struct mmc_card *card,
> +		unsigned int bus_width, u8 *ext_csd)
> +{
> +	int err = 0;
> +	unsigned int pwrclass_val;
> +	unsigned int index = 0;
> +	struct mmc_host *host;
> +
> +	BUG_ON(!card);
> +
> +	host = card->host;
> +	BUG_ON(!host);
> +
> +	if (ext_csd == NULL)
> +		return 0;
> +
> +	/* Power class selection is supported for versions >= 4.0 */
> +	if (card->csd.mmca_vsn < CSD_SPEC_VER_4)
> +		return 0;
> +
> +	/* Power class values are defined only for 4/8 bit bus */
> +	if (bus_width == EXT_CSD_BUS_WIDTH_1)
> +		return 0;
> +
> +	switch (1 << host->ios.vdd) {
> +	case MMC_VDD_165_195:
> +		if (host->ios.clock <= 26000000)
> +			index = EXT_CSD_PWR_CL_26_195;
> +		else if	(host->ios.clock <= 52000000)
> +			index = (bus_width <= EXT_CSD_BUS_WIDTH_8) ?
> +				EXT_CSD_PWR_CL_52_195 :
> +				EXT_CSD_PWR_CL_DDR_52_195;
> +		else if (host->ios.clock <= 200000000)
> +			index = EXT_CSD_PWR_CL_200_195;
> +		break;
> +	case MMC_VDD_32_33:
> +	case MMC_VDD_33_34:
> +	case MMC_VDD_34_35:
> +	case MMC_VDD_35_36:
> +		if (host->ios.clock <= 26000000)
> +			index = EXT_CSD_PWR_CL_26_360;
> +		else if	(host->ios.clock <= 52000000)
> +			index = (bus_width <= EXT_CSD_BUS_WIDTH_8) ?
> +				EXT_CSD_PWR_CL_52_360 :
> +				EXT_CSD_PWR_CL_DDR_52_360;
> +		else if (host->ios.clock <= 200000000)
> +			index = EXT_CSD_PWR_CL_200_360;
> +		break;
> +	default:
> +		pr_warning("%s: Voltage range not supported "
> +			   "for power class.\n", mmc_hostname(host));
> +		return -EINVAL;
> +	}
> +
> +	pwrclass_val = ext_csd[index];
> +
> +	if (bus_width & (EXT_CSD_BUS_WIDTH_8 | EXT_CSD_DDR_BUS_WIDTH_8))
> +		pwrclass_val = (pwrclass_val & EXT_CSD_PWR_CL_8BIT_MASK) >>
> +				EXT_CSD_PWR_CL_8BIT_SHIFT;
> +	else
> +		pwrclass_val = (pwrclass_val & EXT_CSD_PWR_CL_4BIT_MASK) >>
> +				EXT_CSD_PWR_CL_4BIT_SHIFT;
> +
> +	/* If the power class is different from the default value */
> +	if (pwrclass_val > 0) {
> +		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> +				 EXT_CSD_POWER_CLASS,
> +				 pwrclass_val,
> +				 0);
> +	}

Sorry for late review. But I see an issue here. You are reading the max.
power class supported by card for particular voltage and frequency. And
setting that max. power class in POWER_CLASS field without checking if host
power supply (regulators which are powering VCC and VCCQ lines of eMMC) is
capable of supplying this much current or not? Not all host regulators
connected to eMMC might be able to support max. current specified by card
(via power class field).

SD3.01 specification also has concept of max. current based on bus speed
mode. That's why we have following host capability under
"include/linux/mmc/host.h" file:
#define MMC_CAP_MAX_CURRENT_200 (1 << 26)       /* Host max current limit is
200mA */
#define MMC_CAP_MAX_CURRENT_400 (1 << 27)       /* Host max current limit is
400mA */
#define MMC_CAP_MAX_CURRENT_600 (1 << 28)       /* Host max current limit is
600mA */
#define MMC_CAP_MAX_CURRENT_800 (1 << 29)       /* Host max current limit is
800mA */

So basically we should allow host to specify how much current it is capable
of sourcing and then set the min of (max. current specified card power
class, max. current host is capable of sourcing) as POWER_CLASS rather than
blindly setting what card requires.


> +
> +	return err;
> +}
> +
> +/*
>   * Handle the detection and initialisation of a card.
>   *
>   * In the case of a resume, "oldcard" will contain the card
> @@ -787,6 +867,14 @@ static int mmc_init_card(struct mmc_host *host,
> u32 ocr,
>  			bus_width = bus_widths[idx];
>  			if (bus_width == MMC_BUS_WIDTH_1)
>  				ddr = 0; /* no DDR for 1-bit width */
> +			err = mmc_select_powerclass(card,
> ext_csd_bits[idx][0],
> +						    ext_csd);
> +			if (err)
> +				pr_err("%s: power class selection to "
> +				       "bus width %d failed\n",
> +				       mmc_hostname(card->host),
> +				       1 << bus_width);
> +
>  			err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>  					 EXT_CSD_BUS_WIDTH,
>  					 ext_csd_bits[idx][0],
> @@ -810,6 +898,14 @@ static int mmc_init_card(struct mmc_host *host,
> u32 ocr,
>  		}
> 
>  		if (!err && ddr) {
> +			err = mmc_select_powerclass(card,
> ext_csd_bits[idx][1],
> +						    ext_csd);
> +			if (err)
> +				pr_err("%s: power class selection to "
> +				       "bus width %d ddr %d failed\n",
> +				       mmc_hostname(card->host),
> +				       1 << bus_width, ddr);
> +
>  			err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>  					 EXT_CSD_BUS_WIDTH,
>  					 ext_csd_bits[idx][1],
> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
> index ed8fca8..50af227 100644
> --- a/include/linux/mmc/mmc.h
> +++ b/include/linux/mmc/mmc.h
> @@ -279,10 +279,15 @@ struct _mmc_csd {
>  #define EXT_CSD_ERASED_MEM_CONT		181	/* RO */
>  #define EXT_CSD_BUS_WIDTH		183	/* R/W */
>  #define EXT_CSD_HS_TIMING		185	/* R/W */
> +#define EXT_CSD_POWER_CLASS		187	/* R/W */
>  #define EXT_CSD_REV			192	/* RO */
>  #define EXT_CSD_STRUCTURE		194	/* RO */
>  #define EXT_CSD_CARD_TYPE		196	/* RO */
>  #define EXT_CSD_PART_SWITCH_TIME        199     /* RO */
> +#define EXT_CSD_PWR_CL_52_195		200	/* RO */
> +#define EXT_CSD_PWR_CL_26_195		201	/* RO */
> +#define EXT_CSD_PWR_CL_52_360		202	/* RO */
> +#define EXT_CSD_PWR_CL_26_360		203	/* RO */
>  #define EXT_CSD_SEC_CNT			212	/* RO, 4 bytes */
>  #define EXT_CSD_S_A_TIMEOUT		217	/* RO */
>  #define EXT_CSD_REL_WR_SEC_C		222	/* RO */
> @@ -294,6 +299,11 @@ struct _mmc_csd {
>  #define EXT_CSD_SEC_ERASE_MULT		230	/* RO */
>  #define EXT_CSD_SEC_FEATURE_SUPPORT	231	/* RO */
>  #define EXT_CSD_TRIM_MULT		232	/* RO */
> +#define EXT_CSD_PWR_CL_200_195		236	/* RO */
> +#define EXT_CSD_PWR_CL_200_360		237	/* RO */
> +#define EXT_CSD_PWR_CL_DDR_52_195	238	/* RO */
> +#define EXT_CSD_PWR_CL_DDR_52_360	239	/* RO */
> +#define EXT_CSD_POWER_OFF_LONG_TIME	247	/* RO */
> 
>  /*
>   * EXT_CSD field definitions
> @@ -332,6 +342,10 @@ struct _mmc_csd {
>  #define EXT_CSD_RST_N_EN_MASK	0x3
>  #define EXT_CSD_RST_N_ENABLED	1	/* RST_n is enabled on card
> */
> 
> +#define EXT_CSD_PWR_CL_8BIT_MASK	0xF0	/* 8 bit PWR CLS */
> +#define EXT_CSD_PWR_CL_4BIT_MASK	0x0F	/* 8 bit PWR CLS */
> +#define EXT_CSD_PWR_CL_8BIT_SHIFT	4
> +#define EXT_CSD_PWR_CL_4BIT_SHIFT	0
>  /*
>   * MMC_SWITCH access modes
>   */
> --
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

