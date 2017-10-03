From: Colin King <colin.king@canonical.com>
Subject: [PATCH] mmc: dw_mmc-k3: make array hs_timing_cfg static
Date: Tue,  3 Oct 2017 10:56:54 +0100
Message-ID: <20171003095654.25802-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The array hs_timing_cfg is local to the source and does not need to
be in global scope, so make it static.

Cleans up sparse warning:
symbol 'hs_timing_cfg' was not declared. Should it be static?

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/mmc/host/dw_mmc-k3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc-k3.c b/drivers/mmc/host/dw_mmc-k3.c
index 64cda84b2302..73fd75c3c824 100644
--- a/drivers/mmc/host/dw_mmc-k3.c
+++ b/drivers/mmc/host/dw_mmc-k3.c
@@ -75,7 +75,7 @@ struct hs_timing {
 	u32 smpl_phase_min;
 };
 
-struct hs_timing hs_timing_cfg[TIMING_MODE][TIMING_CFG_NUM] = {
+static struct hs_timing hs_timing_cfg[TIMING_MODE][TIMING_CFG_NUM] = {
 	{ /* reserved */ },
 	{ /* SD */
 		{7, 0, 15, 15,},  /* 0: LEGACY 400k */
-- 
2.14.1
