From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 5/5] mmc: sh_mmcif: Use a 10s timeout in the error recovery path
Date: Tue, 21 Jun 2016 15:12:50 +0200
Message-ID: <1466514770-9462-6-git-send-email-ulf.hansson@linaro.org>
References: <1466514770-9462-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f42.google.com ([209.85.215.42]:33652 "EHLO
	mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751589AbcFUNVS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Jun 2016 09:21:18 -0400
Received: by mail-lf0-f42.google.com with SMTP id f6so23580144lfg.0
        for <linux-mmc@vger.kernel.org>; Tue, 21 Jun 2016 06:21:17 -0700 (PDT)
In-Reply-To: <1466514770-9462-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Nguyen Viet Dung <nv-dung@jinso.co.jp>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Baolin Wang <baolin.wang@linaro.org>

The current value means an mdelay(1) may execute up to 10000000 times,
which translates to around ~2.8 hours. This is probably not what the
orignal author had in mind. Let's instead use 10s, which is the same value
sh_mmcif is using for other timeouts.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sh_mmcif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index bab971b..9007784 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -574,7 +574,7 @@ static int sh_mmcif_error_manage(struct sh_mmcif_host *host)
 	if (state1 & STS1_CMDSEQ) {
 		sh_mmcif_bitset(host, MMCIF_CE_CMD_CTRL, CMD_CTRL_BREAK);
 		sh_mmcif_bitset(host, MMCIF_CE_CMD_CTRL, ~CMD_CTRL_BREAK);
-		for (timeout = 10000000; timeout; timeout--) {
+		for (timeout = 10000; timeout; timeout--) {
 			if (!(sh_mmcif_readl(host->addr, MMCIF_CE_HOST_STS1)
 			      & STS1_CMDSEQ))
 				break;
-- 
1.9.1

