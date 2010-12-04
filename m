From: Daniel Drake <dsd@laptop.org>
Subject: working around a Marvell wifi SDIO bug
Date: Sat, 4 Dec 2010 16:22:02 +0000
Message-ID: <AANLkTik2F_-g2beZT5mLe4+XSBL-HUKnceeKqtKQZC=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:38465 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755380Ab0LDQWE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 4 Dec 2010 11:22:04 -0500
Received: by ywl5 with SMTP id 5so5300865ywl.19
        for <linux-mmc@vger.kernel.org>; Sat, 04 Dec 2010 08:22:02 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi,

The XO-1.5 laptop ships with an internal wifi adapter connected to the
SDIO bus (on a sdhci-pci host).

We were experiencing a problem where initialization of this card
sometimes failed (on low-level SD stuff, like setting voltage or
reading CCCR). Also, when runtime PM was enabled, the card
consistently fails to come back after it has been powered down.

We believe this is due to a hardware bug with the wifi card. After SD
power has been cut and restored, the card is left in inconsistent
state. http://dev.laptop.org/ticket/10270#comment:4

"According to a confidential Marvell AN, we should be asserting RESET
externally after powering up the WLAN card. The Linux driver should
assert WLAN_RESETn low for between 1 and 20 uS, about 1 mS after
turning on power to the card"

While other users of this wifi card have WLAN_RESETn permanently wired
low, OLPC has it wired to a GPIO. So we *can* do the above from the
kernel, but its specific to this particular laptop.

The question is: how?
The actual code to do this is trivial, but where would we fit it into
the kernel?


Ohad suggested that we look at the regulator subsystem.  After having
a look I think this would be a hack at best. The docs say:

"The intention is to allow systems to dynamically control regulator power output
in order to save power and prolong battery life. This applies to both voltage
regulators (where voltage output is controllable) and current sinks (where
current limit is controllable)."

And indeed, the requirement that you're regulating current or voltage
comes all the way into the implementation.

In this case we are not changing current or voltage, we are just
asserting a specific signal to the card. So its messy from the start
(I'd have to invent a list of supported voltages or something).



Another option would be just to hack this into the kernel. Inside
mmc_power_up we'd add something like the following:

#ifdef CONFIG_OLPC
if (machine_is_olpc())
   olpc_reset_gpio_fixup(host);
#endif

And olpc_reset_gpio_fixup() would check that we're running on XO-1.5,
check that the host in question is the one where the wifi card is, and
do the GPIO twiddle.


Another cleaner option (but perhaps OTT for just 1 user?) would be to
add a notifier chain that is called at this point.
Then we'd add a whole new "driver" in drivers/mmc somewhere that
registers the appropriate notifier and handles this case.


Thoughts? Other ideas?

Thanks,
Daniel
