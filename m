From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Question of RFKILL for bluetooth, hci_core.c
Date: Fri, 28 May 2010 15:34:39 +0800
Message-ID: <AANLkTiloq_U8CpoSYw-Vl4Tww27QFP_Wirs37iJLb7yP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:48047 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754552Ab0E1Hek (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 28 May 2010 03:34:40 -0400
Received: by gyg13 with SMTP id 13so691844gyg.19
        for <linux-mmc@vger.kernel.org>; Fri, 28 May 2010 00:34:39 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: marcel@holtmann.org
Cc: linux-mmc@vger.kernel.org, Matt Fleming <matt@console-pimps.org>, zgao6@marvell.com

Hi, Marcel

We found you have submitted one patch adding rfkill for bluetoogh.

commit 611b30f74b5d8ca036a9923b3bf6e0ee10a21a53
Author: Marcel Holtmann <marcel@holtmann.org>
Date:   Mon Jun 8 14:41:38 2009 +0200

    Bluetooth: Add native RFKILL soft-switch support for all devices

    With the re-write of the RFKILL subsystem it is now possible to easily
    integrate RFKILL soft-switch support into the Bluetooth subsystem. All
    Bluetooth devices will now get automatically RFKILL support.

    Signed-off-by: Marcel Holtmann <marcel@holtmann.org>

Question 1,
Once hci_register_dev is called, the rfkill_alloc is called, the
result is the rfkill number is increased one by one,  the application
may not know which rfkill it is.
For example, insmod bt.ko -> rfkill0, rmmod bt; insmod bt.ko->
rfkill1, ~~ rfkill2, 3
Same effect would happen when echo 0 > /sys/class/rfkill/rfkill0/state.

The reason is rfkill_register would increase rfkill->idx.
int __must_check rfkill_register(struct rfkill *rfkill)
{
        static unsigned long rfkill_no;
~~~
        rfkill->idx = rfkill_no;
        dev_set_name(dev, "rfkill%lu", rfkill_no);
        rfkill_no++;

~~~
}

Quesiton 2.
In fact, we have own rfkill to control power on and off, then
currently both our own rfkill and bluetooth rfkill need to be enabled.

I am not sure what's the purpose of the rfkill adding in
hci_register_dev, just wander could we add one default state as
enabled for such rfkill. Then we could ignore this rfkill, no matter
the number is increased one by one.

Thanks
Zhangfei
