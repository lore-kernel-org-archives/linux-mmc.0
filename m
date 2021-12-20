Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10E9C433F5
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Dec 2021 11:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbhLTLaj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 20 Dec 2021 06:30:39 -0500
Received: from smtp2.axis.com ([195.60.68.18]:53786 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230476AbhLTLai (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 20 Dec 2021 06:30:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1639999838;
  x=1671535838;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PPTFBkG6y/XQYfQbVpzumWZzIXHOKo1d9VAqFMIom20=;
  b=ANWYmg4kRxxTKUvwGFlLWI4l2Dzpc6PCpoMitfy1hhgOZ0Ju/7cGUyvt
   yRw/Cc9RmHcvFScCW9HVfy0wE/w13iBKnWdYJayPFRjQa1uC2FHALCjym
   o2mLbcMvubdZOKZE1CbD3fVorVkQy2t8PWsrLzVyO9i4WnOIOFN1ROiBu
   7iTseGgJ0GSf8VqWq+zMLuPJDN71OpyAS77MHCwibmH57s4mxuWBrlbOC
   nqehsdN37V7ftvoTeX2N5juN//UY8V07WmH+qzj2dyixpsoKgzV1k4Wfr
   6/X8zQD10sj16KLlFdeX4ZyMRw3Diauz/kzskV1DNVgzHHq855geDVuD0
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
Subject: [PATCH v5 0/4] Add ARTPEC-8 support to DWMMC controller
Date:   Mon, 20 Dec 2021 12:30:22 +0100
Message-ID: <20211220113026.21129-1-marten.lindahl@axis.com>
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

Changes in v4:
 - Add Reviewed-by and Acked-by tags from Krzysztof Kozlowski

Changes in v5:
 - Remove redundant '0x' prefix from debug message
 - Add Acked-by tag by Rob Herring

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

