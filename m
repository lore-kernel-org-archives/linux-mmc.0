From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH, RFC] MIPS: jz4740: use dma filter function
Date: Tue, 06 Jan 2015 14:48:27 +0100
Message-ID: <2633187.PyovTNc8DC@wuerfel>
References: <22569458.nE7JkNNnz3@wuerfel> <54ABBCE6.8060904@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54ABBCE6.8060904@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, dmaengine@vger.kernel.org, alsa-devel@alsa-project.org, linux-mmc@vger.kernel.org, linux-mips@linux-mips.org
List-Id: linux-mmc@vger.kernel.org

On Tuesday 06 January 2015 11:45:58 Lars-Peter Clausen wrote:
> On 01/05/2015 11:39 PM, Arnd Bergmann wrote:
> > As discussed on the topic of shmobile DMA today, jz4740 is the only
> > user of the slave_id field in dma_slave_config besides shmobile. This
> > use is really incompatible with the way that other drivers use the
> > dmaengine API, so we should get rid of it.
> 
> Do you have a link to that discussion?

http://www.spinics.net/lists/linux-mmc/msg30069.html

> > This adds a trivial filter function that uses the filter param to
> > pass the dma type, and uses that in both drivers.
> 
> In my opinion that's just from bad to worse. Using filter functions isn't 
> that great in the first place. And using them to pass data from the consumer 
> to the DMA provider is just a horrible abuse of the API.

I agree that it is quite horrible, but it is currently the only portable
way to use the API without DT. The solution to this is to use the
dma_request_slave_channel API, which was intentionally done in a way to allow
extending it in a nice way by passing just "rx" and "tx" (or whichever
string you choose) into the API and get back a channel that was connected
to the device by the platform. This already works with all DT based systems
and (to a limited extent) with ACPI, but nobody so far has implemented it
for devices that are instantiated through board files.

Anybody on ARM and PowerPC that is cleaning up their platform moves to DT,
so there hasn't been a need for that so far. My patch is the simplest
workaround, to make jz4740 work like all (legacy) ARM platforms. If you
plan to use DT for jz4740 in the long run, that would solve it nicely,
and as an alternative, one could implement the equivalent of
clk_register_clkdevs/regulator_consumer_supplies/... and hook that
up into dma_request_slave_channel_reason() as a third option.

> The patch also adds a platform dependency, so the drivers won't built with 
> COMPILE_TEST anymore.

That would be fixed by using proper platform_data to pass the filter and
arguments, which I hinted in my patch description. This is how drivers
are normally connected to a DMA engine.

	Arnd
