From: Balaji T K <balajitk@ti.com>
Subject: Re: [PATCH 06/13] mmc: omap_hsmmc: add dt pbias and control mmc support
Date: Thu, 23 May 2013 21:37:31 +0530
Message-ID: <519E3EC3.1040309@ti.com>
References: <1367330633-5941-1-git-send-email-balajitk@ti.com> <1367330633-5941-7-git-send-email-balajitk@ti.com> <20130516161650.GW5600@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20130516161650.GW5600@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, b-cousson@ti.com
List-Id: linux-mmc@vger.kernel.org

On Thursday 16 May 2013 09:46 PM, Tony Lindgren wrote:
> Hi,
>
> * Balaji T K <balajitk@ti.com> [130430 07:09]:
>> Add omap_hsmmc_control to support pbias, high speed mode configuration for mmc1,
>> loopback clock configuration (when external transceiver is used) for mmc2
>
> Thanks for working on this, few suggestions inlined below.

Thanks again for reviewing

>
>> --- a/drivers/mmc/host/omap_hsmmc.c
>> +++ b/drivers/mmc/host/omap_hsmmc.c
>> @@ -182,6 +182,7 @@ struct omap_hsmmc_host {
>>   	struct omap_hsmmc_next	next_data;
>>
>>   	struct	omap_mmc_platform_data	*pdata;
>> +	struct omap_hsmmc_control	*ctrl_mmc;
>>   	int needs_vmmc:1;
>>   	int needs_vmmc_aux:1;
>>   };
>> @@ -265,6 +266,8 @@ static int omap_hsmmc_set_power(struct device *dev, int slot, int power_on,
>>
>>   	if (mmc_slot(host).before_set_reg)
>>   		mmc_slot(host).before_set_reg(dev, slot, power_on, vdd);
>> +	if (host->ctrl_mmc && host->ctrl_mmc->before)
>> +		host->ctrl_mmc->before(host->ctrl_mmc->dev, power_on, vdd);
>>
>>   	/*
>>   	 * Assume Vcc regulator is used only to power the card ... OMAP
>> @@ -302,6 +305,8 @@ static int omap_hsmmc_set_power(struct device *dev, int slot, int power_on,
>>
>>   	if (mmc_slot(host).after_set_reg)
>>   		mmc_slot(host).after_set_reg(dev, slot, power_on, vdd);
>> +	if (host->ctrl_mmc && host->ctrl_mmc->after)
>> +		host->ctrl_mmc->after(host->ctrl_mmc->dev, power_on, vdd);
>>
>>   	return ret;
>>   }
>
> These before and after functions should be first converted to just usual
> regulator_set_voltage() eventually. In the PBIAS case it's really a mux
> plus a comparator, but we can set it up as a regulator. And on some boards
> it can be an external regulator like we have the legacy callbacks for in
> mach-omap2/hsmmc.c.

Agree these .before, .after functions are for dual volt pbias i/o cell programming
based on regulator voltage, but modeling pbias register programming via
regulator might be overdo

>
>> +++ b/drivers/mmc/host/omap_hsmmc_control.c
>> @@ -0,0 +1,466 @@
>> +static void omap_control_mmc_writel(u32 reg, u32 *base2)
>> +{
>> +	if (base2)
>> +		__raw_writel(reg, base2);
>> +	return;
>> +}
>> +
>> +static u32 omap_control_mmc_readl(u32 *base2)
>> +{
>> +	u32 pbias_reg = 0;
>> +
>> +	if (base2)
>> +		pbias_reg = __raw_readl(base2);
>> +	return pbias_reg;
>> +}
>> +
>> +static void omap2430_mmc1_active_overwrite(u32 __iomem *devconf1, int vdd)
>> +{
>> +	u32 reg;
>> +
>> +	reg = omap_control_mmc_readl(devconf1);
>> +	if ((1 << vdd) >= MMC_VDD_30_31)
>> +		reg |= OMAP243X_MMC1_ACTIVE_OVERWRITE;
>> +	else
>> +		reg &= ~OMAP243X_MMC1_ACTIVE_OVERWRITE;
>> +	omap_control_mmc_writel(reg, devconf1);
>> +}
>> +/* pbias configuration for omap2430, omap3 */
>> +static void omap_hsmmc1_before_set_reg(struct device *dev,
>> +				  int power_on, int vdd)
>> +{
>> +	u32 reg;
>> +	struct omap_hsmmc_control *ctl_mmc = dev_get_drvdata(dev);
>> +
>> +	if (ctl_mmc->devconf1)
>> +		omap2430_mmc1_active_overwrite(ctl_mmc->devconf1, vdd);
>> +
>> +	reg = omap_control_mmc_readl(ctl_mmc->pbias);
>> +	reg &= ~OMAP2_PBIASLITEPWRDNZ0;
>> +	omap_control_mmc_writel(reg, ctl_mmc->pbias);
>> +}
>> +
>> +static void omap_hsmmc1_after_set_reg(struct device *dev,
>> +				 int power_on, int vdd)
>> +{
>> +	u32 reg;
>> +	struct omap_hsmmc_control *ctl_mmc = dev_get_drvdata(dev);
>> +
>> +	/* 100ms delay required for PBIAS configuration */
>> +	msleep(100);
>> +
>> +	if (power_on) {
>> +		reg = omap_control_mmc_readl(ctl_mmc->pbias);
>> +		reg |= OMAP2_PBIASLITEPWRDNZ0;
>> +		if ((1 << vdd) <= MMC_VDD_165_195)
>> +			reg &= ~OMAP2_PBIASLITEVMODE0;
>> +		else
>> +			reg |= OMAP2_PBIASLITEVMODE0;
>> +		omap_control_mmc_writel(reg, ctl_mmc->pbias);
>> +	} else {
>> +		reg = omap_control_mmc_readl(ctl_mmc->pbias);
>> +		reg |= (OMAP2_PBIASLITEPWRDNZ0 |
>> +			OMAP2_PBIASLITEVMODE0);
>> +		omap_control_mmc_writel(reg, ctl_mmc->pbias);
>> +	}
>> +}
> ...
>
> This all we can simplify quite a bit by defining the PBIAS register
> as pinctrl-single,bits with two different named modes. One for
> 1.8V and for 3.3V. This way the PBIAS register is abstracted for
> various omaps in the .dts file as the register is different.
>

Sometimes pbias register (like in omap3) has bits fields other than mmc1 pbias bits,
in which case it will be difficult to abstract via pinctrl-single
with mask bits for non-mmc1 pbias bits.

> Then this file should just define a new regulator that requests the
> defined pinctrl named mode with pinctrl_select_state().
>
> Now the only thing missing AFAIK is getting the comparator value
> for checks with the generic pinconf framework. But you can already
> get the raw register value with pin_config_get() and add the
> checking to this driver until pinconf allows us to do that.
>
> BTW, the same can then be done for the USB transceivers if we
> figure out a way to properly deal with comparators with generic
> pinconf.
>
> Regards,
>
> Tony
>

