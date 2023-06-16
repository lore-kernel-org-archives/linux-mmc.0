Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21059EB64D7
	for <linux-mmc@archiver.kernel.org>; Fri, 16 Jun 2023 20:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232819AbjFPUmf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 16 Jun 2023 16:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232049AbjFPUme (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Jun 2023 16:42:34 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C2030EF
        for <linux-mmc@vger.kernel.org>; Fri, 16 Jun 2023 13:42:32 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f6195d2b3fso1575818e87.1
        for <linux-mmc@vger.kernel.org>; Fri, 16 Jun 2023 13:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686948151; x=1689540151;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hS88yxL1jQn6LRcaw6w9+K1Tf1vCsxsCr5Hj6kcYNf4=;
        b=b/a17tO+VmgztEsGQHFwhbVp3ilvTKYDQQajvLzs/f7aWr3zC8m1+rNZBRJIFBFX+7
         sFVS1AmwNYAH90OYd+3R3BcLvyR6B2JXfkWkcutAhUa4O3PBBI1vgxGTqddUpFcgj2bO
         i6NCeAAlRgbT6hzmMpOWnIrRDmUl0QRptDw3QJNTmhuf1eS2NF9cgMWJZ5VURHD6awBv
         j5NnlP30LBcXcoT2yaaVZgBCxixNs1iuB2S3rwsj2PDbaFDPEoX1KNNUNK5RFibF/g89
         XwLN5Py1ezojbDO8J8/qZDRH3h/uWCyoPisX6qqbypBSzs+40gSwxA3hRQAQ6GZ+tyHN
         2RvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686948151; x=1689540151;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hS88yxL1jQn6LRcaw6w9+K1Tf1vCsxsCr5Hj6kcYNf4=;
        b=GiuvJuxTPcBCT9r+sU1TY9B+uzJCbinAWHWrehVQcljB8s0kOXtqLILU7pfMlVktHb
         nqBcRwcNa8YnfbkQ4KcxvtJnVvisVnvnuVJVyvKsoKTYNNiyHwjveWfu7P5b9hrF6B+X
         RYuZUTp082OqdzXXxqb/fPj7TNHDFOxL8inbgqMiYM2N55xkDBhVnrLuSMC4MIeTtw71
         pGfOrHv7T4VA9yWfdcZq/C5yoopiU9iRWujLXfwlVo3olITvHfYtLQWJn275gSU1RXQg
         ySMNhyv6M7Ulqq2G0nXJ8h5kQaMtay2lE+Ojxa7+8heS+qT6ErBmYMt39WeNkDSj1uqb
         G9Ew==
X-Gm-Message-State: AC+VfDwfTkSKxnkoOnPZDt+wJpWdkCAOuwfHlb8uZHnoeHowAqKivVJr
        0mIj4W7GnWRaZAidBfEqRrAzZg==
X-Google-Smtp-Source: ACHHUZ6rYMIS5SU/r9BR9vF/bZXQ4x2QmetrGWdb6dQzC0zNicg6Izqv69BdbS7tZ1sjLfPryE+Y6A==
X-Received: by 2002:a19:8c5a:0:b0:4f6:1969:e4a7 with SMTP id i26-20020a198c5a000000b004f61969e4a7mr2516777lfj.24.1686948150726;
        Fri, 16 Jun 2023 13:42:30 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id d22-20020ac244d6000000b004f845907454sm770981lfm.232.2023.06.16.13.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 13:42:30 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v7 0/9] Fix busydetect on Ux500 PL180/MMCI
Date:   Fri, 16 Jun 2023 22:42:18 +0200
Message-Id: <20230405-pl180-busydetect-fix-v7-0-69a7164f2a61@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACrJjGQC/43NTW7DIBAF4KtErEs1MEBwV71H1cUA4xgptSNwr
 UaR716cXeVFvXzz872HqFwyV/F2eojCS655Gls4v5xEHGi8sMypZaFBIxiw8nZVHmT4rvfEM8d
 Z9vlHOkeADhJ2nkR7DVRZhkJjHLbnL6ozl21xK9zun30fny0Puc5TuT/rF7VN/2lalASpPUXV0
 dmw5fdrHqlMr1O5iE1c9BFFN4U5KECNwRq3U/CIgk2JCZPttCV2ZqeYI4ppSuq76KMFgxZ3iju
 iuKYEb4GjB9X1f5V1XX8BVbp9f+oBAAA=
To:     Stefan Hansson <newbyte@disroot.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.2
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This series start to fix a pretty serious problem in the MMCI
busy detect handling, discovered only after going up and
down a ladder of refactorings.

The code is written expecting the Ux500 busy detect
to fire two interrupts: one at the start of the busy
signalling and one at the end of the busy signalling.

DAT0 busy          +-----------------+
                   |                 |
DAT0 not busy  ----+                 +--------

                   ^                 ^
                   |                 |
                  IRQ1              IRQ2

The root cause of the problem seen on some devices
is that only the first IRQ arrives, and then the device
hangs, waiting perpetually for the next IRQ to arrive.

Sometimes neither IRQ arrives! This could be because
the card is so fast that the MCLK does not have time
to latch out the IRQ signal to the bus before it is
gone.

I included the rewrite of the entire busy detect logic
to use a state machine as this makes it way easier to
debug and will print messages about other error
conditions as well.

The problem affects especially the Skomer
(Samsung GT-I9070) and Kyle (Samsung SGH-I407).

This series does not finally solve the problem, but
prepares the ground by making it possible to solve.
I see no regressions on the HREF boards or the
known-good Golden device, but enabling the debug
prints reveals why we have problems on the Skomer:

U8500 HREFv60 TVK:

[    2.343785] mmci-pl18x 80114000.mmc: mmc3: PL180 manf 80 rev4 at 0x80114000 irq 83,0 (pio)
[    2.352789] mmci-pl18x 80114000.mmc: DMA channels RX dma0chan8, TX dma0chan9
[    2.609727] mmc3: new high speed MMC card at address 0001
[    2.610762] mmcblk3: mmc3:0001 008G03 7.38 GiB
[    2.612989]  mmcblk3: p1
[    2.613824] mmcblk3boot0: mmc3:0001 008G03 2.00 MiB
[    2.615367] mmcblk3boot1: mmc3:0001 008G03 2.00 MiB
[    2.616721] mmcblk3rpmb: mmc3:0001 008G03 128 KiB, chardev (246:1)

Then I can mount partitions etc.

U8500 HREF520P TVK:

[    3.064950] mmci-pl18x 80114000.mmc: mmc3: PL180 manf 80 rev4 at 0x80114000 irq 88,0 (pio)
[    3.075458] mmci-pl18x 80114000.mmc: DMA channels RX dma0chan10, TX dma0chan11
[    3.558157] mmc3: new high speed MMC card at address 0001
[    3.573992] mmcblk3: mmc3:0001 SEM16G 14.8 GiB
[    3.595782] mmcblk3boot0: mmc3:0001 SEM16G 2.00 MiB
[    3.610788] mmcblk3boot1: mmc3:0001 SEM16G 2.00 MiB
[    3.633313] mmcblk3rpmb: mmc3:0001 SEM16G 128 KiB, chardev (246:0)

Golden:

[    2.993989] mmci-pl18x 80005000.mmc: mmc2: PL180 manf 80 rev4 at 0x80005000 irq 82,0 (pio)
[    3.003348] mmci-pl18x 80005000.mmc: DMA channels RX dma0chan4, TX dma0chan5
[    3.134052] mmci-pl18x 80005000.mmc: no busy signalling in time
[    3.142300] mmc2: new DDR MMC card at address 0001
[    3.148051] mmcblk2: mmc2:0001 SEM08G 7.28 GiB
[    3.155668] mmc1: new high speed SDIO card at address 0001
[    3.167170]  mmcblk2: p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12 p13 p14 p15 p16 p17 p18 p19 p20 p21 p22 p23 p24 p25
[    3.232390] mmcblk2boot0: mmc2:0001 SEM08G 2.00 MiB
[    3.242865] mmcblk2boot1: mmc2:0001 SEM08G 2.00 MiB
[    3.249808] mmcblk2rpmb: mmc2:0001 SEM08G 128 KiB, chardev (246:0)

Notice an initial error message, then it stabilizes.

Then I can mount partitions etc.

Skomer:

[    2.659027] mmci-pl18x 80005000.mmc: mmc2: PL180 manf 80 rev4 at 0x80005000 irq 81,0 (pio)
[    2.670135] mmci-pl18x 80005000.mmc: DMA channels RX dma0chan4, TX dma0chan5
[    3.380554] mmci-pl18x 80005000.mmc: no busy signalling in time
[    3.387420] mmci-pl18x 80005000.mmc: no busy signalling in time
[    3.394561] mmci-pl18x 80005000.mmc: lost busy status when waiting for busy start IRQ
[    3.402893] mmci-pl18x 80005000.mmc: no busy signalling in time
[    3.409088] mmc2: new DDR MMC card at address 0001
[    3.433166] mmcblk2: mmc2:0001 M4G1YC 3.69 GiB
[    3.466766]  mmcblk2: p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12 p13 p14 p15 p16 p17 p18 p19 p20 p21 p22 p23 p24 p25
[    3.485076] mmcblk2boot0: mmc2:0001 M4G1YC 2.00 MiB
[    3.503265] mmcblk2boot1: mmc2:0001 M4G1YC 2.00 MiB
[    3.524993] mmcblk2rpmb: mmc2:0001 M4G1YC 128 KiB, chardev (246:0)
[    4.470245] mmci-pl18x 80005000.mmc: no busy signalling in time
[    4.489227] mmci-pl18x 80005000.mmc: no busy signalling in time
[    5.457244] mmci-pl18x 80005000.mmc: no busy signalling in time
[    5.469512] mmci-pl18x 80005000.mmc: lost busy status when waiting for busy start IRQ
[    7.133880] mmci-pl18x 80005000.mmc: no busy signalling in time
[    7.154541] mmci-pl18x 80005000.mmc: no busy signalling in time
[    7.189270] mmci-pl18x 80005000.mmc: no busy signalling in time
[    7.542175] mmci-pl18x 80005000.mmc: no busy signalling in time
[    7.552886] mmci-pl18x 80005000.mmc: no busy signalling in time
[    8.277618] mmci-pl18x 80005000.mmc: timeout waiting for busy IRQ

This is why the Skomer isn't working.

Next up will be a patch or patches fixing the issue.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes in v7:
- Do not stop waiting for interrupts if busy detect is still
  asserted when waiting for the second IRQ. Just keep waiting.
- Drop the STM32 changes.
- Link to v6: https://lore.kernel.org/r/20230405-pl180-busydetect-fix-v6-0-b850ec8019f3@linaro.org

Changes in v6:
- Fix up the busy end IRQ in the state machine rewrite: we
  need to check if busy is de-asserted, not asserted!
- Change the timeout handling such that we cancel the timeout
  also on error paths.
- Link to v5: https://lore.kernel.org/linux-mmc/20230614194312.1158498-1-linus.walleij@linaro.org/

Changes in v5:
- Single patch revision to just add the timeout. This
  didn't work out.
- Link to v4: https://lore.kernel.org/r/20230405-pl180-busydetect-fix-v4-0-df9c8c504353@linaro.org

Changes in v4:
- Fix an unrelated change in patch 1
- Move MMCI_BUSY_DONE initialization outside the if()-clause
  for busy detection.
- Use the per-command ->busy_timeout as calculated by the
  core.
- Link to v3: https://lore.kernel.org/r/20230405-pl180-busydetect-fix-v3-0-cd3d5925ae64@linaro.org

Changes in v3:
- Unconditionally assign busy_status = 0
- Rewrite state machine states to just three
- Drop a patch that gets absorbed into another patch
- Drop patch to get busy state from the state machine, it was
  fishy, based on a misunderstanding and not needed
- Link to v2: https://lore.kernel.org/r/20230405-pl180-busydetect-fix-v2-0-eeb10323b546@linaro.org

Changes in v2:
- Drop pointless patch nr 1
- Unconditionally intialize some state variables
- Use a less fragile method to look for busy status when
  using busy detect, should fix Yann's problem
- Link to v1: https://lore.kernel.org/r/20230405-pl180-busydetect-fix-v1-0-28ac19a74e5e@linaro.org

---
Linus Walleij (9):
      mmc: mmci: Clear busy_status when starting command
      mmc: mmci: Unwind big if() clause
      mmc: mmci: Stash status while waiting for busy
      mmc: mmci: Break out error check in busy detect
      mmc: mmci: Make busy complete state machine explicit
      mmc: mmci: Retry the busy start condition
      mmc: mmci: Use state machine state as exit condition
      mmc: mmci: Use a switch statement machine
      mmc: mmci: Break out a helper function

 drivers/mmc/host/mmci.c | 122 +++++++++++++++++++++++++++++++++++++-----------
 drivers/mmc/host/mmci.h |  14 ++++++
 2 files changed, 108 insertions(+), 28 deletions(-)
---
base-commit: 3dff3b32d4752f4a0655fad3c8669978c291ae59
change-id: 20230405-pl180-busydetect-fix-66a0360d398a

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

