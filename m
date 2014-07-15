From: Clemens Eisserer <linuxhippy@gmail.com>
Subject: Re: No UHS support for O2 Micro, Inc. OZ600FJ0/OZ900FJ0/OZ600FJS?
Date: Tue, 15 Jul 2014 20:14:52 +0200
Message-ID: <CAFvQSYSaxWSSNo0_zAHFcOkpbeaJP9UOtmBSZnYYrbE6+ON9YQ@mail.gmail.com>
References: <CAFvQSYQtVWOqjjn_3Tr6R2VfgKb-=z2sb39A0HowJPehYYagQw@mail.gmail.com>
	<CAFvQSYS32yVA4-gLUzyfzZWbBqSBsGHEAUdA6DPwZnw6U2E0OQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f173.google.com ([209.85.220.173]:52743 "EHLO
	mail-vc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932704AbaGOSOx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Jul 2014 14:14:53 -0400
Received: by mail-vc0-f173.google.com with SMTP id hy10so7108473vcb.4
        for <linux-mmc@vger.kernel.org>; Tue, 15 Jul 2014 11:14:52 -0700 (PDT)
In-Reply-To: <CAFvQSYS32yVA4-gLUzyfzZWbBqSBsGHEAUdA6DPwZnw6U2E0OQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Just a short follow-up:

The card (Samsung SD Pro 16GB) the internal O2 card reader writes to
sequentially at 4.2mb/s handles 14.4 mb/s in the raspberry pi (and
about 30mb/s in the O2 + windows 7):

Raspberry:
> ce@raspberrypi:~# dd if=/dev/zero of=/dev/mmcblk0 conv=fsync bs=4M count=256
> 1073741824 bytes (1.1 GB) copied, 74.4169 s, 14.4 MB/s

SandyBridge Core i7 + O2 pci card reader (Linux 3.15.4):
> dd if=/dev/sda of=/dev/mmcblk0 conv=fsync bs=4M count=256
> 1073741824 bytes (1.1 GB) copied, 258.515 s, 4.2 MB/s

Any idea what I could do to find out why the internal card reader is
so slow under Linux?

Thank you in advance, Clemens
