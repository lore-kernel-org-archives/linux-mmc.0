From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 8/8] ARM: omap_hsmmc: remove platform data dma_mask and
 initialization
Date: Fri, 20 Apr 2012 08:26:25 -0700
Message-ID: <20120420152623.GA21106@atomide.com>
References: <20120418194224.GS25053@n2100.arm.linux.org.uk>
 <20120418200214.GP21106@atomide.com>
 <20120418202447.GT25053@n2100.arm.linux.org.uk>
 <20120418210142.GR21106@atomide.com>
 <20120418211606.GU25053@n2100.arm.linux.org.uk>
 <20120418213642.GV25053@n2100.arm.linux.org.uk>
 <20120419013914.GV21106@atomide.com>
 <20120419174332.GY25053@n2100.arm.linux.org.uk>
 <20120419180741.GX21106@atomide.com>
 <20120420151034.GA24205@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120420151034.GA24205@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, "T Krishnamoorthy, Balaji" <balajitk@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [120420 08:15]:
> On Thu, Apr 19, 2012 at 11:07:42AM -0700, Tony Lindgren wrote:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [120419 10:46]:
> > > On Wed, Apr 18, 2012 at 06:39:14PM -0700, Tony Lindgren wrote:
> > > > Cool, you almost got it. Got it working for n800 and 770 with the following
> > > > patch. Only extremely light testing done now so careful with this patch too..
> > > > 
> > > > Had to hack in support for the src_port and dst_port that's needed for
> > > > omap_set_dma_src/dest_params on omap1.
> > > 
> > > What's the relationship between these ports and the DMA request signal?
> > > Is there a document which describes this?
> > 
> > It's the source and destination addresses bus port, so it's more related
> > to the addresses than request signal. I guess routing of the DMA request
> > signal is what it really does.
> > 
> > I'm now wondering if it might be possible to set it automatically based on
> > source and destination address.

There's probably some latency involved that requires setting the src
and dst port earlier, so I doubt that setting it automatically based on
the src and dst address would work correctly.

> > There's some information in the omap5912 trm on pages 717 and 718:
> > 
> > http://www.ti.com/litv/pdf/spru742
> > 
> > It says for CSDP source port "This field identifies the port originator of
> > the transfer."
> 
> Is there a reason not to use EMIFF as for the memory port for any DMA
> activity between a peripheral and system (kernel) memory?

I don't think we have any device to device cases, and it's unlikely that
we'll get them either.
 
> It looks to me like TIPB is the right port to use for anything except
> camera and LCD?
>
> If that's true, we can solve the memory side of the problem very easily -
> we know that prep_slave_sg() will always souce from system memory, so
> the port for that will be known.

OK
 
> For the peripheral side of the transfer, I think we should case this on
> the request signal as the combinations seem to be very limited - and it
> looks like this knowledge is specific to the DMA controller rather than
> the peripheral.

OK sounds good to me.

Regards,

Tony
