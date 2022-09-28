Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D1CC32771
	for <linux-mmc@archiver.kernel.org>; Wed, 28 Sep 2022 08:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233630AbiI1Ip7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 28 Sep 2022 04:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233632AbiI1Ipg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Sep 2022 04:45:36 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9900CF483
        for <linux-mmc@vger.kernel.org>; Wed, 28 Sep 2022 01:41:56 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id l12so13545600ljg.9
        for <linux-mmc@vger.kernel.org>; Wed, 28 Sep 2022 01:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=jk2vF+C/PYJ42SVsy2QF4XFOq1DXTDUxrUF6AO/yW7U=;
        b=lIKu1EN4OWGnM29CBNLA/1X5h0xICvCoscT2+T3tqTuVA0oosZaKkDXXbXgK2G+hTT
         Lplar5z1FJKfA8KKnOED+Jr5NR3U35+8AZgUcrDnvzcQdZxVP1cG6EV05mQTQCbFhbWy
         kWrNLrpwnPASththyluide+4rr4kvwf/Iaez+0gy+NefskY7qLK6PhQ8WLJ/vAQVMc77
         wwug436n03vnt5g34HBt5lm/p4uEH7fcTEGqwN1L2/SRSz5VDsWVc5Lcyc8B69egFzLX
         r5HxTrvzxOjAE/FnVpG/O2fncLKWzq68RdoQo0WjXHySq322PlI1RFFFNdGGILuCRkJ6
         TIPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=jk2vF+C/PYJ42SVsy2QF4XFOq1DXTDUxrUF6AO/yW7U=;
        b=vybZsQCWzQYEIkoTvza5hstFKZz2+K1Fo6UPOuyusCiOPAEZunWGaUMjtFDMZtHILY
         cWW+HNmZYKFzMD3iVnP+LgKKtzqnuEkLc6pjGmfK4dYCMmHMI+qzUF9xq2Nn2f9kiCs1
         KnLvCEurUu28EA+wW47z9AjbWAMFbBVXdnVSmxeEK4bwBsRjysZ9YxKcT4bENIvhJhX6
         VAMcRwTCycRqDFVMVvydbz53Cm0YfaQj+cC9D3AnT8hm3qjP7pAFf9+I8SM7ImSToWJp
         rloIK0CWopAw2X8ovkb8YQzzNxf7Mh0sRebnmiCKweG/ottNvlPp5NpxNaRkwEj7err0
         O5nQ==
X-Gm-Message-State: ACrzQf1l54OWTBZ/rxTKJx7OvtVUyhEPS+n6wq/Jmq3x8SgQCK5aq3yw
        SfDabzoj172FLRZMzTbhWB4tWg==
X-Google-Smtp-Source: AMsMyM49M8Msk9MQDgBkWE2CZgxPSt7DVLA4PMayk1HvSFFNzGKmGNAXijvzGcsxcOz4KAHx8nVaCQ==
X-Received: by 2002:a2e:7309:0:b0:26c:3db7:8fe2 with SMTP id o9-20020a2e7309000000b0026c3db78fe2mr10859978ljc.387.1664354515092;
        Wed, 28 Sep 2022 01:41:55 -0700 (PDT)
Received: from uffe-XPS13.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id c6-20020a056512074600b004948b667d95sm409700lfs.265.2022.09.28.01.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 01:41:54 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] MMC + ARM_SCMI fixes for v6.0-rc8
Date:   Wed, 28 Sep 2022 10:41:52 +0200
Message-Id: <20220928084152.245040-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v6.0-rc8. This time there is
also a fix for the ARM SCMI firmware driver, which has been acked by Sudeep
Holla, the maintainer.

As usual, more details about the highlights are found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 80e78fcce86de0288793a0ef0f6acf37656ee4cf:

  Linux 6.0-rc5 (2022-09-11 16:22:01 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.0-rc5

for you to fetch changes up to e7afa79a3b35a27a046a2139f8b20bd6b98155c2:

  mmc: hsq: Fix data stomping during mmc recovery (2022-09-27 12:38:29 +0200)

----------------------------------------------------------------
MMC core:
 - Terminate infinite loop in SD-UHS voltage switch

MMC host:
 - hsq: Fix kernel crash in the recovery path
 - moxart: Fix bus width configurations
 - sdhci: Fix kernel panic for cqe irq

ARM_SCMI:
 - Fixup clock management by reverting "firmware: arm_scmi: Add clock
   management to the SCMI power domain"

----------------------------------------------------------------
Brian Norris (1):
      mmc: core: Terminate infinite loop in SD-UHS voltage switch

Sergei Antonov (1):
      mmc: moxart: fix 4-bit bus width and remove 8-bit bus width

Ulf Hansson (1):
      Revert "firmware: arm_scmi: Add clock management to the SCMI power domain"

Wenchao Chen (2):
      mmc: sdhci: Fix host->cmd is null
      mmc: hsq: Fix data stomping during mmc recovery

 drivers/firmware/arm_scmi/scmi_pm_domain.c | 26 --------------------------
 drivers/mmc/core/sd.c                      |  3 ++-
 drivers/mmc/host/mmc_hsq.c                 |  2 +-
 drivers/mmc/host/moxart-mmc.c              | 17 +++--------------
 drivers/mmc/host/sdhci.c                   |  4 ++--
 5 files changed, 8 insertions(+), 44 deletions(-)
