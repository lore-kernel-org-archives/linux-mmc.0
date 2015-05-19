From: Andre <andre.2995@gmail.com>
Subject: Question about errors encountered using mmc_test
Date: Tue, 19 May 2015 12:13:52 -0500
Message-ID: <CANQWhJg6-gnCv3Wqcm7NOTYseF366HHv4_YNneA+y6QDCn42iw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:38002 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268AbbESRNx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 May 2015 13:13:53 -0400
Received: by wichy4 with SMTP id hy4so30699323wic.1
        for <linux-mmc@vger.kernel.org>; Tue, 19 May 2015 10:13:52 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hello all, I'm new to the mailing list, so please forgive if this
question is out of line.

I'm trying to run the suite of MMC tests from mmc_test, using the
directions found here:

http://wiki.laptop.org/go/Tiny_Core_Linux/eMMC

When I get to the last step, "for x in $(seq 45); do..." I get an
output full of the following message:

-bash: test: Permission denied

Not surprisingly, this message is output 45 times.

What I am trying to do is debug an interface to an MMC chip on new
hardware.  I tried to use parted to create a partition table.
Basically I try to make a label first, with

mklabel gpt

and that command "doesn't complain".  But then I try to make the table using:

mkpart primary ext2 0 -1s

And I get the message:

Error: Unable to open /dev/mmcblk0 - unrecognised disk label.

For most commands I get this same message.

So any advice or suggestions are appreciated.

Andre
