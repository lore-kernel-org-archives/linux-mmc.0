From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: MMC: commit dba3c29 ruins mmc card data on beagle-xm revB
Date: Wed, 13 Jun 2012 10:56:28 +0530
Message-ID: <CANfBPZ-Sei434hV0edEEGeViwL6TXWsvRnprv7-Kf64dJ6_auQ@mail.gmail.com>
References: <CACVXFVO-Wm1Qwporby1M=+yPz81AWHpZRBZSbr5tgT32b6sSEA@mail.gmail.com>
 <CANrkHUYd8Ww6De4MiZ8_oPfcnhvtsZXOySLRiWSBU4QUQ6beHw@mail.gmail.com> <CACVXFVP16UmHe-GGydrSMgGHwnkSvYhnY339=zr=BfCehvS8Kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACVXFVP16UmHe-GGydrSMgGHwnkSvYhnY339=zr=BfCehvS8Kw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ming Lei <ming.lei@canonical.com>
Cc: "T Krishnamoorthy, Balaji" <balajitk@ti.com>, linux-mmc@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Chris Ball <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, Jun 11, 2012 at 12:50 PM, Ming Lei <ming.lei@canonical.com> wrote:
> On Mon, Jun 11, 2012 at 2:21 PM, T Krishnamoorthy, Balaji
> <balajitk@ti.com> wrote:
>> Hi Ming Lei,
>> Can you let me know if you noticed any write/timeout errors ?
>
> Nothing error logs found during writing.
>
> Below is one of my test case.
>
> root@beagleboard:~# upk
> updateing kernel...
> flush storage...
> root@beagleboard:~# cat bin/upk
> #!/bin/sh
>
> echo "updateing kernel..."
> cp -f /mnt/nfs/t/uImage /media/mmcblk0p1/
>
> echo "flush storage..."
> sync
> root@beagleboard:~# diff /mnt/nfs/t/uImage /media/mmcblk0p1/uImage
> Binary files /mnt/nfs/t/uImage and /media/mmcblk0p1/uImage differ
> root@beagleboard:~# umount /media/mmcblk0p1
> root@beagleboard:~# mount -t vfat /dev/mmcblk0p1 /media/mmcblk0p1
> root@beagleboard:~#
> root@beagleboard:~#
> root@beagleboard:~# diff /mnt/nfs/t/uImage /media/mmcblk0p1/uImage
> Binary files /mnt/nfs/t/uImage and /media/mmcblk0p1/uImage differ
>
Ming,
  Just to keep you posted, Balaji and myself are trying to reproduce
the issue and haven't hit the problem yet.
This patch was in use internaly for sometime before we sent it upstream.
Meanwhile, is is possible for you to reproduce this problem with
MMC_DEBUG enabled ? That would be helpful.
~Venkat.
