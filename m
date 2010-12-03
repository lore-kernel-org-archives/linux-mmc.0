From: Michal Miroslaw <mirq-linux@rere.qmqm.pl>
Subject: Re: [PATCH v4] mmc: Make ID freq configurable
Date: Fri, 3 Dec 2010 07:56:12 +0100
Message-ID: <20101203065612.GA9779@rere.qmqm.pl>
References: <4C80187D.9000304@yahoo.es> <1291288582.15187.91.camel@stummala-linux.in.qualcomm.com> <4CF80DC6.1020801@yahoo.es> <20101202223812.GA2685@rere.qmqm.pl> <1c6eadd860e1a9085336bf75a2a96eb3.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from rere.qmqm.pl ([89.167.52.164]:39256 "EHLO rere.qmqm.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754475Ab0LCG4P (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 3 Dec 2010 01:56:15 -0500
Content-Disposition: inline
In-Reply-To: <1c6eadd860e1a9085336bf75a2a96eb3.squirrel@www.codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: stummala@codeaurora.org
Cc: Hein_Tibosch <hein_tibosch@yahoo.es>, Andrew Morton <akpm@linux-foundation.org>, Pierre Ossman <pierre@ossman.eu>, Chris Ball <cjb@laptop.org>, Ben Nizette <bn@niasdigital.com>, Sascha Hauer <s.hauer@pengutronix.de>, Adrian Hunter <adrian.hunter@nokia.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Matt Fleming <matt@console-pimps.org>

On Thu, Dec 02, 2010 at 09:05:54PM -0800, stummala@codeaurora.org wrote=
:
> Hi Michal,
[...]
> >> > In case of SDIO error, mmc_power_off() is getting called as part=
 of
> >> > mmc_detach_bus().  Shouldn't we power up the host before checkin=
g for
> >> > SDMEM? Any comments?
> >> I think you should ask Michal Miroslaw, as he wrote the patch for =
the
> >> SD-combo (IO + mem)*
> >>
> >> But yes, in case of a failure, mmc_attach_sdio() will call
> >> mmc_detach_bus()
> >> which in turn will call mmc_power_off()
> >>
> >> And so it should be mmc_power_up() again before trying to detect S=
D
> >> memory.
> > Yes, you are right!  This explains some things...
> >
> > Please try attached patch. (Not tested, but obvious enough.)
> I was looking at the code and figured out this issue. I don't have an=
y
> SD-combo card to verify your patch.

You shouldn't be able to use this code path with normal SD-combo cards.
This is relevant if you have a card that responds to CMD5 but then fail=
s
SDIO part initialization in some circumstances (i.e. time-outs).

Best Regards,
Micha=B3 Miros=B3aw
