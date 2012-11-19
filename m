From: Abhilash Kesavan <a.kesavan@samsung.com>
Subject: [PATCH 1/4] mmc: dt: Fix typo in filename
Date: Mon, 19 Nov 2012 10:26:18 +0530
Message-ID: <1353300981-24652-2-git-send-email-a.kesavan@samsung.com>
References: <1353300981-24652-1-git-send-email-a.kesavan@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:18363 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752785Ab2KSEvq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 18 Nov 2012 23:51:46 -0500
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MDP00E1BXGUS1J0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 19 Nov 2012 13:51:44 +0900 (KST)
Received: from localhost.localdomain ([107.108.73.92])
 by mmp2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MDP00338XGFP3E0@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 19 Nov 2012 13:51:44 +0900 (KST)
In-reply-to: <1353300981-24652-1-git-send-email-a.kesavan@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org, linux-mmc@vger.kernel.org

Fix typo in the synopsis dwmmc controller dt binding filename.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 .../{synposis-dw-mshc.txt => synopsis-dw-mshc.txt} |    0
 1 files changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/mmc/{synposis-dw-mshc.txt => synopsis-dw-mshc.txt} (100%)

diff --git a/Documentation/devicetree/bindings/mmc/synposis-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/synopsis-dw-mshc.txt
similarity index 100%
rename from Documentation/devicetree/bindings/mmc/synposis-dw-mshc.txt
rename to Documentation/devicetree/bindings/mmc/synopsis-dw-mshc.txt
-- 
1.6.6.1

