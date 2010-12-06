From: Philip Rakity <prakity@marvell.com>
Subject: RE: working around a Marvell wifi SDIO bug
Date: Sun, 5 Dec 2010 20:37:07 -0800
Message-ID: <43E4817426ED174AA81263BCECB4351D13200C556E@sc-vexch3.marvell.com>
References: <AANLkTik2F_-g2beZT5mLe4+XSBL-HUKnceeKqtKQZC=g@mail.gmail.com>,<AANLkTinPbGcxOU8w_Wy3YVe-QOYpmQm+K7sgRHd-K2vp@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:40700 "HELO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753105Ab0LFEiX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 5 Dec 2010 23:38:23 -0500
In-Reply-To: <AANLkTinPbGcxOU8w_Wy3YVe-QOYpmQm+K7sgRHd-K2vp@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>, Daniel Drake <dsd@laptop.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


I have seen this solved using rfkill.  Is that acceptable?
________________________________________
From: linux-mmc-owner@vger.kernel.org [linux-mmc-owner@vger.kernel.org] On Behalf Of Ohad Ben-Cohen [ohad@wizery.com]
Sent: Sunday, December 05, 2010 6:15 AM
To: Daniel Drake
Cc: linux-mmc@vger.kernel.org
Subject: Re: working around a Marvell wifi SDIO bug

On Sat, Dec 4, 2010 at 6:22 PM, Daniel Drake <dsd@laptop.org> wrote:
> In this case we are not changing current or voltage, we are just
> asserting a specific signal to the card. So its messy from the start
> (I'd have to invent a list of supported voltages or something).

This is exactly what we do today with the 12xx - we just need to
assert a digital signal, which by no means power the device (the
voltage value we provide isn't really fed from the gpio signal).

Your case might be slightly different, but still I think it's worth
looking into this approach first.

> Another option would be just to hack this into the kernel. Inside
> mmc_power_up we'd add something like the following:
>
> #ifdef CONFIG_OLPC
> if (machine_is_olpc())
>   olpc_reset_gpio_fixup(host);
> #endif

Please don't.

Core code should not contain such machine-specific details (imagine
how it would look when other boards will start adding this 8686
tweak...).

> Another cleaner option (but perhaps OTT for just 1 user?) would be to
> add a notifier chain that is called at this point.

That would obviously work but as you and Nicolas mentioned it's an
overkill: we don't really need random users to plug into this hook,
and using notifiers will just make the code less readable and harder
to debug, so it's better to try to find a solution that fits.
--
To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
