From: NamJae Jeon <linkinjeon@gmail.com>
Subject: Re: mmc ioctl for hw reset ,partitiing, enhanced area setting, boot
 partition update.
Date: Tue, 5 Apr 2011 16:53:13 +0900
Message-ID: <BANLkTim7g1tWSSiUEje_VDLC27wcQm9HTg@mail.gmail.com>
References: <AANLkTinF8nWeV5sBb1FOswvPTVgOSbbCNGkOEsiX2+rV@mail.gmail.com>
	<AANLkTik_rGsh7jOkGBRALtW=DB-x5pQrpu_UjAyq15dR@mail.gmail.com>
	<AANLkTin__DPxqh0QigvNs2TSM5fruyMNMyVAnmFC8HGb@mail.gmail.com>
	<AANLkTin7A3ugk03=501yvCnJUxgbvQrJvX_uYNSLqVMV@mail.gmail.com>
	<AANLkTi=5tVp2NfwqmQVGh13JEgqmEsqXcTF8uMcQ-2v3@mail.gmail.com>
	<AANLkTi=bQ7mqgvK7Hj89FvUxdcGT+Etevi9C5WhJEvjR@mail.gmail.com>
	<AANLkTik=Y8La23fcAxzLk6+t-rRHGnD-Lkf3U95x6pdn@mail.gmail.com>
	<BANLkTikEQu6f1StLPomJzcj8JnkBFs4Ahw@mail.gmail.com>
	<BANLkTik_JN4i-D3jx2sT=VbGK4XLeo56AQ@mail.gmail.com>
	<BANLkTi=KOTp=NuAXi4qZqM6vaQ0qnBij7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:49997 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752470Ab1DEHxP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Apr 2011 03:53:15 -0400
Received: by wwa36 with SMTP id 36so136068wwa.1
        for <linux-mmc@vger.kernel.org>; Tue, 05 Apr 2011 00:53:14 -0700 (PDT)
In-Reply-To: <BANLkTi=KOTp=NuAXi4qZqM6vaQ0qnBij7A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

Hi. Andrei.

Can I know current status of progress accepting partition mangement pat=
ch ?

Thanks.

2011=B3=E2 4=BF=F9 4=C0=CF =BF=C0=C8=C4 9:13, Andrei Warkentin <andreiw=
@motorola.com>=B4=D4=C0=C7 =B8=BB:
> When the boot partitioning patch is accepted, there will be a short
> patch to add GP partitions in.
>
> Thanks,
> A
>
> 2011/4/4 NamJae Jeon <linkinjeon@gmail.com>:
>> Hi. Andrei
>>
>> I checked this patch [RFC] MMC: MMC boot partitions support). Can it
>> support gerneal purpose partition ? Boot partition be only supported
>> in this patch.
>>
>> Is there another patch for general purpose partitions ?
>>
>> Thanks.
>>
>> 2011=B3=E2 4=BF=F9 3=C0=CF =BF=C0=C8=C4 12:03, NamJae Jeon <linkinje=
on@gmail.com>=B4=D4=C0=C7 =B8=BB:
>>> Thanks for your reply.
>>>
>>> 2011. 4. 1. =BF=C0=C8=C4 4:58=BF=A1 "Andrei Warkentin" <andreiw@mot=
orola.com>=B4=D4=C0=CC =C0=DB=BC=BA:
>>>
>>>>
>>>> I highly suggest you read the relevant section in JEDEC eMMC spec,=
 which
>>>> is free.
>>>>
>>>> Writeable attributes in EXT_CSD are manipulated through CMD6.
>>>>
>>>> Thanks,
>>>> A
>>>>
>>>> On Apr 1, 2011 2:51 AM, "NamJae Jeon" <linkinjeon@gmail.com> wrote=
:
>>>> > Hi. Andrei.
>>>> >
>>>> > For partitioning, you suggest I try to use ioctl of ACMD.
>>>> >
>>>> > I don't understand your means. because EXT_CSD is changed for
>>>> > partitioning not CMD.
>>>> >
>>>> > Would you plz explain more ?
>>>> >
>>>> > Thanks.
>>>> >
>>>> > 2011/3/31 NamJae Jeon <linkinjeon@gmail.com>:
>>>> >> Hi, Andrei.
>>>> >>
>>>> >> Thanks. I will check your information.
>>>> >>
>>>> >>
>>>> >> 2011/3/31 Andrei Warkentin <andreiw@motorola.com>:
>>>> >>> Hi,
>>>> >>>
>>>> >>> On Wed, Mar 30, 2011 at 10:11 AM, NamJae Jeon <linkinjeon@gmai=
l.com>
>>>> >>> wrote:
>>>> >>>> usally, bootloader is stored in boot partition. I suggested i=
octl to
>>>> >>>> update bootloader in boot partition not modifing boot partiti=
on size.
>>>> >>>>
>>>> >>>
>>>> >>> Maybe I didn't explain myself clearly enough, sorry. The patch=
 I have
>>>> >>> exposes the boot partitions
>>>> >>> as block devices and you can read and write to them without af=
fecting
>>>> >>> the rest of the MMC card.
>>>> >>>
>>>> >>>> and moviNAND(samsung) is needed by boot parittion size settin=
g. and
>>>> >>>> when boot parition size is changed, all user data will be res=
et, it
>>>> >>>> will be initial status.
>>>> >>>>
>>>> >>>> but iNAND(sandisk) is not needed it. boot partition size is
>>>> >>>> fixed(1MB).
>>>> >>>>
>>>> >>>
>>>> >>> I am unsure what you're talking about. The eMMC 4.41 spec (see=
 7.2)
>>>> >>> does not allow changing boot partition size.
>>>> >>> It is fixed to a certain size, and that size is specified by t=
he
>>>> >>> BOOT_SIZE_MULTI field in EXT_CSD. For the Toshiba devices
>>>> >>> I have around me (MMC08G, MMC16G and MMC32G), each boot partit=
ion (two
>>>> >>> total) is 2MB in size.
>>>> >>>
>>>> >>> I don't think ioctl for accessing device partitions is a good =
idea,
>>>> >>> because the device partitions are just block devices, so they =
should
>>>> >>> be exposed as such.
>>>> >>>
>>>> >>
>>>> >>> For device partitioning, to support create General Purpose par=
titions
>>>> >>> (up to 4), an ioctl is probably needed. You could look at "[PA=
TCH
>>>> >>> resend] mmc: Added ioctl to let userspace apps send ACMDs" by =
John
>>>> >>> Calixto which was last send March 17th. That's generic enough =
to
>>>> >>> support partitioning (which is a one time programming procedur=
e
>>>> >>> anyway...so there may be no value of adding a specific ioctl f=
or it,
>>>> >>> considering how dangerous of an operation it is).
>>>> >>>
>>>> >>> A
>>>> >>>
>>>> >>
>>>
>>
>
