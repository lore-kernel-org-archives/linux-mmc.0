Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012021.outbound.protection.outlook.com [52.101.66.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DF83A63F7;
	Mon,  9 Mar 2026 14:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773066878; cv=fail; b=d7kNxZUlBxVk7mDx6Z3rlhAwKjFCBdi9+aI7TGaPgdTAdDhJxYFrlesVaCZKfDoYhh6YENSnccQw9nxUIVFk+QBxeBPdOPVMFc+m67TOfUXk4NrVAI5ErFaCPltloi+y2syS4Wu7yVzwyEdO/TxUTahlFwoI5l7Vm98mYI1P5kk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773066878; c=relaxed/simple;
	bh=srwFOP26/LhqQeGngdrZr+PQkMzumgbe6HCaVj3XMbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G+txGBM4FuFV7ixr6OS6+dtCwBxyTrMRi1ZGN4dwouh5yWSlFWCyg6TvfpcA8Ne4G5oqXquq3ko63YbE2Yd4aEmccNunYWtDt668/IkZWhezfF2hJwmibpITqmp/h8YylrNBPpieX1qEvcDI9O061r7gbP/rql5osbpN0MYq3Uo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=fR4+HAMx; arc=fail smtp.client-ip=52.101.66.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="fR4+HAMx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v5zKwJdukU8AHexdgmXKRJl5nEhWttZ4KLIm2JffEKjckuK8jT+iIBZX8rMBnR6muWPaSz3v5mq+d6o/7vhtydMD2IQHF4zxSGvnk/JxSFsXYmMDJOhS5tV/IKA43NpuPuB2u9FtfyzyPpUr0W2F/V2uOW3LUvFldXG8uQFPnwFKeP4P8uf8k5Ug4RpwgH/qnp31kGhfWL/aM9awmQVlVcKUSRbJvlBpu7zbkSJVTxVexc6mBT6NuECYcFV98Cf11ZVjdLhwxctUH+4E883nIwEZ0aXnkXlsGRIFcmoG0Nk/v6sMCaFheD8EUlp+hqEIQQyychfqfCE0y5T6yH7sOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2f6tJDxO+YDBxoQ2sgE9H0AbR9iXMTu4rMgME9tppII=;
 b=IzwmfVkZK1WhCdK7iGqGvcigyfr3OPEiFPxijgS8WxeTE+fihq986GW5HouMqj94auKHASqzX4RYcDQCFcuB++b6uiuMwe2ftTTzsjN03kY5DqsbTBt6fj6HbpEX8/HoA2WbBgg4nRBSI6ZZFt7RDgHttywAHT6zwbQpEYy41rp5dzKENO+lbtcQEVmkPo8hgA71B9Q43GnOV8y8h3FbD+Bcl/po5FMCGsjm1z9zfr4quenSHpcbgGbvhr7iiAhjKWJPSn7Bd8mpE4yNafb7S/uTDKre/skTDzt/EiPNOu1rpdojAkez61jr8mPUPdth420+TLcUBGWWxCpNDLEDlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2f6tJDxO+YDBxoQ2sgE9H0AbR9iXMTu4rMgME9tppII=;
 b=fR4+HAMxLJ1K/dd069pOPhTCJrUDylMTjdRbkBJ7x8tUMyCY2eqfjvWJAUrd6XDaSfKknYKybuqiDTlEhUpAR2DAImuem2Li/rGUtk8828vjHUIFPiX2FeWm7JKKy4mjIpMAMKs/jp14E7N/4xK8Ikwdgb9R2RfGOmNupAMc2tRC8vDiU3gkAPcC6FtHr9uIn6FOfhdRimSjeI4o36GotTExhCZOYJHnPwBpIVuCWO8/33ZUHqLlRe8smtRwZ8M6A3V823+CjAYWuWbaLIyfVYfKflutW7lS0pr3FKHzcJRarHlvcqUgcfyC96uUF/cXAM5X/pPR0rrW2Qs5+51GEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by PAXPR04MB9156.eurprd04.prod.outlook.com (2603:10a6:102:22f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Mon, 9 Mar
 2026 14:34:23 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9678.024; Mon, 9 Mar 2026
 14:34:20 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	s32@nxp.com,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>,
	Larisa Grigore <larisa.grigore@nxp.com>,
	Andra-Teodora Ilie <andra.ilie@nxp.com>
Subject: [PATCH v5 7/7] arm64: dts: freescale: Add NXP S32N79-RDB board support
Date: Mon,  9 Mar 2026 15:34:11 +0100
Message-ID: <20260309143411.8231-8-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309143411.8231-1-ciprianmarian.costea@oss.nxp.com>
References: <20260309143411.8231-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0034.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::13) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|PAXPR04MB9156:EE_
X-MS-Office365-Filtering-Correlation-Id: fdb5bc82-8c26-470d-ad2e-08de7de8f33e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	y0TCP5X5Y4QynAw/NWq8Nmmft0V2tx+21zXVT0MpkeKu1Zp+6SuMyX2fa4wlhsabz8MeeV3Z5ej3cQBG3hF1tRVMdvrKu4ANMyB58yO2gWTEBaaVqfEjGIiGbN/bxrWmAay/qQM7d68FHgQSHpxCFzjAq/MjwWjPVouP67RrA0IQykcXmDqpjZig2UM5NQ7U2FeqdQIeSKz2vtS0KOM5iNfylGuAaSs1Oz4g13wvKtpPDKhOVpoG9c+pWCQOgW9xWdeiSNbgvcUd+39DMObRTWTGv2X0QVb5MyYq6xYnbKSBqxYMYW03pFBPryHZboKCWtD0w+iGKLIZ4EYim10rkEnh9RBonWw2eU9BcISNp6EeikA6BvNSlnxwYhweJRfhwnd/HB3yiTeV+AqdzjPgIo8CPhQG8iKYic5gYp5/p2g8piuHR76frpNLSKQuZfSrZrampiHhhD7gxSJVHqtivTsw81OVopM31vEGxTJPC7Jc5XYBI+031n3Xosf6NlVDPH21Fl1zs7ZnTZvgEpRHoMINfvL3R3FO/Uji64PTJpSo/Kd2el7VgNPNeq1q/l17r680SMXAl2HnyWpZdFYFSWCAeaM87AmjpPypJbmyjHkYtpOWA75gmiLZkeIWEp0GCGkG6mfsqmdbq7V5+UxRNU2yL/TXKsOQrrIAVD+v2JStQuwEWmh1cTSi94k46X3CF3dbmFVTsisoNQunB2Bhd/zr5mDMZwjSiG/TeTaLBuuAalblEKrSqDUm9PGS+DpbUog4kzD6/0N8OqDWoMoZhh0vnsaa8/+Ok/E9Fja7S14=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SXZ4dDlaSTF2UUw1VkxuNmcyZUxQR0pNY05IWFpvUUlHMWlodTE5cWZXN282?=
 =?utf-8?B?eHlqRmVvZS9Nc0FFVjFISU9LQk5wY1FXenB0YjMweXdZOFdMUU5mUVYzM1l0?=
 =?utf-8?B?SjBOaE5lalJmanZVTHpHazl2VEN4QkRmWnhwRUwyNjcxSHpYWWtXaXFpdGlJ?=
 =?utf-8?B?YVZhMXIvUlA1NzdUL3BSOEltUjN4Qy9lYWI1cDNXajRvRXQ2bVg4M1FTelRV?=
 =?utf-8?B?amRBeVNlbmMyZ1poTXBMRlE3UXJYNFhvT2oyQlFEcXd3cmt3RlovbElwdEI5?=
 =?utf-8?B?bGNveTU2b2ZMUkgyRkd2V3NNeWZRVVcrQTdYSGVPVjFnTzBzQzgwNDlpQ3Ev?=
 =?utf-8?B?Qi9XS2h4bkdUTjdyek1XaFByQWV1MlVvbWFTQ3U2dE8xbzlwdTducXVET0RE?=
 =?utf-8?B?cW51OTFqMHBDRTVaVk1NeXkxUDNYRXBSR29ySXo4YldSRzN0dkFOeGVab3dD?=
 =?utf-8?B?RjhGeUp4RXF2eVp4em5MRDRIcXRYSHpjeG5Qejc2RDhwK0hwelptdHJneFdr?=
 =?utf-8?B?aUxwZFJnVCtoN0FrU1Jjd2xhdlNFV1I5Mis1anNveHlYOURzdFlUKzlSbHVL?=
 =?utf-8?B?eFlSSk9yMVYzK2NSQmh6QVVEOXJyZWFzbTlXRHVBbGQyMCtaR0d6Q0UzMGRj?=
 =?utf-8?B?VHZab2lBVTg5T1JmZWNuK0djZ0pjRGJrekFJa1hISERadjd1WGlMT2h4akRE?=
 =?utf-8?B?WDJMRUdZVHNwbEZDaVpyTHI0TWtDSTV0aDFTaUVmc0lnekNZMzZRdS9welRu?=
 =?utf-8?B?S1NVWHo0VE1LRzBvM2lNOUJORWZIaGZXODJJd002QmorOUszQWdsdDZ3Z2hv?=
 =?utf-8?B?SlRCU2xnMk9aNkprWlh5MlVPMk5oQ0Z3T05rTGpHeDFXWjZiVktYVmk0U2Nh?=
 =?utf-8?B?cUlKZkJDa1VzUVVMNXFXVWVwczdtdklIZ2pNK2Z2ek5wajhDOWVRV3lPRlJ6?=
 =?utf-8?B?VElEanN5cGZRK3g4WVpCRVhyWnZtdmJjS2pZNERWWGN4WFQ4ZURnRHJTMmls?=
 =?utf-8?B?NG9pd3RXQmNXRHV6SittbFYwV0FGemc3TUxtcU9qalJlNFN4bTloNktrNndx?=
 =?utf-8?B?d3BiTzRsbDZEMUN1TWplMHR5QkZuclk1UmtUZ1R4TFRrL1R2NlZSczFwVVYx?=
 =?utf-8?B?L3ZJTjBobC9LVjczYzdtUi9QSGVIWEdEL3YxUU9kak1Da2xseGcrOVc0ZG85?=
 =?utf-8?B?V3lwd3h0cXZzMlRyb3E2MDRnb0diN283dU9EMkRZZGQwOUlCKzJHYTExRDVh?=
 =?utf-8?B?Z25sWG9YMm5YbHd5ZUoxQXplQ1NoT0RGSXFFckZaYVlxdDVHcHQrMm1TUSsw?=
 =?utf-8?B?Y2ZHQVh5Mi9pSVRtRlBPVkpQSlF4aEdReFlVall2ZzNpdTVUU0cramNDUGdS?=
 =?utf-8?B?YlpITmlEQnJFbmJnUDBOWFVXenZTQ2wxK0U0R0EyQ3FBdWZOc2F3TUs3bm16?=
 =?utf-8?B?WkVYZkFhNisxS0JzdGIrZjcyWkhwYkRGek1ET3BndmN5NEo0RGR5TnEwek10?=
 =?utf-8?B?YjBRazAzVkhVbzlsRXZHUXNUV2NZRFZDNW8xWHRUTzFoZ3dnOURIZXBncWtV?=
 =?utf-8?B?ZWI4TDF2Uk91a2FSWDhGRmIzWWlPT1g5SDRpYUdCV2EweWdDSURNUDFPSHgy?=
 =?utf-8?B?UldRSHluTGJnM3BodFlJSytJb21vcGNxZGNRTEFBYTRTamJ0RHdoOEhwQk5D?=
 =?utf-8?B?cGNZYWtuTEdXNkhVbC9IN0VkRnJ1ZnhIdC9FV0h6aHJGbWQxMHRxWTYwWHZH?=
 =?utf-8?B?RE1JdnZMZU5ieUhKTHozWHV5K015aEcveGgzVTBkMGliRlh5VEhwOEV5bEp6?=
 =?utf-8?B?Zi9ZS2Mwc2kxRWc3RTJQQjRYNDNXSzhCYnp1OWc4b2NVZERRcWQvL3dlSVZR?=
 =?utf-8?B?cFA2bHdpd0owOEhJYjFsZHVpWm0raFc5eVpBL1g4YjJXRVVTaHRoN1VmQ2R5?=
 =?utf-8?B?dDBtYTFOTlJFdHduRTR4bVNVZDhqamk5RG5xNko3ZGVjOThvR3FoOXZyekdt?=
 =?utf-8?B?aGluV09kVllsRXE3SC9GNVVaN1FrSkVSUThoSHpmWTR0VlBUdElITkhRSDBX?=
 =?utf-8?B?emgrWkx2ZnZNc0lMbzQrSVNaaGJSY0MvakF1VkJXQ2dNRVc1dlAxUFF1SkNP?=
 =?utf-8?B?a2RKWkFoUVZoUUt2aVBjdjFNdytIdkdvSTY3RDMxQXE3VG9oUDlMY29mTUNx?=
 =?utf-8?B?TFFoS2ZsMFVCMkVFUFFTQ29OazM5R0RBRVJpc0Zpa0tpYlBhTXdTVkZJd2tN?=
 =?utf-8?B?RW0xVVpxREJPYXRpMW1oOHhyVm85MUtpWEx3SVNBQXBPRC9DemtLL2JFSXl3?=
 =?utf-8?B?bmlwalIrc1RLMzRMMEJMditYVUlycUptUDA2L0xJWWxGeFBxV25jcWZVUVVl?=
 =?utf-8?Q?xdMSY1zh+KJ8ybAE=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdb5bc82-8c26-470d-ad2e-08de7de8f33e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 14:34:20.1740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6zFjOmfYf7mkjYll8mfRbtk9hrCoCMDlbOLjqM1SAZlhS/p8DaSA3eQgrL3p0/jb4v6L0Ox/n5/StQGuSjvl9qNss2F40n2IJC7wYSJFuN0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9156

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Add device tree support for the NXP S32N79 Reference Design Board
(RDB) [1].

The S32N79-RDB enables the following peripherals:
- PL011 UART controllers (uart0, uart5, uart6, uart7)
- uSDHC controller
- IRQ steering controller

The board has 32GB of DRAM memory with 28GB usable and 4GB reserved
for ECC logic.

[1] https://www.nxp.com/products/processors-and-microcontrollers/s32-automotive-platform/s32n-vehicle-super-integration-processors:S32N

Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Co-developed-by: Andra-Teodora Ilie <andra.ilie@nxp.com>
Signed-off-by: Andra-Teodora Ilie <andra.ilie@nxp.com>
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 arch/arm64/boot/dts/freescale/Makefile       |  1 +
 arch/arm64/boot/dts/freescale/s32n79-rdb.dts | 70 ++++++++++++++++++++
 2 files changed, 71 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/s32n79-rdb.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 700bab4d3e60..e79807bf1820 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -501,4 +501,5 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mm-phygate-tauri-l-rs232-rs485.dtb
 dtb-$(CONFIG_ARCH_S32) += s32g274a-evb.dtb
 dtb-$(CONFIG_ARCH_S32) += s32g274a-rdb2.dtb
 dtb-$(CONFIG_ARCH_S32) += s32g399a-rdb3.dtb
+dtb-$(CONFIG_ARCH_S32) += s32n79-rdb.dtb
 dtb-$(CONFIG_ARCH_S32) += s32v234-evb.dtb
diff --git a/arch/arm64/boot/dts/freescale/s32n79-rdb.dts b/arch/arm64/boot/dts/freescale/s32n79-rdb.dts
new file mode 100644
index 000000000000..1feccd61258e
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/s32n79-rdb.dts
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * Copyright 2026 NXP
+ *
+ * NXP S32N79 Reference Design Board (S32N79-RDB)
+ */
+
+/dts-v1/;
+#include "s32n79.dtsi"
+
+/ {
+	compatible = "nxp,s32n79-rdb", "nxp,s32n79";
+	model = "NXP S32N79-RDB";
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart5;
+		serial2 = &uart6;
+		serial3 = &uart7;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	reserved-memory {
+		ranges;
+		#address-cells = <2>;
+		#size-cells = <2>;
+
+		scmi_shbuf: memory@93000000 {
+			compatible = "arm,scmi-shmem";
+			reg = <0x0 0x93000000 0x0 0x80>;
+			no-map;
+		};
+	};
+
+	memory@80000000 {
+		reg = <0x00 0x80000000 0x00 0x80000000>,
+			<0x88 0x00000000 0x03 0x40000000>,
+			<0xc0 0x00000000 0x03 0x40000000>;
+		device_type = "memory";
+	};
+};
+
+&irqsteer_coss {
+	status = "okay";
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&uart5 {
+	status = "okay";
+};
+
+&uart6 {
+	status = "okay";
+};
+
+&uart7 {
+	status = "okay";
+};
+
+&usdhc0 {
+	disable-wp;
+	no-sdio;
+	status = "okay";
+};
-- 
2.43.0

