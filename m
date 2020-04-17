Return-Path: <SRS0=NquR=6B=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0263C38A29
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Apr 2020 19:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBB6620780
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Apr 2020 19:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="q74mObg3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730266AbgDQTOW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 17 Apr 2020 15:14:22 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:19392 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730125AbgDQTOV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Apr 2020 15:14:21 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e99ff9d0000>; Fri, 17 Apr 2020 12:12:29 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 17 Apr 2020 12:14:21 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 17 Apr 2020 12:14:21 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 17 Apr
 2020 19:14:21 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 17 Apr 2020 19:14:20 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.171.241]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e9a000b0000>; Fri, 17 Apr 2020 12:14:20 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <baolin.wang@linaro.org>, <kstewart@linuxfoundation.org>,
        <tglx@linutronix.de>, <bradleybolen@gmail.com>,
        <gregkh@linuxfoundation.org>, <faiz_abbas@ti.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <skomatineni@nvidia.com>
CC:     <bbiswas@nvidia.com>, <anrao@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>
Subject: [PATCH 4.19.113 0/3] Fix for long operation cmds busy detection
Date:   Fri, 17 Apr 2020 12:14:01 -0700
Message-ID: <1587150844-12003-1-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1587150749; bh=MLMeZlGwo09nxFFR4BPaUlO5N8koBh6qfFD6TaQ2IpY=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=q74mObg3UbRlzdKkJ0MO2ODy070ojZ36VSP3SOZWz5D6a47VZpuIrMeObRBRxqlZ1
         w5iJXdGi3/z/tzKieBrn7Yjow18QiVJNxNBCAweL6/qHp8Ts6ryYKCkEzbI1oD2uwm
         t69IFPGIVhJAMgLgpOWRni6efg84H00lcMLx1SejKJCHLHOgOjjz/e5zCs9yxlg7bI
         MbnMPKU7MjribqepGMOZCbLYa0vvL/3PlkDtRgMwcV4AbtrJP3LqHKZ18vLjaDUayj
         dsrw6hglkerYbee+Y3MR3HnOlrNkbgIqaXOAhTsUN4tnH85jLItL2fBJ+qJCjrknFf
         SOy5x9SSpJyiQ==
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This series includes manually backported changes that implements Tegra
specific timeout callback to switch between finite and infinite HW busy
detection wait modes.

sdhci-tegra driver patch implements set_timeout callback based on one of
the sdhci host driver patch that refactors sdhci_set_timeout and allows
drivers to call __sdhci_set_timeout with their timeout callback
implementation.

Both of these patches are manually backported in this series.


Sowjanya Komatineni (3):
  mmc: sdhci: Refactor sdhci_set_timeout()
  sdhci: tegra: Implement Tegra specific set_timeout callback
  sdhci: tegra: Enable MMC_CAP_WAIT_WHILE_BUSY host capability

 drivers/mmc/host/sdhci-tegra.c | 32 ++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci.c       | 38 ++++++++++++++++++++------------------
 drivers/mmc/host/sdhci.h       |  1 +
 3 files changed, 53 insertions(+), 18 deletions(-)

-- 
2.7.4

