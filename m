From: Stephen Warren <swarren@nvidia.com>
Subject: Re: [RFC PATCH 0/3] If an IRQ is a GPIO,
	request and configure it
Date: Fri, 5 Aug 2011 12:33:31 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF049F171FD3@HQMAIL01.nvidia.com>
References: <1312498820-2275-1-git-send-email-swarren@nvidia.com>
	<20110805094017.GC20575@n2100.arm.linux.org.uk>
	<74CDBE0F657A3D45AFBB94109FB122FF049F171EFC@HQMAIL01.nvidia.com>
	<20110805191504.GB28958@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20110805191504.GB28958@n2100.arm.linux.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "ccross@android.com" <ccross@android.com>, "olof@lixom.net" <olof@lixom.net>, Thomas Gleixner <tglx@linutronix.de>, Chris Ball <cjb@laptop.org>, Liam Girdwood <lrg@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

Russell King - ARM Linux wrote at Friday, August 05, 2011 1:15 PM:
> On Fri, Aug 05, 2011 at 08:43:20AM -0700, Stephen Warren wrote:
> > Russell King - ARM Linux wrote at Friday, August 05, 2011 3:40 AM:
> > > On Thu, Aug 04, 2011 at 05:00:17PM -0600, Stephen Warren wrote:
> > > > In http://www.spinics.net/lists/linux-tegra/msg01731.html, Mark Brown
> > > > pointed out that it was a little silly forcing every board or driver
> > > > to gpio_request() a GPIO that is later converted to an IRQ, and passed
> > > > to request_irq. The first patch in this series instead makes the core
> > > > IRQ code perform these calls when appropriate, to avoid duplicating it
> > > > everywhere.
> > >
> > > Trying to go from IRQ to GPIO is not a good idea - most of the
> > > IRQ <-> GPIO macros we have today are just plain broken.  Many of them
> > > just add or subtract a constant, which means non-GPIO IRQs have an
> > > apparant GPIO number too.  Couple this with the fact that all positive
> > > GPIO numbers are valid, and this is a recipe for wrong GPIOs getting
> > > used and GPIOs being requested for non-GPIO IRQs.
> > >
> > > I think this was also discussed in the past, and the conclusion was that
> > > IRQs should be kept separate from GPIOs.  Maybe views have changed since
> > > then...
> > >
> > > However, if we do want to do this, then it would be much better to provide
> > > a new API for requesting GPIO IRQs, eg:
> > >
> > > gpio_request_irq()
> > >
> > > which would wrap around request_threaded_irq(), takes a GPIO number,
> > > does the GPIO->IRQ conversion internally, and whatever GPIO setup is
> > > required.  Something like this:
> >
> > With that approach, drivers need to explicitly know whether they're
> > passed a GPIO or an IRQ, and do something different, or they need to
> > choose to only accept a GPIO or IRQ.
> 
> You completely missed the biggest reason why your approach is broken.

No, I didn't.

I was discussing whether an alternative API for IRQ registration
would work, and I was pointing out some problems with it.

That has nothing to do with whether my original proposal is workable.

-- 
nvpublic
