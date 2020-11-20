Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B684CC64E7B
	for <linux-mmc@archiver.kernel.org>; Fri, 20 Nov 2020 03:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65D04222C8
	for <linux-mmc@archiver.kernel.org>; Fri, 20 Nov 2020 03:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="HScsIqsz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgKTD1F (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 19 Nov 2020 22:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbgKTD1F (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Nov 2020 22:27:05 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EE9C0613CF
        for <linux-mmc@vger.kernel.org>; Thu, 19 Nov 2020 19:27:03 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id 11so8584657ljf.2
        for <linux-mmc@vger.kernel.org>; Thu, 19 Nov 2020 19:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P9yk9CQBv+wHVI+u3khuln/FnkAkgCRh1kbuFM32wYo=;
        b=HScsIqszCe4ZeQN7agASe0mHYVTAAsmRlik/QecWIfQ7ENPlG9DvXMFMMm6Fi1Jg/E
         vQiHWZRnEsl9X/K7wdfIsSH9uTdutyzbtQzsql708OAM2pNnOnOf5QZSCu2ztHymLDWj
         ssVN2kECw79wU/VrU5muycbjsBoXNc8rfHNnba0JT9XlKTjA9pbykEQWAEjIgHR7MPkl
         xNKIfSE8Xe4UupU44IZVa0Q6rgIK24quNEGewMp++YHzRcwCi4aVp6K+8Ot2do5EXS+q
         HxflTZPg5rIU2MxgYDT3XegXKmSYswaphvf6BeAc0Ew+GbXe1g68z7lVt5juGOQj6lGn
         qpxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P9yk9CQBv+wHVI+u3khuln/FnkAkgCRh1kbuFM32wYo=;
        b=B0fBcKqcO/8XchhdGq1xDiVca6HrGAbGGd1uLI//eROnoFzRZ9MbyFWWe5R3RZnbPz
         UoBY82HKhUQ3tlrkTLLzzU5KJmktoKgU0nENYLMvC3PvurFNcQk+PdYsnnoTGHkJHiCE
         7PDzns9zFGkzElrUVwfE8f6dLws7AT4oGxphwxoOvFeQBcFiFGGOGG2NNbJrBVHwbR9g
         MYntx37L3LqLjvOkS9ZIYeh70+raqMfcgtpPxiXy6BclvReAJYqPxKuuylVDGvX0lTuL
         vczhbdTf/j1xA+iAZTc70yEysZ4WCVUEFkzp3p6gOhbuDOSLJa4b+/9RJ3/FP2kWQKSb
         qupQ==
X-Gm-Message-State: AOAM532rEbh/ffYWjRfllmsM9W5cNKhuF4qOhG8gpR5uYGTXz1R7Jvyd
        nPK6t3nbCyQuiyhnEGAti1x8NvhN3r4gmWko
X-Google-Smtp-Source: ABdhPJw/xASpUOgSh8LBQvQ2MraAR2lQubQ5Vtuk4iIgbG9734HMINhrlkWn+g0fljbxEVKi23Zh4w==
X-Received: by 2002:a2e:8846:: with SMTP id z6mr7270703ljj.311.1605842821629;
        Thu, 19 Nov 2020 19:27:01 -0800 (PST)
Received: from gilgamesh.semihalf.com (193-106-246-138.noc.fibertech.net.pl. [193.106.246.138])
        by smtp.gmail.com with ESMTPSA id s26sm153647lji.31.2020.11.19.19.27.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Nov 2020 19:27:00 -0800 (PST)
From:   Marcin Wojtas <mw@semihalf.com>
To:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org, huziji@marvell.com,
        adrian.hunter@intel.com, jaz@semihalf.com, tn@semihalf.com,
        ard.biesheuvel@arm.com, kostap@marvell.com,
        Marcin Wojtas <mw@semihalf.com>
Subject: [PATCH v2 0/4] sdhci-xenon ACPI support
Date:   Fri, 20 Nov 2020 04:26:35 +0100
Message-Id: <20201120032639.24386-1-mw@semihalf.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

The second version of the sdhci-xenon ACPI support
is now split into 4 patches instead of a single one.
There are minor functional differencse - match_data
introduction and using dedicated ACPI ID per
controller variant.

The MacchiatoBin firmware for testing can be obtained from:
https://drive.google.com/file/d/1Y8BhyaCrksQgT_GPfpqqiYHpQ41kP8Kp

Changelog:
v1->v2
  * Split single commit to 4
  * Use device_match_data and dedicated ACPI ID's per controller
    variant

Marcin Wojtas (4):
  mmc: sdhci-xenon: use match data for controllers variants
  mmc: sdhci-xenon: switch to device_* API
  mmc: sdhci-xenon: use clk only with DT
  mmc: sdhci-xenon: introduce ACPI support

 drivers/mmc/host/sdhci-xenon.h     |  12 +-
 drivers/mmc/host/sdhci-xenon-phy.c |  40 ++++---
 drivers/mmc/host/sdhci-xenon.c     | 120 +++++++++++++-------
 3 files changed, 110 insertions(+), 62 deletions(-)

-- 
2.29.0

