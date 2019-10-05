From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] memstick: jmb38x_ms: Fix an error handling path in 'jmb38x_ms_probe()'
Date: Sat,  5 Oct 2019 13:21:01 +0200
Message-ID: <20191005112101.14410-1-christophe.jaillet@wanadoo.fr>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: maximlevitsky@gmail.com, oakad@yahoo.com, ulf.hansson@linaro.org, will@kernel.org, gustavo.pimentel@synopsys.com, colin.king@canonical.com, gustavo@embeddedor.com, efremov@linux.com, tglx@linutronix.de, yuehaibing@huawei.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>
List-Id: linux-mmc@vger.kernel.org

If 'jmb38x_ms_count_slots()' returns 0, we must undo the previous
'pci_request_regions()' call.

Goto 'err_out_int' to fix it.

Fixes: 60fdd931d577 ("memstick: add support for JMicron jmb38x MemoryStick host controller")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/memstick/host/jmb38x_ms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memstick/host/jmb38x_ms.c b/drivers/memstick/host/jmb38x_ms.c
index c4a477643977..0a9c5ddf2f59 100644
--- a/drivers/memstick/host/jmb38x_ms.c
+++ b/drivers/memstick/host/jmb38x_ms.c
@@ -941,7 +941,7 @@ static int jmb38x_ms_probe(struct pci_dev *pdev,
 	if (!cnt) {
 		rc = -ENODEV;
 		pci_dev_busy = 1;
-		goto err_out;
+		goto err_out_int;
 	}
 
 	jm = kzalloc(sizeof(struct jmb38x_ms)
-- 
2.20.1
