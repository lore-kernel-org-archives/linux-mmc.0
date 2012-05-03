From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 06/29] regulator: export a function to check if regulator can change status
Date: Thu,  3 May 2012 17:05:35 +0200
Message-ID: <1336057558-11031-7-git-send-email-g.liakhovetski@gmx.de>
References: <1336057558-11031-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1336057558-11031-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: linux-mmc@vger.kernel.org

Some consumers, e.g., the mmc subsystem, can benefit from an ability to
check, whether a regulator can switch power on and off.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/regulator/core.c           |   17 +++++++++++++++++
 include/linux/regulator/consumer.h |    7 +++++++
 2 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index a57defb..ec4cc0b 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1447,6 +1447,23 @@ static int _regulator_can_change_status(struct regulator_dev *rdev)
 		return 0;
 }
 
+bool regulator_can_change_status(struct regulator *regulator)
+{
+	struct regulator_dev *rdev;
+	int ret;
+
+	if (IS_ERR_OR_NULL(regulator))
+		return false;
+
+	rdev = regulator->rdev;
+	mutex_lock(&rdev->mutex);
+	ret = _regulator_can_change_status(rdev);
+	mutex_unlock(&rdev->mutex);
+
+	return ret && !rdev->constraints->always_on;
+}
+EXPORT_SYMBOL_GPL(regulator_can_change_status);
+
 /* locks held by regulator_enable() */
 static int _regulator_enable(struct regulator_dev *rdev)
 {
diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/consumer.h
index 4ed1b30..a15a476 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -177,6 +177,8 @@ int regulator_set_mode(struct regulator *regulator, unsigned int mode);
 unsigned int regulator_get_mode(struct regulator *regulator);
 int regulator_set_optimum_mode(struct regulator *regulator, int load_uA);
 
+bool regulator_can_change_status(struct regulator *regulator);
+
 /* regulator notifier block */
 int regulator_register_notifier(struct regulator *regulator,
 			      struct notifier_block *nb);
@@ -344,6 +346,11 @@ static inline void regulator_set_drvdata(struct regulator *regulator,
 {
 }
 
+static inline bool regulator_can_change_status(struct regulator *regulator)
+{
+	return false;
+}
+
 #endif
 
 #endif
-- 
1.7.2.5

