From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [RFC PATCH 0/21] Totally remove
 SDHCI_QUIRK_BROKEN_CARD_DETECTION quirk
Date: Thu, 28 Jan 2016 15:54:44 +0000
Message-ID: <20160128155444.04d72b47@lxorguk.ukuu.org.uk>
References: <1453871155-3283-1-git-send-email-shawn.lin@rock-chips.com>
	<56A8BF22.8010509@intel.com>
	<20160127132348.GY10826@n2100.arm.linux.org.uk>
	<CAPDyKFr0MT5xa87F=4LPX7WbNuD0THndTDkvhL9N0h6A5g67eg@mail.gmail.com>
	<56A97A27.4000501@rock-chips.com>
	<20160128112946.4d750fae@lxorguk.ukuu.org.uk>
	<CAPDyKFpF6k8My4AZ+sofTBb78_dPDBTRnWH_6gLvbSktOyMnKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:58900 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967620AbcA1Pzp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Jan 2016 10:55:45 -0500
In-Reply-To: <CAPDyKFpF6k8My4AZ+sofTBb78_dPDBTRnWH_6gLvbSktOyMnKg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Adrian Hunter <adrian.hunter@intel.com>, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, 28 Jan 2016 16:03:34 +0100
Ulf Hansson <ulf.hansson@linaro.org> wrote:

> [...]
> 
> >  
> >> > of it's bad code structure. Therefore I have taken a quite simple
> >> > approach by rejecting new callbacks and quirks, in a way to prevent it
> >> > from being worse.  
> >
> > Which merely guarantees that the problem gets worse, because everyone
> > just puts their SD patches into Android trees instead and then when that
> > device is needed in Linux proper the crap hits the fan or people write
> > uglier and more hideous hacks buried elsewhere.
> >
> > Eventually something gives way, and it will always be the maintainer,
> > because everyone needs to get their devices supported. You can guide new
> > callbacks in constructive ways but not stop them.  
> 
> Well, I did stop them at least temporary.

I always describe it as "putting a cork in the sewerage pipe". It might
stop it for a bit but

a) you don't want to be too close when it breaks
b) it's not good what happens further up the pipe

> 
> Although, I have been telling people *why* and also trying to give
> some guidelines of how I wanted this to move forward.
> 
> I understand some become frustrated from getting patches nacked like this.
> 
> In principle I have requested them to help evolving sdhci in a new and
> better direction, instead of adding yet more hacks. That of course
> requires a deeper understanding of both the mmc core, but also sdhci
> in general.
> 
> [...]
> 
> Also, thanks for sharing your experience in this field. You made some
> good points!

I'm happy to help try and sort the code out. Not maintain it - my
knowledge of the intricacies of SDHCI is not good enough.

Alan
