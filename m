From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: Initial signal voltage ?
Date: Thu, 27 Aug 2015 17:16:37 +0000
Message-ID: <1440695797.3349.121.camel@transmode.se>
References: <1439225438.3120.94.camel@transmode.se>
	 <CAPDyKFpDzBV9zXAZH_KddZVdUQ_t2W3Qb3yG70ceagv4+oy7cQ@mail.gmail.com>
	 <1440505201.3349.59.camel@transmode.se>
	 <CAPDyKFpv3HyZSvGXWb-dzD1nec0173TyzegxRiWuhTdm9GdXAg@mail.gmail.com>
	 <1440686001.3349.115.camel@transmode.se>
	 <CAPDyKFrVNoyeHdcBbTJ3AFhU2EeWZsXqBkCqHNswWzCKxUOs=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.transmode.se ([31.15.61.139]:65043 "EHLO smtp.transmode.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751410AbbH0RQn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Aug 2015 13:16:43 -0400
In-Reply-To: <CAPDyKFrVNoyeHdcBbTJ3AFhU2EeWZsXqBkCqHNswWzCKxUOs=A@mail.gmail.com>
Content-Language: en-US
Content-ID: <E9EB18E4372EE44ABF0D54F093D1D3B5@transmode.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Thu, 2015-08-27 at 16:44 +0200, Ulf Hansson wrote:
> [...]
> 
> > > 
> > > Currently drivers return error codes according to when they can't set
> > > the requested voltage level, so that's all fine - right?
> > 
> > Yes, they should. Hovever it seems like my fsl controller cannot.
> > There is VS18,VS30 and VS33 bits in hostcap register but theses are
> > always set :(
> 
> If there are set in the *hostcap* register, doesn't that indicates
> that they are supported? Not what's currently used!?

hmm, this only shows that I am a newbie in this area :)
What register/bits normally holds this info?
> 
> What controller/driver are you using here?

esdhc,v3.0/sdhci-of-esdhc


> > > Moreover, the above code snippet is modified by you (or someone else)
> > > locally, since in the upstream version of the code, the prints are
> > 
> > ahh, yes a did that while debugging.
> > 
> > > done a debug level. That's also okay, I think.
> > > Perhaps changing the last print to warn level instead, since reaching
> > > that point would mean all attempts have failed.
> > 
> > Since not all controllers can tell what VS is you have to specify that, in my case I
> > do it in my device tree as there is a way to do that already.
> > 
> > So I think mmc_power_up() should mask away VS not supported and then try the remaining.
> > The exact way to do this escapes me as I am not familiar with this area yet.
> 
> Okay, I think we could potentially look at the host caps and figure
> out what IO voltage level the host supports before trying to set them.
> 
> Although it does complicates things, so before going there I just want
> to be sure that we really have an issue here.
> 
> I haven't yet really understood why your driver is unable to return
> error codes when failing to set an unsupported voltage level, you need
> to convince me on that.

None the less, the info is there in the host caps so why not use it?
If caps say 1.8V only why insist on trying 3/3.3 Volt?

 Jocke
