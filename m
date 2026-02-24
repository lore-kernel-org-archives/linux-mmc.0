Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011032.outbound.protection.outlook.com [52.101.70.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AF234DB71;
	Tue, 24 Feb 2026 11:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771931746; cv=fail; b=FQpfgHsgDmXC+9Yg8JWdzJGf6xmjnUxogmSha8Tidct61b0OuOGBv4y112ou8ku+tKSI2WGKpcju9aVwu2xxvHc4w/MUWGU3BMMEacqEFcjIWP1TmXz7S++r50P8rdOkWVPjFB8bR49mZ6n/i1Mpf7trvSxrv6JNmyn69TlO5LA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771931746; c=relaxed/simple;
	bh=Rc0u3kuUFUH80tIeeYA93dRvCIH24HKyBBwO674mU8A=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=V3wZ8YI/iLiMpktEr84JkhKH3Yw3o2Qnv52B/CFt5Vkdzyqe8xlhsj6tuW7/nRYyJ1KSQzFQTL+5EVjM7GALirC/ANxlZJCntbgTGHyw7L0gCgx/PMhc4GAB4MEBiWj1cfMxU9UCHZcjoo3+u/ZqdmQtGfrIhSkK+yWh7cZ77p8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=bo64AqC9; arc=fail smtp.client-ip=52.101.70.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="bo64AqC9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aQXo/C7uKl/l2WQX3vxTMJI4CLahtvrVpLy1vIb82NhT1r0ob7Hdp4v691Fp7e3wESHIWUZPHSss0lyQbCiBSoNSQ6JEsg41Praoepby7Wr8RfwljJRlBuUAZQTrC+hdSSFUt9dkAZQiampNv4O2khVevQEUStnVKo9OHrwdO9sOBm0zDgkU2miVV5hEcE7vq9xWSnN1m2Bw7iOe/OGM7ufUWsc4zUACpEia+mL+AHgP/0n81WDfcEtdDywFQ69lsHU75w1E3HnsqWaMWPNfOKwZKn1pPmnPvjGoEr541Fe6uapxB2Dck/0/xV0C7/uFXHbPBTfnYRUgffHOahLVTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nrSysZVK4ARC763j0Al02k7dYhV3oY7fu9P3wdfW+mQ=;
 b=lUN+aZzBzwrxVzlJmomBrPiLqEeQOTJapCqA2KK5CHvwtAf4+TgfO+8Rlz+6+79+yhw6YRCeNUdUGUDMcbWAK0y1xh2Dff+mGtPf2QS4m40pGIPQo5ITscNg9AELf+ChTzr0HNtl0NyfWFuJYA439n1gnYL4hdu2vff5AqdTyVhYaOxAoRez/L1McFe400xhyr4FC71utgUTort8CRxERibeW0Omow+gW1fqbs8Azk0u5GHNF/4o3Bz34/8qK7RnvMY/zY4ehxa2WqAt3GWc1zcUP0SpjO7mzrve2dQzarPypRA0rnoEtwSIJt/l07gCthf/SRnLFzACs+ABkDQpcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nrSysZVK4ARC763j0Al02k7dYhV3oY7fu9P3wdfW+mQ=;
 b=bo64AqC9BASeJixn1p8G/KcoHySaasWAxAEC2DYYeiofI7XBE8MOdWTy/4bVV+rrYYKOMisN/vF7Sh31Skpm40sL6yG9ze1tlui/fNcsOfV3dQKOCypefXpPjzu+9+ZD+Ws4Is23gPVGKeSrUbusD979nF9tZBgKe/oNSqlUcRIfQxiiwrXP75cXj4yITgoOiGNQ46w7uhk6QH2xrl67o+UTdkkfFqDZsADx1lmSSOLFqMjrgHaupuMkJioM4E530DjmeFssBIHJefG67h9LIjw+xNcMzO4RZ9xLcyTD6piJ/LXohvNzxZAXK6qy/YeySGo/TQ/ZgljvCVTqp2yXTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by VI0PR04MB12114.eurprd04.prod.outlook.com (2603:10a6:800:315::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 11:15:39 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 11:15:39 +0000
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
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Subject: [PATCH 0/4] arm64: dts: Add initial support for NXP S32N79 SoC
Date: Tue, 24 Feb 2026 12:15:29 +0100
Message-ID: <20260224111533.3194883-1-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0081.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::8) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|VI0PR04MB12114:EE_
X-MS-Office365-Filtering-Correlation-Id: db3c97fb-b900-415c-cafb-08de73960a7b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZGdXS25FTFk5NTBQUWg4eHJES3ZlK09CcXlHTkVYOXN4VWthOUUyK3lrelA0?=
 =?utf-8?B?ZzBaRTFJUy8ycDFlK1ZXczJ6NUN3T0Z6OERHNURPSmIwOE16ajNiUE9sVGpU?=
 =?utf-8?B?Y3Q1WnFwbW03ZldzVUoyMVB1MFNSN09kM3ZYazVUak1SUkY0Ukl4c0pyT2lu?=
 =?utf-8?B?bEd0ZS9ZOXlkeFNubWZEajFZWTAwMHQvNjJYWGRGUmRwU1ordlY3TUFMSzRQ?=
 =?utf-8?B?QzNsNG1SN3FUM296YVZscmJydWlmWEcwQ2RIMXZ5Y2Jlb01rM3ptMitCRGxJ?=
 =?utf-8?B?RCtRRDVHMmVUazNqTFFEbm0yVHNnMEdsS2kybVN6Wm02ZzVzdDhTMktGZnkz?=
 =?utf-8?B?N0NtTDNmY0MxQjdLVmJveVJOTWNBckNCT0VhWWtNU2JuN3ZlQXRycmo1QTVW?=
 =?utf-8?B?UTkrMU5TbG1mZEhEZjBucU15Ny8yQ043UzlBWGgxK04xcmFzQ3lZZGp5dHgz?=
 =?utf-8?B?RTAyU3NNWmdaVkpndUswOUtOak1ZOXFIbzZhV0lyU3h4amFMUUo3K1RQdHU2?=
 =?utf-8?B?T3lrQk0yNDhwSG4zQm4ycEZQb2pTY1FrdjVUYjZFTGk1YlR1MlV5YVZLOWt3?=
 =?utf-8?B?NVpHS1U5Zmp0ejJNNklURk9Xb2xJcWRvei9MTk9xMkVIc1ZjLzVmRk5ISVJ3?=
 =?utf-8?B?YTJoT2EzMDIxNkxzdnJDOEhiOFRERjV4amFSZHROOHhMYUhEOW1ic2o3UFAr?=
 =?utf-8?B?S3hDd2tVNW1NaE53NUJpb3NkYmZkVkloTmZHUzlIVkpLbzBEUzhNejJSeFJi?=
 =?utf-8?B?ZVFyazBtNnErMXE4YnBpcG95dWtqeU0zZVpObWluNlV6Vzl4T3QvRkZsRVpF?=
 =?utf-8?B?aHVwc2pxbWhpaTc2TjdYVzg3YUYxb2dSTVZ0Q1dON0hRNFVCQnZDN05RMytN?=
 =?utf-8?B?Uis3enJBQmlMWGl4MHhpb0NBMlZ4Q3M5MVRHMDBqaFBXaFA3WjNKeVR0cU83?=
 =?utf-8?B?SUhQcTN1RWtnRVVHZVErTlFkdHJ6aGgwY1lZdWpEY1prb1A4RjlTWDFoeG1r?=
 =?utf-8?B?SEI2Q3ZCMWpERDNSTmd6SkFFZkVUYmFaOFNTSVJWNDNobUVNSUFrRkY2RHcz?=
 =?utf-8?B?bmJkN0RuZHNXSktyZllyWjZ2Mm5pU2lPMGVBWWZ2alNJMGNNdHJYaFpBNHZn?=
 =?utf-8?B?Q3o1WmNOWDdjQlhla2dWcy9IUVduYzlSSnJiVFd2cWJBSmtLeXJBSEdrNFBo?=
 =?utf-8?B?NGhDTVJPVVJmQmtwaitDZE84akEzdFNZSlBXcU9QSWxwZ1o1ZGlYZmIrU0Jx?=
 =?utf-8?B?ZEVZSkgxUXo3Zy8zbGFXdDlqU3JZL0pJZUJmTkU5NjRud2MwZEZXeGdOWkVO?=
 =?utf-8?B?aFpmQnIzdG8zUW01SU9ESUwza2FzSlM4R0pxQjJscHpOOGh1QkFhUDNncjh6?=
 =?utf-8?B?UmJWdzNVYXJPdkc3NmxIcW53aHN6OGJIcmt0NTV5eENPN1FNNlYwdFFXRC9H?=
 =?utf-8?B?N01ad0pseElvanZmeXU4akRqZUdZUzdJKzZrVWlSdlgwUldEQnNXOGxLcG9u?=
 =?utf-8?B?RXc2Q2dOaW9sZHZMTGJ2VStUeEUyYnNBWFBZT1N1SFFKSXVuY1Z1Z3JNa09T?=
 =?utf-8?B?aGthZEd0U25DQXVhM1pRdFlJN3prSnZnSzlvci9qUkhEcGY2ZmZVV3hMejBP?=
 =?utf-8?B?MWpxYUYvV1NLa09EWDU0MVprUWt5VlJGTStSRklDeDU5VnBZNXdDU1lFMFR0?=
 =?utf-8?B?b3ZsUklBYlNiWnloYmJGMVpzZU9hUTIzM21FUGxEak1wT0RJYU8wYXRXYjZ1?=
 =?utf-8?B?OVBhZXRES3A5YVdYK0VBR0ZMMG00UkRZSU1KaTA5U2t4UTZCVHhMN0hnMFgz?=
 =?utf-8?B?WjQ4MVd4VHAzQXRWVEE1MkRucVZvS3pFazJSRFRCenRRaDNnSFBEd0U5OWRj?=
 =?utf-8?B?WmEydFRleUtsc2Y0N1hyNmhWeFdBSkVXZStMeDFRK3E0MjJ4cDdEMVQ1eXdw?=
 =?utf-8?B?U08rUTJWY0cyOWx2SUg2Zm5MWjFLcUZieVJiTXA1L0RSTWRYMWFUYWROZ2Y5?=
 =?utf-8?B?cFlaVnI3VUJYRm9Iand2Rk5OdDB5cjhHWjV0dXQyTUtoTXM5ZWJLdDNQUXVm?=
 =?utf-8?B?WFZ1WDVyaGNMazd6Y3BGbWd2NC9sWWhPeUlOVUpISmlwVmQ0RnNnb3E2eW01?=
 =?utf-8?B?eTBkemozSXU1Tnc2V0pjMmtUdjJBVkZtTGZ0RW03TDQwbEdRMTVQd3EzYnlD?=
 =?utf-8?Q?FgYDjZXvTwUog3BB3YKa1hw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L203eWNmZHZUR2lWQ2ZrWkJLS1dXS2ZGcTdzeHlWM211WTBtcG4rNXBuMEIx?=
 =?utf-8?B?RlliUEtxT2paVVhoUWRvbHU1dnYyWDZGc3JpbitvQzVXamdnTlZaL29XMTM1?=
 =?utf-8?B?NWVPanpZTGVaRjF2VnhuV1hNejhERnllSldzWE5FNFlqSWNPdy9BR3FyeVNj?=
 =?utf-8?B?U3h5TG41V0RwSGJpc0dlOHlHdGdDV3craXgxc0ppL0svc0xKNmw2UGMya3hB?=
 =?utf-8?B?bWs2Y1J6SWlDNlUwQzFNK2xBWkg5T1NxNlZpWUFoajVwbGRMaHE5bGwzNnFZ?=
 =?utf-8?B?cThMTmJoUUVCZ1p6TmpNdWdTOW55NUZ4STFHOGRFUVcvNC9MeFJPWkRYZGVT?=
 =?utf-8?B?bmlMVjBsQkhWdmc1TVdURFd5aVQ2SDhZNXRWNzhJUXFkMnlzazE1M1B1Ty8z?=
 =?utf-8?B?MnBCK0JMTlF4OVVSRUpJVUJzNEdkZEkyRmJKRk5uRUhDR0pPdndnT1hPRWUz?=
 =?utf-8?B?OWFpNTdDUkE2Rm4wYkZnQWFYS1ZBcjVGc05mTnZkUGl5cEhPNmNlbFZ3ZEhu?=
 =?utf-8?B?Sjk4WXpDczRtZEY3bS92ZERXdXJMRkJrYlBhQ2ZxNUNrOU94U3hBeWpiMHVR?=
 =?utf-8?B?em5OWHcyM1dEZXFDcVVMbHV4ajJOTUNOT3lOZUhzYXJlaTBCYVJyNC9qbGlO?=
 =?utf-8?B?eVh2NFplb1ZrS2xrUTZSUzNOSEt5RGljdGxMbEF5Vi9NN3hNWGFEQm1yVVZJ?=
 =?utf-8?B?Zjh5RXZML3NoRDFDa3krV0daSUpCbHVNcjV2VTBIT3lBZFkyYnpPd21CajBp?=
 =?utf-8?B?Q3NLYkZ5SHl5ZmpLV3lnKzNRNW5MRWdRRG1WZ0duZmMxRUs4UWJheWIzQ01N?=
 =?utf-8?B?VEZJM0c3WkdxSkxqZG1YUmE4T1MySTNVb285QWh2N2krOTVNRm9haFpIcGtT?=
 =?utf-8?B?UEdPNXdHK0tjdWpPTzAzTzJOL0lZVnBGbi9qTGZvVmRqUnh2SGZmNDYzTTJx?=
 =?utf-8?B?MnNkc3hrb0VBSHVOV3l6bUVaRXUvME9DdjhGL0RYNisrR2tkTWhQZFY5RVp1?=
 =?utf-8?B?Yi93K0xVSC8vTWhVYS9JL0QwcUVHQXl0ZmRKOG5IZG5LbTNtREszS3cyQlZy?=
 =?utf-8?B?bGF4NmZOT2V1ZmlMMnlFMmFLZThUYmFnUWhCcDBUWVB5OHVsbjB0TjRIaHdQ?=
 =?utf-8?B?Wk01WGh1RFVTTUd5b1FUVWJrMmdVaVN3Rk9ValVlRG52N2xteUxXZ29EVVhr?=
 =?utf-8?B?aEJubVQ0QVFseitwUTg2Q1NaQkNRc0hnVHAvbmRzMGQwVDBTckUybGoxS3Vi?=
 =?utf-8?B?UTVLY0d3dzcybzVieE03R3llbEhDY2lpdnlDYUZEeTd0NmlDMjlPVURmNjQr?=
 =?utf-8?B?MlE4SlQwOFlrVUZZNmo4YnNqd1piOEFCclBla1hxUEwzdXFIRzd5QVhKdGE3?=
 =?utf-8?B?MkdRand6MGdVU0FSRlFYanNMRGI1RlRDdjVWbFQ1MkcvYTlJUDdOZ1JHbkpv?=
 =?utf-8?B?aVI2cmVURHZtUW4xZHpKN0RPdXRMOHA5azNIQlJJbUVuWXFFMENkQXkrSXVV?=
 =?utf-8?B?Q0xuMENxY3Z0YVFoZkFyTnA0Q1FsbmRIUStRQlJ6dHRtcUhEYjBYNzRaZllV?=
 =?utf-8?B?ZlY1dW02UFJlRExyZTlNUGRFUnBjdVNqMDJOT3VOMVk4amx1QW92dENGK20x?=
 =?utf-8?B?dmJwdjJLcjNCaFBmUVRxR1FJMzRLNXM1R3R0TkdpLzNQZ2lISEJyMDFKR24z?=
 =?utf-8?B?UTZVNHpZZXg3MUI5M1Zjd2ZySEFFazRRcmh1YmVjMzNvd0RoTmNDd3FGKzZI?=
 =?utf-8?B?N3RaajRiYnZHV0s3cFpra0MzY1FocVBWbEcxOHZXYmpWYUFHLzc4a3owbWhZ?=
 =?utf-8?B?dXd2ZGRKeU1WaXFpQkhBQkZCSUlZdWJHS1lzWnJrNmhZWFYvbHpoWjJlOExy?=
 =?utf-8?B?UCtJdTdRM0dnTDRHT0JydkdFNHU2ZWltRlpTei9KYTJiSmZGOE9yQW5LM0lD?=
 =?utf-8?B?eHpmNmNtWUVuZUxURTJKN2Y3NDZaOFNGc09IeG52MnpUUjFEaEQvMUYvTVdX?=
 =?utf-8?B?Mit5ZmNnbTcrQjZuVFRtREYzajVjdGc3VkQrMWZ1V3dHWkZ5em5DOTRlSHRY?=
 =?utf-8?B?RjluL3g3OHNDTWFVQWtjN3VOaHpqV2JleHBTbXV2M2pLWEVzUkoxekp4Wm5v?=
 =?utf-8?B?T1pYQTBUQjdScE94Ykg3ZDVNMGJ6L1pickZtWEVua2pjd0NHQ1hlZVVlV1N2?=
 =?utf-8?B?aDZmY3Z5M2F4QjVobSs2T0dNcHRpT1FjelBRZ3RDN1hZdHNNa3NvRlFTYjBD?=
 =?utf-8?B?VEM4SUlUK3BvcndhTG8wWXNoTjkzcXZ4OS8ydnhSaU9JdWNFY2pPNmJDNE9h?=
 =?utf-8?B?TWE5YndOL0p5YnlzS2llVzFKZzVFdldYaGJrNndRdHRWdDJLUkowRFFuMzhx?=
 =?utf-8?Q?i3VszniK4TLCQ+IU=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db3c97fb-b900-415c-cafb-08de73960a7b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 11:15:39.4963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sufTIDJ2Poay4dsKX9XP4lrZDh6RE9WgRxix5JxJriLQEC6PJzmW/oJJwnETFJBYiYBltLP4QW7dkyVn5u5l6ip+JyJ8pPSSx3K4+iUdbK8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12114

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

This series introduces initial device tree support for the NXP S32N79
automotive SoC and its Reference Design Board (RDB).

The S32N79 is an automotive-grade system-on-chip featuring eight Arm
Cortex-A78AE cores organized in four dual-core clusters. It is designed
for high-performance networking and gateway applications vehicle
architectures [1]

Hardware features included in this initial support:
- 8x Arm Cortex-A78AE cores (4 clusters of 2 cores each)
- 32GB DRAM Memory. 28GB are usable and 4GB are reserved for ECC logic
- Three-level cache hierarchy (L1/L2 per core, L3 per cluster)
- GICv3 interrupt controller with ITS
- SMMUv3 for IOMMU support
- Generic Timer
- IRQ steering controller (requires separate driver patches)
- PL011 UART controllers
- uSDHC controller (requires separate driver patches)

Future patches will add support for additional peripherals such as
networking controllers, PCIe, and other IP blocks.

[1] https://www.nxp.com/products/processors-and-microcontrollers/s32-automotive-platform/s32n-vehicle-super-integration-processors:S32N

Ciprian Marian Costea (4):
  dt-bindings: interrupt-controller: fsl,irqsteer: add S32N79 support
  dt-bindings: mmc: fsl-imx-esdhc: add S32N79 support
  dt-bindings: arm: fsl: Add NXP S32N79 SoC and RDB board
  arm64: dts: freescale: Add minimal support for S32N79

 .../devicetree/bindings/arm/fsl.yaml          |   6 +
 .../interrupt-controller/fsl,irqsteer.yaml    |   1 +
 .../bindings/mmc/fsl-imx-esdhc.yaml           |   1 +
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 arch/arm64/boot/dts/freescale/s32n79-rdb.dts  |  70 ++++
 arch/arm64/boot/dts/freescale/s32n79.dtsi     | 361 ++++++++++++++++++
 6 files changed, 440 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/s32n79-rdb.dts
 create mode 100644 arch/arm64/boot/dts/freescale/s32n79.dtsi

-- 
2.43.0

