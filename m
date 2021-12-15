Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3922C433EF
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Dec 2021 16:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244210AbhLOQQQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 15 Dec 2021 11:16:16 -0500
Received: from marcansoft.com ([212.63.210.85]:57986 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243964AbhLOQQQ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 15 Dec 2021 11:16:16 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 5799641E96;
        Wed, 15 Dec 2021 16:16:12 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     Ben Chuang <benchuanggli@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Hector Martin <marcan@marcan.st>,
        Robin Murphy <robin.murphy@arm.com>,
        Sven Peter <sven@svenpeter.dev>, Marc Zyngier <maz@kernel.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 0/2] mmc: sdhci-pci-gli: GL9755: Quirks for Apple ARM platforms
Date:   Thu, 16 Dec 2021 01:10:43 +0900
Message-Id: <20211215161045.38843-1-marcan@marcan.st>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi folks,

This short series adds a few quirks needed to make the card readers in
Apple M1 Pro/Max MacBook laptops work properly.

The first patch should be straightforward; it just allows configuring
the CD/WP polarity based on device tree settings. There is already a
standard DT binding for this.

The second patch works around an issue with 8/16-bit MMIO reads that
only affects these platforms, for some reason.

Changes since v2:
 - Style fixes

Hector Martin (2):
  mmc: sdhci-pci-gli: GL9755: Support for CD/WP inversion on OF
    platforms
  mmc: sdhci-pci-gli: GL975[50]: Issue 8/16-bit MMIO reads as 32-bit
    reads.

 drivers/mmc/host/sdhci-pci-gli.c | 34 ++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

-- 
2.33.0

