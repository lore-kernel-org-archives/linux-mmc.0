From: Ethan Du <ethan.too@gmail.com>
Subject: [PATCH] OMAP HSMMC: fix a racing case between kmmcd and
	omap_hsmmc_suspend
Date: Mon, 21 Jun 2010 19:20:41 +0800
Message-ID: <AANLkTilPeWe7ygUv0npuAhn-MnJhoPdnAu9C7S85OQUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:61566 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751908Ab0FULUp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Jun 2010 07:20:45 -0400
Received: by vws3 with SMTP id 3so894587vws.19
        for <linux-mmc@vger.kernel.org>; Mon, 21 Jun 2010 04:20:43 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>

If suspend called when kmmcd is doing host->ops->disable,
as kmmcd already increased host->en_dis_recurs to 1, the mmc_host_enable
in suspend function will return directly without increase the nesting_cnt,
which will cause the followed register access carried out to the disabled host.

mmc_suspend_host will enable host itself. No need to enable host before it.
Also works on kmmcd will get flushed in mmc_suspend_host, enable host after
it will be safe. So make the mmc_host_enable after it.

Signed-off-by: Ethan <ethan.too@gmail.com>
---
 drivers/mmc/host/omap_hsmmc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index b032828..fc74263 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2291,8 +2291,8 @@ static int omap_hsmmc_suspend(struct device *dev)
                        }
                }
                cancel_work_sync(&host->mmc_carddetect_work);
-               mmc_host_enable(host->mmc);
                ret = mmc_suspend_host(host->mmc);
+               mmc_host_enable(host->mmc);
                if (ret == 0) {
                        omap_hsmmc_disable_irq(host);
                        OMAP_HSMMC_WRITE(host->base, HCTL,
--
1.5.6.5
