Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2083.outbound.protection.outlook.com [40.107.7.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3736F1465A9;
	Thu, 13 Jun 2024 14:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718289161; cv=fail; b=e4w2n/k+mMnDrqf3K2r0wx5UViYPDP39vRFQdd/7PZLQjlfMuxfHOgN8UQ4H97TcIvajVeRZoSA5GyyyKky3g+hGHVo4E1IGGwxqrXSg6bwnsllm0ppcKBAPSUrSzywbYQRPLnhuMQcA7kgMEduBwi8Ow142vSnLUjOCy8nWm00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718289161; c=relaxed/simple;
	bh=s+5+b4w1YZpbi5xnB906ewb3bvJknRFJ1303eoHH8W8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=gAyBRI47RHI6pC67DAqqP6jOZG5kvFgyU06LnKsJ6KnQst/4hDdrZSO9uLsQgNp8y0hzZFU3hZC1P7m9HLtn2ziKJofA/gcCxMxxX86NmeolrNWfk/4unO2yg6uIzEDBGS0mGBQxm4PB0/0/oVv9WmU19HDHfbFhnQe9E1qbTUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=BDBx3rPJ; arc=fail smtp.client-ip=40.107.7.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BDBx3rPJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LLnMkRcGwOCWAV6CVDIRMFFjl6Fnr41nylUdgXB2y9aLlVupjlj/azFicpEDZcX/4ZN67TAsAD0+D6+Elc6fyPuXZEyz9yx/IMZcwD+wh3j2/J0rWc1rC/fmPAZHWGtwpuEzkn+YkwwrdRC7K6Gjn362ohleDzUyZz/yLNfjlylTLj4XJsBLlfgijM34Oi43jK2YCSKV4GCEOIZriXC1TyXhMlMe9EFy4xWsBNH6Dk73p/DSf7yWAqgxpLlbMg0sRk5RHGxPImTUqc7dH7IfGyuD9cOWkMKaCG26KVcMYekQlCU2/GjRo7+LYygHxwg0odCFMeh4wLkpoYfiLVIFSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GTmXQ/3fpq4n2gUscxZrhnRKHdbnSRXL7JdKFFI5Gs4=;
 b=coKWpoYrPKLL78HPaBO48RB1PI5SjsMlf0+xEOCKlgZwxUiNjoi39WB5LL6Egb+ArDzL2YAQ3sQZgVOYSxjbK3BUzfo0aN/BVHp4OWw1q53AicciEGh3eNf/dqbGtUYJq45POgPJmAKHxgeYBV8PRo27x7UWOqqfu2HWjdTLrIFTkW8IpR57A1x1bpyPbJZ9qmeCUWBsgCXpn1D2/VRMENJVVfY/ZXT3R+6sqYs8CIGevL4mvVWB30NqnLJJuNmMSV0t9Cgv+cQK0SBVAMwHpxtQsKjp+nsylfUW2r8akwlU7QJB9surohwYFWmRuQGh80v3h1WbJ+JvU74SI/drZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTmXQ/3fpq4n2gUscxZrhnRKHdbnSRXL7JdKFFI5Gs4=;
 b=BDBx3rPJoSPyOWs63QZCbRNQsH27OY8NY6PKs6rY2d+HIGM/BNP3C8vkXMC4ntKVyCzdG0TtA4TydICB6AghHvb12bEbBjj4QH/+kLXrdLKEkNkqLEivvCdXsFtGUnvjaTgX7YM/SyeT1u8xnMSI08fgrkuENHyQv1YbO96VlcY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8256.eurprd04.prod.outlook.com (2603:10a6:102:1c6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20; Thu, 13 Jun
 2024 14:32:35 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7633.036; Thu, 13 Jun 2024
 14:32:35 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 13 Jun 2024 10:32:07 -0400
Subject: [PATCH v5 3/3] arm64: dts: layerscape: Change node name from
 'esdhc' to 'mmc'
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240613-ls_waring_esdhc-v5-3-36644e2fe21c@nxp.com>
References: <20240613-ls_waring_esdhc-v5-0-36644e2fe21c@nxp.com>
In-Reply-To: <20240613-ls_waring_esdhc-v5-0-36644e2fe21c@nxp.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718289143; l=5612;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=s+5+b4w1YZpbi5xnB906ewb3bvJknRFJ1303eoHH8W8=;
 b=0QZGhRHNy3XDXmqN7elmqDiOHzNAKo4iO2qoKmU6TpR3J7ktPWEETO67KYAqD4c46h8TTZDUu
 7uNcekJU6EyDDd1Uvnv8QDwyH5jE5eBOUp+oUqMdmm2FLTM+rubSyFw
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::30) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8256:EE_
X-MS-Office365-Filtering-Correlation-Id: 238b6050-51bb-4bfe-410c-08dc8bb5aac3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230035|1800799019|366011|7416009|376009|52116009|38350700009;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QVFnOXdSQzB0K0MyMTVFUG0vOHdxUTM3a2s3YXB6K3VYTVJmU0lsZXk4cVpB?=
 =?utf-8?B?eDA2Wis5NjBSZlVpZzdjYmtPeThsVlp2Q1ZYbkZJcWo1dHZGYldkZEhKSUpm?=
 =?utf-8?B?L2dQdFprSVJ5NDFwQnJtc05Ud0FQVnFMcVBQNDMxQjNlTmQ3MkVrYWU4U3pp?=
 =?utf-8?B?Uk1xOCtCWlFmN0VuUWRuSHZaUXpNd1pEN3A0UXIxK21vWStrUUxoTm1NeWxK?=
 =?utf-8?B?dGRDb3VlKzBqRm9rNWY0WVBmdnNWdGZVMXUrU081cDJqY3pvVERuM1B1YW02?=
 =?utf-8?B?cTNCYVJ2dUxUbktycGFKc0puR29FblNJNEh4T0RnK2hxUkhodHVMbW1nQmRX?=
 =?utf-8?B?cVBoSHZjaDNrUWg2WVl6Qy9MYjBBSlBLUXFVR2Z6aVA1L05BVDlZTU9aTzhr?=
 =?utf-8?B?eXRrNG1IbkM1M0Z2U0NGcHkzZ0RSRkJJdGpRRTU0RStUSWRlVStYZkN4UVRR?=
 =?utf-8?B?dUpDQXphdnR0c3NMRlZGaEFlK0NtZjcvbFUrL215SUpBdU1LeDhHWGJZajBB?=
 =?utf-8?B?TFlGVW0wSXZmcmc3NmNtSmlLa2cvVkl3KzFIVXpGMzNLeU03WEZOWnBSU01t?=
 =?utf-8?B?enJGQmJGb2JkcDFScGp1WlZNS2xVekt5Nm0rWXBHQklGc0hvMmZMeUVQUUdN?=
 =?utf-8?B?Tk5SeHFrZzQ5RGZDL2trR2dveHhkbmZaaWdKUEJscFptUS9vSnVoTG5SUXdK?=
 =?utf-8?B?eEE1bWc4NXRjMGg0VjExK1BIckIrZHNKdDVXdzJJWERKOUJlWERockFpWVB0?=
 =?utf-8?B?T2VJTWpUZG9sWG1XcHBDc2FCeHlQUDJHQlZKazBNaXdQUmhhZmVlSHJJWGFn?=
 =?utf-8?B?R2c0U0NyWVMzeHRzV0xOTDhHQU9ieTZuMVVCc1NuYzNIMDJxZGJ5b3NoT255?=
 =?utf-8?B?QUVMYk8rVVdRVmJsN0RQaDArakVZUEZzWlBNYnJ5bkpLRHhLblhmbHlDYy82?=
 =?utf-8?B?VUZlQml5d2tIb29ibVR2d0I1WC9RTTR3U2FaQlN4Tk1pTHMwKzNsc1Jia2Yz?=
 =?utf-8?B?TXh2VCs4N2ZCTUxWTXp5Y0kwTGY1b0djcXo2T1pLUVo5UWRDbUpkV3ZWeU5k?=
 =?utf-8?B?eDdNRElZaGhERy8zS2draWVqWlkvL3pXRFlzSHYyYjlhWGxkOEFUNXEvQ1JO?=
 =?utf-8?B?K0Z3TkhXSnZHR2VMaVQwV0JEaElva3F2OFR1cDNGZ2Rxak1LWmJuVkpBT0ZQ?=
 =?utf-8?B?L1ppWVExeDlOY2RibDhid3hoOC9iekdlZU1CWEY2VEZ5SXM4NlhmV0pzcEgz?=
 =?utf-8?B?TURXTjN5R3djQlQ4QTdXQWxla0V3NDVyM3Z0T0NjSXNSWE1OM0M4NlY3cHhk?=
 =?utf-8?B?MnZlaDhsNi9DQmpqbDhKL3Qxek1TRW9NbUhMVjE4VkdWOHE4RFY1bEY2R3VK?=
 =?utf-8?B?ejIzcVc2bW9Ja0t0Y2c1UGdMM2FXUXpuWkg3Mk9mbGIrc1RGR00xK1hkSnFr?=
 =?utf-8?B?by9iNGFRczZKYzdRaDB5UmNJT0htTGp0c2x0MlYrZXV0MnR0SWJuQ1NlSm5t?=
 =?utf-8?B?V24rQWR6ZzU4Y1lTckF2dEdNc2tXSytFZXlFZEY4aUo0NXNpKzlDeVVLdDBO?=
 =?utf-8?B?QmhDQXdLMGdvS2VYQ09wbk5vNzVqMFBPcHNIWmNVbUtTV2VEZzNxa1cwaGxy?=
 =?utf-8?B?cUZkRmYvdzBONmlCblhkK0hCQytEK1ppaU1HbkM1VHJaelpLeUFJV2RyOXZ0?=
 =?utf-8?B?eHBmQjdnLzJ2Zk9SdmNyL3BGbWFnKzhqZ2NVQkhOd3ZIQWNjOEx0MkNFY3lx?=
 =?utf-8?Q?fJjVsBcA1xiRzJs/8jXhgqQQzWDQWwChLkIn9SV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(7416009)(376009)(52116009)(38350700009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aEhvdVFGTDdpYmo0NUtrTncvcWRJdzNGRjdZVm9WY0lxN2tyRS9XUU4yWFNw?=
 =?utf-8?B?RkdTL0NpbGxqc0ZnMlFuZThZalRIdGR1V0ZMRjhHVzlYZncvKzh4ODhXVlNC?=
 =?utf-8?B?U1NFcVJST3o2U2JyM25qb0MxRWNYaHVvOHJnUnhYSXpNcjNpdDIvc1lsdVhX?=
 =?utf-8?B?MlE0OTZEdE5lYTBzbFN3U2hSdUdpdzdSVDhYNEYyNUpiWW8zOUE0WEZ3dFhl?=
 =?utf-8?B?TC9teDNjUVhGektWRTlTMDNUWnNVV25uNFRjMC9MYWNLOVhIcHVZM0tXNW82?=
 =?utf-8?B?QUxhZm41dE9mVVZDV2JiN0Qvajl1ejNOeWZLbnhYOUxyZDhpMGhMK0JaMGJn?=
 =?utf-8?B?NmFTMlZiWXJzeHVKcGlIT1pneVJSQlpNY3hlSm1uY0RrbW5XWU5UWU9oN0R2?=
 =?utf-8?B?WC9oNU5DdFQzZ2YzYWlRNVgxeXVPS2NJcUVkRWRBZTI1L1ZJRzQ1bC85R21m?=
 =?utf-8?B?bGVRMm85KzJWMTRGU2RRRUpBYldDMTJYMitpWlpLMWlyKzlydkFSSGVUOVpw?=
 =?utf-8?B?QVE4czFWaVJmQkcvZEw4ZFhHL09nUmo2Q043QWlZOU5ZY3MwL0prN053RUFy?=
 =?utf-8?B?TjlzSDB6Y1AvUDZwMmlJeE1nbXVkYlBBWkR2UEUwWDBYY1krMHJQcE12SFRI?=
 =?utf-8?B?QnBsaDQrWVFvdXVKTEl0enZUY3dnRXBNZ2d2RWdMWHMrNnNybjlnR3I1UWZN?=
 =?utf-8?B?TDF5dlZIZUN6L29Ua25JOHMxZmFwQVNNODE2cVZCdW5Yc3VJWUMybFRmdXV0?=
 =?utf-8?B?b1BpUzNvK1FnZXBlaE5NODl2RnlPMSt5Wk85V2NFeFBEREZ3M2p4cklaUDRa?=
 =?utf-8?B?SUFIbFFpVXJiNFVadm5WRDJTYWxpN2IxS3Brb1I5T3cvaDUyWS9tbVJLMHJF?=
 =?utf-8?B?R3NzMkxCVVBmZDR5SmpldFdJVHNHUisyWHY1K2daREZaN29ZVTk2MTRQVmVO?=
 =?utf-8?B?TjNxQWh3YlNaWktEeFQ3SnlxUTdnNlBwMXF6VDJhcGUxQVBySWoyTk8vN2E5?=
 =?utf-8?B?b3lBSC84NGtTOG9XTjVwT1RTWHY5ZGloSjg2ZndyUzdNejdYTkRqdWVNU2xz?=
 =?utf-8?B?NERqS0VlUnJpdkxyd2tUNW8vcms4ci9BY2VmeTNpZGRmNzEvWUt4S2FId3oy?=
 =?utf-8?B?eVFYVjJHb3ltbVVuaXBWZXR6OUF4OHEwYmI4Nzh0c2JIN0hObE9wQjZkM0pB?=
 =?utf-8?B?Z21aYkJhdkVIVXIxUmtSTk84M093UzZ4SjdEVWVIWFQ5WnlRU0dTbnk5a2V4?=
 =?utf-8?B?Wkpkb0E2TFRscHpxRUFCdll5dFFXcGx2RXpQdkdhUEZwVFA0REVka2VSaXpj?=
 =?utf-8?B?bmlaUjRwWnZQbVo0S2lJRURjUENFdUFtWGQ5VWpucTFpdlc4M2MyaDYreUVl?=
 =?utf-8?B?VWpMZ1llUWNhRnpJK21iR2Yrb1AxUWJZMHNycjBONCtyZTYrM0FuT3IxMlM1?=
 =?utf-8?B?amM4SDVCL1R6d2tvN3p6N25MRXR0SHA0VnFRS1c1ZzZPNFAzOGxOMC85OFRN?=
 =?utf-8?B?V3FDNUJWUE1FTW83WjVWTGVWcVB4Y2pVd3kyYjE5d0h5M3U1dzJsa3prcllT?=
 =?utf-8?B?UGQ4ZDZOaFNWbVJ0YzFaMEdmMU4rVndKblVJOFZLbWd6OWJQYmloUHVMU1FO?=
 =?utf-8?B?RXl5Zi8xNTM5TXd2TnZMSDBQTFRvNmt2MFlkS0pBM0pPMjBON1dLSG0xTDk5?=
 =?utf-8?B?cTltdDhTQ0JPWnRtMkg1c053V0ppY3ZuYjFjbWh6NXQ5bEtobUVUOWkzTXcv?=
 =?utf-8?B?SW0rNXp5UUQyL3RYVXMwdzBzQUMxZW5PQUx1UXVxeElnTXYzbVBkSWJpN1ZG?=
 =?utf-8?B?cWUzbUZGQUZIZGtEajlBR1VxWDZXQ21ody84YWhleXdweklESWU5NnMvSzBJ?=
 =?utf-8?B?blVSUEQ2RHZhUEFzcTVlVE9JUUJwOWFNcHI0R1VkY1d6TFZNYzJMNmF1Y2hF?=
 =?utf-8?B?K2hJK1VRQkxTbEFQNWtCWmtvbHhnT0xQZnpweVlxVENTOHBWeFNydWVKalNV?=
 =?utf-8?B?TkxyNUpUUFlrN2V5TFN5amY3VG9wZjdBZGFvNVJWbjBDejZhU1RzMmdJTjk0?=
 =?utf-8?B?SGtaRWF1dWJWdlNBc0tocG9Pd2kyd0ViMTFicGp1aXBiUDFVWjQ5QVMxRVda?=
 =?utf-8?Q?0sIV1jp1iSqvASYjUcCPfixhh?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 238b6050-51bb-4bfe-410c-08dc8bb5aac3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 14:32:35.0845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6piFUGJBpIQeENkZe2pI9zHZDqNwHMA24mvM+S22laEhZv6ANQibdYkMqVIImSoqk8iht3BS13dGLLvNIeOLKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8256

Use common node name 'mmc' to fix DTB_CHECK warning.
Add compatible string 'fsl,ls2080a-esdhc' for fsl-lx2160a.

arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dtb: esdhc@1560000: $nodename:0: 'esdhc@1560000' does not match '^mmc(@.*)?$'
arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dtb: esdhc@1560000: $nodename:0: 'esdhc@1560000' does not match '^mmc(@.*)?$'
arch/arm64/boot/dts/freescale/fsl-ls1046a-frwy.dtb: esdhc@1560000: $nodename:0: 'esdhc@1560000' does not match '^mmc(@.*)?$'
arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dtb: esdhc@2140000: $nodename:0: 'esdhc@2140000' does not match '^mmc(@.*)?$'
arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dtb: esdhc@2140000: $nodename:0: 'esdhc@2140000' does not match '^mmc(@.*)?$'
arch/arm64/boot/dts/freescale/fsl-lx2160a-honeycomb.dtb: esdhc@2140000: compatible:0: 'fsl,esdhc' is not one of ['fsl,mpc8536-esdhc', 'fsl,mpc8378-esdhc', 'fsl,p2020-esdhc', 'fsl,p4080-esdhc', 'fsl,t1040-esdhc', 'fsl,t4240-esdhc', 'fsl,ls1012a-esdhc', 'fsl,ls1028a-esdhc', 'fsl,ls1088a-esdhc', 'fsl,ls1043a-esdhc', 'fsl,ls1046a-esdhc', 'fsl,ls2080a-esdhc']
        from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#
arch/arm64/boot/dts/freescale/fsl-lx2160a-honeycomb.dtb: esdhc@2140000: $nodename:0: 'esdhc@2140000' does not match '^mmc(@.*)?$'

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi | 4 ++--
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 8 ++++----
 6 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
index a0f7bbd691a00..7f8c83670ca86 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -156,7 +156,7 @@ QORIQ_CLK_PLL_DIV(1)>,
 			status = "disabled";
 		};
 
-		esdhc0: esdhc@1560000 {
+		esdhc0: mmc@1560000 {
 			compatible = "fsl,ls1012a-esdhc", "fsl,esdhc";
 			reg = <0x0 0x1560000 0x0 0x10000>;
 			interrupts = <0 62 0x4>;
@@ -175,7 +175,7 @@ scfg: scfg@1570000 {
 			big-endian;
 		};
 
-		esdhc1: esdhc@1580000 {
+		esdhc1: mmc@1580000 {
 			compatible = "fsl,ls1012a-esdhc", "fsl,esdhc";
 			reg = <0x0 0x1580000 0x0 0x10000>;
 			interrupts = <0 65 0x4>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 8ee6d8c0ef619..3eeed7290be9e 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -424,7 +424,7 @@ QORIQ_CLK_PLL_DIV(1)>,
 			status = "disabled";
 		};
 
-		esdhc: esdhc@1560000 {
+		esdhc: mmc@1560000 {
 			compatible = "fsl,ls1043a-esdhc", "fsl,esdhc";
 			reg = <0x0 0x1560000 0x0 0x10000>;
 			interrupts = <0 62 0x4>;
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
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index 604bf88d70b3a..20f331dc28f13 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -474,7 +474,7 @@ QORIQ_CLK_PLL_DIV(4)>,
 			status = "disabled";
 		};
 
-		esdhc: esdhc@2140000 {
+		esdhc: mmc@2140000 {
 			compatible = "fsl,ls1088a-esdhc", "fsl,esdhc";
 			reg = <0x0 0x2140000 0x0 0x10000>;
 			interrupts = <0 28 0x4>; /* Level high type */
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index ccba0a135b247..80fd1420d2299 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -940,7 +940,7 @@ dspi: spi@2100000 {
 			spi-num-chipselects = <5>;
 		};
 
-		esdhc: esdhc@2140000 {
+		esdhc: mmc@2140000 {
 			status = "disabled";
 			compatible = "fsl,ls2080a-esdhc", "fsl,esdhc";
 			reg = <0x0 0x2140000 0x0 0x10000>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index 96055593204ab..742de15bbfd87 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -925,8 +925,8 @@ dspi2: spi@2120000 {
 			status = "disabled";
 		};
 
-		esdhc0: esdhc@2140000 {
-			compatible = "fsl,esdhc";
+		esdhc0: mmc@2140000 {
+			compatible = "fsl,ls2080a-esdhc", "fsl,esdhc";
 			reg = <0x0 0x2140000 0x0 0x10000>;
 			interrupts = <0 28 0x4>; /* Level high type */
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
@@ -939,8 +939,8 @@ esdhc0: esdhc@2140000 {
 			status = "disabled";
 		};
 
-		esdhc1: esdhc@2150000 {
-			compatible = "fsl,esdhc";
+		esdhc1: mmc@2150000 {
+			compatible = "fsl,ls2080a-esdhc", "fsl,esdhc";
 			reg = <0x0 0x2150000 0x0 0x10000>;
 			interrupts = <0 63 0x4>; /* Level high type */
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL

-- 
2.34.1

