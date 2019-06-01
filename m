From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 050/141] mmc: mmci: Prevent polling for busy detection in IRQ context
Date: Sat,  1 Jun 2019 09:20:26 -0400
Message-ID: <20190601132158.25821-50-sashal@kernel.org>
References: <20190601132158.25821-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190601132158.25821-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Ludovic Barre <ludovic.barre@st.com>, Ulf Hansson <ulf.hansson@linaro.org>, Sasha Levin <sashal@kernel.org>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

[ Upstream commit 8520ce1e17799b220ff421d4f39438c9c572ade3 ]

The IRQ handler, mmci_irq(), loops until all status bits have been cleared.
However, the status bit signaling busy in variant->busy_detect_flag, may be
set even if busy detection isn't monitored for the current request.

This may be the case for the CMD11 when switching the I/O voltage, which
leads to that mmci_irq() busy loops in IRQ context. Fix this problem, by
clearing the status bit for busy, before continuing to validate the
condition for the loop. This is safe, because the busy status detection has
already been taken care of by mmci_cmd_irq().

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/mmci.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 1841d250e9e2c..eb1a65cb878f0 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1295,9 +1295,10 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
 		}
 
 		/*
-		 * Don't poll for busy completion in irq context.
+		 * Busy detection has been handled by mmci_cmd_irq() above.
+		 * Clear the status bit to prevent polling in IRQ context.
 		 */
-		if (host->variant->busy_detect && host->busy_status)
+		if (host->variant->busy_detect_flag)
 			status &= ~host->variant->busy_detect_flag;
 
 		ret = 1;
-- 
2.20.1
