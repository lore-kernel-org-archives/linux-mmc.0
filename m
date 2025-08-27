Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012019.outbound.protection.outlook.com [40.107.75.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CC63469E6;
	Wed, 27 Aug 2025 09:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756287369; cv=fail; b=aAuUzuKq1Bg0so8FCe4eFhx/FII0kAJ92Mdb7/sIrBRI4JVV6tBYNhnELOD/S01IFmFfHyXSPBLdaLxXg7Vk8lGtfvFtpA5VPhOe3j7+EVweK/Y++JqtUBrvoy+H0S15lnkCf/BNTxoU0jFl+y0ehUSRGrF2pV6gf+5gXT1hLSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756287369; c=relaxed/simple;
	bh=Fzh/RbbnjPBViqQ7wR+ec2P0Unq8VFrGvmOhmxePhmI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MSYmLt5di5M0Pj6fkC0k0TlsbRvwSchLMHFRvLrx3ILpR3Kk4liDJ9zhQ/SAmLZDvFFdtAUUWiPY2+f1O1hy5oLZr8VWzxlPkhaC14Y1wkXhnouxTwM9wsw29mDthZz5bHn2k/vR/cihyDhGJjKXabGaRI34GGf0g9UhuotNKgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=OqQ4lUh+; arc=fail smtp.client-ip=40.107.75.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="OqQ4lUh+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t1QDeBWroIBQ2o0qwXWHAE5dmwXba0RmUjjSjPy1kcNDFAbQ4Z6D8smWmft9DpHQhhV8GbGADQXgfU/n3sQED5SdCgbXHuTWIbFDYMIlcpTNhIbRGVKk28hivcQgX1aHjKsXrmcWdBP0309oEjHAa7DClIMBO5v/8L/mbkOoNddpaaTXMpBXFHLOdWbWZFbRWJ8y65UlJKWoLST/reMHfXzdkMqApoBsY0E9kvPVrgn/uo/6pMuYsMXQ417+VQCst2jK5Dis6nROsiK5e4zNzfyYY4YTTZsHgdyaWefbiyhhZZ7628ZpLK+QsEzjqkCjGNSQsWsM6sKeiaGNU3GZbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zy5fSZE+h0sY5yQJkEK1ebT5nqmmH3/ua6k2AbteaL0=;
 b=SI/LYwUDnDcRX/vz6AUraE8IUvhwikUldMl7qgyDC6LUilsPmW3TZ2+NFx7MSlq2rINqwITEr7o314+na+nTfRm0ucCD3WDwmxw7Zpl2ENCXisZ87cHs32Agq9J4Tt7Pl5OHYV1ZnFXCuQOZC59UTDBydkcKLBg3bRm1E4YAP5SpoAHKbJTpKiUUHnK30yexhU+hZrqgGK48xyKwCa8amzMtKr9COFVBXp/35C/SNm5eTHS1mnvJEXNG3tUs7iW0LXabDCDuOrOUaaUbUu0nuYFmUS/s97b472Xtg9OpFw06KtqRE9yrXvT3tPeRlF5bDc83iJQLguvS5MGvW1QMbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zy5fSZE+h0sY5yQJkEK1ebT5nqmmH3/ua6k2AbteaL0=;
 b=OqQ4lUh+0SJvzMXuKjPKEMr1hEXX2WLw0Au59fFNxVloULpPZbkAzk9RBHm75LpKKmM4jAeNA8VK/mvYn47s29TGuqPpvRSVRfmMI7UTWTS2eT6AT0AJ7XfpKpnPAYk+HMhGmUPPc4xMZ53+zuYS+puxsYggCifq2CnJy3TjMQ/lOXTBnI3mmCioJ4O9WRLOC6Gncp320PWll0Oa4HO9sTTBID5BfFL1RbOPPHKcyP7qUlnhHBGMdo5eLRMaYCjR5eCqfxdr2ITKgym+pONC2FY4SoA0VjMTQqxlV2cR6Khj2pCuaud4dUrowYig/lGLARRbjc1Rme2wBl4G72PSPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by KL1PR0601MB5656.apcprd06.prod.outlook.com (2603:1096:820:9c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.23; Wed, 27 Aug
 2025 09:36:03 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%7]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 09:36:03 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Ricky Wu <ricky_wu@realtek.com>,
	Avri Altman <avri.altman@sandisk.com>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	linux-mmc@vger.kernel.org (open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND...),
	linux-kernel@vger.kernel.org (open list)
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH 2/2] mmc: rtsx_usb_sdmmc: Remove redundant ternary operators
Date: Wed, 27 Aug 2025 17:35:26 +0800
Message-Id: <20250827093530.416071-3-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250827093530.416071-1-liaoyuanhong@vivo.com>
References: <20250827093530.416071-1-liaoyuanhong@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::17) To SEZPR06MB5576.apcprd06.prod.outlook.com
 (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|KL1PR0601MB5656:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a8ae9ee-68a2-4c6d-7193-08dde54d23c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ivo9OXoDgQAfuss9AmFZWKG1UZmqCbaJeGrEnXxaF+Luv2trbfWUBDj14YcX?=
 =?us-ascii?Q?JCRXRpNDos8sa6NWPs3xQ/Zg+SqcUbcLJWVgtH1jWboL8HJ4kIrg5mN19S2E?=
 =?us-ascii?Q?lvskc3wLzQjScCdF9s+nScJtEh7qbdYYKy+3nCLF8LSbG1wBGfSBXTyfWkSR?=
 =?us-ascii?Q?8aWmaFHLZWNQ+o47hnyW1QmBEzfA7x1pgCn1yu9xrlZfzJE7/xjiBOkNl1Zp?=
 =?us-ascii?Q?91tLdPh11AJ1xvKKOEMkSTd1DfoYTFhmnAgk6IEPrB5yWbModi8MFHZmG33C?=
 =?us-ascii?Q?Y1lZwZJP2gGmC31WNR8HJslDVhBUILvKPNCKxcEKsCwH08hxm5Y1dI5aGoNH?=
 =?us-ascii?Q?OsnQlYM12vtNx6f4/dSEYB0qEhsFuxgeE4JpL1LWeNIfwGLHAeHV3aW5pabc?=
 =?us-ascii?Q?7qHLjWY53AqB12kiP2CnBkgEl4eSXpy9RIPOfxrlh9d1HKxOBI0jU4SsSlNs?=
 =?us-ascii?Q?CzKGI7dzaLCAg7am+wMaeISPzHombEE9zYXkCP2W3NB8Z4gSCOqQ+2MGinRs?=
 =?us-ascii?Q?l/upAdNeKQoHcKZQwKz8NeO6a2H8HCUhsw2RUlZnIeYRF5EXl3kuFvb0ZtMh?=
 =?us-ascii?Q?PCgezaFFoz7mdrkrQAVA8WWcNXYEsQw30qYoLhY+t/FwqVphJfIMRE6mUnG7?=
 =?us-ascii?Q?8axsXIdF0RYgqfOtKV0DNkJIMTnmbXnkwZC3oxsANp2spD2Z310bBaMCxTL0?=
 =?us-ascii?Q?XPMOySByM+HRRlftj62MHs6FiMqBVxc2GJFgdsR/HLHDYmDp5euS+S6/j/FB?=
 =?us-ascii?Q?ni/KCf1ukTlQbJZSv7VhzGNBVEBaexHAiCoDebh+lsa/RMYwwREbZDCSbl8E?=
 =?us-ascii?Q?b1fVxPisxukyZdUNAm7sl+FB+T3qptkwXOaIMFj3qEKR9TuaFmqOgj4uMTYA?=
 =?us-ascii?Q?PSDx20TzJLn7fR8r+2a1Ux5XgQKv1C7XrXNZe+dHfQWy5AauoIsZ0+26THz4?=
 =?us-ascii?Q?Sm7zlLoZYCNR4QtIiWZDtqBHB0EjOnq1pnIFILhjGoYY66nzKUxQ0tqRbDkh?=
 =?us-ascii?Q?UVUp3pnMfHV2FhHc+yrR6Qk5qVUbMqycQmtqpYYOGiog5v+d0m0kHhNd2tRB?=
 =?us-ascii?Q?6UKXdXQeEbtiuDR3Kf2KEF18HKIkpfRqd5PCuB52w7XBzwOy+RG42IEgxmf4?=
 =?us-ascii?Q?Z+JIoIfKcoRG/hI1Pt54o5SxmiI6lTmtfCY7x2JRdRkJ7Vo1Z0cXxxwD86o1?=
 =?us-ascii?Q?BPWNzL70f8zLbKr+Cvx+ydf6TsecgS35zRrVs0p4AxuIC4aEm/rzw1Uk8jW2?=
 =?us-ascii?Q?tWN/PB1nSXuyzhFlXe/Rz0yFVSN8j9gRPN16qdEB7Wfj2AoEbvQxVtxWMQ+s?=
 =?us-ascii?Q?/v2FNNSHAzFP1dJqxYiTXMoB0YTAf+y/k+IlC/2Go5zwQBsYRNKcvEv/G8GN?=
 =?us-ascii?Q?c8zReTB8OChHWf+KwbN+pifTr/Og9Qph6z4+YRpzdwi9BWJXdPD562cKq1rT?=
 =?us-ascii?Q?GcBpBdDTz+D0fzABc5+WTMFhJZFJUNwIBC9WKRsvv8qQYF46Tbn0BcdJMS/Y?=
 =?us-ascii?Q?k/8XTY4T00lJAgo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0W8fUXHaLemJOcelbhihBt77etlQNB/W7ohGbJOUsFcUrpUWzdxvRxSZk+rd?=
 =?us-ascii?Q?0NqHO+tQ25F2Y5+2HYule7ZboZ5A6OK+Zq7oVvJYt7Ek0nbLLh1ePkvrurGO?=
 =?us-ascii?Q?3oA//6rUdtYms7TW7GTGiIIMLvR6/KNy8CkEKMgAS2TuGEO3BIzDOgEedGE8?=
 =?us-ascii?Q?GINMfz1294bQvkwRFpccfIdf42+TwkOfWjHh23hfCdL645Cj8yl7o/jULsgO?=
 =?us-ascii?Q?76/QlVUZKEjumOte49lh/wN/TjlwjnVa6b2WnDL0UcQNSyfVr9J1l3X1UffW?=
 =?us-ascii?Q?iRpFYvG5katf0WPwmgYob9/Qh4WIycVHxCdsYkSNrnIcEep5Hs0yQSBaugcs?=
 =?us-ascii?Q?/wzDtgDzxcdijNhLZ9n+O4rbINghEXzkNgkO+vDw++TXJBn0Ou+bz3WQVR1i?=
 =?us-ascii?Q?pEm8zfhsRWtU2vYIwcNVLvctFcfavEzvOjPH1i9RNAzkWCZ7O7CRT+IqX06T?=
 =?us-ascii?Q?nm+J2rQupPrwtKWBK/iDBF3ZjY3hnY1RRQzPfn531TkfjGesmD+RUW3JoJMW?=
 =?us-ascii?Q?L81mFmzkH1jAUuF+lg0ELZf5sE4Ey6WyVPCXJ3QPviF8aSbkCnZbFG5jGwf2?=
 =?us-ascii?Q?jipz8GVCtLXV0UZbtnQZi6r6jGA2vOHxJBur/YAxg8GfqxbuDpjUKXQdeS+/?=
 =?us-ascii?Q?HtCfuP482t8Zn7uzLUQi7duRUMDHsV6T7Vx8YfhhQXaFxHKycoGi2zvDJzry?=
 =?us-ascii?Q?oNFXJmR2U2QAFxuCSnqez9LNq0G6u4WaCuTxj6llNcYucUpqoUe3/jW5l19h?=
 =?us-ascii?Q?P8uVcIF8tUhE3WX1jKLL5q1XGSFdkvpQjBExfZcpbJQFQp8QTlO1kpMgJ33/?=
 =?us-ascii?Q?jLG263tAg6veH/pZMfXcTlddRNjaQuVZns2k1+vA2IiStRUFnReZ4ylQ4TrN?=
 =?us-ascii?Q?5IoZSh0sGJyvXLXqTYxkLuw1aaVSk3qN+ulQPLGHjZLzqygfjV4C3sN/Rgof?=
 =?us-ascii?Q?xLAhB3csX0570aLmpk+egXjlbGdg8/aVclLp2hZ+pivXr03/mAEA/Hzc3caB?=
 =?us-ascii?Q?zEGK9+mSdVDj3geXP7CHtNHJcq/uSYDKZ7bQpx76q5IYYxafQ3GLdc/iHOCw?=
 =?us-ascii?Q?G5L/LZyTNDtexQaeNa4f2epw2X/7GgoKZ59t+D9TArN7XOwYkk4K+aPalYYh?=
 =?us-ascii?Q?HfUElST2bYx04wfLekaWYt1mK0mg4YCbx78o6SKYf6VmeBXhZvvJGIwfJlea?=
 =?us-ascii?Q?IlBZu7Vu77Oher/XZku0OWTXeHaJcYy3Clp6iASrNAhSU/U6tkHBJq5DfCNl?=
 =?us-ascii?Q?IwEZ+cgT+/u8K2Cs669KBjscKM7bwB3+KhsuF81UdUGx2MA0Cu1/4tHG1K0d?=
 =?us-ascii?Q?Y77dLM0+hsec6e6cwYS5scuUgR/SWPFJ/2Oi78yEd12HABPZHELeq2iw7nzw?=
 =?us-ascii?Q?r9oQkvPleSukzs4uwFMwNTMo5xsJVtJLLz7SmBJHcuPPSuZZM52tM2d35IAU?=
 =?us-ascii?Q?3GdinfQGuzWMCpDetkilg1uznr0Mdp445owbfkt7PmQktjnKwiGDqdmwdgDy?=
 =?us-ascii?Q?5MzU5GOxaegqEQ1AYNrbury+7ZP6vGcqiGMtWYI94vJEVqs9xWdU2Gyo55o6?=
 =?us-ascii?Q?pX4MWyQ2mBL5568RA+QKNWAHxOamiclQQReuv4XU?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a8ae9ee-68a2-4c6d-7193-08dde54d23c2
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 09:36:03.3879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NtRWzowHwV7bLxbizCuWwjqnnxl9GrcpEIXEw32c3SIpOJ3v8mymyNGkHL8aGFlr8p0wa2YQ5r+5iSNn7SqfuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5656

Remove redundant ternary operators to clean up the code.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 drivers/mmc/host/rtsx_usb_sdmmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
index 84674659a84d..97bc3a2e3cca 100644
--- a/drivers/mmc/host/rtsx_usb_sdmmc.c
+++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
@@ -1169,7 +1169,7 @@ static void sdmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		break;
 	}
 
-	host->initial_mode = (ios->clock <= 1000000) ? true : false;
+	host->initial_mode = ios->clock <= 1000000;
 	host->clock = ios->clock;
 
 	rtsx_usb_switch_clock(host->ucr, host->clock, host->ssc_depth,
-- 
2.34.1

