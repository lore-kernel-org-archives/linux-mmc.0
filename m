From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3] mmc: sdhci: Implement an SDHCI-specific bounce buffer
Date: Wed, 10 Jan 2018 11:21:54 +0100
Message-ID: <CAK8P3a2Bt7YN4dDC8_h2-7cVO895Grd4Q+domjFc3V19rW_3Ew@mail.gmail.com>
References: <20180105162936.18612-1-linus.walleij@linaro.org>
 <CAPDyKFo+r39NAW1qGaXxq3_9kr9dVU8DBEuhQBtg-n4r4JFzAA@mail.gmail.com> <CACRpkdYW36Kdi1DuF+TbNsQNwT1RWOmVMfs0jJ-Ssf+LCembTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <CACRpkdYW36Kdi1DuF+TbNsQNwT1RWOmVMfs0jJ-Ssf+LCembTg@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Benjamin Beckmeyer <beckmeyer.b@rittal.de>, Adrian Hunter <adrian.hunter@intel.com>, Pierre Ossman <pierre@ossman.eu>, =?UTF-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?= <benoit@wsystem.com>, Fabio Estevam <fabio.estevam@nxp.com>, "# 4.0+" <stable@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, Jan 9, 2018 at 11:26 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Tue, Jan 9, 2018 at 9:07 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> [...]
>>
>>> @@ -3713,6 +3751,43 @@ int sdhci_setup_host(struct sdhci_host *host)
>>>          */
>>>         mmc->max_blk_count = (host->quirks & SDHCI_QUIRK_NO_MULTIBLOCK) ? 1 : 65535;
>>>
>>> +       if (mmc->max_segs == 1) {
>>> +               unsigned int max_blocks;
>>> +               unsigned int max_seg_size;
>>> +
>>> +               max_seg_size = mmc->max_req_size;
>>> +               max_blocks = max_seg_size / 512;
>>> +               dev_info(mmc->parent, "host only supports SDMA, activate bounce buffer\n");
>>> +
>>> +               /*
>>> +                * When we just support one segment, we can get significant speedups
>>> +                * by the help of a bounce buffer to group scattered reads/writes
>>> +                * together.
>>> +                *
>>> +                * TODO: is this too big? Stealing too much memory? The old bounce
>>> +                * buffer is max 64K. This should be the 512K that SDMA can handle
>>> +                * if I read the code above right. Anyways let's try this.
>>> +                * FIXME: use devm_*
>>> +                */
>>> +               host->bounce_buffer = dma_alloc_coherent(mmc->parent, max_seg_size,
>>> +                                                        &host->bounce_addr, GFP_KERNEL);
>>
>> Why do you need dma_alloc_coherent() - allocated bounce buffer? Isn't
>> a regular kmalloc-ed buffer fine as a bounce buffer?
>
> No, because kmalloc() only guarantee physically coherent memory
> up to 64KB.
>
> The old bounce buffer code capped the size of the bounce buffer to
> 64KB, I think for this reason (another piece of magic that noone dared
> to touch).
>
> If we kmalloc() something > 64KB we might get fragmented memory
> and things explode, which I think is what happened on v1/v2 of this
> patch.
>
> Since the sole purpose of this bounce buffer is to keep things
> physically coherent we need to use dma_alloc_coherent() which
> will be backed by the CMA allocator if available.
>
>> I am worried, also according to your above comment, that it's not
>> always going to work to request a large buffer like this, especially
>> with dma_alloc_coherent().
>
> The driver uses dma_alloc_coherent() in other places, and the size
> we ask for is 512K. (Only on affected devices with just SDMA.)

After thinking about it some more, I wonder if 512K is a bit big
for a coherent allocation. I think some systems are fairly limited
in the amount of DMA-coherent memory they have, so if we
have e.g. 2MB of coherent memory (no CMA support) and multiple
MMC controllers, we run out of space for other drivers very quickly.

> If I cap it down to 64KB it will be as likely to succeed as a regular
> kmalloc(), it can just take any 64KB slab. I would still use
> dma_alloc_coherent() to make the code simple (tests show no
> difference to explicit ownership swap between CPU and device).

Did you measure the CPU utilization or just the block device
throughput? It should not make much difference to the throughput
as the limitation comes from the SD card or eMMC itself, but the
CPU usage could be quite different on some systems, in particular
on SMP machines without cache-coherent DMA.

> But the larger the buffer, the larger the speed improvement, I think
> this is why the driver performs even better than before in some
> cases.

My guess is that the benefit of going beyond 64K is fairly small
though, this seems to be a typical size that the devices optimize
for.

      Arnd
