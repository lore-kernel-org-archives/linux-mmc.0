Return-Path: <SRS0=VpFb=4X=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14EB9C10F28
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Mar 2020 10:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E31342146E
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Mar 2020 10:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgCFKjX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 6 Mar 2020 05:39:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:44042 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726956AbgCFKjW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 6 Mar 2020 05:39:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E5A3BADE8;
        Fri,  6 Mar 2020 10:39:19 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        f.fainelli@gmail.com, phil@raspberrypi.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/10] Raspberry Pi vmmc regulator support
Date:   Fri,  6 Mar 2020 11:38:45 +0100
Message-Id: <20200306103857.23962-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The series snowballed into adding a new quirk, as I reliased
sdhci-iproc's behaviour is not that uncommon.

Based on Phil Elwell's work in the downstream Raspberry Pi kernel.

---

Nicolas Saenz Julienne (10):
  mmc: sdhci: Add quirk SDHCI_QUIRK2_SET_BUS_VOLTAGE
  mmc: sdhci: milbeaut: Use quirk instead of custom set_power()
  mmc: sdhci: arsan: Use quirk instead of custom set_power()
  mmc: sdhci: at-91: Use quirk instead of custom set_power()
  mmc: sdhci: pxav3: Use quirk instead of custom set_power()
  mmc: sdhci: xenon: Use quirk instead of custom set_power()
  mmc: sdhci: am654: Use quirk instead of custom set_power()
  mmc: sdhci: Unexport sdhci_set_power_noreg()
  mmc: sdhci: iproc: Use SDHCI_QUIRK2_SET_BUS_VOLTAGE on bcm2711
  ARM: dts: bcm2711: Add sd_vcc regulator to emmc2

 arch/arm/boot/dts/bcm2711-rpi-4-b.dts | 11 +++++++++
 drivers/mmc/host/sdhci-iproc.c        |  1 +
 drivers/mmc/host/sdhci-milbeaut.c     | 15 ++----------
 drivers/mmc/host/sdhci-of-arasan.c    | 22 +++++------------
 drivers/mmc/host/sdhci-of-at91.c      | 18 +-------------
 drivers/mmc/host/sdhci-pxav3.c        | 20 +---------------
 drivers/mmc/host/sdhci-xenon.c        | 20 +---------------
 drivers/mmc/host/sdhci.c              | 34 +++++++++++++++------------
 drivers/mmc/host/sdhci.h              |  4 ++--
 drivers/mmc/host/sdhci_am654.c        | 23 +++++-------------
 10 files changed, 50 insertions(+), 118 deletions(-)

-- 
2.25.1

