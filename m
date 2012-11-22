From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: mmci: Support non-power-of-two block sizes for
 ux500v2 variant
Date: Thu, 22 Nov 2012 14:43:10 +0100
Message-ID: <CAPDyKFq4dBfP0ruxB-rQKruiXfk0iDLo5OKCkSQ4idK_gg1-Lg@mail.gmail.com>
References: <1350050522-8852-1-git-send-email-ulf.hansson@stericsson.com>
 <20121121153811.GN3290@n2100.arm.linux.org.uk>
 <CAFEEs1kzJUgsvnzgWwU4i7o1jkE=8iTq5+NJ_t1jdiHEm7b-RQ@mail.gmail.com>
 <20121121165048.GO3290@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20121121165048.GO3290@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Per Forlin <per.lkml@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@stericsson.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On 21 November 2012 17:50, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Nov 21, 2012 at 05:13:55PM +0100, Per Forlin wrote:
>> On Wed, Nov 21, 2012 at 4:38 PM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > On Fri, Oct 12, 2012 at 04:02:02PM +0200, Ulf Hansson wrote:
>> >>  /*
>> >> + * Validate mmc prerequisites
>> >> + */
>> >> +static int mmci_validate_data(struct mmci_host *host,
>> >> +                           struct mmc_data *data)
>> >> +{
>> >> +     if (!data)
>> >> +             return 0;
>> >> +
>> >> +     if (!host->variant->non_power_of_2_blksize &&
>> >> +         !is_power_of_2(data->blksz)) {
>> >> +             dev_err(mmc_dev(host->mmc),
>> >> +                     "unsupported block size (%d bytes)\n", data->blksz);
>> >> +             return -EINVAL;
>> >> +     }
>> >> +
>> >> +     if (data->sg->offset & 3) {
>> >> +             dev_err(mmc_dev(host->mmc),
>> >> +                     "unsupported alginment (0x%x)\n", data->sg->offset);
>> >> +             return -EINVAL;
>> >> +     }
>> >
>> > Why?  What's the reasoning behind this suddenly introduced restriction?
>> > readsl()/writesl() copes just fine with non-aligned pointers.  It may be
>> > that your DMA engine can not, but that's no business interfering with
>> > non-DMA transfers, and no reason to fail such transfers.
>> >
>> > If your DMA engine can't do that then its your DMA engine code which
>> > should refuse to prepare the transfer.
>> >
>> > Yes, that means problems with the way things are ordered - or it needs a
>> > proper API where DMA engine can export these kinds of properties.
>> The alignment constraint is related to PIO, sg_miter and that FIFO
>> access must be done with 4 bytes.
>
> Total claptrap.  No it isn't.
>
> - sg_miter just deals with bytes, and number of bytes transferred; there
>   is no word assumptions in that code.  Indeed many ATA disks transfer
>   by half-word accesses so such a restriction would be insane.
>
> - the FIFO access itself needs to be 32-bit words, so readsl or writesl
>   (or their io* equivalents must be used).
>
> - but - and this is the killer item to your argument as I said above -
>   readsl and writesl _can_ take misaligned pointers and cope with them
>   fine.
>
> The actual alignment of the buffer address is totally irrelevant here.
>
> What isn't irrelevant is the _number_ of bytes to be transferred, but
> that's something totally different and completely unrelated from
> data->sg->offset.

We totally agree with the above, but we still think it is worth to
elaborate a bit on why we think the constraints on the buffer address
could be a way forward.
We have also been considering to verify the length of the buffers but
felt in the end if was getting somewhat too complicated.
Let's look at a concrete example.

The mmci_pio_read|write functions are being provided with sg element
buffers, which may have any length and any address alignment, as you
stated.

This example is a read:
-sg-list has 2 elements.
-sg-element [0], is 3 bytes long, and the address is not aligned to 4 bytes.
-sg-element [1], is 1 bytes long and the address is aligned to 4 bytes.

pio_read will start by reading one word (4 bytes) from the FIFO and
fill the sg-element [0] with 3 of those 4 bytes. Then it will return
that 3 bytes has been read.
The upper pio_irq loop still think there is 1 byte more to read but
will never be able to read it. Instead the DATAEND irq will be
triggered and the mmc request will be "successfully" ended.

The above problem, can be fixed by reading data to a local allocated
buffer instead of directly to the sg-element buffer. Thus an extra
memcpy will be needed. Our concern is that it will be messy when
solving the corner cases and thus affecting the "hot path" too much
for pio_read.

Instead we decided to figure out a way to prevent us from needing to
take care of such pio_read situations completely. Since sg-element
buffers can be considered to be consecutive in memory and by adding
the 4 bytes alignment constraint of the buffer address, we believe
this should do it. The idea is that it will then only be the _last_
read to the FIFO which might be done as "unaligned" due to that the
_length_ of data does not have to be 4 bytes aligned. Such read is
already handled properly by pio_read.

Do note, that the problem is present for pio_write as well. Here we
could end up in writing "corrupt" data to the card or even worse,
accessing data outside a mapped page casing page faults.
This is again possible to be solved inside the pio_write function, but
we fare that it will be messy and break the hot path.

Sorry if this was too fussy, somewhat hard to explain without a
"whiteboard". :-)

Kind regards
Ulf Hansson
