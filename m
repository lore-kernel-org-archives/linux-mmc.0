From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3] mmc: sdhci: Implement an SDHCI-specific bounce buffer
Date: Tue, 9 Jan 2018 11:26:45 +0100
Message-ID: <CACRpkdYW36Kdi1DuF+TbNsQNwT1RWOmVMfs0jJ-Ssf+LCembTg@mail.gmail.com>
References: <20180105162936.18612-1-linus.walleij@linaro.org> <CAPDyKFo+r39NAW1qGaXxq3_9kr9dVU8DBEuhQBtg-n4r4JFzAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFo+r39NAW1qGaXxq3_9kr9dVU8DBEuhQBtg-n4r4JFzAA@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Benjamin Beckmeyer <beckmeyer.b@rittal.de>, Adrian Hunter <adrian.hunter@intel.com>, Pierre Ossman <pierre@ossman.eu>, =?UTF-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?= <benoit@wsystem.com>, Fabio Estevam <fabio.estevam@nxp.com>, "# 4.0+" <stable@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, Jan 9, 2018 at 9:07 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> [...]
>
>> @@ -3713,6 +3751,43 @@ int sdhci_setup_host(struct sdhci_host *host)
>>          */
>>         mmc->max_blk_count = (host->quirks & SDHCI_QUIRK_NO_MULTIBLOCK) ? 1 : 65535;
>>
>> +       if (mmc->max_segs == 1) {
>> +               unsigned int max_blocks;
>> +               unsigned int max_seg_size;
>> +
>> +               max_seg_size = mmc->max_req_size;
>> +               max_blocks = max_seg_size / 512;
>> +               dev_info(mmc->parent, "host only supports SDMA, activate bounce buffer\n");
>> +
>> +               /*
>> +                * When we just support one segment, we can get significant speedups
>> +                * by the help of a bounce buffer to group scattered reads/writes
>> +                * together.
>> +                *
>> +                * TODO: is this too big? Stealing too much memory? The old bounce
>> +                * buffer is max 64K. This should be the 512K that SDMA can handle
>> +                * if I read the code above right. Anyways let's try this.
>> +                * FIXME: use devm_*
>> +                */
>> +               host->bounce_buffer = dma_alloc_coherent(mmc->parent, max_seg_size,
>> +                                                        &host->bounce_addr, GFP_KERNEL);
>
> Why do you need dma_alloc_coherent() - allocated bounce buffer? Isn't
> a regular kmalloc-ed buffer fine as a bounce buffer?

No, because kmalloc() only guarantee physically coherent memory
up to 64KB.

The old bounce buffer code capped the size of the bounce buffer to
64KB, I think for this reason (another piece of magic that noone dared
to touch).

If we kmalloc() something > 64KB we might get fragmented memory
and things explode, which I think is what happened on v1/v2 of this
patch.

Since the sole purpose of this bounce buffer is to keep things
physically coherent we need to use dma_alloc_coherent() which
will be backed by the CMA allocator if available.

> I am worried, also according to your above comment, that it's not
> always going to work to request a large buffer like this, especially
> with dma_alloc_coherent().

The driver uses dma_alloc_coherent() in other places, and the size
we ask for is 512K. (Only on affected devices with just SDMA.)

If I cap it down to 64KB it will be as likely to succeed as a regular
kmalloc(), it can just take any 64KB slab. I would still use
dma_alloc_coherent() to make the code simple (tests show no
difference to explicit ownership swap between CPU and device).

But the larger the buffer, the larger the speed improvement, I think
this is why the driver performs even better than before in some
cases.

Is using 512 insead of 64KB a problem on any target system?
Hardly on x86 laptops, but what about i.MX25 and i.MX35?

>> +               if (!host->bounce_buffer) {
>> +                       dev_err(mmc->parent,
>> +                               "failed to allocate %u bytes for bounce buffer\n",
>> +                               max_seg_size);
>> +                       return -ENOMEM;
>
> Why not fall back to use the max_segs = 1 here. It may be slow, as
> reported, but it works.

OK good point. I'll fix this in v4.

Yours,
Linus Walleij
