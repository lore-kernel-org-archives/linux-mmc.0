Return-Path: <SRS0=KkSK=AD=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C192CC433E0
	for <linux-mmc@archiver.kernel.org>; Mon, 22 Jun 2020 02:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A765320732
	for <linux-mmc@archiver.kernel.org>; Mon, 22 Jun 2020 02:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731010AbgFVCZO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 21 Jun 2020 22:25:14 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:41498 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726992AbgFVCZO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 21 Jun 2020 22:25:14 -0400
X-IronPort-AV: E=Sophos;i="5.75,265,1589209200"; 
   d="scan'208";a="50022854"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 22 Jun 2020 11:25:12 +0900
Received: from localhost.localdomain (unknown [10.166.252.89])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id A8A0B415DFD8;
        Mon, 22 Jun 2020 11:25:12 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     mark.rutland@arm.com, lorenzo.pieralisi@arm.com,
        ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v3 0/2] treewide: fix _mmc_suspend() on PSCI
Date:   Mon, 22 Jun 2020 11:24:57 +0900
Message-Id: <1592792699-24638-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

We can detect whether the system is going to suspend by using
pm_suspend_via_firmware() API. So, this patch series update
both PSCI and MMC driver for my environment (r8a77951-salvator-xs).

We can apply each patch to each subsystem without any dependency.

Changes from v2:
 - Fix typo of function name in patch2.
 - Remove RFC.
 https://patchwork.kernel.org/project/linux-renesas-soc/list/?series=305523

Changes from v1:
 - Use pm_suspend_via_firmware() API instead of pm_suspend_target_state.
 - Modify the psci driver to call pm_set_suspend_via_firmware.
 https://patchwork.kernel.org/patch/11557505/


Yoshihiro Shimoda (2):
  firmware: psci: call pm_set_suspend_via_firmware()
  mmc: core: Call mmc_poweroff_nofity() if pm_suspend_via_firmware()

 drivers/firmware/psci/psci.c | 8 ++++++++
 drivers/mmc/core/mmc.c       | 4 +++-
 2 files changed, 11 insertions(+), 1 deletion(-)

-- 
2.7.4

