From: Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH 2/5] mmc: dw_mmc-pci: Remove superflous #else condition on
 CONFIG_PM_SLEEP
Date: Tue, 12 Aug 2014 17:14:26 +0100
Message-ID: <1407860069-12706-3-git-send-email-peter.griffin@linaro.org>
References: <1407860069-12706-1-git-send-email-peter.griffin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1407860069-12706-1-git-send-email-peter.griffin@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tgih.jun@samsung.com, jh80.chung@samsung.com, chris@printf.net, ulf.hansson@linaro.org, jarkko.lavinen@nokia.com, balajitk@ti.com, baohua@kernel.org, viresh.linux@gmail.com, ian.molton@codethink.co.uk, maxime.ripard@free-electrons.com, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, spear-devel@list.st.com, linux-tegra@vger.kernel.org, michal.simek@xilinx.com, swarren@wwwdotorg.org
Cc: peter.griffin@linaro.org, lee.jones@linaro.org, patches@linaro.org
List-Id: linux-mmc@vger.kernel.org

As the code is using SIMPLE_DEV_PM_OPS helper, this compiles away to
nothing if CONFIG_PM_SLEEP is disabled. Thus we don't need to #define
the suspend/resume callbacks to NULL.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/mmc/host/dw_mmc-pci.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-pci.c b/drivers/mmc/host/dw_mmc-pci.c
index f70546a..5523b84 100644
--- a/drivers/mmc/host/dw_mmc-pci.c
+++ b/drivers/mmc/host/dw_mmc-pci.c
@@ -95,9 +95,6 @@ static int dw_mci_pci_resume(struct device *dev)
 
 	return dw_mci_resume(host);
 }
-#else
-#define dw_mci_pci_suspend	NULL
-#define dw_mci_pci_resume	NULL
 #endif /* CONFIG_PM_SLEEP */
 
 static SIMPLE_DEV_PM_OPS(dw_mci_pci_pmops, dw_mci_pci_suspend, dw_mci_pci_resume);
-- 
1.9.1
