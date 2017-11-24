From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2 05/22] mmc: tmio: use devm_ioremap_resource() instead of devm_ioremap()
Date: Sat, 25 Nov 2017 01:24:40 +0900
Message-ID: <1511540697-27387-6-git-send-email-yamada.masahiro@socionext.com>
References: <1511540697-27387-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1511540697-27387-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

The TMIO core misses to call request_mem_region().
devm_ioremap_resource() takes care of it and makes the code cleaner.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Changes in v2: None

 drivers/mmc/host/tmio_mmc_core.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 12df338..d3b7af9 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -1185,8 +1185,9 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host,
 		_host->write16_hook = NULL;
 
 	res_ctl = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res_ctl)
-		return -EINVAL;
+	_host->ctl = devm_ioremap_resource(&pdev->dev, res_ctl);
+	if (IS_ERR(_host->ctl))
+		return PTR_ERR(_host->ctl);
 
 	ret = mmc_of_parse(mmc);
 	if (ret < 0)
@@ -1202,11 +1203,6 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host,
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
