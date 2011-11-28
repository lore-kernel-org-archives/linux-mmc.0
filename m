From: Luciano Coelho <coelho@ti.com>
Subject: Re: [PATCH 3/3] omap: board-sdp4430: declare support for
 MMC_PM_KEEP_POWER
Date: Mon, 28 Nov 2011 11:08:44 +0200
Message-ID: <1322471324.6502.32.camel@cumari>
References: <1321970539-7104-1-git-send-email-eliad@wizery.com>
	 <1321970539-7104-3-git-send-email-eliad@wizery.com>
	 <CAKd1q9pv5hMSpazYiZpmoowV52GvE7gFK5zUJSGpKhNkDZGuVg@mail.gmail.com>
	 <CAB3XZEenx7L07BYmrHGt0h9ZAY-LOpWXL+in0vs7XOoeBf_LUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:55712 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752840Ab1K1JIx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Nov 2011 04:08:53 -0500
In-Reply-To: <CAB3XZEenx7L07BYmrHGt0h9ZAY-LOpWXL+in0vs7XOoeBf_LUw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Eliad Peller <eliad@wizery.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Chris Ball <cjb@laptop.org>, Russell King <linux@arm.linux.org.uk>

On Mon, 2011-11-28 at 10:26 +0200, Eliad Peller wrote: 
> On Mon, Nov 28, 2011 at 9:50 AM, Coelho, Luciano <coelho@ti.com> wrote:
> > On Tue, Nov 22, 2011 at 4:02 PM, Eliad Peller <eliad@wizery.com> wrote:
> >> Declare support for keeping the power of the wlan chip
> >> while suspended. this is needed for Wakeup-On-Wireless.
> >>
> >> Signed-off-by: Eliad Peller <eliad@wizery.com>
> >> ---
> >>  arch/arm/mach-omap2/board-4430sdp.c |    1 +
> >>  1 files changed, 1 insertions(+), 0 deletions(-)
> >
> > What about all the other board files that also have this structure?
> > For example board-omap4panda.c? I think they should all be changed and
> > the change should also be communicated more broadly for those board
> > files which (unfortunately) are not upstream (or which are upstream
> > but without the wl12xx-specific definitions on it, such as Beagle).
> >
> i preferred adding this capability only for boards i can test.
> unfortunately, i don't a panda/beagle setup.
> anyway, i don't think we have to add it all at once.
> let's just do it one board at a time... i'll add support for zoom as
> well. any volunteers for panda/beagle? ;)

Hmmm, okay, there is logic in that for the pragmatic, but this seems to
be so clearly what is needed to solve the same problem with other boards
that it could deserve changing all the board files.  In practice, your
changes may affect all the other boards too, regardless of whether you
set the new flag or not.  In any case, not my call here.

I may do it for panda later on, if I get the time to test it.  For
beagle, it doesn't really apply, because the wl12xx support is
out-of-tree, unfortunately. :(

-- 
Cheers,
Luca.

