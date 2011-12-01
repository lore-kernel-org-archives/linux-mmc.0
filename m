From: "Joe Woodward" <jw@terrafix.co.uk>
Subject: Re: mmc: sdio: runtime PM and 8686 problems
Date: Thu, 01 Dec 2011 11:29:05 +0000
Message-ID: <WC20111201112905.8702EB@terrafix.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.keele.netcentral.co.uk ([212.57.235.197]:55811 "EHLO
	smtp3.keele.netcentral.co.uk" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1752257Ab1LALa1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Dec 2011 06:30:27 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Daniel Drake <dsd@laptop.org>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

I've had a play with the nRESET line (as far as I can tell it is the only pin I have access to), and no joy.

Also tried playing about a bit with the CMD sequence, again no joy.

I'm not entirely sure of the CMD sequence. It seems we get:
  - CMD52 (x2)
  - CMD0
  - CMD8 (fails)
  - CMD5 (fails)

In the "SDIO Simplified Specification Version 2.00" (https://www.sdcard.org/developers/overview/sdio/sdio_spec/Simplified_SDIO_Card_Spec.pdf) page 6 it seems only a CMD52 should be required to "Re-init IO". Previous thread posts state CMD5 (x2) are required by the 8686, but why CMD0/CMD8?

Incidentally errors only occur after the CMD0, but before the first error we get (i.e. a change of cs from 1 to 0):
"mmc1: clock 400000Hz busmode 2 powermode 2 cs 0 Vdd 20 width 0 timing 0".

Any thoughts?

I think we've probably hit the end of the line here, unless someone else pops up who knows more about the Gumstix (i.e. has access to a schematic) or the W2CBW003 and it's SD8686 internals.

Thanks for the help anyway chaps!

Cheers,
Joe


-----Original Message-----
From: Ohad Ben-Cohen <ohad@wizery.com>
To: Joe Woodward <jw@terrafix.co.uk>
Cc: Daniel Drake <dsd@laptop.org>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Date: Thu, 1 Dec 2011 10:07:24 +0200
Subject: Re: mmc: sdio: runtime PM and 8686 problems

> On Wed, Nov 30, 2011 at 5:00 PM, Joe Woodward <jw@terrafix.co.uk>
> wrote:
> > It seems CMD5 fails (which seems to be what the workarounds were
> aiming to fix).
> 
> Right; you get a timeout (-110), which means the 8686 didn't send any
> response.
> 
> This is unexpected because the sdio reset (the CMD52 you see before
> the init sequence) should be enough to reset the device (we confirmed
> this with the Marvell folks on this list awhile ago).
> 
> > I'm afraid I may not be of much more use as Gumstix (annoyingly)
> don't release schematics of their COMs, so actually probing any signals
> isn't really possible.
> 
> Yes, it makes it difficult to debug.
> 
> You can try to verify (in the code) that all the text book
> prerequisites are there (e.g. all SDIO lines are pulled up and muxed
> correctly. though since stuff work for you without SDIO runtime PM, I
> assume these are ok), and maybe even play a bit with stuff like
> delays, sdio resets and power cycles and see if things change. If you
> have access to the other inputs of the 8686 (it has several of them
> which are related to power and resets. Neither me nor Daniel have
> intimate knowledge about what any of those really do, but you could
> dig some info from emails send by Marvell folks on this list), then
> you can also try to play with them and see if things change. With
> luck, you could learn more about the problem and can hopefully get
> closer to finding a solution.
> 
> It could be great if a solution will be found, but if not, we'll
> probably have to proceed with the revert...
> 
> Good luck!
> Ohad.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


