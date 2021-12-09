Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D20BC433EF
	for <linux-mmc@archiver.kernel.org>; Thu,  9 Dec 2021 16:46:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236982AbhLIQti (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 9 Dec 2021 11:49:38 -0500
Received: from smtp2.axis.com ([195.60.68.18]:38786 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231517AbhLIQti (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 9 Dec 2021 11:49:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1639068365;
  x=1670604365;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VOZqhmdSuPnmWvui0MEoOIRDZpX6TGqdRAMK6T3Ed/U=;
  b=by3Ga0Wl5v54+pgQRH2GPPUbZvmHk7qAijVb2ZxMwujVktS+JkTwLkd4
   lAVed80DOFwozM2Y80Cx5tEcQbCt2gGzBSV+QaKx37H2oGPfbXBXOk6OR
   hfe9/WMjDEfXHe705rVTE/o4V6gyruw6aEEfbXZVvy/+wYBVef/clsEqm
   Fey4rNbSrocMpURji1Yz1zRrNLvjgiMOdXxT1ycYZYC6PzwlAVJ5udEK0
   6fCprzWRsF8sINTBbE0L1g2Ut8LfOfAvqxnu81BhNxMw3z3XJXRMLLE3l
   IMEXUjgeBT8Nom6MDi5MqyZFkhXSN+gc1PcHbC/oe/7mDymjys8AvqDWJ
   Q==;
From:   =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Jaehoon Chung <jh80.chung@samsung.com>
CC:     Doug Anderson <dianders@google.com>, <kernel@axis.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>,
        =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
Subject: [PATCH v3 0/4] Add ARTPEC-8 support to DWMMC controller
Date:   Thu, 9 Dec 2021 17:45:54 +0100
Message-ID: <20211209164558.13729-1-marten.lindahl@axis.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi!

The ARTPEC-8 SoC has a DWMMC controller that is compatible with the
Exynos 7 version v2.70a. The main differences from Exynos 7 is that it
does not support HS400 and has an extended data read timeout. To run
this controller we need to add compatibility for ARTPEC-8, because we
need to separate the configuration of the TMOUT register from the non
ARTPEC-8 versions.

This patchset is dependent on 2 changes that has been added to the mmc
git next branch, but has not yet been merged to mainline:

Patch 2 of this patchset depends on commit 0e6f2c4c2072b ("mmc: dw_mmc:
add common capabilities to replace caps").

Patch 3 of this patchset depends on commit d5bc33487eab3 ("mmc: dw_mmc:
Allow lower TMOUT value than maximum").

Kind regards
Mårten Lindahl

Changes in v2:
 - Change compatible string vendor prefix
 - Removed unnecessary comment
 - Change 1<<0 to BIT(0)

Changes in v3:
 - Add callback for implementation specific control of data timeout
 - Add callback for implementation specific read of cycle count for
   data timeout.
 - Move definition of DW_MMC_QUIRK_EXTENDED_TMOUT from patch 3/4 to
   patch 4/4.

Mårten Lindahl (4):
  dt-bindings: mmc: exynos-dw-mshc: Add support for ARTPEC-8
  mmc: dw_mmc-exynos: Add support for ARTPEC-8
  mmc: dw_mmc: Add driver callbacks for data read timeout
  mmc: dw_mmc: Do not wait for DTO in case of error

 .../bindings/mmc/exynos-dw-mshc.txt           |   2 +
 drivers/mmc/host/dw_mmc-exynos.c              | 101 ++++++++++++++++--
 drivers/mmc/host/dw_mmc.c                     |  21 +++-
 drivers/mmc/host/dw_mmc.h                     |  10 ++
 4 files changed, 122 insertions(+), 12 deletions(-)

-- 
2.20.1

