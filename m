From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: Fixup broken suspend and eMMC4.5 power off notify
Date: Thu, 27 Sep 2012 13:45:00 +0200
Message-ID: <CAPDyKFqJRvuTA61m+SyOR4HV8sMdRGmbj46rmeLsVTMN6GSD+g@mail.gmail.com>
References: <1347528053-8521-1-git-send-email-ulf.hansson@stericsson.com>
	<CAGxe1ZFJhc-c8rS0KGdfTvejs27jjpz7T4Z2AVwoB-=7QOMemg@mail.gmail.com>
	<CACRpkdaV_PDaYH+RgM2pa9f9Gp97-D9xbxfDkPUBfXSR+-csAg@mail.gmail.com>
	<201209141504.14658.arnd@arndb.de>
	<003301cd9705$c874a250$595de6f0$@codeaurora.org>
	<CAPDyKFr0guahzweekZrmY3EQ2KyBev9OKbyF88CeOiaH5JtJYg@mail.gmail.com>
	<005801cd9ca3$0c539920$24facb60$@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:54027 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750918Ab2I0LpB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Sep 2012 07:45:01 -0400
Received: by wgbdr13 with SMTP id dr13so1332464wgb.1
        for <linux-mmc@vger.kernel.org>; Thu, 27 Sep 2012 04:45:00 -0700 (PDT)
In-Reply-To: <005801cd9ca3$0c539920$24facb60$@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tanya Brokhman <tlinder@codeaurora.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, Girish K S <girish.shivananjappa@linaro.org>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Per Forlin <per.forlin@stericsson.com>, Johan Rudholm <johan.rudholm@stericsson.com>, Lee Jones <lee.jones@linaro.org>, Saugata Das <saugata.das@linaro.org>, Asutosh Das <asutoshd@codeaurora.org>

Hi Tanya,

Thanks a lot for helping out!!!

Testing suspend to ram, and then resuming back again is the key use
case to test.

Kind regards
Ulf Hansson

On 27 September 2012 13:27, Tanya Brokhman <tlinder@codeaurora.org> wrote:
> Hi Ulf
>
> We've tested your change. It seems to be working fine. We mainly focused on
> testing stability and that the performance wasn't decreased. All tests
> passed.
> As far as performance improvement: it wasn't affected because of BKOPs
> feature.
> Please let me know if there is any specific test scenario you want me to
> run.
>
> (Sorry it took me some time to get back to you. It's holiday season in
> Israel)
>
> Thanks,
> Tanya Brokhman
> ---
> QUALCOMM ISRAEL, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
>
>
>> -----Original Message-----
>> From: Ulf Hansson [mailto:ulf.hansson@linaro.org]
>> Sent: Thursday, September 20, 2012 6:40 PM
>> To: Tanya Brokhman
>> Cc: Arnd Bergmann; Linus Walleij; Girish K S; linux-mmc@vger.kernel.org;
>> Chris Ball; Per Forlin; Johan Rudholm; Lee Jones; Saugata Das; Asutosh Das
>> Subject: Re: [PATCH] mmc: Fixup broken suspend and eMMC4.5 power off
>> notify
>>
>> Hi Tanya,
>>
>> On 20 September 2012 09:58, Tanya Brokhman <tlinder@codeaurora.org>
>> wrote:
>> >> >
>> >> > Let's page Arnd, I was under the impression that he has a eMMC 4.5
>> >> > board so maybe he can test it?
>> >>
>> >> I have a few eMMC samples but am only using them with my (slow)
>> >> thinkpad SD card reader. I also don't know which eMMC-4.5 features
>> >> they implement, as some may be early prototypes.
>> >>
>> >> What exactly do you need tested?
>> >>
>> >>       Arnd
>> >> --
>> >
>> > Hi
>> >
>> > We have eMMC4.5 board and can help with the testing.
>> > Are there other patches besides this one I should take in?
>> >
>>
>> Nope, this is the only one needed.
>> Thanks a lot for helping out!
>>
>> Kind regards
>> Ulf Hansson
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
