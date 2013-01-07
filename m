From: Kevin Liu <kliu5@marvell.com>
Subject: [PATCH 1/2] regulator: add regulator_is_dummy function
Date: Mon,  7 Jan 2013 13:38:50 +0800
Message-ID: <1357537131-8000-1-git-send-email-kliu5@marvell.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Rainer Kaluscha <rainer.kaluscha@web.de>, Rainer Kaluscha <ich@rainer-kaluscha.de>, Philip Rakity <prakity@nvidia.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Chao Xie <cxie4@marvell.com>, Kevin Liu <keyuan.liu@gmail.com>, Kevin Liu <kliu5@marvell.com>
List-Id: linux-mmc@vger.kernel.org

Introduce a regulator_is_dummy function to check whether the
regulator is dummy.

Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/regulator/core.c           |   17 +++++++++++++++++
 include/linux/regulator/consumer.h |    6 ++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index e872c8b..d2a8bdb 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1826,6 +1826,23 @@ int regulator_disable_regmap(struct regulator_dev *rdev)
 }
 EXPORT_SYMBOL_GPL(regulator_disable_regmap);
 
+/**
+ * regulator_is_dummy - check if regulator is dummy
+ * @regulator: regulator source
+ *
+ * Returns positive if the regulator is dummy, zero if it's not.
+ */
+int regulator_is_dummy(struct regulator *regulator)
+{
+	struct regulator_dev	*rdev = regulator->rdev;
+
+	if (!strcmp(rdev_get_name(rdev), "regulator-dummy"))
+		return 1;
+	else
+		return 0;
+}
+EXPORT_SYMBOL_GPL(regulator_is_dummy);
+
 static int _regulator_is_enabled(struct regulator_dev *rdev)
 {
 	/* A GPIO control always takes precedence */
diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/consumer.h
index c43cd35..fe549d0 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -164,6 +164,7 @@ int regulator_count_voltages(struct regulator *regulator);
 int regulator_list_voltage(struct regulator *regulator, unsigned selector);
 int regulator_is_supported_voltage(struct regulator *regulator,
 				   int min_uV, int max_uV);
+int regulator_is_dummy(struct regulator *regulator);
 int regulator_set_voltage(struct regulator *regulator, int min_uV, int max_uV);
 int regulator_set_voltage_time(struct regulator *regulator,
 			       int old_uV, int new_uV);
@@ -249,6 +250,11 @@ static inline int regulator_is_enabled(struct regulator *regulator)
 	return 1;
 }
 
+static inline int regulator_is_dummy(struct regulator *regulator)
+{
+	return 0;
+}
+
 static inline int regulator_bulk_get(struct device *dev,
 				     int num_consumers,
 				     struct regulator_bulk_data *consumers)
-- 
1.7.9.5

