Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011053.outbound.protection.outlook.com [40.107.130.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43505372695;
	Tue,  3 Mar 2026 21:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772571744; cv=fail; b=oOolCoPfO3PJFZIcs5xOaeDaHfhCdmo9tSF67/55cN2iJ5SD0oH3zAQZOv4rr2uXH2nZc99ka3M2ag9VVtHn4C/EOUAe7yPCB3XGJyAIjhDiKz65XAN522YCuJielA6YvMq1Ie4ncIFD2Bk/bqAIGPj9hVqXVkTFum3+DjTFEck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772571744; c=relaxed/simple;
	bh=pBvNrhDejTFek8eQLtDdkf2qPIpoSywAKKRJaxeAjYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MkmupXEXRu5J9D3lVoRBewIZpi2KQjFXpzAh05GYmd6rHhf0cDF4tfLkXu9CrvHRYedA8CVdFdIi85uzgYNt50bhISCVfwL03zffc+ssBjqAUcWbO/KMXAqvtaN4UsoezhHGpQG1mbJ/D9m1gu/9hm6ZAZ5uqIb6eMvA92Uzjqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Imror8Bz; arc=fail smtp.client-ip=40.107.130.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Imror8Bz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P6J7cd3DyN5tpfNdG7EK35r8IlQKQtI76XLeVTu4rUCmZMtdlXPRk1XvpAhmHnfptAv0PD+edp9qxPfDpi3RXUpwOk3tE8y4doD3oQj82sZGX92OcH/NIeavEK5HpmPtVJyLo/kEVm4jnYg/ny/0v1sbeE1LhwSxLlbSez8jrH1a4oLHbk+TsEMJXv547eSa+q2zS7b3Kj4krmQIPwHfSLXW0nSm7hd95grQPnToD0+goq8tDs5QY65gV8jj518IsHbStDxoaX69FxDPgcsaAak8JWdy7z0NeqKmCDvxtGdTy37u+l11qGGfE8V3nO+zwjffAMPnywKF/hCVYLjOjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pBvNrhDejTFek8eQLtDdkf2qPIpoSywAKKRJaxeAjYc=;
 b=CjXupkH7HxKmI8Fs1NlT+RlbgBs8jiAXtsPiJfgp2bBwWQSmaYQYT0AfGH+JxopucaK19hhU/0pmrmJhLHT60/BKiSdTkOcuGq8ZBOTUBM/J5Mv1yoT9ZjElkrU8N898ySRONp1yeiO9CHDRoltYLozdG9pwvQrEIWXPjORFy8QsbwIMRffdu6YoHAQSoVONX+6LgN6FDfoQ3RD/H+ra1qvvHOQqfUCjdAguhAqYM9TlJfbB2WuthXmTcH36wpU0K/u6BwShA6DBdsLW1gpXKXfwhBY3Dwg0VeJmn0Vxdf9o+YyamJqugn6bZXtVdEyMWTmtIQFtuChjdzvkzioiZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBvNrhDejTFek8eQLtDdkf2qPIpoSywAKKRJaxeAjYc=;
 b=Imror8BzPKqBFUA2mAGLGA7y8H29P+vj0Y3qCiQnnncpPeC4YXI0KTKj/E7Mgfrhz71HaLZ+li9if5vm+PB02jjqU1kTjU3woVq1WqpidcVCCt8ggkstrTs+FapuaLmXgHHy6CDeo2g+rKhMJ3owfjh94xU3RH/V3k1TeUn4ZvdqiXAslrqrYwOdNsxL/vJGZ5eAtEiGl/6q33AykKybZeg86HM6MhbNhOkVt8OTqaB3LvTGu27atymeCmPPrpRhnTqKPpsTIG+Buqn2/xhQh9dwWiyuTyAWmB2a0hLn2exguPQ0MKBtbn4v1kxBJfAYuRbw9hBsCR9rCR4SOnRiZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by GVUPR04MB12217.eurprd04.prod.outlook.com (2603:10a6:150:33d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 21:02:17 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9654.020; Tue, 3 Mar 2026
 21:02:17 +0000
From: Frank Li <Frank.Li@nxp.com>
To: adrian.hunter@intel.com,
	ulf.hansson@linaro.org,
	haibo.chen@nxp.com
Cc: Frank Li <frank.li@nxp.com>,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	linux-mmc@vger.kernel.org,
	s32@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] mmc: sdhci-pltfm: remove duplicate DTS property parsing
Date: Tue,  3 Mar 2026 16:01:01 -0500
Message-ID: <20260303210131.2966214-6-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260303105006.989339-5-ziniu.wang_1@nxp.com>
References: <20260303105006.989339-5-ziniu.wang_1@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR05CA0014.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::23) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|GVUPR04MB12217:EE_
X-MS-Office365-Filtering-Correlation-Id: 28ebe27a-d5f1-417b-a863-08de796826e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|19092799006|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	/n94zS6YpDrsb8dqoEWJtVWWU6X/mA3VZhVQiXe29KRzghI6e73rwfV5hHlL1UpVXXViiRsso/L2vcd5CJp1VhLfFwFVsVTrqeNE0biA8UuQwoxKGCRT4x8RvSzNn34phSrAXiGvrtksjE29ZCEX1Tr6F0V9c1OTM+B/+MWoNtnkF078REy+rTmBTiCtOJfdqPNcB1GJvoqIf6qzeTb8N7vaQHz9GMx+OUHgQ2DrC0rK+GcxAc2AYLDuffChGMRQAIjW1TANQjt2SPKsislCpgXGlVFxQer23SfLBaUsllkxqaiV/xepO02fxeQVuPuqV63tsgWdOAsKqKoVctaJNeT/wwOM0sXUd1jhppgV8HJxeYRTp7aP6Wu4dRYdI0OeqK0kzaIfm9ORjQHbW3JcYG39FZR1YlxVwRzKW7+rlpcYT/CvNEgTQ2LhSDtVyE/9cQ3+W3NZnqecG4WwsTGxuIUYimXmWmHmxh3I8ixXITt9DaeS1bh7d62Pm7QmXoSBHbjFq14OVfsE6ZqvHlEYmR+92Xb/N6GDNVgL53ciqFF1XL/1IRFyJoLbmvpvjbSr+Z4a5fEFTuX4unFHxsianFy2xb/q9XdmUl4j+k/Z8ivoa13ge5uM1kj+GdJsc4h9gGaXfDjBNRXtjHxWunC084xy5LBYT8i+CiW/mpZMIMUoeITjrnBNuiYcud5tYwkgY9nwFI/T9vHtfGqHZA0XRo6a/NBsvy9o2jfQUSerJgPGD1YEa9lbzf//fTSZpulHK2fy/UeD+Yz77hi0KrhQ1YcsYEubSHiWF2Y2si93dy8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(19092799006)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MENTZVY0Y3ZVOTQ2S1YwRklMVlVNdlMrNmRkNmdIeTRPTUJVRWdDT0RXRWs4?=
 =?utf-8?B?a1hWVGhBaFNiMG41N1NnRlJGSTNMZFJuanhCclJ2dk12VEhsY0JRMDF1bnlY?=
 =?utf-8?B?YXlLc0RVQ1M3WkNVK0k2RUl1Q09RUEdoTUN5NXF0Njg0cVNrNEhVemlYODdY?=
 =?utf-8?B?QzZqWkIxRUloU2h3cUxoNjMwYVJwVDZraENPeE9PL2xYWVBTRk9tQmVJVmxS?=
 =?utf-8?B?SVh1SXlpMGRHb3VZNmNGL2JsdUdYUjVxQ1NnaGR2ZXVYMTZHaGk4L0lUdHNT?=
 =?utf-8?B?QW84Und0TlQwcE45a0Zta1NLeVN0b09nc2tlVWVBOWpFZGRZUVVONERTenRi?=
 =?utf-8?B?NkpwK2crSjMzejl4MnZueXNGTUdGRmk3V3NNeWZhc0pEdVhIaUhJVXlRbDQr?=
 =?utf-8?B?NHpQdFp5ZGpRRmxCUTdXQ0JmN1R5M0NSSDJqb2tTd3JNTENNRDVhZmI4RHhP?=
 =?utf-8?B?NmorbnFyQ0ZyZG1GZWJPMGN4R2g3WmhQTmxsamVDOTc1TGh4ZXNZVmJabzAw?=
 =?utf-8?B?emtkT01Sbll2VDU5Y2s5WGgvVTVPaTdoQlRVOVRmVER2RE5adE50QlpmeG1E?=
 =?utf-8?B?VFd2LzJnNnNiN3U1S0dRbk5vdzVsVElDYkdmc3h1a2dGRWttYitVTXU0NE1Y?=
 =?utf-8?B?enY3YmI4QVJNRW1HblZ6eFZYZHFRRFZhZVNsM0o0aU9JSGNyWHZtUVZvTjJn?=
 =?utf-8?B?Y3JOVDkzVEtBU1d2RjN0VG5oQmJ3ajV2UXQyZ1kvRVpJenltemVGZHNsMkFq?=
 =?utf-8?B?Qk4xNHkvaUFVRkQ1Y0pRaERiZjUyNVlTdkZwQUI3UGRLUE9DV053MGsvQUtH?=
 =?utf-8?B?c3lvK1U0VU90QXhYazVEVGFvNWNMWG5NbW5mb003dFB1YVEzTlVaTnhtVmxZ?=
 =?utf-8?B?RlhkME5lYURLK25kc1FBcFc1cDNaM0RxMk0wYWt2a0RIcldQWlVISVJ2V09l?=
 =?utf-8?B?WFBtQ0tqU3dUSW9PSk8rd25tdXlySE5Ea001SytKRVhJZ3E3T3UxYmlNVDEv?=
 =?utf-8?B?c2FNU1ZaWkh3WXNDSWc4VHdIOHoycUNsTWp2VHEwVnl5azdXMy8wVGcrc0tD?=
 =?utf-8?B?aWJIRjIwL3RnVk9sUXRJaHdPMkVvTEQvS2tLU3Zad2hTcHY4d1EvNlo3OHRl?=
 =?utf-8?B?QVB5UDBBaTE5azVQOW5NOUVaU2UwaDRFMzZXWi8ramRzZjA0U2p1MWdxN0J6?=
 =?utf-8?B?YlhJbVZ0VWs2RXZaYjl4Ynp3S01BM1haeWcvcGhxRkp6ZkpseWNQUWcyVDZS?=
 =?utf-8?B?cWVTdmU5ZEtoZEZDNi9XUDZWb0dTcUV4NmZ2Yit5a2xkVTRwZXFWTHNERFFE?=
 =?utf-8?B?Qlc3UWJSZnBGczNtNGtTbzF0QU42d2dNbTBWZm96Y1VKQUtLVWdNbWFDUVlT?=
 =?utf-8?B?Q29TNDJsblI4QWVLdkh1bmRDUDFNOGNuajB5Q1RIMkR4aHNiWVVOWUtqQTZD?=
 =?utf-8?B?OTBpbndQSnVoYVlPWFcvb01Za2RyZldjMUU1MERyMkYyZjVlakVHM1lmTUda?=
 =?utf-8?B?eXBRSXFEcWw4SDMvSUpzb1RaNGpMNzNzWEM3Z1BnYnRuMlZwdmt4UlNvOEp1?=
 =?utf-8?B?NHpCZVZWMkxqTEsyYjdGclRPTnBadG5LeGtOa0I0K2RoQTZPQnFuSjc3WnBS?=
 =?utf-8?B?N3JJTmZIMzRIS0Vhc2psVFFVR1hqWFNwQmx0Y0JQR252elBlZGxSVGwxaVJT?=
 =?utf-8?B?YTk4aUNYcXFtU0JUR2FYNlM2OUFUcmhwNTI3UjBkcC9YL2Q2Z2xKR2NVQmls?=
 =?utf-8?B?VFZiZVJoL0d1VDFFOEZtUm1HYnhIMXpyRG14WWpuQWNtYUNCaVgvaTZOdjhI?=
 =?utf-8?B?aU52bG5KNTBJaE1acDJadlFQZ0EzbVl5K25PT0tvT2ZIQ2hRTlpmU1EreGEy?=
 =?utf-8?B?dExWREV6bk5sT2swbm14MHQwQmE4a3gwSlRMV1JQc2o3QnZzamhYQU1GR0J3?=
 =?utf-8?B?RW5yQmFiRGJDNms1eVdVNWxsTWVBeGNHb1RKSlBnMDJTRExvNk5Na3FINlZX?=
 =?utf-8?B?dDl5cjE5QS9BTlNtR0FWK1ZVSmo3R3loeSt1dlhNRFF5ZlpSajFTRU14THg5?=
 =?utf-8?B?L0NYVVhTR0IvVHN4K3RibjVKSFI3TXp6Z1dNUzRUU2I3ZEhTd3B2UGUydWtV?=
 =?utf-8?B?SVpzQkNDMzFDcEVhU3NOTzVwZDVSeDlkOXF0SXhhY0ZHM3FNaE4yRVhBK3Q4?=
 =?utf-8?B?V1JzN3JCZzlYV2J6bG1VZTNVVERlK3FXeGJWSnNselcyM2V5UUpZcWlBeVNr?=
 =?utf-8?B?cG5JSS96aEdkYlhXbi9KNFZibEU5cTNwdjlmWTlYeEsrWUVwWS96cmxiS3Fs?=
 =?utf-8?B?dFFod1ZjL051SWtSempRRmlJSXdsNUUxZ1dCSnZVVmNERnh2MmJ3Zz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28ebe27a-d5f1-417b-a863-08de796826e6
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 21:02:17.1932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9+PDdMpWYE4evdzY6c0UdMaeVftAacCIystn86o4g51wg6c/WjXPIARL9YPXmgE0rjBh0gLNsVmQkU4bDXIjIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVUPR04MB12217

From: Frank Li (AI-BOT) <frank.li@nxp.com>

AI bot review and may be useless.

The patch looks reasonable. The commit message correctly identifies that
mmc_of_parse() already handles these three properties, and the analysis
that all callers of sdhci_get_property() also invoke mmc_of_parse()
(except sdhci-of-hlwd, which doesn't use them) is sound.

However, the commit message should explicitly state *where* these
properties are parsed in mmc_of_parse(). A reader should be able to
verify the claim by grepping drivers/mmc/core/host.c without guessing.

Also, the claim about sdhci-of-hlwd deserves a quick verification: does
its devicetree binding documentation confirm these properties are unused?
If so, mention the file path in the commit message for future
maintainers.

The code deletion itself is correct—no resource leaks or logic errors.
