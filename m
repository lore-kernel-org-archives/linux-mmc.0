From: Karol Wrona <k.wrona@samsung.com>
Subject: [PATCH v2 0/1] mmc: dw_mmc: Add runtime pm to dw_mmc
Date: Fri, 06 Mar 2015 14:29:32 +0100
Message-ID: <1425648573-1896-1-git-send-email-k.wrona@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:63409 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751437AbbCFN3m (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Mar 2015 08:29:42 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Karol Wrona <wrona.vy@gmail.com>, Karol Wrona <k.wrona@samsung.com>

Hello,

This patch adds runtime pm for dw_mmc.  There is no runtime pm callbacks for
exynos dw_mmc because the host hardware gates interface clock itself and it is
done separately.  The reason for runtime is mainly get an info about host state
for now.

Thanks,
Karol

Karol Wrona (1):
  mmc: dw_mmc: Add runtime pm to dw_mmc

 drivers/mmc/host/dw_mmc.c |   99 ++++++++++++++++++++++++++++++++++++++++++---
 drivers/mmc/host/dw_mmc.h |    2 +
 2 files changed, 95 insertions(+), 6 deletions(-)

-- 
1.7.9.5

