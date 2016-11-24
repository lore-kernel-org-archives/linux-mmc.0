From: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH] mmc: android-goldfish: drop duplicate header scatterlist.h
Date: Thu, 24 Nov 2016 21:58:30 +0800
Message-ID: <250ce6f4f275e9596e3078aebd5623f9a6002700.1479988682.git.geliangtang@gmail.com>
References: <15299de49216a2360976ca37ff774cae9d27d88b.1479991297.git.geliangtang@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <15299de49216a2360976ca37ff774cae9d27d88b.1479991297.git.geliangtang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Geliang Tang <geliangtang@gmail.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Drop duplicate header scatterlist.h from android-goldfish.c.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 drivers/mmc/host/android-goldfish.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/host/android-goldfish.c b/drivers/mmc/host/android-goldfish.c
index dca5518..5de7450 100644
--- a/drivers/mmc/host/android-goldfish.c
+++ b/drivers/mmc/host/android-goldfish.c
@@ -42,7 +42,6 @@
 #include <linux/spinlock.h>
 #include <linux/timer.h>
 #include <linux/clk.h>
-#include <linux/scatterlist.h>
 
 #include <asm/io.h>
 #include <asm/irq.h>
-- 
2.9.3
