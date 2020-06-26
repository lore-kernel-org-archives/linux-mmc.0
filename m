Return-Path: <SRS0=oKGY=AH=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A3EC433E0
	for <linux-mmc@archiver.kernel.org>; Fri, 26 Jun 2020 09:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6873B21527
	for <linux-mmc@archiver.kernel.org>; Fri, 26 Jun 2020 09:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbgFZJca (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 26 Jun 2020 05:32:30 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:24970 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725280AbgFZJc3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 26 Jun 2020 05:32:29 -0400
X-IronPort-AV: E=Sophos;i="5.75,283,1589209200"; 
   d="scan'208";a="50446466"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 26 Jun 2020 18:32:28 +0900
Received: from localhost.localdomain (unknown [10.166.252.89])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 45998420330E;
        Fri, 26 Jun 2020 18:32:28 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     ulf.hansson@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        geert+renesas@glider.be, magnus.damm@gmail.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH/RFC v4 0/4] treewide: add regulator condition on _mmc_suspend()
Date:   Fri, 26 Jun 2020 18:32:18 +0900
Message-Id: <1593163942-5087-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The regulator-fixed driver is possible to be off by firmware
like PSCI while the system is suspended. If a consumer could get
such a condition from regulator_is_enabled(), it's useful by
consumers.

The patch series alllows MMC subsystem to get the disabled condition
and then eMMC device condition of my environment (r8a77951-salvator-xs)
will be better than before.
 before:
  - enter sleep mode and then turn the vmmc and vqmmc off without
    any Power Off Notification.
 after:
  - call mmc_poweroff_nofity() and then turn the vmmc and vqmmc off.

We can apply each patch to each subsystem without any dependency.

Note that v5.8-rc2 with r8a77951-salvator-xs seems to cause panic from
PCI driver when the system is suspended. So, I disabled the PCI
devices when I tested this patch series.

Changes from v3:
 - Modify regulator subsytem and regulator/fixed driver.
 - Use regulator_is_enabled() instead of firmware API.
 - Update R-Car Gen3 related dts files for the reference.
   But, I have only tested on r8a779{5,61}-salvaltor-xs.dts.
 https://patchwork.kernel.org/project/linux-renesas-soc/list/?series=306281

Changes from v2:
 - Fix typo of function name in patch2.
 - Remove RFC.
 https://patchwork.kernel.org/project/linux-renesas-soc/list/?series=305523

Changes from v1:
 - Use pm_suspend_via_firmware() API instead of pm_suspend_target_state.
 - Modify the psci driver to call pm_set_suspend_via_firmware.
 https://patchwork.kernel.org/patch/11557505/

Yoshihiro Shimoda (4):
  regulator: core: add prepare and resume_early
  regulator: fixed: add regulator_ops members for suspend/resume
  mmc: core: Call mmc_poweroff_nofity() if regulators are disabled
  arm64: dts: renesas: add regulator-off-in-suspend property for eMMC

 arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts   | 10 ++++--
 arch/arm64/boot/dts/renesas/r8a77980-condor.dts  | 10 ++++--
 arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts   | 10 ++++--
 arch/arm64/boot/dts/renesas/r8a77995-draak.dts   |  9 ++++-
 arch/arm64/boot/dts/renesas/salvator-common.dtsi | 10 ++++--
 arch/arm64/boot/dts/renesas/ulcb.dtsi            | 10 ++++--
 drivers/mmc/core/mmc.c                           | 16 ++++++++-
 drivers/regulator/core.c                         | 42 ++++++++++++++++++++++++
 drivers/regulator/fixed.c                        | 29 ++++++++++++++++
 include/linux/regulator/driver.h                 |  6 ++++
 10 files changed, 140 insertions(+), 12 deletions(-)

-- 
2.7.4

