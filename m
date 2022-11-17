Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BEBFC433FE
	for <linux-mmc@archiver.kernel.org>; Thu, 17 Nov 2022 18:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234924AbiKQS13 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 17 Nov 2022 13:27:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234455AbiKQS10 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Nov 2022 13:27:26 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5170C8223B;
        Thu, 17 Nov 2022 10:27:25 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id n20so7378722ejh.0;
        Thu, 17 Nov 2022 10:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RL4+32oz9xlG5wiks++zP8ElJXnjgHaHNIk8SiYr0gM=;
        b=bwsz2IdnI5WidfTcHG5Q3Ht7k/RmXjiahQwOldbulcvK62NV6b59bMrdhAJogDvd07
         xEesMzeFwtxzp/uOiLNXZVuWqY7YhMK814jspJTms9kguSZpHGN5cOp8MMgJZQeEgbuN
         /Xy/Gtvja5wEXrO/93SflxHD/FC/vPCSK160pUur1YdkR0wROGA+3zL0/MJAZ7N88Q5r
         mViXe51BWfjV5fUwb3lUQ24k2wH0kyQRYNAjTPlMDVO01CFyPvpOcUJVA7vqYEGfwJWA
         FQetkk/pkwIvQSwT9ceZ4cWvqfGYQjFU9QrWkEWRqqx5Tz4wDN6PaaKqpYkCnMUvgeOA
         A/4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RL4+32oz9xlG5wiks++zP8ElJXnjgHaHNIk8SiYr0gM=;
        b=u7okbi8E6QJksET4b73BQh22SYyPmaCM8BhMj+1kYE0zmf0r9eL0zjQcvFCTIfhtM3
         OBDqZ/7nle8Y3m6M/Ubw7hp4uceLfkznxgHkd/ifMf65Xmxgr0timB700mYrU7ZVSoNl
         nxBzLHw7LWq7N/VV2eSTQrHAIEUaicXH4Wwhs8yHAqoGhxcz27sbEUZbG83jv5dOWADB
         zzEhVEFXNLyimyv3huki7HYUCkKXGxScfFVMfPOy5wZykCQUgYwdswd6vbATCPrjeEwa
         T9PaUbbkphPAZttoWPFHi5ETmu1DraM2BnhCCCIk6wVIGMG89suhRoch4q8NQQ14+NwW
         /icA==
X-Gm-Message-State: ANoB5pm5Tu3iNYQx8q3/VUXpouUzeJR8elUO7EyEBO+4yf30Cmi/sZIf
        ssgBVl+xb1JfaiJ5ifUICiI=
X-Google-Smtp-Source: AA0mqf7/7xHFN07C2xyTxohQ8M7Liu+bUXKQNyKGeqyeHQf23eNlaibxXBxrB/PeUUF8dtSK/V62tA==
X-Received: by 2002:a17:907:778c:b0:7ad:79c0:4669 with SMTP id ky12-20020a170907778c00b007ad79c04669mr3252338ejc.395.1668709643783;
        Thu, 17 Nov 2022 10:27:23 -0800 (PST)
Received: from localhost (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id n23-20020a05640204d700b0045c47b2a800sm828832edw.67.2022.11.17.10.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 10:27:23 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prathamesh Shete <pshete@nvidia.com>,
        Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v11 0/6] mmc: sdhci: Add Tegra234 support
Date:   Thu, 17 Nov 2022 19:27:14 +0100
Message-Id: <20221117182720.2290761-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Hi,

This is an updated version of v10 that Prathamesh had sent out a while
ago:

	https://lore.kernel.org/all/20221103043852.24718-1-pshete@nvidia.com/

The main changes in here are the first three patches, of which 2 are
minor preparatory work. The first patch adds a note to the kerneldoc
comment for struct iommu_fwspec to hopefully make it clearer that no
driver should reach into its internals. Patch 2 adds a custom Tegra-
specific helper to encapsulate the common pattern that Tegra drivers
use to access the stream IDs. Patch three then resorts the includes
to make it easier to add subsequent includes in the right place.

The rest of the series is mostly the same as what Prathamesh had sent
out. Patch 4 is slightly updated because it uses the new helper and it
turns out that that also addresses some of the other review comments.

I have a local patch to migrate the remaining Tegra drivers over to the
new helper, but the plan is to hold that back until the new helper has
been merged (hopefully for v6.2) to provide the dependency in mainline,
which makes the conversion patches much easier to apply through the
appropriate subsystem trees.

Thierry

Prathamesh Shete (3):
  mmc: sdhci-tegra: Separate Tegra194 and Tegra234 SoC data
  mmc: sdhci-tegra: Add support to program MC stream ID
  mmc: sdhci-tegra: Issue CMD and DAT resets together

Thierry Reding (3):
  iommu: Add note about struct iommu_fwspec usage
  iommu/tegra: Add tegra_dev_iommu_get_stream_id() helper
  mmc: sdhci-tegra: Sort includes alphabetically

 drivers/mmc/host/sdhci-tegra.c | 70 ++++++++++++++++++++++++++++------
 drivers/mmc/host/sdhci.c       |  5 +++
 drivers/mmc/host/sdhci.h       |  2 +
 include/linux/iommu.h          | 25 ++++++++++++
 4 files changed, 90 insertions(+), 12 deletions(-)

-- 
2.38.1

