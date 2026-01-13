Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011020.outbound.protection.outlook.com [52.101.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDA42DFF1D;
	Tue, 13 Jan 2026 03:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768274182; cv=fail; b=PCuTCRvQZPYe++Dd3xKI+joa6Pa9jP9JlbT3obfUYE0Y6N4E+mMfM1k9vQgW5OGNK27VdW8JlVRW3wmkVytxMvjxomybLrB/iHGd32vcI7FLfUlHT0X1CZ3pgBWcYBy0i5AFiKqlO1DA8fMwPGvL8KTj6TXGJTCJOAgpPSARBUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768274182; c=relaxed/simple;
	bh=Q5h/7NKFLKdnEwdawLjx++jqt+9p2wYgiMy5kzq7V94=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=d66csSEdIr45OMzGXh4h4UMGqrrx33cP9GSNCL5WHl8nv0qOGAwL2IqRtToQWIPCqpcIDrGp9tISlxdFUOKZPZYo7w+jicNc81k3VTqrahGN76kr22b8xN+P6VV5VDaQIVnY7/r282e8TZBVnj/a43DAEbMLRnMurywYkVQ1v7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Us/RcK7B; arc=fail smtp.client-ip=52.101.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Us/RcK7B"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SsrmoLT+vX620oEe5MVrqNLQVdIuhxmnjlFokK7J571jCMRqfVl/v+iUdg+5H9MNiyEP3p4MCGuSQZxc7qJlI6oFLiGdUXMlyp/UQX6IpgXS9zAWJd/yQw1025ESGLvvusgEKd1aBIITFdEA7A0GzoM5FFn3WFzxPa386UYdvpC7Y/rEVZeLOIdeTISlAOQdk2ilvjgC63cTQW4C7AcUQEERqNTZcQeNFf6I6bsgL6370rU44ZdCpKGj8acS0/VMWZ6NHlWx/fCpT0Bzd26EK7M+CvsG3Tr+GRX2668pVearwGMvHvVGl0RLf7S8snHKlhsNpbh8DCg7fz2/5EQ/jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K3cvqK1tr/BF6x3Sfyr9ppLX6qgOsaTKv21ieK/uX50=;
 b=IJxJrMjnRUV7XGZWVHj+9C4i8gM+eb+Eoj7+lo+IUlIzsYUSsgwTbiabnAYzhrC9LSiQqo/v9ZGMoNSVjopvOm4nbo+HEOQWb6UW3wYZHKqYusU3/8NeyiBK8ohZ0LculymBFGTGZlocA97vNpB9TDlCuSV9jHhm5MuccBdLHda4Os61v6pVwpQ8YGeP41AIwr+Z78yzPb89LgHFh4uiNyccUoRw+ZTDxUG07GHXB2bTmpr++A/dT4k9lru4H7BOZanw8uwp6nEhQ6TyJbdRbr+FMgYMssq1XG8QVdaVsjf+4+HeGk1A7ioc3b9K6yiH7iclQFh9euFYOJg6/ncapQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3cvqK1tr/BF6x3Sfyr9ppLX6qgOsaTKv21ieK/uX50=;
 b=Us/RcK7BhahaTMxfb/AZs5qoOBd3tERImNYmUY4Ctwr5YkIPWfEI4RWaZjUIKcAzPycVv4hUyTaRqoWTuSYi/YiVlftxR0GQ3tnhcViJXdbbXCDc/3EYFmCiXPGEhmbF/Mv+WwuAw+6RmlaDREFwKwprlbqKDzBAu1OFbwEIBHaRX7zb3JMzeHkut6RzeNsgBee9x03W0CCTVAPVKUE0MBRAETeEP1xjrp3VrBuD9UEQyLraX8hzRPH2ZNml3UaOX/0N5wnb9MisMdVxLFcpZMJGhGtwtjn10qDLpvmkIzOFTVrk1Mmrz6kOfKVOHFRl5Aal4zmv6rDt/lfMrSK6pA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com (2603:10a6:102:2bb::13)
 by DB9PR04MB9282.eurprd04.prod.outlook.com (2603:10a6:10:36e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 03:16:16 +0000
Received: from PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b]) by PAXPR04MB9255.eurprd04.prod.outlook.com
 ([fe80::1eb5:3ebc:9f11:f20b%2]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 03:16:16 +0000
From: Jeff Chen <jeff.chen_1@nxp.com>
To: ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeff Chen <jeff.chen_1@nxp.com>
Subject: [PATCH] mmc: sdio: add NXP vendor and IW61x device IDs
Date: Tue, 13 Jan 2026 11:15:17 +0800
Message-Id: <20260113031517.244714-1-jeff.chen_1@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0054.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::22) To PAXPR04MB9255.eurprd04.prod.outlook.com
 (2603:10a6:102:2bb::13)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9255:EE_|DB9PR04MB9282:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ad6dba7-98c4-45e6-aced-08de52521d29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|19092799006|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?shfBbOZTPu5N02euKWN0OZslvEwM9u7pXaHHcS9iyJMkFZjgUAiqeDFNdy/G?=
 =?us-ascii?Q?PLLSeQp0RGeXoiuyJbP7+Wp3922a5essF533qCHvU5gfa1zCUPHf5Na40OTg?=
 =?us-ascii?Q?ITfG9r5et0NarbzlCEvOmp7S4w/DkH7KWUxtZwQvTSVmZCkWbPLLAvFzxK5r?=
 =?us-ascii?Q?5Gx+RWpUyCIcucGQ4LZNAY6Lg3UVDOAUbWNI5ssfov860KnqbPqHl8rMp1eA?=
 =?us-ascii?Q?T5OHGwEb6LK8cDAtmUgskpqmuzMQegRX7EIKILwQXPg+6CwQ9deGfl3WVH5z?=
 =?us-ascii?Q?QZaoAi6+Q8UQdD+6b1GSHvxAT9znc9G+8FNiPKAdpuKtZsxUud0u1R7oTWSb?=
 =?us-ascii?Q?eD+6+B6n9aNRsO8rpLwHvCBzdDdtJllcsH8zhn+rau5O2Yw3squWa76F2q/c?=
 =?us-ascii?Q?N8C25PEDnEEUHniqr6YFfg0sxyEdOsGEKZjUuEyhbWyRlxko9byGlHCjz6H5?=
 =?us-ascii?Q?O1OIUY3pLTZZw0bH1RpSd2D3hZfTZxVAee6ai65ZpAUEK4mL2Qv/eGqJCgsY?=
 =?us-ascii?Q?0c95woY1DSPDYI2nGSSyM/Wj90RXGiIvCBbuHjihiqSDbhXp4QsTy+IiGhq5?=
 =?us-ascii?Q?l9sckc7lP9kvGBJen2YKb7IweIqxFizS2xmV2hed7IO8Ij4N8UXWgGK3xIww?=
 =?us-ascii?Q?HeUlCWEd+OorIfMh7DiWyP/KI1RmUh21ze86SatGpB+hp0HhfTMxiwD48pyD?=
 =?us-ascii?Q?0JSL+T34SFXGJ+5iOQfUAb57KqOAQnaCZQeo/IbmHQRuWBctFq2pETzWt7fQ?=
 =?us-ascii?Q?bQmK7Uh+e1ZNlM68oI+9Ewdk9DHYzJrjOM1gjwO1r63rcyLC8SB6cN6HASaV?=
 =?us-ascii?Q?APdXQKMiTKfwOZYqnTW+Axs6ZcLZqOEl5xDMBskKm1xcRXTGqgaNyrypJast?=
 =?us-ascii?Q?PBsK/lHDtMcYcck1OHuhy54BT8KbJi3HkdRoZTwvrUgDumLTsby0Xc6lBSAz?=
 =?us-ascii?Q?U9A9iAuR4wADD888wHFo9o1rxUATCGMSGkPAJmFOjDZ46IZOfG6BJpugkPWR?=
 =?us-ascii?Q?cWmR5KoGMoNVtLKtjuJnZgCFtxOuQRL6Q9YT0njnFjAKFKA8WCsuwKV2cqO0?=
 =?us-ascii?Q?3GbtpBG01xDwS5UFU0ZpW+M0rAtCu205sFf4N9F2S8NXjTYQ9XTPsYpEQSvk?=
 =?us-ascii?Q?oXXE/iSxUOMPEJhx7dfztifX/r4gJRkB/iS/0fdPIRrTLVlIptE5GwJZwm8h?=
 =?us-ascii?Q?9aKITOmLViO6PPSiJENy1YaGJ7Gt3eqqiHpsWlz2mm77ms8DHL5xtd56Wstg?=
 =?us-ascii?Q?25d7Es3l7y27UpAHjAiSPsBD3LfGInmpTMw4uJE0T6iYAj/ONKKnEDwYo0R3?=
 =?us-ascii?Q?1xJ3TOBg0opo29nd4+pDxMCaeAWNzzF+bY/DMmwfWEtRo5koDJ1ZS5oabSGR?=
 =?us-ascii?Q?+0ZYjUDbyfnvPvk/YPV8P1Z1khw+TRvf8ZFoykpKnqTa42yU9ztZp4CDzooP?=
 =?us-ascii?Q?gCSAOFmLFxCJh4PDOIC7SFT8ZIvNiN9eJrgp3hJPEsU5y32HfvgywL5pxzdk?=
 =?us-ascii?Q?o8K9flAjqHCpOqm0luyVeqWj+NK4UYcPWoPN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9255.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(19092799006)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wUKu3QnH+9PX7HhrJ4zUUb/i0U28/eAtSKi3MJcyQj/wsRxt8gWGsPkbOE2K?=
 =?us-ascii?Q?7zmdX5HsXfkutvZTNieVJ0wbc2dStgTio7045Uhz5bGqEaF3AlDdYaJslNUc?=
 =?us-ascii?Q?7LdMU5wLlN+AnwVHo1GlRZjp9byMk5DOoLKirSOj83KFYUzEGYZdh+WIDBde?=
 =?us-ascii?Q?gE3nCIu3sRFN/aCtrM/824JckmhZ0CzYtgvqne1UDBA50W0JxYA6bSVw57DM?=
 =?us-ascii?Q?TpFAx+cU/xGMUogHSqtXrjE5/Mv9hLkl8QoSEGADA3E4FxA5TNWhgQdRKB7Q?=
 =?us-ascii?Q?XKxSwDFN0Y/5uf382q0GjdH6B2/RUrMOz1BgbGPmZsBuOzejLkFjVWVh/yGg?=
 =?us-ascii?Q?VaGEO+WpP7zhfKYn1ceh6gA9JIiOjsTr827VWLLfDEVFyi14D7fm6Xcz2JqB?=
 =?us-ascii?Q?Kq0mdLX0Rm7R/Kd22X2L4G/BPKyu6yWFcdz1pbjOqUJrybsljDtSoTZj9Es1?=
 =?us-ascii?Q?cxlfKvcoFye+ptJzS3QVzTPmOGSoCETUvvW9iLeUEVZlbnkeqXx4oNnVFwuq?=
 =?us-ascii?Q?iPPrQerq5Nsd/W98rNvucEbbe+q+iSLiSu4OQpzEqzO7m3kTcovBzjBgt8pN?=
 =?us-ascii?Q?gU57pkBoY3iwvaMZexwkcU81n/RGyKa5Z5MjnZOmu1DtnRLhX8mJgOJPNh83?=
 =?us-ascii?Q?xzyc444R+e3GSgTcyL/IxQmAnrw54rRL3SwXvdl+m6ptqn2zzxPTyC/ogEn5?=
 =?us-ascii?Q?eRUOFRF+ZJCrEEaIiU+Acvffi63zf39JY4PJEhahJx552ijkJS8U468XYtf7?=
 =?us-ascii?Q?upXzwq/Uva5Q+7plSBJbzjpoz+2ouSY+8L/GvZM7JatQyddJw5+vILh3aVpD?=
 =?us-ascii?Q?D7obLtH/YkYTUu17bf7oKb9c/BX2Mw+9PWFUi5CBdgUcBeSIDyQFfCojZRmE?=
 =?us-ascii?Q?gZMgIioSbsWWYQNMuaYJ3cXnvxeaSA87zTIao5reP83FcUm8iWDPv2QdGU3X?=
 =?us-ascii?Q?QqfKxvhmXjNXWHHhd+/5L8RhD9TXKN+h5wkxJ4hnZ6ss4NjsKPuVnrAZUIm3?=
 =?us-ascii?Q?jK22vNbFkaJvDasnXHNIvRmnE9vILco4T9SwMruKShMYjDTAY7zugd4ZkRyn?=
 =?us-ascii?Q?/3I7f7rLM4F3/9aTEEgpLhnn+S/V/9zh0IGWPEhDnhKlHZMdPV2QMzFyQJXX?=
 =?us-ascii?Q?qKvfx0ENM0YP8C1JrxbDTkxB6hFLKssMFlva3eBs17n7vUI3NhULTA2GiDv8?=
 =?us-ascii?Q?oAoAxO94lMg6lIsVvU6JzpDJcXQeSBVhcjuKi68Uxg5lhxYpgfBjofbn8yWu?=
 =?us-ascii?Q?3zSmkzGXzIcGAlyu7HEf0OpiTa71Vv1li/clT9bpYCYN6m+Dh1GvAREfV0dx?=
 =?us-ascii?Q?7pBjMMZ5Zqqrt81MDzfBnsyX3VzN+IiRJSqhvudPc4pIBJOaeFYn/OAjuv04?=
 =?us-ascii?Q?Z468HXIqrMGCvolncbAWA7iYrqs3gWCF9G209BMZWKF31Nhsk3TGongB6uED?=
 =?us-ascii?Q?QkVzIC8qf5adtU8pb/vZNcPsjjwukiyD4xnWy52FJMxLrirCTz5XtHYrTttH?=
 =?us-ascii?Q?70G1JWv+6/BUk3QRJP/P1cKPntKm87dxcjFn45qwv0cT+AaHcIfZogzMb7fj?=
 =?us-ascii?Q?Z0tRYb5zJnQ/D9gv/vGYOpdBvBbp7JAZT8pHwXSfCvhq2bckD/E2FJea5BjZ?=
 =?us-ascii?Q?wvADFASjxRIiY/g8Eja6Kkhni4Ks3KUVGFbS/nPx005Q9KD9/wj7ConNXxmH?=
 =?us-ascii?Q?s5OBJiKTeC3b3wBGzKR5VmGx1DxJFMIUYl4KxU5VaehAhncsLv6a21dL6WRm?=
 =?us-ascii?Q?0vX8c2EtBg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ad6dba7-98c4-45e6-aced-08de52521d29
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9255.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 03:16:16.6745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W5jDGtrXN704TYNIrPxgKw4yhN7QgpYIVHkj1AB6L3WqiXTnAgojukiE7PqVRZZIaNQe5delKDt0nN2rq4pzHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9282

Add NXP's SDIO vendor ID (0x0471) and IW61x device ID (0x0205) to
sdio_ids.h for future support of NXP Wi-Fi chips over SDIO.

Signed-off-by: Jeff Chen <jeff.chen_1@nxp.com>
---
 include/linux/mmc/sdio_ids.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
index 673cbdf43453..39ac2b612e4a 100644
--- a/include/linux/mmc/sdio_ids.h
+++ b/include/linux/mmc/sdio_ids.h
@@ -116,6 +116,9 @@
 #define SDIO_VENDOR_ID_MICROCHIP_WILC		0x0296
 #define SDIO_DEVICE_ID_MICROCHIP_WILC1000	0x5347
 
+#define SDIO_VENDOR_ID_NXP			0x0471
+#define SDIO_DEVICE_ID_NXP_IW61X		0x0205
+
 #define SDIO_VENDOR_ID_REALTEK			0x024c
 #define SDIO_DEVICE_ID_REALTEK_RTW8723BS	0xb723
 #define SDIO_DEVICE_ID_REALTEK_RTW8821BS	0xb821
-- 
2.34.1

