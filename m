Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012000.outbound.protection.outlook.com [52.101.126.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6182DECD8;
	Tue, 12 Aug 2025 09:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754990962; cv=fail; b=I7YSCbkjlT2+E3Mn6NbjiYTVEyuLC2z6OT6X0qvpejG2L/iDjkiUvDeDo0D4YiyxVNpc3Iz+0OmoTm6Va6M7+C4T7U6UzC5VIcYkkq+eTnsBHfQwr05vVzmR/os+dgci+deS6DMSWFaxTMeMMtc55IYiPH1GQtH5SJsBwY2koRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754990962; c=relaxed/simple;
	bh=gC5stDF9Gn9cN2EZ4y3yUYHvH/FSzyZk4FlvPwUMp9k=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=iFq3hwMt23lXcC4/YRdP0zArIW9SabPz5B3BpyzLna1CFHxA6f35ehWy7LTbMzAX55+XzLgM60jRCeqVk9BH+s2CPt7004ctc8b6A+JciLtbIs3KgfPbQXdLNwb1iPq4DUgdAGdWPwHi+lFX8gdiWX/TEmGYGOiysAY7NeLbc7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=J8PY6pJy; arc=fail smtp.client-ip=52.101.126.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="J8PY6pJy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QLyk5/tN2YoVBT6yoQW2mmwTabwKSYiz6ukULqpwlquH9MKtHYPlA04WLCZ1PFea8HAmj+gUe/8y3Ty/wP3axw5/+ALFEdgKrrOdUDfmV7ehDj7xcCHsdc5sy3FbcoHUQ9/a3MQkA7l3JVn3NRqNhANCuOszEGJRw36Y+nbUqc+PWAFriGM8UeUZ6eHiXARIPSOmAEB/bm+6qFEI0n+TxTpgBW8RaqQQgJ0WTdixNwyu/Q4vJtG5sjcborhfU05J05YixjufmKdHY3zLaiDatDeumxhPLUi0hc8zErUZNF7ao/XSuSaFm4fXT1aU6Vpsb1pJIcLNoCSkAuoIc+6kJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DBKtJYBqwa+t2nbMWusQxJ8DZFsHI/y4b5x0xRlBJhk=;
 b=V0Dmk2UKjhGndpcV30lgRg20GZ5SYP+OFwAEQCd0XSojHUM948JCbu14qysTdyi1q4HegmumWvdUneQoF9oCIFZqU8H9pMYelCB3iEWg69b4VDEGM/YHtT8BctwMIRot9gGwMvg2EfyIVfq3VXNIdtuBMIm2zaHhuWWPVa8u+7+R/QNWJnciI8FXWGyoL79Nid8GfhnMT0K57LxkdEoaa6+OIF5hjAd6gnZziwHhYtY96mxs/9/R0NFWIlsbGY3RWKFvSpkZOyhsQ91hCDthobHybDX+2aXQlaE1V1GfMkMSqH0DIotbJ3s3pzVDXtsRIr3nO6rHAyRownQiwYWpaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DBKtJYBqwa+t2nbMWusQxJ8DZFsHI/y4b5x0xRlBJhk=;
 b=J8PY6pJyt22jZIxcFC8+FNOgnrLerkRmWky7/l14qh1DbWyHeizL++vmvIaGP+4I4Q+Og/G5laIgx9fjjlq1l1vnDCIgA6PQX7YYWucB4ARoqFafR6hu21q9Vx6oynI+SoUBfyYmBBrYyqXGFEl4W/TELpSxq2H3T68ndG+3XZsmCfYeFUq+JvO0cx+9cTQmIw6vynC+iHp1CKkLv8iJB6eeNQuKZWlUGL9zTzHqL6pIiZGYT28hg5JvJmF9No1x4O3mLFjo8OJ/XjYkwT7tlBTe8SlKVzowRdCOFX1/xMYiT63A1sfIU6E1luFJcSJGggk+a3sigiC4VahntKHZ9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by TYZPR06MB6638.apcprd06.prod.outlook.com (2603:1096:400:463::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 12 Aug
 2025 09:29:17 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9009.018; Tue, 12 Aug 2025
 09:29:17 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: ulf.hansson@linaro.org,
	neil.armstrong@linaro.org,
	khilman@baylibre.com
Cc: jbrunet@baylibre.com,
	martin.blumenstingl@googlemail.com,
	linux-mmc@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH] mmc: meson-mx-sdhc: use PTR_ERR_OR_ZERO() to simplify code
Date: Tue, 12 Aug 2025 17:29:08 +0800
Message-Id: <20250812092908.101867-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:196::8) To KL1PR06MB6020.apcprd06.prod.outlook.com
 (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|TYZPR06MB6638:EE_
X-MS-Office365-Filtering-Correlation-Id: e4637473-3d22-46d9-c3d6-08ddd982b597
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nBHpkgBV3NhA0OJe365rQhIZrXgJJ7RjnKNcFcNN/Axhgq3iWMyYLB217eqz?=
 =?us-ascii?Q?MBDvqxhcJ11BUdxrh27BIw9RLvqSwE643+4NDtsG+jT1Yvta8MsVVZ04g6/8?=
 =?us-ascii?Q?YqjRxXG1mgCYUT+bYIVkR9DgozjqrmEs6niIrqCp6wwcHUC2L6JTh3d+SIGM?=
 =?us-ascii?Q?vwU5ubSA5Z3zzbPQztxFpZZh62kF4/wCSip5sb9qmfHKb/fvdMrdQVaOuTnX?=
 =?us-ascii?Q?ikF2Rc1zLlDRC2oevIzdriqB+3hwbI7RT+N8JQYXQrViFiJPzf3BpEwg0S4W?=
 =?us-ascii?Q?bI9MjUCqF0C5TkWM+hj9+dh2vLKAbP/+Cz5idmQi/Q1iMRMB4JhcnlsnPqqi?=
 =?us-ascii?Q?r44cgPmVZkFGIvBVl0cDa1DDegC4BHaXxrxqhNRBF8TkjaVrj/deZ2n8Kbj4?=
 =?us-ascii?Q?RoFdlNOElZZDE3ZR7gIbwE6m6/SdlJaHoo1yTxvBiyWbm6Zmyo4/mm4pJp8m?=
 =?us-ascii?Q?tzPBG9x/JOfSt3QKtTvy/vEVMnQjLTBFalEPkTfx2kprP3iePJTeZR33BXSd?=
 =?us-ascii?Q?kePxZaLewSqI1ySKYn7wt32fYkC2Dt6DKKN6/fXmxd1AKIY1VhlvF/TNyWpG?=
 =?us-ascii?Q?ap0vxMBvarcTja/ItHUPE+BU+woP1M4DOmQsmFASFyTpwOZREm5Jyi0iA9n1?=
 =?us-ascii?Q?cWAwOAs6VSGRJEAXJ3QcQ22VVx8TivUR8Dp0J4eeCrBXAqEh3CJvkmapDwcL?=
 =?us-ascii?Q?3XJzDpw2JNpBUzyVH7QLuI+x/Qk12qfGd6I+7AWdOTRKZ18/PMcQN8Zo1UPV?=
 =?us-ascii?Q?S3Azr/iQCLx1q0UAg66X17656ElkqpHDkJ+ZjsiRs2uM5zEk33uAKV7JZBUI?=
 =?us-ascii?Q?H6zdElC5IN7hLD13dQXw2n7poAiNZY5hsshtw0fICH+UPfbwB0Tx5g5t4Gyr?=
 =?us-ascii?Q?nD/xb+leQYg7kzgyr/EjucsrhPL4x82WsnBVV7r/ve/FcIAvnHAZzfx6gZsE?=
 =?us-ascii?Q?FuQBmc5qEe8GUHNLLYu21H3ZgBu2zjvemoYjca835H7Rcx6dngjSp0VBq051?=
 =?us-ascii?Q?DFRoIZH2UbvA+b6f2GIelbIemXH1NdK43Ewc0Vjbs55TO8VYYk0FhRkcNXmX?=
 =?us-ascii?Q?8/lzk62mw5vMUJQjXt5DOWzybxLQlpWfUlZJeNsnRcwCfeF3p3TN/S42n5Bo?=
 =?us-ascii?Q?1fBseMyc4vuu6Jrkfb1BF+P6Xr5LTcVKKK/z4Y82lfzyi+nluTaP0XDAP+TU?=
 =?us-ascii?Q?YZoBsou75rvLkQotGhNj4GoXQoHSFnqXdJYOmbkDNdjJkqfbhlVFbi/rtLdD?=
 =?us-ascii?Q?UMWFnbTeUlzkaemdoFYYghcK7oGKrISDEqhOP7kF19wA4NuXvLdmxCZZecs/?=
 =?us-ascii?Q?FIpj8V3FZVX3aTVT3S0uSbtUdcj4WmHPmMUv/mCE9bD2NaFh+MNjGQ1WziNm?=
 =?us-ascii?Q?qGpc3UjOL8EbX+9sG07weLCukotplLgP6U7zec1AtmyDOUhIaPFU0k4ZGf3J?=
 =?us-ascii?Q?xqh9xeY+OcEcbgMv8KTPhbYz1H05l1pKTro36SDFzKCbPBoN+e5Rjw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AQx7or9f6zKENYZi7sn0aynIrqseAviCGoCx01FIx/FKG3AN+k8n0LgEbrPS?=
 =?us-ascii?Q?jjqXdxPrckNqrok7V0jYZybBTk1W0KzvnjV2Xgj1AZi4reObVoaWP+jdVBRd?=
 =?us-ascii?Q?MYstKMvdo8wvVfrFugtDIhQ9nbze/omLhhUW/V8G6L5QFBSjbxFc2O+i3y0g?=
 =?us-ascii?Q?oO5fOQXDT287WxUjiePPuzU5xS4ZpWE4iLQMukB7kIlFtKOhvzDsItRNBOKy?=
 =?us-ascii?Q?A6JuRQYHZjlQ46N8y8pNqkUTr77KKsKTrOgkQpz56xfJ6VR5PJ8dnS9TYkPF?=
 =?us-ascii?Q?ePNKOMxXJkrB0CIkGZ6IzdQaWW0sM7aewe/B1tRYi5evfJtI1UYT+VKg3E9v?=
 =?us-ascii?Q?vIODwxr8GzSF8/2VtY2bBGr9x51rDvapu3Whct/fQrJTdDav2Dp0rXJPIA/r?=
 =?us-ascii?Q?/piFtdHX1LGImZuRc1kcCRuiEB0DUesfHLrVxBJ52aMXXZQ5xtgr936SJ2df?=
 =?us-ascii?Q?y7muXaNNFwlp1sp6aeA5sMyHoAvcM7fxQOTFV3ggqBEKtIfzNEd7gPoFMoKy?=
 =?us-ascii?Q?35nGYh4svye0SEI0G82V/Gq7boIPAk5zk62XZPIBJ+q7Gl1HRpRYtKlU5vcj?=
 =?us-ascii?Q?pAzVFBDrAqKtNuFQq3lvMifwbpzoSfRejyGRWZEWgX2CIhUiJ7q0PFrFlgEh?=
 =?us-ascii?Q?hLsKfq10NG948MZfyNrkGI9Ph+eCBhpZ8bgPnIgV7mgzX7V9fiyWt6FhvSXz?=
 =?us-ascii?Q?7tRuqnG8HoNX2DUdJjUUPHJ8S5U4cxb/kKVeyiINNBkr3EeVa5Ln6CgmojBU?=
 =?us-ascii?Q?6T6CchrEexss41KMrIY9UYpgbPmOK9tphiAu9mDIZvI4iPtICY+hZE7pD1zD?=
 =?us-ascii?Q?gtgW1o055gqUPcdfsdWTPeFis7xSf2Vd0yI268uCxlcxiu2UcyoMuD2t242a?=
 =?us-ascii?Q?ZtX0hgIxDCzeOCXZ3sPPv286PZ8Q+g4Qhu30GQfUSGI2YF2AxuBSjNdSu5GD?=
 =?us-ascii?Q?XnVlRcONyaBbnl7RQp98HCbvfJoqZ+FUGmYSfihXNkNUW5Ppi3aVpOMp5pPH?=
 =?us-ascii?Q?XjJ7DgLjrTjQtHTIkU2FCq8Vn1dYqkMdnN7PKOp1fXKhyxSHdtMJMdNma6EZ?=
 =?us-ascii?Q?mt82a8c37IbBGsSEt56Owra2lwpBNHi1etA0F32UFVOi9nLuVOt3wHG/zfek?=
 =?us-ascii?Q?VjU1Ct2bPRDFsGSt1VaaMDBbNHUuNsDGQtxP6x9d7shYaDVjPXyhf6Jr+p/F?=
 =?us-ascii?Q?HJG6klpLt4IeodWXMwxD1SaYcZHkAuvLYLA6cgSgYIYbxu0uFtByEvSkfO7O?=
 =?us-ascii?Q?x8rvbaRtvikKYPeuhHthD1SD0MW3U58Zy1XQgBVhnnU6OMX0uFFiJFiuIpnf?=
 =?us-ascii?Q?Htw6PXg0NmC/6m+4cVYqcrOjpwwxi0JcyfU3GD/8RxXceSbIMgFPOuN8wAk6?=
 =?us-ascii?Q?x65yiqk3VFb/fspDQrftuZTpnFwH1t7FM/rH5LHLLqBekYOG5vjn+Y+dTses?=
 =?us-ascii?Q?HfmKTun5wBdLe7Qkjahsw0dIxUiBCF6drYM7KyNxyB6vq+nYkAlsf1VCO2re?=
 =?us-ascii?Q?xtUChJitCzrQUIXpEjycJ7p16pu3PIj98/gseGxujIbSifaw29j4IgzBSIM9?=
 =?us-ascii?Q?OpdKT8woT697sTJB00aQFuqr70l+dV8MvasYMb8g?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4637473-3d22-46d9-c3d6-08ddd982b597
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 09:29:17.6642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Gc/7EqofXVjzOiGcWcAvfRpefPiZTQ1kA9C9eQPsCu+9XrmnChqH1BjB6+VASjJ2rm9+REZ21RxfO2I2ABmVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6638

Use the standard error pointer macro to shorten the code and simplify.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 drivers/mmc/host/meson-mx-sdhc-clkc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mmc/host/meson-mx-sdhc-clkc.c b/drivers/mmc/host/meson-mx-sdhc-clkc.c
index cbd17a596cd2..6d619bd0a8dc 100644
--- a/drivers/mmc/host/meson-mx-sdhc-clkc.c
+++ b/drivers/mmc/host/meson-mx-sdhc-clkc.c
@@ -84,10 +84,8 @@ static int meson_mx_sdhc_gate_clk_hw_register(struct device *dev,
 		return ret;
 
 	clk_bulk_data[bulk_index].clk = devm_clk_hw_get_clk(dev, hw, name_suffix);
-	if (IS_ERR(clk_bulk_data[bulk_index].clk))
-		return PTR_ERR(clk_bulk_data[bulk_index].clk);
 
-	return 0;
+	return PTR_ERR_OR_ZERO(clk_bulk_data[bulk_index].clk);
 }
 
 int meson_mx_sdhc_register_clkc(struct device *dev, void __iomem *base,
-- 
2.34.1

