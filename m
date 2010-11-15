From: Peppe CAVALLARO <peppe.cavallaro@st.com>
Subject: Re: [RFC] improve the SDHCI wakeup support.
Date: Mon, 15 Nov 2010 15:52:19 +0100
Message-ID: <4CE14923.4090305@st.com>
References: <1289402889-14160-1-git-send-email-peppe.cavallaro@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog108.obsmtp.com ([207.126.144.125]:44609 "EHLO
	eu1sys200aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757475Ab0KOOw7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 15 Nov 2010 09:52:59 -0500
In-Reply-To: <1289402889-14160-1-git-send-email-peppe.cavallaro@st.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Wolfram Sang <w.sang@pengutronix.de>, "nico@fluxnic.net" <nico@fluxnic.net>

Hello

On 11/10/2010 4:28 PM, Giuseppe CAVALLARO wrote:
>
> Hello.
>
> The following patches, currently built against an ST Kernel
> "2.6.32", show how to improve the wakeup support in the SDHCI
> device driver.
>
> Note:
> I'm going to rework them, for example, against the mmc-next
> after performing the review process and, obviously, if you
> think that they can be actually useful.
>
> Indeed, on a STB, it can be nice to have the capability to
> wake-up the system when a card is inserted ;-).
>
> This work allows the SDHCI to wake up the system
> on the following events:
>  1) Card Interrupts.
>  2) Card Insertion.
>  3) Card Removal.
>
> To do that the sdhci has to perform some operations
> described in the patch named:
>   "mmc_sdhci: improve the wake-up support"
>
> A new parameter has been also added to select which wakeup
> event has to be used. At any rate, a device based on
> the sdchi, e.g. sdhci-pci, can use a default mode (that
> can be modified at run-time as well).
> In case of the sdhci-pci the "Card Interrupt event" has not
> been modified according to the logic behind the recent commit:
>   5f619704d18b93869d045abc49e09cdba109b04b
>
> The define MMC_PM_KEEP_POWER has been used to notify that
> a device driver (e.g. sdhci-pltfm) want to wakeup the system.
> In any case, the logic for programming the HC register is
> embedded in the suspend and it's self contained.
>
> In the sdhci-pltfm, it has been also introduced another fix:
> see patch named:
>  "mmc: sdhci-pltfm calls the sdhci_alloc_host with pdev->dev"
> The driver calls the sdhci_alloc_host passing as device pointer
> the parent.
> Note: parent name is "platform" and dev name is "sdhci.0".
> IMO it makes sense to pass the pdev->dev pointer instead of the
> parent. This also helps when invoke the device_set_wakeup_capable etc.
>
> This is a piece of output on our ST platforms:
>
>  bash-3.00# echo 2 > /sys/module/sdhci/parameters/wakeup
>  bash-3.00# echo standby > /sys/power/state
>
>  PM: Syncing filesystems ... done.
>  Freezing user space processes ... (elapsed 0.00 seconds) done.
>  Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
>  [STM][PM] Analyzing the wakeup devices
>  [STM][PM] -> device sdhci.0 can wakeup
>  [STM][PM] -> device stm-asc.0 can wakeup
>
> [snip]
>
> As shown above, to modify at run time the wakeup event we can do:
>  bash-3.00 echo X > /sys/module/sdhci/parameters/wakeup
>
> where X can be:
>  0: no wakeup
>  1: Card Interrupts
>  2: Card Insertion
>  3: Card Removal
>
> Hmm, maybe it's worth having more parameters instead of the
> wakeup. I mean, something like this (welcome feedback):
>  wake_on_card_int
>  wake_on_card_ins
>  wake_on_card_rem
>
> Welcome advice and feedback as usual.
>

I've reworked the patches, I sent the mailing list last week, now built
against the mmc-next Git repository.
I've removed some piece of the code commented by yourself (in this first
thread of emails) and re-generated a single path (marked as V2).

Many thanks for your advice and welcome feedback on the new patch.

Regards
Peppe
