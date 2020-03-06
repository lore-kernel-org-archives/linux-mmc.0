Return-Path: <SRS0=VpFb=4X=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE8F7C10F25
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Mar 2020 17:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A83A02084E
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Mar 2020 17:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbgCFRoW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 6 Mar 2020 12:44:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:60448 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbgCFRoV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 6 Mar 2020 12:44:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BC6A9AC66;
        Fri,  6 Mar 2020 17:44:19 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     adrian.hunter@intel.com, linux-kernel@vger.kernel.org
Cc:     phil@raspberrypi.com, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, f.fainelli@gmail.com,
        stefan.wahren@i2se.com, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        devicetree@vger.kernel.org
Subject: [PATCH v2 00/11] Raspbery Pi 4 vmmc regulator support
Date:   Fri,  6 Mar 2020 18:44:02 +0100
Message-Id: <20200306174413.20634-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The series first cleans up a common pattern, which is ultimately needed
to integrate the regulator with bcm2711's sdhci-iproc. It then
introduces the relevant device-tree changes.

---

Changes since v1:
 - Use helper function istead of quirk
 - Add GPIO label

Nicolas Saenz Julienne (11):
  mmc: sdhci: Introduce sdhci_set_power_and_bus_voltage()
  mmc: sdhci: arasan: Use sdhci_set_power_and_voltage()
  mmc: sdhci: milbeaut: Use sdhci_set_power_and_voltage()
  mmc: sdhci: at91: Use sdhci_set_power_and_voltage()
  mmc: sdhci: pxav3: Use sdhci_set_power_and_voltage()
  mmc: sdhci: xenon: Use sdhci_set_power_and_voltage()
  mmc: sdhci: am654: Use sdhci_set_power_and_voltage()
  mmc: sdhci: Unexport sdhci_set_power_noreg()
  mmc: sdhci: iproc: Add custom set_power() callback for bcm2711
  ARM: dts: bcm2711: Update expgpio's GPIO labels
  ARM: dts: bcm2711: Add vmmc regulator in emmc2

 arch/arm/boot/dts/bcm2711-rpi-4-b.dts | 13 ++++++++++++-
 drivers/mmc/host/sdhci-iproc.c        | 17 ++++++++++++++++-
 drivers/mmc/host/sdhci-milbeaut.c     | 13 +------------
 drivers/mmc/host/sdhci-of-arasan.c    | 15 ++-------------
 drivers/mmc/host/sdhci-of-at91.c      | 18 +-----------------
 drivers/mmc/host/sdhci-pxav3.c        | 20 +-------------------
 drivers/mmc/host/sdhci-xenon.c        | 20 +-------------------
 drivers/mmc/host/sdhci.c              | 24 +++++++++++++++++++++---
 drivers/mmc/host/sdhci.h              |  5 +++--
 drivers/mmc/host/sdhci_am654.c        | 17 +++--------------
 10 files changed, 61 insertions(+), 101 deletions(-)

-- 
2.25.1

