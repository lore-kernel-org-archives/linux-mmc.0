From: Daniel Drake <dsd@laptop.org>
Subject: UHS-I voltage switching on OLPC XO-1.75
Date: Tue, 30 Oct 2012 15:11:13 -0600
Message-ID: <CAMLZHHQfQ26E+BH2sqV9CGyso+uuKHC=WMaqehzBo9_Gr_kyPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:44041 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934561Ab2J3VLN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Oct 2012 17:11:13 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so442655pad.19
        for <linux-mmc@vger.kernel.org>; Tue, 30 Oct 2012 14:11:13 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Johan Rudholm <jrudholm@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

Hi,

Following on from the recent thread
  [PATCH 2/2] mmc: core: Power cycle card on voltage switch fail
I have tried to get a better grip on the problems being faced.

Test setup:
OLPC XO-1.75 laptop, based on Marvell MMP2 ARM SoC (includes sdhci-pxa
interface)
32GB Sandisk Ultra SD card being inserted into external SD slot

The SoC apparently has support for 1.8V, but we physically do not have
the right power lines wired on the motherboard, so we need to detect
the 1.8V failure and go back to 3.3V mode.

Before patching anything, inserting this card results in:
  sdhci: Switching to 1.8V signalling voltage failed, retrying with
S18R set to 0
  mmc0: error -110 whilst initialising SD card

Now, working on Linux-3.5.4, I add these patches:

    mmc: core: reset sigal voltage on power up
    [RFC/PATCH,v2] mmc: core: Fixup signal voltage switch
    regulator: add missing defintion regulator_is_supported_voltage
    mmc: sdhci: Add regulator support for vccq (voltage regualor)
    mmc: sdhci: Let core handle UHS switch failure

I also tweaked the sdhci code so that UHS-I flags are not
unconditionally disabled by the vccq commit (as explained in "sdhci
vccq regulator support drops UHS-I flags").


Under this setup, the first problem encountered is that the system no
longer identifies the fact that the 1.8V voltage failed. Things are
not happy afterwards. The card_busy check in sdhci is saying that the
card is not busy.
Full kernel logs: http://dev.laptop.org/~dsd/20121030/mmc1.log

I tracked down what causes this regression. In order to get the
failure detection working again, I have to make the following change
in mmc_set_signal_voltage():
                if (cmd11) {
                        host->ios.clock = 0;
-                       mmc_set_ios(host);
+                       //mmc_set_ios(host);
                }
(i.e. don't mess with ios before asking sdhci to do the voltage switch)

and at the top of sdhci_do_1_8v_signal_voltage_switch:
+       /* Stop SDCLK */
+       clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+       clk &= ~SDHCI_CLOCK_CARD_EN;
+       sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
(i.e. add the equivalent clock disabling code here)


With that change, I now get:
  mmc2: Signal voltage switch failed, power cycling card (retries = 10)
  mmc2: error -110 whilst initialising SD card

The -110 error comes from mmc_send_app_op_cond(), but its worth noting
that mmc_send_if_cond() (called immediately above) silently failed
with -110 too. Neither of these failed the first time around before
1.8V was tried.

Full patch that I'm testing with: http://dev.laptop.org/~dsd/20121030/mmc.patch

So, now the question is: why is the card not responding to
if_cond/app_op_cond after being powered down and up again? Is the
power down/up sequence OK?
I tried inserting the mmc_power_off, mmc_power_up, mmc_send_if_cond
sequence into various points in the codepaths being discussed.
Measuring success as the card responding to mmc_send_if_cond(0x30080)
without error (0x30080 is a known good value from when before 1.8V is
tried), I find that this "reset sequence" works just fine up until the
point when CMD11 is run.
CMD11 is sent and returns successfully without error, but from this
point, running the reset sequence will fail (send_if_cond will fail
with -110).

Is this kind of test valid? Does this suggest that something is wrong
with the host controller hardware? My assumption is that whatever
state is modified by CMD11 should be erased here, and of course the
hope is that mmc_power_off and mmc_power_up will do a full power cycle
anyway. But whatever is happening, it looks like the effects of CMD11
are persisting past the reset sequence and are breaking later
communication.

In the mail last week, I think we found some kind of configuration (on
Linux-3.0) where this same setup successfully detected the 1.8V
switching failure, and successfully switched back to 3.3V. I plan to
go back and test that, maybe there is some kind of sequence that
doesn't make the hardware die.

Daniel
