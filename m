Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazolkn19010000.outbound.protection.outlook.com [52.103.43.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD292441B8;
	Thu, 19 Jun 2025 05:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750311374; cv=fail; b=O6H2sGrOA22jlMMO0yE4QBjc0gvoCqhXgSUJLQsXvYGiOS8s6VCPmqNa2W5fPC51mZEZJVBtNSy8GJBYVrb1HHHndk2F5vpYAVl5OaGJh+iI+MERVVRQ+vhV0mTPKmD/parv/0l7bEHsWP0g7+p3878vBtwrne7VecLTZ1LrnGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750311374; c=relaxed/simple;
	bh=2JQ4lREyrfUxt3qHkZ7EYw8kXclWDY+L8Zv6tQCwi8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DCyHFkzsSNvAfOtW3/55CThipMvNqPE2rUcU9WxlD6ifxPnM9AUv638akV4jOZKNvXGLQuzpxHH3F2C6aZGLnu1G+fEMzTeF0Z2KSdkfe83C8foqQD6b8YmZjYyL+/TgJbjeMDO3V91KUpbWyZeJupidoo06MWoJlqfCQVidfVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=b7l0SkCW; arc=fail smtp.client-ip=52.103.43.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="b7l0SkCW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z+tNn8/3ZmIjymtjliC6BJ+V2Cw+L4Dtag0CqsKiiYu413nFOjt//G5cq0EUGwQLO7P+vxOFub1SQ5SIn3igEnxV6HKjjb9K/IpHAKuPXzIM5nL2qCJoMnysAVV/mwiYLuWAkQHGfVOrguVhwK++G6NSfzHDDOslSFABMroYMLh2PBH8iisCV/usnN3wkleNfCpsGAcPyidfAWLvinSZUluyK3Ot8dLWk+pbKsrye6kHVDXf8PHj3jdvPsMZ1+MawGX81fAbh338mwR3I56nIwrgnNwgfVGhvQILDQ+WssozmEs4T838ntSFSDHfIr3rjmscpRPdAhzDapTLOSUoiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ekr3/OWtsY9qMAAwR3IBBg5HTEEos/SJMBdxtyJ+oi4=;
 b=mmq7nkMf1teYQ76bwVu7l2w0OTumd5WnQsZ9tXeOTtBJ+C5pLIdx9iZWgfcTO4WHjxsZplhNeOoL2EaERldPKRT8ZfsBfcc26CwfGMjZ6DOjwyV+W1yWL7wSo4xJH6HsEzitNGxVnE71T2xJts4S+2Tp00RQVRFhTNWQmy0J36ePynmBVxHxIMKLXgm5jxH8HwcnKDdYlgDEcFBmr2p3qw3ZyMTA2GyKIQI7t8ooLWFBfsh6xXqN7coNarHdC/ruh240psLzCIee6RXib1ykJRf7JDnuJokKZO/m/zJf7aIEAcwuypUmVWVdO345GQjI8LMJYvQDQztFcTTtyo60eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ekr3/OWtsY9qMAAwR3IBBg5HTEEos/SJMBdxtyJ+oi4=;
 b=b7l0SkCWcQz426HNtccQx6e+0BGDYvsLTlv4UWYlEZVAEkHhvOFwt/IsU4dhJxSWGCGuyYBxSWkGcYrTfmFDsICeXSuvKcFFeqY5kYGNM8YzAKYSfqHymDa08WI9KKQnU3I06OWJ9Wf9eKKM5kVFCjG9ugFm1n8gO390SxCtfflZrn6eDd2E38pmMq8CZoLnKnP25Cw64F/DLv7yK1nNkaqpkE0w0jXtDxj2+QnxoFl2raQqqahwpXIgi3pJBLus4pu0ksLslR+bYLT0kazY4sYFxch8am4AkCiM63eThGJbotBDYHwM9IWKOeTnyibUH6nD7cVo8KNVb4Y5kZ0YNw==
Received: from OSBPR01MB1670.jpnprd01.prod.outlook.com (2603:1096:603:2::18)
 by OS9PR01MB16295.jpnprd01.prod.outlook.com (2603:1096:604:3f3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Thu, 19 Jun
 2025 05:36:10 +0000
Received: from OSBPR01MB1670.jpnprd01.prod.outlook.com
 ([fe80::c00:ec4e:ee7e:9b7f]) by OSBPR01MB1670.jpnprd01.prod.outlook.com
 ([fe80::c00:ec4e:ee7e:9b7f%7]) with mapi id 15.20.8857.016; Thu, 19 Jun 2025
 05:36:09 +0000
From: Shiji Yang <yangshiji66@outlook.com>
To: linux-mmc@vger.kernel.org
Cc: Chaotian Jing <chaotian.jing@mediatek.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH 3/4] mmc: mtk-sd: add default PAD control for mt7620
Date: Thu, 19 Jun 2025 13:35:11 +0800
Message-ID:
 <OSBPR01MB1670E289AE4524B7E192E8ECBC7DA@OSBPR01MB1670.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <OSBPR01MB16708176FE57F691359D0943BC7DA@OSBPR01MB1670.jpnprd01.prod.outlook.com>
References: <OSBPR01MB16708176FE57F691359D0943BC7DA@OSBPR01MB1670.jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0032.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::18) To OSBPR01MB1670.jpnprd01.prod.outlook.com
 (2603:1096:603:2::18)
X-Microsoft-Original-Message-ID:
 <20250619053512.14507-4-yangshiji66@outlook.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSBPR01MB1670:EE_|OS9PR01MB16295:EE_
X-MS-Office365-Filtering-Correlation-Id: a78b3da2-cbd5-4ff3-964b-08ddaef331eb
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|19110799006|7092599006|15080799009|8060799009|5072599009|40105399003|51005399003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6/SbD7DpHRd/MI6XHkvfwoQv57Q6qBLXAY/z1tONWwJRnHy3/B55ER1PH9Nw?=
 =?us-ascii?Q?rw+IMz2cGOFLMVk4b9+KnOG+Pu9/HpUNX+ekKcX+BnsjTgAeuaHcIWrdA9me?=
 =?us-ascii?Q?LF1XXfs39nUxgffKfcALnOngqIGWfhvKdud9TurxvJ55+obDJnPsewF98IKj?=
 =?us-ascii?Q?B/fjMsfwnzgj9YNVDAA2Z7SRYwloss9vAw6MVuwA8t2+Ey4dBUA9v7xPmXNO?=
 =?us-ascii?Q?SHcRAytxogoc6ImaMq6hpeedO9uBPLr6nZEQjYIkMm7/+P0mZUCQYvWQjFLd?=
 =?us-ascii?Q?WKuVyDkhv4sVnXtsyyMyqyPI0bMaosN4VJy8mzkqLBEMQRzc4aXpxjOWF/zn?=
 =?us-ascii?Q?ZExtSR6VnS3S2qqY5VCdB05f/Bro1uLP3sOmi4YFI2lze0fTAt/j92gCSIi5?=
 =?us-ascii?Q?Qj2eBdxIaUwVtjauU/6hcTNOMj73ZDSeM4CaFCFZ9WzSHiOtvjxxJpXIgX2/?=
 =?us-ascii?Q?6tnshGH4HaSA4xgnWFCYXebDN66hENWgnsDevtFX9Vnc139JnUADFUgkYDvb?=
 =?us-ascii?Q?+im+7pHh7MyDZj/rTbl2AlsQumIeo5At14Rr7a/40QSAV9Nl0nroyPF3duLU?=
 =?us-ascii?Q?8n6LQVw6xNr8QfrNnDt08HcK0cQLleCcXPRCDlCGKTY1QygEyyWvJ6xtn6qQ?=
 =?us-ascii?Q?c8uaBeQ7y11Fp0gVTTQhFwZ/F+IhecH73P4X7Ac/Q4k+S65VdIx6ILIkHj5x?=
 =?us-ascii?Q?7pILxHKWGW9/nsz3MTk/YQm7DlS+SGcgQPVKKwihyLxsbMPVkbMNvtee1XpH?=
 =?us-ascii?Q?C/gqgU3aqJh0y/JDVlnJlcEVphUuzgTfD0CJEFuwHi3Yx4Pmr8iAjyPl9AhK?=
 =?us-ascii?Q?PlBefi+zharm2eXWb3zIXOWIpFgLAMdUgCJbIDrtRFhSxwo+1yY85tmI3qxk?=
 =?us-ascii?Q?lBRNJAZyfdMlvoLQtyEHJqnVIMUYe1BIe3AI+bl/VJgnGdGDEdUttUU4Z5qC?=
 =?us-ascii?Q?RO/V0+YQ0TvksTvBjP2EGmwPYugs47Bvz43bdy5bI7mbrINCh9EIh4Fi3iJX?=
 =?us-ascii?Q?UfjtkJeQNYTLvZgsrl+hvCq0XxBQ8OjQ9q9BsTEIhid7n/kMDC4vib9APzMC?=
 =?us-ascii?Q?2yFTHAflAdP7GXbm64xmVp6u0vci4LMwDtX+Xn29h6/9ZARwNKH+etLFhlED?=
 =?us-ascii?Q?gTzKM8lCGpMlQU4oo12gO/aMJ3df/lAzY0sb82M8AMIDWFiGcwf1tzgaiwI5?=
 =?us-ascii?Q?q2KOOKWoz/MKLGkwBUMoAbHJO383zg4lkhHH3Q=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?blt9a5HppWENvsKYyYfcxBmHIsVYb3SrbvMG7rwCrHgZb2biYEYFGSojuudm?=
 =?us-ascii?Q?MNS1eJfhlFksyQ9XxzWktCt67YeiEhnOamcyo77Gig4wTlpqPAX1ZudP+PZG?=
 =?us-ascii?Q?t2tNzvQiqOLCaPaZlnw3aFM4v4Yrv3gn3mNGqFHna0oBCWxIe/+/4OA65svS?=
 =?us-ascii?Q?azhhaDa/mXWb7EHFcVZ60+TGFQXw+STMwG/rsda/6zHWa4yYceDv7YzJVX6k?=
 =?us-ascii?Q?sdE6ePIxGTfncQ4G889BAUzaLuR/t1aw1l6cbun+BMQoFiBOGZSMfoyb/kDz?=
 =?us-ascii?Q?c+8mHYhuZRWtIjuz0Jwtl//Yj8JJBrIXb8gc3Xy4T1qKJnv9S0J27UMHIbQF?=
 =?us-ascii?Q?F2Mqk6y+ICI3qvLlIk/352DhIsAR9k1Zzy5wrsOKF/KR86F2kLxlAaKUWtCs?=
 =?us-ascii?Q?x7fLDOVCb28IOW3QfmKSN59me4McOHyjFsd0yFEkYNgqhH/ttr3zLA8h+WEt?=
 =?us-ascii?Q?lKyU8ashjD/zrOSv2AM/Q80UoMmneEb1qmeq25nPOPtjGVY7NH+Iui20oW/h?=
 =?us-ascii?Q?OX6osbbt5yOhnA5KrtygvNbmZN1KE+1vnFVBevYtQgJT9rHPw1meKyhTLBe3?=
 =?us-ascii?Q?D5tazPguIJK2SMdbsriKKkXgtqt9v6CLCL3j+rrTnQa5jmLaS+oPQY8JtsmF?=
 =?us-ascii?Q?ch8YmSIp11AQ4aUsxkWSwCz1Cv6AsVne66PCOMcAp9Tlse9uaEoKPj/ChXyK?=
 =?us-ascii?Q?T5B9YoEMxOC9A8yvVOxZn4yWWqJ7DyIJD5e4ka7RF50yd2aeYKS0vzm2PwON?=
 =?us-ascii?Q?W/nXQ5LEi8mQpdvFZr2lhfbGtccYmRy1pGMfELXmNa+m6PzuHmJTBCs0J8Ur?=
 =?us-ascii?Q?1prUqTHlgmHIl5si/cA7ZdcqVU7OXrYRZj9kFhVvIVBvSSwcuceulvQnENki?=
 =?us-ascii?Q?XsjTBNEhBg3A/exkXViqdqNDkUVpGPSZtYMJlBxWyMcpg/JMMHGPf6Bczv+z?=
 =?us-ascii?Q?bUEiZbunykmObl4psDypjiJsaBqGNKL6LpFOLuS8Uwmavdhh0aGWwkXBT6Ux?=
 =?us-ascii?Q?PgwxJ6J/aD9RAXrUREyaA1kamPhZGqhSgAEh67p0fbLC9BBtWKPtanypjhqU?=
 =?us-ascii?Q?n2AC2u33DovrgUmmc2ZGNI1ynaVcAZecuOg/JWdn5iq3ZbfQy5k9+4HVdR2i?=
 =?us-ascii?Q?atFlHJ8BWcXYbxAyAH+2gyJAKVTlcOorBZHFe3PQiom44t2Kg26spKrcZNU2?=
 =?us-ascii?Q?pTApdXOz6Mejj+Okfv80yKQ3VpmS8/ylM6ViRcA6zzPdNpZeuxTyuqXwkF2S?=
 =?us-ascii?Q?bPJQE3qk/FO4PGyjKReo?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a78b3da2-cbd5-4ff3-964b-08ddaef331eb
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB1670.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 05:36:09.9335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB16295

According to the vendor SDK driver, these legacy MIPS MT762x SoCs
require configuring the IO pin drive strength via the PAD control
registers. This should help improve the stability of electrical
signal transmission.

Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
---
 drivers/mmc/host/mtk-sd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 52198daef..276d4e324 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -77,6 +77,9 @@
 #define MSDC_PATCH_BIT   0xb0
 #define MSDC_PATCH_BIT1  0xb4
 #define MSDC_PATCH_BIT2  0xb8
+#define MSDC_PAD_CTRL0   0xe0
+#define MSDC_PAD_CTRL1   0xe4
+#define MSDC_PAD_CTRL2   0xe8
 #define MSDC_PAD_TUNE    0xec
 #define MSDC_PAD_TUNE0   0xf0
 #define MSDC_DAT_RDDLY0  0xf0
@@ -2038,6 +2041,11 @@ static void msdc_init_hw(struct msdc_host *host)
 	}
 
 	if (host->dev_comp->mips_mt762x) {
+		/* Set default pins drive strength */
+		writel(0x000d0044, host->base + MSDC_PAD_CTRL0);
+		writel(0x000e0044, host->base + MSDC_PAD_CTRL1);
+		writel(0x000e0044, host->base + MSDC_PAD_CTRL2);
+
 		/* Set default tuning parameters */
 		writel(0x84101010, host->base + tune_reg);
 		writel(0x10101010, host->base + MSDC_DAT_RDDLY0);
-- 
2.50.0

