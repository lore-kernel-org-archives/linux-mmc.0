From: Vishal Thanki <vishalthanki@gmail.com>
Subject: Re: omap_hsmmc: sdio: issue with generic wakeup IRQ handling
Date: Thu, 25 Feb 2016 12:18:16 +0100
Message-ID: <20160225111813.GA19506@c50.bag.software>
References: <20160218182750.GA5948@c50.bag.software>
 <CALtMJEBdXLef8AJ1-8Txmg2iS413bVV7cpQSb+nL5M7jN_QYzw@mail.gmail.com>
 <20160219141135.GA14354@c50.bag.software>
 <CAC3a_SDH3zspEAUHkGN0qCBKQZBdnhmei2Rqw2Md=7R2iXostA@mail.gmail.com>
 <56CEDB90.6040708@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:34816 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933038AbcBYLSV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 25 Feb 2016 06:18:21 -0500
Content-Disposition: inline
In-Reply-To: <56CEDB90.6040708@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Andreas Fenkart <afenkart@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-omap@vger.kernel.org

On Thu, Feb 25, 2016 at 12:46:40PM +0200, Grygorii Strashko wrote:
> On 02/24/2016 11:32 PM, Vishal Thanki wrote:
> >Hi,
> >
> >On Fri, Feb 19, 2016 at 7:41 PM, Vishal Thanki <vishalthanki@gmail.com> wrote:
> >>Hi Andreas,
> >>
> >>On Thu, Feb 18, 2016 at 10:31:04PM +0100, Andreas Fenkart wrote:
> >>>Hi Vishal,
> >>>
> >>>I remember there was a problem with IRQ, but can't remember on top of
> >>>my head. Meanwhile this might be some pointer:
> >>>
> >>>diff --git a/drivers/net/wireless/mwifiex/sta_ioctl.c
> >>>b/drivers/net/wireless/mwifiex/sta_ioctl.c
> >>>index a6c8a4f..67587c2 100644
> >>>--- a/drivers/net/wireless/mwifiex/sta_ioctl.c
> >>>+++ b/drivers/net/wireless/mwifiex/sta_ioctl.c
> >>>@@ -517,6 +517,17 @@ int mwifiex_enable_hs(struct mwifiex_adapter *adapter)
> >>>         adapter->hs_enabling = true;
> >>>         mwifiex_cancel_all_pending_cmd(adapter);
> >>>
> >>>+       /* if the MMC host is already in suspend it will not detect SDIO irq
> >>>+        * and we might run into response timeout. By claiming the MMC host we
> >>>+        * wake it up, which is sufficient to detect a pending IRQ
> >>>+        */
> >>>+       {
> >>>+               struct sdio_mmc_card *card = adapter->card;
> >>>+               sdio_claim_host(card->func);
> >>>+               printk("+++ poll mmc host for IRQ +++\n");
> >>>+               sdio_release_host(card->func);
> >>>+       }
> >>>+
> >>>         if (mwifiex_set_hs_params(mwifiex_get_priv(adapter,
> >>>                                                    MWIFIEX_BSS_ROLE_STA),
> >>>                                   HostCmd_ACT_GEN_SET, MWIFIEX_SYNC_CMD,
> >>
> >>I tried this code change but that did not help. I saw that the code
> >>change is in a function called mwifiex_enable_hs(), which only gets
> >>invoked by mwifiex_sdio_suspend(); which is why I think it is not having
> >>any effect. Because when I run the command to scan the channel list
> >>(i.e. iw dev wlan0 scan), the system is not in suspend state. And I
> >>noticed (by adding prints in omap_hsmmc.c for suspend and resume
> >>callbacks) that during the "scan" command, the suspend routine gets invoked
> >>for HSMMC but it never gets resumed (may be due to the missed wakeup
> >>IRQ) from mwifiex and the command times out.
> 
> Suspend or Runtime suspend?

The it is the runtime suspend routine for omap_hsmmc.c

	mmc1_pins: pinmux_mmc1_pins {
		pinctrl-single,pins = <
			0x0fc 0x38	/* MMC0_DAT0 */
			0x0f8 0x38	/* MMC0_DAT1 */
			0x0f4 0x38	/* MMC0_DAT2 */
			0x0f0 0x38	/* MMC0_DAT3 */
			0x100 0x38	/* MMC0_CLK */
			0x104 0x38	/* MMC0_CMD */
			0x88  0x07	/* GPMC_CSN3 -> GPIO2_0 */
		>;
	};

	mmc1_sleep_pins: pinmux_mmc1_sleep_pins {
		pinctrl-single,pins = <
			0x0fc 0x3f	/* MMC0_DAT0 */
			0x0f8 0x3f	/* MMC0_DAT1 */
			0x0f4 0x3f	/* MMC0_DAT2 */
			0x0f0 0x3f	/* MMC0_DAT3 */
			0x100 0x3f	/* MMC0_CLK */
			0x104 0x3f	/* MMC0_CMD */
			0x88  0x17	/* GPMC_CSN3 -> GPIO2_0 PULL UP */
		>;
	};

	mmc1_cirq_pin: pinmux_cirq_pin {
		pinctrl-single,pins = <
			0x0f8 0x3f	/* MMC0_DAT1 as GPIO2_28 */
		>;
	};

	wlan0_pwrseq: pwrseq {
		compatible = "mmc-pwrseq-simple";
		reset-gpios = <&gpio2 0 GPIO_ACTIVE_LOW>;
		clocks = <&clk_32768_ck>;
		clock-names = "ext_clock";
	};

&mmc1 {
	status = "okay";
	pinctrl-names = "default", "idle", "sleep";
	pinctrl-0 = <&mmc1_pins>;
	pinctrl-1 = <&mmc1_cirq_pin>;
	pinctrl-2 = <&mmc1_sleep_pins>;
	interrupts-extended = <&intc 64 &gpio2 28 0>;
	ti,non-removable;
	bus-width = <4>;
	vmmc-supply = <&ldo2_reg>;
	vmmc_aux-supply = <&vmmc>;
	keep-power-in-suspend;
	enable-sdio-wakeup;
	mmc-pwrseq = <&wlan0_pwrseq>;
};


> 
> >>
> >
> >Is there any other suggestion for mwifiex that I should try out? Or
> >is there any way in omap_hsmmc to specify the wakeup interrupt
> >type (IRQF_TRIGGER_LOW) while using generic wakeup IRQ
> >mechanism. I could not find it, but I may be missing something.
> 
> How your irqs defined in DT? Could you provide mmc+wifi nodes?



> 
> 
> >>>
> >>>2016-02-18 19:27 GMT+01:00 Vishal Thanki <vishalthanki@gmail.com>:
> >>>>Hi,
> >>>>
> >>>>On a custom built am335x based board, I am facing an issue mwifiex wifi
> >>>>module which is connected to host via SDIO interface. I am using kernel
> >>>>version 4.4.
> >>>>
> >>>>The problem is related to the wifi "ext_scan" command getting timed out
> >>>>over SDIO. This was working with old kernel (v4.0), but does not work on
> >>>>kernel v4.4. I found the following commit is responsible for this
> >>>>behavior.
> >>>>
> >>>>=================================
> >>>>5b83b2234be6733cfe22036c38031b2c890b3db8
> >>>>
> >>>>mmc: omap_hsmmc: Change wake-up interrupt to use generic wakeirq
> >>>>
> >>>>We can now use generic wakeirq handling and remove the custom handling
> >>>>for the wake-up interrupts.
> >>>>=================================
> >>>>
> >>>>There is no wifi issue if I revert the above mentioned commit on kernel
> >>>>v4.4.
> >>>>
> >>>>I see that before this commit, the wakeup IRQ handler was registered
> >>>>within the omap_hsmmc.c itself with additional IRQF_TRIGGER_LOW flag.
> >>>>But with the introduction to dev_pm_set_dedicated_wake_irq(), the
> >>>>generic wakeup IRQ handler is registered which does not take the
> >>>>IRQF_TRIGGER flag. I am not sure if that is the issue, but I added that
> >>>>IRQF_TRIGGER_LOW flag in dev_pm_set_dedicated_wake_irq() while
> >>>>registering a threaded IRQ handler, I could see the problem disappears.
> >>>>However, this change is causing the infinite interrupts because the of
> >>>>level triggered interrupt is not handled in generic wakeup IRQ handling
> >>>>code (as it was done specially in omap_hsmmc.c code earlier).
> >>>>
> >>>>I am not much familiar with MMC/SDIO driver and I am not sure how to fix
> >>>>this behavior. So any guidance would be really helpful.
> >>>>
> 
> 
> 
> -- 
> regards,
> -grygorii
