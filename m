From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: Initial signal voltage ?
Date: Thu, 27 Aug 2015 14:33:21 +0000
Message-ID: <1440686001.3349.115.camel@transmode.se>
References: <1439225438.3120.94.camel@transmode.se>
	 <CAPDyKFpDzBV9zXAZH_KddZVdUQ_t2W3Qb3yG70ceagv4+oy7cQ@mail.gmail.com>
	 <1440505201.3349.59.camel@transmode.se>
	 <CAPDyKFpv3HyZSvGXWb-dzD1nec0173TyzegxRiWuhTdm9GdXAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.transmode.se ([31.15.61.139]:61806 "EHLO smtp.transmode.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752033AbbH0Od0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Aug 2015 10:33:26 -0400
In-Reply-To: <CAPDyKFpv3HyZSvGXWb-dzD1nec0173TyzegxRiWuhTdm9GdXAg@mail.gmail.com>
Content-Language: en-US
Content-ID: <5AE5C71C5547CD45A3F6F3EE9BB371ED@transmode.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Thu, 2015-08-27 at 16:01 +0200, Ulf Hansson wrote:
> On 25 August 2015 at 14:20, Joakim Tjernlund
> <joakim.tjernlund@transmode.se> wrote:
> > On Tue, 2015-08-25 at 14:05 +0200, Ulf Hansson wrote:
> > > On 10 August 2015 at 18:50, Joakim Tjernlund
> > > <joakim.tjernlund@transmode.se> wrote:
> > > > in mmc_power_up() we have:
> > > >         /* Try to set signal voltage to 3.3V but fall back to 1.8v or 1.2v */
> > > >         if (__mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_330) == 0)
> > > >                 dev_err(mmc_dev(host), "Initial signal voltage of 3.3v\n");
> > > >         else if (__mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180) == 0)
> > > >                 dev_err(mmc_dev(host), "Initial signal voltage of 1.8v\n");
> > > >         else if (__mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_120) == 0)
> > > >                 dev_err(mmc_dev(host), "Initial signal voltage of 1.2v\n");
> > > > 
> > > > Here one jut brutally tries to set the initial power to 3.3 but nowhere in
> > > > general code there is a check if the controller can handle this w.r.t
> > > > HOST CAPS.
> > > 
> > > You are right, it's brutal. :-)
> > > 
> > > Perhaps the host driver should return -EINVAL when a voltage level
> > > can't be reached. The above code should not print messages as errors,
> > > at least as long some voltage level can be used.
> > > 
> > > > Where should this check be performed, I am guessing either here or in sdhci?
> > > > This is all new to me so I am just throwing this out there
> > > 
> > > Do you want to send a patch?
> > 
> > No, you didn't answer the question
> 
> Sorry for being a bit vague. I looked a bit more into this.
> 
> Currently drivers return error codes according to when they can't set
> the requested voltage level, so that's all fine - right?

Yes, they should. Hovever it seems like my fsl controller cannot.
There is VS18,VS30 and VS33 bits in hostcap register but theses are
always set :(

> 
> Moreover, the above code snippet is modified by you (or someone else)
> locally, since in the upstream version of the code, the prints are

ahh, yes a did that while debugging.

> done a debug level. That's also okay, I think.
> Perhaps changing the last print to warn level instead, since reaching
> that point would mean all attempts have failed.

Since not all controllers can tell what VS is you have to specify that, in my case I
do it in my device tree as there is a way to do that already.

So I think mmc_power_up() should mask away VS not supported and then try the remaining.
The exact way to do this escapes me as I am not familiar with this area yet.

 Jocke