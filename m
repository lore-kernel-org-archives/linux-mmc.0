From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC 00/12] OMAP DMA engine conversion
Date: Wed, 25 Apr 2012 00:29:29 +0100
Message-ID: <20120424232928.GB6290@n2100.arm.linux.org.uk>
References: <20120423160409.GE24299@n2100.arm.linux.org.uk> <20120424103858.GC25053@n2100.arm.linux.org.uk> <20120424165147.GP3739@atomide.com> <CANOLnOOf0znGBSSQp5B3U+1q2OJBXnB_1T0aiuma_rJZDZA08Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CANOLnOOf0znGBSSQp5B3U+1q2OJBXnB_1T0aiuma_rJZDZA08Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Wed, Apr 25, 2012 at 01:47:21AM +0300, Grazvydas Ignotas wrote:
> On Tue, Apr 24, 2012 at 7:51 PM, Tony Lindgren <tony@atomide.com> wro=
te:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [120424 03:42]:
> >> Here's another patch - for the OMAP NAND driver.
> >>
> >> One thing this doesn't do is configure up the source/destination b=
ursts,
> >> which the old code did:
> >>
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_set_dma_dest_=
burst_mode(info->dma_ch,
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 OMAP_DMA_DATA_BURST_16);
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_set_dma_src_b=
urst_mode(info->dma_ch,
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 OMAP_DMA_DATA_BURST_16);
> >
> > Grazvydas, care to give this patch a go?
>=20
> Tested-by: Grazvydas Ignotas <notasas@gmail.com>
> for:
> - SD card connected over transceiver to MMC2
> - touchscreen connected over SPI
> - NAND on GPMC in DMA mode
> Seems to be working just as they did before, except that I'm not sure
> SPI was crossing PIO threshold.

I think my testing on OMAP4430SDP with the SPI based ethernet should've
caught anything untoward there.

=46or the MMC2, could you say whether this was the hsmmc driver or the
older omap1/2 driver please?

Thanks.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
