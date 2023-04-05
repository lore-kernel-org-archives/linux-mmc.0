Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634DAC7619A
	for <linux-mmc@archiver.kernel.org>; Wed,  5 Apr 2023 06:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236840AbjDEGuh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 5 Apr 2023 02:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236708AbjDEGug (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Apr 2023 02:50:36 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8037840F7
        for <linux-mmc@vger.kernel.org>; Tue,  4 Apr 2023 23:50:35 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id d7so305695lfj.3
        for <linux-mmc@vger.kernel.org>; Tue, 04 Apr 2023 23:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680677434;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t1f4W5nQPbYeNaKqHsc1ito3X+7lccB4+/1nqAy/3Fw=;
        b=ahcX1Mj/Lz8JlGmHoQMhBmG286JRJ+psLEZRIr5cwEc0xQvzs4vdjPksPVR1FBWIpU
         Djn9PqQGlEIUD4t0147DTiPGuqmvveSHhD7dtNfz4ScGz5IIM7zo2H3COfVdGj6WWt8H
         RXwSbyud7Wm9r6D8LHd09HPyPSWSb6iKA+xCpyCivOR1kgcu2rkQ7Z6s/Y182rrRftru
         oEsms1Y2yO+rn0W7dwIXXQq3rMDAGKNgb96RZyhw14vGoW2CHNFnY4ppxyvg37f5es+t
         wIRKv20wAUiQSHBM3VuPp8JIAq7Y8uosXjuIVt4x9uS0EjidzsC+v7A7nsHx1JfSTqdH
         dKcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680677434;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t1f4W5nQPbYeNaKqHsc1ito3X+7lccB4+/1nqAy/3Fw=;
        b=pLgFtPi7yndsyswrxeNLxEFUSXUAj38QfWJEG2NhR2KBKk7zF6waqoHk2AIzI68Jie
         8rTkzpuNJR3zONUwLM938UEZt6XNbHXB8pHueb2Z3fZXOvyBsvPuHlKjDjNUCZ8ExJSB
         XrTsMaBXs5xz3bjy4gLspt/KI9QsR6mh5f+PHow41wT4oTB9xlu+6/x8JIIXp+d84Z8Z
         7c5Ta0rVrvsw9+2x3COtBKvKBRBMGaj5ofmJkQqIqzjG+m2JUMIqNtF1kjx81yyi9q4W
         lqlSJN831uiVT9ml8mqXiqiTHBHXrlmiGbbQBqWmPuHKHm3ZhAdldxl1dbPIMuo7gZHU
         UzHg==
X-Gm-Message-State: AAQBX9fiMLX9LQyBimAR4+ONZr4YfA+yNNb0eNFXqwBsYyF6Z3m0vlW4
        vQq2IxEcXhavtlsq0Ju0dh0eOA==
X-Google-Smtp-Source: AKy350aafRTQRZv1RBmxir0BrkSNZZANJ0/Oi8m+R1lGq57377+Q7VZbW6GtW5JS1sds7/u432YZXA==
X-Received: by 2002:a05:6512:143:b0:4eb:1048:1285 with SMTP id m3-20020a056512014300b004eb10481285mr1241185lfo.47.1680677433734;
        Tue, 04 Apr 2023 23:50:33 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id z19-20020ac25df3000000b004eb274b3a43sm2683086lfq.134.2023.04.04.23.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 23:50:33 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 00/13] Fix busydetect on Ux500 PL180/MMCI
Date:   Wed, 05 Apr 2023 08:50:26 +0200
Message-Id: <20230405-pl180-busydetect-fix-v1-0-28ac19a74e5e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADIaLWQC/x2N0QrCMAxFf2Xk2UC2apn+iviQttEVtI6kijL27
 3Y+Hs493AVMNIvBqVtA5Z0tP0uDftdBnLjcBHNqDAMNjvZ0wPnej4ThZd8kVWLFa/6g90zOU3L
 HkaGlgU0wKJc4bfGDrYpuYlZp+//f+bKuP+AQnhB/AAAA
To:     Stefan Hansson <newbyte@disroot.org>,
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
Linus Walleij (13):
      mmc: mmci: Only call busy_complete if callback defined
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

 drivers/mmc/host/mmci.c             | 165 +++++++++++++++++++++++++++---------
 drivers/mmc/host/mmci.h             |  17 ++++
 drivers/mmc/host/mmci_stm32_sdmmc.c |   6 +-
 3 files changed, 149 insertions(+), 39 deletions(-)
---
base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
change-id: 20230405-pl180-busydetect-fix-66a0360d398a

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

