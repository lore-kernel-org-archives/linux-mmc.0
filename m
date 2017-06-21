From: Ravikumar <rk@ti.com>
Subject: Re: [PATCH] omap_hsmmc: Reduce max_segs
Date: Wed, 21 Jun 2017 14:46:46 +0530
Message-ID: <ec8e0bbd-e278-3067-6340-f7b3db293b05@ti.com>
References: <20170619093644.16054-1-willn@resin.io>
 <CAFbHwiSuAAophPr2tyHOq2iWrC1Uo2N+EOuvhiNcc9xERuvZZA@mail.gmail.com>
 <20170621062427.GP3730@atomide.com>
 <CAFbHwiQO5dHq59Bab4+9A6-QVcjsTVMzNfni0PQDQA1g3YCcgw@mail.gmail.com>
 <20170621083252.GQ3730@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lelnx193.ext.ti.com ([198.47.27.77]:44302 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752579AbdFUJMc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Jun 2017 05:12:32 -0400
In-Reply-To: <20170621083252.GQ3730@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Will Newton <will.newton@gmail.com>
Cc: linux-omap@vger.kernel.org, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>



On Wednesday 21 June 2017 02:02 PM, Tony Lindgren wrote:
> * Will Newton <will.newton@gmail.com> [170621 01:18]:
>> On Wed, Jun 21, 2017 at 7:24 AM, Tony Lindgren <tony@atomide.com> wrote:
>>
>> Hi Tony,
>>
>>> * Will Newton <will.newton@gmail.com> [170620 05:39]:
>>>> Just adding a few people to CC. I'd love to get some feedback as to
>>>> whether this patch makes sense or not.
>>>>
>>>> On Mon, Jun 19, 2017 at 10:36 AM, Will Newton <will.newton@gmail.com> wrote:
>>>>> Reduce max_segs to a value that allows allocation of an entire
>>>>> descriptor list within a single page. This avoids doing a
>>>>> higher order GFP_ATOMIC allocation when setting up a transfer
>>>>> which can potentially fail and lead to I/O failures.
>>> I recall we only ever have few SG entries so if there is no performance
>>> impact I see no reason to lower it to save memory. Care to check
>>> if that's the case still?
>> I have been seeing allocation failures in edma_prep_slave_sg
>> allocating the descriptor list of order 3, which from my rough
>> calculations is an sg_len of ~800. The memory usage itself doesn't
>> seem like a problem but doing a GFP_ATOMIC allocation of higher order
>> under I/O load seems like it is always going to cause problems.
max_segs= 64  looks like a sensible value to me for edma/sdma, with each 
param set ~40Bytes - this will ensure to fit in a single page.
IIRC, edma splits the list at 20. MAX_NR_SEGS set to 20 in edma.c. So, 
having a bigger number *may not* guarantee a proportional increase
in throughput.

> OK
>
>> I'm not an expert on this code but it looks like the scatterlist is
>> created from the queue so if the queue gets full we can get a very
>> large scatterlist. The current value of 1024 seems to be something of
>> an outlier:
When using ADMA, since you allocate the table only once during probe, 
there'll be no alloc calls at a later time.
And increase in number of sg entries would increase efficiency. I've 
seen  as many as 290-300 sg entries being used during file-system 
init/mount. So, for ADMA, I would say at least max_segs = 512 is a 
better option since descriptor size is 8B,
would still fit in a page.
You can over-wirte it under  "if (host->adma)"
>>
>> drivers/mmc/host/android-goldfish.c:    mmc->max_segs = 32;
>> drivers/mmc/host/atmel-mci.c:           mmc->max_segs = 256;
>> drivers/mmc/host/atmel-mci.c:           mmc->max_segs = 64;
>> drivers/mmc/host/au1xmmc.c:     mmc->max_segs = AU1XMMC_DESCRIPTOR_COUNT;
>> drivers/mmc/host/bcm2835.c:     mmc->max_segs = 128;
>> drivers/mmc/host/bfin_sdh.c:    mmc->max_segs = 1;
>> drivers/mmc/host/bfin_sdh.c:    mmc->max_segs = PAGE_SIZE /
>> sizeof(struct dma_desc_array);
>> drivers/mmc/host/cavium.c:              mmc->max_segs = 16;
>> drivers/mmc/host/cavium.c:              mmc->max_segs = 1;
>> drivers/mmc/host/dw_mmc.c:              mmc->max_segs = host->ring_size;
>> drivers/mmc/host/dw_mmc.c:              mmc->max_segs = 64;
>> drivers/mmc/host/dw_mmc.c:              mmc->max_segs = 64;
>> drivers/mmc/host/jz4740_mmc.c:  mmc->max_segs = 128;
>> drivers/mmc/host/meson-gx-mmc.c:        mmc->max_segs =
>> SD_EMMC_DESC_BUF_LEN / sizeof(struct sd_emmc_desc);
>> drivers/mmc/host/mmc_spi.c:     mmc->max_segs = MMC_SPI_BLOCKSATONCE;
>> drivers/mmc/host/mmci.c:        mmc->max_segs = NR_SG;
>> drivers/mmc/host/mtk-sd.c:      mmc->max_segs = MAX_BD_NUM;
>> drivers/mmc/host/mvsdio.c:      mmc->max_segs = 1;
>> drivers/mmc/host/mxcmmc.c:              mmc->max_segs = 64;
>> drivers/mmc/host/mxs-mmc.c:     mmc->max_segs = 52;
>> drivers/mmc/host/omap.c:        mmc->max_segs = 32;
>> drivers/mmc/host/omap_hsmmc.c:  mmc->max_segs = 1024;
>> drivers/mmc/host/pxamci.c:      mmc->max_segs = NR_SG;
>> drivers/mmc/host/rtsx_pci_sdmmc.c:      mmc->max_segs = 256;
>> drivers/mmc/host/rtsx_usb_sdmmc.c:      mmc->max_segs = 256;
>> drivers/mmc/host/sdhci.c:               mmc->max_segs = SDHCI_MAX_SEGS;
>> drivers/mmc/host/sdhci.c:               mmc->max_segs = 1;
>> drivers/mmc/host/sdhci.c:               mmc->max_segs = SDHCI_MAX_SEGS;
>> drivers/mmc/host/sh_mmcif.c:    mmc->max_segs = 32;
>> drivers/mmc/host/tifm_sd.c:     mmc->max_segs = mmc->max_blk_count;
>> drivers/mmc/host/tmio_mmc_pio.c:        mmc->max_segs = 32;
>> drivers/mmc/host/usdhi6rol0.c:  mmc->max_segs = 32;
>> drivers/mmc/host/ushc.c:        mmc->max_segs      = 1;
>> drivers/mmc/host/via-sdmmc.c:   mmc->max_segs = 1;
>> drivers/mmc/host/vub300.c:      mmc->max_segs = 128;
>> drivers/mmc/host/wbsd.c:        mmc->max_segs = 128;
>> drivers/mmc/host/wmt-sdmmc.c:   mmc->max_segs = wmt_caps->max_segs;
> OK maybe update the patch description a bit more with that
> info above :)
>
> Regards,
>
> Tony
Regards,
RK
