Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 149E1C433B4
	for <linux-mmc@archiver.kernel.org>; Tue,  6 Apr 2021 10:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9A74613C6
	for <linux-mmc@archiver.kernel.org>; Tue,  6 Apr 2021 10:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237435AbhDFKsl (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 6 Apr 2021 06:48:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:43766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237178AbhDFKsi (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 6 Apr 2021 06:48:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C1462610C8;
        Tue,  6 Apr 2021 10:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617706111;
        bh=vlNBewdohdDRf3gdIEX3K46W8EM1S5JbaoVBGjDPwWE=;
        h=From:To:Cc:Subject:Date:From;
        b=i1qH07UyELWf92Khy38ECphN7Zmcx/9KhplNkkhghDmpSTkHlhnyiNSDaQW/zZ/ZP
         1EhV7vvqpn41B547r71kQtdO5YvBIajmxKNYerHRXdzmGwEIm1i/3ioDqkMw9weUid
         NLUnf3/YjwuKq1AC7ZgZgf35E0QJcsE4z1hAA+TuzjZ8FI05PQGAjxVhJMb9z4TfFK
         IbTxq5I7K65MzzEyzjF3GOBW0Nr5v5NBLckWg6RDNXdG1GaL/wsMZlYVseSpy95+IC
         I6jBhH0ICj1wQ4bzIXwTFBe03anlgSwKap+Z3gKdFyBaldWvAxbxLxKsLQv/522/dU
         u20V5KphTgm+w==
From:   Nicolas Saenz Julienne <nsaenz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        Ray Jui <ray.jui@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Saenz Julienne <nsaenz@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Stefan Wahren <wahrenst@gmx.net>,
        Matthias Brugger <mbrugger@suse.com>
Cc:     f.fainelli@gmail.com, phil@raspberrypi.com,
        tim.gover@raspberrypi.com, adrian.hunter@intel.com,
        sbranden@broadcom.com, alcooperx@gmail.com, nsaenzjulienne@suse.de,
        linux-kernel@vger.kernel.org, robh@kernel.org,
        stefan.wahren@i2se.com
Subject: [PATCH 0/3] BCM2711 sdhci-iproc improvements
Date:   Tue,  6 Apr 2021 12:47:59 +0200
Message-Id: <20210406104802.20898-1-nsaenz@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This is a follow-up series to "BCM2711's sdhci-iproc CMD timeouts"[1],
but since much most of the patches changed I decided to start counting
patch revisions from scratch.

This series tries to address rather odd behavior from BCM2711's
integration of sdhci-iproc (Raspberry Pi 4's SoC). The controller will
timeout on SDHCI CMDs under the following conditions:

 - No SD card plugged in (the card polling thread is running, CD irq disabled).
 - BCM2711's VPU clock configured at 500MHz or more, lower clocks are OK.

There is no specific command that will time out, it seems random.

As an extra to this I also include a small fix, and convert the
controller's bindings to yaml.

Regards,
Nicolas

[1] https://lore.kernel.org/linux-mmc/20210322185816.27582-1-nsaenz@kernel.org/

---

Nicolas Saenz Julienne (3):
  dt-bindings: mmc: iproc-sdhci: Convert to json-schema
  mmc: sdhci-iproc: Cap min clock frequency on BCM2711
  mmc: sdhci-iproc: Set SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN on BCM2711

 .../bindings/mmc/brcm,iproc-sdhci.yaml        | 63 +++++++++++++++++++
 .../bindings/mmc/brcm,sdhci-iproc.txt         | 37 -----------
 drivers/mmc/host/sdhci-iproc.c                | 21 ++++++-
 3 files changed, 83 insertions(+), 38 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml
 delete mode 100644 Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt

-- 
2.30.2

