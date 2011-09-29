From: NamJae Jeon <linkinjeon@gmail.com>
Subject: Re: [PATCH v2] mmc : general purpose partition support.
Date: Thu, 29 Sep 2011 10:03:28 +0900
Message-ID: <CAKYAXd8q=ksfOxjoC4L3Cmh6EvQg74Saz4b7nO8790Z+1Lo7-w@mail.gmail.com>
References: <1316840820-2014-1-git-send-email-linkinjeon@gmail.com>
	<1419276380.765271.1317226086965.JavaMail.root@zimbra-prod-mbox-2.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:42437 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754109Ab1I2BDa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Sep 2011 21:03:30 -0400
In-Reply-To: <1419276380.765271.1317226086965.JavaMail.root@zimbra-prod-mbox-2.vmware.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <awarkentin@vmware.com>
Cc: linux-kernel@vger.kernel.org, adrian hunter <adrian.hunter@intel.com>, james p freyensee <james_p_freyensee@linux.intel.com>, cjb@laptop.org, linux-mmc@vger.kernel.org

2011/9/29 Andrei Warkentin <awarkentin@vmware.com>:
> Hi Namjae,
>
> In general I think your approach is fine and solves the problem. See =
further inline
> comments.
>
> ----- Original Message -----
>> From: "Namjae Jeon" <linkinjeon@gmail.com>
>> To: cjb@laptop.org, linux-mmc@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org, awarkentin@vmware.com, "adrian hun=
ter" <adrian.hunter@intel.com>, "james p
>> freyensee" <james_p_freyensee@linux.intel.com>, "Namjae Jeon" <linki=
njeon@gmail.com>
>> Sent: Saturday, September 24, 2011 1:07:00 AM
>> Subject: [PATCH v2] mmc : general purpose partition support.
>>
>> It allows gerneral purpose partitions in MMC Device.
>> And I try to simpliy make mmc_blk_alloc_parts using mmc_part
>> structure suggested by Andrei Warkentin.
>> After patching, we can see general purpose partitions like this.
>> > cat /proc/partitions
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 179 0 847872 mmcblk0
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 179 192 4096 mmcblk0gp4
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 179 160 4096 mmcblk0gp3
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 179 128 4096 mmcblk0gp2
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 179 96 =C2=A01052672 mmcblk0gp1
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 179 64 =C2=A01024 mmcblk0boot1
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 179 32 =C2=A01024 mmcblk0boot0
>>
>> Signed-off-by: Namjae Jeon <linkinjeon@gmail.com>
>
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ext_csd[EXT_CSD_BOOT=
_MULT]) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 for (i =3D 0, boot_part_config =3D 0x1;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i < MMC_NUM_BOOT_PARTITION;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i++, boot_part_config++) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 card->part[i].size =3D ...
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 card->part[i].cookie =3D ...
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sprintf(card->part[i].name, "boot%d", i=
);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 card->part[i].force_ro =3D ...
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 }
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> =C2=A0 =C2=A0 =C2=A0 }
>>
>>
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ext_csd[EXT_CSD_PART=
ITION_SUPPORT] & 0x1) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ....
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 int i, gp_num, gp_part_config, gp_size_mult;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 for (i =3D 2, gp_num =3D 1, gp_part_config =3D 0x4,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 card->part[i].size =3D ...
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 card->part[i].cookie =3D ...
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sprintf(card->part[i].name,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "gp%d", gp_=
num);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 card->part[i].force_ro =3D ..
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 }
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>>
>
> I feel that you should factor out a function that operates on the sta=
tic part[] array and
> adds a new entry base name, index (i.e. the %d for gp%d), cookie, siz=
e, force.
> Otherwise you end up with these hidden mines like fixed indeces for
> particular parts (i =3D 2, etc...) which becomes indecipherable for o=
thers.
> Plus you're mostly doing the same thing.
>
Hi.
I think that factoring out a function will be not inefficient by many
agument and size calculation,. etc.
And I agree about readabiliby, readability is dropped by some fixed
value. so I will modify current patch.
plz review one more when I post new patch.
Thanks.
> Thanks,
> A
>
