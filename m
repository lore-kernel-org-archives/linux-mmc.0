Return-Path: <SRS0=HGUj=6G=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A47C5518B
	for <linux-mmc@archiver.kernel.org>; Wed, 22 Apr 2020 16:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47F5620767
	for <linux-mmc@archiver.kernel.org>; Wed, 22 Apr 2020 16:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ejWXzDfq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgDVQcc (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 22 Apr 2020 12:32:32 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:3295 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgDVQcc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Apr 2020 12:32:32 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ea071930000>; Wed, 22 Apr 2020 09:32:19 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 22 Apr 2020 09:32:32 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 22 Apr 2020 09:32:32 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 22 Apr
 2020 16:32:32 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 22 Apr 2020 16:32:32 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.165.49]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ea0719f0000>; Wed, 22 Apr 2020 09:32:31 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <baolin.wang@linaro.org>, <kstewart@linuxfoundation.org>,
        <tglx@linutronix.de>, <bradleybolen@gmail.com>,
        <gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <skomatineni@nvidia.com>
CC:     <anrao@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
Subject: [PATCH 5.4.33 0/2] Fix for long operation cmds busy detection
Date:   Wed, 22 Apr 2020 09:32:27 -0700
Message-ID: <1587573149-30269-1-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1587573139; bh=UfGeyrkbNZXh5G8PF6DuyJaJvNbRZiJ76BYRYIS88GE=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=ejWXzDfqyxKgNycdgh1di0tVsnjj7B7OmuF7UdsBTqBOiapgEhkW/P4BtRC4ceXWm
         trFxT557DAVq3MpyQLs5lldMLDgI5PvTkf8r4Nzu1YAFIxjy/KLDpPG4RpjLd+c4yc
         GxT3h5FQDaMH1M04SMe+Pn70uKW1jFkIzaVzd+ple01k2chxmImmWKDIKcFn/ZIP5/
         wN1P5Z9p7aO7yBoi6C0epi0ySqJJc1D3U6mCf3RwsW1AyOomJLGw2Dp2OUwkz2nZZV
         EnvJ8RnsdHg+ADthIRo1ypLSVtyhjazy40QF5vndWoQt+1ZTaEF6ag7yKWUvBVY0yz
         gr9NgkpYXNmSw==
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This series is to backport the upstream patches that fixes busy detection
for long operation mmc commands by implementing Tegra specific timeout
callback to switch between finite and infinite HW busy detection wait
modes.


Sowjanya Komatineni (2):
  sdhci: tegra: Implement Tegra specific set_timeout callback
  sdhci: tegra: Enable MMC_CAP_WAIT_WHILE_BUSY host capability

 drivers/mmc/host/sdhci-tegra.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

-- 
2.7.4

