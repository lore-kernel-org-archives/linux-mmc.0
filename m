Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2089.outbound.protection.outlook.com [40.107.21.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E1815A849;
	Fri,  4 Oct 2024 12:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728043669; cv=fail; b=JmjIYxZRinKpD1OhLv3Z5LuSBSZBCdf84H8+H9aWslCqH3N/0hrGw4dOKWzQ58ngvZ5CC6X2kdc+xysVHpyubB0IaJlwIZBfGgDVQRqIr03I7UkhBnturAkYG5mzL/oLgdnpH9LHbBz31JAk2E2t2I0khYkaynT0v/nMTQuZZ0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728043669; c=relaxed/simple;
	bh=Moj2Oip1PQ8rXBx6SMLlr9zeA7XcM5ORv26+rf/qDvI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iMlgtHv7LKht/Nze09uAcQi/46wtEgNWJMCDbHts3yHfHNxkHbGm1Y90CNKv/gUYwYuoMwsLsLZSwJpyNoF7HGAcjnwUEUTl9/tIh1maE23eiDGzeYNMfG+HNgISNcloIgvR2wDXItxvKBrS194z6nTD+HeYJxm/AP9vqG7abuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=uwOYQ/kB; arc=fail smtp.client-ip=40.107.21.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="uwOYQ/kB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YuiYFquqEFUjpO7um3uPhZuJxYb+DTHsoCKCdtG8DbPfWY4BqrWOqfEfuy1ng+8gvGYhqV0P0D/3OxnRJipZlg9Np+0usIosyInOYhQUJnUzVZAvWB1ZEnRdgjWN3npO0YYJDCpzNgMR+LBGSDCiHWGu0IoY68oU/Rw2slC/HAHTY9T/1ZUZPWAnyoLaSyY1OA0tISnh6SGLfgtWNiYPURd0qZ8Wo1ZANzZsEdpeqoU4R0X7Uo6c4RAEICDhN9lAK8ePff/gX8fOmEbroCuQlPh4x+c3XbPRA87S0M90Y4cXAaeZQQLk31h1I3VI0mYeZyGdRK1NsXNXrmVfrTxX3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RtinHPJCX0Ghf1AHtH9ixH1p5qJwB7vMIjeRtYao5fY=;
 b=eTv/AHn1+ka4EPNmz/SMm2vY2EUa34dpo6XXUMIzOabxyeTn7EGHC3Qyu+ffP96iG7iZ0/UKriGpXpYXMYwLKj8lRWn29vSz4MdELa66h7ikN0NCvno1iK6tOysCvWN9mDIpEuwTBMTJ1Av7cd99U/Z+RdNytPtUKrYHwwvbJKrWAcydJ1Qd0YwTBM/0haDFuj7yhZr3GAY4T9O7hf7E6zOqH1CSPPAkprv3myV61ul6hUVsNCl4/fXgY/uNreRQgCx1CgbnDkXrtwAZuNGBn1spF17HPuQJ7kT141LNP/F9/ZG1zeJRd7KEQhFPgmOm4COFcKfX5Ar6gEGWhj2TWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=leica-geosystems.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RtinHPJCX0Ghf1AHtH9ixH1p5qJwB7vMIjeRtYao5fY=;
 b=uwOYQ/kBFObaE8KzggIfSVK9fr6RfPG++slp667SOdbvavfLgBfutzTuxCMKrq+4MM5XXdR+bF91jUfJcTx0GxpKpKoIEBdLlKMovxdioRdgDG8v5SKuoaY9fTChxBFP4gOqOmJo5++mRO920IOmrPvakJajwX4JYJCtx4C+8As=
Received: from AS4P191CA0026.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:5d9::17)
 by PAXPR06MB7775.eurprd06.prod.outlook.com (2603:10a6:102:157::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Fri, 4 Oct
 2024 12:07:43 +0000
Received: from AM4PEPF00027A5D.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d9:cafe::88) by AS4P191CA0026.outlook.office365.com
 (2603:10a6:20b:5d9::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18 via Frontend
 Transport; Fri, 4 Oct 2024 12:07:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=hexagon.com; pr=C
Received: from hexagon.com (193.8.40.94) by
 AM4PEPF00027A5D.mail.protection.outlook.com (10.167.16.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.11 via Frontend Transport; Fri, 4 Oct 2024 12:07:43 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.60.34.116]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Fri, 4 Oct 2024 14:07:43 +0200
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
Subject: [PATCH 2/2] mmc: pwrseq_simple: add support for reset control
Date: Fri,  4 Oct 2024 14:07:40 +0200
Message-Id: <20241004120740.2887776-2-catalin.popescu@leica-geosystems.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241004120740.2887776-1-catalin.popescu@leica-geosystems.com>
References: <20241004120740.2887776-1-catalin.popescu@leica-geosystems.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 04 Oct 2024 12:07:43.0067 (UTC) FILETIME=[042DCAB0:01DB1656]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A5D:EE_|PAXPR06MB7775:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 02af0b58-1fdb-4f5f-d8f0-08dce46d26e2
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K3jhXyyr/8nt94IoGhplXWgCb0EzvLd5iWA7/ESC6/KnqgD8uNKXe8/7ekSV?=
 =?us-ascii?Q?+wKubzYc0zsSRRaps0M9/BaQIcGwNIpXEOH2ONv2RxhacBTWk/GftB4kljEf?=
 =?us-ascii?Q?pi9p6HzZn6iY9gb+4tIcFozEoW2Niwb+rIDbLFoKfrZnk4jI5WMppYSxf5B6?=
 =?us-ascii?Q?01WHsbpPjfPg5yMdK598ZgF+rqcPB0TxQ4AI+0+fgR1XWLRlLcOBFF5k4+H6?=
 =?us-ascii?Q?ilIamrJgXqe+5PeZOAvUYEDd34imKPB+hfcMTuk4p2n+Nnjs+EzZxTis7H0s?=
 =?us-ascii?Q?tJ4643nmqJ6170H7eQWvBhfTHdXgRWqam0lcBC7RwAHpIyUulSEMSfyMsnNt?=
 =?us-ascii?Q?ZnAVbrwtGMS5LOXFIaBsFfhTa8oij2XZg/HCv4jx0jlOPA31KnCnPQGcDqJz?=
 =?us-ascii?Q?19MmLg6r1GobYEiI04Pe32zgDUn66HgiKMYqu0xvieuQHvKVfSxrvPrPeySb?=
 =?us-ascii?Q?t066ybShVhe6lEuNd7jDrsPZ3owU4c1NpFRktVTT+1AKwtDPv6TENv7H4JlT?=
 =?us-ascii?Q?ixstQJJXwUJU565Wa0WHdZ6V9w5zqFb9XE7pCJtKJ/KRXHu/MgxznSmHmB93?=
 =?us-ascii?Q?tl0GtVrH3hlUpJtnNT3P7xp//6rKtYWZ6C4wQGBvYlodgjXrg+5D2qfNM6yK?=
 =?us-ascii?Q?65v0jrAGJnCA77yyNWpRizIGN378Mr7LAyuNokKRRJ58qtKcNeRVGaiv6O6d?=
 =?us-ascii?Q?LAFWkRz7FTPLmNtV3skkGnSVcGolg8ih4Xi+Omxsm+5OL/WUu/iKQCYjc5cd?=
 =?us-ascii?Q?+ozUMfDDRz+zYxL7qbCA/IlQAaLChvfqVCQZtChz2d9Pv7i8xmDem8LHHDHO?=
 =?us-ascii?Q?zIQlNcw6ecINxNN4T+k4FrMBwbuuRpZs+2i2HDEnd1UM3Y9iYPSkVIF7Yvwg?=
 =?us-ascii?Q?2oS7bw8LOcSo01M5CnwAM+MXyVfa2YNgbjINpMjSjcC8NA4Kb2XC21m7ybJd?=
 =?us-ascii?Q?wMhuI6mIkNHhRJquUPlywkNbsxx+EgfeUMBPIfx5uxSMrn1T6O8zDqVSx3+5?=
 =?us-ascii?Q?i/qC4PThrC5HvDxlQzBgFWtSBC20nyXKvY0eJ48daMfBwehL3pB01e6mdWwC?=
 =?us-ascii?Q?weYMb2yglyLZE2jr4eLhusc6K7fShBid44eRouTqAumg4RuIIfKrWa74465y?=
 =?us-ascii?Q?gvNJojRKxO1A/bNMJ5CxiTGer3WLigYw4uMSyHQ+FUJz5saIwitz65VlOsj1?=
 =?us-ascii?Q?d8npu8WPj1wm0f15n4QceswZde/rL8Eysa2Kl6veLtORiaZMt/phDgUKZVeA?=
 =?us-ascii?Q?NZcDWSVlQuOndS3qedgqhGduwaFZrHdQxWRZmD2tuEcBrpD3oN4FvXsoBqZO?=
 =?us-ascii?Q?pT6I02c3ZI+WEJDGGbQcyuw6/M6F/njlEgUzQ/waAHsemrWpUMwqgVqmY2Vs?=
 =?us-ascii?Q?Ws4VCZ56VdrqK+LDtNTWh+Ij+6/b?=
X-Forefront-Antispam-Report:
	CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 12:07:43.3799
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02af0b58-1fdb-4f5f-d8f0-08dce46d26e2
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A5D.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR06MB7775

Reset controls are refcounted and as such allows to use shared resets or
gpios across drivers. Add support for reset control while keeping in
place the support for gpios. Use compatible string to choose between
reset control ("mmc-pwrseq-simple-reset") and reset gpios
("mmc-pwrseq-simple"). Only one reset control is supported.

Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>
---
 drivers/mmc/core/pwrseq_simple.c | 58 ++++++++++++++++++++++++++------
 1 file changed, 48 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
index 9e016b0746f5..6495b97d48d9 100644
--- a/drivers/mmc/core/pwrseq_simple.c
+++ b/drivers/mmc/core/pwrseq_simple.c
@@ -17,11 +17,17 @@
 #include <linux/gpio/consumer.h>
 #include <linux/delay.h>
 #include <linux/property.h>
+#include <linux/of.h>
+#include <linux/reset.h>
 
 #include <linux/mmc/host.h>
 
 #include "pwrseq.h"
 
+struct mmc_pwrseq_simple_data {
+	bool use_reset;
+};
+
 struct mmc_pwrseq_simple {
 	struct mmc_pwrseq pwrseq;
 	bool clk_enabled;
@@ -29,6 +35,8 @@ struct mmc_pwrseq_simple {
 	u32 power_off_delay_us;
 	struct clk *ext_clk;
 	struct gpio_descs *reset_gpios;
+	struct reset_control *reset_ctrl;
+	const struct mmc_pwrseq_simple_data *data;
 };
 
 #define to_pwrseq_simple(p) container_of(p, struct mmc_pwrseq_simple, pwrseq)
@@ -67,14 +75,21 @@ static void mmc_pwrseq_simple_pre_power_on(struct mmc_host *host)
 		pwrseq->clk_enabled = true;
 	}
 
-	mmc_pwrseq_simple_set_gpios_value(pwrseq, 1);
+	if (pwrseq->data->use_reset) {
+		reset_control_deassert(pwrseq->reset_ctrl);
+		reset_control_assert(pwrseq->reset_ctrl);
+	} else
+		mmc_pwrseq_simple_set_gpios_value(pwrseq, 1);
 }
 
 static void mmc_pwrseq_simple_post_power_on(struct mmc_host *host)
 {
 	struct mmc_pwrseq_simple *pwrseq = to_pwrseq_simple(host->pwrseq);
 
-	mmc_pwrseq_simple_set_gpios_value(pwrseq, 0);
+	if (pwrseq->data->use_reset)
+		reset_control_deassert(pwrseq->reset_ctrl);
+	else
+		mmc_pwrseq_simple_set_gpios_value(pwrseq, 0);
 
 	if (pwrseq->post_power_on_delay_ms)
 		msleep(pwrseq->post_power_on_delay_ms);
@@ -84,7 +99,10 @@ static void mmc_pwrseq_simple_power_off(struct mmc_host *host)
 {
 	struct mmc_pwrseq_simple *pwrseq = to_pwrseq_simple(host->pwrseq);
 
-	mmc_pwrseq_simple_set_gpios_value(pwrseq, 1);
+	if (pwrseq->data->use_reset)
+		reset_control_assert(pwrseq->reset_ctrl);
+	else
+		mmc_pwrseq_simple_set_gpios_value(pwrseq, 1);
 
 	if (pwrseq->power_off_delay_us)
 		usleep_range(pwrseq->power_off_delay_us,
@@ -102,8 +120,17 @@ static const struct mmc_pwrseq_ops mmc_pwrseq_simple_ops = {
 	.power_off = mmc_pwrseq_simple_power_off,
 };
 
+struct mmc_pwrseq_simple_data mmc_pwrseq_simple_gpio = {
+	.use_reset = false,
+};
+
+struct mmc_pwrseq_simple_data mmc_pwrseq_simple_reset = {
+	.use_reset = true,
+};
+
 static const struct of_device_id mmc_pwrseq_simple_of_match[] = {
-	{ .compatible = "mmc-pwrseq-simple",},
+	{ .compatible = "mmc-pwrseq-simple", .data = &mmc_pwrseq_simple_gpio },
+	{ .compatible = "mmc-pwrseq-simple-reset", .data = &mmc_pwrseq_simple_reset },
 	{/* sentinel */},
 };
 MODULE_DEVICE_TABLE(of, mmc_pwrseq_simple_of_match);
@@ -121,12 +148,23 @@ static int mmc_pwrseq_simple_probe(struct platform_device *pdev)
 	if (IS_ERR(pwrseq->ext_clk) && PTR_ERR(pwrseq->ext_clk) != -ENOENT)
 		return dev_err_probe(dev, PTR_ERR(pwrseq->ext_clk), "external clock not ready\n");
 
-	pwrseq->reset_gpios = devm_gpiod_get_array(dev, "reset",
-							GPIOD_OUT_HIGH);
-	if (IS_ERR(pwrseq->reset_gpios) &&
-	    PTR_ERR(pwrseq->reset_gpios) != -ENOENT &&
-	    PTR_ERR(pwrseq->reset_gpios) != -ENOSYS) {
-		return dev_err_probe(dev, PTR_ERR(pwrseq->reset_gpios), "reset GPIOs not ready\n");
+	pwrseq->data = of_device_get_match_data(dev);
+	if (!pwrseq->data)
+		return -EINVAL;
+
+	if (pwrseq->data->use_reset) {
+		pwrseq->reset_ctrl = devm_reset_control_get_optional_shared(dev, NULL);
+		if (IS_ERR(pwrseq->reset_ctrl))
+			return dev_err_probe(dev, PTR_ERR(pwrseq->reset_ctrl),
+					     "reset controls not ready\n");
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
-- 
2.34.1

