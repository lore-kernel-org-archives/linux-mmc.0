Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013044.outbound.protection.outlook.com [40.107.162.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7E137C0FE;
	Tue, 24 Feb 2026 11:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771931753; cv=fail; b=MllMb8NNcoxuPTmk8pGGRcWMiMDpEGrC9aJL0jXez1IYcWl8SVfPYYpwZbai6mjEkQTqhSiaeH6cfiV/XwU0fjL6RnPDE57cCSKtfGGWBBagkIOaQXfSmuwYb+ZZOYSsbDxmNViSADCRP5mFTWWNQWP1Ls2yT6tBJugzAQnVv68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771931753; c=relaxed/simple;
	bh=5ycXpYLwoo4NovIPAAkqzuuuFcOcBsURSn2X7DKz2qg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GSeYAkoEc6yD/4ICUx6OW96B5JDPALudggwwZA+5ZPgcWcu6TZhwTFfoW9pLvkVEXyRv6bX9L0OnXqF8aCVavz1oq74tc6kD93KThqS/QxJB1cVEIcntC9dW+D9e7cOlPpEbR2c3Be7iDKrrQx97DsvowRB/EGeFtj27/zNFr0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=g+9zCImj; arc=fail smtp.client-ip=40.107.162.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="g+9zCImj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sWsxV8YL1YHLwMPg2Cl3nUbgH581yOKkpeX1RP9M+cZN+0bgqg0MKcFbNMj+bN7UKptyMhoF0zVFvRxgv/quReU0ebFKk6iVdnqUCwybmAhmX5eUeS7C1YL3257rcE+zuk1hN65SrYpgxMgjUeqX6zWRxdJ9DPRexsfHa/RRDc5uWY55zbeXum4purddGyfjOGRgUhfiN8Bx4FQV0yjTcru6UXCteGkacj/msqvN5M895nNvYn4fMUoNaRAr6nwpr+iNxlgHUot8nkwRy/Mm9cfE+pm6eTkQLv97M+2eb1OoAK+uUBxtJ4evAp3VePfF085kQVXcbFspAq59PIc/0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q77XJi90zQ7AgMZ/Ckhwzi9fjYJJMrR+NUaYPZwjgHA=;
 b=Uc6drj+opao9WUg579Qa/UEt5lpnXMSZC3Q6PqeXUDCQNkN+vAXj+TSRNeNoqhG2Fdjxp5IjfTtH4Qs8RV34kYuYqzrw8PiCWy55lMKCxkxufspA1tbmkqEa0X5MZ0b+Mt5ut9VhgaJ1KQOR/mbnfjxLDOpgpL45oFh65Sy4ohXNUONVpn+G1mk4f2kQbl/2YKFSMXjgzJSb+ugsccJ7e7/lAnRLKrc4TxHTeiF8obLunv/50LL88JZnmFmNEirhKOx0bx/aL2/antsHzPthcapo8Iqe89eAoCaEuGUZQno7h9Q5bnSl8xiNVFy+JZGG3wk/1U8foYvW6PsjenJBBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q77XJi90zQ7AgMZ/Ckhwzi9fjYJJMrR+NUaYPZwjgHA=;
 b=g+9zCImjGEXkWA1P//27MLOY3QuULuxPaATkfO+Gecga16Dh7lN06vEaUkCNb79RanCRNlcnq8CDzcjpYtKY4waoPI9QyvBW/BnYoOeq6uJuWEjT/HDq3E1h/daHmOCcgrZZ0rDFjv+oxoKWPYeOz2q87ldsrP3Esp5jczjet3DAxrkqjs0yyPluIrcVbQs4xPOGKjZLwJDRMpo0uwA9EaJ2SM0sNDG4qAXllVum9gDMDABw9gD8Yz+DhD7DMOODpq0bvSwblwlIk/1hD2ClA2O4Vg19wTIiDXpLV1nLUzM275gy/SUJFk9KPvUR1NUF1+UioMrTCaqV1UTcF4ovug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by AM9PR04MB8228.eurprd04.prod.outlook.com (2603:10a6:20b:3e9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 11:15:47 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 11:15:47 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Eric Chanudet <echanude@redhat.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	NXP S32 Linux Team <s32@nxp.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>,
	Larisa Grigore <larisa.grigore@nxp.com>,
	Andra-Teodora Ilie <andra.ilie@nxp.com>,
	Andrei Cherechesu <andrei.cherechesu@nxp.com>
Subject: [PATCH 4/4] arm64: dts: freescale: Add minimal support for S32N79
Date: Tue, 24 Feb 2026 12:15:33 +0100
Message-ID: <20260224111533.3194883-5-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260224111533.3194883-1-ciprianmarian.costea@oss.nxp.com>
References: <20260224111533.3194883-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0076.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::18) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|AM9PR04MB8228:EE_
X-MS-Office365-Filtering-Correlation-Id: bb4cd32a-3f10-4215-5468-08de73960f64
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?czFkbmNNTGRqdjVkZWpLMXZnRmY1VDkxbzdrTUdaRHlUMktnRmF0VFpsQzFC?=
 =?utf-8?B?ZDBGSjJvcUNDMDhPY21uRnRJRzNBOEw5WmpGb214K3NvVTBMbVNDbHVpYzlr?=
 =?utf-8?B?M1ViR2l6alBvWExybjBhQnBHeUdyQ0tUcStoaktpTXpaN05DRkZwS1lpTWhq?=
 =?utf-8?B?UURPNy83UG5Vd0NNNkRDM1JwWW9FUDdrQ25oSEM3Q3hhNFRHVHFYc0d5aUh3?=
 =?utf-8?B?R3BFTlpEbGs5a1VkekEvTHhLQVdVcWxwUDQvcTJqNHZnOU9OdjZkRUxTSmk4?=
 =?utf-8?B?dmJFYlFLWjN4cUxLcDBRMDE0UVlZZHM2WTR6QzBOQjRXUy9QU3VmUi82RWFU?=
 =?utf-8?B?UXNRUUpPbVdEWWd0dWdxNjBQUEVhSTJUc0RJalJQR0plVUJiaWdrS2JwTHdZ?=
 =?utf-8?B?UEt0NmJuR1JIRVR1QWUyVWI0Rkk1WnMxdkRCUzlWQVJMSXJsNUJqaXhmRTkz?=
 =?utf-8?B?V0ZkdjN4eElDVFd5ekp0OVNEN0dOdXRITmI0b05ZS3pUSXoxNjV4Z2JycnZx?=
 =?utf-8?B?d1d2RnN0cjJIMzZrSStpRkd5SG9GVStocHVuOU5rR2wwNlhrUFVMS0x5Z00r?=
 =?utf-8?B?RGY2WDJYY0c0dXNqM2JLZitGYTczMzR3R1RVSWl3VEx0NVFhYUlQcGdicDJu?=
 =?utf-8?B?aW05RmhXR3F2ZEJaNjJlTEgzazBUZjlEdUwweHp5ZVdtOFl6L3htVXlnSWVy?=
 =?utf-8?B?MGk0SURPL0M3alhibHl0eHRUeDVneHFudkd4WURiV1B0S3ZwUHVpRGxsQlZx?=
 =?utf-8?B?R043RVNUSWZRd2FwbXMxekY0Z0Judk1Ba2kwN1NjSFNndHN4NlN3aDFrV2Uv?=
 =?utf-8?B?bG5PN1dwdzBKMHljcFBubGVVQVBEeHc5NzQ0aVkyVDV5aE0xMnpjdG8rbGhy?=
 =?utf-8?B?L0UwaVlTSDRPaXpHdWhZcXRzYTZJdklraFFkNkJKOVNSSTRRZzFrMUYwS2NX?=
 =?utf-8?B?NGZJOEZQbzJWbFkyVUM2cXlydEJRRGQrNlpMcmZPL1dVRUtEOTVFdm5nVDlU?=
 =?utf-8?B?bktXR0lac3A2Q1F6VlZQZUhaREt4SldaM2o4OTRUSFptbXJkQ3ErM21wRGpW?=
 =?utf-8?B?cHVqZDFaUjRuaFdQYTVSZXVITFlpdEpjRmFRdFROcVFQMUFaNnVVMlpKcm9k?=
 =?utf-8?B?RS9tOVN3aHhTOGJuVUhKaGJMRGtFYXFHckZuZFdwMGR0TjRNWDhrb001bEJP?=
 =?utf-8?B?dWVOUmV1L09YdERTUUhQQ2NNK3ArL3JrZkpjUmsrMXJ1Y3lMeXpvNVVaNUtD?=
 =?utf-8?B?L0RORExQbTd5U0gyN3hqY0h4dnkzVytwRy9iZXBVMVdvNm1lYnZUdWFjVHYw?=
 =?utf-8?B?SE5uS1FiMWZYYzZ0NG1oWHZCRjJ6OGNEYzRMUkx3OWZ4QXJISkg1YXJsZGhn?=
 =?utf-8?B?aVk0WUF4cGFZczFpbFVGTnozSTlocDJlZnRscUovcGJSaVhJZy9lU1lPemxr?=
 =?utf-8?B?UTY5R2RJOTNDVGxScEE2U0VoVW1YUVJSWG1JOVZESEE4QUdiWHlZWUxBdVpN?=
 =?utf-8?B?SG1lSlJYRm1BRzFMa1JtVXBQa3VpU3FnR211S1R3bmV1SXpKU2FQS0dRYkhk?=
 =?utf-8?B?bWM5ekV5N0dQYlRvZkJ1aFkyOE1kblkrcXFkMGZLUmxiWm10MndPUlVZa2ZU?=
 =?utf-8?B?ZWNqZmVzNC9senp3RnJDL1VZMW1qVnlWc28zZXJiNERIczBHRk1iS2dSV1Bz?=
 =?utf-8?B?VGpGamt1Zkp6WlVpbFViSERkU3Z4UTNzSlBIbDdnY3hLZngvdmtYZWg1TXlH?=
 =?utf-8?B?TUZ1Qm11alplZS9CNi84NlF6Q3pSdnFNei9Xait6T2JBQ2JrV1VJMXpTOWxK?=
 =?utf-8?B?Sk5Bbmdaa3Y1OXdLWE9RT1ZHcEs2WFIwLzBrR0JZRXNSSnN1K0Z6S2tFOVdF?=
 =?utf-8?B?VTVjVW5ydGkyY0MxSTNBTEc1bGtUYXNhaFc3MlloNUVmeU5NbXlQRjRyak53?=
 =?utf-8?B?cWtHRUtyai96aHpoRTFlYTAyR3UwWTFqcmk0VFprT082aFlWcmdmbFphQ2lQ?=
 =?utf-8?B?RFBWeEZ0UTZvN3RqTjVqMG5EYURLYm10ajFEaXJpSVFLeG9TTzRRM3Bab25V?=
 =?utf-8?B?Yno0L041YXdzbG1kVk52aVVrL2hrQjBPY2xTOW13UFMxRHFqclhtU2lyTEtQ?=
 =?utf-8?B?VmRFbGREMVFYUVRDL3ptMFBPTUszVDQ3aUtoQnNXWHJMNGFDdExqemZEaDRM?=
 =?utf-8?B?dUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGtFNG5jTlFYOUIyck1CQm5qZGxmd0hHYTkwRlhiQTZEbVNMbTl0WEY0VC9P?=
 =?utf-8?B?cDhNQmhYMmgwZVFXdWNxaWdCY3piV1lCZHAxSlNhaFV1TzNxQzVtTTlucG5X?=
 =?utf-8?B?cXB1emlyWndOSnVCb0prVHdZb3pGUW5zd3ZoSHgvL1ZBanNJdW0xelZkd3li?=
 =?utf-8?B?ZUxjQktNdXQ3NkUzTStTWDZOTmVSdGVPUUZvQ2VxM2xtS0t2NGs3QnZreUow?=
 =?utf-8?B?cW1LMEk5cDFFYkQySTViOXZEbGtDUGxQQ3Rpc0UvTWdnWmdhOGJJZDhNUDBp?=
 =?utf-8?B?bFVjRVluZlRNd0xycHRQcGRJZDRvb1Nkd0pJZnpSRnVyTFFvTXRPMzUwUFpW?=
 =?utf-8?B?NTZIR1RmeWszV2tuczZzL1B1MXY5a29ydGhsZGFnQXc0blhpUUl5bVlxM3dX?=
 =?utf-8?B?N0F4a0lXbldMVkxTUkx0L2JhbGxTamF3S0hJZm5XQVlIVnBEbnlMZEMwWDJX?=
 =?utf-8?B?ekJsQzhleDRTRVZDYWRvVTl1TGRmZmhHdU91Q2h1TUw1bHFQZTJ1OVY4Uy9J?=
 =?utf-8?B?Y3NnZWpVNjFRWFhJemhMRk5YWWE4NUZjcjVaQ2NCZERZUE0zSzRoU2RqWkgw?=
 =?utf-8?B?QUxFZEJOWDYrbkhTOXE2OEhFbzBWajlEdVR1cXBlelJNVDBtM3dOQ1E3Q2Jv?=
 =?utf-8?B?OGhyTUE3aUlpRWxYSTh3RGZjVVJOWmQzWnlKOGhhOUloMlgxUGNJY05QN2Q0?=
 =?utf-8?B?UUxCdGhHa0dITXFTM0JOLzNmZmNxT3daYi9Pb2RhanlweDRwNjczaWoxblZj?=
 =?utf-8?B?Q1V4ZzFRellHSi9CQXhmTUh2VGE2SmljSzhkeGdOYU1oUHh4NThTQjQ0cmFN?=
 =?utf-8?B?YzdpV2FQdThUL0IwSnNlVkRHOTN5YS84V0pjQkVZVERaaXJaZmlnRmhkS2dL?=
 =?utf-8?B?U2hZU2RkRmhPVmh6ZUNCNDVQZTZNSThMU08xUnhXNXgrcWkyNnRJakQ2alFV?=
 =?utf-8?B?QThsa0Z2WDJOZVVMQk54c2FuK2M4OUwvcEpmNzhWSTkrSWxxZXhhUFRLUTdL?=
 =?utf-8?B?T2hka3BsVUEzUTB4ODJsMWlHZHgyY1ZuaXQxN2EvSERzTWZuM1ErVjNVNThY?=
 =?utf-8?B?ODBHWEVFVEkycnFuZ3JoMWcxNW9iOUdOeUVxOWFaUW53NDJhdHB0cU5wSFRq?=
 =?utf-8?B?dlh4MDZRVi9ybjZtbjM3bnZFNGtIcDVSTWhNYktWc1h6T3pIeE40YlI3VlFP?=
 =?utf-8?B?bmlsL3BxaVpRR3E2OG5aeHFpbEVMb3NxNzFtRm03cFRHUWZwTjBhMzRvM29s?=
 =?utf-8?B?VHNEQUwwa0dGTmV6dUNjdG0wblVIa3dqcG5PSFRiUGhiVU44ZFljSm1xVi9Y?=
 =?utf-8?B?ci9nOFV3bHUrclBIdEpuVTg3TnVmb25ld1hmc1NoaEZUWnl4VnpYMXFNY3NY?=
 =?utf-8?B?dXNOckM0UkcvdjRraXE5TTVkRFpzWktlMTQveGFvcnp2eXBsSHdrL1oyMFBU?=
 =?utf-8?B?N3M0RzJTV21WcW9BZVZ2Z0FXNHhWbitXMklpQVFWQ1dNZzBSbEdrTzcwdUZ3?=
 =?utf-8?B?SWU0a3JsZ1VEektSYmhLMVJkQjFaWFRTZXJJKzZvcngweTFlRzg4Z2k4STU1?=
 =?utf-8?B?LzhBUzd0aG5xWDlQbkg1THRNajB4TWJnVzVoejB2cGhwenRWUkhIZE1Sd0Er?=
 =?utf-8?B?UHBab1hoMVAyT3Q2cllEdlY0aVZkZklSMElaMCtFV0gzakNDRG04SXRFcTFE?=
 =?utf-8?B?c3Q2SWVUMWtWYTcrZng2WnpnVFNWT0dUa0xZU3JBVVJNUVJHVzZFUjE4Uysx?=
 =?utf-8?B?OTRKNTU4VkJwRE13dWE5UmxEY1F6TDNyU1o2MTJkMEJDVU1PVjZnTE1oRVUx?=
 =?utf-8?B?ZnpaSWY3bWdBN1Jyb3BqZGRwN0tMM3E0YWttTWIxSGVhMDlyU3UzZ3kxRDFJ?=
 =?utf-8?B?YS9qTFBWMGZWWis3Y0luVkRRYUVEVnY4RXJuQ0tKMWtGSWgvSVBIeFNCOHdu?=
 =?utf-8?B?UnplMVBNYzV4U3NyYVRISDltU3lUbXAyV2FWLzROa3pIVjI5aDljV1gyd2ov?=
 =?utf-8?B?UFcvUk93U2dVMTBxNFkrbXIzdEk5UHQ5WCs3OFV5SlMyNTBTVVRhVSthNEMv?=
 =?utf-8?B?WElYQVFYMVhnN2VnUkR3eDAzL3R3Z1NSdVFYdk42a2Vpd0dYTDBzZjBHOStX?=
 =?utf-8?B?SjZXY0ZWenp3TForSFN2VGVlYkM0c05POHpISldZOG1kTUwvTFA4alpmeGow?=
 =?utf-8?B?WFZzVGFOLzN0N3M4b0dOb1FHR2FXa2NxRFpXSmNMNFU2ZVpwK0V3R09LUHNT?=
 =?utf-8?B?a2tuMUtzREwwUmE1cEVseW1Cbm03ZDNtYzhSRVc1eEFmZnZQVE9RNUV1am1o?=
 =?utf-8?B?eVRBR1pkRHpJRFp2cS8xQ1ZhRkMxcUNIbjI0ckhxc0l5VmZWa216NG1WT2lT?=
 =?utf-8?Q?TP0xVE6u1BJATPUQ=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb4cd32a-3f10-4215-5468-08de73960f64
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 11:15:47.5726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s61AocYcF9Lc6m2+Vg69GUVkx3aGuwsNR1r//GHL2ZGV/A8lkiYOTZSVdqKxRO7NiGxTWBQlWLd0drXPjq69nBBmOi74OzJPeEl6U7HVvyI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8228

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Add device tree support for the NXP S32N79 automotive SoC and the S32N79
Reference Design Board (RDB) [1].

The S32N79 features eight Arm Cortex-A78AE cores organized in four
dual-core clusters, with a three-level cache hierarchy (L1/L2 per core,
L3 per dual-core cluster) and 32GB of DRAM memory. It includes an SMMUv3
for IOMMU functionality.

On S32N79 SoC, peripherals are organized into subsystems, such as:
- CIS (Coherent Interconnect Subsystem).
- COSS (Connectivity Subsystem)
- FSS (Foundation Subsystem)

This initial support includes basic peripherals:
- GICv3, SMMUv3 from CIS Subsystem
- PL011 UARTs and IRQ steering controller from COSS Subsystem
- uSDHC from FSS Subsystem

Clock and Pin multiplexing settings for the chip are managed over SCMI.

[1] https://www.nxp.com/products/processors-and-microcontrollers/s32-automotive-platform/s32n-vehicle-super-integration-processors:S32N

Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Co-developed-by: Andra-Teodora Ilie <andra.ilie@nxp.com>
Signed-off-by: Andra-Teodora Ilie <andra.ilie@nxp.com>
Co-developed-by: Andrei Cherechesu <andrei.cherechesu@nxp.com>
Signed-off-by: Andrei Cherechesu <andrei.cherechesu@nxp.com>
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 arch/arm64/boot/dts/freescale/Makefile       |   1 +
 arch/arm64/boot/dts/freescale/s32n79-rdb.dts |  70 ++++
 arch/arm64/boot/dts/freescale/s32n79.dtsi    | 361 +++++++++++++++++++
 3 files changed, 432 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/s32n79-rdb.dts
 create mode 100644 arch/arm64/boot/dts/freescale/s32n79.dtsi

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
index 000000000000..c8b1dcefa2db
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
+	model = "NXP S32N79-RDB";
+	compatible = "nxp,s32n79-rdb", "nxp,s32n79";
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
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x00 0x80000000 0x00 0x80000000>,
+			<0x88 0x00000000 0x03 0x40000000>,
+			<0xc0 0x00000000 0x03 0x40000000>;
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		scmi_shbuf: shm@93000000 {
+			compatible = "arm,scmi-shmem";
+			reg = <0x0 0x93000000 0x0 0x80>;
+			no-map;
+		};
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
diff --git a/arch/arm64/boot/dts/freescale/s32n79.dtsi b/arch/arm64/boot/dts/freescale/s32n79.dtsi
new file mode 100644
index 000000000000..ff4e004fcd7c
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/s32n79.dtsi
@@ -0,0 +1,361 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * NXP S32N79 SoC
+ *
+ * Copyright 2026 NXP
+ */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&cpu0>;
+				};
+
+				core1 {
+					cpu = <&cpu1>;
+				};
+			};
+
+			cluster1 {
+				core0 {
+					cpu = <&cpu2>;
+				};
+
+				core1 {
+					cpu = <&cpu3>;
+				};
+			};
+
+			cluster2 {
+				core0 {
+					cpu = <&cpu4>;
+				};
+
+				core1 {
+					cpu = <&cpu5>;
+				};
+			};
+
+			cluster3 {
+				core0 {
+					cpu = <&cpu6>;
+				};
+
+				core1 {
+					cpu = <&cpu7>;
+				};
+			};
+		};
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a78ae";
+			reg = <0x0>;
+			enable-method = "psci";
+			next-level-cache = <&l2_0>;
+		};
+
+		cpu1: cpu@100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a78ae";
+			reg = <0x100>;
+			enable-method = "psci";
+			next-level-cache = <&l2_0>;
+		};
+
+		cpu2: cpu@10000 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a78ae";
+			reg = <0x10000>;
+			enable-method = "psci";
+			next-level-cache = <&l2_1>;
+		};
+
+		cpu3: cpu@10100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a78ae";
+			reg = <0x10100>;
+			enable-method = "psci";
+			next-level-cache = <&l2_1>;
+		};
+
+		cpu4: cpu@20000 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a78ae";
+			reg = <0x20000>;
+			enable-method = "psci";
+			next-level-cache = <&l2_2>;
+		};
+
+		cpu5: cpu@20100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a78ae";
+			reg = <0x20100>;
+			enable-method = "psci";
+			next-level-cache = <&l2_2>;
+		};
+
+		cpu6: cpu@30000 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a78ae";
+			reg = <0x30000>;
+			enable-method = "psci";
+			next-level-cache = <&l2_3>;
+		};
+
+		cpu7: cpu@30100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a78ae";
+			reg = <0x30100>;
+			enable-method = "psci";
+			next-level-cache = <&l2_3>;
+		};
+
+		l2_0: l2-cache0 {
+			compatible = "cache";
+			cache-level = <2>;
+			cache-size = <524288>;
+			cache-line-size = <64>;
+			cache-sets = <512>;
+			cache-unified;
+			next-level-cache = <&l3_0>;
+		};
+
+		l2_1: l2-cache1 {
+			compatible = "cache";
+			cache-level = <2>;
+			cache-size = <524288>;
+			cache-line-size = <64>;
+			cache-sets = <512>;
+			cache-unified;
+			next-level-cache = <&l3_1>;
+		};
+
+		l2_2: l2-cache2 {
+			compatible = "cache";
+			cache-level = <2>;
+			cache-size = <524288>;
+			cache-line-size = <64>;
+			cache-sets = <512>;
+			cache-unified;
+			next-level-cache = <&l3_2>;
+		};
+
+		l2_3: l2-cache3 {
+			compatible = "cache";
+			cache-level = <2>;
+			cache-size = <524288>;
+			cache-line-size = <64>;
+			cache-sets = <512>;
+			cache-unified;
+			next-level-cache = <&l3_3>;
+		};
+
+		l3_0: l3-cache0 {
+			compatible = "cache";
+			cache-level = <3>;
+			cache-size = <1048576>;
+			cache-line-size = <64>;
+			cache-sets = <1024>;
+			cache-unified;
+		};
+
+		l3_1: l3-cache1 {
+			compatible = "cache";
+			cache-level = <3>;
+			cache-size = <1048576>;
+			cache-line-size = <64>;
+			cache-sets = <1024>;
+			cache-unified;
+		};
+
+		l3_2: l3-cache2 {
+			compatible = "cache";
+			cache-level = <3>;
+			cache-size = <1048576>;
+			cache-line-size = <64>;
+			cache-sets = <1024>;
+			cache-unified;
+		};
+
+		l3_3: l3-cache3 {
+			compatible = "cache";
+			cache-level = <3>;
+			cache-size = <1048576>;
+			cache-line-size = <64>;
+			cache-sets = <1024>;
+			cache-unified;
+		};
+	};
+
+	pmu: pmu {
+		compatible = "arm,armv8-pmuv3";
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	timer: timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	firmware {
+		scmi: scmi {
+			compatible = "arm,scmi-smc";
+			shmem = <&scmi_shbuf>;
+			arm,smc-id = <0xc20000fe>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "okay";
+
+			clks: protocol@14 {
+				reg = <0x14>;
+				#clock-cells = <1>;
+			};
+		};
+
+		psci {
+			compatible = "arm,psci-1.0";
+			method = "smc";
+		};
+	};
+
+	cis-bus {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x4f200000 0x0 0x4f200000 0xc00000>;
+
+		gic: interrupt-controller@4f200000 {
+			compatible = "arm,gic-v3";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			#interrupt-cells = <3>;
+			interrupt-controller;
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+			reg = <0x4f200000 0x10000>, /* GIC Dist */
+			      <0x4f260000 0x100000>; /* GICR (RD_base + SGI_base) */
+			ranges;
+
+			its: msi-controller@4f240000 {
+				compatible = "arm,gic-v3-its";
+				reg = <0x4f240000 0x20000>;
+				msi-controller;
+				#msi-cells = <1>;
+			};
+		};
+
+		smmu: iommu@4fc00000 {
+			compatible = "arm,smmu-v3";
+			reg = <0x4fc00000 0x200000>;
+			interrupt-parent = <&gic>;
+			interrupts = <GIC_SPI 1 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 4 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 8 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 2 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "eventq", "gerror", "priq", "cmdq-sync";
+			#iommu-cells = <1>;
+			dma-coherent;
+			status = "disabled";
+		};
+	};
+
+	coss-bus {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x4a000000 0x0 0x4a000000 0xff0000>,
+			 <0x4e000000 0x0 0x4e000000 0x1000000>;
+
+		uart0: serial@4a030000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x4a030000 0x1000>;
+			clocks = <&clks 0x9a>, <&clks 0x9a>;
+			clock-names = "uartclk", "apb_pclk";
+			interrupt-parent = <&irqsteer_coss>;
+			interrupts = <264>;
+			status = "disabled";
+		};
+
+		uart5: serial@4a060000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x4a060000 0x1000>;
+			clocks = <&clks 0x9a>, <&clks 0x9a>;
+			clock-names = "uartclk", "apb_pclk";
+			interrupt-parent = <&irqsteer_coss>;
+			interrupts = <269>;
+			status = "disabled";
+		};
+
+		uart6: serial@4aa30000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x4aa30000 0x1000>;
+			clocks = <&clks 0x9a>, <&clks 0x9a>;
+			clock-names = "uartclk", "apb_pclk";
+			interrupt-parent = <&irqsteer_coss>;
+			interrupts = <270>;
+			status = "disabled";
+		};
+
+		uart7: serial@4aa40000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x4aa40000 0x1000>;
+			clocks = <&clks 0x9a>, <&clks 0x9a>;
+			clock-names = "uartclk", "apb_pclk";
+			interrupt-parent = <&irqsteer_coss>;
+			interrupts = <271>;
+			status = "disabled";
+		};
+
+		irqsteer_coss: interrupt-controller@4ed00000 {
+			compatible = "nxp,s32n79-irqsteer";
+			reg = <0x4ed00000 0x10000>;
+			interrupts = <GIC_SPI 527 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 528 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 529 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 530 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 531 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 532 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 533 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 534 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			interrupt-parent = <&gic>;
+			#interrupt-cells = <1>;
+			clocks = <&clks 0x9a>;
+			clock-names = "ipg";
+			fsl,channel = <0>;
+			fsl,num-irqs = <512>;
+			status = "disabled";
+		};
+	};
+
+	fss-bus {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x5b490000 0x0 0x5b490000 0x1000>;
+
+		usdhc0: mmc@5b490000 {
+			compatible = "nxp,s32n79-usdhc";
+			reg = <0x5b490000 0x1000>;
+			interrupts = <GIC_SPI 472 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks 0x58>, <&clks 0x50>, <&clks 0x5f>;
+			clock-names = "ipg", "ahb", "per";
+			bus-width = <8>;
+			status = "disabled";
+		};
+	};
+};
-- 
2.43.0

