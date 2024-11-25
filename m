Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2078.outbound.protection.outlook.com [40.107.104.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC112A1BA;
	Mon, 25 Nov 2024 08:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732523647; cv=fail; b=HNuEf8XrnMZojqHyhLbtKvthYX44QMdYPnEh1fCj3EPXMLgY4exbVrasE8aP0ITYn3do7Fbc1hBPOVGv7DWoLnME2Kz8762BOxzydaWrYhfDAvCwXt3enfrZAXe5I+RVS5mhK46SEZqjMx6I0P5W6+wURVOCqm4jG93VrzuKw6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732523647; c=relaxed/simple;
	bh=HoUe0C6pVV4kmDj3XBaqaUM1T84TyDQTt7WeEbqigzU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ZWwqjt9QPqomSz/fYclKXSJpUJp8yb0+EVfQX9+SWsbhdcv920U2tmgsetpB6I8gWeynBRjlVOiIgc8vsPPX1OWPsaSjD08YmUhf0oFQdSIgHckW6CUmMfMP2TicxTvXTsOZAh070ldxCGai4s85gIrwpHqRYPiOyS/pMTkLA+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=lIhwE642; arc=fail smtp.client-ip=40.107.104.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="lIhwE642"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b/tOOTF3BF4kji6Amf3NnzEA2TJLUdx3NNZOqSUI+Pu5GGpGcjj8iqE1k/isiH31iQRv5MuDoFiL/iKuYeUq5s5NDym15fGQnPqaU2J5dijylkS+SWV+wYzt6c+yaZv9wXs9xRvrTV4QzjbkmYa8JKpWYff6X/gtBqVlrUKpH6BjKqqjT2YzMCq0mqMKejLv+NiX3EgK6o3/hOKMxE/5DY+W10O/A7SDc1ntwE1+iX2J+bLT0axcXNaRutHCAlZsEyukFA3Li5ksAeHzzbV+rxJ5b8SZCoxaPhigs2pXR/k2RTV+TrWH/irdtbf3aN0ZHRVZ6CzF/sjZbCF/uAmi+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5DdgRaImBJGrmY31w50BHnYNZsbvbj/gDz5ekYx+7Bk=;
 b=Rsayc0itb/FMzuUR+ScNxGWOfNAZYFFTRx1PGB+CiY3dXkVBPrn8BfVNf2O+4TLicXKAermEsv3mR7C9XP0UCXEBgqyohKDHwIgyRGas/EjJkSe/eQHZApZ+jbmD/YdxC0Srz0rw/EXTcZe7Vj+mIOTBjmxSZ2Er4oa18KeVg6QJYKmSBFVAZ2ju4gCu1CKsVYFuJ+C1ZbOXViujvnbpWz31qmPDvL1TBvWHh33yH1aNcN8Psd4EKFxJG3qRj9UNyQEPEzbW7t6PwcblWoH7dM4GonLxgvcAgefULf31V7iBUap2lUtkfpZBp/nDxs4MUhWifIMgsBzwjwZ1d4vsMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5DdgRaImBJGrmY31w50BHnYNZsbvbj/gDz5ekYx+7Bk=;
 b=lIhwE642nLGn5mAVgqc/jBThdLWnKkJJDBcxMuMHQK4grVyfOwdfk9iofF7zyTaN+6S8UNvFq7FAoei0QVjRJx7cQSZXJZ3rxHPCXEQw8FM/L4q277ysRIW5UgUdR3MsxdRRKWs3X4UIG9RK6yj1Gi4FzGeti719gVwcyBsbBCpAHKcMW7DhAH5S7TCs0u4fAIe2hjlop0IAsb9uE4BicOItQgL6FPhLHLKdY9ekMeTjMwlysnwg8S8CR7MOUQh5hnREJof9ghbzTey4wFJxMiUD4SxNDq5QVzhnBrlhTiQYqATZSvMBRe4AtyZaAAyR6zk2qcp4R3pWaA+F5imhsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by PA1PR04MB10699.eurprd04.prod.outlook.com (2603:10a6:102:488::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Mon, 25 Nov
 2024 08:34:01 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%6]) with mapi id 15.20.8182.018; Mon, 25 Nov 2024
 08:34:01 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Haibo Chen <haibo.chen@nxp.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	imx@lists.linux.dev,
	linux-mmc@vger.kernel.org,
	s32@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Subject: [PATCH] mmc: sdhci-esdhc-imx: enable 'SDHCI_QUIRK_NO_LED' quirk for S32G
Date: Mon, 25 Nov 2024 10:33:56 +0200
Message-ID: <20241125083357.1041949-1-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.45.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0208.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::15) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|PA1PR04MB10699:EE_
X-MS-Office365-Filtering-Correlation-Id: c7439485-932d-475f-f20e-08dd0d2be9b2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QTJ5U1hqTTB6ZHNVTDBzVXVnNHkybXN6RU1sNDF3STNFTWMzdW9IZWk2MEx1?=
 =?utf-8?B?MFg5Q3RocC9NcnptQmZWaTV1K1p5bUpObWJMeEVCdmNYdCtoclE5b0crdE1K?=
 =?utf-8?B?L05Kc1FPK0FNalVNQWI2YlZIOVUzMHI5SVlBZW5XVTV6bDRYNkwxR2hWR1M2?=
 =?utf-8?B?UUlrZ2c4SktJUFdlQkU3WFoyLzVBVTF2U2JZVnA4ZlExUEd1VnJGNXpwcHBm?=
 =?utf-8?B?MGo2a3hFQ2o3SzIzS25yWXFPOUdSTC9kN0l0RzVHa0FINDg3eFhjekZDbjlk?=
 =?utf-8?B?b0IxZERJbHBETWFzdWpCVTFkdEwwblFlT0t5amlLRW9hVExHZXV1eENYdWU0?=
 =?utf-8?B?ZkFUUE92ZmM1c1Vyd05CVUJleU1ZUWN0Tkp2Nlp2WStLSy9PNzAva1VncTdj?=
 =?utf-8?B?YmFkOEtGWmNxYWhoTGE3bEtNZExwV2xqQ00vSUM2VlVZL09Yek5lY0YvYTlO?=
 =?utf-8?B?NVFMdnd4d3dzZ3FvYXhmVzlZaUJ6bVl4Y3hTQTBJenpFcy9wbGNydFVUUFRY?=
 =?utf-8?B?R2lUSVY4ZEdndllDUkh0WFY1UmpuMnVoYlplNjFjUmE0Mm9lQTJuM1RLVzh4?=
 =?utf-8?B?eCtuTXljVWRGNWErTlh5c0w1Y25Da1lCVmxZaDVQRkQ0SlVSSU53bFBLdHNq?=
 =?utf-8?B?U3gxRDgzOTFHckxZSzlrcUVhMTlYZDdFL2w2S25OOC85Z2pTVkVpQ0FibVpM?=
 =?utf-8?B?ek9jWVROWVNja3lZMmphTDdJN2VFbXRnNnZTR2FxZ3RIUFlaYkVIaDVub3VE?=
 =?utf-8?B?K2hqajJiaThwdmR6NmNTY3dRbTFsN1hmSldONGZxWEpzSS93c1ZKS3g5TTdT?=
 =?utf-8?B?UDlxREo3OGUxTDZwVFVFd2orV2RjVlFXbHRkT1BRZmpvZVNSOGdqd2FWMno2?=
 =?utf-8?B?NFozM2MzeXM0Z3dySTFSSmpIbXQ3Q3FQQTJwT09Ub2Q0VVhHeVVqNi9ISjVj?=
 =?utf-8?B?eGxpa2NKOWh0bGhSNzVnbUtYYXMvK092MmVFKytMUXlRUURHenNiUmMwTkx5?=
 =?utf-8?B?VERBV2tkcUpXaXNnUWpwSllnSXdYNTBQaFRHNmRlS2hMRDBDVjBYNURNRDNU?=
 =?utf-8?B?N0RXcnBCQkxVRUxmNmhCT0hZcUswdTNMQnVrODhYOXhkV1ZMakZPejlHZ0xo?=
 =?utf-8?B?cGFVUStxNVlNUXpkZkdNbEEvMUhTQi9iZWs0SHgwaDBycWpoOWtuSGRTNC93?=
 =?utf-8?B?WHpxUTRGTFpUMjNMT0VqWlp3R001R1Yzc0FyZGprRGNBaHlIM0s3MlNwb2Y4?=
 =?utf-8?B?UGN6MjVzTlgxSnI1RWNNYUdtdmhNM2s3WFJVVWZZbVhvaXpBTzFHVTRJTndS?=
 =?utf-8?B?NlNFaUtYcGw0RUNBQk9iZzFPSHlUeVZhamJ3OFVLTHkwa3BFQTU1R2gyT2l4?=
 =?utf-8?B?YlZwT01mL29vUE1sRlFJVU96WDNnU2tFN2dNRC9PUC9Nd3NtSktIelZkbzRw?=
 =?utf-8?B?akVLZWNoVEhydCtUT1VGSk8vejhXWjBtblRRMVN6NSs5V2NwQjhBUzJyNVgw?=
 =?utf-8?B?NFRFNk41SmJaTGptZTkwVm4wc1BIbUNtQXJoMEJ3L2taeG9sNlhnRkNqaWh6?=
 =?utf-8?B?dHdwNkVEVHhzWjNqSTU2NW9oU0FYSnpPbHZKZWl4YUpoSG9jTjJ5RUFqVFFv?=
 =?utf-8?B?NURRRndLV2JiYURNR3FGREFGdDA1UW1GZGgxYXRMSFEyT2R3d3U5THRURkV3?=
 =?utf-8?B?M2lSdDdOK0RCYzEwVDlZN203WW43YlBhZnlhdVNOUzFoUWVWWDVOWno2cGVK?=
 =?utf-8?B?eG5pQ1JJQUVtM2hOaVNBTFBVUXdNOVltT3JENEQybXc5RXhyU3FLU2w4dTkx?=
 =?utf-8?B?UFF5M3RMM0c3UlFuR3hzZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b2M4NG9KRkI2REtNYWFyODJJWXVQTkpGaEtqY3k1aVkybzc5eW8zcXFXbXo4?=
 =?utf-8?B?R0NkR0tKaS9nWWl6SDBQQ1hDSTlLRmhXNDJtdndFdHhKaGxLTW9vV3F6TnNT?=
 =?utf-8?B?WGNFSnR4UCtVOHpDSlN6N2NnclNYdSszcXp6YVJmNFprOUxPSDN2Y2wrd3pN?=
 =?utf-8?B?VjcwVWpLdnVmVGFGOWZZTGxEZ1c5RURKb3czWXdOdForc09jU3lBNzZ1eCt2?=
 =?utf-8?B?ZWVTaXpHaWtlbVNyL0lxWEhoL2RTekIxSlFpZzA1eldvNTNuTHIzbEp3aTRh?=
 =?utf-8?B?NVpUc2pMN2x2Vzl4ODlkZ3FNSmV5Qjl2UmowYzZ4blQvTnRrSmF6eUMvZjdR?=
 =?utf-8?B?eE9HYUthZW5ubjlkcllEZkxqUTA1YnJ1OGZ1ZnB6dmE4Y1FIVWpkdHU0MHpX?=
 =?utf-8?B?V01ENXYrM2R6MUlXOGtoMHBlUlAvWEd0RERYMWpnL1JHdlRVR3Z1UktkYU1E?=
 =?utf-8?B?blJrejNDYVlOMmFzUXVBOGJyVWEveXNWa2JBZ084cS8vNkU3bzhGeFgxcXB0?=
 =?utf-8?B?SG9qWjQwSW5NUi9vaWVoMU5mZ09kV3RZVnlHRlBNclB0cDFwRFpKdjkxSUF0?=
 =?utf-8?B?VHBDOXVsdjdLamxlZ3JnanJaU284ZFVLSUt4TlhMRFJSTkZkUmlHYUVXNzRD?=
 =?utf-8?B?dW9UendLdVp0Z0hhUGllTjlDeHhhNmljMjNtblpveklpTUFhMFRmclNCNlhD?=
 =?utf-8?B?MU5FbkdVUldaMTdwRm9ZSWJmQVk1QjByVzBlai8rSUNLTFhaWFI3SWMrWmxp?=
 =?utf-8?B?ZEFJZE9ubzJ5Q0ZqR2hReDkwRGRBcW5EVHgreVlsRC9lcm5SYm1jUC96OGNh?=
 =?utf-8?B?QUZUNnRmQUxiVVBIYVVVTXpYdkp4ZDgzdkwrR000MkNkWWxlVEY3WDI0OENt?=
 =?utf-8?B?VkRYV0toSitXL1Jxc0NNbWo2WGNSaEpzSmhKWlA4R09yamdZaUhneVBtWm9N?=
 =?utf-8?B?bHRsRzJybUVIUVh6bi9SZEVzbDNibHpqbm9YLzdLNU41TkQ3VVpzVmZpWjlP?=
 =?utf-8?B?OTFiRUhQUTRiSzY0MEd5OXBkNzd3WlBKOTBibkZlY2drNVpqUDBtTzQ4bGw0?=
 =?utf-8?B?YUVPd0hicVNxRnI1eGpkSjZRbld2S2NVYWtWMzZESG5Tb0huY1l4Tm9zeWpR?=
 =?utf-8?B?Q1Nhb2pxaCtOUmZwdlp4am9WUE1QMzBDVkZ3djNhb25QZFBhL3dNenozSGFF?=
 =?utf-8?B?ZmxDQ2N2U05tN0RhbmdlNE1sMmoxcXN3Z053NGZldW9YaEZxKyt1WmtoVFox?=
 =?utf-8?B?TTVCbUtwaXpFckhIRndpa0piVXhmWlptblBQOEROWklNQ0ZpQXZ3WitCTFJ1?=
 =?utf-8?B?NlVLM2kyNVFhVUgzNUVsNzlDRCs3YmEycW4rUkRVOTQ5bHFKaWNCaktndzFw?=
 =?utf-8?B?K0R1ZkhPUUowT1hiUVNzaVRHcFV6Z09WNzBQUTNTQUhkTTEweU1zK1ozSzZq?=
 =?utf-8?B?bk9SbUtxUUZDMkdYRExUMW9leXhmN3BCdGpkd0VkVDYvL0Y2cjd0Y281THRM?=
 =?utf-8?B?RVZub3dhL01ueWYwR3I1TVV3NnZudXZmMXhTZUVaMStCQmRsM1NzZmhMZDc5?=
 =?utf-8?B?ZFgwaWdObkgxWGZhcnJ5Q3FKdDg2S1p6R01ORExnM3lQUHZwVjRNdUVEeUpV?=
 =?utf-8?B?MXAzMDRxdkQxeFE1M3BLZ3dQK2FHZ0kzTDlPVFhyWC9oWXFOUkczZFBYcmFX?=
 =?utf-8?B?QjBGVDNCaHRlRFB6WTEzazViR0MwYVA0NGppYzBJeHNPeERjTmNOSXlPajQ3?=
 =?utf-8?B?c0E1T0J4K3B3NjhwYzdFRUxYM091RDVqS0lkVDJaemhiT2FDa1ZZckVSM2hR?=
 =?utf-8?B?Sy85OXZ0ZXZWLzJmdGZFcDAvKzFwNjdWcnBYUTVpaUZzL3FlNzdJZzdpV3hE?=
 =?utf-8?B?cEN3SEdieDdJNHZHdmg1VmsxWU9BOHQzWm9xeU55WWc2TVYyczduWmNKdHFt?=
 =?utf-8?B?U1JqMG9Qak1sUkZ1eURZaWNnbTczVmcvTDJGVndwMFkveDlEQTdzSjNsaFBN?=
 =?utf-8?B?S2l0SEhlYUhqQWlyUHppK1dhU1FtbGhqWWZESmhlRkt2YTBpcmJJR3JJVWFW?=
 =?utf-8?B?RDJETmtJVHJQYnJQV0hiRGZNSUI5bFB1aUkzSjRkdnAxaVRFMzhZZ3VWUVFw?=
 =?utf-8?B?SGJmazVVZWI5OWszeDF2VUlMaGZ6ZFJWWEMvVFJmbmU4cU13dzVQSmwzeTR1?=
 =?utf-8?B?TUE9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7439485-932d-475f-f20e-08dd0d2be9b2
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 08:34:01.4287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3IrhZaJJepbrru3+1QIQo3BKjNVgv2Vmm9eLN3sPprN+jrMU+/S4U/44U5rtl5zPp7CmSPoaIR9vFUugmQangBWcnzWR17e4KBGcD3DP90Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10699

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Enable 'SDHCI_QUIRK_NO_LED' quirk for S32G2/S32G3 SoCs.
S32G SDHCI controller does not have a LED signal line.

Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index d55d045ef236..e23177ea9d91 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -304,6 +304,7 @@ static struct esdhc_soc_data usdhc_s32g2_data = {
 			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
 			| ESDHC_FLAG_HS400 | ESDHC_FLAG_HS400_ES
 			| ESDHC_FLAG_SKIP_ERR004536 | ESDHC_FLAG_SKIP_CD_WAKE,
+	.quirks = SDHCI_QUIRK_NO_LED,
 };
 
 static struct esdhc_soc_data usdhc_imx7ulp_data = {
-- 
2.45.2

