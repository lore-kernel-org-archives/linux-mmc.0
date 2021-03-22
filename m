Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E291C433E0
	for <linux-mmc@archiver.kernel.org>; Mon, 22 Mar 2021 18:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED233619A2
	for <linux-mmc@archiver.kernel.org>; Mon, 22 Mar 2021 18:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbhCVS73 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 22 Mar 2021 14:59:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:40076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232030AbhCVS7T (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 22 Mar 2021 14:59:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B511061994;
        Mon, 22 Mar 2021 18:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616439559;
        bh=ma5DQZiST6UuyaXhG1RK3qqQkaUKYMAQFWfliR48sPE=;
        h=From:To:Cc:Subject:Date:From;
        b=SSE65I6P2nTrfma4pzn7lsxd92K0aAl/O+XlncTRhO8W0n5ebTr9vJiqrSGp9SFU4
         ZuF0GnSFVn9cAGDPux0FfqWjdO0+iYQsqrkuwY5exIOyI3baeOdK7kKv8RsFmIuYdU
         V/EptWkZNcZwK0+OM4XQMAUwKZck6lsb7syKaECwiwy8A+p05qeIqTbB5LH2mJTwrF
         ie89t+Tao0fEir6bV9rwwCgOTJqUJBl/eap9BV3oapVQ0gYdhpgwN8uIuUkiFW1Jgk
         PA7jyPVE5kP94PsnmLPjtk603Do6P80UFGHG9mxQXQIJ0M9+pbkBIBgI0m7OQrFTIq
         As88LluFAuPYg==
From:   Nicolas Saenz Julienne <nsaenz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        Saenz Julienne <nsaenz@kernel.org>
Cc:     f.fainelli@gmail.com, phil@raspberrypi.com,
        tim.gover@raspberrypi.com, adrian.hunter@intel.com,
        sbranden@broadcom.com, alcooperx@gmail.com, nsaenzjulienne@suse.de,
        linux-kernel@vger.kernel.org, ulf.hansson@linaro.org
Subject: [PATCH 0/4] BCM2711's sdhci-iproc CMD timeouts
Date:   Mon, 22 Mar 2021 19:58:13 +0100
Message-Id: <20210322185816.27582-1-nsaenz@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This series tries to address rather odd behavior from BCM2711's
integration of sdhci-iproc (Raspberry Pi 4's SoC). The controller will
timeout on SDHCI CMDs under the following conditions:

 - No SD card plugged in (the card polling thread is running, CD irq disabled).
 - BCM2711's VPU clock configured at 500MHz or more, lower clocks are OK.

There is no specific command that will time out, it seems random.

I found out that by bumping the controller's frequency to 150MHz the
issue disapears. So let's do that.

Regards,
Nicolas

---

Nicolas Saenz Julienne (4):
  dt-bindings: mmc: iproc-sdhci: Convert to json-schema
  dt-bindings: mmc: iproc-sdhci: Add clock-frequency support
  mmc: sdhci-iproc: Set clock frequency as per DT
  ARM: dts: Fix-up EMMC2 controller's frequency

 .../bindings/mmc/brcm,iproc-sdhci.yaml        | 64 +++++++++++++++++++
 .../bindings/mmc/brcm,sdhci-iproc.txt         | 37 -----------
 arch/arm/boot/dts/bcm2711-rpi-4-b.dts         |  6 ++
 drivers/mmc/host/sdhci-iproc.c                | 10 +++
 4 files changed, 80 insertions(+), 37 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml
 delete mode 100644 Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt

-- 
2.30.2

