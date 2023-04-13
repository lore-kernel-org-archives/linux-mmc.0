Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6C8C77B6E
	for <linux-mmc@archiver.kernel.org>; Thu, 13 Apr 2023 14:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbjDMOBF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 13 Apr 2023 10:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjDMOBE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Apr 2023 10:01:04 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0986B8A6C
        for <linux-mmc@vger.kernel.org>; Thu, 13 Apr 2023 07:00:59 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pmxVR-0000jX-MA; Thu, 13 Apr 2023 16:00:57 +0200
Message-ID: <2e4521c5-b291-e228-c926-525e9a50a023@leemhuis.info>
Date:   Thu, 13 Apr 2023 16:00:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: Odroid-C1 regression with commit 4bc31edebde5 ("mmc: core: Set HS
 clock speed before sending HS CMD13")
Content-Language: en-US, de-DE
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <CAFBinCD0RT0p-jk86W0JuMT3ufohRh1RqWCcM35DKZJpuc10HQ@mail.gmail.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <CAFBinCD0RT0p-jk86W0JuMT3ufohRh1RqWCcM35DKZJpuc10HQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1681394460;c538e318;
X-HE-SMSGID: 1pmxVR-0000jX-MA
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

[CCing the regression list, as it should be in the loop for regressions:
https://docs.kernel.org/admin-guide/reporting-regressions.html]

On 11.04.23 01:13, Martin Blumenstingl wrote:
> 
> today I found that upstream commit 4bc31edebde5 ("mmc: core: Set HS
> clock speed before sending HS CMD13") breaks eMMC support on my
> Odroid-C1.
> (yes, I know that I am very late to the party...)
> 
> The .dts for this board is upstream using
> arch/arm/boot/dts/meson8b-odroidc1.dts (&sdhc node)
> The MMC host driver used is drivers/mmc/host/meson-mx-sdhc*.
> 
> The problem I'm seeing is that the eMMC module is simply not detected.
> There are no errors in the kernel log (note that mmc1 is the eMMC
> while mmc0 is the SD card which is attached to another controller on
> that SoC):
> # dmesg | grep mmc
> [    2.742136] meson-mx-sdhc c1108e00.mmc: allocated mmc-pwrseq
> [    4.315905] platform c1108c20.mmc:slot@1: Got CD GPIO
> [    4.450921] mmc0: new high speed SDHC card at address 0001
> [    4.456985] mmcblk0: mmc0:0001 EB1QT 29.8 GiB
> [    4.466108]  mmcblk0: p1
> 
> In this state I get:
> # cat /sys/kernel/debug/mmc1/ios
> clock:          52000000 Hz
> actual clock:   51000000 Hz
> vdd:            21 (3.3 ~ 3.4 V)
> bus mode:       2 (push-pull)
> chip select:    0 (don't care)
> power mode:     2 (on)
> bus width:      3 (8 bits)
> timing spec:    9 (mmc HS200)
> signal voltage: 1 (1.80 V)
> driver type:    0 (driver type B)
> 
> After reverting the mentioned commit I get:
> # dmesg | grep mmc
> [    2.744226] meson-mx-sdhc c1108e00.mmc: allocated mmc-pwrseq
> [    2.970944] mmc1: new HS200 MMC card at address 0001
> [    2.974492] mmcblk1: mmc1:0001 8GND3R 7.28 GiB
> [    2.985126]  mmcblk1: p1
> [    2.987810] mmcblk1boot0: mmc1:0001 8GND3R 4.00 MiB
> [    3.003007] mmcblk1boot1: mmc1:0001 8GND3R 4.00 MiB
> [    4.311754] platform c1108c20.mmc:slot@1: Got CD GPIO
> [    4.374732] mmc0: new high speed SDHC card at address 0001
> [    4.377228] mmcblk0: mmc0:0001 EB1QT 29.8 GiB
> [    4.399152]  mmcblk0: p1
> # cat /sys/kernel/debug/mmc1/ios
> clock:          100000000 Hz
> actual clock:   94444445 Hz
> vdd:            21 (3.3 ~ 3.4 V)
> bus mode:       2 (push-pull)
> chip select:    0 (don't care)
> power mode:     2 (on)
> bus width:      3 (8 bits)
> timing spec:    9 (mmc HS200)
> signal voltage: 1 (1.80 V)
> driver type:    0 (driver type B)
> 
> Please let me know which additional information would be helpful for
> debugging this further.
> Also I'd like to highlight that I'm not blaming the above commit
> (unless I know better). It's entirely possible that the meson-mx-sdhc
> driver (which I wrote) can be at fault and that I was previously just
> lucky.
> 
> [...]
> # first bad commit: [4bc31edebde51fcf8ad0794763b8679a7ecb5ec0] mmc:
> core: Set HS clock speed before sending HS CMD13

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced 4bc31edebde51fcf8ad079
#regzbot title mmc: core: eMMC support broken on Odroid-C1
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply and tell me -- ideally
while also telling regzbot about it, as explained by the page listed in
the footer of this mail.

Developers: When fixing the issue, remember to add 'Link:' tags pointing
to the report (the parent of this mail). See page linked in footer for
details.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
