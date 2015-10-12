From: Sheetal <sheetal.tigadoli@gmail.com>
Subject: Re: mmc_test.ko usage
Date: Mon, 12 Oct 2015 11:40:45 +0530
Message-ID: <561B4EE5.10006@gmail.com>
References: <CAHhAz+iGUga6o+zatkew8uqBi+aJpHnpetGx393Fc_sC4YQhxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34763 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750705AbbJLGKy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Oct 2015 02:10:54 -0400
Received: by padhy16 with SMTP id hy16so144871568pad.1
        for <linux-mmc@vger.kernel.org>; Sun, 11 Oct 2015 23:10:53 -0700 (PDT)
In-Reply-To: <CAHhAz+iGUga6o+zatkew8uqBi+aJpHnpetGx393Fc_sC4YQhxA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Muni Sekhar <munisekharrms@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>


On Monday 12 October 2015 11:25 AM, Muni Sekhar wrote:
> Hi ,
>
>
> I tried to use the MMC host test driver (mmc_test.ko) for testing SD
> Host controller hardware. When I load the driver I noticed that
> mmc_test_probe() not getting called.
>
> Could anyone specify the exact usage of mmc_test.ko?
>
Hello Muni Sekhar,

I think the following might help you in using MMC_TEST.KO Module

0. insmod mmc_test.ko
1. unbind the mmc block driver
echo mmc0:b368 > /sys/bus/mmc/drivers/mmcblk/unbind
2. bind the mmc_test driver
echo mmc0:b368 > /sys/bus/mmc/drivers/mmc_test/bind
3. mount the debugfs if you don't mount for debugfs
mount -t debugfs none /sys/kernel/debug
4. After mount, you can see the "/sys/kernel/debug/mmc0/mmc0:b368/test"
5. echo "test number" > /sys/kernel/debug/mmc0/mmc0\:b368/test
you can see the "test number" using the "cat /sys/kernel/debug/mmc0/mmc0\:b368/testlist"

The above has been copied straigtly from thelink  <http://forum.kernelnewbies.org/read.php?12,1991,116405#msg-116405>

