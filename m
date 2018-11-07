From: Ludovic Barre <ludovic.Barre@st.com>
Subject: [PATCH V2 1/2] mmc: mmci: send stop command if sbc error issue
Date: Wed, 7 Nov 2018 10:30:40 +0100
Message-ID: <1541583041-17461-2-git-send-email-ludovic.Barre@st.com>
References: <1541583041-17461-1-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1541583041-17461-1-git-send-email-ludovic.Barre@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: srinivas.kandagatla@linaro.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, Ludovic Barre <ludovic.barre@st.com>
List-Id: linux-mmc@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

Refer to "4.15 set block count command" of sd specification:
Host needs to issue CMD12 if any error is detected in
the CMD18 and CMD25 operations.

In sbc case, the data->stop is fill by framework.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 82bab35..13fa640 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1190,11 +1190,10 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
 			/* The error clause is handled above, success! */
 			data->bytes_xfered = data->blksz * data->blocks;
 
-		if (!data->stop || host->mrq->sbc) {
+		if (!data->stop || (host->mrq->sbc && !data->error))
 			mmci_request_end(host, data->mrq);
-		} else {
+		else
 			mmci_start_command(host, data->stop, 0);
-		}
 	}
 }
 
-- 
2.7.4
