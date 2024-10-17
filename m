Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2051.outbound.protection.outlook.com [40.107.104.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AD41D414F;
	Thu, 17 Oct 2024 13:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729171208; cv=fail; b=p3OwQIzHxBukeshc27pl5I1ujjZymHLVT7mhYFlsDM4x5eplOsXixFFQzyANwpZ+gDXW38/pKAgvY7JMY5uZIyXWgmngX9Ws+17lHJhJnw8dRIorjfnMVyA71CGzSKnpnGVzvcKtnZ4vizj6AtZ+rKLVM3bR4EmoSodkyR1XGYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729171208; c=relaxed/simple;
	bh=mauwRmKwJ+adRAUomH8ZJtUIi30K25y7+o8CnNkQ2+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=c+9GmnpIKu9dSvfEhTSWMb2h2N5J/PyTccMOzS9LlKKAUOpte8g7h9xlxfJI0HcYwx3fdXvqfOx8AjL4kmTCGL+RCYRw5LSNwtvdp5uTppi6FQj1fA4W20z0864Jqawc1zwTS6W7UAd6ipd8LIc7WnE0E/8R6ecyr6gmdmv2WHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=ddC03zke; arc=fail smtp.client-ip=40.107.104.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="ddC03zke"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Te+auYg/yocRr1CkPVdHu/PmnisuAOEPVyy/Z0p+kAW3M5Hsn072eknSCqI/4KbWrfQOuwqyOqu3BIzgs2SqUk+foc+QoKlqkIi8VUBDOqp8D+3q3KqTFmULY7sbR/aIVtOmyNAPfJcTm+KoZ3+ZsaWwV6teVo/MzjjT5w7zjU1wqvqa4ZIMpN+/fmUCKaURHyzBD09kZlRJasxO+VxIUqBGysp4OGz45EfTUWeiAHERw7r5S8pxN0BcksMBG/kLxxHMQdl3RMuoS5j6igDwC6xINF9K5L5i24GcWSxqFFoCVvXJsm2LeOYdtH09h/fvgkbg3zEI2WH/LI6CMNTe9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hNk7SD5JVAqdOmX7oQXIwjLhLC1A9QvUhj4+KdKKivY=;
 b=uIVnNe7H6nBHjVm3FCbNRxvchsoszqtiqhfcdXOREPqZnzgHBH/oU43tRfnZP28nqMG2hcImoyIPVwUNNshMNHhXhy3qGsJB58BJu0SDa99Tyc48DHfyBZ5BUxJ+ikOddGhwvNNqs0W6HIvcUMrGeCW/IvTDPdfMKl2Q4TyKnPsXXwe/ev9L5IwyYaUP98dYoF1zwgwG54v8jxfdC97cWSluC0+k3DZsqOax4nJq6UAIBg74UrNPzRctcFw72VaYhIrCTqQPbTYRzAfWZBlE+9Y0/VM3U3dDnO/E/5QPkbmtrS2a0EimEv5L1KYZji8Giq/WwZeMt0aq3h8Uq1gzMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=leica-geosystems.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hNk7SD5JVAqdOmX7oQXIwjLhLC1A9QvUhj4+KdKKivY=;
 b=ddC03zkea8cQxVs3TvVZ3qdijz+bgaEmP/mmkuBYalh3yANDk96jTucN1OChd/4jfbAntECTPEgNI3gN4pO/99HrQLEXt1Uezy76jBF1cUZkFRg6reJZF2FSEq5IHYKl8eYtyPniPI9WJ7pgtBUblK6z7rbfHDB2i3jDKVSDHDE=
Received: from AS4P250CA0030.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:5e3::20)
 by PAXPR06MB8175.eurprd06.prod.outlook.com (2603:10a6:102:19a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.21; Thu, 17 Oct
 2024 13:20:00 +0000
Received: from AMS0EPF000001A3.eurprd05.prod.outlook.com
 (2603:10a6:20b:5e3:cafe::7d) by AS4P250CA0030.outlook.office365.com
 (2603:10a6:20b:5e3::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19 via Frontend
 Transport; Thu, 17 Oct 2024 13:20:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=hexagon.com; pr=C
Received: from hexagon.com (193.8.40.94) by
 AMS0EPF000001A3.mail.protection.outlook.com (10.167.16.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 13:20:00 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.60.34.116]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Thu, 17 Oct 2024 15:20:00 +0200
From: Catalin Popescu <catalin.popescu@leica-geosystems.com>
To: ulf.hansson@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de
Cc: linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	m.felsch@pengutronix.de,
	bsp-development.geo@leica-geosystems.com,
	Catalin Popescu <catalin.popescu@leica-geosystems.com>
Subject: [PATCH v2] mmc: pwrseq_simple: add support for one reset control
Date: Thu, 17 Oct 2024 15:19:57 +0200
Message-Id: <20241017131957.1171323-1-catalin.popescu@leica-geosystems.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 17 Oct 2024 13:20:00.0046 (UTC) FILETIME=[449704E0:01DB2097]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A3:EE_|PAXPR06MB8175:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ecaecfd6-f19b-4072-f150-08dceeae6755
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hUH3C9L6/OqjQOzq3YrqKuynCxfFlFwJB99YXL2KlCg1Hr0YiLJG1nAG+QiA?=
 =?us-ascii?Q?u/iILTN6lfGa1hSiJ6jABbr4ZF6MMB5h5h2zgkS0OSF118eSfJ+MUMJ3IWJ0?=
 =?us-ascii?Q?z/U85iYh0SUPm/lVQeCFEFdrJs/GNC/1hyQWWxEh4wQm1AT8Re5/jMJ/Mhl8?=
 =?us-ascii?Q?/DTXdCL+5ub0rNL0QP9JqJvLVe+is+GvW0NVAYyRWv4s9vQM0zi+5UgO/zGf?=
 =?us-ascii?Q?ruIReXSbN5DDys/xIZczJL1yBaGyg34udl8nS99NVjDh6kh6N0qv0DH4Y/L4?=
 =?us-ascii?Q?6MWqr2V3GajTvLweN6P9e0doncQb3Okt7kuySiKophih8g6paOI/LoNgges3?=
 =?us-ascii?Q?enxg92CwHTtWcx6o/q16I2ou1G/4jLt0UNUUg8F+ES4CPZyLxaGDpNdXg3Pw?=
 =?us-ascii?Q?bjy0xYvmeSuPYwNp8dHVO6COkVn3iiP5v8n7sks8p2FWqoVthBFkksUXbWmg?=
 =?us-ascii?Q?xSqs838/Nu2yWmVR33KEiOZuTN+UvOIdts1AuKsWVLa8H4nmmwuV+2Vu+W5q?=
 =?us-ascii?Q?NWI6kYuQyfrqFSex7+J+IKCSsqcI0cq6IEfhpM2JgFEvVPnCFoZb0VX8DgZB?=
 =?us-ascii?Q?vHNQdGyWKphuIIXXqZUf0OfgbH9UwP8J2JoD+x6Ni7E8qFRBcOd44RJVytAu?=
 =?us-ascii?Q?RXXtnoU6vw/kBkopKwtGgg/RRzglAvCEdkNIa7zqo0Jfyvz9JQ9Odr80OdLF?=
 =?us-ascii?Q?1yi5OMgJC/nqeViFOcARZVN4WOE917Kl/5QL+oj+LhQb1vvx/jQ8Iz//449H?=
 =?us-ascii?Q?2/YidHNrXoXy/fDxqP8s1ZRLTMIc3FjXWdFH2y6ju6cQmBJIcsytxw3aVCbV?=
 =?us-ascii?Q?B1FbM5kmtwIL/ibsVrDzOpEXkXfFU5y+R24ifoPYrnrwsnvl3h7eCu7oID4w?=
 =?us-ascii?Q?orCWgCCPcZgZgxuJDF6JSY0qQKvNbVUWulDkkk3198r3vL8BHIZvw6xrBNBR?=
 =?us-ascii?Q?FyMVmWkiWLKisjd7R6cMgNYypWWH89Nbf/zZWf+n6DMp3rPW70MriEXB1BIk?=
 =?us-ascii?Q?L0TwJvoqPj8ViNLU9Fe44cwTPeg+V82Spm5eHqJEjLrtS0HcAcos+xXcC0ZL?=
 =?us-ascii?Q?0o13o7ztY5vn3zeuGd5WBx0oaTGAmiKG9vPtgNsxOPrIsmi7UQQ2Ds+I1kmN?=
 =?us-ascii?Q?ClrIEs2op4cVeehxroPwZBrlNxcGPipZFfPRoPO5A1FdQLPhveEGHgX8ldtW?=
 =?us-ascii?Q?C1ZWta5B4mUIr6KRHauyhCPWCzRfANxoYsYdDlIeRfzY1XPuxFSCTs7D5BJj?=
 =?us-ascii?Q?uFrYplQIz+bnfwTQ1N/ihVeZ/568MHOoZahmFK62IpYtZZFC8q+QLeqp07WI?=
 =?us-ascii?Q?r1yku61nFAV2T5LcW4OZ2PIZaK99dB4nNtKWRZyIWtBMLofX1ShCUTw4TSBL?=
 =?us-ascii?Q?puZqQRh2PS0+aa6NeTjFSG5aqzAZEhWTkio4hD2Hi2T0he899Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 13:20:00.4236
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecaecfd6-f19b-4072-f150-08dceeae6755
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A3.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR06MB8175

Reset controls being refcounted, they allow to share gpios across
drivers. Right now, reset framework and reset-gpio driver supports only
one reset gpio, so add support for one single reset control. If more
than one reset gpio is configured in the device tree, then fallback to
classic gpio control.

Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>
---
v2:
 - drop DT bindings patch
 - use reset control with 1 reset gpio and fallback to gpio with
   multiple reset gpios
---
 drivers/mmc/core/pwrseq_simple.c | 44 +++++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
index 9e016b0746f5..24e4e63a5dc8 100644
--- a/drivers/mmc/core/pwrseq_simple.c
+++ b/drivers/mmc/core/pwrseq_simple.c
@@ -17,6 +17,8 @@
 #include <linux/gpio/consumer.h>
 #include <linux/delay.h>
 #include <linux/property.h>
+#include <linux/of.h>
+#include <linux/reset.h>
 
 #include <linux/mmc/host.h>
 
@@ -29,6 +31,8 @@ struct mmc_pwrseq_simple {
 	u32 power_off_delay_us;
 	struct clk *ext_clk;
 	struct gpio_descs *reset_gpios;
+	struct reset_control *reset_ctrl;
+	bool use_reset;
 };
 
 #define to_pwrseq_simple(p) container_of(p, struct mmc_pwrseq_simple, pwrseq)
@@ -67,14 +71,21 @@ static void mmc_pwrseq_simple_pre_power_on(struct mmc_host *host)
 		pwrseq->clk_enabled = true;
 	}
 
-	mmc_pwrseq_simple_set_gpios_value(pwrseq, 1);
+	if (pwrseq->use_reset) {
+		reset_control_deassert(pwrseq->reset_ctrl);
+		reset_control_assert(pwrseq->reset_ctrl);
+	} else
+		mmc_pwrseq_simple_set_gpios_value(pwrseq, 1);
 }
 
 static void mmc_pwrseq_simple_post_power_on(struct mmc_host *host)
 {
 	struct mmc_pwrseq_simple *pwrseq = to_pwrseq_simple(host->pwrseq);
 
-	mmc_pwrseq_simple_set_gpios_value(pwrseq, 0);
+	if (pwrseq->use_reset)
+		reset_control_deassert(pwrseq->reset_ctrl);
+	else
+		mmc_pwrseq_simple_set_gpios_value(pwrseq, 0);
 
 	if (pwrseq->post_power_on_delay_ms)
 		msleep(pwrseq->post_power_on_delay_ms);
@@ -84,7 +95,10 @@ static void mmc_pwrseq_simple_power_off(struct mmc_host *host)
 {
 	struct mmc_pwrseq_simple *pwrseq = to_pwrseq_simple(host->pwrseq);
 
-	mmc_pwrseq_simple_set_gpios_value(pwrseq, 1);
+	if (pwrseq->use_reset)
+		reset_control_assert(pwrseq->reset_ctrl);
+	else
+		mmc_pwrseq_simple_set_gpios_value(pwrseq, 1);
 
 	if (pwrseq->power_off_delay_us)
 		usleep_range(pwrseq->power_off_delay_us,
@@ -112,6 +126,7 @@ static int mmc_pwrseq_simple_probe(struct platform_device *pdev)
 {
 	struct mmc_pwrseq_simple *pwrseq;
 	struct device *dev = &pdev->dev;
+	int ngpio;
 
 	pwrseq = devm_kzalloc(dev, sizeof(*pwrseq), GFP_KERNEL);
 	if (!pwrseq)
@@ -121,12 +136,23 @@ static int mmc_pwrseq_simple_probe(struct platform_device *pdev)
 	if (IS_ERR(pwrseq->ext_clk) && PTR_ERR(pwrseq->ext_clk) != -ENOENT)
 		return dev_err_probe(dev, PTR_ERR(pwrseq->ext_clk), "external clock not ready\n");
 
-	pwrseq->reset_gpios = devm_gpiod_get_array(dev, "reset",
-							GPIOD_OUT_HIGH);
-	if (IS_ERR(pwrseq->reset_gpios) &&
-	    PTR_ERR(pwrseq->reset_gpios) != -ENOENT &&
-	    PTR_ERR(pwrseq->reset_gpios) != -ENOSYS) {
-		return dev_err_probe(dev, PTR_ERR(pwrseq->reset_gpios), "reset GPIOs not ready\n");
+	ngpio = of_count_phandle_with_args(dev->of_node, "reset-gpios", "#gpio-cells");
+	if (ngpio == 1)
+		pwrseq->use_reset = true;
+
+	if (pwrseq->use_reset) {
+		pwrseq->reset_ctrl = devm_reset_control_get_optional_shared(dev, NULL);
+		if (IS_ERR(pwrseq->reset_ctrl))
+			return dev_err_probe(dev, PTR_ERR(pwrseq->reset_ctrl),
+					     "reset control not ready\n");
+	} else {
+		pwrseq->reset_gpios = devm_gpiod_get_array(dev, "reset", GPIOD_OUT_HIGH);
+		if (IS_ERR(pwrseq->reset_gpios) &&
+		    PTR_ERR(pwrseq->reset_gpios) != -ENOENT &&
+		    PTR_ERR(pwrseq->reset_gpios) != -ENOSYS) {
+			return dev_err_probe(dev, PTR_ERR(pwrseq->reset_gpios),
+					     "reset GPIOs not ready\n");
+		}
 	}
 
 	device_property_read_u32(dev, "post-power-on-delay-ms",

base-commit: 58ca61c1a866bfdaa5e19fb19a2416764f847d75
prerequisite-patch-id: 0000000000000000000000000000000000000000
-- 
2.34.1

