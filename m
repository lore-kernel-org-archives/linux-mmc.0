From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: UHS-1 cards with iMX6Q
Date: Sat, 8 Feb 2014 21:55:26 +0800
Message-ID: <CAA+hA=RH_rsS+o7+qm+yke+eaHbNnpLjypc55KZc1NmnaJLpxQ@mail.gmail.com>
References: <20140207152951.GB26684@n2100.arm.linux.org.uk>
	<20140207155920.GA10195@S2101-09.ap.freescale.net>
	<20140207161604.GC26684@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f47.google.com ([209.85.216.47]:52853 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751659AbaBHNz1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 8 Feb 2014 08:55:27 -0500
Received: by mail-qa0-f47.google.com with SMTP id j5so6914873qaq.6
        for <linux-mmc@vger.kernel.org>; Sat, 08 Feb 2014 05:55:26 -0800 (PST)
In-Reply-To: <20140207161604.GC26684@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Shawn Guo <shawn.guo@linaro.org>, Dong Aisheng <b29396@freescale.com>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Sat, Feb 8, 2014 at 12:16 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Feb 07, 2014 at 11:59:23PM +0800, Shawn Guo wrote:
>> On Fri, Feb 07, 2014 at 03:29:51PM +0000, Russell King - ARM Linux wrote:
>> > Hi,
>> >
>> > I have a Samsung 8GB UHS-1 card which I'm trying with iMX6Q, and it's
>> > not behaving very well with the voltage switch.  With MMC debugging
>> > enabled - and augmented with additional debug for the ESDHC_VENDOR
>> > register, I'm seeing this with 3.14-rc1:
>> >
>> > [    2.771270] mmc1: starting CMD11 arg 00000000 flags 00000015
>> > [    2.771575] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000080
>> > [    2.771613] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00000001
>> > [    2.771632] mmc1: req done (CMD11): 0: 00000320 00000000 00000000 00000000
>> > [    2.772669] mmc1: clock 0Hz busmode 2 powermode 2 cs 0 Vdd 21 width 0 timing 0
>> > [    2.772679] mmc1: clearing ESDHC_VENDOR_SPEC_FRC_SDCLK_ON
>> > [    2.772687] mmc1: ESDHC_VENDOR_SPEC_VSELECT is clear
>> > [    2.772695] mmc1: clearing ESDHC_VENDOR_SPEC_VSELECT
>> > [    2.772703] mmc1: clearing ESDHC_VENDOR_SPEC_FRC_SDCLK_ON
>> > [    2.772713] sdhci-esdhc-imx 2194000.usdhc: change pinctrl state for uhs 0
>> > [    2.772719] mmc1: clearing ESDHC_VENDOR_SPEC_FRC_SDCLK_ON
>> > [    2.772729] mmc1: ESDHC_VENDOR_SPEC_VSELECT is clear
>> > [    2.772735] mmc1: setting ESDHC_VENDOR_SPEC_VSELECT
>> > [    2.778276] mmc1: ESDHC_VENDOR_SPEC_VSELECT is sett
>> > [    2.786482] mmc1: clock 400000Hz busmode 2 powermode 2 cs 0 Vdd 21 width 0 timing 0
>> > [    2.786502] sdhci-esdhc-imx 2194000.usdhc: desired SD clock: 400000, actual: 386718
>> > [    2.786511] mmc1: setting ESDHC_VENDOR_SPEC_FRC_SDCLK_ON
>> > [    2.787515] mmc1: ESDHC_VENDOR_SPEC_VSELECT is sett
>> > [    2.787522] mmc1: setting ESDHC_VENDOR_SPEC_VSELECT
>> > [    2.787529] mmc1: clearing ESDHC_VENDOR_SPEC_FRC_SDCLK_ON
>> > [    2.787536] sdhci-esdhc-imx 2194000.usdhc: change pinctrl state for uhs 0
>> > [    2.787548] sdhci-esdhc-imx 2194000.usdhc: desired SD clock: 400000, actual: 386718
>> > [    2.787554] mmc1: setting ESDHC_VENDOR_SPEC_FRC_SDCLK_ON
>> > [    2.789560] mmc1: card failed to indicate switch to low voltage mode
>> >
>> > This appears to correspond with the sequence:
>> >
>> > CMD11 -> clock off -> set vselect -> clock on -> clock off ->
>> > set pinctrl -> clock on -> test D[3:0]
>> >
>> > which appears not to be the expected sequence - the expected sequence
>> > should be:
>> >
>> > CMD11 -> clock off -> set vselect -> clock on -> test D[3:0]
>> >
>> > maybe with the setting of the IOMUX settings somewhere in there -
>> > probably at the point where the clock is off - the additional clock
>> > off/clock on step looks to me incorrect.
>> >

The clock on is done by mmc_set_ios(host), from the code,
in sdhci_do_set_ios, the clock will be off and on during set_uhs_signaling.
That could be the reason why you see one more clock off and on before
test D[3:0].

I'm not sure this could be the issue for card to do voltage switch,
the sequence is a bit different from the spec.
Up till now my tests of 3 SD3.0 cards seemed work well on this sequence.

If you think it may be the problem of your card, you can simply remove
that one more
clock disable code to see if it becomes working.

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index f892757..7c3d6a4 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1550,11 +1550,6 @@ static void sdhci_do_set_ios(struct sdhci_host
*host, struct mmc_ios *ios)
                }


-               /* Reset SD Clock Enable */
-               clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
-               clk &= ~SDHCI_CLOCK_CARD_EN;
-               sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
-
                if (host->ops->set_uhs_signaling)
                        host->ops->set_uhs_signaling(host, ios->timing);
                else {
@@ -1588,9 +1583,6 @@ static void sdhci_do_set_ios(struct sdhci_host
*host, struct mmc_ios *ios)
                        ios->drv_type = (preset & SDHCI_PRESET_DRV_MASK)
                                >> SDHCI_PRESET_DRV_SHIFT;
                }
-
-               /* Re-enable SD Clock */
-               sdhci_update_clock(host);
        } else
                sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);

>> > In any case, I've also augmented the other failure paths in
>> > mmc_set_signal_voltage(), and it's always this one (the last step)
>> > which fails:
>> >
>> >         if (host->ops->card_busy && host->ops->card_busy(host)) {
>> >                 pr_debug("%s: card failed to indicate switch to low voltage mode\n",
>> >                          mmc_hostname(host));
>> >                 err = -EAGAIN;
>> >         }
>> >
>> > Any ideas?
>>
>> I'm not sure if it's the cause or you have it set up or not, but I
>> remember that we need to have 3 pinctrl states for 50MHz, 100MHz and
>> 200MHz to get UHS card to work.  You can look at
>> arch/arm/boot/dts/imx6qdl-sabreauto.dtsi for example.
>
> Yes, you need those before the voltage switch is even attempted - I have
> all that in place.  Lack of the pinctrl states disables 1.8V support:
>

Signal voltage switch is earlier than tunning so the pad setting may not be
the cause of this issue.

>         /* sdr50 and sdr104 needs work on 1.8v signal voltage */
>         if ((boarddata->support_vsel) && esdhc_is_usdhc(imx_data)) {
>                 imx_data->pins_100mhz = pinctrl_lookup_state(imx_data->pinctrl,
>                                                 ESDHC_PINCTRL_STATE_100MHZ);
>                 imx_data->pins_200mhz = pinctrl_lookup_state(imx_data->pinctrl,
>                                                 ESDHC_PINCTRL_STATE_200MHZ);
>                 if (IS_ERR(imx_data->pins_100mhz) ||
>                                 IS_ERR(imx_data->pins_200mhz)) {
>                         dev_warn(mmc_dev(host->mmc),
>                                 "could not get ultra high speed state, work on $                        /* fall back to not support uhs by specify no 1.8v quir$                        host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
>                 }
>         } else {
>                 host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
>         }
>
> Here's the latest extract from DT for this:
>
> &iomuxc {
>         cubox_i {
>                 pinctrl_cubox_i_usdhc2_aux: cubox-i-usdhc2-aux {
>                         fsl,pins = <
>                                 MX6QDL_PAD_GPIO_4__GPIO1_IO04    0x1f071
>                                 MX6QDL_PAD_KEY_ROW1__SD2_VSELECT 0x1b071
>                         >;
>                 };
>
>                 pinctrl_cubox_i_usdhc2: cubox-i-usdhc2 {
>                         fsl,pins = <
>                                 MX6QDL_PAD_SD2_CMD__SD2_CMD    0x17059
>                                 MX6QDL_PAD_SD2_CLK__SD2_CLK    0x10059
>                                 MX6QDL_PAD_SD2_DAT0__SD2_DATA0 0x17059
>                                 MX6QDL_PAD_SD2_DAT1__SD2_DATA1 0x17059
>                                 MX6QDL_PAD_SD2_DAT2__SD2_DATA2 0x17059
>                                 MX6QDL_PAD_SD2_DAT3__SD2_DATA3 0x17059
>                         >;
>                 };
>
>                 pinctrl_cubox_i_usdhc2_100mhz: cubox-i-usdhc2-100mhz {
>                         fsl,pins = <
>                                 MX6QDL_PAD_SD2_CMD__SD2_CMD    0x170b9
>                                 MX6QDL_PAD_SD2_CLK__SD2_CLK    0x100b9
>                                 MX6QDL_PAD_SD2_DAT0__SD2_DATA0 0x170b9
>                                 MX6QDL_PAD_SD2_DAT1__SD2_DATA1 0x170b9
>                                 MX6QDL_PAD_SD2_DAT2__SD2_DATA2 0x170b9
>                                 MX6QDL_PAD_SD2_DAT3__SD2_DATA3 0x170b9
>                         >;
>                 };
>
>                 pinctrl_cubox_i_usdhc2_200mhz: cubox-i-usdhc2-200mhz {
>                         fsl,pins = <
>                                 MX6QDL_PAD_SD2_CMD__SD2_CMD    0x170f9
>                                 MX6QDL_PAD_SD2_CLK__SD2_CLK    0x100f9
>                                 MX6QDL_PAD_SD2_DAT0__SD2_DATA0 0x170f9
>                                 MX6QDL_PAD_SD2_DAT1__SD2_DATA1 0x170f9
>                                 MX6QDL_PAD_SD2_DAT2__SD2_DATA2 0x170f9
>                                 MX6QDL_PAD_SD2_DAT3__SD2_DATA3 0x170f9
>                         >;
>                 };
>         };
> };
>
> &usdhc2 {
>         pinctrl-names = "default", "state_100mhz", "state_200mhz";
>         pinctrl-0 = <&pinctrl_cubox_i_usdhc2_aux &pinctrl_cubox_i_usdhc2>;
>         pinctrl-1 = <&pinctrl_cubox_i_usdhc2_aux &pinctrl_cubox_i_usdhc2_100mhz>;
>         pinctrl-2 = <&pinctrl_cubox_i_usdhc2_aux &pinctrl_cubox_i_usdhc2_200mhz>;
>         vmmc-supply = <&reg_3p3v>;
>         cd-gpios = <&gpio1 4 0>;
>         status = "okay";
> };
>
> The VSELECT pin drives an external switch which supplies either 3.3V or
> 1.8V to the card and NVCC_SD2.
>

Actually VSELECT pin should only affect the signal voltage, card voltage
should be always 3.3v for SD 3.0 cards.
Not sure if this could be the issue of your boards.

Did you have an imx6q sabreauto board?
If yes, you could give a quick try on that board for your cards to if
it works well.

I just tried a Toshiba SD3.0 cards and a Sandisk SD3.0 cards, both works well
on imx6q sabreauto boards.

Regards
Dong Aisheng

> --
> FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
> in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
> Estimate before purchase was "up to 13.2Mbit".
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
