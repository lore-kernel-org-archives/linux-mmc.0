Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A45C433FE
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Dec 2021 14:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344270AbhLFOdT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 6 Dec 2021 09:33:19 -0500
Received: from smtp2.axis.com ([195.60.68.18]:10552 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245601AbhLFOdT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 6 Dec 2021 09:33:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1638800991;
  x=1670336991;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=I56fq9oOSQa7fp6BC7G0m8hJ7yaBpxzTKGiw2H8tVwA=;
  b=TISV0DnlKjS6fIIxpx2SG+06+Tpg/xNg+jx2FesOuL8EGEyGkFYfvjcb
   UZ0feUcmeUL3QhNrfDtGPcLVeN9cxWoU2+mZ0luOzOmKf2SKgWS8hha4m
   zPJSHz/dr9UcW4SaxvoY4GK+sVkX0Lv5KRhVmziMxsbX2JuZXDlnz6ODF
   glYngvngFvkzI3BgT3FoSLvq99eNto73UgGy6L4+Z+fjP8j81bTnwsXva
   GYdQnxKrVyBQM/PuQIZgUQLlShYr8TzV4wBGJ4jg2DqPRXUdaxZEisSJg
   PDH+s8ZgjLJvyQLYiwWO7J7VtqgSW86LMW7o7barDojQP53abLeThFWZD
   w==;
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
Subject: [PATCH v2 0/4] Add ARTPEC-8 support to DWMMC controller
Date:   Mon, 6 Dec 2021 15:29:25 +0100
Message-ID: <20211206142929.26729-1-marten.lindahl@axis.com>
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

Changes in v2:
 - Change compatible string vendor prefix
 - Removed unnecessary comment
 - Change 1<<0 to BIT(0)

Mårten Lindahl (4):
  dt-bindings: mmc: exynos-dw-mshc: Add support for ARTPEC-8
  mmc: dw_mmc-exynos: Add support for ARTPEC-8
  mmc: dw_mmc: Add quirk for extended data read timeout
  mmc: dw_mmc: Do not wait for DTO in case of error

 .../bindings/mmc/exynos-dw-mshc.txt           |  2 +
 drivers/mmc/host/dw_mmc-exynos.c              | 52 +++++++++++++++----
 drivers/mmc/host/dw_mmc.c                     | 41 +++++++++++++--
 drivers/mmc/host/dw_mmc.h                     |  6 +++
 4 files changed, 86 insertions(+), 15 deletions(-)

-- 
2.20.1

