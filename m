From: Saugata Das <saugata.das@linaro.org>
Subject: Re: [RFC 1/2] [MMC-4.5] Disable emulation
Date: Mon, 14 May 2012 20:21:51 +0530
Message-ID: <CAKLKtzfihpmU4Xhwj_u5oYkYo4Ra5twaPB3-WvVkzxF3EAVYAA@mail.gmail.com>
References: <1336574901-26579-1-git-send-email-saugata.das@stericsson.com>
	<4FB0DD88.2050005@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:34858 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752402Ab2ENOvw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 May 2012 10:51:52 -0400
Received: by qcro28 with SMTP id o28so3362501qcr.19
        for <linux-mmc@vger.kernel.org>; Mon, 14 May 2012 07:51:52 -0700 (PDT)
In-Reply-To: <4FB0DD88.2050005@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Subhash Jadavani <subhashj@codeaurora.org>
Cc: Saugata Das <saugata.das@stericsson.com>, linux-mmc@vger.kernel.org, patches@linaro.org

On 14 May 2012 15:55, Subhash Jadavani <subhashj@codeaurora.org> wrote:
> On 5/9/2012 8:18 PM, Saugata Das wrote:
>>
>> From: Saugata Das<saugata.das@linaro.org>
>>
>> This patch adds the support for large sector size of 4KB by disablin=
g
>> emulation.
>> This patch passes eMMC DATA_SECTOR_SIZE as the logical block size du=
ring
>> mmc_blk_alloc_req.
>>
>> In order to use this patch for 4KB sector size, ensure that
>> USE_NATIVE_SECTOR
>> is enabled, partition table is 4KB sector size aligned and file syst=
em
>> block
>> size is 4KB.
>>
>> Signed-off-by: Saugata Das<saugata.das@linaro.org>
>> ---
>> =A0drivers/mmc/card/block.c | =A0 =A06 +++++-
>> =A0drivers/mmc/core/mmc.c =A0 | =A0 =A02 ++
>> =A02 files changed, 7 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>> index a7c75d8..0e54118e 100644
>> --- a/drivers/mmc/card/block.c
>> +++ b/drivers/mmc/card/block.c
>> @@ -1517,7 +1517,11 @@ static struct mmc_blk_data
>> *mmc_blk_alloc_req(struct mmc_card *card,
>> =A0 =A0 =A0 =A0snprintf(md->disk->disk_name, sizeof(md->disk->disk_n=
ame),
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "mmcblk%d%s", md->name_idx, subname =
? subname : "");
>>
>> - =A0 =A0 =A0 blk_queue_logical_block_size(md->queue.queue, 512);
>> + =A0 =A0 =A0 if (mmc_card_mmc(card))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 blk_queue_logical_block_size(md->queue=
=2Equeue,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.data_sec=
tor_size);
>
> Shouldn't we also set the physical block size to NATIVE_SECTOR_SIZE v=
alue?
>

The physical block size gets set from blk_queue_logical_block_size

> Other question,
> Did you find any eMMC device which 4K native sector size? If yes, ple=
ase
> share the test results.
>

I have not yet seen the eMMC device implementing 4KB sector. But MMC
vendors are promising this feature, so I prepared this patch. So far,
I have tested by setting "data_sector_size" to 4KB (doing a hack in
mmc_read_ext_csd), configuring file system to have 4KB block size and
mounting it.

> Other than that, this patch looks good to me.
>
> Regards,
> Subhash
>
>> + =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 blk_queue_logical_block_size(md->queue=
=2Equeue, 512);
>> =A0 =A0 =A0 =A0set_capacity(md->disk, size);
>>
>> =A0 =A0 =A0 =A0if (mmc_host_cmd23(card->host)) {
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index 02914d6..8dcbe995 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -533,6 +533,8 @@ static int mmc_read_ext_csd(struct mmc_card *car=
d, u8
>> *ext_csd)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0card->ext_csd.data_ta=
g_unit_size =3D 0;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>> + =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.data_sector_size =3D 512=
;
>> =A0 =A0 =A0 =A0}
>>
>> =A0out:
>
>
