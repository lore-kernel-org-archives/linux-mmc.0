From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [RFC 1/2] [MMC-4.5] Disable emulation
Date: Tue, 15 May 2012 15:47:10 +0530
Message-ID: <CANfBPZ-AKz-xnoR7rET5+DhWr=KXBaGZ3uSQCAnxaQmtahR07Q@mail.gmail.com>
References: <1336574901-26579-1-git-send-email-saugata.das@stericsson.com>
 <4FB0DD88.2050005@codeaurora.org> <CAKLKtzfihpmU4Xhwj_u5oYkYo4Ra5twaPB3-WvVkzxF3EAVYAA@mail.gmail.com>
 <4FB1FA50.8010505@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:39946 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751894Ab2EOKRd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 15 May 2012 06:17:33 -0400
Received: by bkty8 with SMTP id y8so4518233bkt.3
        for <linux-mmc@vger.kernel.org>; Tue, 15 May 2012 03:17:30 -0700 (PDT)
In-Reply-To: <4FB1FA50.8010505@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Subhash Jadavani <subhashj@codeaurora.org>
Cc: Saugata Das <saugata.das@linaro.org>, Saugata Das <saugata.das@stericsson.com>, linux-mmc@vger.kernel.org, patches@linaro.org

On Tue, May 15, 2012 at 12:10 PM, Subhash Jadavani
<subhashj@codeaurora.org> wrote:
> On 5/14/2012 8:21 PM, Saugata Das wrote:
>>
>> On 14 May 2012 15:55, Subhash Jadavani<subhashj@codeaurora.org> =A0w=
rote:
>>>
>>> On 5/9/2012 8:18 PM, Saugata Das wrote:
>>>>
>>>> From: Saugata Das<saugata.das@linaro.org>
>>>>
>>>> This patch adds the support for large sector size of 4KB by disabl=
ing
>>>> emulation.
>>>> This patch passes eMMC DATA_SECTOR_SIZE as the logical block size =
during
>>>> mmc_blk_alloc_req.
>>>>
>>>> In order to use this patch for 4KB sector size, ensure that
>>>> USE_NATIVE_SECTOR
>>>> is enabled, partition table is 4KB sector size aligned and file sy=
stem
>>>> block
>>>> size is 4KB.
>>>>
>>>> Signed-off-by: Saugata Das<saugata.das@linaro.org>
>>>> ---
>>>> =A0drivers/mmc/card/block.c | =A0 =A06 +++++-
>>>> =A0drivers/mmc/core/mmc.c =A0 | =A0 =A02 ++
>>>> =A02 files changed, 7 insertions(+), 1 deletions(-)
>>>>
>>>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>>>> index a7c75d8..0e54118e 100644
>>>> --- a/drivers/mmc/card/block.c
>>>> +++ b/drivers/mmc/card/block.c
>>>> @@ -1517,7 +1517,11 @@ static struct mmc_blk_data
>>>> *mmc_blk_alloc_req(struct mmc_card *card,
>>>> =A0 =A0 =A0 =A0snprintf(md->disk->disk_name, sizeof(md->disk->disk=
_name),
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "mmcblk%d%s", md->name_idx, subnam=
e ? subname : "");
>>>>
>>>> - =A0 =A0 =A0 blk_queue_logical_block_size(md->queue.queue, 512);
>>>> + =A0 =A0 =A0 if (mmc_card_mmc(card))
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 blk_queue_logical_block_size(md->que=
ue.queue,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.data_s=
ector_size);
>>>
>>> Shouldn't we also set the physical block size to NATIVE_SECTOR_SIZE
>>> value?
>>>
>> The physical block size gets set from blk_queue_logical_block_size
>>
>>> Other question,
>>> Did you find any eMMC device which 4K native sector size? If yes, p=
lease
>>> share the test results.
>>>
>> I have not yet seen the eMMC device implementing 4KB sector. But MMC
>> vendors are promising this feature, so I prepared this patch. So far=
,
>> I have tested by setting "data_sector_size" to 4KB (doing a hack in
>> mmc_read_ext_csd), configuring file system to have 4KB block size an=
d
>> mounting it.
>
> Ok. So basically you are emulating the 512B native sector device as 4=
K
> native sector device and always read/write this device in 4K granular=
ity. So
> this is just a proof of concept that setting the block queue logical =
sector
> size to 4K works or not?
> Are vendors promising any performance improvement if we run the devic=
e in 4K
> sector size mode rather than emulation mode?
>
> I have few other doubts (from specification point of view) when the d=
evice
> starts running in native sector size mode:
>
> 1. According spec, "A large sector device shall not support partial a=
ccess
> and shall not support reliable write mode EN_REL_WR=3D0."
> =A0 =A0 =A0 =A0Shouldn't this patch make ensure this?
>
> 2. =A0Some internal sizes reported by the device may change after suc=
cessfully
> disabling of the emulation mode.
> =A0 =A0 =A0 =A0Shouldn't =A0we take of this as well?
This would be because if a single 512byte sector was marked as bad
(unusable) initially, the entire
aligned 4K block would be marked as bad now after switching to 4K
sector size, resulting in a slight capacity shrinkage.
  This would only matter if the switch happens for a fairly old
device. Typically, the sector size change should happen during factory
initialization, so there wouldn't be too many bad blocks, so it
shouldn't be much of an issue now.
  Of course, this is just one aspect of a problem for the "dynamic
device capacity" feature of eMMC4.5, and can be solved if we get to
that..


>
> 3. After a successful disabling of the emulation mode, the content of=
 the
> User Data Area is undefined.
> =A0 =A0 =A0 =A0If the contents of the user data area is undefined aft=
er disabling
> the emulation mode, i don't think device will be able to boot to kern=
el
> after power cycle. So does this mean we have to flash the kernel/file=
 system
> images
> =A0 =A0 =A0 =A0again? Basically i don't see a use of disabling the em=
ulation mode
> from kernel. It should be done by basic build/image flashing utility =
which
> could flash the images after setting the use_native_sector field and =
power
> cycle.
>
> 4. Data transfers on the bus are still using 512B CRC-protected block=
s, but
> data shall only be transferred in multiple of 8 such blocks (always
> multiples of 4KB)
> =A0 =A0 =A0 =A0So this means host controller still will be configured=
 in 512B sector
> mode but amount of data will be in multple of 8 such 512B blocks?
>
> 5. Sector addressing is still used, but sector addresses shall always=
 be
> aligned to 8 (4KB)
> =A0 =A0 =A0 =A0How the sector addressing work here? will the sector a=
ddress (at
> argument of read/write commands) of byte address 0x1000 be 1 or 8?
>
> =A0 =A0 =A0 =A0512B sector addressing:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(byte address) =A0 =A0 =A0 =A0 (sector=
 address)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x0000 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
=3D> 0
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x0200 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
=3D> 1
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x0400 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
=3D> 2
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x0600 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
=3D> 3
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x0800 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
=3D> 4
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x0A00 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
=3D> 5
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x0C00 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
=3D> 6
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x0E00 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
=3D> 7
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x1000 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
=3D> 8
>
> =A0 =A0 =A0 =A04K sector addressing:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(byte address) =A0 =A0 =A0 =A0 (sector=
 address)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x0000 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
=3D> 0
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x0200 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
=3D> NA
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x0400 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
=3D> NA
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x0600 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
=3D> NA
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x0800 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
=3D> NA
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x0A00 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
=3D> NA
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x0C00 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
=3D> NA
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x0E00 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
=3D> NA
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x1000 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
=3D> 1
>
> 6. Arguments for read commands (CMD17/18) and write commands (CMD24/2=
5)
> shall always be aligned to 8 (4KB)
> =A0 =A0 =A0 =A0What will be meaning of the single block read now? Sho=
uld it be use
> single 512B block or single 4KB block? If CMD17 and CMD24 now mean th=
at
> access to 4KB memory area, don't you need to take of the same in MMC
> =A0 =A0 =A0 =A0block driver?
>
> 7. what should be the block length set by CMD16 (SET_BLOCK_LENGTH) co=
mmand?
> =A0 =A0 =A0 =A0I would guess that in 4KB native sector size mode, thi=
s command is
> redundant and will be ignored by the card but it's no where explicitl=
y
> mentioned in specification.
>
> Regards,
> Subhash
>
>
>>
>>> Other than that, this patch looks good to me.
>>>
>>> Regards,
>>> Subhash
>>>
>>>> + =A0 =A0 =A0 else
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 blk_queue_logical_block_size(md->que=
ue.queue, 512);
>>>> =A0 =A0 =A0 =A0set_capacity(md->disk, size);
>>>>
>>>> =A0 =A0 =A0 =A0if (mmc_host_cmd23(card->host)) {
>>>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>>>> index 02914d6..8dcbe995 100644
>>>> --- a/drivers/mmc/core/mmc.c
>>>> +++ b/drivers/mmc/core/mmc.c
>>>> @@ -533,6 +533,8 @@ static int mmc_read_ext_csd(struct mmc_card *c=
ard,
>>>> u8
>>>> *ext_csd)
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0card->ext_csd.data_=
tag_unit_size =3D 0;
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>>>> + =A0 =A0 =A0 } else {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.data_sector_size =3D 5=
12;
>>>> =A0 =A0 =A0 =A0}
>>>>
>>>> =A0out:
>>>
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
