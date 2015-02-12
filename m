From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [RFC PATCH] mmc: dw_mmc: add status check before clock update
Date: Thu, 12 Feb 2015 17:53:55 +0100
Message-ID: <CABxcv=nXuKpGJdBiO2NwUhkYUi7SyuhO1HeEoSUoAESVmEq4XQ@mail.gmail.com>
References: <1423572711-13787-1-git-send-email-a.hajda@samsung.com>
	<1423578559-27947-1-git-send-email-a.hajda@samsung.com>
	<CAGOxZ52E2ymA4WUrqLS28uPmF=3DGExkoFvw=HezC70xs=8dvA@mail.gmail.com>
	<54DB09EA.30602@samsung.com>
	<54DB13A7.8090101@samsung.com>
	<54DB1B78.1010709@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:37510 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751176AbbBLQx4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Feb 2015 11:53:56 -0500
Received: by mail-wi0-f178.google.com with SMTP id em10so5866243wid.5
        for <linux-mmc@vger.kernel.org>; Thu, 12 Feb 2015 08:53:55 -0800 (PST)
In-Reply-To: <54DB1B78.1010709@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrzej Hajda <a.hajda@samsung.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Alim Akhtar <alim.akhtar@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Seungwon Jeon <tgih.jun@samsung.com>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>

Hello Andrzej,

On Wed, Feb 11, 2015 at 10:06 AM, Andrzej Hajda <a.hajda@samsung.com> wrote:
> On 02/11/2015 09:32 AM, Jaehoon Chung wrote:
>> On 02/11/2015 04:51 PM, Andrzej Hajda wrote:
>>> Hi,
>>>
>>> Thanks for comments.
>>>
>>> On 02/10/2015 03:54 PM, Alim Akhtar wrote:
>>>> Hi Andrzej,
>>>>
>>>> On Tue, Feb 10, 2015 at 7:59 PM, Andrzej Hajda <a.hajda@samsung.com> wrote:
>>>>> According to specs for version 250A, status register should be
>>>>> tested before clock update. Otherwise in case MMC card is missing
>>>>> mci_send_cmd timeouts and subsequent CTYPE registry write causes system hang.
>>>>> This behavior has been observed on Exynos5422/Odroid-XU3.

I've also observed the same behavior (mmc command send timing out and
system hang) on an Exynos5420 Peach Pit Chromebook and an Exynos5800
Peach Pi Chromebok which both have the same dw_mmc 250A IP version.

Unfortunately $subject doesn't seem to be enough since even with that
applied I got:

[    4.264418] mmc_host mmc1: Timeout sending command (cmd 0x202000
arg 0x0 status 0x80202000)
[    4.283988] random: nonblocking pool is initialized
[   28.054406] INFO: rcu_sched detected stalls on CPUs/tasks:
[   28.058412] 0: (5 ticks this GP) idle=65f/140000000000001/0
softirq=215/216 fqs=39
[   28.066129] (detected by 1, t=4765 jiffies, g=-294, c=-295, q=2)
[   28.072202] Task dump for CPU 0:
[   28.075412] kworker/u16:0   R running      0     6      2 0x00000002
[   28.081749] Workqueue: kmmcd mmc_rescan
[   28.085570] [<c04c2698>] (__schedule) from [<00000000>] (  (null))
[   28.091724] rcu_sched kthread starved for 796 jiffies!

>>>>>
>>>>> +static bool dw_mci_wait_busy(struct dw_mci *host)
>>>>> +{
>>>>> +       unsigned long timeout;
>>>>> +
>>>>> +       if (host->verid < DW_MMC_250A)
>>>>> +               return true;
>>>>> +
>>>> I wonder this might be true for 240A as well.
>>> Odroid-U3 board with Exynos4412 and MMC 240A does not have this problem.
>>> On the other side busy check does not hurt it anyway.

This problem also does not happen on an Exynos5250 Snow Chromebook
which has a dw_mmc IP version 241A.

>> Which kernel version do you use?
>> I also have the exynos5422 board, but i didn't find the below error yet.
>> It doesn't relate with IP version.
>> If you share your environment, i can check with exynos5422 board.
>
> linux-next on odroid-xu3. With MMC card removed, booting from sdcard.
> Please also note that broken-cd quirk is on in dts.
>

I tested by trying to add wifi support to the Peach Pit/Pi Chromebooks
which have an SDIO wifi chip attached to mmc@12210000. This [0] is the
patch I've on top of linux-next fwiw.

>>
>> I'm not sure but this patch could be dropped.
>> Because this patch is just only checking whether card is busy or not.
>>
>> this patch(mmc:dw_mmc: fix bug that case 'timeout sending command') can cover your patch.
>
> I will test it.
>

I tested it and although the mentioned patch does fix the mmc commands
send timing out, now card detection seems to not be working since the
kernel keeps waiting for aiting for root device /dev/mmcblk1p4...

and the this error is shown:

[    4.249434] dwmmc_exynos 12210000.mmc: Data busy (status 0x306)

So I tried the other patch from Addy's series "mmc: dw_mmc: Don't
start command while data busy" but it did not have an effect. I still
see the data busy error and the uSD card is not detected.

Best regards,
Javier

[0]: http://paste.debian.net/plain/145877
