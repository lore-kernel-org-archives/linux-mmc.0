From: NamJae Jeon <linkinjeon@gmail.com>
Subject: Re: [PATCH v10] mmc : general purpose partition support.
Date: Wed, 5 Oct 2011 20:49:24 +0900
Message-ID: <CAKYAXd9OBgjjHHdqajgVtR4hBFs6cCGveahzgrT6x2_C+jP_Cw@mail.gmail.com>
References: <1317750317-4489-1-git-send-email-linkinjeon@gmail.com>
	<4E8C1F98.9070909@intel.com>
	<CAKYAXd-9+_1TBniszQir+krF1fRqzBMiAAX9PgzaW+odps0EDg@mail.gmail.com>
	<4E8C370E.7080806@intel.com>
	<CAKYAXd_AoSgY6htSO5jJyD3QJ_xXFqgKLyNX49s3PuRW6AUmbg@mail.gmail.com>
	<CAKYAXd9iHW3bdeFkq=ywdOTPtzFdqK8Yb9fXxi8Jvoq6BRvHtQ@mail.gmail.com>
	<4E8C4163.1090109@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:54906 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934221Ab1JELt0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Oct 2011 07:49:26 -0400
In-Reply-To: <4E8C4163.1090109@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, awarkentin@vmware.com, linus.walleij@linaro.org, james_p_freyensee@linux.intel.com, sebras@gmail.com, Ulf.Hansson@stericsson.com, stefan.xk.nilsson@stericsson.com, per.forlin@stericsson.com, johan.rudholm@stericsson.com

2011/10/5 Adrian Hunter <adrian.hunter@intel.com>:
> On 05/10/11 14:22, NamJae Jeon wrote:
>>
>> 2011/10/5 NamJae Jeon<linkinjeon@gmail.com>:
>>>
>>> 2011/10/5 Adrian Hunter<adrian.hunter@intel.com>:
>>>>
>>>> On 05/10/11 13:21, NamJae Jeon wrote:
>>>>>
>>>>> 2011/10/5 Adrian Hunter<adrian.hunter@intel.com>:
>>>>>>
>>>>>> On 04/10/11 20:45, Namjae Jeon wrote:
>>>>>>>
>>>>>>> It allows gerneral purpose partitions in MMC Device.
>>>>>>> And I try to simpliy make mmc_blk_alloc_parts using mmc_part
>>>>>>> structure
>>>>>>> suggested by Andrei Warkentin.
>>>>>>> After patching, we can see general purpose partitions like this=
=2E
>>>>>>>>
>>>>>>>> cat /proc/partitions
>>>>>>>
>>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 179 0 847872 mmcblk0
>>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 179 192 4096 mmcblk0gp3
>>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 179 160 4096 mmcblk0gp2
>>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 179 128 4096 mmcblk0gp1
>>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 179 96 =C2=A01052672 mmcblk0=
gp0
>>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 179 64 =C2=A01024 mmcblk0boo=
t1
>>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 179 32 =C2=A01024 mmcblk0boo=
t0
>>>>>>>
>>>>>>> Signed-off-by: Namjae Jeon<linkinjeon@gmail.com>
>>>>>>> ---
>>>>>>> =C2=A0drivers/mmc/card/block.c | =C2=A0 34 +++++++++++++++++---=
---------
>>>>>>> =C2=A0drivers/mmc/core/mmc.c =C2=A0 | =C2=A0 52
>>>>>>> ++++++++++++++++++++++++++++++++++++++++++---
>>>>>>> =C2=A0include/linux/mmc/card.h | =C2=A0 34 ++++++++++++++++++++=
+++++++++-
>>>>>>> =C2=A0include/linux/mmc/mmc.h =C2=A0| =C2=A0 =C2=A05 +++-
>>>>>>> =C2=A04 files changed, 105 insertions(+), 20 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.=
c
>>>>>>> index 782d5f8..fb6f1e9 100644
>>>>>>> --- a/drivers/mmc/card/block.c
>>>>>>> +++ b/drivers/mmc/card/block.c
>>>>>>> @@ -1470,26 +1470,32 @@ static int mmc_blk_alloc_part(struct mm=
c_card
>>>>>>> *card,
>>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
>>>>>>> =C2=A0}
>>>>>>>
>>>>>>> +/* MMC Physical partition consist of two boot partitions and
>>>>>>> + * up to four general purpose partitions.
>>>>>>> + * For each partitions enabled in EXT_CSD
>>>>>>> + * The block device will allocated to provide access to the
>>>>>>> partition.
>>>>>>> + */
>>>>>>> +
>>>>>>> =C2=A0static int mmc_blk_alloc_parts(struct mmc_card *card, str=
uct
>>>>>>> mmc_blk_data
>>>>>>> *md)
>>>>>>> =C2=A0{
>>>>>>> - =C2=A0 =C2=A0 =C2=A0 int ret =3D 0;
>>>>>>> + =C2=A0 =C2=A0 =C2=A0 int idx, ret =3D 0;
>>>>>>>
>>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!mmc_card_mmc(card))
>>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0=
;
>>>>>>>
>>>>>>> - =C2=A0 =C2=A0 =C2=A0 if (card->ext_csd.boot_size&&
>>>>>>> =C2=A0mmc_boot_partition_access(card->host)) {
>>>>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D mmc_=
blk_alloc_part(card, md,
>>>>>>> EXT_CSD_PART_CONFIG_ACC_BOOT0,
>>>>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0card->ext_csd.boot_size>>
>>>>>>> =C2=A0 =C2=A09,
>>>>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0true,
>>>>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0"boot0");
>>>>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret)
>>>>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 return ret;
>>>>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D mmc_=
blk_alloc_part(card, md,
>>>>>>> EXT_CSD_PART_CONFIG_ACC_BOOT1,
>>>>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0card->ext_csd.boot_size>>
>>>>>>> =C2=A0 =C2=A09,
>>>>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0true,
>>>>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0"boot1");
>>>>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret)
>>>>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 return ret;
>>>>>>> + =C2=A0 =C2=A0 =C2=A0 for (idx =3D 0; idx< =C2=A0 =C2=A0 =C2=A0=
card->nr_parts; idx++) {
>>>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((idx =3D=
=3D 0 || idx =3D=3D 1)&&
>>>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 !mmc_boot_partition_access(card->host))
>>>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 continue;
>>>>>>
>>>>>> Seems a bit fragile. =C2=A0What if someone decided to put the gp
>>>>>> partitions before the boot partitions. =C2=A0What about:
>>>>>
>>>>> There are the default two boot partition in mmc spec. I think tha=
t
>>>>> this case can not be happened.
>>>>> And boot partition size of EXT CSD is read-only.
>>>>> Can you explain which is case put to gp partitions before the boo=
t
>>>>> partition ?
>>>>
>>>> Relying on the partition order in the partition array is fragile.
>>>> You cannot predict how someone may want to change it in the future=
,
>>>> and that person will not expect that certain positions have certai=
n
>>>> meaning.
>>
>> 0,1 of Boot partition is fixed if spec is not changed over. but gp
>
> No. 0,1 are an accidental result of the order in which ext-csd is
> parsed.
>
>> partition is variable in 2,3,4,5,6 of array.
>> If How someone change code, problem occur ?
>
> If you move code around in mmc_read_ext_csd() the order can change,
> hence it is fragile.
As I remember, boot size can be default zero in the mmc device 4.3 of
some chip vendor.
and it should set proper size using vendor cmd. but gp partition is
not support in mmc 4.3.
um.. I will add your suggested code to avoid vendor specific part in MM=
C 4.4.
Thanks Adrian~

>
>>>>
>>>>>
>>>>>>
>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (mmc_i=
s_boot_partition(&part[idx])&&
>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0!mmc_boot_partition_access(card->host)
>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0continue;
>>>>>>
>>>>>> And:
>>>>>>
>>>>>> int mmc_is_boot_partition(struct mmc_part *part)
>>>>>> {
>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0return part->part_cfg>=3D EXT_CSD_PAR=
T_CONFIG_ACC_BOOT0&&
>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 part->part_cfg<=
=3D EXT_CSD_PART_CONFIG_ACC_BOOT0 +
>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MMC_NUM_BOOT_PARTITION;
>>>>>> }
>>>>>>
>>>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (card->pa=
rt[idx].size) {
>>>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 ret =3D mmc_blk_alloc_part(card, md,
>>>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 card->part[idx].part_cfg,
>>>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 card->part[idx].size>> =C2=A0=
 =C2=A0 =C2=A09,
>>>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 card->part[idx].force_ro,
>>>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 card->part[idx].name);
>>>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 if (ret)
>>>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;
>>>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>>>>>>>
>>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
>>>>>>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>>>>>>> index c632b1f..2f458a0 100644
>>>>>>> --- a/drivers/mmc/core/mmc.c
>>>>>>> +++ b/drivers/mmc/core/mmc.c
>>>>>>> @@ -239,7 +239,9 @@ static int mmc_get_ext_csd(struct mmc_card =
*card,
>>>>>>> u8
>>>>>>> **new_ext_csd)
>>>>>>> =C2=A0 */
>>>>>>> =C2=A0static int mmc_read_ext_csd(struct mmc_card *card, u8 *ex=
t_csd)
>>>>>>> =C2=A0{
>>>>>>> - =C2=A0 =C2=A0 =C2=A0 int err =3D 0;
>>>>>>> + =C2=A0 =C2=A0 =C2=A0 int err =3D 0, idx;
>>>>>>> + =C2=A0 =C2=A0 =C2=A0 unsigned int part_size;
>>>>>>> + =C2=A0 =C2=A0 =C2=A0 u8 hc_erase_grp_sz =3D 0, hc_wp_grp_sz =3D=
 0;
>>>>>>>
>>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0BUG_ON(!card);
>>>>>>>
>>>>>>> @@ -340,7 +342,14 @@ static int mmc_read_ext_csd(struct mmc_car=
d
>>>>>>> *card,
>>>>>>> u8
>>>>>>> *ext_csd)
>>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * There=
 are two boot regions of equal size, defined
>>>>>>> in
>>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * multi=
ples of 128K.
>>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
>>>>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 card->ext_cs=
d.boot_size =3D
>>>>>>> ext_csd[EXT_CSD_BOOT_MULT]<<
>>>>>>> =C2=A017;
>>>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ext_csd[=
EXT_CSD_BOOT_MULT]) {
>>>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 for (idx =3D 0; idx<
>>>>>>> =C2=A0MMC_NUM_BOOT_PARTITION;
>>>>>>> idx++)
>>>>>>> {
>>>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 part_size =3D
>>>>>>> ext_csd[EXT_CSD_BOOT_MULT]<<
>>>>>>> =C2=A017;
>>>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmc_part_add(card, part_size=
,
>>>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
EXT_CSD_PART_CONFIG_ACC_BOOT0
>>>>>>> +
>>>>>>> idx,
>>>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
"boot%d", idx, true);
>>>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 }
>>>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>>>>>>>
>>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0card->ext_csd.raw_hc_erase_gap_size =
=3D
>>>>>>> @@ -362,9 +371,9 @@ static int mmc_read_ext_csd(struct mmc_card
>>>>>>> *card,
>>>>>>> u8
>>>>>>> *ext_csd)
>>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0card->ex=
t_csd.raw_partition_support =3D
>>>>>>> ext_csd[EXT_CSD_PARTITION_SUPPORT];
>>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((ext=
_csd[EXT_CSD_PARTITION_SUPPORT]& =C2=A0 =C2=A0 =C2=A00x2)&&
>>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(ext_csd=
[EXT_CSD_PARTITION_ATTRIBUTE]& =C2=A0 =C2=A0 =C2=A00x1)) {
>>>>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 u8 hc_erase_grp_sz =3D
>>>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 hc_erase_grp_sz =3D
>>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ext_csd[EXT_CSD_HC_ERAS=
E_GRP_SIZE];
>>>>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 u8 hc_wp_grp_sz =3D
>>>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 hc_wp_grp_sz =3D
>>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ext_csd[EXT_CSD_HC_WP_G=
RP_SIZE];
>>>>>>>
>>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0card->ext_csd.enhanced_area_en =3D 1;
>>>>>>> @@ -393,6 +402,41 @@ static int mmc_read_ext_csd(struct mmc_car=
d
>>>>>>> *card,
>>>>>>> u8
>>>>>>> *ext_csd)
>>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0card->ext_csd.enhanced_area_offset =3D -EINVAL;
>>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0card->ext_csd.enhanced_area_size =3D -EINVAL;
>>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>>>>>>> +
>>>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
>>>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Gene=
ral purpose partition feature support --
>>>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* If e=
xt_csd have the size of general purpose
>>>>>>> partitions,
>>>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* set =
size, part_cfg, partition name in mmc_part.
>>>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>>>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ext_csd[=
EXT_CSD_PARTITION_SUPPORT]&
>>>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 EXT_CSD_PART_SUPPORT_PART_EN) {
>>>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 if (card->ext_csd.enhanced_area_en !=3D 1) {
>>>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hc_erase_grp_sz =3D
>>>>>>> +
>>>>>>> ext_csd[EXT_CSD_HC_ERASE_GRP_SIZE];
>>>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hc_wp_grp_sz =3D
>>>>>>> +
>>>>>>> ext_csd[EXT_CSD_HC_WP_GRP_SIZE];
>>>>>>> +
>>>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 card->ext_csd.enhanced_area_=
en =3D 1;
>>>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 }
>>>>>>> +
>>>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 for (idx =3D 0; idx< =C2=A0 =C2=A0 =C2=A0MMC_NUM_GP_PART=
ITION;
>>>>>>> idx++) {
>>>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!ext_csd[EXT_CSD_GP_SIZE=
_MULT +
>>>>>>> idx
>>>>>>> *
>>>>>>> 3]&&
>>>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !ext_csd[EXT_CSD_GP_SIZE_MUL=
T + idx *
>>>>>>> 3
>>>>>>> +
>>>>>>> 1]&&
>>>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !ext_csd[EXT_CSD_GP_SIZE_MUL=
T + idx *
>>>>>>> 3
>>>>>>> +
>>>>>>> 2])
>>>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
continue;
>>>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 part_size =3D
>>>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (ext_csd[EXT_CSD_GP_SIZE_MUL=
T + idx *
>>>>>>> 3
>>>>>>> +
>>>>>>> 2]
>>>>>>> +<< =C2=A0 =C2=A0 =C2=A016) +
>>>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (ext_csd[EXT_CSD_GP_SIZE_MUL=
T + idx *
>>>>>>> 3
>>>>>>> +
>>>>>>> 1]
>>>>>>> +<< =C2=A0 =C2=A0 =C2=A08) +
>>>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ext_csd[EXT_CSD_GP_SIZE_MULT=
 + idx *
>>>>>>> 3];
>>>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 part_size *=3D (size_t)(hc_e=
rase_grp_sz
>>>>>>> *
>>>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
hc_wp_grp_sz);
>>>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmc_part_add(card, part_size=
<<
>>>>>>> =C2=A019,
>>>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
EXT_CSD_PART_CONFIG_ACC_GP0 +
>>>>>>> idx,
>>>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
"gp%d", idx, false);
>>>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 }
>>>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0card->ex=
t_csd.sec_trim_mult =3D
>>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0ext_csd[EXT_CSD_SEC_TRIM_MULT];
>>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0card->ex=
t_csd.sec_erase_mult =3D
>>>>>>> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.=
h
>>>>>>> index 5294ddf..0522627 100644
>>>>>>> --- a/include/linux/mmc/card.h
>>>>>>> +++ b/include/linux/mmc/card.h
>>>>>>> @@ -12,6 +12,7 @@
>>>>>>>
>>>>>>> =C2=A0#include<linux/mmc/core.h>
>>>>>>> =C2=A0#include<linux/mod_devicetable.h>
>>>>>>> +#include<linux/genhd.h>
>>>>>>>
>>>>>>> =C2=A0struct mmc_cid {
>>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0manfid;
>>>>>>> @@ -64,7 +65,6 @@ struct mmc_ext_csd {
>>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0bool =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0enhanced_area_en; =C2=A0 =C2=A0 =C2=
=A0 /* enable bit
>>>>>>> */
>>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long long =C2=A0 =C2=A0 =C2=
=A0enhanced_area_offset; =C2=A0 /* Units: Byte
>>>>>>> */
>>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0enhanced_area_size; =C2=A0 =C2=A0 /* Units: KB
>>>>>>> */
>>>>>>> - =C2=A0 =C2=A0 =C2=A0 unsigned int =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0boot_size; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
/* in bytes
>>>>>>> */
>>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0u8 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raw_partition_support; =C2=A0=
/* 160 */
>>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0u8 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raw_erased_mem_count; =C2=A0 =
/* 181 */
>>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0u8 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raw_ext_csd_structure; =C2=A0=
/* 194 */
>>>>>>> @@ -158,6 +158,23 @@ struct sdio_func_tuple;
>>>>>>>
>>>>>>> =C2=A0#define SDIO_MAX_FUNCS =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A07
>>>>>>>
>>>>>>> +/* The number of MMC physical partitions
>>>>>>> + * It consist of boot partitions(2), general purpose partition=
s(4)
>>>>>>> in
>>>>>>> MMC
>>>>>>> v4.4
>>>>>>> + */
>>>>>>> +#define MMC_NUM_BOOT_PARTITION 2
>>>>>>> +#define MMC_NUM_GP_PARTITION =C2=A0 4
>>>>>>> +#define MMC_NUM_PHY_PARTITION =C2=A06
>>>>>>> +
>>>>>>> +/*
>>>>>>> + * MMC Physical partitions
>>>>>>> + */
>>>>>>> +struct mmc_part {
>>>>>>> + =C2=A0 =C2=A0 =C2=A0 unsigned int =C2=A0 =C2=A0size; =C2=A0 /=
* partition size (in bytes) */
>>>>>>> + =C2=A0 =C2=A0 =C2=A0 unsigned int =C2=A0 =C2=A0part_cfg; =C2=A0=
 =C2=A0 =C2=A0 /* it used to part_type */
>>>>>>> + =C2=A0 =C2=A0 =C2=A0 char =C2=A0 =C2=A0name[DISK_NAME_LEN];
>>>>>>> + =C2=A0 =C2=A0 =C2=A0 bool =C2=A0 =C2=A0force_ro; =C2=A0 =C2=A0=
 =C2=A0 /* to make boot parts RO by default
>>>>>>> */
>>>>>>> +};
>>>>>>> +
>>>>>>> =C2=A0/*
>>>>>>> =C2=A0 * MMC device
>>>>>>> =C2=A0 */
>>>>>>> @@ -219,9 +236,24 @@ struct mmc_card {
>>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0sd_bus_speed; =C2=A0 /* Bus Speed Mode set
>>>>>>> for
>>>>>>> the card */
>>>>>>>
>>>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct dentry =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 *debugfs_root;
>>>>>>> + =C2=A0 =C2=A0 =C2=A0 struct mmc_part part[MMC_NUM_PHY_PARTITI=
ON]; /* physical
>>>>>>> partitions */
>>>>>>> + =C2=A0 =C2=A0 =C2=A0 unsigned int =C2=A0 =C2=A0nr_parts;
>>>>>>> =C2=A0};
>>>>>>>
>>>>>>> =C2=A0/*
>>>>>>> + * This function fill contents in mmc_part.
>>>>>>> + */
>>>>>>> +static inline void mmc_part_add(struct mmc_card *card, unsigne=
d int
>>>>>>> size,
>>>>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 unsigned int part_cfg, char *name, int idx,
>>>>>>> bool
>>>>>>> ro)
>>>>>>> +{
>>>>>>> + =C2=A0 =C2=A0 =C2=A0 card->part[card->nr_parts].size =3D size=
;
>>>>>>> + =C2=A0 =C2=A0 =C2=A0 card->part[card->nr_parts].part_cfg =3D =
part_cfg;
>>>>>>> + =C2=A0 =C2=A0 =C2=A0 sprintf(card->part[card->nr_parts].name,=
 name, idx);
>>>>>>> + =C2=A0 =C2=A0 =C2=A0 card->part[card->nr_parts].force_ro =3D =
ro;
>>>>>>> + =C2=A0 =C2=A0 =C2=A0 card->nr_parts++;
>>>>>>> +}
>>>>>>> +
>>>>>>> +/*
>>>>>>> =C2=A0 * =C2=A0The world is not perfect and supplies us with br=
oken mmc/sdio
>>>>>>> devices.
>>>>>>> =C2=A0 * =C2=A0For at least some of these bugs we need a work-a=
round.
>>>>>>> =C2=A0 */
>>>>>>> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
>>>>>>> index 50af227..ea558eb 100644
>>>>>>> --- a/include/linux/mmc/mmc.h
>>>>>>> +++ b/include/linux/mmc/mmc.h
>>>>>>> @@ -270,6 +270,7 @@ struct _mmc_csd {
>>>>>>> =C2=A0 * EXT_CSD fields
>>>>>>> =C2=A0 */
>>>>>>>
>>>>>>> +#define EXT_CSD_GP_SIZE_MULT =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 143 =C2=A0 =C2=A0 /* R/W */
>>>>>>> =C2=A0#define EXT_CSD_PARTITION_ATTRIBUTE =C2=A0 156 =C2=A0 =C2=
=A0 /* R/W */
>>>>>>> =C2=A0#define EXT_CSD_PARTITION_SUPPORT =C2=A0 =C2=A0 160 =C2=A0=
 =C2=A0 /* RO */
>>>>>>> =C2=A0#define EXT_CSD_RST_N_FUNCTION =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0162 =C2=A0 =C2=A0 /* R/W */
>>>>>>> @@ -313,7 +314,9 @@ struct _mmc_csd {
>>>>>>>
>>>>>>> =C2=A0#define EXT_CSD_PART_CONFIG_ACC_MASK =C2=A0(0x7)
>>>>>>> =C2=A0#define EXT_CSD_PART_CONFIG_ACC_BOOT0 (0x1)
>>>>>>> -#define EXT_CSD_PART_CONFIG_ACC_BOOT1 =C2=A0(0x2)
>>>>>>> +#define EXT_CSD_PART_CONFIG_ACC_GP0 =C2=A0 =C2=A0(0x4)
>>>>>>> +
>>>>>>> +#define EXT_CSD_PART_SUPPORT_PART_EN =C2=A0 (0x1)
>>>>>>>
>>>>>>> =C2=A0#define EXT_CSD_CMD_SET_NORMAL =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1<<0)
>>>>>>> =C2=A0#define EXT_CSD_CMD_SET_SECURE =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1<<1)
>>>>>>
>>>>>>
>>>>
>>>>
>>>
>
>
