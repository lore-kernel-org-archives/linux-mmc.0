From: Karol Wrona <k.wrona@samsung.com>
Subject: [PATCH v3 0/1] mmc: dw_mmc: Add runtime pm to dw_mmc
Date: Mon, 09 Mar 2015 14:46:36 +0100
Message-ID: <1425908798-9906-1-git-send-email-k.wrona@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:64711 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753660AbbCINqz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Mar 2015 09:46:55 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Karol Wrona <wrona.vy@gmail.com>, Karol Wrona <k.wrona@samsung.com>

Hello,

This patch adds runtime pm for dw_mmc.  There is no runtime pm callbacks for
exynos dw_mmc because the host hardware gates interface clock itself and it is
done separately.  The reason for runtime is mainly get an info about host state
for now.

>From v1:
	- move all pm_runtime functions to dw_mmc.c
	- change runtime autosuspend timeout

>From v2:
	- rebase on next-20150306


Thanks,
Karol

Karol Wrona (1):
  mmc: dw_mmc: Add runtime pm to dw_mmc

 drivers/mmc/host/dw_mmc.c |  103 ++++++++++++++++++++++++++++++++++++++++++---
 drivers/mmc/host/dw_mmc.h |    2 +
 2 files changed, 99 insertions(+), 6 deletions(-)

-- 
1.7.9.5

