Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFB842903D;
	Fri, 17 Jul 2026 17:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784310037; cv=fail; b=M576t4r2GlyBTtd/V5ctT2i1Bjq3a8MAyZ+blonSlqm8KVxVeL3CqB9yK5fNVTqcDxWo9qC1LjA8LjK6A5cUT1eJdzQdFfwFuAohw5I5HKKHTDokMdO8V4rJG/aSetnxshqqaw8t8WUenw4MdqhzWBWaEKcmslzyKh7PK2eR/bE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784310037; c=relaxed/simple;
	bh=ty0QTqf8GM+vmnh88C/wTinVGgVLeuj1pOR27nI0MvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mUNHVlgxn3vnrvqU8WCHrJvaoifR0RxbxH4nKabd+5lZimB0FQFvWKsPIgRHOWUlDxPjYogYcGOilzekbidDKITB4bUmo5XtqzuRN6aK4UOILtPmrfSyAiTaqMwe/waqmo3lU3y+OkHuYr7WDYnjrFRHnNT6U/Ank+sm4dwIsH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=jLYYVGpQ; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KFd2ANOz; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="jLYYVGpQ";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KFd2ANOz"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66HGkCjB3022719;
	Fri, 17 Jul 2026 12:40:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=/zGJyxOjvx2f1ELXDE3031ut4Hq94tLsRUPS/2F6G
	00=; b=jLYYVGpQjcIpCeAzHJtHNaJaG6wSz6pNSdGRXGCkdjvRW8R+6LZbIV/c6
	OsBoUdd61n0CxYYwPpiva7IiOOKUoR0uwQ6Luh6TlL1f/WVJnQUeLfBNZns7G346
	VeX+XmeXWFFby//6fl6Q2hf/V7lVEI7AfalxzXZSrLhvUs0M7HoewkVg86Zid14R
	d/98ft4DdzWueBZh2QGbiM3657r5mtbRm7A/JeZ2W5dAuVP1SUsGbbZonIwBZ610
	oE+ADX6YFQMyAt+LcgbZ1bZIILOsNxfo8165Y8DNtL+NsuEZh1Ty0a6CkgCKy5N6
	Xt/6Tx8wdsGjB4D8hVjN8i2iz8wlA==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011038.outbound.protection.outlook.com [52.101.57.38])
	by m0380145.ppops.net (PPS) with ESMTPS id 4ffks326jn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 12:40:31 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PHGGrqlvsEXH45wn/CZfIffGvH/Yq7p9ZecVvNFN+c/mAWqCu33E79fSBmfrALxSoDuzviiIPx89o3JZGo5GcmU/Z6VLipLlgow+rmktXfmjyPk1GcbkULe4lZEEkMIKhzzu/R/bF45tQY7nPL5oXNtOEhJTxp3zP5TrupmHMggNy6KSr5u4OxksokkXT5hcG+/35Vk3lh8HdBkMD+To8gL0kaFb+mLBusrB9bEW9ZmfTySw63AcslaanxV4cQ5/EvoWHluuyuPJCfG7CrVzyJwyT3wzmVxqWjzfYhC9+sF/Oh9LzP6IxROV5f6RoNC90ltHmITUIIVwzbEHAwsZwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/zGJyxOjvx2f1ELXDE3031ut4Hq94tLsRUPS/2F6G00=;
 b=qXwKHM+9wFisOfrnZoTo1a2h/5bJcepaRjB90GljAynjoaQWKH2gbIGEf8l6SiR8fVZ5BN7sM0d6AKWASfKSoyx+QrYrxdmU72G7ZFurl1Mx5h+2Vlx6Uq/bjU8MfKw08MJnTLzE5GwJEdpvGRAIRb5JaDFcMiswI4+I7q9zJMzs7Gr3jZhnIoqBjASia/rCZTAlhL5Wv1spqFPviiyZQL38xKeniLRJS5R0/3s8WgwxMKw0oI4vnfmThvSaDvWkZErtnsD9UDZE7S0h8ez7sSooSfbJG+TExC8IZmhcAcnQh23qbrRIBaonivvorUDVwB9lMrruY+S/lkJ+lKjmYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/zGJyxOjvx2f1ELXDE3031ut4Hq94tLsRUPS/2F6G00=;
 b=KFd2ANOzBHs0eOe2YepynZ8E2IJUW0dume5SjGbjpmVUIf7DlFhRshdiIWVAJ+6VpMHN7urQ6Aea7S2In2hI21F9Kn6baCduML4YRQZQCJRH/UGk4wgKUds5Uv+7nHnTMBLEXj/DUXxf/skuM7dBX9aTmryyhdHNZnK0Q01xCv8=
Received: from DS7P221CA0035.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:25e::15) by
 CH3PR10MB7907.namprd10.prod.outlook.com (2603:10b6:610:1ca::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.12; Fri, 17 Jul 2026 17:40:22 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:8:25e:cafe::9f) by DS7P221CA0035.outlook.office365.com
 (2603:10b6:8:25e::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.13 via Frontend Transport; Fri,
 17 Jul 2026 17:40:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Fri, 17 Jul 2026 17:40:20 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Jul
 2026 12:40:14 -0500
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Jul
 2026 12:40:14 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 17 Jul 2026 12:40:14 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66HHeEjl3722960;
	Fri, 17 Jul 2026 12:40:14 -0500
Message-ID: <305cf4be-2f45-49b9-b933-05ac41092685@ti.com>
Date: Fri, 17 Jul 2026 12:40:14 -0500
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: mmc: Add post-power-off-delay-ms
 property
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
CC: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260716232641.2659710-1-jm@ti.com>
 <20260716232641.2659710-2-jm@ti.com>
 <CAPx+jO-a3+mv2msL+12Ag-xs33es2+Wxbr_uKRMY3rbN7eL-cw@mail.gmail.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <CAPx+jO-a3+mv2msL+12Ag-xs33es2+Wxbr_uKRMY3rbN7eL-cw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|CH3PR10MB7907:EE_
X-MS-Office365-Filtering-Correlation-Id: cafcb2fb-01be-4de7-31a5-08dee42a794f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|23010399003|1800799024|36860700016|3023799007|4143699003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	CfpJ7bzWg0uZO9rdwefDIsdiO7C3B3kdT0pTNqy94d8j1338YAdVavCTdhi/h0rTY5Zx86napLQT5uOq7qjeRnF1e3dMCIVmg/APRx3iR5Uf5BNs3zbe/lIyy5J0VFmcM7faJQF+aFI319Lrbhf5kSfcgfSX6AvTAHa4dntZXgTy7XAEA4mhaAhxO5OtV+UrY7y6DEhhaI9ME+PHccjoRCytVdf7ZuiJ/a1XXuAsbulVaZhtkHtcUcnVC1ZM+WG2PN1Ev2TZHR20dXadgGRMOvE2NXouD4qqtDRf380YbF4utws8p6nWZOWFvOCVPWlbZW+EjBjJ58UfWvjvKGUJnKd4xzzX57gyZbvEiWafgMHgx+UqKaOYRbD5FArgxZX4Wn3KEXOLcWJ2buvAydikRoVOarppQomBKKjUKSCaCYLo/AOcduC3vVldNB8tuJBnpORkblB3KQEEhNRAQ6NJX+xyo8oYEPOmVCGvvf2MBt7NjWw7uMk3NohrAPaJVoKY2EiR2U6BFarEle7PAzYHwBlPnjUlxt1H78Cezmckl0I4Yn0+Y5+Dl6OPP8lOghxaf7slO/XUXmauxeO1ZUh4YzFh7KDipq25chKTYvxbq1vWsa7hxuYaB2Uba6Pl7KbkDmP4SjPV2cwZPsieKSnTmCqZFLPrLhBB2+IHMmCukJwvKKIUPvWmlEsho9cxVckt+Bqo4zN7bsuCqhwYMDfOaQ==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(82310400026)(23010399003)(1800799024)(36860700016)(3023799007)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lA9W/GAqmHNo9zMBmSfgqmaclct+Q6LsVQgQ+Ja98jzHWK4J0DElOQk2gWWqB4RV21ZpRpdT1+jwsX1AXKAk4rBYSxDZuzgLcss5wXehZmtJVrGXKu0JWA+cATGh+ekYHGRGGhvIjNXZWfYA0ZodWNH2hI/O6KU4zC9joWpQCwpyg/zyI385iVYWpl/y2dqIzDvLR5R5VwvlxDsgCrK+I3JRIb/gAD113mrqGt81LpPdLSesrP6SDXzH//p+8WglYsR56+orlKj+Es2P4koQ9l6PQSKdSxJDrh3705UqUDze1itCicIOgpdv/SOWo9Z3xnQWi/8/pywU6IQDcgWdLp29puE1AnE3ZNDhhbuaZ+/6BV0srdCEsFo+P6PeBjjd2Cg4rXQKOQ8joH2l464iD8m1ZAbnaTk3LCcmzHIGaOPFxraP2DvkSbFXr+p2HJoP
X-Exchange-RoutingPolicyChecked:
	XbyXKEhdzWXpGVufeS0AfVotdwQzpo4aJeBFMA6aeaYY8ypy2KX4nSLCxAC8GHuchi7WL+zH91emrceskhikClOFT8OYCZaysmh6APNdDkovZ5nMqYmXYpUAUNWJ1twmpt7ym5mWBqD33J/3kVQ3OPKRTv0KlWoGc1tru4zF9ssqV1oH3Jb9NTl3/cJmIZdb7pW/OkaWBB2ONf2e2Ju5kUwnHGUHqbqI4UKSeooDs2YBoEK/pmO0oyRy8TVKa3dJOytGNK8pc7H67BCD4dhhUFcscJ6dWBe2QjYIGV0z2pAfS0RUYa30HDC85l1MDmcOMbAP5Dd0qxf6q3d01XRNqA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 17:40:20.8002
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cafcb2fb-01be-4de7-31a5-08dee42a794f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7907
X-Authority-Analysis: v=2.4 cv=e9Y2j6p/ c=1 sm=1 tr=0 ts=6a5a6910 cx=c_pps
 a=n8wvYzHE7/phCzIUoQmMUw==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8 a=pm_y97fTR1tPyHivVqAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDE4MCBTYWx0ZWRfX2B6Mp48j19Hi
 464pwVWLWnMtNXsutr8H+Fj3YasRy1gKM8eGO/rxiqNi3d6e4toibmSmlOn3cFuGF+yd4Vtrdm3
 0l3vat8HCOWg/AW7Y6tHKgQ2vXDjpcKIlNOEhd3MWpgJAYfpYQv13P5r+dN9YmprQhXLG3Vw+Ex
 KIeficDj6dVhssYNTXOHITrj+QDFtxg4KbuwtZXcV1j3rKyoNVRqlKlzB7Bg8Eii5IUhJp90Lfv
 W+MLrVuM6WZ0d3uO/kp3EiFuHMjwgI41FGgkTBwNzTVtVGKAlNFN1narNOgEDm+sk/c48Km8//8
 FwyLrkmcbglHE0xuKCtUN/nTwV1WLBbPgXj9H5p8io4nHaNLF3dwsThz9Neb+kK8ukR1d0eHLh3
 5h9EAQ1Ymvk4LrdZgRPY478UYlWljTdtuArnIveskXmlBhsh9u3OjL9in3/INbSm8pdC3m4AN4V
 ijs7ZRwl8V2D9KY3xIg==
X-Proofpoint-GUID: 0feGjpiHIio_VZmW6edFuMCC5rlY-1Zx
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDE4MCBTYWx0ZWRfXxPd1Jk3Lmywu
 rdSSx9zCTiF25McxrrBZGqrzfYOrAZyPShTDRnMj+cm6lQrIgtM5ZnKv/SEwP7bKuR4kVdxOd/U
 D9QmrSwbgKDOfJLjYOtgHjoqBAHopdk=
X-Proofpoint-ORIG-GUID: 0feGjpiHIio_VZmW6edFuMCC5rlY-1Zx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_05,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1011 bulkscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170180

Hi Ulf,

On 7/17/26 5:21 AM, Ulf Hansson wrote:
> On Fri, Jul 17, 2026 at 1:26 AM Judith Mendez <jm@ti.com> wrote:
>>
>> Add post-power-off-delay-ms property to MMC controller common.
>>
>> This property shall be used to specify delay if needed after
>> deasserting power during MMC power cycles.
> 
> Please clarify with some additional information from the cover-letter,
> like "specify custom delays after MMC power off to work around
> hardware issues such as slow RC circuites on MMC VDD rails."
> 
>>
>> Signed-off-by: Judith Mendez <jm@ti.com>
>> ---
>>   .../devicetree/bindings/mmc/mmc-controller-common.yaml    | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
>> index 3d7195e9461c3..3ff68d32a308f 100644
>> --- a/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
>> +++ b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
>> @@ -275,6 +275,14 @@ properties:
>>         not available.
>>       default: 10
>>
>> +  post-power-off-delay-ms:
> 
> For mmc-pwrseq-simple we already have "power-off-delay-us", perhaps
> better to re-use that name instead.

Besides having the same dt property name as mmc-pwrseq-simple what is
the benefit of switching to power-off-delay-us?

All values will have to be in us instead of ms and thus will look a bit
less clean in code. If it is just a naming  preference, I do prefer
the current name in this version, please let me know if we can keep:
post-power-off-delay-ms.

All other comments I agree with and will fix in v2.

Thanks for reviewing (:

~ Judith


> 
>> +    description:
>> +      The presence of this property indicates that the card requires a
>> +      delay (in milliseconds) after power off before the next power on.
> 
> Again, maybe something to indicate this is specific like "specify
> custom delays after MMC power off to work around
> hardware issues such as slow RC circuites on MMC VDD rails."
> 
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    minimum: 0
>> +    maximum: 10000
> 
> Are the above limits needed at all?
> 
> I suggest we add a "default: 1", as that would correspond to the
> hardcoded value that the mmc core currently uses for this delay.
> 
>> +
>>     supports-cqe:
>>       $ref: /schemas/types.yaml#/definitions/flag
>>       description:
>> --
>> 2.54.0
>>
> 
> Kind regards
> Uffe

