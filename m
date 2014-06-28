From: Clemens Eisserer <linuxhippy@gmail.com>
Subject: No UHS support for O2 Micro, Inc. OZ600FJ0/OZ900FJ0/OZ600FJS?
Date: Sat, 28 Jun 2014 09:42:43 +0200
Message-ID: <CAFvQSYQtVWOqjjn_3Tr6R2VfgKb-=z2sb39A0HowJPehYYagQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f179.google.com ([209.85.220.179]:62156 "EHLO
	mail-vc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751079AbaF1Hmo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 28 Jun 2014 03:42:44 -0400
Received: by mail-vc0-f179.google.com with SMTP id id10so5858185vcb.10
        for <linux-mmc@vger.kernel.org>; Sat, 28 Jun 2014 00:42:44 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hello,

My Dell latitude has an integrated O2 Micro SDHC card reader, listed
by lspci as:
0a:00.0 SD Host controller: O2 Micro, Inc. OZ600FJ0/OZ900FJ0/OZ600FJS
SD/MMC Card Reader Controller (rev 05)

So far I was happily using it with cheap/slow SDHC cards.
However recently I bought a "Samsung SDHC Pro" card which manages to
aequentially write about 45mb/s when I dual-boot Windows7.

The same card caps out on Linux at about ~4-5mb/s:
> dd if=/dev/sda of=/dev/mmcblk0 conv=fsync bs=4M count=256
> 1073741824 bytes (1.1 GB) copied, 258.515 s, 4.2 MB/s

My raspberry pi is able to write to the card at about ~8mb/s.

Any ideas how to debug this issue would be highly appreciated.

Thank you in advance, Clemens
