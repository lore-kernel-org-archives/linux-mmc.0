From: NamJae Jeon <linkinjeon@gmail.com>
Subject: Re: [PATCH v11] mmc : general purpose partition support.
Date: Thu, 6 Oct 2011 09:13:50 +0900
Message-ID: <CAKYAXd9wqjK90pn6YHNGKi+gDEqwDV4x14CrY-Nc7JHQ_Ed7xw@mail.gmail.com>
References: <1317825945-1918-1-git-send-email-linkinjeon@gmail.com>
	<1757717892.66886.1317828833207.JavaMail.root@zimbra-prod-mbox-2.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:46719 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935580Ab1JFANw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Oct 2011 20:13:52 -0400
In-Reply-To: <1757717892.66886.1317828833207.JavaMail.root@zimbra-prod-mbox-2.vmware.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <awarkentin@vmware.com>
Cc: linux-kernel@vger.kernel.org, adrian hunter <adrian.hunter@intel.com>, linus walleij <linus.walleij@linaro.org>, james p freyensee <james_p_freyensee@linux.intel.com>, sebras@gmail.com, Ulf Hansson <Ulf.Hansson@stericsson.com>, stefan xk nilsson <stefan.xk.nilsson@stericsson.com>, per forlin <per.forlin@stericsson.com>, johan rudholm <johan.rudholm@stericsson.com>, cjb@laptop.org, linux-mmc@vger.kernel.org

2011/10/6 Andrei Warkentin <awarkentin@vmware.com>:
> Hi,
>
> ----- Original Message -----
>> From: "Namjae Jeon" <linkinjeon@gmail.com>
>> To: cjb@laptop.org, linux-mmc@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org, awarkentin@vmware.com, "adrian hun=
ter" <adrian.hunter@intel.com>, "linus walleij"
>> <linus.walleij@linaro.org>, "james p freyensee" <james_p_freyensee@l=
inux.intel.com>, sebras@gmail.com, "Ulf Hansson"
>> <Ulf.Hansson@stericsson.com>, "stefan xk nilsson" <stefan.xk.nilsson=
@stericsson.com>, "per forlin"
>> <per.forlin@stericsson.com>, "johan rudholm" <johan.rudholm@stericss=
on.com>, "Namjae Jeon" <linkinjeon@gmail.com>
>> Sent: Wednesday, October 5, 2011 10:45:45 AM
>> Subject: [PATCH v11] mmc : general purpose partition support.
>>
>> It allows gerneral purpose partitions in MMC Device.
>> And I try to simpliy make mmc_blk_alloc_parts using mmc_part
>> structure suggested by Andrei Warkentin.
>> After patching, we can see general purpose partitions like this.
>> > cat /proc/partitions
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 179 0 847872 mmcblk0
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 179 192 4096 mmcblk0gp3
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 179 160 4096 mmcblk0gp2
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 179 128 4096 mmcblk0gp1
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 179 96 =C2=A01052672 mmcblk0gp0
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 179 64 =C2=A01024 mmcblk0boot1
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 179 32 =C2=A01024 mmcblk0boot0
>>
>> Signed-off-by: Namjae Jeon <linkinjeon@gmail.com>
>> ---
>> =C2=A0drivers/mmc/card/block.c | =C2=A0 41 +++++++++++++++++++++++--=
----------
>> =C2=A0drivers/mmc/core/mmc.c =C2=A0 | =C2=A0 52
>> =C2=A0++++++++++++++++++++++++++++++++++++++++++---
>> =C2=A0include/linux/mmc/card.h | =C2=A0 34 +++++++++++++++++++++++++=
++++-
>> =C2=A0include/linux/mmc/mmc.h =C2=A0| =C2=A0 =C2=A05 +++-
>> =C2=A04 files changed, 112 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>> + =C2=A0 =C2=A0 for (idx =3D 0; idx < card->nr_parts; idx++) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (mmc_is_boot_partitio=
n(&card->part[idx]) &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 !mmc_boot_partition_access(card->host))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 continue;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (card->part[idx].size=
) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ret =3D mmc_blk_alloc_part(card, md,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 card->part[idx].part_cfg,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 card->part[idx].size >> 9,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 card->part[idx].force_ro,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 card->part[idx].name);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if (ret)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> =C2=A0 =C2=A0 =C2=A0 }
>
> Is there any reason for putting the mmc_boot_partition_access() logic=
 here? If
> boot partitions are not allowed by host, then just don't add the mmc_=
parts to
> the parts array, no? Such minutae should belong in core mmc code, not=
 block driver, IMHO.

Hi.

How about changing patch like this ?

if (ext_csd[EXT_CSD_BOOT_MULT] && mmc_boot_partition_access(card->host)=
) {
                        for (idx =3D 0; idx < MMC_NUM_BOOT_PARTITION; i=
dx++) {
                                part_size =3D ext_csd[EXT_CSD_BOOT_MULT=
] << 17;
                                mmc_part_add(card, part_size,
                                        EXT_CSD_PART_CONFIG_ACC_BOOT0 +=
 idx,
                                        "boot%d", idx, true);
                        }
                }

I want to hear the opinion from andrei and
adrian(mmc_boot_partition_access patch's author)
Thanks.
>
> A
>
