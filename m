Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399BFC4167B
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Dec 2020 06:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11C4A23A57
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Dec 2020 06:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgLHGTp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 8 Dec 2020 01:19:45 -0500
Received: from server-x.ipv4.hkg02.ds.network ([27.111.83.178]:40568 "EHLO
        mail.gtsys.com.hk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbgLHGTo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Dec 2020 01:19:44 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 9D51E200257D;
        Tue,  8 Dec 2020 14:18:57 +0800 (HKT)
X-Virus-Scanned: Debian amavisd-new at gtsys.com.hk
Received: from mail.gtsys.com.hk ([127.0.0.1])
        by localhost (mail.gtsys.com.hk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QDOF_0t8pMbV; Tue,  8 Dec 2020 14:18:57 +0800 (HKT)
Received: from s01.gtsys.com.hk (unknown [10.128.4.2])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 758B220001FE;
        Tue,  8 Dec 2020 14:18:57 +0800 (HKT)
Received: from armhf2.gtsys.com.hk (unknown [10.128.4.15])
        by s01.gtsys.com.hk (Postfix) with ESMTP id 60A59C01F98;
        Tue,  8 Dec 2020 14:18:57 +0800 (HKT)
Received: by armhf2.gtsys.com.hk (Postfix, from userid 1000)
        id 022B52000CF; Tue,  8 Dec 2020 14:18:56 +0800 (HKT)
From:   Chris Ruehl <chris.ruehl@gtsys.com.hk>
To:     linux-mmc@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Chris Ruehl <chris.ruehl@gtsys.com.hk>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        Krishna Konda <kkonda@codeaurora.org>,
        linux-kernel@vger.kernel.org, Jack <jack.lo@gtsys.com.hk>
Subject: [PATCH 0/6] mmc: core: hs400(es) fix probe/init
Date:   Tue,  8 Dec 2020 14:18:33 +0800
Message-Id: <20201208061839.21163-1-chris.ruehl@gtsys.com.hk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Fix the probe if hs400-1_8v / hs400-1_2v is used in the
dts and mmc-hs400-enhanced-strobe isn't set.
That was the first attemped, but it turns out that some
more cleanups and simplifications can be done.

* move mmc_select_hs400() in between hs200 & hs400es (preparation)
* make mmc_select_hs400() independent and move it out
  of the hs200. Run hs400 tuning inside mmc_select_hs400();
* merge hs400 with hs400es function
* remove mmc_select_hs400es function 
* remove mmc_hs200_tuning()
* cleanup host->caps2 for hs400-1_8(2)v 


Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
---
Replace patch set [PATCH 0/3] mmc: core: hs400 fix probe
