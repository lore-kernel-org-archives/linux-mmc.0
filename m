Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76CA3C04A6A
	for <linux-mmc@archiver.kernel.org>; Mon,  7 Aug 2023 14:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbjHGOUK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 7 Aug 2023 10:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjHGOUJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Aug 2023 10:20:09 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4564910DB
        for <linux-mmc@vger.kernel.org>; Mon,  7 Aug 2023 07:19:58 -0700 (PDT)
Received: from dggpemm100014.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RKJKv2sn3z1Z1WG;
        Mon,  7 Aug 2023 22:17:07 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100014.china.huawei.com (7.185.36.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 22:19:55 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 22:19:55 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <yangyingliang@huawei.com>
Subject: [PATCH -next 0/4] mmc: remove unnecessary set_drvdata() function
Date:   Mon, 7 Aug 2023 22:17:00 +0800
Message-ID: <20230807141704.3486854-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The driver data will be set to NULL in device_unbind_cleanup() in driver
core code. So the set_drvdata(..., NULL) called in remove and error path
in probe can be removed.

Yang Yingliang (4):
  mmc: via-sdmmc: remove unnecessary dev_set_drvdata()
  mmc: block: remove unnecessary dev_set_drvdata()
  mmc: moxart: remove unnecessary dev_set_drvdata()
  mmc: sunplus: remove unnecessary platform_set_drvdata()

 drivers/mmc/core/block.c       | 1 -
 drivers/mmc/host/moxart-mmc.c  | 2 --
 drivers/mmc/host/sunplus-mmc.c | 1 -
 drivers/mmc/host/via-sdmmc.c   | 2 --
 4 files changed, 6 deletions(-)

-- 
2.25.1

