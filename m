From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: eMMC and "mkfs.ext3" hangs without "-E nodiscard"
Date: Mon, 29 Sep 2014 16:12:22 +0200
Message-ID: <2065626.g5SozRVghv@wuerfel>
References: <CAOpc7mF+9DgEeikB-gjGphPnsC_Ku+9=AtdGUaQEZYK6Jm77vA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:52765 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754428AbaI2OMZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Sep 2014 10:12:25 -0400
In-Reply-To: <CAOpc7mF+9DgEeikB-gjGphPnsC_Ku+9=AtdGUaQEZYK6Jm77vA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Holger Schurig <holgerschurig@gmail.com>
Cc: linux-mmc@vger.kernel.org

On Monday 29 September 2014 15:46:10 Holger Schurig wrote:
> on kernel 3.16.3 running on an i.MX6 with an eMMC card formatting a
> partition won't work, it hangs. With an added -v the last thing it
> spit out is "Discarding device blocks: 4096/196608".
> 
> When I run mkfs with "-E nodiscard", formatting & booting works.
> 
> 
> Noteworthy: when the eMMC device was still in virgin mode,
> partitioning without "-E nodiscard" worked. But last week I used the
> mmc tool to turn the user space into enhanced format. Basically, I
> first run "mmc extcsd read /dev/mmcblk0" and used the number after
> MAX_ENH_SIZE_MULT for an "mmc enh_area set -y 0 7651323 /dev/mmcblk0".
> Then, after a power-cycle, I also turned bkops on because kernel was
> complaining that it wasn't enabled. And since the default discard
> option of mkfs.ext3 doesn't seem to work anymore.

Are you sure that it's not just taking very long?

Can you try erasing a smaller region of the device using the program
below? Normally BLKDISCARD is very fast for a device that has been
erased or that is new, but depending on the device it can take a
while to erase actual data.

	Arnd

----
#define _GNU_SOURCE

#include <sys/stat.h>
#include <sys/ioctl.h>
#include <sys/types.h>
#include <stdio.h>
#include <errno.h>
#include <fcntl.h>
#include <linux/fs.h>
#include <stdlib.h>

int main(int argc, char *argv[])
{
        int fd = open(argv[1], O_RDWR | O_DIRECT);
        int ret;
        unsigned long long range[2];

        if (argc != 4) {
                fprintf(stderr, "usage: %s <device> <start> <length>\n",
                        argv[0]);
        }

        if (fd < 0) {
                perror("open");
                return errno;
        }

        range[0] = atoll(argv[2]);
        range[1] = atoll(argv[3]);

        printf("erasing %lld to %lld on %s\n", range[0], range[0] + range[1], argv[1]);

        ret = ioctl(fd, BLKDISCARD, range);
        if (ret)
                perror("ioctl");

        return errno;
}

