Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B49C44AB63;
	Fri, 31 Jul 2026 17:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785517425; cv=fail; b=Bd3vTIEvp4198DB3Y2Ddh8WDdtwxaEQsNocIMNph/nz+QE60T9LDfQUFo7WVi74wHSLu8UFu2Od7KkVExht0B5sKFkoK2apDZk2gSfigWqhH0qBPyM+LNOIjjEA0UlOzgmzvQ/F+mgpcArEeQ19Pp8btYhLlpxPxpcKzyfmVc6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785517425; c=relaxed/simple;
	bh=PyeSXr+Mv96p7Jdp3L/bxlLUIRMc3JCORC9qoZpa59o=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=olhJenaGb5uR98TKkj36z+zcwaCGHyRl2THI1urdIfRVElJyz/c13Pv0kgN6ij5wIQixXLC7/26Qda3p0J5Y+egChXi3UEPvqRaz9xrQGlsIpPSWW1vmB0INHXSgGcLcNULL8E/oCOevl2IaUUkOHpHeWl0Ti3vRHnpshtcJeVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=kZpot1F0; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=OvvSKj+1; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="kZpot1F0";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OvvSKj+1"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66VFMMWK254484;
	Fri, 31 Jul 2026 12:03:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=DilCYmA7wzr2EH+4SNUxz+t/qayVOmgZKh7WrhAlu
	/4=; b=kZpot1F0Pw/yHXZCERmef0yna+7BS7VL3GW4hStNKf90rt/Z38bodFQIT
	lRKDCFFQszzGjq6WMS/esh9OI65ffl5UN1ucPbrYfclut74OeAHWhz/vGbRZan8C
	FWQylg7WFirji0/gpeS7CYtpqMWb2yJpCYHyzQNwiiJdKNYMqnjpZ5VoUGDpVvGG
	pVet7/u+gSPOtMvKt9Of9JsKadWlMcCxWJdF+bgiSnImR7ld938nk+fvIqaytqRK
	aIZtRMF+G4QpmrY9Kb/MZrLWU25+ui0WIKYimov+6FpCIW30tGDybZfuGbmZA39x
	AHe6oHCNh6SPa9MnCw3qdWHZnFoFg==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011003.outbound.protection.outlook.com [52.101.52.3])
	by m0380145.ppops.net (PPS) with ESMTPS id 4fruny1wjh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 12:03:40 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q0aUJ4g7TbgGISk32O81KxVi1q/nvhJdcg7KGOelUZ2AUO/Y3W44CIiuJxHaJNy7f7ArypD+EZ4J5Cbe/u5Zov8ccvOtYe1bT6sYzDBiofel69Z7jGeGDDM+tmb5HKosjgVYW8hURr5vX/OObjpuYaCbl48K6EaJ/FefCMW4eiiTrenSnR+kepxvDzMiCVGWTymj+PK58wViI0/yH0uUibiqggeFMVNzRjU0wxoPFtpG1xsFuag3Ckmf/JC2NKAkV5oHn+OgmscC6YnejkXERmBnAVbtcQigbPyMkXPOoGXfVA+MjWwqrn3VQCpexPHh7H9PKzVQKrVZyA7a5vs3uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DilCYmA7wzr2EH+4SNUxz+t/qayVOmgZKh7WrhAlu/4=;
 b=F0dnVyubm/E+ryTwBS4o1VqWxvZn9vr6ne1Y+RfmeExP6G7OlYmNvcoqYa04deSOtQuBPIJuvQpylIMufZOmOCH0iBKNuNrBldXiju2Yg+GT1EmX7WDPq3Vmrwh+WKGIPFC1EtpvUT76KSt4pHcJL6JqZ2TuwanHEZ599cSzIjT/y2Ea6YvtYWJrjFOKc2oZrmBECQ1AlTAd+DZinRBzLAIkSvwjEZL3m/NBwebjwbI4gtVxrzNJMueoc+3nwkRJkORZ/vxAqe+ilCow/U/00wQ1hAdIHg1eXb66aMkTBFfottA0tSyVQl8R6daaxDrVH1OlaIbnHSf27BFpp5kHYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DilCYmA7wzr2EH+4SNUxz+t/qayVOmgZKh7WrhAlu/4=;
 b=OvvSKj+1aLfoSTf29V5aH7myln9pA6qPnzsm4hRC/L+2W7Pc3nrQA6AKOE6o3zMk8SIRRVL6wIyGPxIHDkEsCTxbGjS0wSNmOcgyildU79Udf51UluBppJlyvNeeaWvxSNtCI0I3EfAR4fBbtEtbpL/+JlV64GAiPJtL/xj+xKc=
Received: from CH2PR16CA0026.namprd16.prod.outlook.com (2603:10b6:610:50::36)
 by DS0PR10MB6103.namprd10.prod.outlook.com (2603:10b6:8:c8::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.12; Fri, 31 Jul 2026 17:03:33 +0000
Received: from DS2PEPF000061C8.namprd02.prod.outlook.com
 (2603:10b6:610:50:cafe::1c) by CH2PR16CA0026.outlook.office365.com
 (2603:10b6:610:50::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.16 via Frontend Transport; Fri,
 31 Jul 2026 17:03:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 DS2PEPF000061C8.mail.protection.outlook.com (10.167.23.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Fri, 31 Jul 2026 17:03:31 +0000
Received: from DFLE215.ent.ti.com (10.64.6.73) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 31 Jul
 2026 12:03:31 -0500
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 31 Jul
 2026 12:03:31 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 31 Jul 2026 12:03:31 -0500
Received: from [10.249.34.24] ([10.249.34.24])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66VH3U8U958242;
	Fri, 31 Jul 2026 12:03:31 -0500
Message-ID: <65911135-c50a-499b-a61e-3f6db95cd6a2@ti.com>
Date: Fri, 31 Jul 2026 12:03:30 -0500
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] mmc: core: Add power-off-delay-us support
From: "Mendez, Judith" <jm@ti.com>
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
CC: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260722205701.372789-1-jm@ti.com>
 <20260722205701.372789-4-jm@ti.com>
 <CAPx+jO9w0utg5BhsKnUSgdCWeM1prOqoV0gCrTpaeuaWZouXoA@mail.gmail.com>
 <307ee173-81ae-4434-aee4-9ddbbc9e6890@ti.com>
Content-Language: en-US
In-Reply-To: <307ee173-81ae-4434-aee4-9ddbbc9e6890@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C8:EE_|DS0PR10MB6103:EE_
X-MS-Office365-Filtering-Correlation-Id: cc5a3eb2-04fd-4e50-a388-08deef25a68f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|56012099006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	6hoBJtcCYmRdZ0iIXTOlb6Vs/JVOSsEX/495BAj4S05tzOU2dDXJxme45PVTTxnuCTRuCyzSrPbIzBoarZcxrGbgfoFNWmyKF2gXKLjGMDRhg09tVZxR0TATcdAjMZOXIBctGSfJfBrrnSjlOVaG4LT0WOVbNUmbcQNS3IwIIZ5pmYWnG9BH3+nmiOimch2rq8IHKFf0jgm0JmZL1RQvXnH9jjbBQgmQrYi6Lqq3nGGvSXvx47WM6fXmE38sLL3VlDhQi1/CScc/MEHf03ART6UM3nLEQdNHGZMoxTWymAey3CGYUhFfM+OhkYlOHWyPYxQdJ1z7WS8PKjr6ZmnIE6zGxsUVFc+WGtvivBRULTF09HOxzh6aX3bsVfsSExW5/vZpe/+uqcz5LVi9NIGUCI18bRLaNH76rVXO7/TtBgtaWyewyyTUEFmTZKw26opu+z4xCcSk9gtD3/yO8gV9pdUYaEaOBG3b+oMctqu1M2qQBEyM4U15gWGz6dGEqJq2D0fpQhqGPmzWdG8RKZ4/MGj5szSSKPUBG2YINOZuVzFWA+KXSxAXds6jX2FB+fzkUWhsI9cQ1+GZS9lwxOjKNR0ztJzc5JwcXhgPqvjdPv1I9jJtqmADW36exQ8ag+9BNnSYZ1k4s8NZ7V1+aCb1YAkHJDir7rEG4OUVHZtCG+orR9glcaPMdbtStXy9aWg7wcZPGJZ61E4pJ1dNAEx1gg==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/3wU/tTkCMpBQ8iQu10frJumD5D13sU/2hiyWBdtccOeTlA+BeduNoE30+FC+bUItppJ8BhgWANWLT/i3Aaki7idvKAX2tznek8SETsqRpUlLU41K/1uvu+9GhT2b8Y+ipKreGWMJtz/xej5cWL20VM32TBPRr7E30xmK0ueCRi48CDT5ncb8i9lnRraYPm+u8X9MOaMp7cKzgHeH5vxVxLOMB/iotOCxAYe48qM2efDdbt1KyoSLSMmiBjXOrPJgMKxFK7f/fyWV8+AM/D7rMW+eCgYCnKwWSDo7Bf/oYDUWr3N4W9vZhB61+swNh9zqBjseYYXlTphXgxbvZ6ktM405V1HFv+Z43f3eNGkv2gLxzEejpjPiupf4qVSoiIXuEisolGCPjQhwnVhiy/h1cvb6885mRZzmlImC3hUA5XSUmRb4dl9FOqMGUSyMO99
X-Exchange-RoutingPolicyChecked:
	DWHjX5xT5TrCNC+nCsRjisySeXIH/A+ZQvc28uig9eJhVxRe8P6UT/dXOWFX7Ogvab04RdkUTSbocNK43jCC8QkHgJ5nWK0znIdypDC7hIukfEW9CvUYN46CmtJjGm8cHX1OZfb0eeAj7l07s+DcaRYuFjfg4lamjsNyH+RlTnXVpT5lxXr22X7duFMtKywgGf54BJFysl09SaMqKRbsh3erFZNoM+3B32BwUP0tTZizYyW9qs7/dRyiA2tVafZ4vIvCD6xkJbR/4CBc8i8tDYnXjA2kmjVx8uBLTNEC4Bzy1yV5KWefzJxYLgTQBdkAje0E2LrxqSSnLhZVN4SnNg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 17:03:31.9276
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc5a3eb2-04fd-4e50-a388-08deef25a68f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6103
X-Proofpoint-GUID: EorAvRz33Nhag3wzUfZRxcCQ_fGCVEsB
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDEzMCBTYWx0ZWRfX5Z1AlxwhDUvU
 zQQzMe9Lf+lFWAzQg9KDf7szJWFJ9MXaqjYipdG/bcTOnfaySIMOAb4KAmGujozSB7DspngzzSF
 JFNteW9yphgclDvLRA9f7hZj9y86sCY=
X-Proofpoint-ORIG-GUID: EorAvRz33Nhag3wzUfZRxcCQ_fGCVEsB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDEzMCBTYWx0ZWRfX1gtZdmR7poyo
 6I1vEENbZoVNDSFOz69hW0+ulODl/dEU4B9XORIAggh4yAdoSUu2y09rZRCi7ZijVMOOwWSPFN4
 GEM8x/yd0vwLwr+5exOM67urEcGh+OKbDxka+Yrlf71PaTroPAuaCAVdFW9Ov5PjtiMXQbNR3wN
 TljgycwqraPspITZ9JRtGN6266aWykt27daRLVotgOBm3aThc08hqLk9Q3smKQDfIz7kampOzBg
 ghBRsqzNn7o7ZUk8IbLSOcZo7d3bBqEDQNy1d3uTBmEvSTCC65AzMAh/tx9u7mONRY7huxDonz/
 rsoXVYE2DRVJ9wJk8wKsDy5W2FZcRf1iHAmO9IjmOLFQF+0KpPEUqBJee6hZsEa2NGex9V4zbqV
 wyzqei6XM9GdquxpBWhS0GGcMBzf1+eW6P5j1cc16eCMxN5BR+5qTQ7S4r/VYkxpfF4s9N8pBU8
 n5l7uyh2T3tITYA8d3g==
X-Authority-Analysis: v=2.4 cv=Db0nbPtW c=1 sm=1 tr=0 ts=6a6cd56c cx=c_pps
 a=n2iMVF0J/Egc90AivcUAPg==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8 a=uskIVHaxS17_MF-i9pgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_05,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310130

Hi Ulf,

On 7/28/2026 4:56 PM, Judith Mendez wrote:
> Hi Ulf,
> 
> On 7/27/26 10:16 AM, Ulf Hansson wrote:
>> On Wed, Jul 22, 2026 at 10:57 PM Judith Mendez <jm@ti.com> wrote:
>>>
>>> Add support for power-off-delay-us which shall be used to specify
>>> value of delay after deasserting power during MMC power cycles.
>>> Default for delay is 1000us but custom delay can be passed in to work
>>> around hardware issues such as slow RC discharge on MMC VDD rails.
>>>
>>> Signed-off-by: Judith Mendez <jm@ti.com>
>>> ---
>>> Changes since v1:
>>> - Move delay to mmc_power_off
>>> - Fix dt checks and remove print
>>> - Move from mmc_host struct to mmc_ios struct
>>> - Rename post-power-off-delay-ms to power_off_delay_us
>>> ---
>>>   drivers/mmc/core/core.c  | 2 +-
>>>   drivers/mmc/core/host.c  | 8 ++++++++
>>>   include/linux/mmc/host.h | 1 +
>>>   3 files changed, 10 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>> index 29e80e5f928e9..9472041fe1c20 100644
>>> --- a/drivers/mmc/core/core.c
>>> +++ b/drivers/mmc/core/core.c
>>> @@ -1388,7 +1388,7 @@ void mmc_power_off(struct mmc_host *host)
>>>           * XO-1.5, require a short delay after poweroff before the card
>>>           * can be successfully turned on again.
>>>           */
>>> -       mmc_delay(1);
>>> +       mmc_delay_us(host->ios.power_off_delay_us);
>>>   }
>>>
>>>   void mmc_power_cycle(struct mmc_host *host, u32 ocr)
>>> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
>>> index b7ce3137d4529..fac50a2860211 100644
>>> --- a/drivers/mmc/core/host.c
>>> +++ b/drivers/mmc/core/host.c
>>> @@ -421,6 +421,13 @@ int mmc_of_parse(struct mmc_host *host)
>>>          device_property_read_u32(dev, "post-power-on-delay-ms",
>>>                                   &host->ios.power_delay_ms);
>>>
>>> +       device_property_read_u32(dev, "power-off-delay-us",
>>> +                                &host->ios.power_off_delay_us);
>>> +       if (host->ios.power_off_delay_us < 1)
>>> +               host->ios.power_off_delay_us = 1000;
>>
>> If power-off-delay-us is specified and the value >= 0, I think we can
>> respect it as is.
>>
>> This means we need to treat "0" a bit special and bail out in 
>> mmc_delay_us().
> 
> Ok, just to confirm, then, you want to drop these guards in mmc_of_parse
> and instead catch 0 in mmc_power_off?
> 
> What if DT parse gets garbled and host->ios.power_off_delay_us < 1 is
> passed?
Gentle ping on the above. Please let me know if you really want to drop
all the guards here and only catch value 0 in power off function, all
other values directly pass them to sleep function.

Thanks ^.^

~ Judith
