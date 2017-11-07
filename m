From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 3/6] mmc: tmio: use devm_ioremap_resource() instead of devm_ioremap()
Date: Tue,  7 Nov 2017 17:09:29 +0900
Message-ID: <1510042172-27220-4-git-send-email-yamada.masahiro@socionext.com>
References: <1510042172-27220-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1510042172-27220-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org
Cc: Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

The TMIO core misses to request_mem_region().  devm_ioremap_resource()
takes care of it and makes the code cleaner.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mmc/host/tmio_mmc_core.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 9b8ef73..0db6cac 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -1182,8 +1182,9 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host,
 		_host->write16_hook = NULL;
 
 	res_ctl = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res_ctl)
-		return -EINVAL;
+	_host->ctl = devm_ioremap_resource(&pdev->dev, res_ctl);
+	if (IS_ERR(_host->ctl))
+		return PTR_ERR(_host->ctl);
 
 	ret = mmc_of_parse(mmc);
 	if (ret < 0)
@@ -1199,11 +1200,6 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host,
 	if (ret < 0)
 		return ret;
 
-	_host->ctl = devm_ioremap(&pdev->dev,
-				  res_ctl->start, resource_size(res_ctl));
-	if (!_host->ctl)
-		return -ENOMEM;
-
 	tmio_mmc_ops.card_busy = _host->card_busy;
 	tmio_mmc_ops.start_signal_voltage_switch =
 		_host->start_signal_voltage_switch;
-- 
2.7.4
