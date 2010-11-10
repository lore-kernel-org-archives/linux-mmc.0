From: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Subject: [RFC] improve the SDHCI wakeup support.
Date: Wed, 10 Nov 2010 16:28:03 +0100
Message-ID: <1289402889-14160-1-git-send-email-peppe.cavallaro@st.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog110.obsmtp.com ([207.126.144.129]:48264 "EHLO
	eu1sys200aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756620Ab0KJP2S (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Nov 2010 10:28:18 -0500
Received: from zeta.dmz-eu.st.com (ns2.st.com [164.129.230.9])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 033C49A
	for <linux-mmc@vger.kernel.org>; Wed, 10 Nov 2010 15:28:15 +0000 (GMT)
Received: from mail1.ctn.st.com (mail1.ctn.st.com [164.130.116.128])
	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B343C5419
	for <linux-mmc@vger.kernel.org>; Wed, 10 Nov 2010 15:28:15 +0000 (GMT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hello.

The following patches, currently built against an ST Kernel
"2.6.32", show how to improve the wakeup support in the SDHCI
device driver.

Note:
I'm going to rework them, for example, against the mmc-next
after performing the review process and, obviously, if you
think that they can be actually useful.

Indeed, on a STB, it can be nice to have the capability to
wake-up the system when a card is inserted ;-).

This work allows the SDHCI to wake up the system
on the following events:
 1) Card Interrupts.
 2) Card Insertion.
 3) Card Removal.

To do that the sdhci has to perform some operations
described in the patch named:
  "mmc_sdhci: improve the wake-up support"

A new parameter has been also added to select which wakeup
event has to be used. At any rate, a device based on
the sdchi, e.g. sdhci-pci, can use a default mode (that
can be modified at run-time as well).
In case of the sdhci-pci the "Card Interrupt event" has not
been modified according to the logic behind the recent commit:
  5f619704d18b93869d045abc49e09cdba109b04b

The define MMC_PM_KEEP_POWER has been used to notify that
a device driver (e.g. sdhci-pltfm) want to wakeup the system.
In any case, the logic for programming the HC register is
embedded in the suspend and it's self contained.

In the sdhci-pltfm, it has been also introduced another fix:
see patch named:
 "mmc: sdhci-pltfm calls the sdhci_alloc_host with pdev->dev"
The driver calls the sdhci_alloc_host passing as device pointer
the parent.
Note: parent name is "platform" and dev name is "sdhci.0".
IMO it makes sense to pass the pdev->dev pointer instead of the
parent. This also helps when invoke the device_set_wakeup_capable etc.

This is a piece of output on our ST platforms:

 bash-3.00# echo 2 > /sys/module/sdhci/parameters/wakeup
 bash-3.00# echo standby > /sys/power/state

 PM: Syncing filesystems ... done.
 Freezing user space processes ... (elapsed 0.00 seconds) done.
 Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
 [STM][PM] Analyzing the wakeup devices
 [STM][PM] -> device sdhci.0 can wakeup
 [STM][PM] -> device stm-asc.0 can wakeup

[snip]

As shown above, to modify at run time the wakeup event we can do:
 bash-3.00 echo X > /sys/module/sdhci/parameters/wakeup

where X can be:
 0: no wakeup
 1: Card Interrupts
 2: Card Insertion
 3: Card Removal

Hmm, maybe it's worth having more parameters instead of the
wakeup. I mean, something like this (welcome feedback):
 wake_on_card_int
 wake_on_card_ins
 wake_on_card_rem

Welcome advice and feedback as usual.

Regards
Giuseppe
