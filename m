Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 055E9C83F12
	for <linux-mmc@archiver.kernel.org>; Tue, 29 Aug 2023 09:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbjH2J7Z (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 29 Aug 2023 05:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232956AbjH2J7Y (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Aug 2023 05:59:24 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D43EE9
        for <linux-mmc@vger.kernel.org>; Tue, 29 Aug 2023 02:59:21 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qavVG-0006fc-3h; Tue, 29 Aug 2023 11:59:18 +0200
Message-ID: <3a6f8d86-b369-bcf7-406b-4f7d0cd5cfa3@leemhuis.info>
Date:   Tue, 29 Aug 2023 11:59:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: Odroid-C1 regression with commit 4bc31edebde5 ("mmc: core: Set HS
 clock speed before sending HS CMD13")
Content-Language: en-US, de-DE
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Luca Weiss <luca@z3ntu.xyz>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        Ziyang Huang <hzyitc@outlook.com>
References: <CAFBinCD0RT0p-jk86W0JuMT3ufohRh1RqWCcM35DKZJpuc10HQ@mail.gmail.com>
 <CAPDyKFqgYnBfm-NespEZF8AJ5Ou4Bya8jLfVEnfyZvfAZ05Q7Q@mail.gmail.com>
 <CAFBinCDjPJHEhN-Jx3DhhhHJ3yi8oEoW7u4-Ld6Rd1+W826ttA@mail.gmail.com>
 <CAPDyKFqKSWJkJwgCO89jgKQ6AB==P9BWkuX6XtKj=ASOH15y9g@mail.gmail.com>
 <CAFBinCDwgYw3v31hP4AtV3+Z1o+esDqMKugRwMMMLqSX0Acjzw@mail.gmail.com>
 <CAPDyKFr+hQo+N31r=3f58taf9sYW0UF0ApCJhwz9vRsyNizcvg@mail.gmail.com>
 <CAFBinCDSv_vdu5887vveotvaOGFrZvaSX4jM+7Q3QvDhTdazzw@mail.gmail.com>
 <CAPDyKFpS-UwiaRPMqSpX0mNPrS5p=yJzu3g0=pGyCkWHSYyqWg@mail.gmail.com>
 <CAFBinCCnB=po9x6tsxCzRM99ZqgV9=5jBxS9LaoJqLPGZYSH6g@mail.gmail.com>
 <CAPDyKFpAGUudAJKAmzMbcM=LrALU6ELpwaD-ijy18o7yrPgOqA@mail.gmail.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
In-Reply-To: <CAPDyKFpAGUudAJKAmzMbcM=LrALU6ELpwaD-ijy18o7yrPgOqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1693303161;bd4bf22f;
X-HE-SMSGID: 1qavVG-0006fc-3h
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
for once, to make this easily accessible to everyone.

I still have this regression (caused by a commit from Brian, applied by
Ulf) on my list of tracked issues. Was there any progress to finally get
this fixed[1]? Doesn't look like it from here, but I might have easily
missed something, that's why I'm asking.

[1] this patch from Ziyang Huang afaics was supposed to help, but it
went nowhere afaics
https://lore.kernel.org/linux-amlogic/TYZPR01MB5556B56D834E02F41C44D81DC95FA@TYZPR01MB5556.apcprd01.prod.exchangelabs.com/

Or does anybody stop caring?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

On 20.06.23 11:53, Ulf Hansson wrote:
> On Mon, 19 Jun 2023 at 21:54, Martin Blumenstingl
> <martin.blumenstingl@googlemail.com> wrote:
>>
>> On Wed, Jun 14, 2023 at 5:49 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> [...]
>>>> Full register dump:
>>>> # cat /sys/kernel/debug/regmap/c1108e00.mmc/registers
>>>> 00: 00000900
>>>> 04: 0000004d
>>>> 08: e7ffe002
>>>> 0c: 02f0003f
>>>> 10: 0003f009
>>>> 14: 03b81c00
>>>> 18: 2c43bcf0
>>>> 1c: e0000150
>>>> 20: 00000000
>>>> 24: 00003067
>>>> 28: 00000000
>>>> 2c: 00000000
>>>> 30: 00000000
>>>> 34: 00fe0cff
>>>> 38: 0000100b
>>>>
>>>> In case you are curious, the driver is: drivers/mmc/host/meson-mx-sdhc-mmc.c
>>>
>>> Thanks for sharing this data!
>>>
>>> I assume the above registers indicate that we have sent the command
>>> and are now waiting for an IRQ for a response/error, but we never
>>> receive one.
>>>
>>> To really figure out what is going on, I think we need to do some
>>> additional low level debugging/testing.
>>>
>>> I was looking at the commit message from e4bf1b0970ef ("mmc: host:
>>> meson-mx-sdhc: new driver for the Amlogic Meson SDHC host"), which
>>> indicates that the clock management is quite limited for this HW. For
>>> example, the 51000000Hz isn't one of the supported frequencies. Could
>>> that be the reason for the problem? Perhaps if we play with changing
>>> the frequency to something that is considered supported - then can we
>>> make this work?
>> You seem to be more familiar with this Amlogic MMC controller than I am ;-)
> 
> Sometimes a well written commit message actually helps. :-)
> 
>> Today I finally had some time for testing and when I started Ziyang
>> Huang provided a patch [0] (admittedly: I think it needs to be
>> improved, but finally we know that it's a MMC controller driver
>> limitation and not an MMC core bug)
>
> Great news!
> 
> I will continue to monitor the thread and defer to apply anything
> until you have given it your blessing, of course.
> 
> Kind regards
> Uffe
