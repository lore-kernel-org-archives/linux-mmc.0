Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C422CC4332F
	for <linux-mmc@archiver.kernel.org>; Thu, 10 Nov 2022 02:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbiKJC5E (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 9 Nov 2022 21:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232626AbiKJC5C (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Nov 2022 21:57:02 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C19233BC
        for <linux-mmc@vger.kernel.org>; Wed,  9 Nov 2022 18:57:01 -0800 (PST)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N761G4m1FzHvcF;
        Thu, 10 Nov 2022 10:56:34 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 10:57:00 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 10 Nov
 2022 10:56:59 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <yangyingliang@huawei.com>
Subject: [PATCH v4 0/2] mmc: sdio: fixes some leaks
Date:   Thu, 10 Nov 2022 10:55:28 +0800
Message-ID: <20221110025530.4106568-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This patchset fix a refcount leak and two memory leaks about
SDIO function.

v3 -> v4:
  Drop patch1, keep calling put_device() to free memory,
  set 'func->card' to NULL to avoid redundant put.

v2 -> v3:
  Change to call of_node_put() in remove() function to
  fix node refcount leak.

v1 -> v2:
  Fix compile error in patch #2.

Yang Yingliang (2):
  mmc: sdio: fix of node refcount leak in sdio_add_func()
  mmc: sdio: fix possible memory leak in some error path

 drivers/mmc/core/sdio.c     | 1 +
 drivers/mmc/core/sdio_bus.c | 6 +++---
 drivers/mmc/core/sdio_cis.c | 3 ++-
 3 files changed, 6 insertions(+), 4 deletions(-)

-- 
2.25.1

