Return-Path: <SRS0=5biu=AE=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972B4C433E0
	for <linux-mmc@archiver.kernel.org>; Tue, 23 Jun 2020 13:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E189207BB
	for <linux-mmc@archiver.kernel.org>; Tue, 23 Jun 2020 13:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732719AbgFWNlT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 23 Jun 2020 09:41:19 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:32992 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732639AbgFWNlS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 23 Jun 2020 09:41:18 -0400
X-Greylist: delayed 364 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Jun 2020 09:41:16 EDT
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 23 Jun 2020 06:35:13 -0700
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 23 Jun 2020 06:35:11 -0700
Received: from vbadigan-linux.qualcomm.com ([10.206.24.109])
  by ironmsg01-blr.qualcomm.com with ESMTP; 23 Jun 2020 19:04:55 +0530
Received: by vbadigan-linux.qualcomm.com (Postfix, from userid 76677)
        id 5E82A4140; Tue, 23 Jun 2020 19:04:54 +0530 (IST)
From:   Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        bjorn.andersson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Subject: [PATCH V5 0/3] Internal voltage control for qcom SDHC
Date:   Tue, 23 Jun 2020 19:04:45 +0530
Message-Id: <1592919288-1020-1-git-send-email-vbadigan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1589541535-8523-1-git-send-email-vbadigan@codeaurora.org>
References: <1589541535-8523-1-git-send-email-vbadigan@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On qcom SD host controllers voltage switching be done after the HW
is ready for it. The HW informs its readiness through power irq.
The voltage switching should happen only then.

So added support to register voltage regulators from the msm driver
and use them.

This patchset was posted long back but not actively pursued
https://lore.kernel.org/linux-arm-msm/1539004739-32060-1-git-send-email-vbadigan@codeaurora.org/
So posting it as fresh patchset.  

Changes since V4:	
	- Added clear comments on condtion which allows either to
	  tunf off/on Vqmmc or to set load. 
	- Added mmc_card_removable() to the condtion whcih checks
	  if the card is eMMC or other card.
	- Rerturning error for unsupported voltagtes in 
	  sdhci_msm_start_signal_voltage_switch()
	- Moved setting ios.power_mode to mmc_alloc_host().

Changes since V3:	
	- Dropped reading of regulator load values from device tree.
	- Dropped documentaiton chagne.
	- Since only Vqmmc supply of eMMC would be kept On during suspend,
	  setting load only for this regulator so that it can go to LPM.
	  And since this Load reamins same, load value is hard-coded in the driver.

Changes since V2:
	- Removed redundant log from sdhci_msm_set_vmmc.
	- Added the condition for skiping disabling of vqmmc for eMMC.
	- Updated logic such that, setting load for vqmmc only if
	  it is kept ON. 
	- Retained ack by Adrian for second patch.
	- Updated dt properties names as per Robs comments.

Changes since V1:
	- Removed setting load for Vmmc regulator while turning it on/off.
	  Instead setting the active load once during probe.
	- Simplified handlng of supplies for BUS_ON/OFF cases in shci_msm_handle_pwr_irq().
	- Moved common code out of switch case in sdhci_msm_start_signal_voltage_switch().
	- Updated variable name to sdhci_core_to_disable_vqmmc.
	- Updated pr_err logs to dev_err logs.
Veerabhadrarao Badiganti (2):
  mmc: core: Set default power mode in mmc_alloc_host
  mmc: sdhci-msm: Use internal voltage control

Vijay Viswanath (1):
  mmc: sdhci: Allow platform controlled voltage switching

 drivers/mmc/core/host.c      |   1 +
 drivers/mmc/host/sdhci-msm.c | 206 +++++++++++++++++++++++++++++++++++++++++--
 drivers/mmc/host/sdhci.c     |  32 ++++---
 drivers/mmc/host/sdhci.h     |   1 +
 4 files changed, 218 insertions(+), 22 deletions(-)

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc., is a member of Code Aurora Forum, a Linux Foundation Collaborative Project

