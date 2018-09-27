From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH 2/2] mmc: Add mmc_force_detect_change_begin / _end
 functions
Date: Thu, 27 Sep 2018 10:14:53 +0200
Message-ID: <20180927081452.a2xw25sdoqtadntu@flea>
References: <CAPDyKFqDrdD+N+foLCwsVABtboz1Vn=OtJs14gp07zJfXHVKSA@mail.gmail.com>
 <f9028dcb-c217-4efc-60a7-d0a2c1804a08@exceet.de>
 <d9795fde-6bdd-b6fa-da41-839d44df6435@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d9795fde-6bdd-b6fa-da41-839d44df6435@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Frieder Schrempf <frieder.schrempf@exceet.de>, ulf.hansson@linaro.org, quentin.schulz@free-electrons.com, gregkh@linuxfoundation.org, linus.walleij@linaro.org, shawn.lin@rock-chips.com, adrian.hunter@intel.com, baolin.wang@linaro.org, thomas.petazzoni@free-electrons.com, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, devel@driverdev.osuosl.org, icenowy@aosc.xyz, wens@csie.org
List-Id: linux-mmc@vger.kernel.org

On Wed, Sep 26, 2018 at 10:19:22PM +0200, Hans de Goede wrote:
> On 26-09-18 16:44, Frieder Schrempf wrote:
> > Hi,
> > 
> > On Fri, Feb 09, 2018 at 03:01:00PM +0100, Ulf Hansson wrote:
> > > [...]
> > > 
> > > >> > I'd like to know if any progress has been made on that problem
> > (I may
> > > >> > have missed patches).
> > > >> > Had you had the time to look at the issue?
> > > >>
> > > >> I have looked at the issue, but not manage to cook some patches
> > for it.
> > > >>
> > > >> However, it's on my top of my TODO list for mmc. No promises, but
> > > >> perhaps and hopefully I manage to get something posted during the
> > > >> coming release cycle.
> > 
> > I would be interested in a ESP8089 driver in mainline and that's why I want to pick up this discussion.
> > 
> > What is the current status of the "mmc_reprobe_device" implementation, that Hans was explaining and Ulf wanted to provide some months ago?
> 
> Ulf did eventually write a new way to deal with this and then Quentin
> did manage to get the esp8089 driver to work with it, the new function
> to use for this is added by this commit:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/mmc/core?id=1433269c4d2461be1f36db5dbb453976b38996ff
> 
> I'm not sure what the status of upstreaming the ep8089 driver is now
> that we've this in place.
> 
> Quentin, do you have a version of the esp8089 driver somewhere
> which will work correctly with the new mmc_sw_reset() function?
> 
> Also what is the status of adding this driver to say staging?

IIRC, we tried to get it into staging, and we got told that it was too
nice for staging at this point. So we're basically stuck somewhere
between staging and !staging, with the driver being too nice for the
former, and not nice enough for the latter :)

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
