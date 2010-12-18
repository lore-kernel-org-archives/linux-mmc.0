From: David Vrabel <david.vrabel@csr.com>
Subject: Re: [linux-pm] subtle pm_runtime_put_sync race and sdio functions
Date: Sat, 18 Dec 2010 14:16:30 +0000
Message-ID: <4D0CC23E.6000509@csr.com>
References: <AANLkTikJr+0kVPE4aSwPjZWRfA3gRSNgGwzQdSwRpo_5@mail.gmail.com> <Pine.LNX.4.44L0.1012110937100.10743-100000@netrider.rowland.org> <AANLkTi=32bqipN5U00La-B7JSgTC1bHgMev=xUSF6kRN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from queue02.mail.zen.net.uk ([212.23.3.27]:47277 "EHLO
	queue02.mail.zen.net.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756227Ab0LROjY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 18 Dec 2010 09:39:24 -0500
In-Reply-To: <AANLkTi=32bqipN5U00La-B7JSgTC1bHgMev=xUSF6kRN@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@sisk.pl>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-mmc@vger.kernel.org, Ido Yariv <ido@wizery.com>

On 18/12/2010 13:29, Ohad Ben-Cohen wrote:
> 
> During system suspend, our driver is asked (by mac80211's suspend
> handler) to power off its device. When this happens, the driver has no
> idea that the system is suspending - regular driver code (responsible
> to remove the wlan interface and stop the device) is being called.
> Obviously pm_runtime_put_sync() won't power off the device at this
> point, but later during suspend, when the SDIO core will suspend, the
> device will be powered off and things would work as expected.
> 
> That breaks when the suspend transition is cancelled (e.g. due to an
> error) before SDIO core gets the chance to power off the device: the
> driver will be asked (by mac80211's resume handler) to power up the
> device and reinitialize it, but since the device was never powered
> off, the driver will fail doing so because the device is quiescent (a
> power cycle should have put him into a communicable state, but that
> never happened in this scenario).
> 
> At that resume point the device is always on - whether the system
> suspended successfully or not - and the driver can't tell whether the
> device was indeed powered off beforehand or not. In addition, the
> driver code that is going to fail is not a resume handler - it's just
> regular driver code responsible for powering on the device and
> reinitializing it (which is being called by mac80211's resume
> handler).

It's not clear where the problem is exactly.  It may be useful if you
describe the wi-fi chip's operational or power states and the valid
transitions between them.

Is the problem:

1. The suspend handler puts the wi-fi chip into a state that cannot be
recovered from without a power cycle?  The obvious solution would be to
not put the chip into such a state.

or

2. The resume handler fails because it cannot distinguish between a
wi-fi chip that needs reinitializing from power-on and one that is
already operational?  There is probably a chip register you can query to
determine if the chip was powered down or reset.  In the absense of any
suitable chip-specific register a CCCR register such as I/O Enable might
be usable.

David
