From: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
Subject: Re: [PATCH] mmc: Reduce fOD to 200 kHz if possible
Date: Wed, 15 Sep 2010 17:10:45 +0200
Message-ID: <20100915171045.53397db0@hskinnemoen-d830>
References: <1284541140-7328-1-git-send-email-haavard.skinnemoen@atmel.com>
	<9348108E-1108-46FE-8437-6F1271025C61@niasdigital.com>
	<20100915125138.1f25e4b1@hskinnemoen-d830>
	<4C90D8AB.9030606@yahoo.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relay.atmel.no ([194.19.124.36]:1332 "EHLO relay.atmel.no"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753940Ab0IOPLU (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 15 Sep 2010 11:11:20 -0400
In-Reply-To: <4C90D8AB.9030606@yahoo.es>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hein_Tibosch <hein_tibosch@yahoo.es>
Cc: Ben Nizette <bn@niasdigital.com>, linux-mmc@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Chris Ball <cjb@laptop.org>

Hein_Tibosch <hein_tibosch@yahoo.es> wrote:
> >> We've now submitted one fix each, mine was similar to yours [1] but there's been movement on Hein's more comprehensive patch recently [2].  I don't know who's supposed to be merging MMC patches atm, Chris Ball added on CC on a hunch.
> > Thanks for the references. IMO Hein's patch is overkill. There is
> > absolutely no reason why 200 kHz should be a problem on any setup, and
> > I haven't found any indication in any discussions that it is.
> >
> 
> I have also seen situations in which the SD will only start up at 180 Khz
> or lower.

Ok, so my patch would obviously not fix those. Could you tell me more
about those situations? What kind of board are you running at, etc?

> IMO my patch is indeed a bit of an overkill (the amount of code changed),
> I'd rather see a patch like yours or Ben's, but settings fOD at 100 or 50 Khz.

I guess 100 kHz would make sense. 50 kHz is not allowed according to
the SD card spec.

Another solution might be to introduce a new field, f_max_od, which the
host controller driver could use to limit the bus frequency in open
drain mode.

> It was Pierre who suggested to try several frequencies[1]: most systems will start
> using 400 Khz (so they won't suffer any loss of performance) and in some rare
> cases, the SD will only be identified at 100 Khz (which does happen, sometimes)

I think any performance hit in open drain mode is not likely to be
noticeable, as it is only used for a couple of commands. The only thing
that really matters for performance is push-pull mode, where too strong
pull-ups might cause problems at high speed.

But if there really are cards that have problems at 100 kHz, I guess
your patch might be the best bet.

Haavard
