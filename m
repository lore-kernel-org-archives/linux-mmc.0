Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF97C433FE
	for <linux-mmc@archiver.kernel.org>; Tue,  1 Nov 2022 06:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiKAGcC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 1 Nov 2022 02:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbiKAGcB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Nov 2022 02:32:01 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9E316595
        for <linux-mmc@vger.kernel.org>; Mon, 31 Oct 2022 23:32:00 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N1gCd3vwDzHvPs;
        Tue,  1 Nov 2022 14:31:41 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 1 Nov 2022 14:31:51 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 1 Nov
 2022 14:31:51 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <yangyingliang@huawei.com>
Subject: [PATCH 0/9] mmc: fix return value check of mmc_add_host()
Date:   Tue, 1 Nov 2022 14:30:14 +0800
Message-ID: <20221101063023.1664968-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

mmc_add_host() may return error, but it was ignored in some drivers, if we
ignore it, the memory that allocated in mmc_alloc_host() will be leaked and
it will lead a kernel crash because of deleting not added device in the remove
path.

So fix this by checking the return value and calling mmc_free_host() in error
path.

Yang Yingliang (9):
  mmc: alcor: fix return value check of mmc_add_host()
  mmc: moxart: fix return value check of mmc_add_host()
  mmc: mxcmmc: fix return value check of mmc_add_host()
  mmc: pxamci: fix return value check of mmc_add_host()
  mmc: rtsx_pci: fix return value check of mmc_add_host()
  mmc: rtsx_usb_sdmmc: fix return value check of mmc_add_host()
  mmc: toshsd: fix return value check of mmc_add_host()
  mmc: vub300: fix return value check of mmc_add_host()
  mmc: wmt-sdmmc: fix return value check of mmc_add_host()

 drivers/mmc/host/alcor.c          |  5 ++++-
 drivers/mmc/host/moxart-mmc.c     |  4 +++-
 drivers/mmc/host/mxcmmc.c         |  4 +++-
 drivers/mmc/host/pxamci.c         |  7 ++++++-
 drivers/mmc/host/rtsx_pci_sdmmc.c |  9 ++++++++-
 drivers/mmc/host/rtsx_usb_sdmmc.c | 11 ++++++++++-
 drivers/mmc/host/toshsd.c         |  6 +++++-
 drivers/mmc/host/vub300.c         | 11 ++++++++---
 drivers/mmc/host/wmt-sdmmc.c      |  6 +++++-
 9 files changed, 52 insertions(+), 11 deletions(-)

-- 
2.25.1

