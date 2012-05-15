From: Subhash Jadavani <subhashj@codeaurora.org>
Subject: Re: [RFC 1/2] [MMC-4.5] Disable emulation
Date: Tue, 15 May 2012 12:10:16 +0530
Message-ID: <4FB1FA50.8010505@codeaurora.org>
References: <1336574901-26579-1-git-send-email-saugata.das@stericsson.com> <4FB0DD88.2050005@codeaurora.org> <CAKLKtzfihpmU4Xhwj_u5oYkYo4Ra5twaPB3-WvVkzxF3EAVYAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:28456 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754661Ab2EOGkW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 May 2012 02:40:22 -0400
In-Reply-To: <CAKLKtzfihpmU4Xhwj_u5oYkYo4Ra5twaPB3-WvVkzxF3EAVYAA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Saugata Das <saugata.das@linaro.org>
Cc: Saugata Das <saugata.das@stericsson.com>, linux-mmc@vger.kernel.org, patches@linaro.org

On 5/14/2012 8:21 PM, Saugata Das wrote:
> On 14 May 2012 15:55, Subhash Jadavani<subhashj@codeaurora.org>  wrote:
>> On 5/9/2012 8:18 PM, Saugata Das wrote:
>>> From: Saugata Das<saugata.das@linaro.org>
>>>
>>> This patch adds the support for large sector size of 4KB by disabling
>>> emulation.
>>> This patch passes eMMC DATA_SECTOR_SIZE as the logical block size during
>>> mmc_blk_alloc_req.
>>>
>>> In order to use this patch for 4KB sector size, ensure that
>>> USE_NATIVE_SECTOR
>>> is enabled, partition table is 4KB sector size aligned and file system
>>> block
>>> size is 4KB.
>>>
>>> Signed-off-by: Saugata Das<saugata.das@linaro.org>
>>> ---
>>>   drivers/mmc/card/block.c |    6 +++++-
>>>   drivers/mmc/core/mmc.c   |    2 ++
>>>   2 files changed, 7 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>>> index a7c75d8..0e54118e 100644
>>> --- a/drivers/mmc/card/block.c
>>> +++ b/drivers/mmc/card/block.c
>>> @@ -1517,7 +1517,11 @@ static struct mmc_blk_data
>>> *mmc_blk_alloc_req(struct mmc_card *card,
>>>         snprintf(md->disk->disk_name, sizeof(md->disk->disk_name),
>>>                  "mmcblk%d%s", md->name_idx, subname ? subname : "");
>>>
>>> -       blk_queue_logical_block_size(md->queue.queue, 512);
>>> +       if (mmc_card_mmc(card))
>>> +               blk_queue_logical_block_size(md->queue.queue,
>>> +                       card->ext_csd.data_sector_size);
>> Shouldn't we also set the physical block size to NATIVE_SECTOR_SIZE value?
>>
> The physical block size gets set from blk_queue_logical_block_size
>
>> Other question,
>> Did you find any eMMC device which 4K native sector size? If yes, please
>> share the test results.
>>
> I have not yet seen the eMMC device implementing 4KB sector. But MMC
> vendors are promising this feature, so I prepared this patch. So far,
> I have tested by setting "data_sector_size" to 4KB (doing a hack in
> mmc_read_ext_csd), configuring file system to have 4KB block size and
> mounting it.
Ok. So basically you are emulating the 512B native sector device as 4K 
native sector device and always read/write this device in 4K 
granularity. So this is just a proof of concept that setting the block 
queue logical sector size to 4K works or not?
Are vendors promising any performance improvement if we run the device 
in 4K sector size mode rather than emulation mode?

I have few other doubts (from specification point of view) when the 
device starts running in native sector size mode:

1. According spec, "A large sector device shall not support partial 
access and shall not support reliable write mode EN_REL_WR=0."
         Shouldn't this patch make ensure this?

2.  Some internal sizes reported by the device may change after 
successfully disabling of the emulation mode.
         Shouldn't  we take of this as well?

3. After a successful disabling of the emulation mode, the content of 
the User Data Area is undefined.
         If the contents of the user data area is undefined after 
disabling the emulation mode, i don't think device will be able to boot 
to kernel after power cycle. So does this mean we have to flash the 
kernel/file system images
         again? Basically i don't see a use of disabling the emulation 
mode from kernel. It should be done by basic build/image flashing 
utility which could flash the images after setting the use_native_sector 
field and power cycle.

4. Data transfers on the bus are still using 512B CRC-protected blocks, 
but data shall only be transferred in multiple of 8 such blocks (always 
multiples of 4KB)
         So this means host controller still will be configured in 512B 
sector mode but amount of data will be in multple of 8 such 512B blocks?

5. Sector addressing is still used, but sector addresses shall always be 
aligned to 8 (4KB)
         How the sector addressing work here? will the sector address 
(at argument of read/write commands) of byte address 0x1000 be 1 or 8?

         512B sector addressing:
                 (byte address)         (sector address)
                 0x0000                => 0
                 0x0200                => 1
                 0x0400                => 2
                 0x0600                => 3
                 0x0800                => 4
                 0x0A00                => 5
                 0x0C00                => 6
                 0x0E00                => 7
                 0x1000                => 8

         4K sector addressing:
                 (byte address)         (sector address)
                 0x0000                => 0
                 0x0200                => NA
                 0x0400                => NA
                 0x0600                => NA
                 0x0800                => NA
                 0x0A00                => NA
                 0x0C00                => NA
                 0x0E00                => NA
                 0x1000                => 1

6. Arguments for read commands (CMD17/18) and write commands (CMD24/25) 
shall always be aligned to 8 (4KB)
         What will be meaning of the single block read now? Should it be 
use single 512B block or single 4KB block? If CMD17 and CMD24 now mean 
that access to 4KB memory area, don't you need to take of the same in MMC
         block driver?

7. what should be the block length set by CMD16 (SET_BLOCK_LENGTH) command?
         I would guess that in 4KB native sector size mode, this command 
is redundant and will be ignored by the card but it's no where 
explicitly mentioned in specification.

Regards,
Subhash

>
>> Other than that, this patch looks good to me.
>>
>> Regards,
>> Subhash
>>
>>> +       else
>>> +               blk_queue_logical_block_size(md->queue.queue, 512);
>>>         set_capacity(md->disk, size);
>>>
>>>         if (mmc_host_cmd23(card->host)) {
>>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>>> index 02914d6..8dcbe995 100644
>>> --- a/drivers/mmc/core/mmc.c
>>> +++ b/drivers/mmc/core/mmc.c
>>> @@ -533,6 +533,8 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8
>>> *ext_csd)
>>>                 } else {
>>>                         card->ext_csd.data_tag_unit_size = 0;
>>>                 }
>>> +       } else {
>>> +               card->ext_csd.data_sector_size = 512;
>>>         }
>>>
>>>   out:
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

