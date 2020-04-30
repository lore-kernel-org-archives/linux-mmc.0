Return-Path: <SRS0=CLt1=6O=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE47C83001
	for <linux-mmc@archiver.kernel.org>; Thu, 30 Apr 2020 06:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 989292173E
	for <linux-mmc@archiver.kernel.org>; Thu, 30 Apr 2020 06:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l+AJg1G4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgD3G5r (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 30 Apr 2020 02:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726337AbgD3G5q (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Apr 2020 02:57:46 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68318C035494
        for <linux-mmc@vger.kernel.org>; Wed, 29 Apr 2020 23:57:46 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id j3so5255101ljg.8
        for <linux-mmc@vger.kernel.org>; Wed, 29 Apr 2020 23:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6F+XndsIru6duR0CCwlaQ2qNG4XUe6rojDGrs09hMvY=;
        b=l+AJg1G4eg8RVQ0OCKtowUmC2BD9hVyGr0Ni76WpLrv3E7LCD7I6ykogl0HvbX7a/x
         b2zUy+xTgOhx/HikhevbV90OoEjhnmU8zKZqxe02y9VqkI9AQqpOHYOwm6rDCFMS6SeK
         yC7CAusyyxm2XVbAmbI6qYRplSc/PmaSm9gMEyyO0WxZvOpqjgQG1y34H2jeugd8UJL3
         XCMJ2xbKhcUGx1yZYSiOHlv3MFlStYIJYE4uKsP9grfQmnGgPW1Ys7UCtT/XaCrt4AZo
         1rCyNmLfoowCIvBONCjqM0xo+8C5Mb1DPmalBYNpA1fAagJc94NDFmzyo25PVMVQlsGo
         c5RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6F+XndsIru6duR0CCwlaQ2qNG4XUe6rojDGrs09hMvY=;
        b=ZzgYZ2u5tv+MyYU4bH6s13bvygYpT2LSj7REOJ5MVx8FiNcu/7wHdFMEkJXMa2T78s
         i349Gm7LetHuBx3YcN2cFGD1WDrc5fjHN5CKTTPXHG61nJMVfXawDV+1Ns2AcIoNkL4R
         zK9fjCXk8hlI/B4n6+N/RYuWI8UKQS9ZZQy0Y4z823/FdW9PhRV6h/5JW4g4EyT3pJX2
         yA2y+gzCr/496WtqROuXbCulvGGyHY/RcsVTrJ60KW53jopfVe2qq5kWfcrQ4rtueIhd
         QnACnYBoqqgxM4sqGiZYQGA7L7mmausrgf1XfmofkAmyERdl/9ek/9OPfIXzAyi0Vl9O
         iGpg==
X-Gm-Message-State: AGi0PuYpDagQEO+VKdihGv1uGpRW6dMi+7hURkftYT4iDyIK4TrUKUOY
        22I9DY+i76wCUIerLlgY2A8ULw==
X-Google-Smtp-Source: APiQypIeFer/HL1t7w5DYHAubotVYeGojlmu3tPBDVbGwjXGJOqMQzNmvf/Is5cSyIwrW/tw9fE4Cg==
X-Received: by 2002:a2e:81d5:: with SMTP id s21mr1200669ljg.258.1588229864883;
        Wed, 29 Apr 2020 23:57:44 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-7.NA.cust.bahnhof.se. [98.128.181.7])
        by smtp.gmail.com with ESMTPSA id q7sm3923866ljp.20.2020.04.29.23.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 23:57:44 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.7-rc4
Date:   Thu, 30 Apr 2020 08:57:43 +0200
Message-Id: <20200430065743.21952-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v5.7-rc4. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit ae83d0b416db002fe95601e7f97f64b59514d936:

  Linux 5.7-rc2 (2020-04-19 14:35:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.7-rc2

for you to fetch changes up to 1a8eb6b373c2af6533c13d1ea11f504e5010ed9a:

  mmc: sdhci-pci: Fix eMMC driver strength for BYT-based controllers (2020-04-22 17:57:17 +0200)

----------------------------------------------------------------
MMC host:
 - meson-mx-sdio: Fix support for HW busy detection
 - sdhci-msm: Fix support for HW busy detection
 - cqhci: Fix polling loop by converting to readx_poll_timeout()
 - sdhci-xenon: Fix annoying 1.8V regulator warning
 - sdhci-pci: Fix eMMC driver strength for BYT-based controllers

----------------------------------------------------------------
Adrian Hunter (1):
      mmc: sdhci-pci: Fix eMMC driver strength for BYT-based controllers

Douglas Anderson (1):
      mmc: cqhci: Avoid false "cqhci: CQE stuck on" by not open-coding timeout loop

Jason Yan (1):
      mmc: core: make mmc_interrupt_hpi() static

Marek Behún (1):
      mmc: sdhci-xenon: fix annoying 1.8V regulator warning

Martin Blumenstingl (2):
      mmc: meson-mx-sdio: Set MMC_CAP_WAIT_WHILE_BUSY
      mmc: meson-mx-sdio: remove the broken ->card_busy() op

Veerabhadrarao Badiganti (1):
      mmc: sdhci-msm: Enable host capabilities pertains to R1b response

 drivers/mmc/core/mmc_ops.c        |  2 +-
 drivers/mmc/host/cqhci.c          | 21 ++++++++++-----------
 drivers/mmc/host/meson-mx-sdio.c  | 11 +----------
 drivers/mmc/host/sdhci-msm.c      |  2 ++
 drivers/mmc/host/sdhci-pci-core.c |  3 +++
 drivers/mmc/host/sdhci-xenon.c    | 10 ++++++++++
 6 files changed, 27 insertions(+), 22 deletions(-)
