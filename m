From: Fabio Estevam <festevam@gmail.com>
Subject: Re: eMMC and "mkfs.ext3" hangs without "-E nodiscard"
Date: Thu, 9 Oct 2014 17:40:27 -0300
Message-ID: <CAOMZO5B70G+zhwXSQyZarVwbNUCuC0Oq3pC+WJZHCSA-TaP=8g@mail.gmail.com>
References: <CAOpc7mF+9DgEeikB-gjGphPnsC_Ku+9=AtdGUaQEZYK6Jm77vA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:54758 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751030AbaJIUk3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Oct 2014 16:40:29 -0400
Received: by mail-lb0-f175.google.com with SMTP id u10so1888120lbd.6
        for <linux-mmc@vger.kernel.org>; Thu, 09 Oct 2014 13:40:27 -0700 (PDT)
In-Reply-To: <CAOpc7mF+9DgEeikB-gjGphPnsC_Ku+9=AtdGUaQEZYK6Jm77vA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Holger Schurig <holgerschurig@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi Holger,

On Mon, Sep 29, 2014 at 10:46 AM, Holger Schurig
<holgerschurig@gmail.com> wrote:
> Hi all,
>
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

Can you try applying this series to see if it helps?
http://www.spinics.net/lists/linux-mmc/msg23656.html

It has been applied into linux-next already.
