From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [RFC 0/8] DMA engine conversion
Date: Mon, 23 Apr 2012 20:57:20 +0530
Message-ID: <4F9574D8.1000104@ti.com>
References: <20120418100954.GK25053@n2100.arm.linux.org.uk> <20120423114615.GB25053@n2100.arm.linux.org.uk> <CAMQu2gyQ3928VQ9Q9Y0mNiacB+br2oGezGCvhLXikbOTi-JR3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <CAMQu2gyQ3928VQ9Q9Y0mNiacB+br2oGezGCvhLXikbOTi-JR3Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Monday 23 April 2012 06:02 PM, Shilimkar, Santosh wrote:
>> conversion process is fairly straight forward - it's more or less:
>> > 1. add struct dma_chan * pointer to the private structure.
>> > 2. add allocation/freeing functions for the DMA engine channels.
>> > 3. convert the callbacks to match the DMA engine callback prototype.
>> > 4. add code to set the DMA engine channel configuration appropriately
>> >   (avoiding any unnecessary calls) via dmaengine_slave_config().
>> > 5. add code to queue the transfer via dmaengine_prep_slave_sg() and
>> >   dmaengine_submit().
>> > 6. omap_start_dma() becomes dma_async_issue_pending().
>> >
>> >  drivers/spi/spi-omap2-mcspi.c |  186 +++++++++++++++++++++++++++++++++-------
>> >  1 files changed, 153 insertions(+), 33 deletions(-)
> The patch seems to be fine to me.
>
> Am looping Shubro in case he has any comment on "why element sync was used ?"
> and also to test the patch with more peripherals connected over SPI.
>
> Regards
> Santosh
Tested on omap4 ethernet and omap3 touchscreen
also did a spidev test.

Tested-by: Shubhrajyoti <shubhrajyoti@ti.com <mailto:shubhrajyoti@ti.com>>
