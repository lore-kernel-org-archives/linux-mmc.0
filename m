From: Linus Walleij <linus.walleij@stericsson.com>
Subject: [PATCH 2/4] mmci: adjust calculation of f_min
Date: Tue, 28 Jun 2011 09:57:33 +0200
Message-ID: <1309247853-17143-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Linus Walleij <linus.walleij@linaro.org>, Lee Jones <lee.jones@linaro.org>, Ulf Hansson <ulf.hansson@stericsson.com>
List-Id: linux-mmc@vger.kernel.org

From: Ulf Hansson <ulf.hansson@stericsson.com>

For the st_clkdiv variant f_min is too low for practical cases,
there is a heuristic calculation that appear to set the min
frequency to mclk rounded up with 512, for our practical use
cases dividing by 257 gives a reasonable floor value on the
ST Micro version of the clock divider.

Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
Reviewed-by: Sebastian Rasmussen <sebastian.rasmussen@stericsson.com>
[Use DIV_ROUND_UP to clarify elder code]
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/mmci.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index fe14072..c73d054 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1063,7 +1063,10 @@ static int __devinit mmci_probe(struct amba_device *dev,
 	}
 
 	mmc->ops = &mmci_ops;
-	mmc->f_min = (host->mclk + 511) / 512;
+	if (variant->st_clkdiv)
+		mmc->f_min = host->mclk / 257;
+	else
+		mmc->f_min = DIV_ROUND_UP(host->mclk, 512);
 	/*
 	 * If the platform data supplies a maximum operating
 	 * frequency, this takes precedence. Else, we fall back
-- 
1.7.3.2
