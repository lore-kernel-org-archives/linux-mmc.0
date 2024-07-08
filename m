Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2040.outbound.protection.outlook.com [40.107.249.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295B7143C7D;
	Mon,  8 Jul 2024 12:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720440638; cv=fail; b=QXJOiw3YJEW3DC6iOcXf3zRcrkiPP2JbV20wP1BgvnaXEwxO20z+VvNyhTCOUvpAZMvYL3Ky+PP2FnJdcig1NLOHiwfQ5jrNzEiRn+U6U/GhNHaLtb/lyQo2q3Ve7N8QwmfIV5ec7CRpEfzOs5nDgj0kMbRb+wg0BgzR7+40vek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720440638; c=relaxed/simple;
	bh=WA3wpQYMiw+SuvwzzQm8hfOQzI2ldcitSNgjB50H6Lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lQL06NufP42zHGduCeBqXDLLq83tC19KJaPzoLOKjU+M8ec7rxZpKkGO+BiDeZV+/V5IRYKaRSaue4+ayi29pbLXzKsJHwwykcVD5BdWh9bpOY/15vkKIXBon6+ulX/qXTXU2T22L0fDrSA0/OMyGA8oxzCPectEJrFL8IkP4UA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=iqJ2/+0v; arc=fail smtp.client-ip=40.107.249.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="iqJ2/+0v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hOmHQozoOzeTdNXidSsx6xPuBIN2QPa7GzEf8ptonejiSyRlr5zD9Joqnd+oY63APCbRQWViClJu4y+k/rUrVxtNfeSRBsbwXDx02zSNSRUKLsdT1rKf+O85tejsUa7M6UgkpTBEN67KE/zcxyIuHZrNVCGcpzR59kbP8fslrWIOL6/gcKkuaMEjCmOT24Bf9wDVRlwmt/6bSs6LfyxRleq9ZCipa0JQ7rg1XWyLiWUXw7ENuqKC9mdSUgB83pS5fzA3r9FlFUodXGo1wTjdIj1xK9ku71AVH0l2BfB7kQKpKVGyRrPwNLSrNH0fUO3zqNC5gOySmScyjVW3Hyp4mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GqXn2Spewu7hks/6PVU+Dt4N+nV0Zeg0eP7GR31+71M=;
 b=E+SZ9nm+eXTFoAfhIl95cB7FrkrtLebkNrqb5v8ua26WJjOM7Q02thshsXGYUfHP87ttktAiwoZ7lk5MWqaeiRhFUcZZTbrqFLsOZFd+aZm6sRlL5lTskf6jrmv5WR37C3NjhwCiDRfGJCNKmNMdpm3WnfzWF7cp7cL1RTxLq4nOOPb63lBukZwyILwiZVoua4RJ3M7qwEdj9j5o7Y/KVpx5+Y0Wp9FeGhRsDDPeBvndC94Hv7CF38p6+ZzLh++IS3wxq9eFsdHqcV2p2VN/oY1yET3AN9S/TA6QVXW13jItyTTowrCTufUHoqLApvCICpXEGT1Z5TCx7W2xkrZ9rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GqXn2Spewu7hks/6PVU+Dt4N+nV0Zeg0eP7GR31+71M=;
 b=iqJ2/+0v1PvzWGAWedhfyxQy+0saq1h+luP6nueG6h6CxHaRFND2C0RT1LV0+rzkzulJL8q07yfQ6ZDE6upmVpJIvD7YbD3Yu59XqcbLbMYHZEbi9d1zvsY4ps/EXlmrOMr+EayKxkOf4hYb2BmB+uhb8DbtBLFkZLF3TudcsOk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by VI0PR04MB10614.eurprd04.prod.outlook.com (2603:10a6:800:260::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 12:10:24 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%5]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 12:10:24 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Haibo Chen <haibo.chen@nxp.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	s32@nxp.com,
	Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
Subject: [PATCH 1/3] mmc: sdhci-esdhc-imx: disable card detect wake for S32G based platforms
Date: Mon,  8 Jul 2024 15:10:16 +0300
Message-ID: <20240708121018.246476-2-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240708121018.246476-1-ciprianmarian.costea@oss.nxp.com>
References: <20240708121018.246476-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P190CA0002.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5de::11) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|VI0PR04MB10614:EE_
X-MS-Office365-Filtering-Correlation-Id: 90be1601-904a-4dd7-7df4-08dc9f46f250
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cEVqMldmc0JrbVF3TUpTcmZYYURGRFJOUElNUGg2NzB4OHg2ZW1aRWtkVkd4?=
 =?utf-8?B?c3VZNkNTVmF6NUhnMGh3aGFVUDdWbXg5S1pTZEVSU2J4Z0lzbzZtaEVPc1k1?=
 =?utf-8?B?WG9UbU55eG45dDJWR1pUZVAvUjY3R3J6R0dxQkNTdTdFSWw1eWwzaW9mZGJI?=
 =?utf-8?B?SS9GQ1Nnb1hGUHpvekdtUlJDV2NsZjU2QmUyWDhzS0tLV29hT09KdUFtUmlE?=
 =?utf-8?B?Z3p2LzFXcGI1ZDdxc3hhTlZldnA4aFpjNXVWRTlXWDNSMXFndGkvTmN4Tmo5?=
 =?utf-8?B?T2ViYUVqSjdhRTkzR1ZmWjZwNmxiUWVYV0gwMTBvbE5ZTlF2a0JYaW9yRGhC?=
 =?utf-8?B?S2Q4SFZnNm96THMzcXd2NEJJMUc4SkhPOTk4VW1UQnpkMHZ2Qm01RGpWYlBy?=
 =?utf-8?B?L1h6aEZOUHMvMFhMR043bDZXSGF0WTU2ajR5cU1TSW1nbjVGbXIwaXVJcFRq?=
 =?utf-8?B?YjdTL2FETHVkMTE3UFdpQjd5TE9IRGJGWXFDbTlJaFZjNGxnN1dmajhQS0dU?=
 =?utf-8?B?Y0M5SzBNZkkvZWNHa2R0azFQSjZwajQvOUdCOTdDY2l4TjkvR0FqMW5iRm9h?=
 =?utf-8?B?WFBTWWlVcUxHMy9ENkdrMVYzYjdvS1NKRzNBazU1SS9XS3o2eElwN0srQVVk?=
 =?utf-8?B?dkJYRXBxbUdYYkplR3BXa1VGcUdpUTZiMU9qamZuSU5oTjlXZEgwV1JaaE9P?=
 =?utf-8?B?VXhsVFpiVVFyNlhtUEdjV2xIN3VuVG02ZTZpVXpSRUowUWJzRlZiNVpoTkhL?=
 =?utf-8?B?RHppRm1Bb25QYWZ2aDZmMnpzckRxZEI3U0owem5GUXliTEtGd0RTZ0VBNDY4?=
 =?utf-8?B?R2hEMEZtSzdyN24zRzk4NDB4TnEzbHlPUmN3R1RkMnpyT212UUs5VkhiN2ov?=
 =?utf-8?B?alczdjhOTk4xZUFPcVJhQzJibnNWc0lacjYyNXpFY0Q4NDU1UHdXZGgwTlNa?=
 =?utf-8?B?S3BEWXNISHNOUWRzWW1DKzgwYm1sbDBjWmNqdTZWVTdLY1gyakhob0tQWWc3?=
 =?utf-8?B?a3lWZEZodzRHanU1UTdmbmhPd0ZGWEtoSFJGVVdOR3JMLzRaaEF0K1J2QTl0?=
 =?utf-8?B?Y3lPd3dnbVZUaTl0RCthUkhydGpxTWdTVENSamxxWmRrMGZzK0tLVE80VGMv?=
 =?utf-8?B?SU5TSEJqNlVPL1Z3WW5BOTVoSWYwU1kwM09Vb3pYVDM3anZJOVYzd2k4d2gx?=
 =?utf-8?B?UUpwOGV0MVBaY0wwVUY4akRSM1B3dlFOekRFdW5HRWs2RE8ydVRVMXRzM0wr?=
 =?utf-8?B?VUpVOW1BZlNZbkp2bnJyUnpUbWNTRlRLckVTdEJGQm1qUjZLa0NWb05kQ2Ux?=
 =?utf-8?B?TVFWZU5YNFA2WEVDRWFnM2JxVlMrYlNGek9VakNMSzhqQWdLdS9zZmJpVW11?=
 =?utf-8?B?d05pN09CQjFKRmY3T3FXN2pHU0F1QlRpb2tNZENBb1NaZXZSMkdCc1dxdEVw?=
 =?utf-8?B?eE43UDhCMGFZWHZPUmZLM0JnUDRlOXpmMjEraW5QdVFSSUVQQzVOeVk2eVcw?=
 =?utf-8?B?MjR5SkpVTnVmRGk0STVBVGJRWHR0dFJCSWZQSUtvMHd2bEpBTVgxWVFYajdu?=
 =?utf-8?B?NXRvNG44cmZVTHBxWXpacDlPVVlrMGZMUEJELzltMzBsbVAyYTZaTlh3YUVX?=
 =?utf-8?B?RWdYZFJFNEMyY2kyQ0hEWlpicUpMZlBFWk12SUhNMmF0ZkhjWlhGYnZMNVMz?=
 =?utf-8?B?N1hNN3kxMjRGb0lQeCtGaW05VHc5R2xnKysxMDhKOE9GZ2t6WXVCVElKNVlS?=
 =?utf-8?B?TUpKMUJkUkNZbWs0Y3lCNTFON3NVdTdSNENtSzNGeG4xV3lzNlgzcTNxdFJE?=
 =?utf-8?B?eWorYzJLQjBpWUhJVjdEUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eUUxZTVpTzhjaWRiNGxUU3UwY0J3amszRWV5YlBjTnAwOFJ6SDVBZ0dmQ3NC?=
 =?utf-8?B?aytDT0lHYjFwZm1ZeC9sNlNWVUpOS0hwM2o4NVhOWWUyanN5MlkyS0VKekRS?=
 =?utf-8?B?aWtkekgrcUNhdm0wS3VrS2FPRW5OK3BvWFpGbUZoUmpYVVgxUUozT1FSUXd1?=
 =?utf-8?B?MjhLTUR4bjJaNmQ2MytnV1FHVUNkUUUvVHVnRVZxNThVMlhmMlltejBsbm5X?=
 =?utf-8?B?dzNUeUhrM1lBYlZGSlVCc2hseFY4aDgxTTlwYzVqN3ZHTUtjV0xGMUVnYXha?=
 =?utf-8?B?LzFhNlBGZENpcnIra2VOQ0R1cjVkL1BrSVhWaGdJa1VUSDlJdGRibzNPWTZ0?=
 =?utf-8?B?Mk9Ld1FnTXY1MjFxZG9nZG96VFVpeDIvMVpRTjRWbEN0cTNrakFCUS9qNUVR?=
 =?utf-8?B?YVIxeFFvL0haU0ozTDhBQmRBc3Q0NW1BWnluNlJhc09BbDVQOEVEUm5Nb0dQ?=
 =?utf-8?B?SlZLZW51Y2ZrUmI0Qy9RQmdrdWViOVV6U2ZSK0E3Ti9Rais4M0UwRXZJR29j?=
 =?utf-8?B?STJtcm04cjNsMWZ3RzVreUxKTjJaT3JOZGxQM3dsdUMycExEK21NT3creTlG?=
 =?utf-8?B?c0ZTM2Z2QnJXZms4Ui8vRXJlcFVhYkk4bVBNeFdta1IweDRMM1piUDAwdm9q?=
 =?utf-8?B?MXRtdDhpZjZhdW5EN1lLeVlENGJWM1gvRDhxdWFaUGgxRE1tRzRtTGxXNXRB?=
 =?utf-8?B?Rm9aQWFKUWxETWZWSmQ3WTdmNTRSTTlkSEVNZG02czhNTWdhd01GQ3g2cTha?=
 =?utf-8?B?T0k0dWdYV09sOS94OVoyTXBXZ3F6eDVHbWxoZHNlU3JOZkJZNWF2ZFJZcURk?=
 =?utf-8?B?Y09leitIRmwyTFYvOEttWCs2bDFSK1lpTkozcEZPT2FDemlyOGZHNk1neVRW?=
 =?utf-8?B?NFQvaWdxa214dUZKNnZwMUs1RDBraUgyUUYxVUtLWG1CZUVDOHQvc3VHK1FO?=
 =?utf-8?B?bDIrbTA5bWtMeG9YMlUwcktKS3ZRcUlaQmdRa3ZieXpjVTdLUDRyY0dKV29P?=
 =?utf-8?B?OXMwZXFGcFBSeUVCUHBhcHhjUysya0lQYlVNdlNyQXRkZGFYbzJzQ3hCREY5?=
 =?utf-8?B?SVphUXZOZ2M2QmZldFpDQ2JoK1NINldRYzlpL1BRN2hRYVlFSXVTVS9yNUlu?=
 =?utf-8?B?cjRCWXBGSWp6bm1rbmR4c2FLZDZMVDFTb3VhaUJoZkx4Sy91VndoVW1acys1?=
 =?utf-8?B?Yys5SkhJTERzSEFsYzE1RmZaTVNyc053YVNsOHIxRGppTlVjbUFoTHRaRXNm?=
 =?utf-8?B?QkJkeStPMW9jdjNQK2krb01Ua3ErY0tJT3c5MENYTDBsYll2d252RHhmTTlz?=
 =?utf-8?B?ckxTZ3k5dWdwTWppdmhJZVI5QU1aVlY4VElCZFRBclJGdmZYeGNMZHRQOGtJ?=
 =?utf-8?B?U1FpSlV3WkJsZFFYd00rTTRpd0M0Yys5VjRveEVRdnZ1WUhRdG5Ca1c2T05o?=
 =?utf-8?B?dVZYRlJQMXZ6WDEzbXFuT2gvcFRxdDlvRGJWNGFLY2J1VTNJRVNrU0lvV3l0?=
 =?utf-8?B?RCt5ZmlKcUhzV0RoR08xSDFJY1JvMS9qbURzbkVwWVhiVk1LSlVvajZCY2RX?=
 =?utf-8?B?TTJPbk9NSWcyMks3eXZnaGZoeThlS1JLcDJDeW5NYVpIenVtc1NJblJ1VFNi?=
 =?utf-8?B?MGtCbFphSG5FN2F5V01xbTFoR3k0R1A4cllzUXFxWHVZYjBCRmlYSlRkbUdx?=
 =?utf-8?B?TmJya2xwMTlPNHdpekluVWhrTnd5NmoyY0tOaHVPdTlKR21hWktkYTc1M2Vi?=
 =?utf-8?B?ZEYrQ1hPcGkrdnhqdkF4RWt5Y1BjNWZ0Y2hvWUQ1Lzh5YWVVUE1WdUl6Y0s0?=
 =?utf-8?B?aHV1b3YyVGpGVWJxZXlFNzdNTlZGMktaUExkcFY5VjVDeHhIU0JDUnBRcmdk?=
 =?utf-8?B?dm5nQTQ3LzZvYWxWdXFoQzNMUi9pQmJ6Rm5sUEVEdng4Q3JVbkVLcjlKSGFY?=
 =?utf-8?B?dVBHVVBwY1IrZTgzOEI5dVZWUmVLQno5Q1ZtZmdkUXNUV01sQXIrM3RxenJn?=
 =?utf-8?B?amtJZk8xc2xUS0RBdWxOVVVGWkg0ZVNvYmlqa1NGQXZ5SFZTT3VVUEhJMDdx?=
 =?utf-8?B?V2k5cFdtbHcwcjdRRlJ2Tk1RblBRenhIRXNrb1oxVmxuVmRLTmNKQytRb0lN?=
 =?utf-8?B?UDYxZVI3c0xyOUpBa0Z3aHdQQmhVUENoZTJkWVBGUlJKbzZiMm9Ya3dXdGpP?=
 =?utf-8?B?K3c9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90be1601-904a-4dd7-7df4-08dc9f46f250
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 12:10:24.3039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cupYtf8BuAX8+jdU3iwJSmfdieTejIVBBfy9mmwsReHGIGV7Zx+Y0CvsD3RiJTe8n6G2A9jfPv5yLbO/XoT4FaSNkArsWwjFALCbJRN0tks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10614

In case of S32G based platforms, GPIO CD used for card detect
wake mechanism is not available.

For this scenario the newly introduced flag
'ESDHC_FLAG_SKIP_CD_WAKE' is used.

Signed-off-by: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 40a6e2f8145a..21d984a77be8 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -201,6 +201,9 @@
 /* ERR004536 is not applicable for the IP  */
 #define ESDHC_FLAG_SKIP_ERR004536	BIT(17)
 
+/* The IP does not have GPIO CD wake capabilities */
+#define ESDHC_FLAG_SKIP_CD_WAKE		BIT(18)
+
 enum wp_types {
 	ESDHC_WP_NONE,		/* no WP, neither controller nor gpio */
 	ESDHC_WP_CONTROLLER,	/* mmc controller internal WP */
@@ -298,7 +301,7 @@ static struct esdhc_soc_data usdhc_s32g2_data = {
 	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_MAN_TUNING
 			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
 			| ESDHC_FLAG_HS400 | ESDHC_FLAG_HS400_ES
-			| ESDHC_FLAG_SKIP_ERR004536,
+			| ESDHC_FLAG_SKIP_ERR004536 | ESDHC_FLAG_SKIP_CD_WAKE,
 };
 
 static struct esdhc_soc_data usdhc_imx7ulp_data = {
@@ -1726,7 +1729,8 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 		host->mmc->caps |= MMC_CAP_1_8V_DDR | MMC_CAP_3_3V_DDR;
 
 		/* GPIO CD can be set as a wakeup source */
-		host->mmc->caps |= MMC_CAP_CD_WAKE;
+		if (!(imx_data->socdata->flags & ESDHC_FLAG_SKIP_CD_WAKE))
+			host->mmc->caps |= MMC_CAP_CD_WAKE;
 
 		if (!(imx_data->socdata->flags & ESDHC_FLAG_HS200))
 			host->quirks2 |= SDHCI_QUIRK2_BROKEN_HS200;
-- 
2.45.2

