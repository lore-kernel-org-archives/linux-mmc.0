Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E04C5C43217
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Nov 2022 08:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233358AbiKHI0x (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 8 Nov 2022 03:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233609AbiKHI0p (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Nov 2022 03:26:45 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EB5D229CB4
        for <linux-mmc@vger.kernel.org>; Tue,  8 Nov 2022 00:26:42 -0800 (PST)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 08 Nov 2022 17:25:38 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 4AB0C20584CE;
        Tue,  8 Nov 2022 17:25:38 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 8 Nov 2022 17:25:38 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id B2A58B62A4;
        Tue,  8 Nov 2022 17:25:37 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Jassi Brar <jaswinder.singh@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 0/4] mmc: Add support for F_SDH30_E51
Date:   Tue,  8 Nov 2022 17:25:29 +0900
Message-Id: <20221108082533.21384-1-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This series adds support for F_SDH30_E51 IP and some additional functions,
such as reset control, non-removable media, and quirks for broken timeout
clock.

Kunihiko Hayashi (4):
  mmc: f-sdh30: Add reset control support
  mmc: f-sdh30: Add support for non-removable media
  mmc: f-sdh30: Add quirks for broken timeout clock capability
  mmc: f-sdh30: Add compatible string for Socionext F_SDH30_E51

 drivers/mmc/host/sdhci_f_sdh30.c | 30 +++++++++++++++++++++++++++++-
 drivers/mmc/host/sdhci_f_sdh30.h |  3 +++
 2 files changed, 32 insertions(+), 1 deletion(-)

-- 
2.25.1

