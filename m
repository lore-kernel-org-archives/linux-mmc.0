From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: Question of RFKILL for bluetooth, hci_core.c
Date: Tue, 8 Jun 2010 18:22:15 +0800
Message-ID: <AANLkTilYabovivjqHrluD5upFb9LhP9p8M_Cfdx86V-a@mail.gmail.com>
References: <AANLkTiloq_U8CpoSYw-Vl4Tww27QFP_Wirs37iJLb7yP@mail.gmail.com>
	<1275087477.4706.85.camel@aeonflux.t-mobile.de>
	<AANLkTimDk8Nr0ih5VAVi84jKQ3ResR73kTodFoxg9IAG@mail.gmail.com>
	<1275422411.2182.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:54217 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751035Ab0FHKWQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Jun 2010 06:22:16 -0400
Received: by iwn37 with SMTP id 37so4457681iwn.19
        for <linux-mmc@vger.kernel.org>; Tue, 08 Jun 2010 03:22:16 -0700 (PDT)
In-Reply-To: <1275422411.2182.6.camel@localhost.localdomain>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-mmc@vger.kernel.org, Matt Fleming <matt@console-pimps.org>, zgao6@marvell.com

hi, Marcel



On Wed, Jun 2, 2010 at 4:00 AM, Marcel Holtmann <marcel@holtmann.org> w=
rote:
> Hi Zangfei,
>
>> > first of all, please use linux-bluetooth mailing list and not the =
MCC
>> > one.
>> >
>> >> We found you have submitted one patch adding rfkill for bluetoogh=
=2E
>> >>
>> >> commit 611b30f74b5d8ca036a9923b3bf6e0ee10a21a53
>> >> Author: Marcel Holtmann <marcel@holtmann.org>
>> >> Date: =A0 Mon Jun 8 14:41:38 2009 +0200
>> >>
>> >> =A0 =A0 Bluetooth: Add native RFKILL soft-switch support for all =
devices
>> >>
>> >> =A0 =A0 With the re-write of the RFKILL subsystem it is now possi=
ble to easily
>> >> =A0 =A0 integrate RFKILL soft-switch support into the Bluetooth s=
ubsystem. All
>> >> =A0 =A0 Bluetooth devices will now get automatically RFKILL suppo=
rt.
>> >>
>> >> =A0 =A0 Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
>> >>
>> >> Question 1,
>> >> Once hci_register_dev is called, the rfkill_alloc is called, the
>> >> result is the rfkill number is increased one by one, =A0the appli=
cation
>> >> may not know which rfkill it is.
>> >> For example, insmod bt.ko -> rfkill0, rmmod bt; insmod bt.ko->
>> >> rfkill1, ~~ rfkill2, 3
>> >> Same effect would happen when echo 0 > /sys/class/rfkill/rfkill0/=
state.
>> >>
>> >> The reason is rfkill_register would increase rfkill->idx.
>> >> int __must_check rfkill_register(struct rfkill *rfkill)
>> >> {
>> >> =A0 =A0 =A0 =A0 static unsigned long rfkill_no;
>> >> ~~~
>> >> =A0 =A0 =A0 =A0 rfkill->idx =3D rfkill_no;
>> >> =A0 =A0 =A0 =A0 dev_set_name(dev, "rfkill%lu", rfkill_no);
>> >> =A0 =A0 =A0 =A0 rfkill_no++;
>> >>
>> >> ~~~
>> >> }
>> >>
>> >> Quesiton 2.
>> >> In fact, we have own rfkill to control power on and off, then
>> >> currently both our own rfkill and bluetooth rfkill need to be ena=
bled.
>> >>
>> >> I am not sure what's the purpose of the rfkill adding in
>> >> hci_register_dev, just wander could we add one default state as
>> >> enabled for such rfkill. Then we could ignore this rfkill, no mat=
ter
>> >> the number is increased one by one.
>> >
>> > And second it is clearly the soft RFKILL switch. As usual a device=
 can
>> > also have a hard kill switch.
>> >
>> > The index numbers are irrelevant. If the RFKILL switch is assigned=
 to a
>> > device is will be a child of its parent, so it is easy to figure o=
ut
>> > where it belong. In case of platform switches it is impossible any=
way
>> > and hence we have implemented CHANGE_ALL support.
>> >
>>
>> Thanks for your explanation, however how to get hard kill switch.
>> Ususally we enable wifi via "echo 1 > sys/class/rfkill/rfkill0/state=
",
>> and enable bt via "echo 1 > sys/class/rfkill/rfkill1/state".
>> This method highly depends on the indelx number.
>
> just use the rfkill utility. Using the sysfs is a bad idea.
>
>> Could you kindly share me how to set hard kill switch, which may
>> irrelevant with the index number.
>
> You can not set hard states from software. They are meant for physica=
l
> RFKILL switches.
>

=46or how to use rfkill utility?
Do you mean rfkill tool.

$rfkill block bluetooth
to stop Bluetooth and

$rfkill unblock bluetooth
to resume Bluetooth.

If not, is there any example?
I looking for example in kernel, and find many driver use rfkill_alloc
just one time, for example in probe or _init, then the rfkill number
would be keep same.

> Regards
>
> Marcel
>
>
>
