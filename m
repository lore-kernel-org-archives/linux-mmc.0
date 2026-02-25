Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013016.outbound.protection.outlook.com [52.101.72.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15232320393;
	Wed, 25 Feb 2026 08:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772009561; cv=fail; b=AjKk1BOuDKIWaWjbbLwF5XeWY6eWZAqdwOhy36WI7ztWnZWRTFtZ/asM/seRn0Lqb/s4DWBFoYQULlb4Han4V737xm0BTEi6vsCeLuZo2rkTsDa+loOQ22bNZ06H6SB6DvmlSR9okhcQBIM5ETOyDVb4ZE/jocCAQtl0+c/JeZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772009561; c=relaxed/simple;
	bh=0hbDLuOV2eEe/ttCTH8DEsetGyLgUCYQSh0i0uXRTkM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n9iQPQ6794bVbWYvmayaImQcHVjiEEfciFL3axMOB8qz6qKO7BgvdX8k1xvSDewZjFsr6n5vHekyrSuSHGwdAx6LDQ4SJDdzal0oC5wYwGYVn2s0ttnn8V1RmA4D6bGVTwPAOPgg5i+PJphLOBZBPeyORgZdnQHi9aBiMGtKiCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Y7dOASLF; arc=fail smtp.client-ip=52.101.72.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Y7dOASLF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ICYFbjv5/a4FKfn9s29Rz3/4RJCprSA2sapWQEseDzq0FVf//SpxIfapAlyr+TVOGay9ndn1MvXrGqto6blTTIsnfM/TRuXcnCn7hBQZZQISZUyaLx4GoYoaPtVpHFYQ3d2PVRqL0GC8bKIgoHU0L10U9YlRjauNSVzjQV/7AaLlRZEEY+7Be9tQmEKkZ77YrrNzri6ALb5DFjcyPdHWzd+C8VkeUt+dQlCDbNhtJHez67R01hVrjlXWRZU7GAnPApL0h7B82UWDX5ew4KN7UTogaOmBVVj2oGgR20hdSGpIZr2F7ADXDU94Iox5JLCn6ySmhVKLQqMJWxcAl2r3cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7WdJZaRBYMPAJJALkPlmSv14FTKxviO/SfS+qzYVH2M=;
 b=OJPhT1HsEgquqyW9CMGWwpZrcjBnGoo6MP+ue1o4Ogwz56WJp8rncmvj8eD5QW+QB3Hg8GuaSBvjg29jZmDGT6AZ6UBq+evnEM8DswWQVPnktGBWbsjgWZ+WoVitEFP5k1eKzN4fOL6cNR/kNDwlr59/F36cjATbQb4g1dk/qvPCeEWrVjEB8xP3IP/zFH7gsuA8GqNH1AbWoZPIST3OD8fI/QOZAJ8pl1t1Ri1Sc33NqXJLBJd7YNOlAO44vP7HeTTEJEMZ6owwpHdQLTQNDOp4D76hnW0ljLiTneiA85Ol6F98gfc6H9PC9BMq3k8sgRiXk2xkrrFmbe2tWLGjWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7WdJZaRBYMPAJJALkPlmSv14FTKxviO/SfS+qzYVH2M=;
 b=Y7dOASLFEP1JDE3fQJ8TlaZGiAynJorAhn402nt8EqaUBpLIq88pF3ev6iVEW2OMwepQcy8Hoe9XJlteeZSGo/rfuHWz650YIDcgF6w7ion0Stkunqp/LC4ncSCC5lOYr5hpWxmDrlXc+vDlrEiRA1h/MKdnHlinV0tcdDGpGnWgiwVu+tceTPeiYj1ufyB3VD8Ty871oq2fLj6eF01BqqRR8GHp+fPpdL2ZS+dZkkvN9lCJJUgYOd8Zpd10XlVizO1FQan/mJXBakveStVthKQs1bqEQsc1IvpOGRlt6hN7pNyuDPIQUUMvUSBlzyan68WmHq8N9431g6yV/X81Ag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by DUZPR04MB10014.eurprd04.prod.outlook.com (2603:10a6:10:4db::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 08:52:36 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::5c3a:1a67:2e02:20d0%5]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 08:52:36 +0000
Message-ID: <62ce70e9-6075-4042-bc29-cd6eacbf17f0@oss.nxp.com>
Date: Wed, 25 Feb 2026 10:52:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] dt-bindings: mmc: fsl-imx-esdhc: add S32N79 support
To: Conor Dooley <conor@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Shawn Guo <shawnguo@kernel.org>, Lucas Stach <l.stach@pengutronix.de>,
 Christophe Lizzi <clizzi@redhat.com>, Alberto Ruiz <aruizrui@redhat.com>,
 Enric Balletbo <eballetb@redhat.com>, Eric Chanudet <echanude@redhat.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 NXP S32 Linux Team <s32@nxp.com>, Larisa Grigore <larisa.grigore@nxp.com>
References: <20260224111533.3194883-1-ciprianmarian.costea@oss.nxp.com>
 <20260224111533.3194883-3-ciprianmarian.costea@oss.nxp.com>
 <20260224-remote-deliverer-958fcaba8bfa@spud>
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <20260224-remote-deliverer-958fcaba8bfa@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0017.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::27) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|DUZPR04MB10014:EE_
X-MS-Office365-Filtering-Correlation-Id: ddfc9b9a-c6b6-4034-bca3-08de744b3919
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?alEwNkZzS25KN0l5Ymk3TmZoazVvd1Nua0pLTUthK3I5ekF4d1ZSeDFQR3NY?=
 =?utf-8?B?ODZ2NHZpVjVJbmlLQVFMYXFxUjV6bEFvUkN1MTIrYWc2YnBXZ0MyRzNyQzdE?=
 =?utf-8?B?cDBYcUorZlI3VzFZNGtrZ1BqdHIyN3FhRFNCWUtqS2E2SFhYRVQzQ2RUSnJE?=
 =?utf-8?B?ZW9HSXAxLzVUMHU2WC9vOVp5d0I0RUtJNHl3ejhQU29PVUtOTi94Z0FIdmlG?=
 =?utf-8?B?NDlQVlZ2bXFDM3BHMzJiNDYrUWdvZWZ3UVF2QytXcVpEb2xmd2pYQmk1dWVU?=
 =?utf-8?B?MGNHbm9hWFFkTTUyZ0pXVXdYakxpVjVQUThhUmptUUxJOHBMdnNuaFlZakIy?=
 =?utf-8?B?eHEzalZPcWJRVDBWTUUwMjBvUW9VM2daS2Q0cDR1OW94M2xhbWNobVZpQ0pl?=
 =?utf-8?B?bG1UL2RCVC9yRXFvdzdFS2ZsaE5NTGZtUk1vQWIwWEVYSHFkUHBkamVFaUho?=
 =?utf-8?B?M1p3ekxiczlncHlhVlUrS2lMK0p6M0JWbzB5WkcxSEViRmJiTGpnaWE5eVlw?=
 =?utf-8?B?SU1vWThRVkZIUkdFSWdFcG9SMm9GUVVaRWVvZEJjZGFXUGw5WTNXWUJCWEcr?=
 =?utf-8?B?R2daalRUMFlVK1J4NVZBM0pycXpURlVyVEt0cXhucThSNS9rQW55ckh5aVJ4?=
 =?utf-8?B?Q2FuWVJ4VXpWM2xUS2RLU1c3VnpMMjA4RXlMZjUwUnJ2UGlaeTBXQzNuMjB6?=
 =?utf-8?B?M1RvdHV3cFp6L3FPQlJ6M1RGRzA3YU81K2hJNXRXOG9KU2llVHdHMTQyVU5E?=
 =?utf-8?B?UlBoNm5reVlKUHpza3RsVDVTYTdvblltV3FDQUZjUWFZR2JhZ0VhTzNFSGhT?=
 =?utf-8?B?MEtaYVVmZU1wby91T1JnMjVGQ2VPRS9iSkRHTXdLdzFZajI2OTYvdlR6UjYy?=
 =?utf-8?B?ZUNuSFBIc01lS2hsb0o4K2VlK0tVaUJtZk1yRlR0NDY4cnZIb09qYWh4ejk1?=
 =?utf-8?B?V1FhY3RoZndLWktiNU5LV3RaaXRlSzhRMVVOclRBTU9oZ2xzME9lRDlNcGlk?=
 =?utf-8?B?WEs0Z0pweS8veVFQdUdNRWZLdnlYU2tFM3Bjam54YjE0MEZiK0UyRmNqcDZt?=
 =?utf-8?B?ZHJxSXdKb2RlclRsNFV0SC83Z1h2UDBpT1ltR0N2YXU4Uy92MmJqRGZlUHdH?=
 =?utf-8?B?UUtxQk5Uc25OOVhwOGF0ZlNtckFNWTBJcVVqUjZrSzBmRHFrNFpESnZjQzU3?=
 =?utf-8?B?TEIzcmtDUUpFWnpPRURIdDFQYzNJajhpSW1XYkdDYzMxb1pLZGIvRWlmajRx?=
 =?utf-8?B?bnB2WnJiTnlwbFhMcjFPcWNOaHdaUmZWSlIxVmNqQ3kwNXRobGpJNUpuTGtk?=
 =?utf-8?B?bG5CRzNLZlB3akhnc1RpbkpGV3JaaGVUZEtQb1NoRU9HaUZieGdrWlphRGlP?=
 =?utf-8?B?RWxvdTBUM3dER2xRT1dqdVVQaVloOGMrTVlEOGxBZDlZaWNybklkM0RoOFgr?=
 =?utf-8?B?dTZxSFh1MDVtUnVicDRKUjFweGVSendUb2dmNloxYWF2VTRnZUd5ZXM5Nkdw?=
 =?utf-8?B?L3JzRFN1QytZaTVuTFlPWGp6djdpc1BEKzVIZjNoYWl0RTZHVzZycGNrODBz?=
 =?utf-8?B?dVl2U3RzSnNLWnFZemNXU3lXbGZuU0M1RDQ0b2w4RGxBcHNMODBWMWFQRkZx?=
 =?utf-8?B?Ukxkcm9SNUxXVDZUendBYWhwVlJNVFE3QlBjaDhPNWZZR3VoVFYrczduT2Er?=
 =?utf-8?B?dHJCdGhrSmpHRXRhb1d0RGtkeTlzWDVzbitEUUdvYm55cVpRclVCK3pnOTN1?=
 =?utf-8?B?ZjFvQjdhM2xCazdxcGZrQzdzSElFMEVyaGRrQXl5eTNZcERJQ3VkNDRkUWlH?=
 =?utf-8?B?ZFZWQmhwWWRMem1VU2hFRHpxVGlXczhKc1BzQkF6TjR1OGdLQ3BJb0N1bG1y?=
 =?utf-8?B?WFdCWVFqeW5oWDl5QVp5ZEtYS2cySEY2YnY1R1FUZEZhcFJJNFluMThOemp0?=
 =?utf-8?B?cVk4dHRhY0dEVXE5UVRhSUdheGptQ3NtSERPTjJFbndDejkrV0R2NVJZZXZq?=
 =?utf-8?B?YjJNVjNYR3h3NXFlYyt6Y2JTTWIzSzlXOFMxL1ZyeTNKS24reUN4NzlFZVF5?=
 =?utf-8?B?a2tIWDdwZlJOS0U3UGJML3BqWmVLdDRHby9ZK1VUVHV0NXpULy95bkhMbEpC?=
 =?utf-8?Q?hHDg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWt4V1hCVk12WGNUSFMyYVd0RGtHZXV1Ylg4MDdqSWNjSEVkejBtQXlCMmc1?=
 =?utf-8?B?QVV4Rk91UytGeWpiUndLblRsRGhjVHNReWxBbnBGQzVFVzd4WnVJc3FvZG4v?=
 =?utf-8?B?aXZHcGlScXZQWjE0UFg5TnJlSVo3VmtnaXpCYkRZNzJLN1pLOGRSWXdtcmdF?=
 =?utf-8?B?QTIzWE9wZUp3RHc0TDc3Q096K0ZBMDFXcE1lY3lTZTN1ZkYvOEVCSWZMQ2dz?=
 =?utf-8?B?em9JaEtsaERmWGVGSk85ZGRSQ29wd2NWNnZCemEweC9tRlBQUmJOSG4rZ1lU?=
 =?utf-8?B?bzNjVnlLdmFtWkFUWG9PSDd5YkNLRE52ZGdhTVZaM3lYMXF5aXhTZ2ViY1cx?=
 =?utf-8?B?eUlEMXdCZ3FYTEtpOUNNUjJFWFRCR21jQzdmaXhacFltMnNCcUxtd1Jrd0dG?=
 =?utf-8?B?ckIxM0dZaVJ6MStSdXdmcDhLZzhuOVhYZmYxMXdsczdDTUpXVy9jTnYxQzBw?=
 =?utf-8?B?RmZrdVZSR1c1b2xiait3RmFDdW9xbWU2OXBsbXl1VTBGVUFGcFYrVUlMOGtv?=
 =?utf-8?B?bWtwMmdCMXNsMzVWbGdpZ0FwYU52SUx4UllpdmdvNW1mYTViVzEzcittR1VS?=
 =?utf-8?B?TDAraDY4ODQxSzkyWDJwb1BlZkRPSHc0YTNIV1N3UlQ3YzB6aXhOdTlFQVk1?=
 =?utf-8?B?RDNpTkVoeXErYmt2NTU5OU9QT0J5cUdiWXlPdWxURmEvcnhTT0hXV2svN2J0?=
 =?utf-8?B?NGdsWFlMNzdLZzNiZmpOR1VNY3EwR1dWRnB1cnV0TVRUZU9IdjNBMEx2Snc2?=
 =?utf-8?B?MzYxTitUWlF4N2svRDh0bzZJVmpmczNzaTE4WStETGdhVWxBY0VSeGU0RHNN?=
 =?utf-8?B?L3kwbUhpTGNMWFlYUGZHbU0yTVRnV0dHRnYyblduZjdSR3kzTW1JYzQ5QXYw?=
 =?utf-8?B?Yk9KekQ5MTRTanl0TW5wdlZxRDVvN2dHSzFTbnlKSDc2S3gwUFIwL1B1WXJC?=
 =?utf-8?B?TGJtSUpVa3M3eHZma2wyTXNmOE5TQThhdlREWkVzYytleFh5eGtZaDdaUWNK?=
 =?utf-8?B?cFhyQzNmQ1d2b3cyWjdrMTFERkRKK2hXaWtZYkNDOVg3cnAwUkxOUGk0MzRn?=
 =?utf-8?B?OGg2cnlicHp6T2NhaW5GNlc2ckdtVzhWNmdCclNPWURIWFc3RWFCL3o1RmxV?=
 =?utf-8?B?MXFMangyL1BnU1psTlM0UzNmK0xaVnZPdk5xUlUwZ1JrRnlyRHJObUNLTTJq?=
 =?utf-8?B?bERLWXNETGRDdG4yZUZMOXZTRElSY1VqWmsyK2tWYlZ0djJtUHFmOWR6QWdw?=
 =?utf-8?B?MVMrN1RsVlhOYTRJWCtrOEM3VHZkSGhrVGdMTlBtWk9SaHJES0JSUVcwcEQ2?=
 =?utf-8?B?L1gvYjNzRm11Vkx3WDRXd2RsMks5ZXR5M0NwcVZrTUJCT0sva3lGQjhka3dY?=
 =?utf-8?B?UUdDdzF3NEhIcmZHbnJtUnNHdldqMjg5czVraGMzYkxvV0ZZY2swc1crT1lw?=
 =?utf-8?B?WlJEYlZjbXdrbU4wMTBBSTZGeEZBb1BXK2lxVkIzcHk4ZGJNV2ZDYXZ3b0ZW?=
 =?utf-8?B?OEl2WEZaaDRxWGhjQnRMcFVuc29tbmowRW5LSDBmRXJmdlBJcmxQV2J0aG9H?=
 =?utf-8?B?OUVvdEZrQ0xtakFmM3czRUJGd2lpVm5LV1dNN3VQc1FpcUNNSGlKL002TE9w?=
 =?utf-8?B?N2F3UW0vZFhBZWlwSEN1TEtFbmoxTnpFRUlDakhUYWVXSTQzWlFQZWpsQThk?=
 =?utf-8?B?MlRPSDIwZXhwdUw0Q1h5Yk5PNTMwaE5FWUNMN3YrRFF4YnhscytXd09jVDVh?=
 =?utf-8?B?ZXlaRkpvdkVPR3RUMHYzV2dqVVA1ckxGaG1yQytkMW9YMlFycm1OSEpsQnNR?=
 =?utf-8?B?ejl0QmVsazhKdzF6OVBhSGIzWnhjWG5HRVV0THQrY1JacTQyV1hZSE9adUMw?=
 =?utf-8?B?T0pYL0Y2WnZ3MVFseHo3OFBMNU90MnFBOHpyaFlrV3paa21VcHpJeWN0Z2ZD?=
 =?utf-8?B?ZmdqZWRFYXRaZkoyd0ZUTm1WZzYrVll0bk5CRThEbWtjVjBJaUp0ZXlsWXZN?=
 =?utf-8?B?cHVBVHFPNkcxL2pnbC94cmJuUkxxQS90TWtCR1VHOS9xandCanlrUlRma0F4?=
 =?utf-8?B?NlhYVnV1S1NnMU5NTWp6cVJEQlloUWF0Z3p3RWo2dUtqWjF2LytUMGlISFVw?=
 =?utf-8?B?cVYrekxmbXZSRHlPOFhQU3FhVFJTQU85SUhQcWdlMVNtbjMvTFNzYkdlL3M3?=
 =?utf-8?B?YzREalBYYmVtUGRnSWovc3QvNFpicG1uOTdNL1NEOTlFWW5Za1lLNzc2WmJC?=
 =?utf-8?B?SEhreEtjT0dZWUFtSXg1b2g0dzMvZlphQlBERkVkb1lQWjFrRXFTdC8yeEZK?=
 =?utf-8?B?b3RrbWxtbEN4eWxEYUVUdWRyc1ZuaTljd0dodGo5bDdNZGlma2JMUWkyT3VE?=
 =?utf-8?Q?CsIcdS5Cla5o6E4KyDHfkWyHleAmBlhH66tt/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddfc9b9a-c6b6-4034-bca3-08de744b3919
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 08:52:36.5636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wpd0LYfrdcZTvJcTtkxH12bOid5PO3NVywXs5/hlqZSm8S1iY/Io6b7+itReZbgfH8QoNBjfvJemszTgj8PzKx8lznwx6dkI86GR4UUgCb4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10014

On 2/24/2026 7:58 PM, Conor Dooley wrote:
> On Tue, Feb 24, 2026 at 12:15:31PM +0100, Ciprian Costea wrote:
>> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>>
>> Add compatible string "nxp,s32n79-usdhc" for the uSDHC controller found in
>> NXP S32N79 series automotive SoCs.
>>
>> The controller is compatible with the existing i.MX uSDHC controllers.
>>
>> Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
>> Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
>> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>> ---
>>   Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
>> index b98a84f93277..014b049baeb6 100644
>> --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
>> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
>> @@ -35,6 +35,7 @@ properties:
>>             - fsl,imx8mm-usdhc
>>             - fsl,imxrt1050-usdhc
>>             - nxp,s32g2-usdhc
>> +          - nxp,s32n79-usdhc
> 
> Ditto here, no driver change?
> 

There are driver changes. I will add them in V2.

Best Regards,
Ciprian

>>         - items:
>>             - const: fsl,imx50-esdhc
>>             - const: fsl,imx53-esdhc
>> -- 
>> 2.43.0
>>

