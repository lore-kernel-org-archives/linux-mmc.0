Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2040.outbound.protection.outlook.com [40.107.249.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE7B145332;
	Mon,  8 Jul 2024 12:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720440642; cv=fail; b=rKhiZcS2OqugTxSa7VEO8q+XVfxti4J5OfC4eBT9OMlXTyMV5kF+Gpg3HqPUBAfc93ifLT1zPdXeuEsIo+/6mHbVvM5Eg94DqLM7+1MhzdoLr5VmQCz7NyDEGP5tgSdtQxMPpG2Fkcj85A6aSwgTphfObefnrbHdySotHtmxUNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720440642; c=relaxed/simple;
	bh=UvJ//py6u04igD8qG8neO2Kzkeg3fYEFwQSQ2MmZYw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GpDYdwYACKGKog2v1+dvWmha71NrvwpEpqD95fCx+FHFWZ3OwUSjN2O2Bg3TeTwp87Bm4j+FmUNBB6YzpbxaGooZ2Spfwf0PVfPFjreXEQkF9nHNFt0MGfdr+vbTGwB0coMGf/CjXISB3maGqrkbgj5GiiDo7gmdGhDkxRp4nHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=S2ZxmEkd; arc=fail smtp.client-ip=40.107.249.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="S2ZxmEkd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DqeP+LmeM4ZWVnZpLclvgp2wek7OvnaZ6zAY1EiyV4L1P3EOX3lQsCNy2TqsdTQOMOMnaiGY3yQ49leIUcd5yhm4RS3OBZjeFFvCDzLAoCkOnj98Jr4pzNHC9Y1rltdCNe4ZB3p9hTYOkkwhO6Z0NljKgmOauVLoCcnWLAf+rgesH2iyE/QkJX2QR5EucOCDvT6iCxd4Iz8A5KR6gO9SNDwTQ9l632CaTSiMHkQM1AUTYJMOQu4yCul++wM8VAUI20QxuCQ4pRW9zFfxED3YAR9AgdA5/j3x6HlJ9XCCU04GYv4nG7achT0UDH9ph0UOCpOHR3cG1U5jbK5z9b5s3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nmzi7pzRdCyBH91BfJgTLrJfH9xHWssBPfiXsqupkYg=;
 b=gXdLbmzSsoQiMo/dRCdUqNdbwikQSrZp1pg+TsSwGkzkbMX9QTS1AnAfb4j9qjJNKAekNp9x0U0r3yOyck/ax/UMXgmJ4qf9FBfW00aRdXRFwakALdoUQaLL2gao1ajyk6PUHli32fuiEYzRczeknzP4Lg5EPIAN2pNdkswyu0uvO4nN0O0uIq1iSO5fJSbjAnAZ1jlC1J88B1BA6hlCH4VcGEfYFNcWMUYIH2V6TJgE0ZmAZEc3pbR9FhIUbiNuZRfj5wfAM7BQDV8/CPrBeHH0ZfZD0c64H9A01IzTkk1mBeQx0xwIlRDrk9sokOHlg2U147vpmMcZp7r5EdeDQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nmzi7pzRdCyBH91BfJgTLrJfH9xHWssBPfiXsqupkYg=;
 b=S2ZxmEkd8LEvbLsILTRkaeOaQkgAP3f6nN/V9P39+kUAV26+hFU1TPn21ta2ybMncIKiNVyZzUBhIN5OjJWbCNV0jLqMIZBVeNaxOEDOGR4zPbNBU9lCZD9c359pYyNE6R89aAOINI0sU4Favi24Ll0K/3upFlrXs7bnbmgvDgY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by VI0PR04MB10614.eurprd04.prod.outlook.com (2603:10a6:800:260::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 12:10:27 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%5]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 12:10:27 +0000
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
Subject: [PATCH 3/3] MAINTAINERS: add 's32@nxp.com' as relevant mailing list for 'sdhci-esdhc-imx' driver
Date: Mon,  8 Jul 2024 15:10:18 +0300
Message-ID: <20240708121018.246476-4-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240708121018.246476-1-ciprianmarian.costea@oss.nxp.com>
References: <20240708121018.246476-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P190CA0003.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5de::8) To DU0PR04MB9251.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: a72d173e-cc8d-48f9-f2e5-08dc9f46f42f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UUYzN3FtOTdpWmt1QVVRbUQwcHpveVpBNkpLcEVKMldUckRtQ3pFNDlXWHhE?=
 =?utf-8?B?eVE5SERCT09HcDQzQTh6RndKcWVlR3BFUzExMmZ6cTlXMFhWaE1YNm96U1RP?=
 =?utf-8?B?KzdVSDRlZXJGcU9CakxLTW1OOWc4VjNkMTRMNXZVUVBaNUtqeUxWRWVmejYx?=
 =?utf-8?B?bVFTSExNQ0xWOVNRamx4cTd2MUw2QkFQNFd6KzJYejN2bG1FT01vWVBmckxD?=
 =?utf-8?B?WUlJTW1TOGh1TWY4bzNEaElOZWs1YldMNmtJaFRpRHEwaGxJZVRRNkx3OU5p?=
 =?utf-8?B?VUt1akFaM2pWMlpyM001ZktZbFVSRVJOeXJTOXFjaWo2MnZCcXpqSyt3ZzVO?=
 =?utf-8?B?ZHBNZldJcFRGaHp0WXNOdEp0Y0ZsTkt1TGU0cjVveVJic294bG01c3F0MzZB?=
 =?utf-8?B?eU12OUt5Y1kyRTJwZVMxb2VVWG9jRS9TcExQMDRrUS9tczBzaW5yRXJKaEdu?=
 =?utf-8?B?blVxUWc0RUhJTmw0Nk1sNnNqVnFEWUFpZWc2MDFWK29FcVFBYXV2U3FxY3NW?=
 =?utf-8?B?dVA5eUh5bkd2MXVTVnpEMzNWaGMyeFhiUXJmMi9vdG15Z0UyUFJLR3N6cTVU?=
 =?utf-8?B?ZEZjZFJJaGVBU3M2clFjbXlyVURXREhxbmsxbllJc0ZTSUFoZHIzZUJraEhx?=
 =?utf-8?B?Qm1SQmgxQlUyL2VvQzlZNEpMWUtlS0ZuTE42a1QxZTZiT3lRN1pEV3h6VHpM?=
 =?utf-8?B?VjhkL0hDVGtnbG9RWXVIUk95enJOUHZobGxtQWlDSDRQMk5ycmo2T2x4ZklP?=
 =?utf-8?B?ZTRJQ284bHpEbjlWNTZFbHhRQ0IzTVlYZEViOWRyNEdRUW5mdjF1R0dDSzcy?=
 =?utf-8?B?Si9aTTJaM01mcDhLc1AvZWdhTFFFZmdCbm8wK09CeWIxZW0xUEQ1OVQyb2F0?=
 =?utf-8?B?a0RJZXo5Q0FHbXcxYmMrYit4UVB6Z1dMRlJuQUE5Nm9ZVFdWVUdwblBaaUk4?=
 =?utf-8?B?ZmRQZnI1cVhVeGhvUUtWVFJVSDUzOEx1N1N0aTkwcHRCdldEQjdKUnQ1Q0hC?=
 =?utf-8?B?UXRTa3VQVDlPdTZGODhBZncweEs1bzBwemh3bi8rNU5jRTBSdFYrdmM2VWxw?=
 =?utf-8?B?SDF3MVlMOFQ1YVRHWE41cXZlNzhZeXMxekFqMlR0bmJnRWNJeWtXWGZLQTRz?=
 =?utf-8?B?QTBpb0hxSTBMV09TaHZweEl3cjJSRmUyOFVYSHpYMm5QSzdWaWwwVmNUZ0ZW?=
 =?utf-8?B?Y2tVRk9aTWxNcGRRa1hjY25BWC9HNEtWMFdtaytPTzVzcWlieTdpUEFxVElB?=
 =?utf-8?B?UXlvNERVVGMyNXl2N0pTWG52MkRIVUROVFJzODFYaXVXNkFSOHNrcXpiZmpT?=
 =?utf-8?B?aGpDbUE1TG8rWnBENk1wc1Y0QkVsc0M1M0w2Q20vR3ZjODlpSG5uT25kNEFI?=
 =?utf-8?B?VHA2Y0syVnVJQ2loVTQyRng5dVZrK2RWVXMrK0RXZGxTdUpHY1VZODR6R0h3?=
 =?utf-8?B?Q3ZPSU4yaVpuc3BiMXZEQXdsN21rd21JR2w0WWFtZGhUMWFkK29yZzdjZDVO?=
 =?utf-8?B?R3FzTGNnWHVMaG9QODhVdVlSWVlHQzJBaW5ab1hlbzQvOHJaZWowT2xaRFhB?=
 =?utf-8?B?N3hJYUxmWUJyRUp6MVY2YWpPMGoyRXNZOFFFWHdyaFBBVE5pc0NNVEdGcENw?=
 =?utf-8?B?dXQyR3NiRGJCaUpvcWE4bkdYZVdETmkzYmRtK01KNEYzQm0yQUpYZmVtWWNi?=
 =?utf-8?B?eDJXd2Z1YXI2UzVvc08xTlVXckZwb1VGNFE2VUNSdFpIbVEvUGlxU1d5RVpq?=
 =?utf-8?B?bGJoM0c2bFFJMmFWZU95QThIL1NSRjErSThZemdYWVlGQ25CUHV5dEd0ZXhu?=
 =?utf-8?B?T2Z5T2l1UHlhUUF5aytjZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TEo2ZXJmRVNQRXJ5UmZidnFMc1FNUGdlelpZZzNpL2VjZHRTNGhlSzNta20v?=
 =?utf-8?B?NHZCN0FJNHNTV2NobnpwVGpWaG5HRmlmcGNkWEowc1U1MXNadlVrQ3Rsc1Fp?=
 =?utf-8?B?MktvWUZoZkNDbFJsZDJxSURwaVg5aDVGSVJwK3lRL2dmeHEvL0xuYUhFMm9t?=
 =?utf-8?B?VUxuWHd1MzVqeCtRVXlCQkpnR3d5WEdxNmh6VHNYUDdYWTd6alNPb3htVnkz?=
 =?utf-8?B?N3ZjM2x0elN6eUs4UUhCb1h6OGlSWGJMOUMrRlkwSjY0NGZtY01Kc2JqaTlv?=
 =?utf-8?B?QnNWc3JhUllBdy9oNjN3QU03SXJmWmN3RjhWZUVndWUrSldxeUZhZHBKVnNz?=
 =?utf-8?B?M0pMaVJEZGliRlI1bHMwbGY4OW1lbWpjeURpbFlUeGF4R1lQMGhkLzM3R2pO?=
 =?utf-8?B?eFlLdEVlTjFNMTlXTjVYR2pwZk1SV2xScVdscmtOcjQ5RXhxYlVaQlBPNnVp?=
 =?utf-8?B?Z0MxSG5uSytzTXE0YitUVFU4NmNLYlcwVktoWlZzaUkvaEYzeFNoSVgwcXZP?=
 =?utf-8?B?cFQwQUVSSkVMMmg1MzNnU1BKeXQwSndoZ3RDT1NkZHN6U3h4WFU5QmJaWUJX?=
 =?utf-8?B?YmxPWFdodTRJVEYvRGt5Mk1tRjk4MThVR0dqQ2owcnpwL1pTRko2dGczQ0F6?=
 =?utf-8?B?enlFQ2M1cjJVT2ZhcytjK0NDNHM2dmZRZEQ1TFpBcTlvNjN2WlZkdmQwVjAr?=
 =?utf-8?B?WnRyanY5QzcwMVJSUXQ1bUZ6Umg4Kyt0bjV6U3k4R0txVjRGQlFqYjl4Qjdq?=
 =?utf-8?B?YWpVV0VxQ1YwSi9iTm44cjRkMFQyeFF2LzBtV04vMks4Zk1rZWlTMGVpaXN1?=
 =?utf-8?B?dlRWeFM2TE1IQlYyWk53R05TL1o0K2RkeFROOE5GRUI4Ty9zWEpoZ21heGVz?=
 =?utf-8?B?MUVMdnordTlpUWk3NlhTem1BM2duR2N3dHpDWDBsNEx6aW5yR21oaGYyeEFu?=
 =?utf-8?B?OVdzL1V1L1FYeC9TaEZKYWIvMURvSFZoSDBDMHdqYUdzSnh1VW9IUDEvUmtI?=
 =?utf-8?B?QmRyVzRSNVdZNUtLTStVTnlINTE1NnIyZk1BNGh1MkZXbTdhaUdTdlQvV0h1?=
 =?utf-8?B?M0F1RU13UDZGOUtkQW9UNDl5NzYzbHRxa2VLUTE5TFloRlJ4a0ZyU2s3ZVM1?=
 =?utf-8?B?M2tRT1BHcWd3THBYcVhrVEZDQmI4dCtENTh2SFVXcVMxOFhqdXM3SU9nUTI5?=
 =?utf-8?B?WDBtN21MUGNtY2kxTkUzS2NKdzVudm5xT1AwR1RPZm1ISDN6ckdHQVRXcnFn?=
 =?utf-8?B?clpPK00wa0h0TWs1Zm5raHk2a3dTUW1UNUhha3E0Z2MweFI2Y2laQW4xb0w4?=
 =?utf-8?B?YkRCL05ndUpRTVVFaE1BdmhHRGtUdTNrSHlRTEtpUG12YVRRMVhTVzZhQ3lB?=
 =?utf-8?B?bmMvVENodjc2aDVMRE93aGtNU1BzNzNmbzJsanhNOW5QTExadjlWUVRlTHE3?=
 =?utf-8?B?WmhwZkJqeWo5VkZwK0VVNk1GazgwOTA1aVVCZTltWm5LckZLeG9LaU0zcEdJ?=
 =?utf-8?B?V2FnTG9UcUFWbzdEMnZrV1Y5RnNxVTZxTDRrOG55a3lWenBKbzd5Wm8rYmRu?=
 =?utf-8?B?RDdORHp6czU1QStHMXBrZmJSMWh0NG9ybFJzTVAyc3pTL0syUmMySEJ4ZGFr?=
 =?utf-8?B?NWdMSkdyZEQvclp3UUlTQmVOREdkWHZVV3NSdkRGYkd5QlFNMnBCekRMdHBG?=
 =?utf-8?B?SEtvSTNTZ0VWM3BDU3FkQTNMMC9SWDE1SGN6U2FWMzdNQmVoVEcwVDR2Y1Y0?=
 =?utf-8?B?N1hKZXl2cmFtbGQrVGJFTjV4eHh2YjNVeVhjYVNDYmdaSGlWRzI5MjZDSGp6?=
 =?utf-8?B?YTlhaUVwSHZLNVFkNEhRNjVjdnFaY0xkYTU2dWVsWjhwOUhlSFhhUzh2Vm1j?=
 =?utf-8?B?NWo0UWUrZGp6SE82WTBEcnNXUlVyOUJNUUtJNU81QjRMRGU4dUpjTjlIL0NS?=
 =?utf-8?B?akRrQUI1ME8xK0NzbHozQkRqUkdSd2VId1I2eEdyL1RsbEFqRCtiRVlQNm9Y?=
 =?utf-8?B?QUxrbk5vN3hvdkd5bVVUN2txZktTS2pUOUo2Qk5CbFNxZ1VSeGJZd1pzcmpw?=
 =?utf-8?B?YlJkWDBzOURBbXpYcFlWa2IrcHdhTXpmeFBJWDh5aGZuVVNKTkltQkhZQU1j?=
 =?utf-8?B?MGh6OEVNU3BiVmhwUWZjZW1PcEp2UzBBdzF0K2dxZkdDMXZXR2k2U1FXY0t3?=
 =?utf-8?B?bUE9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a72d173e-cc8d-48f9-f2e5-08dc9f46f42f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 12:10:27.4168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JPJXPW9rY+HUPGCgN4gSKVxLbtYBin0bFXUdq90NVjF2AsHUXABpdMIghbNpFklUE3yJM3wGPD3QYrbroLJajViWTBIeoL3TOXBrJICZifo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10614

Since NXP S32G2 and S32G3 SoCs share the SDHCI controller with
I.MX platforms it would be valuable to add 's32@nxp.com' as a
relevant mailing list in this area.

Signed-off-by: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a39c237edb95..26b1ec2ba094 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20098,6 +20098,7 @@ SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) NXP i.MX DRIVER
 M:	Haibo Chen <haibo.chen@nxp.com>
 L:	imx@lists.linux.dev
 L:	linux-mmc@vger.kernel.org
+L:	s32@nxp.com
 S:	Maintained
 F:	drivers/mmc/host/sdhci-esdhc-imx.c
 
-- 
2.45.2

