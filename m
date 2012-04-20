From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 8/8] ARM: omap_hsmmc: remove platform data dma_mask and
	initialization
Date: Fri, 20 Apr 2012 16:37:43 +0100
Message-ID: <20120420153743.GB24205@n2100.arm.linux.org.uk>
References: <20120418200214.GP21106@atomide.com> <20120418202447.GT25053@n2100.arm.linux.org.uk> <20120418210142.GR21106@atomide.com> <20120418211606.GU25053@n2100.arm.linux.org.uk> <20120418213642.GV25053@n2100.arm.linux.org.uk> <20120419013914.GV21106@atomide.com> <20120419174332.GY25053@n2100.arm.linux.org.uk> <20120419180741.GX21106@atomide.com> <20120420151034.GA24205@n2100.arm.linux.org.uk> <20120420152623.GA21106@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120420152623.GA21106@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, "T Krishnamoorthy, Balaji" <balajitk@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Fri, Apr 20, 2012 at 08:26:25AM -0700, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [120420 08:15]:
> > On Thu, Apr 19, 2012 at 11:07:42AM -0700, Tony Lindgren wrote:
> > > There's some information in the omap5912 trm on pages 717 and 718:
> > > 
> > > http://www.ti.com/litv/pdf/spru742
> > > 
> > > It says for CSDP source port "This field identifies the port originator of
> > > the transfer."
> > 
> > Is there a reason not to use EMIFF as for the memory port for any DMA
> > activity between a peripheral and system (kernel) memory?
> 
> I don't think we have any device to device cases, and it's unlikely that
> we'll get them either.
>  
> > It looks to me like TIPB is the right port to use for anything except
> > camera and LCD?
> >
> > If that's true, we can solve the memory side of the problem very easily -
> > we know that prep_slave_sg() will always souce from system memory, so
> > the port for that will be known.
> 
> OK
>  
> > For the peripheral side of the transfer, I think we should case this on
> > the request signal as the combinations seem to be very limited - and it
> > looks like this knowledge is specific to the DMA controller rather than
> > the peripheral.
> 
> OK sounds good to me.

Okay, so this turns out to be really quite simple as the first step - as
below.  This makes us always use EMIFF for the memory side, and TIPB for
the peripherals, which won't be a problem until we start thinking about
camera and LCD.

I'm not going to conditionalise their use because they're merely ignored
by arch/arm/plat-omap/dma.c on non-OMAP1 targets, so having this driver
set them to zero for non-OMAP1 makes little sense (other than just making
things unnecessarily more complicated.)

So, with this patch plus my original patch to omap's mmc host driver, this
should result in something which works without all the overhead of drivers
supplying the port information.  Please confirm, and I'll merge this into
the original omap-dma.c commit.

Thanks.

 drivers/dma/omap-dma.c |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index 5b12f74..ed1b8f5 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -52,6 +52,7 @@ struct omap_desc {
 	uint8_t es;		/* element size */
 	uint8_t sync_mode;	/* OMAP_DMA_SYNC_xxx */
 	uint8_t sync_type;	/* OMAP_DMA_xxx_SYNC* */
+	uint8_t periph_port;	/* Peripheral port */
 
 	unsigned sglen;
 	struct omap_sg sg[0];
@@ -83,11 +84,11 @@ static void omap_dma_start_sg(struct omap_chan *c, struct omap_desc *d,
 	struct omap_sg *sg = d->sg + idx;
 
 	if (d->dir == DMA_DEV_TO_MEM)
-		omap_set_dma_dest_params(c->dma_ch, 0, OMAP_DMA_AMODE_POST_INC,
-				sg->addr, 0, 0);
+		omap_set_dma_dest_params(c->dma_ch, d->periph_port,
+			OMAP_DMA_AMODE_POST_INC, sg->addr, 0, 0);
 	else
-		omap_set_dma_src_params(c->dma_ch, 0, OMAP_DMA_AMODE_POST_INC,
-				sg->addr, 0, 0);
+		omap_set_dma_src_params(c->dma_ch, d->periph_port,
+			OMAP_DMA_AMODE_POST_INC, sg->addr, 0, 0);
 
 	omap_set_dma_transfer_params(c->dma_ch, d->es, sg->en, sg->fn,
 		d->sync_mode, c->dma_sig, d->sync_type);
@@ -111,11 +112,11 @@ static void omap_dma_start_desc(struct omap_chan *c)
 	c->sgidx = 0;
 
 	if (d->dir == DMA_DEV_TO_MEM)
-		omap_set_dma_src_params(c->dma_ch, 0, OMAP_DMA_AMODE_CONSTANT,
-			d->dev_addr, 0, 0);
+		omap_set_dma_src_params(c->dma_ch, OMAP_DMA_PORT_EMIFF,
+			OMAP_DMA_AMODE_CONSTANT, d->dev_addr, 0, 0);
 	else
-		omap_set_dma_dest_params(c->dma_ch, 0, OMAP_DMA_AMODE_CONSTANT,
-			d->dev_addr, 0, 0);
+		omap_set_dma_dest_params(c->dma_ch, OMAP_DMA_PORT_EMIFF,
+			OMAP_DMA_AMODE_CONSTANT, d->dev_addr, 0, 0);
 
 	omap_dma_start_sg(c, d, 0);
 }
@@ -269,6 +270,7 @@ static struct dma_async_tx_descriptor *omap_dma_prep_slave_sg(
 	d->es = es;
 	d->sync_mode = OMAP_DMA_SYNC_FRAME;
 	d->sync_type = sync_type;
+	d->periph_port = OMAP_DMA_PORT_TIPB;
 
 	/*
 	 * Build our scatterlist entries: each contains the address,

