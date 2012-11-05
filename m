From: Philip Rakity <prakity@nvidia.com>
Subject: Re: UHS-I voltage switching on OLPC XO-1.75
Date: Mon, 5 Nov 2012 13:50:43 +0100
Message-ID: <9DACC000-8DE6-4129-A65F-8E75E2ABD7AF@nvidia.com>
References: <CAMLZHHQfQ26E+BH2sqV9CGyso+uuKHC=WMaqehzBo9_Gr_kyPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.121.140]:8220 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751197Ab2KEMvl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Nov 2012 07:51:41 -0500
In-Reply-To: <CAMLZHHQfQ26E+BH2sqV9CGyso+uuKHC=WMaqehzBo9_Gr_kyPQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>, Chris Ball <cjb@laptop.org>
Cc: Johan Rudholm <jrudholm@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


Hi Daneil, Chris,

I reviewed kevin's patch in September which fixes this issue.  Chris -- can we pull it into mmc-next ?  This patch is okay as a standalone change.

From: Philip Rakity <prakity <at> marvell.com>
Subject: Re: [PATCH v2 5/8] mmc: sdhci: fix null return check of regulator_get
Newsgroups: gmane.linux.kernel.mmc
Date: 2012-09-24 15:02:34 GMT (5 weeks, 6 days, 21 hours and 44 minutes ago)

Philip

On Oct 30, 2012, at 9:11 PM, Daniel Drake <dsd@laptop.org> wrote:

> Hi,
> 
> Following on from the recent thread
> [PATCH 2/2] mmc: core: Power cycle card on voltage switch fail
> I have tried to get a better grip on the problems being faced.
> 
> Test setup:
> OLPC XO-1.75 laptop, based on Marvell MMP2 ARM SoC (includes sdhci-pxa
> interface)
> 32GB Sandisk Ultra SD card being inserted into external SD slot
> 
> The SoC apparently has support for 1.8V, but we physically do not have
> the right power lines wired on the motherboard, so we need to detect
> the 1.8V failure and go back to 3.3V mode.
> 
> Before patching anything, inserting this card results in:
> sdhci: Switching to 1.8V signalling voltage failed, retrying with
> S18R set to 0
> mmc0: error -110 whilst initialising SD card
> 
> Now, working on Linux-3.5.4, I add these patches:
> 
>  mmc: core: reset sigal voltage on power up
>  [RFC/PATCH,v2] mmc: core: Fixup signal voltage switch
>  regulator: add missing defintion regulator_is_supported_voltage
>  mmc: sdhci: Add regulator support for vccq (voltage regualor)
>  mmc: sdhci: Let core handle UHS switch failure
> 
> I also tweaked the sdhci code so that UHS-I flags are not
> unconditionally disabled by the vccq commit (as explained in "sdhci
> vccq regulator support drops UHS-I flags").
> 
> 
> Under this setup, the first problem encountered is that the system no
> longer identifies the fact that the 1.8V voltage failed. Things are
> not happy afterwards. The card_busy check in sdhci is saying that the
> card is not busy.
> Full kernel logs: http://dev.laptop.org/~dsd/20121030/mmc1.log
> 
> I tracked down what causes this regression. In order to get the
> failure detection working again, I have to make the following change
> in mmc_set_signal_voltage():
>              if (cmd11) {
>                      host->ios.clock = 0;
> -                       mmc_set_ios(host);
> +                       //mmc_set_ios(host);
>              }
> (i.e. don't mess with ios before asking sdhci to do the voltage switch)
> 
> and at the top of sdhci_do_1_8v_signal_voltage_switch:
> +       /* Stop SDCLK */
> +       clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +       clk &= ~SDHCI_CLOCK_CARD_EN;
> +       sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> (i.e. add the equivalent clock disabling code here)
> 
> 
> With that change, I now get:
> mmc2: Signal voltage switch failed, power cycling card (retries = 10)
> mmc2: error -110 whilst initialising SD card
> 
> The -110 error comes from mmc_send_app_op_cond(), but its worth noting
> that mmc_send_if_cond() (called immediately above) silently failed
> with -110 too. Neither of these failed the first time around before
> 1.8V was tried.
> 
> Full patch that I'm testing with: http://dev.laptop.org/~dsd/20121030/mmc.patch
> 
> So, now the question is: why is the card not responding to
> if_cond/app_op_cond after being powered down and up again? Is the
> power down/up sequence OK?
> I tried inserting the mmc_power_off, mmc_power_up, mmc_send_if_cond
> sequence into various points in the codepaths being discussed.
> Measuring success as the card responding to mmc_send_if_cond(0x30080)
> without error (0x30080 is a known good value from when before 1.8V is
> tried), I find that this "reset sequence" works just fine up until the
> point when CMD11 is run.
> CMD11 is sent and returns successfully without error, but from this
> point, running the reset sequence will fail (send_if_cond will fail
> with -110).
> 
> Is this kind of test valid? Does this suggest that something is wrong
> with the host controller hardware? My assumption is that whatever
> state is modified by CMD11 should be erased here, and of course the
> hope is that mmc_power_off and mmc_power_up will do a full power cycle
> anyway. But whatever is happening, it looks like the effects of CMD11
> are persisting past the reset sequence and are breaking later
> communication.
> 
> In the mail last week, I think we found some kind of configuration (on
> Linux-3.0) where this same setup successfully detected the 1.8V
> switching failure, and successfully switched back to 3.3V. I plan to
> go back and test that, maybe there is some kind of sequence that
> doesn't make the hardware die.
> 
> Daniel
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
