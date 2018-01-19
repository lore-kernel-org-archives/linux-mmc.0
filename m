From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH v2 1/3] mmc: tmio: correct treatment of errors during tuning
Date: Fri, 19 Jan 2018 14:39:04 +0100
Message-ID: <20180119133906.11280-2-horms+renesas@verge.net.au>
References: <20180119133906.11280-1-horms+renesas@verge.net.au>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20180119133906.11280-1-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

From: Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>

If the return value of mmc_send_tuning() is error other than -EILSEQ, the
tuning fails and process goes out of for_loop.  But the correct processing
is to judge their TAP as bad.

Signed-off-by: Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
v2 [Simon Horman]
* Added to patchset targeted at upstream
* Minor revision of changelog

v0 [Masaharu Hayakawa]
---
 drivers/mmc/host/tmio_mmc_core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 6d8719be75a8..41767d33ef97 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -800,10 +800,7 @@ static int tmio_mmc_execute_tuning(struct mmc_host *mmc, u32 opcode)
 		if (host->prepare_tuning)
 			host->prepare_tuning(host, i % host->tap_num);
 
-		ret = mmc_send_tuning(mmc, opcode, NULL);
-		if (ret && ret != -EILSEQ)
-			goto out;
-		if (ret == 0)
+		if (!mmc_send_tuning(mmc, opcode, NULL))
 			set_bit(i, host->taps);
 
 		usleep_range(1000, 1200);
-- 
2.11.0
