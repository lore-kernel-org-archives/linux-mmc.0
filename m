Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE90DC433FE
	for <linux-mmc@archiver.kernel.org>; Wed,  1 Dec 2021 15:38:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351066AbhLAPlm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 1 Dec 2021 10:41:42 -0500
Received: from smtp1.axis.com ([195.60.68.17]:57178 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351054AbhLAPll (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 1 Dec 2021 10:41:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1638373101;
  x=1669909101;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gRz4HOaI2cGK+bxLSJG/rA1CRIX2yJP88+KYxiGCaX0=;
  b=j49QbukY6BckPfsnWMnYywPJv7l5/ACIr10GMDkO+QCUND8dozZAnzKj
   a3KYwlEsDoaAHsvniDlMGfXPWN+QzlK2SXmfezY9QpRpauDj3yktmqgUk
   FwqCOsTm9wEPoX6eRYJZj0DTe2NhjSMMQJChlmDHTsUhIYIJvMj5QF52h
   DNIkpJKB9Yr+mSYlZe+RbFxFPznzaQImLYVnAocIKnTgn9ldJkJm2EfVD
   R2Ggo7OZ/rHUkyMdfgmmxg1l1+TZWZ9giZXdbs3RJq3OVpynSYuaEwwF7
   9uZFroDEf5E01MGfYjC278ZuphUbZjT6YjfUsG+zvgeVQzwCdmF4yaIbn
   A==;
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
Subject: [PATCH 0/4] Add ARTPEC-8 support to DWMMC controller
Date:   Wed, 1 Dec 2021 16:38:00 +0100
Message-ID: <20211201153804.27655-1-marten.lindahl@axis.com>
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
need a quirk to separate the configuration of the TMOUT register from
the non ARTPEC-8 versions.

This patchset is dependent on 2 changes that has been added to the mmc
git next branch, but has not yet been merged to mainline:

Patch 2 of this patchset depends on commit 0e6f2c4c2072b ("mmc: dw_mmc:
add common capabilities to replace caps").

Patch 3 of this patchset depends on commit d5bc33487eab3 ("mmc: dw_mmc:
Allow lower TMOUT value than maximum").

Kind regards
Mårten Lindahl


Mårten Lindahl (4):
  dt-bindings: mmc: exynos-dw-mshc: Add support for ARTPEC-8
  mmc: dw_mmc-exynos: Add support for ARTPEC-8
  mmc: dw_mmc: Add quirk for extended data read timeout
  mmc: dw_mmc: Do not wait for DTO in case of error

 .../bindings/mmc/exynos-dw-mshc.txt           |  2 +
 drivers/mmc/host/dw_mmc-exynos.c              | 52 +++++++++++++++----
 drivers/mmc/host/dw_mmc.c                     | 41 +++++++++++++--
 drivers/mmc/host/dw_mmc.h                     |  7 +++
 4 files changed, 87 insertions(+), 15 deletions(-)

-- 
2.20.1

