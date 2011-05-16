From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: kernel 2.6.38.6 MMC controller problem (fwd)
Date: Mon, 16 May 2011 19:48:08 +0900
Message-ID: <4DD100E8.5020009@samsung.com>
References: <Pine.LNX.4.64.1105160830420.4131@axis700.grange>
 <BANLkTinbJfDLp5nfkq-VTYLJvihT1thXvA@mail.gmail.com>
 <Pine.LNX.4.64.1105161044260.4131@axis700.grange>
 <4DD0FBBB.4090102@samsung.com>
 <Pine.LNX.4.64.1105161238590.4131@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:27842 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753275Ab1EPKsK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 May 2011 06:48:10 -0400
Received: from epcpsbgm1.samsung.com (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LLA00BHNBC7XCM0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 16 May 2011 19:48:09 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LLA00CUMBC8VU@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 16 May 2011 19:48:08 +0900 (KST)
In-reply-to: <Pine.LNX.4.64.1105161238590.4131@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, David Strobach <lalochcz@gmail.com>, linux-mmc@vger.kernel.org, Greg KH <greg@kroah.com>, Chris Ball <cjb@laptop.org>, horms@verge.net.au, damm@opensource.se, Andrei Warkentin <andreiw@motorola.com>, Linus Walleij <linus.walleij@linaro.org>, Kyungmin Park <kyungmin.park@samsung.com>

Guennadi Liakhovetski wrote:
> On Mon, 16 May 2011, Jaehoon Chung wrote:
> 
>> Hi..
>>
>> i found the similar case. So i wonder how i can resolve that..
>> But i didn't find the solution and i didn't know what problem..
> 
> What MMC host driver? Anything in dmesg?

Using sdhci and dw_mmc controller..i will resend the dmesg log.

Thanks,
Jaehoon Chung

> 
> Thanks
> Guennadi
> 
>> i want to know that solution..
>>
>> ->first card inserted (correct card detect)
>> # mmc1: new SDHC card at address e624
>> mmcblk1: mmc1:e624 SU04G 3.69 GiB
>> mmcblk1: p1
>> #
>> # mmc1: card e624 removed
>> -> second card inserted
>> mmc1: error -110 whilst initialising SD card
>> mmc1: Card removed during transfer!
>> mmc1: Resetting controller.
>> -> third card inserted 
>> mmc1: new SDHC card at address e624
>> mmcblk1: mmc1:e624 SU04G 3.69 GiB
>>   mmcblk1: p1
>>
>> Regards,
>> Jaehoon Chung
>>
>> Guennadi Liakhovetski wrote:
>>> "divide error"???... hmmm, maybe one of SDHCI maintainers has to look at 
>>> it?:)
>>>
>>> Thanks
>>> Guennadi
>>>
>>> On Mon, 16 May 2011, David Strobach wrote:
>>>
>>>> It's actually an oops. The backtrace is attached.
>>>>
>>>> David
>>>>
>>>> On Mon, May 16, 2011 at 09:06, Guennadi Liakhovetski
>>>> <g.liakhovetski@gmx.de>wrote:
>>>>
>>>>> (added the ML and previous discussion participants to CC)
>>>>>
>>>>> Looks like my patch was indeed less obviious, than we thought. We need a
>>>>> lock-up backtrace, I guess. David, can you use a sysrq to get a trace?
>>>>> Something like
>>>>>
>>>>> echo w > /proc/sysrq-trigger
>>>>> or even
>>>>> echo t > /proc/sysrq-trigger
>>>>>
>>>>> and provide traces? The one with 't' will be probably huge, so, maybe you
>>>>> could do it with as few tasks running as possible, maybe without a
>>>>> graphical login. Or I would have to test it with my Laptop, to which I'll
>>>>> get access tomorrow.
>>>>>
>>>>> Thanks
>>>>> Guennadi
>>>>> ---
>>>>> Guennadi Liakhovetski, Ph.D.
>>>>> Freelance Open-Source Software Developer
>>>>> http://www.open-technology.de/
>>>>>
>>>>> ---------- Forwarded message ----------
>>>>> Date: Mon, 16 May 2011 01:57:04 +0200
>>>>> From: David Strobach <lalochcz@gmail.com>
>>>>> To: gregkh@suse.de, g.liakhovetski@gmx.de
>>>>> Cc: horms@verge.net.au, damm@opensource.se
>>>>> Subject: kernel 2.6.38.6 MMC controller problem
>>>>>
>>>>> Hello,
>>>>>
>>>>> I found (by bisection), that the commit 3fe962c (
>>>>>
>>>>> http://git.kernel.org/?p=linux/kernel/git/stable/linux-2.6.38.y.git;a=commit;h=3fe962c04818a4634255beb3be9f236d36350543
>>>>> )
>>>>> introduced regression in MMC card detection. The card is either not
>>>>> detected
>>>>> or causes the system to hang. There is related forum thread at
>>>>> https://bbs.archlinux.org/viewtopic.php?id=118751. Relevant part of my own
>>>>> log follows:
>>>>>
>>>>> May 16 00:15:13 localhost kernel: [  134.670685] mmc0: new SD card at
>>>>> address aaaa
>>>>> May 16 00:15:23 localhost kernel: [  144.715115] mmc0: Timeout waiting for
>>>>> hardware interrupt.
>>>>> May 16 00:15:23 localhost kernel: [  144.715119] sdhci: ===========
>>>>> REGISTER
>>>>> DUMP (mmc0)===========
>>>>> May 16 00:15:23 localhost kernel: [  144.715126] sdhci: Sys addr:
>>>>> 0xbae85840
>>>>> | Version:  0x00000400
>>>>> May 16 00:15:23 localhost kernel: [  144.715133] sdhci: Blk size:
>>>>> 0x00007040
>>>>> | Blk cnt:  0x00000001
>>>>> May 16 00:15:23 localhost kernel: [  144.715140] sdhci: Argument:
>>>>> 0x00000200
>>>>> | Trn mode: 0x00000013
>>>>> May 16 00:15:23 localhost kernel: [  144.715146] sdhci: Present:
>>>>>  0x01ff0001
>>>>> | Host ctl: 0x00000003
>>>>> May 16 00:15:23 localhost kernel: [  144.715153] sdhci: Power:
>>>>>  0x0000000f
>>>>> | Blk gap:  0x00000000
>>>>> May 16 00:15:23 localhost kernel: [  144.715159] sdhci: Wake-up:
>>>>>  0x00000000
>>>>> | Clock:    0x00000100
>>>>> May 16 00:15:23 localhost kernel: [  144.715166] sdhci: Timeout:
>>>>>  0x00000009
>>>>> | Int stat: 0x00000000
>>>>> May 16 00:15:23 localhost kernel: [  144.715172] sdhci: Int enab:
>>>>> 0x02ff00cb
>>>>> | Sig enab: 0x02ff00cb
>>>>> May 16 00:15:23 localhost kernel: [  144.715178] sdhci: AC12 err:
>>>>> 0x00000000
>>>>> | Slot int: 0x00000000
>>>>> May 16 00:15:23 localhost kernel: [  144.715185] sdhci: Caps:
>>>>> 0x01e032b2
>>>>> | Caps_1:   0x00000000
>>>>> May 16 00:15:23 localhost kernel: [  144.715192] sdhci: Cmd:
>>>>>  0x0000101a
>>>>> | Max curr: 0x00000040
>>>>> May 16 00:15:23 localhost kernel: [  144.715194] sdhci:
>>>>> ===========================================
>>>>> May 16 00:15:31 localhost kernel: [  152.604505] mmc0: Card removed during
>>>>> transfer!
>>>>> May 16 00:15:31 localhost kernel: [  152.604511] mmc0: Resetting
>>>>> controller.
>>>>> May 16 00:15:31 localhost kernel: [  152.604568] mmcblk0: unable to set
>>>>> block size to 512: -123
>>>>> May 16 00:15:31 localhost kernel: [  152.604687] mmcblk: probe of mmc0:aaaa
>>>>> failed with error -22
>>>>> May 16 00:15:31 localhost kernel: [  152.801534] mmc0: card aaaa removed
>>>>> May 16 00:15:31 localhost kernel: [  152.814827] mmc0: Got command
>>>>> interrupt
>>>>> 0x00030000 even though no command operation was in progress.
>>>>> May 16 00:15:31 localhost kernel: [  152.814835] sdhci: ===========
>>>>> REGISTER
>>>>> DUMP (mmc0)===========
>>>>> May 16 00:15:31 localhost kernel: [  152.814844] sdhci: Sys addr:
>>>>> 0xbae85840
>>>>> | Version:  0x00000400
>>>>> May 16 00:15:31 localhost kernel: [  152.814853] sdhci: Blk size:
>>>>> 0x00007040
>>>>> | Blk cnt:  0x00000001
>>>>> May 16 00:15:31 localhost kernel: [  152.814860] sdhci: Argument:
>>>>> 0x00000200
>>>>> | Trn mode: 0x00000013
>>>>> May 16 00:15:31 localhost kernel: [  152.814867] sdhci: Present:
>>>>>  0x01f00001
>>>>> | Host ctl: 0x00000000
>>>>> May 16 00:15:31 localhost kernel: [  152.814874] sdhci: Power:
>>>>>  0x0000000f
>>>>> | Blk gap:  0x00000000
>>>>> May 16 00:15:31 localhost kernel: [  152.814881] sdhci: Wake-up:
>>>>>  0x00000000
>>>>> | Clock:    0x00004007
>>>>> May 16 00:15:31 localhost kernel: [  152.814888] sdhci: Timeout:
>>>>>  0x00000009
>>>>> | Int stat: 0x00000000
>>>>> May 16 00:15:31 localhost kernel: [  152.814895] sdhci: Int enab:
>>>>> 0x00ff00c3
>>>>> | Sig enab: 0x00ff00c3
>>>>> May 16 00:15:31 localhost kernel: [  152.814902] sdhci: AC12 err:
>>>>> 0x00000000
>>>>> | Slot int: 0x00000000
>>>>> May 16 00:15:31 localhost kernel: [  152.814909] sdhci: Caps:
>>>>> 0x01e032b2
>>>>> | Caps_1:   0x00000000
>>>>> May 16 00:15:31 localhost kernel: [  152.814916] sdhci: Cmd:
>>>>>  0x0000101a
>>>>> | Max curr: 0x00000040
>>>>> May 16 00:15:31 localhost kernel: [  152.814919] sdhci:
>>>>> ===========================================
>>>>>
>>>>>
>>>>> Regards
>>>>> David Strobach
>>>>>
>>> ---
>>> Guennadi Liakhovetski, Ph.D.
>>> Freelance Open-Source Software Developer
>>> http://www.open-technology.de/
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
> 
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
> http://www.open-technology.de/
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

