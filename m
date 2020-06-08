Return-Path: <SRS0=tDFP=7W=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34462C433E0
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Jun 2020 00:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 097A42078D
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Jun 2020 00:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591661931;
	bh=BDvc6Ul4JpUEu0xyaXOuBkOI3neeAE1ZCxh7AFG5C6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=od0NjwpeH/0xc1E3L58WPKHa7RmcKjxh7TllbjXaHnFvMORoYdeozxEjefINVS1xe
	 t4Kjf1NuaMh4dxE5+DfoMK86REoUHuNEn5DoakZh39jKVjJBU4RoxK2lLkJem158oR
	 ZXXdcZf6yq0VjkblzvltNfy4y8GhgSmDkpr+qS7E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbgFIASd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 8 Jun 2020 20:18:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:40876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730650AbgFHXSd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 8 Jun 2020 19:18:33 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26F652087E;
        Mon,  8 Jun 2020 23:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658313;
        bh=BDvc6Ul4JpUEu0xyaXOuBkOI3neeAE1ZCxh7AFG5C6I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z7jWVjEoiHjsISKPLQ2OPolPSV8N3kQ3m3+v3B8VHMz3m/PQmsVJUjj4MXaI/3bsQ
         4ywrKhAvjBEFMh0g5yxXp6nD5iPe7c6ktmpk+2khfa/Iqr3yDkE+axfSo6BkAhi8vd
         2gmxn3wKu4rSKJIAEvatGME/peGxKN+e158XBqhc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Peng Hao <richard.peng@oppo.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-mmc@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 314/606] mmc: block: Fix use-after-free issue for rpmb
Date:   Mon,  8 Jun 2020 19:07:19 -0400
Message-Id: <20200608231211.3363633-314-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231211.3363633-1-sashal@kernel.org>
References: <20200608231211.3363633-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Peng Hao <richard.peng@oppo.com>

[ Upstream commit 202500d21654874aa03243e91f96de153ec61860 ]

The data structure member “rpmb->md” was passed to a call of the function
“mmc_blk_put” after a call of the function “put_device”. Reorder these
function calls to keep the data accesses consistent.

Fixes: 1c87f7357849 ("mmc: block: Fix bug when removing RPMB chardev ")
Signed-off-by: Peng Hao <richard.peng@oppo.com>
Cc: stable@vger.kernel.org
[Uffe: Fixed up mangled patch and updated commit message]
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/core/block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 32db16f6debc..2d19291ebc84 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2475,8 +2475,8 @@ static int mmc_rpmb_chrdev_release(struct inode *inode, struct file *filp)
 	struct mmc_rpmb_data *rpmb = container_of(inode->i_cdev,
 						  struct mmc_rpmb_data, chrdev);
 
-	put_device(&rpmb->dev);
 	mmc_blk_put(rpmb->md);
+	put_device(&rpmb->dev);
 
 	return 0;
 }
-- 
2.25.1

