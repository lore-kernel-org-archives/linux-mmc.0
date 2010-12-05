From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: working around a Marvell wifi SDIO bug
Date: Sat, 04 Dec 2010 21:24:43 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1012042111570.10437@xanadu.home>
References: <AANLkTik2F_-g2beZT5mLe4+XSBL-HUKnceeKqtKQZC=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:11668 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755341Ab0LECYo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 4 Dec 2010 21:24:44 -0500
Received: from xanadu.home ([66.130.28.92]) by vl-mh-mrz21.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LCX00ESQO0SOD50@vl-mh-mrz21.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Sat, 04 Dec 2010 21:24:28 -0500 (EST)
In-reply-to: <AANLkTik2F_-g2beZT5mLe4+XSBL-HUKnceeKqtKQZC=g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: linux-mmc@vger.kernel.org

On Sat, 4 Dec 2010, Daniel Drake wrote:

> "According to a confidential Marvell AN, we should be asserting RESET
> externally after powering up the WLAN card. The Linux driver should
> assert WLAN_RESETn low for between 1 and 20 uS, about 1 mS after
> turning on power to the card"
> 
> While other users of this wifi card have WLAN_RESETn permanently wired
> low, OLPC has it wired to a GPIO. So we *can* do the above from the
> kernel, but its specific to this particular laptop.
> 
> The question is: how?
> The actual code to do this is trivial, but where would we fit it into
> the kernel?

That is the question indeed.

> Ohad suggested that we look at the regulator subsystem.  After having
> a look I think this would be a hack at best.

Whatever you do, that will be a hack.  And since this is trivial to hack 
the code to do what you want, the goal here is therefore to find a way 
to make that hack as elegant as possible.  And the regulator subsystem 
certainly allows you to make this hack look elegant, even if the 
intended purpose wasn't exactly that.

> In this case we are not changing current or voltage, we are just
> asserting a specific signal to the card. So its messy from the start
> (I'd have to invent a list of supported voltages or something).

You can pretend that you are changing voltage from null to a single 
fixed value.  And for that to happen properly you also need to assert a 
reset signal.  So in some twisted sense you do regulate proper power 
usage with that reset signal.

> Another option would be just to hack this into the kernel. Inside
> mmc_power_up we'd add something like the following:
> 
> #ifdef CONFIG_OLPC
> if (machine_is_olpc())
>    olpc_reset_gpio_fixup(host);
> #endif
> 
> And olpc_reset_gpio_fixup() would check that we're running on XO-1.5,
> check that the host in question is the one where the wifi card is, and
> do the GPIO twiddle.

No way.  That's the total opposite of elegance.  At least the regulator 
subsystem does provide a level of abstraction allowing you not to 
pollute the core driver code.

> Another cleaner option (but perhaps OTT for just 1 user?) would be to
> add a notifier chain that is called at this point.
> Then we'd add a whole new "driver" in drivers/mmc somewhere that
> registers the appropriate notifier and handles this case.

For only one user that's rather overkill.  Especially if an alternative 
already exists.


Nicolas
