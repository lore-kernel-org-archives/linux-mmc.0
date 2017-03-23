From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [v2, 4/7] mmc: sdhci: add a quirk to restore delay in tuning
Date: Thu, 23 Mar 2017 09:03:43 +0200
Message-ID: <878da006-5b83-a9d9-6136-07d8f07ea65f@intel.com>
References: <1488529129-23560-1-git-send-email-yangbo.lu@nxp.com>
 <1488529129-23560-5-git-send-email-yangbo.lu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1488529129-23560-5-git-send-email-yangbo.lu@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Yangbo Lu <yangbo.lu@nxp.com>, linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
Cc: devicetree@vger.kernel.org, Xiaobo Xie <xiaobo.xie@nxp.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On 03/03/17 10:18, Yangbo Lu wrote:
> There was a mdelay between tuning cycles which is removed since
> eMMC spec didn't require that. However it's observed that eSDHC
> needed this delay for HS200 successful tuning. Maybe it's also
> needed for some other controllers. This patch is to add a quirk
> to fix it.
> 
> Fixes: 197160d52e85 ("mmc: sdhci: remove mdelay in eMMC tuning")
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> ---

I would prefer to do something like this:

---
From: Adrian Hunter <adrian.hunter@intel.com>
Date: Thu, 23 Mar 2017 08:54:06 +0200
Subject: [PATCH] mmc: sdhci: Control the delay between tuning commands

The delay between tuning commands for SD cards is not part of the
specification. A driver that needs it probably needs it for eMMC too,
whereas most drivers would probably like to set it to 0. Make it a
host member (host->tuning_delay) that defaults to the existing behaviour.
Drivers can set it to zero to eliminate the delay, or set it to a positive
value to always have a delay.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 11 ++++++++---
 drivers/mmc/host/sdhci.h |  1 +
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index a33102fc800b..2fc33485df1d 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2100,9 +2100,9 @@ static void __sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
 			break;
 		}
 
-		/* eMMC spec does not require a delay between tuning cycles */
-		if (opcode == MMC_SEND_TUNING_BLOCK)
-			mdelay(1);
+		/* Spec does not require a delay between tuning cycles */
+		if (host->tuning_delay > 0)
+			mdelay(host->tuning_delay);
 	}
 
 	pr_info("%s: Tuning failed, falling back to fixed sampling clock\n",
@@ -2164,6 +2164,9 @@ int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 
 	host->mmc->retune_period = tuning_count;
 
+	if (host->tuning_delay < 0)
+		host->tuning_delay = opcode == MMC_SEND_TUNING_BLOCK;
+
 	sdhci_start_tuning(host);
 
 	__sdhci_execute_tuning(host, opcode);
@@ -3108,6 +3111,8 @@ struct sdhci_host *sdhci_alloc_host(struct device *dev,
 	host->cqe_ier     = SDHCI_CQE_INT_MASK;
 	host->cqe_err_ier = SDHCI_CQE_INT_ERR_MASK;
 
+	host->tuning_delay = -1;
+
 	return host;
 }
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 35b41da0a636..b0f416fc9548 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -538,6 +538,7 @@ struct sdhci_host {
 #define SDHCI_TUNING_MODE_1	0
 #define SDHCI_TUNING_MODE_2	1
 #define SDHCI_TUNING_MODE_3	2
+	int			tuning_delay;	/* Delay (ms) between tuning commands */
 
 	unsigned long private[0] ____cacheline_aligned;
 };
-- 
1.9.1
