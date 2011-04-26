From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/6] mmc_block: Allow more than 8 partitions per card
Date: Tue, 26 Apr 2011 18:13:55 +0200
Message-ID: <201104261813.55627.arnd@arndb.de>
References: <1303520502-32171-1-git-send-email-john.stultz@linaro.org> <201104261522.22329.arnd@arndb.de> <BANLkTinEiG5QGaZNp2hnOc8BmNhNc_SiwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:60538 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754564Ab1DZQOA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Apr 2011 12:14:00 -0400
In-Reply-To: <BANLkTinEiG5QGaZNp2hnOc8BmNhNc_SiwA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Colin Cross <ccross@android.com>
Cc: John Stultz <john.stultz@linaro.org>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Dima Zavin <dima@android.com>

On Tuesday 26 April 2011, Colin Cross wrote:
> On Tue, Apr 26, 2011 at 6:22 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Saturday 23 April 2011, John Stultz wrote:
> >> From: Colin Cross <ccross@android.com>
> >>
> >> Set the GENHD_FL_EXT_DEVT flag, which will allocate minor numbers
> >> in major 259 for partitions past disk->minors.
> >>
> >> Also remove the use of disk_devt to determine devidx from md->disk.
> >> md->disk->first_minor is always initialized from devidx and can
> >> always be used to recover it.
> >>
> >> CC: Chris Ball <cjb@laptop.org>
> >> CC: Arnd Bergmann <arnd@arndb.de>
> >> CC: Dima Zavin <dima@android.com>
> >> Signed-off-by: Colin Cross <ccross@android.com>
> >> Signed-off-by: John Stultz <john.stultz@linaro.org>
> >
> > The new code looks reasonable, but wouldn't changing this be incompatible
> > with existing root file systems that contain static device nodes?
> 
> I don't think so.  Without this change, /dev/mmcblk0p1 will be (179,
> 1), /dev/mmcblk0p7 will be (179, 7), and /dev/mmcblk0p8 will be
> dropped.  After this change, /dev/mmcblk0p1-7 will be the same, but
> /dev/mmcblk0p8 will be (259, <random number>).  A root file system
> with static inodes will still have access to partitions 1-7, and will
> still not have access to dynamically-assigned partition 8.

Ah, I see.

The patch looks good to me then.

	Arnd
