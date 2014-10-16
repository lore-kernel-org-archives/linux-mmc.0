From: Gwendal Grignou <gwendal@google.com>
Subject: Re: [PATCH] mmc: Report firmware version for eMMC 5.0 devices.
Date: Thu, 16 Oct 2014 11:09:56 -0700
Message-ID: <CAMHSBOVx+ZaeOL8LxTof_r7eU+SUgxVUBeY3ge7v7dSROOhQYg@mail.gmail.com>
References: <1413414288-4667-1-git-send-email-gwendal@chromium.org> <CAPDyKFpzdKHJ5mR+s42L-+TZdzE-m7RoWqix29gYe_CMm46B9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:43738 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751309AbaJPSKR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Oct 2014 14:10:17 -0400
Received: by mail-vc0-f174.google.com with SMTP id hq12so3088079vcb.5
        for <linux-mmc@vger.kernel.org>; Thu, 16 Oct 2014 11:10:16 -0700 (PDT)
In-Reply-To: <CAPDyKFpzdKHJ5mR+s42L-+TZdzE-m7RoWqix29gYe_CMm46B9Q@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Gwendal Grignou <gwendal@chromium.org>, Chris Ball <chris@printf.net>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>

On Thu, Oct 16, 2014 at 6:28 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 16 October 2014 01:04, Gwendal Grignou <gwendal@chromium.org> wrote:
>> For eMMC 5.0 compliant device, firmware version is stored in ext_csd.
>> Report firmware as a 64bit hexa decimal. Vendor can use hexa or ascii
>> string to report firmware version.
>> Also add FFU related EXT_CSD register and note if the device is FFU capable.
>>
>> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
>
> Nitpick: Please prefix patch with "mmc: core:"
>
>> ---
>>  drivers/mmc/core/mmc.c   | 24 +++++++++++++++++++++++-
>>  include/linux/mmc/card.h |  2 ++
>>  include/linux/mmc/mmc.h  | 10 ++++++++++
>>  3 files changed, 35 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index 1eda8dd..a0663cf 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -603,6 +603,25 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
>>                 card->ext_csd.data_sector_size = 512;
>>         }
>>
>> +       /* eMMC v5 or later */
>> +       if (card->ext_csd.rev >= 7) {
>> +               u64 fwrev;
>> +
>> +               memcpy(&fwrev, &ext_csd[EXT_CSD_FIRMWARE_VERSION],
>> +                      sizeof(fwrev));
>> +               card->ext_csd.ffu_capable =
>> +                       ((ext_csd[EXT_CSD_SUPPORTED_MODE] & 1) == 1) &&
>> +                       ((ext_csd[EXT_CSD_FW_CONFIG] & 1) == 0);
>
> Please convert the above statement into this:
>
> card->ext_csd.ffu_capable = ext_csd[EXT_CSD_SUPPORTED_MODE] & 0x1 &&
> !(ext_csd[EXT_CSD_FW_CONFIG] & 0x1)
>
>> +               /*
>> +                * Firmware version can be a string or a hexa decimal number.
>> +                * In case of string, the first byte should be printed first.
>> +                * in case of hexadecimal, we can assume the first byte is the
>> +                * more significant, therefore we print it first as well.
>
> I had a quick look in the eMMC 5.0 spec. I can't find were the above
> is stated, or maybe what you are saying is just a consequence of that
> there are some pieces missing in the spec? :-)
The only info in the spec I found is:
7.4.26 FIRMWARE_VERSION [261-254]
This field provides the device firmware version.

And that's it. The spec does not specify if it is a string, which
character set is allowed and so on.
I rework the patch to print it is as an hex buffer, without the weird
conversion.
>
> Anyway, I wonder if just should skip the conversion and keep the raw format.
>
>> +                */
>> +               card->ext_csd.fwrev = be64_to_cpu(fwrev);
>> +       } else {
>
> The "else" isn't needed, ffu_capable's default value is already false.
>
>> +               card->ext_csd.ffu_capable = false;
>> +       }
>>  out:
>>         return err;
>>  }
>> @@ -697,7 +716,9 @@ MMC_DEV_ATTR(csd, "%08x%08x%08x%08x\n", card->raw_csd[0], card->raw_csd[1],
>>  MMC_DEV_ATTR(date, "%02d/%04d\n", card->cid.month, card->cid.year);
>>  MMC_DEV_ATTR(erase_size, "%u\n", card->erase_size << 9);
>>  MMC_DEV_ATTR(preferred_erase_size, "%u\n", card->pref_erase << 9);
>> -MMC_DEV_ATTR(fwrev, "0x%x\n", card->cid.fwrev);
>> +MMC_DEV_ATTR(fwrev, "0x%llx\n", (card->ext_csd.rev >= 7 ?
>> +               card->ext_csd.fwrev : card->cid.fwrev));
>
> cid.fwrev is not an u64.
>
>> +MMC_DEV_ATTR(ffu_capable, "0x%x\n", card->ext_csd.ffu_capable);
>>  MMC_DEV_ATTR(hwrev, "0x%x\n", card->cid.hwrev);
>>  MMC_DEV_ATTR(manfid, "0x%06x\n", card->cid.manfid);
>>  MMC_DEV_ATTR(name, "%s\n", card->cid.prod_name);
>> @@ -717,6 +738,7 @@ static struct attribute *mmc_std_attrs[] = {
>>         &dev_attr_erase_size.attr,
>>         &dev_attr_preferred_erase_size.attr,
>>         &dev_attr_fwrev.attr,
>> +       &dev_attr_ffu_capable.attr,
>>         &dev_attr_hwrev.attr,
>>         &dev_attr_manfid.attr,
>>         &dev_attr_name.attr,
>> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
>> index d424b9d..67bae22 100644
>> --- a/include/linux/mmc/card.h
>> +++ b/include/linux/mmc/card.h
>> @@ -87,6 +87,8 @@ struct mmc_ext_csd {
>>         unsigned int            data_tag_unit_size;     /* DATA TAG UNIT size */
>>         unsigned int            boot_ro_lock;           /* ro lock support */
>>         bool                    boot_ro_lockable;
>> +       bool                    ffu_capable;    /* FFU support */
>> +       u64                     fwrev;          /* Firmware version */
>>         u8                      raw_exception_status;   /* 54 */
>>         u8                      raw_partition_support;  /* 160 */
>>         u8                      raw_rpmb_size_mult;     /* 168 */
>> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
>> index 64ec963..9216519 100644
>> --- a/include/linux/mmc/mmc.h
>> +++ b/include/linux/mmc/mmc.h
>> @@ -272,6 +272,9 @@ struct _mmc_csd {
>>   * EXT_CSD fields
>>   */
>>
>> +#define EXT_CSD_FFU_STATUS             26      /* R */
>> +#define EXT_CSD_MODE_OPERATION_CODES   29      /* W */
>> +#define EXT_CSD_MODE_CONFIG            30      /* R/W */
>>  #define EXT_CSD_FLUSH_CACHE            32      /* W */
>>  #define EXT_CSD_CACHE_CTRL             33      /* R/W */
>>  #define EXT_CSD_POWER_OFF_NOTIFICATION 34      /* R/W */
>> @@ -290,6 +293,7 @@ struct _mmc_csd {
>>  #define EXT_CSD_SANITIZE_START         165     /* W */
>>  #define EXT_CSD_WR_REL_PARAM           166     /* RO */
>>  #define EXT_CSD_RPMB_MULT              168     /* RO */
>> +#define EXT_CSD_FW_CONFIG              169     /* R/W */
>>  #define EXT_CSD_BOOT_WP                        173     /* R/W */
>>  #define EXT_CSD_ERASE_GROUP_DEF                175     /* R/W */
>>  #define EXT_CSD_PART_CONFIG            179     /* R/W */
>> @@ -326,6 +330,12 @@ struct _mmc_csd {
>>  #define EXT_CSD_GENERIC_CMD6_TIME      248     /* RO */
>>  #define EXT_CSD_CACHE_SIZE             249     /* RO, 4 bytes */
>>  #define EXT_CSD_PWR_CL_DDR_200_360     253     /* RO */
>> +#define EXT_CSD_FIRMWARE_VERSION       254     /* RO, 8 bytes */
>> +#define EXT_CSD_NUM_OF_FW_SEC_PROG     302     /* RO, 4 bytes */
>> +#define EXT_CSD_FFU_ARG                        487     /* RO, 4 bytes */
>> +#define EXT_CSD_OPERATION_CODE_TIMEOUT 491     /* RO */
>> +#define EXT_CSD_FFU_FEATURES           492     /* RO */
>> +#define EXT_CSD_SUPPORTED_MODE         493     /* RO */
>>  #define EXT_CSD_TAG_UNIT_SIZE          498     /* RO */
>>  #define EXT_CSD_DATA_TAG_SUPPORT       499     /* RO */
>>  #define EXT_CSD_MAX_PACKED_WRITES      500     /* RO */
>> --
>> 2.1.0.rc2.206.gedb03e5
>>
>
> Nitpick: You are adding a few EXT_CSD defines that's not required by
> this patch. Normally I would prefer to keep things separate, could you
> maybe split those pieces?
>
> Kind regards
> Uffe
