Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FBF9C7619A
	for <linux-mmc@archiver.kernel.org>; Sat,  8 Apr 2023 22:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjDHWAj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 8 Apr 2023 18:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjDHWAi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 8 Apr 2023 18:00:38 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E315271
        for <linux-mmc@vger.kernel.org>; Sat,  8 Apr 2023 15:00:36 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id z26so2181635lfj.11
        for <linux-mmc@vger.kernel.org>; Sat, 08 Apr 2023 15:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680991234;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tzgCahSKSbY4bggNw1U4wqY72Jurg4mAOzP4dgnCGXs=;
        b=BKYXeYA5ofaFOoIFk95sw2+7g5vcWEQAvgM/A3ZNfWg55ZxxSA09+tV1lQGH3n9yS8
         4l1ZydtHbLODFwSB37aZ5Tdqq+ceeEe75uZuGNRDYfet2fDvwhcsdsgAlFjIuH5lbHJe
         vRhjYGF7x8hakEuvRHZYrSpUQcS8W9+H2p5u2Ryk5wsGQpaLvzu8e7te5taEr+kCcelc
         7tkSlN61bP9wVmEXlP+7/uU3OGGYv05kW6rqkm86AHlNOd+C04dcG6EV2uUpu6c4wY4R
         o22kGChohZpjyKjFhmSHY19kI2S89KcTCUycaXofMV5W89CUTCZIWtmpoqhSe8TqdHu/
         zKWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680991234;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tzgCahSKSbY4bggNw1U4wqY72Jurg4mAOzP4dgnCGXs=;
        b=Wu3OU+PejhJYk7DrsBuPK/F87vQxmHs0CxxilqmJgvIeEpClYgqhciGlbOVe3iTSGG
         lNx4zbT6uQ+V42UAchFT5z1y5yvi6ZhMr6oqVlWdr9nwe7938YOg3sluYmiF1d3f7aRa
         A+JUec7ZUzTFBhTIcV8esx558HPHmwkklJc5oOvLyiysOU5oaiQgfvp9MEbAxkRQWpKK
         3db82vWP9Em4C5M7V2hvl7CyE2wRsMRftj8rdcmMVlOzzaeATpQEtHGWgsg+LwwuKS3V
         wMp6OzBbzwsDjEpDUHvMT6iiOIqiZdp7kRhyhE6NT+0JsrCLqPG6Y66l0Yw4dssfq4Vm
         rIsw==
X-Gm-Message-State: AAQBX9fYtIBbrP2VxwXflyfN5g1AAApRY5GRvVgVzBj80hTJNVGraNol
        M8nzBer1CZYwogRYuMltrPHewg==
X-Google-Smtp-Source: AKy350ZLmdSOsBeO9CCQdCoQAHpO5RkeX64B3yVYDYRhQflkyoDVwJ3inORxmwobngf78D4H7cAIqw==
X-Received: by 2002:a19:700b:0:b0:4eb:4335:e104 with SMTP id h11-20020a19700b000000b004eb4335e104mr1803913lfc.47.1680991234321;
        Sat, 08 Apr 2023 15:00:34 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id v9-20020a056512048900b004e9cad1cd7csm1328904lfq.229.2023.04.08.15.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Apr 2023 15:00:33 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 00/12] Fix busydetect on Ux500 PL180/MMCI
Date:   Sun, 09 Apr 2023 00:00:21 +0200
Message-Id: <20230405-pl180-busydetect-fix-v2-0-eeb10323b546@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPXjMWQC/4WNSw6CMBCGr0K6dkxbHoIr72FYDGWEJtiSaSUSw
 t0tXMDl9z/ybSIQWwrinm2CabHBepdAXzJhRnQDge0TCy11LgtZwjypWkL3CWtPkUyEl/1CVaH
 MK9nnTY0iXTsMBB2jM+NxfmOIxEcxM6X96Xu2iUcbouf11C/qSP+YFgUSdI1GNXgrqKTHZB2yv
 3oeRLvv+w///BHs0gAAAA==
To:     Yann Gautier <yann.gautier@foss.st.com>,
        Stefan Hansson <newbyte@disroot.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     linux-mmc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.0
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This series fixes a pretty serious problem in the MMCI
busy detect handling, discovered only after going up and
down a ladder of refactorings.

The code is written expecting the Ux500 busy detect
to fire two interrupts: one at the start of the busy
signalling and one at the end of the busy signalling.

The root cause of the problem seen on some devices
is that only the first IRQ arrives, and then the device
hangs, waiting perpetually for the next IRQ to arrive.

This is eventually solved by adding a timeout using
a delayed work that fire after 10 ms if the busy detect
has not stopped at this point. (Other delay spans can
be suggested.) This is the last patch in the series.

I included the rewrite of the entire busy detect logic
to use a state machine as this makes it way easier to
debug and will print messages about other error
conditions as well.

The problem affects especially the Skomer
(Samsung GT-I9070) and Kyle (Samsung SGH-I407).

It is fine to just apply this for the -next kernel,
despite it fixes the busy detect that has been broken
for these devices for a while, we can think about
backporting a simpler version of the timeout for
stable kernels if we want.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes in v2:
- Drop pointless patch nr 1
- Unconditionally intialize some state variables
- Use a less fragile method to look for busy status when
  using busy detect, should fix Yann's problem
- Link to v1: https://lore.kernel.org/r/20230405-pl180-busydetect-fix-v1-0-28ac19a74e5e@linaro.org

---
Linus Walleij (12):
      mmc: mmci: Clear busy_status when starting command
      mmc: mmci: Unwind big if() clause
      mmc: mmci: Stash status while waiting for busy
      mmc: mmci: Break out error check in busy detect
      mmc: mmci: Make busy complete state machine explicit
      mmc: mmci: Retry the busy start condition
      mmc: mmci: Use state machine state as exit condition
      mmc: mmci: Use a switch statement machine
      mmc: mmci: Break out a helper function
      mmc: mmci: mmci_card_busy() from state machine
      mmc: mmci: Drop end IRQ from Ux500 busydetect
      mmc: mmci: Add busydetect timeout

 drivers/mmc/host/mmci.c             | 166 ++++++++++++++++++++++++++++--------
 drivers/mmc/host/mmci.h             |  17 ++++
 drivers/mmc/host/mmci_stm32_sdmmc.c |   6 +-
 3 files changed, 151 insertions(+), 38 deletions(-)
---
base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
change-id: 20230405-pl180-busydetect-fix-66a0360d398a

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

