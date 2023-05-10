Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DCFEC7EE22
	for <linux-mmc@archiver.kernel.org>; Wed, 10 May 2023 14:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237096AbjEJOVh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 10 May 2023 10:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237173AbjEJOVg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 10 May 2023 10:21:36 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E29B2D78
        for <linux-mmc@vger.kernel.org>; Wed, 10 May 2023 07:21:35 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-55a10577911so105687627b3.0
        for <linux-mmc@vger.kernel.org>; Wed, 10 May 2023 07:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683728494; x=1686320494;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NTliPO5TtnfG4tcDS3v2xj4WrgjW3xwnTLSRwMwofdY=;
        b=T34mniW+3feeMOkbewnEpUEwwnBkbic4H0E7CqMlTRIfva+nJL93ofRESCdKy21Hc2
         YTeMtx9xc8uYdSASfVbjfiHgqcFv+Ui3zlZfLAuVFdUTWaRUoLwGCI9lepMjOokUwR4E
         YIl6BGTgZpoPRIHa2G6WDXLggEil0f1s7Fzzv4tiOdcL8eofOd3bPy0ajJc8LmxPqr7i
         rSKqV/VkndiX/kR+wKDv9DzzLSnbUWb1Jl0N1/vX8fSE5UumgcGenaLbWQv3LcNvnPvP
         Nb2lhVzYSffJqgbNyLRkXypCFNnxPOyC6tA+qxNKNjJoJ2rSg3sYs1EH9fuQ5vNfL7a9
         3JYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683728494; x=1686320494;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NTliPO5TtnfG4tcDS3v2xj4WrgjW3xwnTLSRwMwofdY=;
        b=Wexcri4PW4sSmNC6aLIAP8M73N9N2aBz0/Rw4CYXKCSGUkGsmKJNFYqUGPhMLVLSSk
         TwbyHMCc55vBz3WpwP7Z62i1HDzqnRSYj7t/Ns2paNDjYmCoshNCXaE3WkcVyf8irCYT
         88mrh3e5pe/P3H4x7yi+OHUWHmbNEtAP2UPJekIJbdSzo9EwGNhqGi6zwCzJZIR9HoT/
         +9TSTXo+OAvcShOEKwAqRfMGk6c9kQEHQnQglhwNTAaw2ijS3YeC4gFbcryLWTSS+hKX
         mx8iEc+f/B2YMU8uOMaIsr8tDqYbfTzLbjhxHynionHIF7FB2b66eX6Lc0ioFwQLhfzM
         bNsQ==
X-Gm-Message-State: AC+VfDznS2sYPxVoiuyCkoLPgePLCnjEdXul1LWlajqN4eQee3Hxa5oi
        2MTl39B8EcvdL/EcwM655d1OSKcQUzC0/0C3+QeBIO4jSrTIcsCUfOA=
X-Google-Smtp-Source: ACHHUZ78rMS5zaFdKBocwZ3zTgdcYwD4FzIErGiEYx6tkSsRK7AV974CXdcd6zFAuhtBKpdu3e3kaiwvVOERFd9RX/Y=
X-Received: by 2002:a25:f56:0:b0:b9a:6d87:f4cf with SMTP id
 83-20020a250f56000000b00b9a6d87f4cfmr18210997ybp.2.1683728494489; Wed, 10 May
 2023 07:21:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAFBinCD0RT0p-jk86W0JuMT3ufohRh1RqWCcM35DKZJpuc10HQ@mail.gmail.com>
In-Reply-To: <CAFBinCD0RT0p-jk86W0JuMT3ufohRh1RqWCcM35DKZJpuc10HQ@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 10 May 2023 16:20:58 +0200
Message-ID: <CAPDyKFqgYnBfm-NespEZF8AJ5Ou4Bya8jLfVEnfyZvfAZ05Q7Q@mail.gmail.com>
Subject: Re: Odroid-C1 regression with commit 4bc31edebde5 ("mmc: core: Set HS
 clock speed before sending HS CMD13")
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Luca Weiss <luca@z3ntu.xyz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

+ Shawn Lin, Luca Weiss

On Tue, 11 Apr 2023 at 01:13, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hello Ulf,

Hi Martin,

Thanks for reporting - and my apologies for the long delay! It's been
a busy period with lots of travelling for me.

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

It looks to me that we are in the process of enabling the HS200 mode,
but hangs at some point. Unless I am mistaken.

More precisely, I suspect it's either the call to mmc_set_clock() or
the call to mmc_switch_status(), in mmc_select_hs200(). Can you have a
closer look to confirm this?

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
> My git bisect log is:
> $ git bisect log
> git bisect start
> # status: waiting for both good and bad commits
> # good: [f443e374ae131c168a065ea1748feac6b2e76613] Linux 5.17
> git bisect good f443e374ae131c168a065ea1748feac6b2e76613
> # status: waiting for bad commit, 1 good commit known
> # bad: [4b0986a3613c92f4ec1bdc7f60ec66fea135991f] Linux 5.18
> git bisect bad 4b0986a3613c92f4ec1bdc7f60ec66fea135991f
> # good: [25fd2d41b505d0640bdfe67aa77c549de2d3c18a] selftests:
> kselftest framework: provide "finished" helper
> git bisect good 25fd2d41b505d0640bdfe67aa77c549de2d3c18a
> # good: [02e2af20f4f9f2aa0c84e9a30a35c02f0fbb7daa] Merge tag
> 'char-misc-5.18-rc1' of
> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc
> git bisect good 02e2af20f4f9f2aa0c84e9a30a35c02f0fbb7daa
> # good: [887f75cfd0da44c19dda93b2ff9e70ca8792cdc1] drm/amdgpu: Ensure
> HDA function is suspended before ASIC reset
> git bisect good 887f75cfd0da44c19dda93b2ff9e70ca8792cdc1
> # good: [cf424ef014ac30b0da27125dd1fbdf10b0d3a520] Merge tag
> 'for-5.18/fbdev-2' of
> git://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev
> git bisect good cf424ef014ac30b0da27125dd1fbdf10b0d3a520
> # good: [4e707344e18525b4edf5c2bc2e3eb60692e8c92e] MAINTAINERS: add
> missing files for bonding definition
> git bisect good 4e707344e18525b4edf5c2bc2e3eb60692e8c92e
> # bad: [680b892685ea7043addb5819ddec9147d4263195] Merge branch
> '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
> git bisect bad 680b892685ea7043addb5819ddec9147d4263195
> # bad: [e3de3a1cda5fdc3ac42cb0d45321fb254500595f] Merge tag
> 'powerpc-5.18-4' of
> git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux
> git bisect bad e3de3a1cda5fdc3ac42cb0d45321fb254500595f
> # bad: [4b97bac0756a81cda5afd45417a99b5bccdcff67] Merge tag
> 'for-5.18-rc5-tag' of
> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux
> git bisect bad 4b97bac0756a81cda5afd45417a99b5bccdcff67
> # bad: [64267926e01b06f43e26232722fb3dc3f4819823] Merge tag
> 'mmc-v5.18-rc4' of
> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc
> git bisect bad 64267926e01b06f43e26232722fb3dc3f4819823
> # good: [fe27d189e3f42e31d3c8223d5daed7285e334c5e] Merge tag
> 'folio-5.18f' of git://git.infradead.org/users/willy/pagecache
> git bisect good fe27d189e3f42e31d3c8223d5daed7285e334c5e
> # good: [ca5e2f4d6b677efa3f43a6790777e46dcf806e4d] Merge tag
> 'drm-misc-fixes-2022-05-05' of
> git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
> git bisect good ca5e2f4d6b677efa3f43a6790777e46dcf806e4d
> # bad: [3e5a8e8494a8122fe4eb3f167662f406cab753b9] mmc: sdhci-msm:
> Reset GCC_SDCC_BCR register for SDHC
> git bisect bad 3e5a8e8494a8122fe4eb3f167662f406cab753b9
> # bad: [e9f3fb523dbf476dc86beea23f5b5ca8f9687c93] mmc: sunxi-mmc: Fix
> DMA descriptors allocated above 32 bits
> git bisect bad e9f3fb523dbf476dc86beea23f5b5ca8f9687c93
> # bad: [4bc31edebde51fcf8ad0794763b8679a7ecb5ec0] mmc: core: Set HS
> clock speed before sending HS CMD13
> git bisect bad 4bc31edebde51fcf8ad0794763b8679a7ecb5ec0
> # first bad commit: [4bc31edebde51fcf8ad0794763b8679a7ecb5ec0] mmc:
> core: Set HS clock speed before sending HS CMD13
>
>
> Thank you and best regards,
> Martin

Kind regards
Uffe
