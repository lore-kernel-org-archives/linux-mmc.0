Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2056.outbound.protection.outlook.com [40.107.249.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D150E3A8E4;
	Tue, 11 Jun 2024 16:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718121761; cv=fail; b=Xsik8BQgkysrfDFRcOnsxuLgTv02JdJfxorHoZ9HegAWSIrxLU7rWqfLoq2upikrPqWNa7XJ7wW3/5kzwvbyezvopGFsIFrDe8NF8EKIo5O6WPaiSp3dtuAR2VAarPsBTII/oLp1UOlkwacQkte7BFD/pc6CMV5+JesaWoEch+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718121761; c=relaxed/simple;
	bh=55g0S+gbbRZ76IWGqbNuy73IO+tSgv7Kz9mf8ri9esg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=tshLhI3//l4q/yI6oMYdSpqy6PJIYhEL4IajLOKNUKFEiqUw0GEJc2ovhR3FlUcta55sYC13z7GcobdLXWN/6hhDJWRruuV+m9R+tu0NxCKrAflXsuvmUoUDbUIkzBUD62DIc9CS4fAZ59WHHwufMvz0cYZIEnUeYUw6Mz1jcLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=YXR4hwwS; arc=fail smtp.client-ip=40.107.249.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YXR4hwwS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N0pEwVS+VAV/KcePlD7GYN7ONbMD6a0/aO/8uBnjwA9RecsO/7/eI1q3rAJVbz7psXwfad/ePOFJd1OKxRyEoeSipMnhVzPeEQe7HBeVotYCJ55085sWAphA2FpIntl+pZyMRgM0+xqwosDp1P0RoSo9KbePUngt9Z5Iww6eEPGjk/gzYNp0Ie27UKJDgo7Qjz9HXhM8MtbNQZWtAEWCjVHSd/oYjHQrcq0VLkWrogP3p0ac2Mr1MqaeIJCnak3iwB/Ii2MsHwx7JgBXD6K1+ztwuD0usK/Bdrn0jyRkyMSrBnlYlC3Xho9dh9aPohgg71DSLJ6h7O/K/Ap7SqcQ0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4v5EZ4DJv0OpQo4MXkpZrNDJ4B5O93tZvIF1OuD1Do0=;
 b=dlFqHr81wgF0ajQ43omDbPihOWJQWhEIx4cUpHgNd9DHNRd56QQxrW8vePPdliOJFpuMboDn1JN1j9LMBVpHIC7dtyda55acLAUG5BZXvNqTTtyJKV76Pt7VlGjHbI8YJESFTpgkPt8O4TIOozAWcOHnkm2vDz5EhRYYs8+wVcVOAUn4yOgEi1IEPO/Prwtiz0T3Etup1/LO25Bj5cYDgaSIFTyMyTJUNsmulKtmcNSaz3oeQlLF8CmoRVy3607PVguPkPhS4SVNZeq+dHkeaaRwmV8+uSoP6hmMuQZ54ZCjRHCgPnvj/gYYh0x0PN+lw4GQ/V17hyTfR8+q4LnyEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4v5EZ4DJv0OpQo4MXkpZrNDJ4B5O93tZvIF1OuD1Do0=;
 b=YXR4hwwSTTBYpay8tpm57KDxf/gXnX5xClkV8ydgs1crAOcT6DOF7yH7GR0grCJWiP+6OBACEo/R+125ka1X7WIaX62+v/+H8H1hn55iQ1Pw2biz5Yso0NgqH2+2E+BwdElA8aFhzytv/n0ImXQNwB3eQ6oCXYVbgM10x3sV3CA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8005.eurprd04.prod.outlook.com (2603:10a6:20b:2ac::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 16:02:32 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 16:02:37 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 11 Jun 2024 12:01:50 -0400
Subject: [PATCH v4 5/8] arm64: dts: ls1046a: Chang node name from 'esdhc'
 to 'mmc'
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240611-ls_waring_esdhc-v4-5-d0d8a5b3f3cb@nxp.com>
References: <20240611-ls_waring_esdhc-v4-0-d0d8a5b3f3cb@nxp.com>
In-Reply-To: <20240611-ls_waring_esdhc-v4-0-d0d8a5b3f3cb@nxp.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718121739; l=893;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=55g0S+gbbRZ76IWGqbNuy73IO+tSgv7Kz9mf8ri9esg=;
 b=JzyAcxCposooucoFFWiQQO9rUnlbWdRVR1psqiMAhsPZvDcDZ3ze0ZTK2YNFW/baa93Taejsm
 I1b38cPpnzbCmWyul+XtYeMmne0CEbwAxEnQCp8jmwSI7E7IzhlJDP/
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0017.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::22) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8005:EE_
X-MS-Office365-Filtering-Correlation-Id: f6ac09f9-ab9a-4bf6-31c7-08dc8a2fe9c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230032|52116006|376006|7416006|366008|1800799016|38350700006;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OGMzNlMzTlh1VmFnTExFZktKbEhpc3RWVFdWOSs4dHF0UkpKTVByeXNwK202?=
 =?utf-8?B?N2NkNFZJN0xKak1FSjV1WUYzR2V4TjA4eEk0RWRTeFhkRXlRYWJreHpQVTJt?=
 =?utf-8?B?c3NhRit1R0JTZ3NmOHdoRE01S0FXTGV2TGhUR1lIT25SL1pnQWwyMTZjOGhR?=
 =?utf-8?B?enViS0JpcmVoRHRySVBLWEpwSnJyU0N4dm1Zd0hkMXIydytGZE56QVZDZFVq?=
 =?utf-8?B?aEEzQ09aaUhyZVNUSUN6VnhjcG1EVThBRWs5K29RaStPVDFqZisrdER3OEpl?=
 =?utf-8?B?NFBkWHphUUFXREJVYitBVnd3bm1SOVRCVFJNMVpkaFNqSFdjdjBTUThObkxI?=
 =?utf-8?B?eWsyclFBSEhqWi9JbkNvbERRZ0NEY2RSUE50QU9zL3dUQ2lwUDFmSDRiOUhK?=
 =?utf-8?B?bzVKUEFVeEwwQzZrWFhwd0hCbXlxbXNIcTBSeHcvU1hNblVvNTFiY3prUzdx?=
 =?utf-8?B?OFFrbW4yVkN2SnY1RldTOEk0NHVXUVpuR2Q4dWhGOXppbSs1QjJJTnRJS0Zt?=
 =?utf-8?B?c25MSXB4ZUZwWmFLb1BLWnNxZ2xBd0tQbW1zbzh1YlJOOTd1SkRqekxWZDhi?=
 =?utf-8?B?WlEzYzYva1lJTm5pYmNVSE1zYlhraThvTUQyY1EyVjNuMklMT0h3YjMvb2I2?=
 =?utf-8?B?eXNPR05meWZLdDkrN0thbENlbUYyaXFKUlpLQkt2dWZ4R01MRjk2VksrdXA5?=
 =?utf-8?B?MDRIY1NpTGZlRXRhK3Qrak1XRFMveUZTQWFNODdzc1dPMEFLZGhXM3JIcDdV?=
 =?utf-8?B?cTlLT3JBOEQ1bnhSaGQyTlNFVGtJeU5ub25kay9ZcmpxWEU0NDdacldxRFpH?=
 =?utf-8?B?ZXU4Mmtqa21IL1A3VG4xQjUwZkZhQkc3S2hLR0NVaytPY3Z0MjNNSVZKNWxU?=
 =?utf-8?B?cTB6WHdDdHNqSHhuWDl6T3ZzTHBKS2pQa01pMkpteWZsV0F6SG1OV0NrV1hp?=
 =?utf-8?B?cVBjbE4yZGUycFFUaXJrekw2d0lHWHFZZmFTM0dOQkFGellIU1IvYzAxVlE1?=
 =?utf-8?B?NVp5Tk9uTWxBVWREd3VSaVRJa1hUdTF0MlQzZ1QyM0EwNG1tM3ZsdDhNcml6?=
 =?utf-8?B?azloQkNIVnh0WFMweitkcitpSHFCbnVDUzQ2L1ZwZDVQZ2pnWHQwdXFjalVW?=
 =?utf-8?B?ZnZ4bFdpZDBCT2x5NVpaYkI4QTQ5TWZKVFVzRVJvVUJER2FSeEhETFNjNDU2?=
 =?utf-8?B?aGVnQ0ljdEZQK3MwalJwUzdhL2x6SE00TVZIa2d3REhUcGtjLy9VaGxmODh6?=
 =?utf-8?B?QzZTb1NicUJGWVYrUXpDRTlDSG8vNUU0WjEwZ2luTWk4anJqWWdrUzQ0Z2Jl?=
 =?utf-8?B?L3RBUzA4UmFsUWc1ZGdhSXFoVVhSQmcvVCtKNGRIa3dMdG1ub2hFVWdILzlZ?=
 =?utf-8?B?TklscU1iMVZvenZCdkxpRW5mVzhVS0lZeng0cE1icVpNZTduWHdIdlczc2Zl?=
 =?utf-8?B?NklQSUJsT25LZWRjMytka0JMM2VZT3V3cDhsVTdzb0pCbjVNRUZGaXEvdVVt?=
 =?utf-8?B?TkpyQkM0dGZEazhPaWx4U0kwMk9zYzVRNHlqZldWcUpjMlFSQnB2dURTMTlv?=
 =?utf-8?B?R09YZnZpcnJaN2RYMzdaMzd3RXhsTzk5MGJtY2svWm55bDJFRW5VNlRGMjlX?=
 =?utf-8?B?WVVrKzhqSUQwZmNqSWZ4dm4weXVLVUc4MVZLRlNPZFkwZU5TSlFZaHBQMjdz?=
 =?utf-8?B?ZHIrTGtQdUVnblFwRVUyNHNLdjI1MVYzZ1FGRk12cXF6QjgzTTRBWjV1QjBw?=
 =?utf-8?B?ZEhSQkxFY3JQR3gyTkI5QWxpOUEveVl3emNWNDdpZEpBSE9IMUpUcTZ4YzV2?=
 =?utf-8?Q?a+ZNTF5rwxqeN4XpY4m4IuTC7RxCL1pLr8PT8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(52116006)(376006)(7416006)(366008)(1800799016)(38350700006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y0JSb1FmNUlJaHlST2dqTTNhcmp6ZUNKbk1sQkZYK3hiMlU2TGgvQXFnR3ds?=
 =?utf-8?B?OXlBbTMzNkZ1eEgzWEJVUEJ0bXVEN2lCMnQ0TG05TVlMWEdBOFdhS2FVOE9X?=
 =?utf-8?B?YURFclV0WEE1VHRLUWQ4WWgvMGRjR1ptN0VqMUwvVE1TVFYwWjVBZDNTTE9W?=
 =?utf-8?B?UzNmekJuRHlTYVoxdElrWUNqOWQweTRHNEtMRktreXVOcmdQaHBzSkp5TEdz?=
 =?utf-8?B?V0x5QW8yanpSMFNaMU8ySU9QQmVkYWs3U1dGL2dybk1TQ0JJN2NmNjQ5OWcy?=
 =?utf-8?B?MW15Y1IwVm5PVXN4YVNMT0docWttM240N2N6VlpYbW4rcGpueGJRNGRiOEtx?=
 =?utf-8?B?N3RZeUVPWCtZN2JWalFKcStIYUxpMXNObVNPaXd1VHJyY3FVcm5mOHpiUUZu?=
 =?utf-8?B?SnI5aHQ0VWRZem1TZ0Z2Ny9LNCt5a2xTTkdVRENlUnBMTXh6RUxJVUJhSTNv?=
 =?utf-8?B?QndZbEJhclIrcFVhNEkveCtjRVJGaGowMEFaNzdxZlBaRC96bklLVXo4c09H?=
 =?utf-8?B?NUxzQnhWbkcxbjQ4cU44d0laRnBUa2F3VnJOYWlLTGlBQWwwci9DNHcxaDdW?=
 =?utf-8?B?OWlrcjltbmorV2tWd2lXOTQ2K0d1clFINTYzcDM4VFYyNTA1T3NxK3lwVmh0?=
 =?utf-8?B?WGNTTVkzT3VrL0lpNlRhbGF6aHhlRHdYZEVJUEFBNktBd0NQSEZCOFJmRTZq?=
 =?utf-8?B?alhDSHVmdDZSQ1NLU2lQMGwybjd5b1Buem9VSjE2SmsrTmtQbUpoTWFDd3NE?=
 =?utf-8?B?YisyeldaRUlrRmI0SnRHM0VoSFlPUG9SajZVUmpPN1NIbjBWRDBQM0R0TDBq?=
 =?utf-8?B?dWVxSGlDRTJWZ0t3bXkyT2Q4aUx6QlZ3OExqSUcrS0lRRW1ZZnd0NWw2alcy?=
 =?utf-8?B?MitrYWxGTnpaQmh2b1NGckRWUXhnL3JqUzFJYlEvdnc5MlVOSlNwZW9YbEVW?=
 =?utf-8?B?U3VGK2JQWVJVeEJkSHlDODNTRTdmYWV4TmFScWx6b2ordXlVRzYvcEw4RlNF?=
 =?utf-8?B?OHduMFpuNmtZa1JjU2tMZkRUS3ltK2kyKzR2MnRRMWtISEVPVVNsbG9PUFBr?=
 =?utf-8?B?UEZoODZHNlhNWWdQTjM3ZmpRTC9nL1hnNlZ5cnVIbGRXdzBJckM5Qi92eVJM?=
 =?utf-8?B?RG1xVTRGYzBzUG1UR254VDFXYnd1SXRVNlh4NXNjMEdzUStXbDZrZlZPWlNL?=
 =?utf-8?B?bWxacExPcXQ4dmhucHBsVCt4c3FmeXdBSENxc3hYSDZaUUtlZXZuaWhDc1Nu?=
 =?utf-8?B?UkVRV0hUL003V3VNQUFMWXJCdk95enU2ZEZjU3YxWXZKdldOeVJvMWlOMVJO?=
 =?utf-8?B?b1I5MUgxUzVLY1VXaWJIOW5nSE5keDJyTytpS1FGb1B2cktmQWF0M0d0dG9z?=
 =?utf-8?B?TXZkVTZ6TlQreEgvSnFzNVp0N2swMXIxNGNZclI1aHBFYjVaeWsrdUJPa1gz?=
 =?utf-8?B?OGEybDlSbU02M3ZCMFNvczJlRWtKTUVDMFZOdHZRM3Q2WWExSDIzcWZiSnp6?=
 =?utf-8?B?RnF4MDNvQ0FDdnNHajZ1NDMrbVdjZlU5dmw5eFlVa1dLYkl5NDNWVFNjenJK?=
 =?utf-8?B?bmNWUUxtaDU0TFpaeEhLZmhiQXYzamRvRXVjZ0VGWU5UdlNqcXYzclM3Sldw?=
 =?utf-8?B?S3VMQjUxeStHaitURmY0NjkxckxOYUZOeXhTdnlJWit5K1ZXOTVsMWQrWHRF?=
 =?utf-8?B?TDl1aEZjWVJNeUhSNnVRU21CQ1JLQnQwTVJqZDh5Vkpkd0pQdFdoL1M1NWh4?=
 =?utf-8?B?dldnbjhuT1E1MXEzVmZOMTRDYWpPZzJyb0xHdVg0SG5KQnBOWjZaMU1Ta0pJ?=
 =?utf-8?B?Q3YxUnloU2l5NzBHdFVJa0JKWUVwT0pOc21tOUFMWHF4ZzR1aDFHV0pnaWVt?=
 =?utf-8?B?TE00S0hkRWZ0djVaWFBmeXhQcFlSbjhpZ3BIcUllQTZpc0szZFhDSkp1SVpB?=
 =?utf-8?B?Q2FwTDNYbFc2b3hqTGRuUTVzT1R2NzlsTGtPb24rblc5VDROenFLNVlvR2FW?=
 =?utf-8?B?Z0RVS0FibVM5Rnp3WHFVRndHeU1kNWUzRVdqNjNaV1Y0V2pWaytsMEhPbTNZ?=
 =?utf-8?B?cWpBejg1ZnNHWE5wNVFuejhkUCt3UkNVaGF5RnlBWVFwdjRiN25VdkdHcXY1?=
 =?utf-8?Q?YZ6N6jCP5+ZCV0e4De+A5JGhR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6ac09f9-ab9a-4bf6-31c7-08dc8a2fe9c4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 16:02:37.0426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5FTCaKvV4h2ZSBUG0wlPV5T4a8ctVhMmU3yXPzYikMHu/6T3ONOY0hjR4tox7yGPcBh4FnsL+0pQaGTOVxCoug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8005

Use common node name 'mmc' to fix DTB_CHECK warning.
    arch/arm64/boot/dts/freescale/fsl-ls1046a-frwy.dtb: esdhc@1560000: $nodename:0: 'esdhc@1560000' does not match '^mmc(@.*)?$'

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 754a64be739cf..4d65093341774 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -308,7 +308,7 @@ QORIQ_CLK_PLL_DIV(2)>,
 			status = "disabled";
 		};
 
-		esdhc: esdhc@1560000 {
+		esdhc: mmc@1560000 {
 			compatible = "fsl,ls1046a-esdhc", "fsl,esdhc";
 			reg = <0x0 0x1560000 0x0 0x10000>;
 			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;

-- 
2.34.1

