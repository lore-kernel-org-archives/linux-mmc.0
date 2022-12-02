Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28532C47088
	for <linux-mmc@archiver.kernel.org>; Fri,  2 Dec 2022 15:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232993AbiLBP0v (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 2 Dec 2022 10:26:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbiLBP0u (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Dec 2022 10:26:50 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5606CFE5A;
        Fri,  2 Dec 2022 07:26:49 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id vv4so12310445ejc.2;
        Fri, 02 Dec 2022 07:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GfzukV1Ux4L9BL4XI4be4KBb9NmoiHmVAa0fVMWotXE=;
        b=m+FyXr9EiTw2fTjeRYB4BUG5ZlNW3lQ4bcSuOrJIQ74j/lh2RwSv3aIo0zB8XeEwHL
         adUoFgi6869CujIh2dzvT+vjqSGfPjyy7UWXalHlXzxAwy8GBwuPEiWH+wD26u3Uhqqv
         Px5JoMpqO7rjSPOtZGbkbDG06siK/DxDgvmmv/m3ql4s/al/0H9RQv/k5M7EjpFYHN4O
         EfXJ3ToER3krYSkIBSm7UK5YzIlbw08RwxFFAw3HGXWD6UiVFMy6hs3+Zs9BsoK36QG0
         FQc8tAFq3stQZtE79FrfNG2RqP/d1Mueub6AY9OckgxqRfl1YU1EBUHAhkM63mTApiQC
         cMLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GfzukV1Ux4L9BL4XI4be4KBb9NmoiHmVAa0fVMWotXE=;
        b=YuYoQYQNINRurtT9xi461XGUyXeGRpMQutUWJSO8Ge6oqou3XoeCwboXSbhLQuqMU7
         XIYSBkL70rzGTDd2uEYgoDIbqSXoyuzfsh0PzszGpPEYOBrVIt0pR8QwZIMv2YjBTmeD
         fuzPWzwapw0hTjHFY9yAIdDx3FAyx+hmGdLZ4VoCfdYZRs3FvaujqQdiP/OEDFBBiwX4
         faTlXwcbwutQnSUhdCtx4rts7oH2OYUb4uPIWHhTMun2pambTpc4hYooLuTQBxKBD6kT
         jn2wy48b0/vxupFcU2mFoh7XayVBmpuVTxG21DJf2hLmj7FdhbUPEUe5FXD8FfceBfmo
         aKYQ==
X-Gm-Message-State: ANoB5pnWJhsh089q2DknVQ+C40djtr+tCryzTptxQHnThA/w2mQ5+DPV
        B10S+mJMH1rQtZ9ENCjp4ec=
X-Google-Smtp-Source: AA0mqf56zuknqOVtOmggUF7Y3oz5DQtwS6R6rztiCqCmQcygR8xW/UKeH9cEzf3Xv9nBTE09A/aqSQ==
X-Received: by 2002:a17:906:8465:b0:7bd:7253:457a with SMTP id hx5-20020a170906846500b007bd7253457amr6508795ejc.81.1669994808123;
        Fri, 02 Dec 2022 07:26:48 -0800 (PST)
Received: from localhost (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id l1-20020a1709060cc100b00779cde476e4sm3130670ejh.62.2022.12.02.07.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 07:26:47 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prathamesh Shete <pshete@nvidia.com>,
        Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v12 0/6] mmc: sdhci: Add Tegra234 support
Date:   Fri,  2 Dec 2022 16:26:38 +0100
Message-Id: <20221202152644.29450-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Hi,

This is an updated version of v11 that I sent out a few weeks ago:

    https://lore.kernel.org/all/20221117182720.2290761-1-thierry.reding@gmail.com/

All remaining comments should now be addressed. I've left in the include
reordering and dropped the bitfield.h include that Adrian had noticed. I
also left the new helper as it was and will leave it up to Joerg and
Robin to decide if they want me to split off an extra !IOMMU_API stub.

It'd be great to see this go in for v6.2 and we're getting quite close
to the merge window now. As far as I can tell, the only remaining thing
is an Acked-by on the new Tegra-specific helper from Joerg and/or Robin
so that Ulf can pick this up.

Thanks,
Thierry

Prathamesh Shete (3):
  mmc: sdhci-tegra: Separate Tegra194 and Tegra234 SoC data
  mmc: sdhci-tegra: Add support to program MC stream ID
  mmc: sdhci-tegra: Issue CMD and DAT resets together

Thierry Reding (3):
  iommu: Add note about struct iommu_fwspec usage
  iommu/tegra: Add tegra_dev_iommu_get_stream_id() helper
  mmc: sdhci-tegra: Sort includes alphabetically

 drivers/mmc/host/sdhci-tegra.c | 69 ++++++++++++++++++++++++++++------
 drivers/mmc/host/sdhci.c       |  5 +++
 drivers/mmc/host/sdhci.h       |  2 +
 include/linux/iommu.h          | 25 ++++++++++++
 4 files changed, 89 insertions(+), 12 deletions(-)

-- 
2.38.1

