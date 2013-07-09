From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH v4 5/7] mmc: SDHI: add DT compatibility strings for further
 SoCs
Date: Tue, 9 Jul 2013 09:43:40 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1307090940310.28812@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:61683 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751960Ab3GIHny (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Jul 2013 03:43:54 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Add further OF compatibility strings to the SDHI driver to be able to
precisely control driver's behaviour on each of them.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---

v4:
1. added r8a7778 and r8a7779 per Morimoto-san's request
2. sh* and r8a* entries now sorted alphabetically

 drivers/mmc/host/sh_mobile_sdhi.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index cc4c872..dc4f0e0 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -129,7 +129,12 @@ static const struct sh_mobile_sdhi_ops sdhi_ops = {
 static const struct of_device_id sh_mobile_sdhi_of_match[] = {
 	{ .compatible = "renesas,shmobile-sdhi" },
 	{ .compatible = "renesas,sh7372-sdhi" },
+	{ .compatible = "renesas,sh73a0-sdhi", .data = &sh_mobile_sdhi_of_cfg[0], },
+	{ .compatible = "renesas,r8a73a4-sdhi", .data = &sh_mobile_sdhi_of_cfg[0], },
 	{ .compatible = "renesas,r8a7740-sdhi", .data = &sh_mobile_sdhi_of_cfg[0], },
+	{ .compatible = "renesas,r8a7778-sdhi", .data = &sh_mobile_sdhi_of_cfg[0], },
+	{ .compatible = "renesas,r8a7779-sdhi", .data = &sh_mobile_sdhi_of_cfg[0], },
+	{ .compatible = "renesas,r8a7790-sdhi", .data = &sh_mobile_sdhi_of_cfg[0], },
 	{},
 };
 MODULE_DEVICE_TABLE(of, sh_mobile_sdhi_of_match);
-- 
1.7.2.5

