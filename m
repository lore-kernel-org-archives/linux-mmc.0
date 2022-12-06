Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 782ECC47090
	for <linux-mmc@archiver.kernel.org>; Tue,  6 Dec 2022 16:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234387AbiLFQ7x (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 6 Dec 2022 11:59:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbiLFQ7v (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Dec 2022 11:59:51 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A40228E0F;
        Tue,  6 Dec 2022 08:59:50 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id bj12so7649006ejb.13;
        Tue, 06 Dec 2022 08:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OKfjJSzc/TnXqstz2PY9P2PR+nNTrFow0PUsOQ/jdOw=;
        b=Zvcp0zw5Sm5Up3yg/gT9HXUTEc0NH4b3lBqCPCEBPx8Y7grbSZtbcuoi6oAMNXlaL/
         i9CG+7ouc5/gk+6vhdwVkpDIgnyQeOYfpNn/PNp9vSaCo68pMqebx2ar09ZcomhYy+8E
         Y1lrvkJFRvW7xPlTRk8cuYsRG1SDCzMfWbNsK4y2xvf6rzO/R8AJLC9d4WgcnKgNK3t5
         aH8f8XTeAUREuZMZ9Uguqv17DVx3PX4OV8vAdHkP9mLNptNyUibkrYECHIA4hhMV34Xf
         KHrZJ3ghMtrmv4XJmgrOoSkGiuxDGPoeMvtJ1h9k8njqYP6LI7kr4vbrH6ik0J6xMqFH
         d4pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OKfjJSzc/TnXqstz2PY9P2PR+nNTrFow0PUsOQ/jdOw=;
        b=qAhP7V4D6fPScvGFz4Quyw2bXpPmmubGm1y0WTtsw5LMyeUAuy1eA8TiT3DSp62FDk
         fPdF1cV1cqy6kbA3+kG66NW4siLxxxaDPByE7mdGKlpLcyCSKfdT/VhjmnOmJDRfSmeR
         Us/MbXHdRHotCHHRhtea6KPk3JPRmRShi0dV2KPaQakazxkqFFAfi0R6rFEwAdH/E47K
         rKT1IlRAPtXqPUGFlUQvrAFX6W+HduzasrxzsNUqUaeLhrCgmK3rZ+rSKiWRcNWM23tI
         I+fTg7J0oieCJnnglVgXseQSZoUGFExwWhLdRBkytroyluG6uzCU8Aq8h+JRd41kQPnb
         l/Ig==
X-Gm-Message-State: ANoB5pl5JPnTrRO3B1e7ICNrlbjdISTKuAWNs9xcxpH0NgzoTcmUQFRy
        TnQ57mxMDyQF48UY2DX82fI=
X-Google-Smtp-Source: AA0mqf7/XtLCHxTzVL2rzhU5nVWG7pN/cgzL2TNvbS69BEzhOsblB35SfrIyXQ9EPmXYd6Fe3OcNaQ==
X-Received: by 2002:a17:907:8749:b0:7c0:7c6c:d484 with SMTP id qo9-20020a170907874900b007c07c6cd484mr8199865ejc.752.1670345988984;
        Tue, 06 Dec 2022 08:59:48 -0800 (PST)
Received: from localhost (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id j10-20020a17090623ea00b00782ee6b34f2sm7502460ejg.183.2022.12.06.08.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 08:59:48 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prathamesh Shete <pshete@nvidia.com>,
        Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v13 0/6] mmc: sdhci: Add Tegra234 support
Date:   Tue,  6 Dec 2022 17:59:39 +0100
Message-Id: <20221206165945.3551774-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Hi,

This is an updated version of v12 from a few days ago:

    https://lore.kernel.org/all/20221202152644.29450-1-thierry.reding@gmail.com/

The only difference here is a fix for the included headers (bitops.h
does not have all the definitions on all architectures, so we need
bitfield.h instead) and an Acked-by from Robin on the new Tegra-specific
helper.

It'd be great to see this go in for v6.2 so that the new helper is
available for the next release and the other patches that I have
prepared can be merged.

Ulf, given that Joerg has acked patch 1 and Robin has acked patch 2, I
think the expectation is for you to pick up the whole set.

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

