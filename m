From: Ludovic Barre <ludovic.Barre@st.com>
Subject: [PATCH V2 2/5] mmc: mmci: avoid fake busy polling in mmci_irq
Date: Fri, 26 Apr 2019 09:46:35 +0200
Message-ID: <1556264798-18540-3-git-send-email-ludovic.Barre@st.com>
References: <1556264798-18540-1-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1556264798-18540-1-git-send-email-ludovic.Barre@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: srinivas.kandagatla@linaro.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, Ludovic Barre <ludovic.barre@st.com>
List-Id: linux-mmc@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

mmci_irq function loops until the status is totally cleared.
However the busy_detect_flag could occurred even if no busy
response is expected and that busy d0 line is low (like in
cmd11: voltage switch).
Like busy_detect_flag is handled into mmci_cmd_irq this flag
can be always excluded.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 049f8e3..a040f54 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1535,9 +1535,10 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
 		}
 
 		/*
-		 * Don't poll for busy completion in irq context.
+		 * Busy_detect_flag has been handled by mmci_cmd_irq,
+		 * it can be excluded to avoid to poll on it
 		 */
-		if (host->variant->busy_detect && host->busy_status)
+		if (host->variant->busy_detect_flag)
 			status &= ~host->variant->busy_detect_flag;
 
 		ret = 1;
-- 
2.7.4
