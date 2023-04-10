Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A20AEC77B61
	for <linux-mmc@archiver.kernel.org>; Mon, 10 Apr 2023 23:14:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjDJXOr (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 10 Apr 2023 19:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjDJXOb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 10 Apr 2023 19:14:31 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425B430F4
        for <linux-mmc@vger.kernel.org>; Mon, 10 Apr 2023 16:13:52 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id f26so9859427ejb.1
        for <linux-mmc@vger.kernel.org>; Mon, 10 Apr 2023 16:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112; t=1681168422;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vYCRP+KrlDlbA1Ibo/A0cTBAFRfyjiKjYzNUeLYUHNM=;
        b=b86yQvYJywZnlnP3IrOiP8D5lc4U68ihljTY6XuXNu5BEGdmV9H49PEZJu0SII5Zuk
         4Awb0S3s1pWnT55GpB3eRthVZFJ4YSncT2lEcI3bWpnyMvcsYvI6GY2I5TebQgVos/KS
         P5W83VKOPEZwbFl9qUhJ+RYD0eAFLSdFVCsHgFnLTCnWV+oE6dJNHB+4rOHMOcixc7BX
         Mqby4BuC3EKAgy3RixF6tHr7inI0rgnun9ArzY78ocNznoureBLo28s3ZKu9Y+HY0pe9
         7bNt/m6Ppn3YqBzLpE3LFiDH7UQOf3N87+H/PjTiXAj70+0W1oizd57DU/uG+d2EV9PL
         WH8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681168422;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vYCRP+KrlDlbA1Ibo/A0cTBAFRfyjiKjYzNUeLYUHNM=;
        b=4sfpuFl1+wcerjWPxdIQb3wU3cKe7Gj138xlvpBMTmi7sHkBgsn74xGfBdhuIaBKA/
         yqdpY99KX5md6W6J3xBufLghUz5ePvcQlXGGu5HImhsmEJZm2xHFVQbJmflwwr5FV7bI
         S8BbAMGmS+3vOtCIekcBtetxyVwsxKDVxtJvtvjEL4o67aM0qjZIrdzrxGNyCwwznSXE
         ncBbslpWDGSwrMXS7wCkLZxU340OxtSiqXx85YZ8ud0yOewXQXNCdxam62Soy7e/fWUT
         40xn8we25MQRPvP8sGdKoS+9oiuc/dnx4FUnpHRtOLtIW3tUNkjWwS1AmwgNfBwHOrSR
         V1LA==
X-Gm-Message-State: AAQBX9eMl6ETFNd7VBeYGEb50Wn914Yrl0LjRSGdaUZ7KicI/VZSq3d/
        zeZNr7sD47OjU1e+MrLtLrtCGeT/DGKKM00TtfUdD2wN5+o=
X-Google-Smtp-Source: AKy350ZSOn5vAFET2Urc7I8f2l8+gbmJ4gCwaITbvhLfKwc+0P9A260bj1k0r/tHrE5oGSFnAdT0hp3ato9ui9VMDok=
X-Received: by 2002:a17:907:6f07:b0:878:4a24:1a5c with SMTP id
 sy7-20020a1709076f0700b008784a241a5cmr3599198ejc.6.1681168421730; Mon, 10 Apr
 2023 16:13:41 -0700 (PDT)
MIME-Version: 1.0
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 11 Apr 2023 01:13:30 +0200
Message-ID: <CAFBinCD0RT0p-jk86W0JuMT3ufohRh1RqWCcM35DKZJpuc10HQ@mail.gmail.com>
Subject: Odroid-C1 regression with commit 4bc31edebde5 ("mmc: core: Set HS
 clock speed before sending HS CMD13")
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hello Ulf,

today I found that upstream commit 4bc31edebde5 ("mmc: core: Set HS
clock speed before sending HS CMD13") breaks eMMC support on my
Odroid-C1.
(yes, I know that I am very late to the party...)

The .dts for this board is upstream using
arch/arm/boot/dts/meson8b-odroidc1.dts (&sdhc node)
The MMC host driver used is drivers/mmc/host/meson-mx-sdhc*.

The problem I'm seeing is that the eMMC module is simply not detected.
There are no errors in the kernel log (note that mmc1 is the eMMC
while mmc0 is the SD card which is attached to another controller on
that SoC):
# dmesg | grep mmc
[    2.742136] meson-mx-sdhc c1108e00.mmc: allocated mmc-pwrseq
[    4.315905] platform c1108c20.mmc:slot@1: Got CD GPIO
[    4.450921] mmc0: new high speed SDHC card at address 0001
[    4.456985] mmcblk0: mmc0:0001 EB1QT 29.8 GiB
[    4.466108]  mmcblk0: p1

In this state I get:
# cat /sys/kernel/debug/mmc1/ios
clock:          52000000 Hz
actual clock:   51000000 Hz
vdd:            21 (3.3 ~ 3.4 V)
bus mode:       2 (push-pull)
chip select:    0 (don't care)
power mode:     2 (on)
bus width:      3 (8 bits)
timing spec:    9 (mmc HS200)
signal voltage: 1 (1.80 V)
driver type:    0 (driver type B)

After reverting the mentioned commit I get:
# dmesg | grep mmc
[    2.744226] meson-mx-sdhc c1108e00.mmc: allocated mmc-pwrseq
[    2.970944] mmc1: new HS200 MMC card at address 0001
[    2.974492] mmcblk1: mmc1:0001 8GND3R 7.28 GiB
[    2.985126]  mmcblk1: p1
[    2.987810] mmcblk1boot0: mmc1:0001 8GND3R 4.00 MiB
[    3.003007] mmcblk1boot1: mmc1:0001 8GND3R 4.00 MiB
[    4.311754] platform c1108c20.mmc:slot@1: Got CD GPIO
[    4.374732] mmc0: new high speed SDHC card at address 0001
[    4.377228] mmcblk0: mmc0:0001 EB1QT 29.8 GiB
[    4.399152]  mmcblk0: p1
# cat /sys/kernel/debug/mmc1/ios
clock:          100000000 Hz
actual clock:   94444445 Hz
vdd:            21 (3.3 ~ 3.4 V)
bus mode:       2 (push-pull)
chip select:    0 (don't care)
power mode:     2 (on)
bus width:      3 (8 bits)
timing spec:    9 (mmc HS200)
signal voltage: 1 (1.80 V)
driver type:    0 (driver type B)

Please let me know which additional information would be helpful for
debugging this further.
Also I'd like to highlight that I'm not blaming the above commit
(unless I know better). It's entirely possible that the meson-mx-sdhc
driver (which I wrote) can be at fault and that I was previously just
lucky.

My git bisect log is:
$ git bisect log
git bisect start
# status: waiting for both good and bad commits
# good: [f443e374ae131c168a065ea1748feac6b2e76613] Linux 5.17
git bisect good f443e374ae131c168a065ea1748feac6b2e76613
# status: waiting for bad commit, 1 good commit known
# bad: [4b0986a3613c92f4ec1bdc7f60ec66fea135991f] Linux 5.18
git bisect bad 4b0986a3613c92f4ec1bdc7f60ec66fea135991f
# good: [25fd2d41b505d0640bdfe67aa77c549de2d3c18a] selftests:
kselftest framework: provide "finished" helper
git bisect good 25fd2d41b505d0640bdfe67aa77c549de2d3c18a
# good: [02e2af20f4f9f2aa0c84e9a30a35c02f0fbb7daa] Merge tag
'char-misc-5.18-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc
git bisect good 02e2af20f4f9f2aa0c84e9a30a35c02f0fbb7daa
# good: [887f75cfd0da44c19dda93b2ff9e70ca8792cdc1] drm/amdgpu: Ensure
HDA function is suspended before ASIC reset
git bisect good 887f75cfd0da44c19dda93b2ff9e70ca8792cdc1
# good: [cf424ef014ac30b0da27125dd1fbdf10b0d3a520] Merge tag
'for-5.18/fbdev-2' of
git://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev
git bisect good cf424ef014ac30b0da27125dd1fbdf10b0d3a520
# good: [4e707344e18525b4edf5c2bc2e3eb60692e8c92e] MAINTAINERS: add
missing files for bonding definition
git bisect good 4e707344e18525b4edf5c2bc2e3eb60692e8c92e
# bad: [680b892685ea7043addb5819ddec9147d4263195] Merge branch
'100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
git bisect bad 680b892685ea7043addb5819ddec9147d4263195
# bad: [e3de3a1cda5fdc3ac42cb0d45321fb254500595f] Merge tag
'powerpc-5.18-4' of
git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux
git bisect bad e3de3a1cda5fdc3ac42cb0d45321fb254500595f
# bad: [4b97bac0756a81cda5afd45417a99b5bccdcff67] Merge tag
'for-5.18-rc5-tag' of
git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux
git bisect bad 4b97bac0756a81cda5afd45417a99b5bccdcff67
# bad: [64267926e01b06f43e26232722fb3dc3f4819823] Merge tag
'mmc-v5.18-rc4' of
git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc
git bisect bad 64267926e01b06f43e26232722fb3dc3f4819823
# good: [fe27d189e3f42e31d3c8223d5daed7285e334c5e] Merge tag
'folio-5.18f' of git://git.infradead.org/users/willy/pagecache
git bisect good fe27d189e3f42e31d3c8223d5daed7285e334c5e
# good: [ca5e2f4d6b677efa3f43a6790777e46dcf806e4d] Merge tag
'drm-misc-fixes-2022-05-05' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
git bisect good ca5e2f4d6b677efa3f43a6790777e46dcf806e4d
# bad: [3e5a8e8494a8122fe4eb3f167662f406cab753b9] mmc: sdhci-msm:
Reset GCC_SDCC_BCR register for SDHC
git bisect bad 3e5a8e8494a8122fe4eb3f167662f406cab753b9
# bad: [e9f3fb523dbf476dc86beea23f5b5ca8f9687c93] mmc: sunxi-mmc: Fix
DMA descriptors allocated above 32 bits
git bisect bad e9f3fb523dbf476dc86beea23f5b5ca8f9687c93
# bad: [4bc31edebde51fcf8ad0794763b8679a7ecb5ec0] mmc: core: Set HS
clock speed before sending HS CMD13
git bisect bad 4bc31edebde51fcf8ad0794763b8679a7ecb5ec0
# first bad commit: [4bc31edebde51fcf8ad0794763b8679a7ecb5ec0] mmc:
core: Set HS clock speed before sending HS CMD13


Thank you and best regards,
Martin
