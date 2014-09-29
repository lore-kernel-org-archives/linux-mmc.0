From: Holger Schurig <holgerschurig@gmail.com>
Subject: eMMC and "mkfs.ext3" hangs without "-E nodiscard"
Date: Mon, 29 Sep 2014 15:46:10 +0200
Message-ID: <CAOpc7mF+9DgEeikB-gjGphPnsC_Ku+9=AtdGUaQEZYK6Jm77vA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:49061 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754173AbaI2NqM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Sep 2014 09:46:12 -0400
Received: by mail-wg0-f45.google.com with SMTP id m15so466439wgh.16
        for <linux-mmc@vger.kernel.org>; Mon, 29 Sep 2014 06:46:11 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi all,

on kernel 3.16.3 running on an i.MX6 with an eMMC card formatting a
partition won't work, it hangs. With an added -v the last thing it
spit out is "Discarding device blocks: 4096/196608".

When I run mkfs with "-E nodiscard", formatting & booting works.


Noteworthy: when the eMMC device was still in virgin mode,
partitioning without "-E nodiscard" worked. But last week I used the
mmc tool to turn the user space into enhanced format. Basically, I
first run "mmc extcsd read /dev/mmcblk0" and used the number after
MAX_ENH_SIZE_MULT for an "mmc enh_area set -y 0 7651323 /dev/mmcblk0".
Then, after a power-cycle, I also turned bkops on because kernel was
complaining that it wasn't enabled. And since the default discard
option of mkfs.ext3 doesn't seem to work anymore.
