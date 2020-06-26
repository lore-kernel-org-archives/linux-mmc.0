Return-Path: <SRS0=oKGY=AH=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05AEFC433DF
	for <linux-mmc@archiver.kernel.org>; Fri, 26 Jun 2020 09:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D37D621548
	for <linux-mmc@archiver.kernel.org>; Fri, 26 Jun 2020 09:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgFZJca (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 26 Jun 2020 05:32:30 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:24970 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726074AbgFZJca (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 26 Jun 2020 05:32:30 -0400
X-IronPort-AV: E=Sophos;i="5.75,283,1589209200"; 
   d="scan'208";a="50446469"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 26 Jun 2020 18:32:28 +0900
Received: from localhost.localdomain (unknown [10.166.252.89])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 6BEAD42034D1;
        Fri, 26 Jun 2020 18:32:28 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     ulf.hansson@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        geert+renesas@glider.be, magnus.damm@gmail.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH/RFC v4 2/4] regulator: fixed: add regulator_ops members for suspend/resume
Date:   Fri, 26 Jun 2020 18:32:20 +0900
Message-Id: <1593163942-5087-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593163942-5087-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1593163942-5087-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The regulator-fixed driver is possible to be off by firmware
like PSCI while the system is suspended. If a consumer could get
such a condition from regulator_is_enabled(), it's useful by
consumers.

So, add some regulator_ops members for it. And then, if
regulator-fixed nodes have suitable sub-nodes and properties [1],
regulator_is_enabled() will return false while suspend() of
a consumer.

[1]
 - The node has regulator-state-(standby|mem|disk) sub-nodes.
 - The node doesn't have regulator-always-on.
 - The sub-node has regulator-off-in-suspend property.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/regulator/fixed.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/regulator/fixed.c b/drivers/regulator/fixed.c
index d54830e..0bd4a1a 100644
--- a/drivers/regulator/fixed.c
+++ b/drivers/regulator/fixed.c
@@ -35,6 +35,7 @@ struct fixed_voltage_data {
 
 	struct clk *enable_clock;
 	unsigned int clk_enable_counter;
+	bool disabled_in_suspend;
 };
 
 struct fixed_dev_type {
@@ -49,6 +50,31 @@ static const struct fixed_dev_type fixed_clkenable_data = {
 	.has_enable_clock = true,
 };
 
+static int reg_is_enabled(struct regulator_dev *rdev)
+{
+	struct fixed_voltage_data *priv = rdev_get_drvdata(rdev);
+
+	return !priv->disabled_in_suspend;
+}
+
+static int reg_prepare_disable(struct regulator_dev *rdev)
+{
+	struct fixed_voltage_data *priv = rdev_get_drvdata(rdev);
+
+	priv->disabled_in_suspend = true;
+
+	return 0;
+}
+
+static int reg_resume_early_disable(struct regulator_dev *rdev)
+{
+	struct fixed_voltage_data *priv = rdev_get_drvdata(rdev);
+
+	priv->disabled_in_suspend = false;
+
+	return 0;
+}
+
 static int reg_clock_enable(struct regulator_dev *rdev)
 {
 	struct fixed_voltage_data *priv = rdev_get_drvdata(rdev);
@@ -132,6 +158,9 @@ of_get_fixed_voltage_config(struct device *dev,
 }
 
 static struct regulator_ops fixed_voltage_ops = {
+	.is_enabled = reg_is_enabled,
+	.set_prepare_disable = reg_prepare_disable,
+	.clear_resume_early_disable = reg_resume_early_disable,
 };
 
 static struct regulator_ops fixed_voltage_clkenabled_ops = {
-- 
2.7.4

