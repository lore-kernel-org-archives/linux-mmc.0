From: philipspatches@gmail.com
Subject: [PATCH] regulator: add missing defintion regulator_is_supported_voltage
Date: Sat, 30 Jun 2012 16:05:36 -0700
Message-ID: <1341097536-14190-1-git-send-email-prakity@marvell.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, broonie@opensource.wolfsonmicro.com
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org, Philip Rakity <prakity@marvell.com>
List-Id: linux-mmc@vger.kernel.org

From: Philip Rakity <prakity@marvell.com>

This definition is missing when CONFIG_REGULATOR is not defined.
This causes compiler errors when compiling sdhci.c.  This can
be worked around by adding #ifdef CONFIG_REGULATOR .. #endif
but since other definitions are there we have defined the missing
definition

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 include/linux/regulator/consumer.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/consumer.h
index 4ed1b30..42eac1c 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -294,6 +294,12 @@ static inline int regulator_get_voltage(struct regulator *regulator)
 	return 0;
 }
 
+static inline int regulator_is_supported_voltage(struct regulator *regulator,
+				   int min_uV, int max_uV)
+{
+	return 0;
+}
+
 static inline int regulator_set_current_limit(struct regulator *regulator,
 					     int min_uA, int max_uA)
 {
-- 
1.7.0.4
