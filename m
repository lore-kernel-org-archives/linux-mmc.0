From: Girish K S <girish.shivananjappa@linaro.org>
Subject: Re: [PATCH] mmc: Fixup broken suspend and eMMC4.5 power off notify
Date: Sun, 30 Sep 2012 16:09:44 +0900
Message-ID: <CAGxe1ZHiX6rVyxw7Nb3Vvg42Eu1NMEvRo-O69cfaf5U861zd1A@mail.gmail.com>
References: <1347528053-8521-1-git-send-email-ulf.hansson@stericsson.com>
	<CAGxe1ZFJhc-c8rS0KGdfTvejs27jjpz7T4Z2AVwoB-=7QOMemg@mail.gmail.com>
	<CACRpkdaV_PDaYH+RgM2pa9f9Gp97-D9xbxfDkPUBfXSR+-csAg@mail.gmail.com>
	<201209141504.14658.arnd@arndb.de>
	<003301cd9705$c874a250$595de6f0$@codeaurora.org>
	<CAPDyKFr0guahzweekZrmY3EQ2KyBev9OKbyF88CeOiaH5JtJYg@mail.gmail.com>
	<005801cd9ca3$0c539920$24facb60$@codeaurora.org>
	<CAPDyKFqJRvuTA61m+SyOR4HV8sMdRGmbj46rmeLsVTMN6GSD+g@mail.gmail.com>
	<005901cd9ed7$aca95c30$05fc1490$@codeaurora.org>
	<CAGxe1ZFr31DarVf_QaM4qoPnhfthDHFTD28YuySdTnj3p1kwfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:35114 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751955Ab2I3HJp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 30 Sep 2012 03:09:45 -0400
Received: by vbbff1 with SMTP id ff1so4438355vbb.19
        for <linux-mmc@vger.kernel.org>; Sun, 30 Sep 2012 00:09:45 -0700 (PDT)
In-Reply-To: <CAGxe1ZFr31DarVf_QaM4qoPnhfthDHFTD28YuySdTnj3p1kwfQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tanya Brokhman <tlinder@codeaurora.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Per Forlin <per.forlin@stericsson.com>, Johan Rudholm <johan.rudholm@stericsson.com>, Lee Jones <lee.jones@linaro.org>, Saugata Das <saugata.das@linaro.org>, Asutosh Das <asutoshd@codeaurora.org>

On 30 September 2012 16:07, Girish K S <girish.shivananjappa@linaro.org> wrote:
> On 30 September 2012 15:48, Tanya Brokhman <tlinder@codeaurora.org> wrote:
>> Hi Ulf,
>>
>>>
>>> Hi Tanya,
>>>
>>> Thanks a lot for helping out!!!
>>
>> NP.
>>>
>>> Testing suspend to ram, and then resuming back again is the key use case
>> to
>>> test.
>>
>>
>> Is there a special scenario to trigger suspend or just leaving the system
>> idle? I did that. Added prints in the code to verify that the PON was sent
>> to the card.... It feels a bit superficial to me that's why I'm asking if
>> there is a specific scenario I can try.
>> Other than that, as I already mentioned we ran our test suit that includes
>> various user-use cases such as playing a game, reading a web page, email
>> etc. And of course I tried lmdd both ways.
> from command prompt you can suspend by forcing the string mem to state
> variable as given below
>  echo mem > sys/power/state
> If sysfs is not mounted mount it(mount -t sysfs sys /sys) before
> running the above command.
>
> If your board is configured for an external interrupt as a wakeup
> source (on my board it is the keypad)
> press the key for resume.
>
> If no External interrupt wakeup source is availabe, and if the SOc has
> a RTC, it can be used for resume purpose as below
>
> echo 0 > /sys/class/rtc/rtcN/wakealarm  (reset old value)
> echo 10 > /sys/class/rtc/rtcN/wakealarm (set new value)
>
> After  the specified above seconds the system will resume
If you are using rtc as wakeup source.

first configure rtc and then run echo mem > sys/power/state
>
>>
>>>
>>> Kind regards
>>> Ulf Hansson
>>>
>>
>>
>> Thanks,
>> Tanya Brokhman
>> ---
>> QUALCOMM ISRAEL, on behalf of Qualcomm Innovation Center, Inc. is a member
>> of Code Aurora Forum, hosted by The Linux Foundation
>>
>>
