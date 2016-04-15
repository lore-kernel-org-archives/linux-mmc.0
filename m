From: Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH 10/23] mmc: core: disable auto retune during card detection
 process
Date: Sat, 16 Apr 2016 01:29:34 +0800
Message-ID: <1460741387-23815-11-git-send-email-aisheng.dong@nxp.com>
References: <1460741387-23815-1-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1460741387-23815-1-git-send-email-aisheng.dong@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-mmc@vger.kernel.org
Cc: aisheng.dong@nxp.com, ulf.hansson@linaro.org, dongas86@gmail.com, chris@printf.net, haibo.chen@nxp.com, adrian.hunter@intel.com, shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

During card detection process, mmc core may sends commands
to detect if card is still exist in mmc_rescan for removable
card which may trigger mmc retuning process after a bit time
of runtime pm suspend.
Obviously this retuning process is meaningless for card remove
case, so we disable mmc_retune in mmc_detect_change() for it.
For card insert case, the mmc_retune will be enabled normally
in its card initialization process later in mmc_execute_tuning().
So disable it at first has no side effection.

CC: stable <stable@vger.kernel.org>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/mmc/core/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 52bfaf0..76d0802 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1888,6 +1888,7 @@ static void _mmc_detect_change(struct mmc_host *host, unsigned long delay,
 		pm_wakeup_event(mmc_dev(host), 5000);
 
 	host->detect_change = 1;
+	mmc_retune_disable(host);
 	mmc_schedule_delayed_work(&host->detect, delay);
 }
 
-- 
1.9.1
