From: Sheetal <sheetal.tigadoli@gmail.com>
Subject: Re: mmc_test.ko usage
Date: Mon, 12 Oct 2015 12:58:22 +0530
Message-ID: <561B6116.6070206@gmail.com>
References: <CAHhAz+iGUga6o+zatkew8uqBi+aJpHnpetGx393Fc_sC4YQhxA@mail.gmail.com>	<561B4EE5.10006@gmail.com> <CAHhAz+gv2dpozYdZu9aEa4iT8Dv0=+CMN-jjd6vP1tJ-08PeZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33970 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304AbbJLH2c (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Oct 2015 03:28:32 -0400
Received: by padhy16 with SMTP id hy16so146727775pad.1
        for <linux-mmc@vger.kernel.org>; Mon, 12 Oct 2015 00:28:32 -0700 (PDT)
In-Reply-To: <CAHhAz+gv2dpozYdZu9aEa4iT8Dv0=+CMN-jjd6vP1tJ-08PeZQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Muni Sekhar <munisekharrms@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>


On Monday 12 October 2015 12:11 PM, Muni Sekhar wrote:
> On Mon, Oct 12, 2015 at 11:40 AM, Sheetal <sheetal.tigadoli@gmail.com=
> wrote:
>> On Monday 12 October 2015 11:25 AM, Muni Sekhar wrote:
>>> Hi ,
>>>
>>>
>>> I tried to use the MMC host test driver (mmc_test.ko) for testing S=
D
>>> Host controller hardware. When I load the driver I noticed that
>>> mmc_test_probe() not getting called.
>>>
>>> Could anyone specify the exact usage of mmc_test.ko?
>>>
>> Hello Muni Sekhar,
>>
>> I think the following might help you in using MMC_TEST.KO Module
>>
>> 0. insmod mmc_test.ko
>> 1. unbind the mmc block driver
>> echo mmc0:b368 > /sys/bus/mmc/drivers/mmcblk/unbind
>> 2. bind the mmc_test driver
>> echo mmc0:b368 > /sys/bus/mmc/drivers/mmc_test/bind
>> 3. mount the debugfs if you don't mount for debugfs
>> mount -t debugfs none /sys/kernel/debug
>> 4. After mount, you can see the "/sys/kernel/debug/mmc0/mmc0:b368/te=
st"
>> 5. echo "test number" > /sys/kernel/debug/mmc0/mmc0\:b368/test
>> you can see the "test number" using the "cat
>> /sys/kernel/debug/mmc0/mmc0\:b368/testlist"
>>
>> The above has been copied straigtly from thelink
>> <http://forum.kernelnewbies.org/read.php?12,1991,116405#msg-116405>
>>
>
>
> Hello Sheetal,
>
>
>
> Thanks for the quick reply. I followed the steps but nmcblk unbind
> fails =E2=80=9Cbash: echo: write error: No such device=E2=80=9D. Any =
idea about this
> failure?
>
>
>
> # echo mmc0:b368 > /sys/bus/mmc/drivers/mmcblk/unbind
>
> bash: echo: write error: No such device
>
>
>
>
> # ls -al /sys/bus/mmc/drivers/mmcblk
>
> total 0
>
> drwxr-xr-x 2 root root    0 Oct 12 11:49 .
>
> drwxr-xr-x 4 root root    0 Oct 12 11:49 ..
>
> --w------- 1 root root 4096 Oct 12 11:52 bind
>
> --w------- 1 root root 4096 Oct 12 11:49 uevent
>
> --w------- 1 root root 4096 Oct 12 11:52 unbind
>
>
>
> --
> Thanks,
> Sekhar
Hello Muni Sekhar,

You have to find the device node that has been created, In the example=20
it was "mmc0:b368"
and appropriately modify the echo statement and every other statement=20
where it is referenced

Thanks & Regards
