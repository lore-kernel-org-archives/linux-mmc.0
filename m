From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Subject: [PATCH mmc-next] mmc: sdhci: fix __sdhci_adma_write_desc
Date: Mon, 17 Sep 2018 13:30:41 +0800
Message-ID: <20180917133041.66100101@xhacker.debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

If hosts provides ops->adma_write_desc, we should not fall back to the
general sdhci_adma_write_desc().

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---

Hi Ulf, Adrian,

When I introduced .adma_write_desc, I made a mistake since v4 -- if the host
provide ops->adma_write_desc, we should just call it and don't fall back
to the general sdhci_adma_write_desc(). Before v4, the adma_write_desc return
int, since v4 there's no return value, so when I prepared the v4, I just
removed return, this is where the mistake is from. I dunno how to handle
this case, fold the patch into previous commit or apply it as a separate patch?

I'm very sorry for this. In fact, Adrian caught another similar bug during
review.

Sorry about the inconvenience,
Jisheng

 drivers/mmc/host/sdhci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 0dda6f4b6a24..99bdae53fa2e 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -649,8 +649,8 @@ static inline void __sdhci_adma_write_desc(struct sdhci_host *host,
 {
 	if (host->ops->adma_write_desc)
 		host->ops->adma_write_desc(host, desc, addr, len, cmd);
-
-	sdhci_adma_write_desc(host, desc, addr, len, cmd);
+	else
+		sdhci_adma_write_desc(host, desc, addr, len, cmd);
 }
 
 static void sdhci_adma_mark_end(void *desc)
-- 
2.19.0
