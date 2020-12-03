Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84053C64E7B
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Dec 2020 09:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32B4F22201
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Dec 2020 09:34:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729951AbgLCJe5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 3 Dec 2020 04:34:57 -0500
Received: from server-x.ipv4.hkg02.ds.network ([27.111.83.178]:37222 "EHLO
        mail.gtsys.com.hk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbgLCJe5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Dec 2020 04:34:57 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.gtsys.com.hk (Postfix) with ESMTP id D28E9200033F;
        Thu,  3 Dec 2020 17:34:09 +0800 (HKT)
X-Virus-Scanned: Debian amavisd-new at gtsys.com.hk
Received: from mail.gtsys.com.hk ([127.0.0.1])
        by localhost (mail.gtsys.com.hk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FxuPORXtCJRr; Thu,  3 Dec 2020 17:34:09 +0800 (HKT)
Received: from s01.gtsys.com.hk (unknown [10.128.4.2])
        by mail.gtsys.com.hk (Postfix) with ESMTP id ACBEC20001F5;
        Thu,  3 Dec 2020 17:34:09 +0800 (HKT)
Received: from armhf2.gtsys.com.hk (unknown [10.128.4.15])
        by s01.gtsys.com.hk (Postfix) with ESMTP id 95744C019FF;
        Thu,  3 Dec 2020 17:34:09 +0800 (HKT)
Received: by armhf2.gtsys.com.hk (Postfix, from userid 1000)
        id 45EE1200756; Thu,  3 Dec 2020 17:34:09 +0800 (HKT)
From:   Chris Ruehl <chris.ruehl@gtsys.com.hk>
To:     Avri Altman <Avri.Altman@wdc.com>
Cc:     Jack <jack.lo@gtsys.com.hk>,
        Chris Ruehl <chris.ruehl@gtsys.com.hk>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Krishna Konda <kkonda@codeaurora.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] mmc: core: hs400 fix probe errors 
Date:   Thu,  3 Dec 2020 17:33:26 +0800
Message-Id: <20201203093338.10480-1-chris.ruehl@gtsys.com.hk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Fix the probe if hs400-1_8v / hs400-1_2v is used in the
dts and mmc-hs400-enhanced-strobe isn't set.

Kernel errors report when on boot and reboot and eMMC device
not detect randomly. With log output below.

[    1.802342] mmc1: SDHCI controller on fe330000.sdhci [fe330000.sdhci] using ADMA
[    2.007581] mmc1: mmc_select_hs200 failed, error -110
[    2.007589] mmc1: error -110 whilst initialising MMC card
[    2.413559] mmc1: mmc_select_hs200 failed, error -110
[    2.413562] mmc1: error -110 whilst initialising MMC card
[    3.183343] mmc1: Command Queue Engine enabled
[    3.183355] mmc1: new HS400 MMC card at address 0001
[    3.197163] mmcblk1: mmc1:0001 DG4008 7.28 GiB

Current implementation called the mmc_select_hs200 first, and after init
upgrade to hs400. Somehow the eMMC chip randomly crashed here.

Patch has been tested with customized Rockchip rk3399.

Patch 1/3 preparation
move mmc_select_hs400() in between hs400es and hs200, to be able to use
static functions defined previously below the mmc_select_hs400().

Patch 2/3 functionally change
mmc_select_timing()
 call mmc_select_hs400 if EXT_CSD_CARD_TYPE_HS400 is set the
 mmc_avail_type
mmc_select_hs400()
 fixup bus-width check
 fixup set power 1.8v or 1.2v; only one because of host-cap2
 is checked in mmc_select_card().
 Add drop-down to hs-mode.
 Call hs400 prepare tuning (if ops callback)
 and mmc_execute_tuning()

Patch 3/3 cleanup
Remove MMC_CAP2_HS200_1_8V_SDR / MMC_CAP2_HS200_1_2V_SDR from
host->caps2 when mmc-hs400-1_8v or mmc-hs400-1_2v is used in the dts.


Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
---

