From: Luciano Coelho <coelho@ti.com>
Subject: Re: [PATCH 3/3] omap: board-sdp4430: declare support for
 MMC_PM_KEEP_POWER
Date: Mon, 28 Nov 2011 11:58:10 +0200
Message-ID: <1322474290.6502.53.camel@cumari>
References: <1321970539-7104-1-git-send-email-eliad@wizery.com>
	 <1321970539-7104-3-git-send-email-eliad@wizery.com>
	 <CAKd1q9pv5hMSpazYiZpmoowV52GvE7gFK5zUJSGpKhNkDZGuVg@mail.gmail.com>
	 <CAB3XZEenx7L07BYmrHGt0h9ZAY-LOpWXL+in0vs7XOoeBf_LUw@mail.gmail.com>
	 <1322471324.6502.32.camel@cumari>  <4ED353C5.7030704@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <4ED353C5.7030704@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Eliad Peller <eliad@wizery.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Chris Ball <cjb@laptop.org>, Russell King <linux@arm.linux.org.uk>
List-Id: linux-mmc@vger.kernel.org

On Mon, 2011-11-28 at 11:26 +0200, Igor Grinberg wrote: 
> Hi Luciano,

Hi Igor,


> On 11/28/11 11:08, Luciano Coelho wrote:
> > I may do it for panda later on, if I get the time to test it.  For
> > beagle, it doesn't really apply, because the wl12xx support is
> > out-of-tree, unfortunately. :(
> 
> If I understood correctly, you want to change all the
> board files supporting the wl12xx wifi chip to have this
> capability set, right?
> Isn't this immediately affects the power consumption in
> sleep state?
> Shouldn't this be runtime controllable?
> I bet there are many applications that do not care about WoW,
> but do care about the power consumption.
> How does this change affect them?

Good point, I don't know. :) Probably Eliad has the answer for that.

In any case, I don't see why this behaviour should be different in the
different board files.  If there is the problem of power consumption
while in suspend, we will have it also with the 4430sdp board.

I'm not sure about doing it dynamically, though.  I think it would be
more of a kernel configuration option or something.  At least the board
file is not the correct place to decide whether the wl12xx chip will
support WoW or not.  And, if we change only the MMC capabilities of the
wl12xx chip, we won't hurt other scenarios, when the wl12xx chip is not
in use.

-- 
Cheers,
Luca.

