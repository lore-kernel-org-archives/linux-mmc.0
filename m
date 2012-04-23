From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [RFC 0/8] DMA engine conversion
Date: Mon, 23 Apr 2012 18:02:52 +0530
Message-ID: <CAMQu2gyQ3928VQ9Q9Y0mNiacB+br2oGezGCvhLXikbOTi-JR3Q@mail.gmail.com>
References: <20120418100954.GK25053@n2100.arm.linux.org.uk> <20120423114615.GB25053@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20120423114615.GB25053@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Mon, Apr 23, 2012 at 5:16 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Here's a patch which converts the SPI driver to use dma engine suppor=
t.
> It's more or less a mechanical replacement in this driver. =A0Tested =
on
> OMAP4430SDP ethernet (which basically means that udhcpc works.)
>
> One thing to note: the old DMA code programmed the DMA hardware for a=
n
> element count of N and frame size of 1, with element sync. =A0The DMA
> engine code will program the DMA hardware for an element count of 1 a=
nd
> a frame size of N, with frame sync. =A0This appears to work - but at =
the
> moment I've not looked to see if there's any implications of this.
>
> You can enable/disable the DMA engine code for the TX or RX side by
> tweaking the two definitions at the top of the file if you want to do
> comparisons.
>
> Comments? =A0If none, I'll see about committing this into the patch s=
et,
> adding the removal of the private DMA code, and sending it out more
> "officially" with the next round of RFC for this set.
>
Element sync vs Frame sync change seems to be fine thought it's
bit puzzling that why it was not that way first place.

> Modulo the element vs frame sync issue, I think folk can see that the
> conversion process is fairly straight forward - it's more or less:
> 1. add struct dma_chan * pointer to the private structure.
> 2. add allocation/freeing functions for the DMA engine channels.
> 3. convert the callbacks to match the DMA engine callback prototype.
> 4. add code to set the DMA engine channel configuration appropriately
> =A0 (avoiding any unnecessary calls) via dmaengine_slave_config().
> 5. add code to queue the transfer via dmaengine_prep_slave_sg() and
> =A0 dmaengine_submit().
> 6. omap_start_dma() becomes dma_async_issue_pending().
>
> =A0drivers/spi/spi-omap2-mcspi.c | =A0186 +++++++++++++++++++++++++++=
++++++-------
> =A01 files changed, 153 insertions(+), 33 deletions(-)

The patch seems to be fine to me.

Am looping Shubro in case he has any comment on "why element sync was u=
sed ?"
and also to test the patch with more peripherals connected over SPI.

Regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
