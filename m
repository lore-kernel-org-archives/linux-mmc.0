From: Colin Cross <ccross@android.com>
Subject: Re: [PATCH 2/6] mmc_block: Allow more than 8 partitions per card
Date: Tue, 26 Apr 2011 09:10:28 -0700
Message-ID: <BANLkTinEiG5QGaZNp2hnOc8BmNhNc_SiwA@mail.gmail.com>
References: <1303520502-32171-1-git-send-email-john.stultz@linaro.org>
	<1303520502-32171-3-git-send-email-john.stultz@linaro.org>
	<201104261522.22329.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:14086 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756763Ab1DZQKg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Apr 2011 12:10:36 -0400
Received: from wpaz13.hot.corp.google.com (wpaz13.hot.corp.google.com [172.24.198.77])
	by smtp-out.google.com with ESMTP id p3QGAUhA030723
	for <linux-mmc@vger.kernel.org>; Tue, 26 Apr 2011 09:10:32 -0700
Received: from yxd5 (yxd5.prod.google.com [10.190.1.197])
	by wpaz13.hot.corp.google.com with ESMTP id p3QGASmt009188
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Tue, 26 Apr 2011 09:10:29 -0700
Received: by yxd5 with SMTP id 5so174468yxd.35
        for <linux-mmc@vger.kernel.org>; Tue, 26 Apr 2011 09:10:28 -0700 (PDT)
In-Reply-To: <201104261522.22329.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: John Stultz <john.stultz@linaro.org>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Dima Zavin <dima@android.com>

On Tue, Apr 26, 2011 at 6:22 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Saturday 23 April 2011, John Stultz wrote:
>> From: Colin Cross <ccross@android.com>
>>
>> Set the GENHD_FL_EXT_DEVT flag, which will allocate minor numbers
>> in major 259 for partitions past disk->minors.
>>
>> Also remove the use of disk_devt to determine devidx from md->disk.
>> md->disk->first_minor is always initialized from devidx and can
>> always be used to recover it.
>>
>> CC: Chris Ball <cjb@laptop.org>
>> CC: Arnd Bergmann <arnd@arndb.de>
>> CC: Dima Zavin <dima@android.com>
>> Signed-off-by: Colin Cross <ccross@android.com>
>> Signed-off-by: John Stultz <john.stultz@linaro.org>
>
> The new code looks reasonable, but wouldn't changing this be incompatible
> with existing root file systems that contain static device nodes?

I don't think so.  Without this change, /dev/mmcblk0p1 will be (179,
1), /dev/mmcblk0p7 will be (179, 7), and /dev/mmcblk0p8 will be
dropped.  After this change, /dev/mmcblk0p1-7 will be the same, but
/dev/mmcblk0p8 will be (259, <random number>).  A root file system
with static inodes will still have access to partitions 1-7, and will
still not have access to dynamically-assigned partition 8.
