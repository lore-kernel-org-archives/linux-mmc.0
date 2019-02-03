From: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH v2 2/3] mmc: bcm2835: Drop pointer to mmc_host from
 bcm2835_host
Date: Sun, 3 Feb 2019 09:27:00 +0100
Message-ID: <ffa656c9f2c0e397a38e5827ba586f13e723f81b.1549181242.git.lukas@wunner.de>
References: <cover.1549181242.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <cover.1549181242.git.lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shraddha Barke <shraddha.6596-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Vaishali Thakkar <me-c39Wob3KZ2c64PEq3mRLUp/QNRX+jHPU@public.gmane.org>, Frank Pavlic <f.pavlic-XB/JSsFECOqzQB+pC5nmwQ@public.gmane.org>, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

The BCM2835 MMC host driver uses a pointer to get from the private
bcm2835_host structure to the generic mmc_host structure.  However the
latter is always immediately preceding the former in memory, so compute
its address with a subtraction (which is cheaper than a dereference) and
drop the superfluous pointer.

No functional change intended.

Signed-off-by: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Cc: Frank Pavlic <f.pavlic-XB/JSsFECOqzQB+pC5nmwQ@public.gmane.org>
Cc: Alexander Graf <agraf-l3A5Bk7waGM@public.gmane.org>
---
 drivers/mmc/host/bcm2835.c | 20 ++++++++++----------
 include/linux/mmc/host.h   |  5 +++++
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
index ab8d58a60352..246c8ec24148 100644
--- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -148,7 +148,6 @@ struct bcm2835_host {
 	void __iomem		*ioaddr;
 	u32			phys_addr;
 
-	struct mmc_host		*mmc;
 	struct platform_device	*pdev;
 
 	int			clock;		/* Current clock speed */
@@ -618,7 +617,7 @@ static void bcm2835_finish_request(struct bcm2835_host *host)
 				"failed to terminate DMA (%d)\n", err);
 	}
 
-	mmc_request_done(host->mmc, mrq);
+	mmc_request_done(mmc_from_priv(host), mrq);
 }
 
 static
@@ -837,7 +836,7 @@ static void bcm2835_timeout(struct work_struct *work)
 		dev_err(dev, "timeout waiting for hardware interrupt.\n");
 		bcm2835_dumpregs(host);
 
-		bcm2835_reset(host->mmc);
+		bcm2835_reset(mmc_from_priv(host));
 
 		if (host->data) {
 			host->data->error = -ETIMEDOUT;
@@ -1100,6 +1099,7 @@ static void bcm2835_dma_complete_work(struct work_struct *work)
 
 static void bcm2835_set_clock(struct bcm2835_host *host, unsigned int clock)
 {
+	struct mmc_host *mmc = mmc_from_priv(host);
 	int div;
 
 	/* The SDCDIV register has 11 bits, and holds (div - 2).  But
@@ -1143,18 +1143,18 @@ static void bcm2835_set_clock(struct bcm2835_host *host, unsigned int clock)
 		div = SDCDIV_MAX_CDIV;
 
 	clock = host->max_clk / (div + 2);
-	host->mmc->actual_clock = clock;
+	mmc->actual_clock = clock;
 
 	/* Calibrate some delays */
 
 	host->ns_per_fifo_word = (1000000000 / clock) *
-		((host->mmc->caps & MMC_CAP_4_BIT_DATA) ? 8 : 32);
+		((mmc->caps & MMC_CAP_4_BIT_DATA) ? 8 : 32);
 
 	host->cdiv = div;
 	writel(host->cdiv, host->ioaddr + SDCDIV);
 
 	/* Set the timeout to 500ms */
-	writel(host->mmc->actual_clock / 2, host->ioaddr + SDTOUT);
+	writel(mmc->actual_clock / 2, host->ioaddr + SDTOUT);
 }
 
 static void bcm2835_request(struct mmc_host *mmc, struct mmc_request *mrq)
@@ -1264,7 +1264,7 @@ static const struct mmc_host_ops bcm2835_ops = {
 
 static int bcm2835_add_host(struct bcm2835_host *host)
 {
-	struct mmc_host *mmc = host->mmc;
+	struct mmc_host *mmc = mmc_from_priv(host);
 	struct device *dev = &host->pdev->dev;
 	char pio_limit_string[20];
 	int ret;
@@ -1370,7 +1370,6 @@ static int bcm2835_probe(struct platform_device *pdev)
 
 	mmc->ops = &bcm2835_ops;
 	host = mmc_priv(mmc);
-	host->mmc = mmc;
 	host->pdev = pdev;
 	spin_lock_init(&host->lock);
 
@@ -1441,8 +1440,9 @@ static int bcm2835_probe(struct platform_device *pdev)
 static int bcm2835_remove(struct platform_device *pdev)
 {
 	struct bcm2835_host *host = platform_get_drvdata(pdev);
+	struct mmc_host *mmc = mmc_from_priv(host);
 
-	mmc_remove_host(host->mmc);
+	mmc_remove_host(mmc);
 
 	writel(SDVDD_POWER_OFF, host->ioaddr + SDVDD);
 
@@ -1454,7 +1454,7 @@ static int bcm2835_remove(struct platform_device *pdev)
 	if (host->dma_chan_rxtx)
 		dma_release_channel(host->dma_chan_rxtx);
 
-	mmc_free_host(host->mmc);
+	mmc_free_host(mmc);
 	platform_set_drvdata(pdev, NULL);
 
 	return 0;
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 4d35ff36ceff..d893902b2f1c 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -478,6 +478,11 @@ static inline void *mmc_priv(struct mmc_host *host)
 	return (void *)host->private;
 }
 
+static inline struct mmc_host *mmc_from_priv(void *priv)
+{
+	return container_of(priv, struct mmc_host, private);
+}
+
 #define mmc_host_is_spi(host)	((host)->caps & MMC_CAP_SPI)
 
 #define mmc_dev(x)	((x)->parent)
-- 
2.20.1
