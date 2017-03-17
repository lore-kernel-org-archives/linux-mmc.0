From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH V2 1/2] mmc: sdhci: Add support for setting parent clock
Date: Fri, 17 Mar 2017 09:25:31 +0000
Message-ID: <1489742732-7722-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ritesh Harjani <riteshh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

It is common for SD/MMC host controllers to set the parent clock that
drives the SD/MMC interface in order to support various operating
speeds. Typically, this is performed by calling common clock framework
APIs such as clk_set_rate(). The problem is that these APIs may sleep
and must not be called from within atomic sections and therefore, these
functions cannot be called within the existing 'set_clock' SDHCI
operator because they are called from within the context of a spinlock.
Add a new 'set_parent_clock' operator for the SDHCI driver that is
called early during the SDHCI 'set_ios' before the spinlock is aquired
to give the platform driver the opportunity to set the parent clock
rate.

Please note that the Tegra and MSM SDHCI drivers currently appear to
mis-use the 'set_clock' operator by calling clk_set_rate(). In the case
of Tegra, occasionally but not always, 'scheduling while atomic' errors
are reported (so most of the time we are getting lucky). In the of the
MSM SDHCI driver, it is releasing and re-acquiring the spinlock which is
bad.

Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---

Changes since V1:
- Fixed idiotic copy-paste error and testing thoroughly!

 drivers/mmc/host/sdhci.c | 3 +++
 drivers/mmc/host/sdhci.h | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 6fdd7a70f229..8effc28ece15 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1579,6 +1579,9 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	if (ios->power_mode == MMC_POWER_UNDEFINED)
 		return;
 
+	if (host->ops->set_parent_clock)
+		host->ops->set_parent_clock(host, ios->clock);
+
 	spin_lock_irqsave(&host->lock, flags);
 
 	if (host->flags & SDHCI_DEVICE_DEAD) {
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index edf3adfbc213..585fbcdab70c 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -541,6 +541,8 @@ struct sdhci_ops {
 #endif
 
 	void	(*set_clock)(struct sdhci_host *host, unsigned int clock);
+	void	(*set_parent_clock)(struct sdhci_host *host,
+				    unsigned int clock);
 	void	(*set_power)(struct sdhci_host *host, unsigned char mode,
 			     unsigned short vdd);
 
-- 
2.7.4
