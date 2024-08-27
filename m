Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2057.outbound.protection.outlook.com [40.107.255.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDF913C695;
	Tue, 27 Aug 2024 07:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724744149; cv=fail; b=gs3nayDjdJkJAAFTS0O2OOi+Z30hwQWDWGAFBFqT44tUnxAb7+HBicEjoBoPra2vlah8a5Uegitxgz3GXhCRmry2Dby0WQz5ljClEM54bd/XnvrFjyte5r7O9z7t7CUcicFFCV5WBgjoPDTfXDgunvaAuHHAUq15c9MJgmKc6oY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724744149; c=relaxed/simple;
	bh=xDvCroMp0aDXU5rUbuguUFC85E8aiQVrM1RYvK6vjzo=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h5IdUPL+WTNg+OUv7GbjsejI4+Dwui3wfJXTHxrGxbPpGH6YVVfe+xHdpahUZaj0eKNX8YmG5Lk19fZ+ceRPSGztOSBIE4W2G6mryRDuGhMiAJfmb9UmC6LPQQ0AMiExPj2PYzG5epgABFGKeK1aozYCgkUbZDtvGcmY5wEK6ZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=P2q+KYp1; arc=fail smtp.client-ip=40.107.255.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="P2q+KYp1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TkazcKgoOm/iaqwfmTxjJy3ELuBg1i3q8l7i19mFJ/jb1KcTzoumGxdugmvjF5dsgFePAMUFsd0cbyDdjrLJ6NyFvDfQ7tTIHzE7nodnqNSXH2hm4jqLuzdLlv+0jbdr66+pOExpNDaW/zeRgh+V2xlyauM/LKc7gHgtiBGWjUmDbUjNsT9JgB9kbY7GCe6qfV5fTM3ZV4AdiRt0cp7E8cqDd4X8ShVzj5elKUpmMomq0jHtnOWAQjizrdvBlpvXnVVV+PdS6+RwQuHeSkVJzDydesK6/qSd4fT+t19rVz4YNEEtXJWDmWEb97cFX7AhdYZz7hkE1MhFZjoXYa9x6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LltO6/GeL5VjOeZSLuuIVsg7yhtwm4dguIk0sohcj24=;
 b=dYyJPvsZUbrVEpP8tWdjo2LLyfL+GssOYCn2fJtODlcHRv1aqhgt0mBjkPeah//rPn4Gi4BKk1InryVbJx+VuYZLvldFBgAtCLdmVa1LMpLRRIsXeeoeGwJQVMtIFQD9FUIgnSkD8IsgXJKG4avrx3HT/IMg8EqHcQLs2qUy4oPAHukT4w3CdXZ62tuUF+IxaH+QIesaB1KR3Y0QRJoipnCtAJj++A4JZTa2IDRY7txBx6PJ0zcl+voPmPDEnqTBmqxUhFsN6tAz4HkD3E9vZqUnZxj3ShUMWuxcvJVyDCPrbwIYfkhfcfigprnJow+xDKbRr2kNviETVi3N4khDfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LltO6/GeL5VjOeZSLuuIVsg7yhtwm4dguIk0sohcj24=;
 b=P2q+KYp1Xu9pR6sRWY+LaedBQKmGgjsySP2tgP8KkaRoeyxy2rSvDV7u3kr3cw0pLLwN+2DrLjVTDh85jjv31RLRKmtaqWHZ644J2djoUaoRWzsynb8V0GNsCs9mxHV2at3hEu4Hrv0Q7yXu8s5kMt0jKU6RXGxL7Msy1grhVzRxNdREXa4aWzflPYXYK50HHwZA0/jiZC9D1Tl6EusCoL4Cxeb+FXsvVBW7/sWUQIINeJc5wDeoZ5mQP6HW1TvPbbwTqVo0T/rRYm43jlEM/QkvvgLU0p8by251CWnfc/NySGE4LhwM1bw+7mhUMgKkNntnHe7gfdGVhlTHIkpmrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB5178.apcprd06.prod.outlook.com (2603:1096:400:1f7::12)
 by JH0PR06MB6656.apcprd06.prod.outlook.com (2603:1096:990:2f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.22; Tue, 27 Aug
 2024 07:35:43 +0000
Received: from TYZPR06MB5178.apcprd06.prod.outlook.com
 ([fe80::f6de:c016:c33a:318]) by TYZPR06MB5178.apcprd06.prod.outlook.com
 ([fe80::f6de:c016:c33a:318%4]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 07:35:43 +0000
From: zhangxirui <xirui.zhang@vivo.com>
To: Robert Richter <rric@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Taichi Sugaya <sugaya.taichi@socionext.com>,
	Takao Orito <orito.takao@socionext.com>,
	Michal Simek <michal.simek@amd.com>,
	zhangxirui <xirui.zhang@vivo.com>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 6/9] mmc: mxs-mmc: Use devm_clk_get_enabled() helpers
Date: Tue, 27 Aug 2024 01:48:44 -0600
Message-Id: <20240827074857.2671808-7-xirui.zhang@vivo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240827074857.2671808-1-xirui.zhang@vivo.com>
References: <20240827074857.2671808-1-xirui.zhang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:3:17::17) To TYZPR06MB5178.apcprd06.prod.outlook.com
 (2603:1096:400:1f7::12)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB5178:EE_|JH0PR06MB6656:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b4d7a21-e3bc-4e46-429c-08dcc66adba9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|921020|38350700014|43062017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oUGHR69KcSfBZ9fXidkc0awaPTcbVjQ4ZT9lR0+gbW+3Jg8vz3qnhIMz5sE9?=
 =?us-ascii?Q?+Jl4qsDX+10K9ysIiGgF727v+Ahgv3RiVOmGL9cY//S7RjlsoaA5LKqwM6y/?=
 =?us-ascii?Q?pG0aiuTw+sPKgQh2Q9/LSst7ZWJDseTGxXVZiO0C3OmZ7P9R39Ga3xMjbAlK?=
 =?us-ascii?Q?gygzjwPurC+5DEROmw0VtOORyQOFPEokv254tWqdxsnFC5Cwr+Uu2YIW/EsL?=
 =?us-ascii?Q?io0LpGW1S1PBfo/re+tQehcjlATc1NbHDv7tbbpjJFxroHIRixKttkcmn2tK?=
 =?us-ascii?Q?YnxTtOOu28yB7mbuupt4i78VFj90mhaMbvrfRXU+WQcbtsicuCGa0U9+2CVU?=
 =?us-ascii?Q?VdZTplLsuyjrrgEA/Xqm5qT9kKOeMA4K7kgGBsS9rTiENKWdmzT4/5IGh/Fx?=
 =?us-ascii?Q?yMzdp/jeC6bbNP/xbXsdHDKhxvTPmdW9sgTWAFL6sS3S32sNqmCo2vSccPa4?=
 =?us-ascii?Q?hmZgSsR0GwZsfFfoqwKRBRhUKdxABZzs8KKu0nr/jiC+q3IuuoNjS6rYrNwn?=
 =?us-ascii?Q?HdJtilG5As1r4qspoD+rW1of/vUtJIkCQ0ZbMStB8zd2ubZ3niJijUvZBaWh?=
 =?us-ascii?Q?sCV3rBZHCo4k+AwbVjgUKhlqpz+ypm537Ms7Anq2nz5ntQDmixb6Fml0EGL3?=
 =?us-ascii?Q?uWNb6WpKMfJ3MzaclW/kpNxKDAG3AsIGQs3aV1ci3oYCnsJ1+8N3TiKfQDKa?=
 =?us-ascii?Q?DYutr5vjiWe809eiITVjh7eW7+ouDgWgofEdTcdU/HO1ciYF2gc2Mdb9wcyx?=
 =?us-ascii?Q?s+2tVfrG3vS66H9QcjSOgKqNwDx85SbgU4aIsBTKd2Vdua5zUACVbE6Y3lJo?=
 =?us-ascii?Q?9DQg3Hgrk3CwgapVGoiYZtuL4/KNq0PCVxvKsw8QVmxY5YJmhtEC+SvbEYIr?=
 =?us-ascii?Q?6Cub3B8AI+JC3Bm/xJg8CJa7u79yOyjZxLb44eYURx03Wim6zgsaUm1T1w0b?=
 =?us-ascii?Q?A93FSjidwXc/nDUUJPSPxBQ6pHFYGpMCC6gXUuxvTfjW8mXloAE4y6eGo4C/?=
 =?us-ascii?Q?A/Nq3AH4RCYtRsgG8dHeT2Fdy0C1XlgNzJ/RZFe8XnvairsWYmEyx3nE7wO5?=
 =?us-ascii?Q?fr59Dm72NPbEQndWnRhH82ZqvMddPusa2E7HdXYwkLgE0RtQOmwMipejYixV?=
 =?us-ascii?Q?H9wJ+2whX6XZlYkma2Hpxc70RDkMZXaI50/qs0Kwi2aZqVQQcr2QxfkksWgy?=
 =?us-ascii?Q?NigOYvgfGS/Le7x2vmfOJOat/27UCVqZ5xNsk+SOH9lGWguDHzQ4VL5LKG7y?=
 =?us-ascii?Q?10ZIdcVbJiWDEiNs1YLLfMKsJW6vnmo1iBBQ3ygok51JJxJ6fwlYfIOABC9P?=
 =?us-ascii?Q?HKpdDPKT96+dj7A5ZV9NvpQtXZHCrZUcVHmarnlifLMT0sINw4JfsduTZv7q?=
 =?us-ascii?Q?YMs/5ldWkoQVF9sQ7gMGo9Drv8SxYR43t947QXfkkRoM/OBnkgQTiaXiQooG?=
 =?us-ascii?Q?vAqAKahjDBpjZ+2O0yo/4/wHzc6tW3RW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB5178.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(921020)(38350700014)(43062017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?syvw0mq39mJfg7RPiKvR28aryT+BBtn2H/rz+eTqZgVHwc/9GWM6PHSs1Bbi?=
 =?us-ascii?Q?hTKHrodRNpKMSQhbZzLakzJ9lD3E4w2SopEYZdYqqR87elsnFPhponEUe+IY?=
 =?us-ascii?Q?r0KG5VJ6AvAcFp+rLOvq3QNvaqhevraRDwhsVGKVInsnabZ9udPZZBa4g2Yf?=
 =?us-ascii?Q?tt/dgy97jKnGzt05QZnQgcriDhjPCUayd8gvhlNbROUzCOsWGv/dCpZafTIw?=
 =?us-ascii?Q?WtLMbaEzgSJTJrxnkadKRi2XOuajEg2kHf/3GhDo6Tm/lg8XDcIoGmRow0DU?=
 =?us-ascii?Q?xyA8lTP7g4R2sU9gAZMeWof9QcFO7nIFGrNCTm4BN8+FVU3WF9c+Ir601x21?=
 =?us-ascii?Q?dCY7y8mMxrtmS2TLGU7oa16VgsxlEQ4K3dvdtX7p7ssvmvXfMttMFL75Y69p?=
 =?us-ascii?Q?7uo6V8W8OGnirdx4Hso3RK6EHhU3bktp+zoY3Kyt/hJ0o7antaBlGkBeO+j3?=
 =?us-ascii?Q?2FNnkqCioGd54hNQotWPpFz/k8gmnHLYCwfsfqiR2MiRVuCJzLcE6UT5xgIG?=
 =?us-ascii?Q?lpHjtM/13jnquvc55yqVCugogU2+uZbohHGRZvxA+8doRVMgXSwBKr0AS0Cl?=
 =?us-ascii?Q?cIanYxGzL2mMhvc1twlXEcrtkQhmdNRPE9rUeiKPAz0sh9iCAt7N+7JLCYeA?=
 =?us-ascii?Q?a75ZlsqJ9fq00w1QofxC2S8cMVYLGa5unDmgFHg5skMMP4QbkRzkkq0kViBz?=
 =?us-ascii?Q?rLyWHwFsJVly0YfAOqZ6LCAm4++Jo7j8C6YBA4RS/sopqTTUl8Iu47340Axx?=
 =?us-ascii?Q?28KqSgXpNUmcCAg8+/ILd+JYD9gRB0zP5f0vHqSszRZCLfRjl4UW+yRptg0F?=
 =?us-ascii?Q?SkdG8MTcEApSufYdM6ZDTBfAPKbcqchYYuRE4RSxeHxM+PPGnzia+LApoyLh?=
 =?us-ascii?Q?r4Q609DllVFEUK9U6UJFBIVvF/yuqIAggXc4EGTJxWGqJIbWxGxFvakcbOxt?=
 =?us-ascii?Q?jx1bBVAjkZC5/tUUM0RmROTTIHWPy3YnqSig0HDd1XhVwjDJ2EovapMXYbEt?=
 =?us-ascii?Q?m+dIjJXeyEdv6UiQEqloTXYvXLI7QYL+yIB4My++UzU94k9IowtiRUGA4EPy?=
 =?us-ascii?Q?g9YEGNUxsVAN9HDiNjy0qL4jSlbVyo9grDOf9um7YDL/7lLVcmfnVfKzWDB8?=
 =?us-ascii?Q?evy0WVYblKa8vTYDGSt2ELnvb3X53k78KDCpPmbZZnK6I/MrHvol0Y+nEypX?=
 =?us-ascii?Q?TcazBz35ctwdJmpsyrMsalZFrsHCbrVal/Uopj6Pj/ozFkbNPhC9JY65Ammx?=
 =?us-ascii?Q?SBfGDqry+C0RIc9xx064JEesfs1DN2PqObMxw6VydxgTIkEjOSpRDYsR+YqY?=
 =?us-ascii?Q?74mBLK0LxGRd2gezfZQqR1SbXyPKWUqS5BohITLrzwVrk5GINGyLwlLTpHWU?=
 =?us-ascii?Q?0DjS+kkKynisc4pGaDDFYPBX5Xyr07YBxk0OvwzRU8YH9ESPKAE9YVFYsLXi?=
 =?us-ascii?Q?cxZAN5SHPRCbUZ2CpTfNDMUBB27DXbJmaO4PYk9ij2LQBPpN0fjhZCKG2oAn?=
 =?us-ascii?Q?XHvKkXF/dudwN/rVfUi5GThbmzKrjcVS3Wq76ByIdf+dAMN6tRMSzzlAygMJ?=
 =?us-ascii?Q?ho5WojwssnY/re4pMN6F1iT49g7pdwT6QJxcI4R3?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b4d7a21-e3bc-4e46-429c-08dcc66adba9
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB5178.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 07:35:43.5203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IeW3m6Ev4ghgwZcpKHZ0CqKWU0S0AIbfqWSrEeh+cGoSmg4pwkqzVtnatpgiwUqeuCxXoRL7sjx3fEB8aT5Elw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6656

Use devm_clk_get_enabled() to simplify code
and avoids the calls to clk_disable_unprepare().

Signed-off-by: zhangxirui <xirui.zhang@vivo.com>
---
 drivers/mmc/host/mxs-mmc.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index 6751da9b60f9..591b5a3ad6dd 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -602,19 +602,16 @@ static int mxs_mmc_probe(struct platform_device *pdev)
 			goto out_mmc_free;
 	}
 
-	ssp->clk = devm_clk_get(&pdev->dev, NULL);
+	ssp->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(ssp->clk)) {
 		ret = PTR_ERR(ssp->clk);
 		goto out_mmc_free;
 	}
-	ret = clk_prepare_enable(ssp->clk);
-	if (ret)
-		goto out_mmc_free;
 
 	ret = mxs_mmc_reset(host);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to reset mmc: %d\n", ret);
-		goto out_clk_disable;
+		goto out_mmc_free;
 	}
 
 	ssp->dmach = dma_request_chan(&pdev->dev, "rx-tx");
@@ -622,7 +619,7 @@ static int mxs_mmc_probe(struct platform_device *pdev)
 		dev_err(mmc_dev(host->mmc),
 			"%s: failed to request dma\n", __func__);
 		ret = PTR_ERR(ssp->dmach);
-		goto out_clk_disable;
+		goto out_mmc_free;
 	}
 
 	/* set mmc core parameters */
@@ -666,8 +663,6 @@ static int mxs_mmc_probe(struct platform_device *pdev)
 
 out_free_dma:
 	dma_release_channel(ssp->dmach);
-out_clk_disable:
-	clk_disable_unprepare(ssp->clk);
 out_mmc_free:
 	mmc_free_host(mmc);
 	return ret;
@@ -684,8 +679,6 @@ static void mxs_mmc_remove(struct platform_device *pdev)
 	if (ssp->dmach)
 		dma_release_channel(ssp->dmach);
 
-	clk_disable_unprepare(ssp->clk);
-
 	mmc_free_host(mmc);
 }
 
-- 
2.25.1

