From: "Luca Porzio (lporzio)" <lporzio@micron.com>
Subject: RE: [RFC 1/2] [MMC-4.5] Disable emulation
Date: Tue, 15 May 2012 09:41:29 +0000
Message-ID: <26E7A31274623843B0E8CF86148BFE326FB720ED@NTXAVZMBX04.azit.micron.com>
References: <1336574901-26579-1-git-send-email-saugata.das@stericsson.com>
 <4FB0DD88.2050005@codeaurora.org>
 <CAKLKtzfihpmU4Xhwj_u5oYkYo4Ra5twaPB3-WvVkzxF3EAVYAA@mail.gmail.com>
 <4FB1FA50.8010505@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from masquerade.micron.com ([137.201.242.130]:31404 "EHLO
	masquerade.micron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751576Ab2EOJm5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 May 2012 05:42:57 -0400
In-Reply-To: <4FB1FA50.8010505@codeaurora.org>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Subhash Jadavani <subhashj@codeaurora.org>, Saugata Das <saugata.das@linaro.org>
Cc: Saugata Das <saugata.das@stericsson.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "patches@linaro.org" <patches@linaro.org>

Hallo Subhash,

One general comment: native sector size is mandatory (as of Jedec spec) 
for >256GB devices. For other devices native sector size is optional.
This feature is not meant for performance improvement. Anyway if you 
start using your device with 4K alignment, you should already see 
some performance improvements on currently available market devices.

Other Comments below.

> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-owner@vger.kernel.org]
> On Behalf Of Subhash Jadavani
> Sent: Monday, May 14, 2012 11:40 PM
> To: Saugata Das
> Cc: Saugata Das; linux-mmc@vger.kernel.org; patches@linaro.org
> Subject: Re: [RFC 1/2] [MMC-4.5] Disable emulation
> 
> On 5/14/2012 8:21 PM, Saugata Das wrote:
> > On 14 May 2012 15:55, Subhash Jadavani<subhashj@codeaurora.org>  wrote:
> >> On 5/9/2012 8:18 PM, Saugata Das wrote:
> >>> From: Saugata Das<saugata.das@linaro.org>
> >>>
> >>> This patch adds the support for large sector size of 4KB by disabling
> >>> emulation.
> >>> This patch passes eMMC DATA_SECTOR_SIZE as the logical block size during
> >>> mmc_blk_alloc_req.
> >>>
> >>> In order to use this patch for 4KB sector size, ensure that
> >>> USE_NATIVE_SECTOR
> >>> is enabled, partition table is 4KB sector size aligned and file system
> >>> block
> >>> size is 4KB.
> >>>
> >>> Signed-off-by: Saugata Das<saugata.das@linaro.org>
> >>> ---
> >>>   drivers/mmc/card/block.c |    6 +++++-
> >>>   drivers/mmc/core/mmc.c   |    2 ++
> >>>   2 files changed, 7 insertions(+), 1 deletions(-)
> >>>
> >>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> >>> index a7c75d8..0e54118e 100644
> >>> --- a/drivers/mmc/card/block.c
> >>> +++ b/drivers/mmc/card/block.c
> >>> @@ -1517,7 +1517,11 @@ static struct mmc_blk_data
> >>> *mmc_blk_alloc_req(struct mmc_card *card,
> >>>         snprintf(md->disk->disk_name, sizeof(md->disk->disk_name),
> >>>                  "mmcblk%d%s", md->name_idx, subname ? subname : "");
> >>>
> >>> -       blk_queue_logical_block_size(md->queue.queue, 512);
> >>> +       if (mmc_card_mmc(card))
> >>> +               blk_queue_logical_block_size(md->queue.queue,
> >>> +                       card->ext_csd.data_sector_size);
> >> Shouldn't we also set the physical block size to NATIVE_SECTOR_SIZE value?
> >>
> > The physical block size gets set from blk_queue_logical_block_size
> >
> >> Other question,
> >> Did you find any eMMC device which 4K native sector size? If yes, please
> >> share the test results.
> >>
> > I have not yet seen the eMMC device implementing 4KB sector. But MMC
> > vendors are promising this feature, so I prepared this patch. So far,
> > I have tested by setting "data_sector_size" to 4KB (doing a hack in
> > mmc_read_ext_csd), configuring file system to have 4KB block size and
> > mounting it.
> Ok. So basically you are emulating the 512B native sector device as 4K
> native sector device and always read/write this device in 4K
> granularity. So this is just a proof of concept that setting the block
> queue logical sector size to 4K works or not?
> Are vendors promising any performance improvement if we run the device
> in 4K sector size mode rather than emulation mode?
> 
> I have few other doubts (from specification point of view) when the
> device starts running in native sector size mode:
> 
> 1. According spec, "A large sector device shall not support partial
> access and shall not support reliable write mode EN_REL_WR=0."
>          Shouldn't this patch make ensure this?
> 

I agree. Reliable write shall be disabled for native sector size 
but also I would suggest for performances (reliable writes act
As per Jedec spec as the FUA bit so unless this is intended behavior
I would suggest to remove it)

> 2.  Some internal sizes reported by the device may change after
> successfully disabling of the emulation mode.
>          Shouldn't  we take of this as well?
> 
> 3. After a successful disabling of the emulation mode, the content of
> the User Data Area is undefined.
>          If the contents of the user data area is undefined after
> disabling the emulation mode, i don't think device will be able to boot
> to kernel after power cycle. So does this mean we have to flash the
> kernel/file system images
>          again? Basically i don't see a use of disabling the emulation
> mode from kernel. It should be done by basic build/image flashing
> utility which could flash the images after setting the use_native_sector
> field and power cycle.
> 

I agree that use_native_sector size and its settings is something that 
Basically needs to happen in factory or any kind of "controlled environment".

Nevertheless my understanding here is that Saugata provided only the support 
within the Kernel to recognize the native sector setting. In my understanding
the userspace tool is more like a reference code for factory or development 
than something to be used for production. 

As such I think Saugata patch is ok because lets the kernel be aware of it.

> 4. Data transfers on the bus are still using 512B CRC-protected blocks,
> but data shall only be transferred in multiple of 8 such blocks (always
> multiples of 4KB)
>          So this means host controller still will be configured in 512B
> sector mode but amount of data will be in multple of 8 such 512B blocks?
>

Yes. Basically in the attempt to not be disruptive with legacy host 
Controllers, CRC, sectors and addressing will all still be in terms of 512B
sectors.
Actually my understanding is that as long as you guarantee a 4K alignment, 
Nothing changes at all with or without enabling native sector size.
 
> 5. Sector addressing is still used, but sector addresses shall always be
> aligned to 8 (4KB)
>          How the sector addressing work here? will the sector address
> (at argument of read/write commands) of byte address 0x1000 be 1 or 8?
> 
>          512B sector addressing:
>                  (byte address)         (sector address)
>                  0x0000                => 0
>                  0x0200                => 1
>                  0x0400                => 2
>                  0x0600                => 3
>                  0x0800                => 4
>                  0x0A00                => 5
>                  0x0C00                => 6
>                  0x0E00                => 7
>                  0x1000                => 8
> 

This is right

>          4K sector addressing:
>                  (byte address)         (sector address)
>                  0x0000                => 0
>                  0x0200                => NA
>                  0x0400                => NA
>                  0x0600                => NA
>                  0x0800                => NA
>                  0x0A00                => NA
>                  0x0C00                => NA
>                  0x0E00                => NA
>                  0x1000                => 1
> 

This is wrong.
As above, addressing is still in 512B sectors to guarantee retro-compatibility.

> 6. Arguments for read commands (CMD17/18) and write commands (CMD24/25)
> shall always be aligned to 8 (4KB)
>          What will be meaning of the single block read now? Should it be
> use single 512B block or single 4KB block? If CMD17 and CMD24 now mean
> that access to 4KB memory area, don't you need to take of the same in MMC
>          block driver?
> 

Single block read/write as per jedec spec cannot be used anymore as such they 
should be disabled on those devices where native sector size has been enabled.

> 7. what should be the block length set by CMD16 (SET_BLOCK_LENGTH) command?
>          I would guess that in 4KB native sector size mode, this command
> is redundant and will be ignored by the card but it's no where
> explicitly mentioned in specification.
> 
> Regards,
> Subhash
> 
> >
> >> Other than that, this patch looks good to me.
> >>
> >> Regards,
> >> Subhash
> >>
> >>> +       else
> >>> +               blk_queue_logical_block_size(md->queue.queue, 512);
> >>>         set_capacity(md->disk, size);
> >>>
> >>>         if (mmc_host_cmd23(card->host)) {
> >>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> >>> index 02914d6..8dcbe995 100644
> >>> --- a/drivers/mmc/core/mmc.c
> >>> +++ b/drivers/mmc/core/mmc.c
> >>> @@ -533,6 +533,8 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8
> >>> *ext_csd)
> >>>                 } else {
> >>>                         card->ext_csd.data_tag_unit_size = 0;
> >>>                 }
> >>> +       } else {
> >>> +               card->ext_csd.data_sector_size = 512;
> >>>         }
> >>>
> >>>   out:
> >>
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
