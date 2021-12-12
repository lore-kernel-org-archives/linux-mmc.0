Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A7FC433F5
	for <linux-mmc@archiver.kernel.org>; Sun, 12 Dec 2021 07:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbhLLHCW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 12 Dec 2021 02:02:22 -0500
Received: from marcansoft.com ([212.63.210.85]:59154 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229545AbhLLHCV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 12 Dec 2021 02:02:21 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 4D6E642598;
        Sun, 12 Dec 2021 07:02:15 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     Ben Chuang <benchuanggli@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Marc Zyngier <maz@kernel.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/2] Hi folks,
Date:   Sun, 12 Dec 2021 16:02:08 +0900
Message-Id: <20211212070210.141664-1-marcan@marcan.st>
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

Changes since v1:

- Also applied workaround to GL9750
- Fixed checkpatch warnings

Hector Martin (2):
  mmc: sdhci-pci-gli: GL9755: Support for CD/WP inversion on OF
    platforms
  mmc: sdhci-pci-gli: GL975[50]: Issue 8/16-bit MMIO reads as 32-bit
    reads.

 drivers/mmc/host/sdhci-pci-gli.c | 42 ++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

-- 
2.33.0

