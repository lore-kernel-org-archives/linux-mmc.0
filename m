From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: core: eMMC 4.5 Power Class Selection Feature
Date: Wed, 21 Sep 2011 14:06:29 -0400
Message-ID: <m2hb454voa.fsf@bob.laptop.org>
References: <1315918652-14340-1-git-send-email-girish.shivananjappa@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1315918652-14340-1-git-send-email-girish.shivananjappa@linaro.org>
	(Girish K. S.'s message of "Tue, 13 Sep 2011 18:27:32 +0530")
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Girish K S <girish.shivananjappa@linaro.org>
Cc: linux-mmc@vger.kernel.org, kgene.kim@samsung.com, patches@linaro.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Girish,

On Tue, Sep 13 2011, Girish K S wrote:
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
>  drivers/mmc/core/mmc.c  |   77 +++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mmc/mmc.h |   13 ++++++++
>  2 files changed, 90 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 63cc77b..a4004da 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -536,6 +536,81 @@ static struct device_type mmc_type = {
>  };
>  
>  /*
> + * Select the PowerClass for the current bus width
> + * If power class is defined for 4/8 bit bus in the
> + * extended CSD register, select it by executing the
> + * mmc_switch command.
> + */
> +static int mmc_select_powerclass(struct mmc_card *card, unsigned int bus_width)
> +{
> +	u8 *ext_csd;
> +	int err;
> +	unsigned int pwrclass_val;
> +	unsigned int index = 0;
> +	struct mmc_host *host = card->host;
> +
> +	BUG_ON(!card);
> +	BUG_ON(!host);
> +
> +	/* Power class selection is supported for versions >= 4.0 */
> +	if (card->csd.mmca_vsn < CSD_SPEC_VER_4)
> +		return 0;
> +	/*Power class values are defined only for 4/8 bit bus*/

Spaces between /* */ and the comment itself, please.

> +	if (bus_width == EXT_CSD_BUS_WIDTH_1)
> +		return 0;
> +
> +	switch ((1 << host->ios.vdd)) {

Extra parens unnecessary.

> +	case MMC_VDD_165_195:
> +		if (host->ios.clock <= 26000000)
> +			index = EXT_CSD_PWR_CL_26_195;
> +		else if	(host->ios.clock <= 52000000)
> +			index = (bus_width <= EXT_CSD_BUS_WIDTH_8) ?
> +					EXT_CSD_PWR_CL_52_195 :
> +					EXT_CSD_PWR_CL_DDR_52_195;
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
> +					EXT_CSD_PWR_CL_52_360 :
> +					EXT_CSD_PWR_CL_DDR_52_360;
> +		else if (host->ios.clock <= 200000000)
> +			index = EXT_CSD_PWR_CL_200_360;
> +		break;
> +	default:
> +		BUG();

BUG() is a huge deal -- it will take out the entire MMC stack, so it's
not appropriate here.  How about just a pr_error() that notes an
unexpected VDD and then returns an error value?

> +		break;
> +	}
> +
> +	err = mmc_get_ext_csd(card, &ext_csd);
> +	if (err)
> +		goto ret;
> +
> +	pwrclass_val = ext_csd[index];
> +
> +	if (bus_width & (EXT_CSD_BUS_WIDTH_8 | EXT_CSD_DDR_BUS_WIDTH_8))
> +		pwrclass_val = (pwrclass_val & EXT_CSD_PWR_CL_8BIT_MASK) >>
> +					EXT_CSD_PWR_CL_8BIT_SHIFT;
> +	else
> +		pwrclass_val = (pwrclass_val & EXT_CSD_PWR_CL_4BIT_MASK) >>
> +					EXT_CSD_PWR_CL_4BIT_SHIFT;
> +
> +	err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> +			EXT_CSD_POWER_CLASS,
> +			pwrclass_val,
> +			0);
> +ret:
> +	mmc_free_ext_csd(ext_csd);
> +	return err;
> +}
> +
> +/*
>   * Handle the detection and initialisation of a card.
>   *
>   * In the case of a resume, "oldcard" will contain the card
> @@ -802,6 +877,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>  			bus_width = bus_widths[idx];
>  			if (bus_width == MMC_BUS_WIDTH_1)
>  				ddr = 0; /* no DDR for 1-bit width */
> +			mmc_select_powerclass(card, ext_csd_bits[idx][0]);

Since you're returning a meaningful error value above, we should do
something with it here -- if you don't expect the error cases to be
hit, you could pr_warning() the return value here so that we can
investigate.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
