From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 8/8] ARM: omap_hsmmc: remove platform data dma_mask and
 initialization
Date: Wed, 18 Apr 2012 14:34:25 -0700
Message-ID: <20120418213425.GS21106@atomide.com>
References: <20120418100954.GK25053@n2100.arm.linux.org.uk>
 <E1SKRsg-0004bX-4w@rmk-PC.arm.linux.org.uk>
 <CANrkHUajRzoCp7K8L3cJArWN3xdqpft8L4k-o4gFTRTo8nmhmg@mail.gmail.com>
 <20120418152956.GP25053@n2100.arm.linux.org.uk>
 <CANrkHUYvKdBUZh9UmWcE30ywAAiqhN-KcnSAE2T56WJLFPX1gA@mail.gmail.com>
 <20120418194224.GS25053@n2100.arm.linux.org.uk>
 <20120418200214.GP21106@atomide.com>
 <20120418202447.GT25053@n2100.arm.linux.org.uk>
 <20120418210142.GR21106@atomide.com>
 <20120418211606.GU25053@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120418211606.GU25053@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "T Krishnamoorthy, Balaji" <balajitk@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [120418 14:19]:
> On Wed, Apr 18, 2012 at 02:01:44PM -0700, Tony Lindgren wrote:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [120418 13:28]:
> > > I'd like to have the same thing happen on OMAP1 as well (it's actually
> > > quite simple to do) and it means that this DMA engine implementation
> > > detail is (correctly) hidden from the drivers - provided there's no
> > > dependencies on each individual scatterlist entry back to the peripheral
> > > driver.
> > 
> > That would be nice. If the DMA engine driver can't dynamically adjust the
> > frame size for each SG entry, then maybe we can work around that by not doing
> > DMA for entries that are below the frame sizes?
> 
> I don't think it has to in this case, though I am thinking that we
> may have to adjust the frame size for other peripherals.
> 
> In the case of the OMAP1 MMC driver, let me pull out that chunk of code
> again:
> 
>         frame = data->blksz;
>         if (cpu_is_omap15xx() && frame > 32)
>                 frame = 32;
>         else if (frame > 64)
>                 frame = 64;
>         frame >>= 1;
>         if (!(data->flags & MMC_DATA_WRITE)) {
>                 buf = 0x800f | ((frame - 1) << 8);
>         } else {
>                 buf = 0x0f80 | ((frame - 1) << 0);
>         }
>         OMAP_MMC_WRITE(host, BUF, buf);
> 
> Nothing there depends on the size of an individual scatterlist entry -
> the dependencies for the frame size are the smaller of the FIFO size
> and the data block size.  I believe we can cope with that quite well on
> a per-transfer basis, and I _think_ we can get away with writing this
> BUF register just once per transfer (similar to what happens for PIO
> transfers.)

OK, let's see if that works :)
 
> However, this is going to be rather hit and miss for me - all I can do
> is create a patch and check that it builds.  I have no way (that I know
> of) to test this change as I don't have any OMAP1 nor OMAP2 hardware.

I can certainly test it on at least for 1710 on 770 and 2420 on N800.

Regards,

Tony
