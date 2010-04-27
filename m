From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: [PATCH 3/4] MMC: atmel-mci: remove data error interrupt after xfer
Date: Tue, 27 Apr 2010 16:36:28 +0200
Message-ID: <8b5493cebeb6b6fb11936940f708956e24b3c2a1.1272378853.git.nicolas.ferre@atmel.com>
References: <1271671952-29204-1-git-send-email-nicolas.ferre@atmel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1271671952-29204-1-git-send-email-nicolas.ferre@atmel.com>
In-Reply-To: <bfa27c51250b39deeccbf6f3a656db4e0b73ce92.1272378853.git.nicolas.ferre@atmel.com>
References: <bfa27c51250b39deeccbf6f3a656db4e0b73ce92.1272378853.git.nicolas.ferre@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: haavard.skinnemoen@atmel.com, linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org, linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel@avr32linux.org, Nicolas Ferre <nicolas.ferre@atmel.com>
List-Id: linux-mmc@vger.kernel.org

Disable data error interrupts while we are actually recording that there is not
such errors. This will prevent, in some cases, the warning message printed at
new request queuing (in atmci_start_request()).

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/mmc/host/atmel-mci.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 12572e5..68b47cc 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -1308,6 +1308,7 @@ static void atmci_tasklet_func(unsigned long priv)
 			} else {
 				data->bytes_xfered = data->blocks * data->blksz;
 				data->error = 0;
+				mci_writel(host, IDR, ATMCI_DATA_ERROR_FLAGS);
 			}
 
 			if (!data->stop) {
-- 
1.5.6.5
