From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Subject: [PATCH/RFC] mmc: sh_mmcif: Fix timeout value for command request
Date: Thu, 30 Apr 2015 02:03:51 +0900
Message-ID: <1430327031-8349-1-git-send-email-ykaneko0929@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35914 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753701AbbD2RER (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 29 Apr 2015 13:04:17 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-sh@vger.kernel.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

f9fd54f22e ("mmc: sh_mmcif: Use msecs_to_jiffies() for host->timeout")
changed the timeout value from 1000 jiffies to 1s. In the case where
HZ is 1000 the values are the same. However, for smaller HZ values the
timeout is now smaller, 1s instead of 10s in the case of HZ=100.

Since the timeout occurs in spite of a normal data transfer a timeout of
10s seems more appropriate. This restores the previous timeout in the
case where HZ=100 and results in an increase over the previous timeout
for larger values of HZ.

Fixes: f9fd54f22e ("mmc: sh_mmcif: Use msecs_to_jiffies() for host->timeout")
Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
[horms: rewrote changelog to refer to HZ]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
---

This patch is based on the for-next branch of Mark Brown's spi tree.

A survey of the HZ resulting from of defconfigs that enable MMCIF is
as follows:

bockw_defconfig: CONFIG_HZ=1024
kzm9g_defconfig: CONFIG_HZ=128
multi_v7_defconfig: CONFIG_HZ=200
shmobile_defconfig: CONFIG_HZ=100

Simon Horman, SH Mobile maintainer, notes that it is the last defconfig
that is recommended for use at this time.

 drivers/mmc/host/sh_mmcif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 072f670..b82b982 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -1411,7 +1411,7 @@ static int sh_mmcif_probe(struct platform_device *pdev)
 	host		= mmc_priv(mmc);
 	host->mmc	= mmc;
 	host->addr	= reg;
-	host->timeout	= msecs_to_jiffies(1000);
+	host->timeout	= msecs_to_jiffies(10000);
 	host->ccs_enable = !pd || !pd->ccs_unsupported;
 	host->clk_ctrl2_enable = pd && pd->clk_ctrl2_present;
 
-- 
1.9.1

