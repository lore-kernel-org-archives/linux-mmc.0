From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: Enabling RPMB overwrites setting the boot partition via ioctl
Date: Wed, 24 May 2017 08:33:13 +0800
Message-ID: <33fa3552-a2b8-72c7-86ce-8b0d27a48b6b@rock-chips.com>
References: <BN6PR12MB1442FDD4A02698E52489183490E50@BN6PR12MB1442.namprd12.prod.outlook.com>
 <CAPDyKFq3tgYgWcO3w_7_1-3CgDWhKq2RWqKygcgBk2CfR8tsHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.130]:57121 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759973AbdEXAdl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 23 May 2017 20:33:41 -0400
In-Reply-To: <CAPDyKFq3tgYgWcO3w_7_1-3CgDWhKq2RWqKygcgBk2CfR8tsHA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, "Schaefer, Brandon" <brandon.schaefer@flukenetworks.com>
Cc: shawn.lin@rock-chips.com, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Bean Huo (beanhuo)" <beanhuo@micron.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Hi

On 2017/5/23 18:17, Ulf Hansson wrote:
> + Bean Huo, Shawn Lin, Bartlomiej Zolnierkiewicz,
>
> On 20 May 2017 at 00:03, Schaefer, Brandon
> <brandon.schaefer@flukenetworks.com> wrote:
>> Linux kernel: 4.1.15 (imx_4.1.15_1.0.0_ga branch)
>>
>> I've noticed that writing to the boot partition is overwritten by RPMB related functions as it stores this byte (card->ext_csd.part_conf). It is necessary to update this reference when issuing CMD6 SWITCH through ioctl. See below patch for above kernel version:
>
> Thanks for sharing the information!
>
>>
>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>> index be776fa..cbd0533 100644
>> --- a/drivers/mmc/card/block.c
>> +++ b/drivers/mmc/card/block.c
>> @@ -60,7 +60,9 @@ MODULE_ALIAS("mmc:block");
>> #define INAND_CMD38_ARG_SECTRIM2 0x88
>> #define MMC_BLK_TIMEOUT_MS  (10 * 60 * 1000)        /* 10 minute timeout */
>> #define MMC_SANITIZE_REQ_TIMEOUT 240000
>> -#define MMC_EXTRACT_INDEX_FROM_ARG(x) ((x & 0x00FF0000) >> 16)
>> +#define MMC_EXTRACT_SWITCH_MODE_FROM_ARG(x)  (((x) & 0x03000000) >> 24)
>> +#define MMC_EXTRACT_INDEX_FROM_ARG(x)        (((x) & 0x00FF0000) >> 16)
>> +#define MMC_EXTRACT_VALUE_FROM_ARG(x)        (((x) & 0x0000FF00) >> 8)
>>
>>  #define mmc_req_rel_wr(req)   (((req->cmd_flags & REQ_FUA) || \
>>                                 (req->cmd_flags & REQ_META)) && \
>> @@ -572,6 +574,24 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev,
>>               goto cmd_rel_host;
>>        }
>>
>> +       /* If writing part config register, update struct */
>> +       if ((MMC_EXTRACT_INDEX_FROM_ARG(cmd.arg) == EXT_CSD_PART_CONFIG) &&
>> +           (cmd.opcode == MMC_SWITCH)) {
>> +              u8 mode = MMC_EXTRACT_SWITCH_MODE_FROM_ARG(cmd.arg);
>> +              u8 value = MMC_EXTRACT_VALUE_FROM_ARG(cmd.arg);
>> +              switch (mode) {
>> +              case MMC_SWITCH_MODE_SET_BITS:
>> +                      card->ext_csd.part_config |= value;
>> +                      break;
>> +              case MMC_SWITCH_MODE_CLEAR_BITS:
>> +                      card->ext_csd.part_config &= ~value;
>> +                      break;
>> +              case MMC_SWITCH_MODE_WRITE_BYTE:
>> +                      card->ext_csd.part_config = value;
>> +                      break;
>> +              }
>> +       }
>> +
>>        /*
>>         * According to the SD specs, some commands require a delay after
>>         * issuing the command.
>
> I am not sure how to go with this, especially since you are referring
> to an old kernel, 4.1.15. Can you confirm that the problem is still
> present in the my next branch of my mmc git tree? That would be more
> relevant information to start with.
>
> So to move forward, I decide to investigate the problem a bit. Here's
> my summary:
>
> 1) There are problems regarding switching between partitions in
> general, because the (e)MMC partitions isn't correctly set up.
> 2) The are problems related to when userspace utilizes the mmc
> back-door (mmc-ioctl) to change ext csd, because the mmc core don't
> get informed about these updates. For example, the mmc core may then
> take wrong decisions in the suspend/resume sequence.
>

patch[1] was also trying to fix one of these.
I think the core issue here is that we cached the ext_csd and provide
the ability for user space to r/w it without proper updating the whole
cached ext_csd. So could we just simply read ext_csd again if CMD6 was
issued by ioctl?


[1]: https://patchwork.kernel.org/patch/9632365/

> It would really be nice to fix these problems, however I need good
> quality patches, based on my mmc next branch confirming to fix
> problems.
>
> Here are some interesting samples from my investigation.
> https://patchwork.kernel.org/patch/9632365/
> https://community.nxp.com/thread/340088
> http://www.spinics.net/lists/linux-mmc/msg13516.html
>
>
> And here is an interesting commit, which really puzzles me as issuing
> a CMD0 should always re-set the eMMC device to the user partition. I
> don't get why this is needed and nor how it can fix a problem.
>
> commit 41e2a4893566ced3c46af15df5b727326881e47d
> Author: Philip Rakity <prakity@marvell.com>
> Date:   Sat Mar 19 14:10:33 2011 -0400
>
>     mmc: Ensure linux starts in eMMC user partition
>
>     uBoot sometimes leaves eMMC pointing to the private boot partition.
>     Ensure we always start looking at the user partition.
>
>
> Kind regards
> Uffe
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>

