From: Dong Aisheng <b29396@freescale.com>
Subject: Re: [PATCH v2] mmc: core: Do not set mmc voltage to 1.8V when
 'no-1-8-v' is present
Date: Thu, 18 Jun 2015 22:03:16 +0800
Message-ID: <20150618140313.GA2383@shlinux1.ap.freescale.net>
References: <1434227067-9600-1-git-send-email-festevam@gmail.com>
 <CAPDyKFq29S3K0sxCkUHO=QO0MqM0PskcjoM62EZysNc19SxP6w@mail.gmail.com>
 <CAOMZO5CSvYHNwmeRsSJ+KYfAkisX+_2DePawd6AWHP-ANErq5Q@mail.gmail.com>
 <CAOMZO5Amb9hR=DOxd_wynwqc3Dfo0rLfdJS-dkKiOqB89PyMwQ@mail.gmail.com>
 <CAPDyKFotVdm5vDwjqUw=cD9jmRU86ZBbq1c-qmiFa4Yj2JivxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bl2on0109.outbound.protection.outlook.com ([65.55.169.109]:58240
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752750AbbFROHv (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 18 Jun 2015 10:07:51 -0400
Content-Disposition: inline
In-Reply-To: <CAPDyKFotVdm5vDwjqUw=cD9jmRU86ZBbq1c-qmiFa4Yj2JivxQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Fabio Estevam <festevam@gmail.com>, Dong Aisheng <aisheng.dong@freescale.com>, Kevin Lemoi <kevin.lemoi@savant.com>, Otavio Salvador <otavio@ossystems.com.br>, Sascha Hauer <kernel@pengutronix.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, linux-mmc <linux-mmc@vger.kernel.org>, Fabio Estevam <fabio.estevam@freescale.com>

On Tue, Jun 16, 2015 at 11:31:50AM +0200, Ulf Hansson wrote:
> On 15 June 2015 at 14:49, Fabio Estevam <festevam@gmail.com> wrote:
> > On Mon, Jun 15, 2015 at 9:23 AM, Fabio Estevam <festevam@gmail.com> wrote:
> >> Hi Ulf,
> >>
> >> On Mon, Jun 15, 2015 at 9:08 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >>
> >>> What card (eMMC, SD, MMC) and which host driver is being used here?
> >>
> >> It is an eMMC and the host driver is sdhci-esdhc-imx.c.
> >>
> >>>> --- a/drivers/mmc/core/host.c
> >>>> +++ b/drivers/mmc/core/host.c
> >>>> @@ -527,6 +527,8 @@ int mmc_of_parse(struct mmc_host *host)
> >>>>                 host->caps2 |= MMC_CAP2_HS400_1_8V | MMC_CAP2_HS200_1_8V_SDR;
> >>>>         if (of_find_property(np, "mmc-hs400-1_2v", &len))
> >>>>                 host->caps2 |= MMC_CAP2_HS400_1_2V | MMC_CAP2_HS200_1_2V_SDR;
> >>>> +       if (of_find_property(np, "no-1-8-v", &len))
> >>>> +               host->caps2 |= MMC_CAP_3_3V_ONLY_DDR;
> >>>
> >>> Do you intend to use 3.3V as the I/O voltage level for an eMMCs
> >>> running in DDR mode? Isn't that violation of the eMMC spec?
> >>
> >> Yes, I would like to use 3.3V as the I/O voltage level for an eMMC in DDR mode.
> >>
> >> This was the behaviour prior to 312449efd16bb0, which I would like to
> >> keep so that our custom board based on mx6sl could work. It works fine
> >> with 3.14 kernel, but not on 4.1-rc due to the fact that the board
> >> cannot provide 1.8V level, hence 'no-1-8-v' property is passed in the
> >> device tree. With this patch applied 3.3V is applied and the eMMC can
> >> successfully operate in 3.3V DDR mode.
> 
> I had a closer look, should have done that before.
> 
> I think we need to decide what "no-1-8-v" should be used for.
> Currently the DT documentation is unclear and depending on what SDHCI
> variant, the binding has different purpose. It's a mess!
> 

That's true!

> sdhci-pltfm + sdhci-esdhc-imx use the "no-1-8-v" DT binding to enable
> the SDHCI_QUIRK2_NO_1_8_V. The sdhci driver uses this quirk to mask
> the bus speed modes for SD UHS cards.
> 
> In this regards, consider the two below options.
> 
> 1) We have DT bindings for SD UHS speed modes, which somehow makes the
> "no-1-8-v" binding redundant (or deprecated).
> 
> 2) If you can model the VCCQ power supply as as a regulator, you could
> use regulator_is_supported_voltage() API to find out similar
> information used to set SDHCI_QUIRK2_NO_1_8_V. In fact, sdhci already
> does that to mask MMC_CAP2_HSX00_1_2V, unless 1.2V is supported.
> 

One problem of this way for IMX is that the voltage switch is controlled
by register bit. It may be not suitable to model VCCQ as regualtor.

> In a third case, sdhci-pxav3 use the "no-1-8-v" DT binding to mask
> SDHCI_CAN_VDD_180/SDHCI_CAN_VDD_330, which seems wrong, as it has
> nothing to do with the power to the card (VMMC). It's also used it to
> mask MMC_CAP_1_8V_DDR.
> 
> The summary, is that I would rather see us to move away from using the
> "no-1-8-v" DT binding and use the proper SD UHS bus speed modes
> binding instead.
> 

One concern of using SD UHS bus speed binding is that we may have to define
all speed mode under the node to support all different kinds of card.
e.g.
Originally it's:
&usdhc3 {
        pinctrl-names = "default", "state_100mhz", "state_200mhz";
        pinctrl-0 = <&pinctrl_usdhc3>;
        pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
        pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
        bus-width = <8>;
        cd-gpios = <&gpio2 10 GPIO_ACTIVE_HIGH>;
        wp-gpios = <&gpio2 15 GPIO_ACTIVE_HIGH>;
        keep-power-in-suspend;
        enable-sdio-wakeup;
        vmmc-supply = <&vcc_sd3>;
        status = "okay";
};

Now:
&usdhc3 {
        pinctrl-names = "default", "state_100mhz", "state_200mhz";
        pinctrl-0 = <&pinctrl_usdhc3>;
        pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
        pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
        bus-width = <8>;
        cd-gpios = <&gpio2 10 GPIO_ACTIVE_HIGH>;
        wp-gpios = <&gpio2 15 GPIO_ACTIVE_HIGH>;
        keep-power-in-suspend;
        enable-sdio-wakeup;
        vmmc-supply = <&vcc_sd3>;
	cap-sd-highspeed;
	cap-mmc-highspeed;
	sd-uhs-sdr12;
	sd-uhs-sdr25;
	sd-uhs-sdr50;
	sd-uhs-sdr104;
	sd-uhs-ddr50;
        status = "okay";
};

So the question comes:
1) it adds a lot duplicated things for different host node in device tree
and this increase dts size.
2) do we really need to claim this uhs capability from device tree?
Since it looks to me most is host controller capablity and not board
dependant.
3) those uhs mode defined in device tree may be also conflict with
common sdhci probe/detect function and maybe overwritten later.
If do that, we may need re-structure the common sdhci driver.

> >
> > Also, looked at the eMMC spec and the only restriction I saw about
> > using 3.3V voltage is with HS200 or HS400 devices:
> >
> > "VCCQ (I/O) 3.3 V range is not supported in either HS200 or HS400 devices"
> 
> You are correct! We should add a MMC_CAP_3V_DDR for this and a
> corresponding DT binding.
> 

How about MMC_CAP_VIO_3V and MMC_CAP_VIO_1_8_V/1.2V to directly
reflect the VIO capability?
It can be reused for UHS/HSxx.

> Then we need to teach mmc_select_hs_ddr() and mmc_select_card_type()
> about the above new possible configuration.
> 
> Kind regards
> Uffe

Regards
Dong Aisheng
