Return-Path: <SRS0=HGUj=6G=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E173C55185
	for <linux-mmc@archiver.kernel.org>; Wed, 22 Apr 2020 16:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D176B20767
	for <linux-mmc@archiver.kernel.org>; Wed, 22 Apr 2020 16:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="n+XDQOaa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgDVQdC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 22 Apr 2020 12:33:02 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:3382 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbgDVQdC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Apr 2020 12:33:02 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ea071b10000>; Wed, 22 Apr 2020 09:32:49 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 22 Apr 2020 09:33:02 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 22 Apr 2020 09:33:02 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 22 Apr
 2020 16:33:01 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 22 Apr 2020 16:33:01 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.165.49]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ea071bd0000>; Wed, 22 Apr 2020 09:33:01 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <baolin.wang@linaro.org>, <kstewart@linuxfoundation.org>,
        <tglx@linutronix.de>, <bradleybolen@gmail.com>,
        <gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <skomatineni@nvidia.com>
CC:     <anrao@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
Subject: [PATCH 5.5.18 0/2] Fix for long operation cmds busy detection
Date:   Wed, 22 Apr 2020 09:32:56 -0700
Message-ID: <1587573178-30326-1-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1587573169; bh=UfGeyrkbNZXh5G8PF6DuyJaJvNbRZiJ76BYRYIS88GE=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=n+XDQOaaKQilw1L6BadmGvY2vfB3YvRuGRMzkFc8bUFF0NhqOWklFw5Ogk9j8yZHE
         dTrdB0n88z+zOcC9SVfcAmOfERsyLp1ox96AZf3Na1mWkANVe8YKYN5Bp/DV9q77yg
         yFFmTn2Sr5TUOMzHexODXizXbu6rnPbhzbeQ+rUMcMupgHBUyFs7yB/blFuSchKTWN
         zdnPOM/H5qcTErLNHuQWPL/03KJx7oTr0pry6QQO/JN2SNlHWIGS3ADfAcefdRzbVy
         qnWMfh9Uq+jGH2yCxSNAHG/aph9RK6jJTqGo1GWSkX+fgYNR5Y3S8G59CV8tDaCdDV
         7AUfrSBuXvXIA==
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

