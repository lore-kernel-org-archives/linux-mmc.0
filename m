From: Adriano Martins <adrianomatosmartins@gmail.com>
Subject: mmc/sd remove without umount
Date: Fri, 8 Nov 2013 13:39:09 -0200
Message-ID: <CAJRKTVophUmV5_Hbz9WmUBjgj87UVQxEGz9iyK+gZ-JCr8jXPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-we0-f170.google.com ([74.125.82.170]:57165 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756797Ab3KHPjb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 8 Nov 2013 10:39:31 -0500
Received: by mail-we0-f170.google.com with SMTP id u57so2170444wes.1
        for <linux-mmc@vger.kernel.org>; Fri, 08 Nov 2013 07:39:30 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi all,

I have a issue when I remove the SD card without unmount before. I
have linux-2.6.23 on powerpc processor that is used the mmc/SD in SPI
mode.

When I remove the card in a file transfer, and try to umount with -l,
I face a problem if I insert it again. The mmc-block registers the
card on a second device /dev/mmcblk1, where before was /dev/mmcblk0.


I have worked in the kernel 3.0 and this issue do not happens.

I already searched in the linux-mmc for answers, but I can't find. Is
it a known issue?

I see that when the problem occurs, the variable md->usage is not
decremented to 0 in the mmc-block driver. Why it occurs?

Regards
Adriano Martins
