From: Arnd Bergmann <arnd@arndb.de>
Subject: [BACKPORT 4.4.y 05/25] mmc: debugfs: Add a restriction to mmc debugfs clock setting
Date: Fri, 22 Mar 2019 16:43:56 +0100
Message-ID: <20190322154425.3852517-6-arnd@arndb.de>
References: <20190322154425.3852517-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190322154425.3852517-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: stable@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chuanxiao Dong <chuanxiao.dong@intel.com>, Yuan Juntao <juntaox.yuan@intel.com>, Pawel Wodkowski <pawelx.wodkowski@intel.com>, Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

From: Chuanxiao Dong <chuanxiao.dong@intel.com>

Clock frequency values written to an mmc host should not be less than
the minimum clock frequency which the mmc host supports.

Signed-off-by: Yuan Juntao <juntaox.yuan@intel.com>
Signed-off-by: Pawel Wodkowski <pawelx.wodkowski@intel.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
(cherry picked from commit e5905ff1281f0a0f5c9863c430ac1ed5faaf5707)
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mmc/core/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
index 154aced0b91b..705586dcd9fa 100644
--- a/drivers/mmc/core/debugfs.c
+++ b/drivers/mmc/core/debugfs.c
@@ -220,7 +220,7 @@ static int mmc_clock_opt_set(void *data, u64 val)
 	struct mmc_host *host = data;
 
 	/* We need this check due to input value is u64 */
-	if (val > host->f_max)
+	if (val != 0 && (val > host->f_max || val < host->f_min))
 		return -EINVAL;
 
 	mmc_claim_host(host);
-- 
2.20.0
