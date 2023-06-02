Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84DCEC7EE24
	for <linux-mmc@archiver.kernel.org>; Fri,  2 Jun 2023 13:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235600AbjFBNR3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 2 Jun 2023 09:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235979AbjFBNR2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Jun 2023 09:17:28 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D700499
        for <linux-mmc@vger.kernel.org>; Fri,  2 Jun 2023 06:17:19 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1q54eb-00024q-AR; Fri, 02 Jun 2023 15:17:17 +0200
Message-ID: <5eb7694f-8c45-bab8-4d4c-2852f125f0eb@leemhuis.info>
Date:   Fri, 2 Jun 2023 15:17:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: Odroid-C1 regression with commit 4bc31edebde5 ("mmc: core: Set HS
 clock speed before sending HS CMD13")
Content-Language: en-US, de-DE
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Luca Weiss <luca@z3ntu.xyz>,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <CAFBinCD0RT0p-jk86W0JuMT3ufohRh1RqWCcM35DKZJpuc10HQ@mail.gmail.com>
 <CAPDyKFqgYnBfm-NespEZF8AJ5Ou4Bya8jLfVEnfyZvfAZ05Q7Q@mail.gmail.com>
 <CAFBinCDjPJHEhN-Jx3DhhhHJ3yi8oEoW7u4-Ld6Rd1+W826ttA@mail.gmail.com>
 <CAPDyKFqKSWJkJwgCO89jgKQ6AB==P9BWkuX6XtKj=ASOH15y9g@mail.gmail.com>
 <CAFBinCDwgYw3v31hP4AtV3+Z1o+esDqMKugRwMMMLqSX0Acjzw@mail.gmail.com>
 <CAPDyKFr+hQo+N31r=3f58taf9sYW0UF0ApCJhwz9vRsyNizcvg@mail.gmail.com>
 <CAFBinCDSv_vdu5887vveotvaOGFrZvaSX4jM+7Q3QvDhTdazzw@mail.gmail.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
In-Reply-To: <CAFBinCDSv_vdu5887vveotvaOGFrZvaSX4jM+7Q3QvDhTdazzw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1685711839;bc681d32;
X-HE-SMSGID: 1q54eb-00024q-AR
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
for once, to make this easily accessible to everyone.

Ulf, Martin, what happened to this? It looks like we didn't get any
closer to fixing this regression in the last two weeks. Did it fall
through the cracks? Or was progress made and I just missed it?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

On 16.05.23 22:45, Martin Blumenstingl wrote:
> On Mon, May 15, 2023 at 11:44 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> [...]
>>>> 3) If 2) seems to work above, we need to figure out why
>>>> mmc_switch_status() is hanging. If there is a problem with the eMMC
>>>> card responding in-correctly, the host driver should return with an
>>>> error code, right?
>>> You're right: it's indeed hanging in mmc_switch_status()
>>> I don't get any interrupts (timeout, CRC error, ...) for it.
>>> Do you have any suggestions what to check next?
>>
>> So the mmc_switch_status() is sending a CMD13. Even if the card
>> doesn't reply, I would expect that the meson mmc controller would
>> raise some kind of error condition, probably via a timeout-irq.
>>
>> Did you verify that the driver is actually waiting for an IRQ to
>> happen, which also means waiting for a CMD13 response?
> register 0x24 is ICTL (interrupt control) and 0x28 is ISTAT (interrupt status)
> ISTAT is all zeros and ICTL is 0x3067 which translates so:
> - BIT(0): RESP_OK
> - BIT(1): RESP_TIMEOUT
> - BIT(2): RESP_ERR_CRC
> - BIT(5): DATA_TIMEOUT
> - BIT(6): DATA_ERR_CRC
> - BIT(12): RXFIFO_FULL
> - BIT(13): TXFIFO_EMPTY
> 
> I guess in this case BIT(1) RESP_TIMEOUT is the relevant one.
> 
> register 0x04 is SEND and reads 0x4d which translates to:
> - CMD13
> - MMC_RSP_PRESENT (HAS_RESP, BIT(6))
> - no other flags (STOP, R1B, ...) are set
> 
> Full register dump:
> # cat /sys/kernel/debug/regmap/c1108e00.mmc/registers
> 00: 00000900
> 04: 0000004d
> 08: e7ffe002
> 0c: 02f0003f
> 10: 0003f009
> 14: 03b81c00
> 18: 2c43bcf0
> 1c: e0000150
> 20: 00000000
> 24: 00003067
> 28: 00000000
> 2c: 00000000
> 30: 00000000
> 34: 00fe0cff
> 38: 0000100b
> 
> In case you are curious, the driver is: drivers/mmc/host/meson-mx-sdhc-mmc.c
> 
> 
> Best regards,
> Martin
