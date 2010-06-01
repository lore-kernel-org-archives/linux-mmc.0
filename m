From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Question of RFKILL for bluetooth, hci_core.c
Date: Tue, 01 Jun 2010 13:00:11 -0700
Message-ID: <1275422411.2182.6.camel@localhost.localdomain>
References: <AANLkTiloq_U8CpoSYw-Vl4Tww27QFP_Wirs37iJLb7yP@mail.gmail.com>
	 <1275087477.4706.85.camel@aeonflux.t-mobile.de>
	 <AANLkTimDk8Nr0ih5VAVi84jKQ3ResR73kTodFoxg9IAG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:41715 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756264Ab0FAUA4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Jun 2010 16:00:56 -0400
In-Reply-To: <AANLkTimDk8Nr0ih5VAVi84jKQ3ResR73kTodFoxg9IAG@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: linux-mmc@vger.kernel.org, Matt Fleming <matt@console-pimps.org>, zgao6@marvell.com

Hi Zangfei,

> > first of all, please use linux-bluetooth mailing list and not the MCC
> > one.
> >
> >> We found you have submitted one patch adding rfkill for bluetoogh.
> >>
> >> commit 611b30f74b5d8ca036a9923b3bf6e0ee10a21a53
> >> Author: Marcel Holtmann <marcel@holtmann.org>
> >> Date:   Mon Jun 8 14:41:38 2009 +0200
> >>
> >>     Bluetooth: Add native RFKILL soft-switch support for all devices
> >>
> >>     With the re-write of the RFKILL subsystem it is now possible to easily
> >>     integrate RFKILL soft-switch support into the Bluetooth subsystem. All
> >>     Bluetooth devices will now get automatically RFKILL support.
> >>
> >>     Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> >>
> >> Question 1,
> >> Once hci_register_dev is called, the rfkill_alloc is called, the
> >> result is the rfkill number is increased one by one,  the application
> >> may not know which rfkill it is.
> >> For example, insmod bt.ko -> rfkill0, rmmod bt; insmod bt.ko->
> >> rfkill1, ~~ rfkill2, 3
> >> Same effect would happen when echo 0 > /sys/class/rfkill/rfkill0/state.
> >>
> >> The reason is rfkill_register would increase rfkill->idx.
> >> int __must_check rfkill_register(struct rfkill *rfkill)
> >> {
> >>         static unsigned long rfkill_no;
> >> ~~~
> >>         rfkill->idx = rfkill_no;
> >>         dev_set_name(dev, "rfkill%lu", rfkill_no);
> >>         rfkill_no++;
> >>
> >> ~~~
> >> }
> >>
> >> Quesiton 2.
> >> In fact, we have own rfkill to control power on and off, then
> >> currently both our own rfkill and bluetooth rfkill need to be enabled.
> >>
> >> I am not sure what's the purpose of the rfkill adding in
> >> hci_register_dev, just wander could we add one default state as
> >> enabled for such rfkill. Then we could ignore this rfkill, no matter
> >> the number is increased one by one.
> >
> > And second it is clearly the soft RFKILL switch. As usual a device can
> > also have a hard kill switch.
> >
> > The index numbers are irrelevant. If the RFKILL switch is assigned to a
> > device is will be a child of its parent, so it is easy to figure out
> > where it belong. In case of platform switches it is impossible anyway
> > and hence we have implemented CHANGE_ALL support.
> >
> 
> Thanks for your explanation, however how to get hard kill switch.
> Ususally we enable wifi via "echo 1 > sys/class/rfkill/rfkill0/state",
> and enable bt via "echo 1 > sys/class/rfkill/rfkill1/state".
> This method highly depends on the indelx number.

just use the rfkill utility. Using the sysfs is a bad idea.

> Could you kindly share me how to set hard kill switch, which may
> irrelevant with the index number.

You can not set hard states from software. They are meant for physical
RFKILL switches.

Regards

Marcel


