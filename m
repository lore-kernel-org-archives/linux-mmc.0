From: Jisheng Zhang <jszhang@marvell.com>
Subject: Re: [PATCH-v2 4/7] mmc: sdhci-pxav3: Add pinctl setting according
 to bus clock
Date: Tue, 8 Sep 2015 18:04:51 +0800
Message-ID: <20150908180451.4c8bd26c@xhacker>
References: <1441624721-15612-1-git-send-email-vaibhav.hiremath@linaro.org>
	<1441624721-15612-5-git-send-email-vaibhav.hiremath@linaro.org>
	<20150908145254.6807dffc@xhacker>	<55EEABB1.8010806@linaro.org>
	<20150908175220.6b81efda@xhacker>	<55EEB23A.50805@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:49929 "EHLO
	mx0a-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754003AbbIHKIr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Sep 2015 06:08:47 -0400
In-Reply-To: <55EEB23A.50805@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, ulf.hansson@linaro.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Liu <kliu5@marvell.com>

On Tue, 8 Sep 2015 15:32:34 +0530
Vaibhav Hiremath <vaibhav.hiremath@linaro.org> wrote:

> 
> 
> On Tuesday 08 September 2015 03:22 PM, Jisheng Zhang wrote:
> > On Tue, 8 Sep 2015 15:04:41 +0530
> > Vaibhav Hiremath <vaibhav.hiremath@linaro.org> wrote:
> >
> >>
> >>
> >> On Tuesday 08 September 2015 12:22 PM, Jisheng Zhang wrote:
> >>> On Mon, 7 Sep 2015 16:48:38 +0530
> >>> Vaibhav Hiremath <vaibhav.hiremath@linaro.org> wrote:
> >>>
> >>>> Different bus clock may need different pin setting.
> >>>> For example, fast bus clock like 208Mhz need pin drive fast
> >>>> while slow bus clock prefer pin drive slow to guarantee
> >>>> signal quality.
> >>>>
> >>>> So this patch creates two states,
> >>>>     - Default (slow/normal) pin state
> >>>>     - And fast pin state for higher freq bus speed.
> >>>>
> >>>> And selection of pin state is done based on timing mode.
> >>>>
> >>>> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
> >>>> Signed-off-by: Kevin Liu <kliu5@marvell.com>
> >>>> ---
> >>>>    drivers/mmc/host/sdhci-pxav3.c | 45 +++++++++++++++++++++++++++++++++++++++++-
> >>>>    1 file changed, 44 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
> >>>> index c2b2b78..d933f75 100644
> >>>> --- a/drivers/mmc/host/sdhci-pxav3.c
> >>>> +++ b/drivers/mmc/host/sdhci-pxav3.c
> >>>> @@ -35,6 +35,7 @@
> >>>>    #include <linux/pm.h>
> >>>>    #include <linux/pm_runtime.h>
> >>>>    #include <linux/mbus.h>
> >>>> +#include <linux/pinctrl/consumer.h>
> >>>>
> >>>>    #include "sdhci.h"
> >>>>    #include "sdhci-pltfm.h"
> >>>> @@ -92,6 +93,10 @@ struct sdhci_pxa {
> >>>>    	void __iomem *io_pwr_reg;
> >>>>    	void __iomem *io_pwr_lock_reg;
> >>>>    	struct sdhci_pxa_data *data;
> >>>> +
> >>>> +	struct pinctrl *pinctrl;
> >>>> +	struct pinctrl_state *pins_default;
> >>>> +	struct pinctrl_state *pins_fast;
> >>>>    };
> >>>>
> >>>>    static struct sdhci_pxa_data pxav3_data_v1 = {
> >>>> @@ -298,6 +303,33 @@ static void pxav3_gen_init_74_clocks(struct sdhci_host *host, u8 power_mode)
> >>>>    	pxa->power_mode = power_mode;
> >>>>    }
> >>>>
> >>>> +static int pxav3_select_pinstate(struct sdhci_host *host, unsigned int uhs)
> >>>> +{
> >>>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> >>>> +	struct sdhci_pxa *pxa = pltfm_host->priv;
> >>>> +	struct pinctrl_state *pinctrl;
> >>>> +
> >>>> +	if (IS_ERR(pxa->pinctrl) ||
> >>>> +		IS_ERR(pxa->pins_default) ||
> >>>> +		IS_ERR(pxa->pins_fast))
> >>>> +		return -EINVAL;
> >>>> +
> >>>> +	switch (uhs) {
> >>>> +	case MMC_TIMING_UHS_SDR50:
> >>>> +	case MMC_TIMING_UHS_SDR104:
> >>>> +	case MMC_TIMING_MMC_HS200:
> >>>> +	case MMC_TIMING_MMC_HS400:
> >>>> +		pinctrl = pxa->pins_fast;
> >>>> +		break;
> >>>> +	default:
> >>>> +		/* back to default state for other legacy timing */
> >>>> +		pinctrl = pxa->pins_default;
> >>>> +		break;
> >>>> +	}
> >>>> +
> >>>> +	return pinctrl_select_state(pxa->pinctrl, pinctrl);
> >>>> +}
> >>>> +
> >>>>    static void pxav3_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
> >>>>    {
> >>>>    	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> >>>> @@ -353,6 +385,8 @@ static void pxav3_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
> >>>>    	dev_dbg(mmc_dev(host->mmc),
> >>>>    		"%s uhs = %d, ctrl_2 = %04X\n",
> >>>>    		__func__, uhs, ctrl_2);
> >>>> +
> >>>> +	pxav3_select_pinstate(host, uhs);
> >>>
> >>> return pxav3_select_pinstate(host, uhs);?
> >>>
> >>
> >> Its void function, so don't need it.
> >
> > Can you please have a look at the function?
> >
> > static int pxav3_select_pinstate(struct sdhci_host *host, unsigned int uhs)
> >
> 
> I was referring to pxav3_set_uhs_signaling().
> It is void, so what you are suggesting would generate warning.

Oops, you are correct.

> 
> >>
> >>> And could we ignore this call for those SDHCI hosts that don't need it?
> >>>
> >>
> >> I do not want to introduce flags here.
> >> And also, it is already ignored for those who don't need it.
> >>
> >> The first thing in the function pxav3_select_pinstate() is
> >>
> >>
> >> 	if (IS_ERR(pxa->pinctrl) ||
> >> 		IS_ERR(pxa->pins_default) ||
> >> 		IS_ERR(pxa->pins_fast))
> >> 		return -EINVAL;
> >>
> >>
> >> So its already handled.
> >>
> >>>>    }
> >>>>
> >>>>    static void pxav3_voltage_switch(struct sdhci_host *host,
> >>>> @@ -416,7 +450,6 @@ static void pxav3_set_clock(struct sdhci_host *host, unsigned int clock)
> >>>>    		/* TX internal clock selection */
> >>>>    		pxav3_set_tx_clock(host);
> >>>>    	}
> >>>> -
> >>>
> >>> why not fix this in patch 3?
> >>>
> >>
> >> Oops. it got missed from my eyes :)
> >> Will fix in next version.
> >>
> >>>>    }
> >>>>
> >>>>    static const struct sdhci_ops pxav3_sdhci_ops = {
> >>>> @@ -586,6 +619,16 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
> >>>>    		}
> >>>>    	}
> >>>>
> >>>> +	pxa->pinctrl = devm_pinctrl_get(dev);
> >>>
> >>> could we ignore this for those SDHCI hosts that don't need it?
> >>>
> >>
> >> Again, no need to introduce flags here. This is standard call and
> >> handled properly. So for the platforms not using this, it really should
> >> not matter.
> >> Also, lookup is getting executed only when pinctrl is populated.
> >>
> >> So I do not see any need here.
> >>
> >>>> +	if (!IS_ERR(pxa->pinctrl)) {
> >>>> +		pxa->pins_default = pinctrl_lookup_state(pxa->pinctrl, "default");
> >>>> +		if (IS_ERR(pxa->pins_default))
> >>>> +			dev_err(dev, "could not get default pinstate\n");
> >>>
> >>> Why those SDHCI hosts that don't need pinctl setting should got this error?
> >>>
> >>
> >> It won't.
> >
> > It does. On Marvell Berlin SoCs, I got
> >
> > [    1.070000] sdhci-pxav3 f7ab0800.sdhci: could not get default pinstate
> > [    1.080000] sdhci-pxav3 f7ab0800.sdhci: could not get fast pinstate
> >
> >
> >
> >>
> >> If Host does not need pinctrl, the execution would never reach this
> >> point.
> >> The if condition check would handle it, isn't it?
> >>
> >> 	pxa->pinctrl = devm_pinctrl_get(dev);
> >
> > It seems this function always succeed...
> >
> 
> Not always.
> I would succeed only if you have pinctrl defined in DT for this device.

Yes, that's what I thought, but I got

[    1.070000] sdhci-pxav3 f7ab0800.sdhci: could not get default pinstate
[    1.080000] sdhci-pxav3 f7ab0800.sdhci: could not get fast pinstate

there's no pinctrl for f7ab0800.sdhci. Am I missing somthing?

Thanks,
Jisheng

> 
> And if you have pinctrl defined, isn't it is expected to have "default"
> pin state to be always present?
> And if answer is yes here, then it is fair to be prompting error for it.
> 
> >  From another side, we may have default pin in dts, for example: pin muxed between
> > emmc and nandflash. But we don't have fast pinstate, so we at least need the
> > flag to fast pinstate. Otherwise, in such platforms, we could get something like
> >
> 
> That is exactly the reason behind keeping it as dev_info.
> 
> > [    1.000000] sdhci-pxav3 f7ab0000.sdhci: get default pinstate
> > [    1.000000] sdhci-pxav3 f7ab0000.sdhci: could not get fast pinstate
> >
> >
> Thanks,
> Vaibhav

