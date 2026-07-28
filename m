Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E6F4746B6;
	Tue, 28 Jul 2026 21:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785275819; cv=fail; b=eEvX8XVY7/WSo5LNmSmWAjL5vyH4iGFpxZjX172pObSsI51nCLZPiecPo23mT27iEoAQ0WZ57sLWoyU+0/Px2kSbM2nouNJwUQgAxXJ2UMl+TybTTGMb1CdHeqcaZ3FxE2sYFcvjjSDAhIl9V/7o+SKORxzS5q10l5EDWQz6Hb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785275819; c=relaxed/simple;
	bh=gs8YGwvrAcs2d2+Gd1bOuTJQy6tXPriOeit2cY2dgCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=svEozhQYzi9KLHDplCo931ORNOzisI3kiAx6VNoC9ft9q2AOU8Og/Y6dslTrT8nMHoT3Akc2gk5cqRjZYm3WbUtJ0Xj/XaszrlGrMy9xn4fn2gWZKlrVa/SE+ZDHYbrSdZWYv75CeuyhHIfEMGShbbI0yDeLs9FUtXG4owhGwhk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=NL1c4Gb4; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=xcB4UqAG; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="NL1c4Gb4";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xcB4UqAG"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66SL5wLs2279245;
	Tue, 28 Jul 2026 16:56:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=o0MnZy29bsbAVfNxElcsLqrqEuJhxLKhgYNb9en0e
	nw=; b=NL1c4Gb4BZGIePOAPFPTHWDzxc8pBpwRf0XbwiOqXAtZQLm6b/EaFv7+o
	jJ5mQ7fsJUlSizlBvp+9tYgToF7KZnKT2DHKcEZYQmVzmukX/c1LdGPbDT5fenzn
	ZcvjVw2gpaVpmMzlJkQzUf+onxt7XNSMdM/+OnRue2eULf2Jl5MCGn07xP5TGQS2
	WJ9tObQ+makQuSp7o5eaUJKgZGm9EWhEXbatVIna1SgQcVCqvc80mYBDqZb4BUxX
	QZHDMhsm6HUwBNcaZMxNbeuZSxBw6reNWs8DhdfK/IAnn/hdKPKbwkfpptcJUJ1e
	DgTTFhyukJXC3QQj68ntmDBzbiMEw==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010059.outbound.protection.outlook.com [52.101.193.59])
	by m0384305.ppops.net (PPS) with ESMTPS id 4fq41vr7bv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 16:56:43 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qDSXXTpK8ltCC+Qzr9vwPC373IP9Gxer6OEOrgpHMpzhG1zq5G696ZbOO5x5d4tZrD7hOxOC65HPu0bQZF4oTVpZuPY9j7WhK+/0hodIwGzsHf7suvfttQuki4bjdklaCGByfvBMlj1GkVjE+v/37ppXRij2rFq3+axtmEZoKGW+Y89NOZH3ac67Kf41DLhwCAcaVotkOfO0SAga5GBorr2N50bGW81xQY3Hpcs1oPfLuF4kjAYFE+GpGPNiPFpoCAuMt/IV8DGwmgB9Y/qY3t+dUL1ttMs0zTX5ePWC5V92GK+O+yf5blOCFxztp+aV0BnpESveuSCEE3okJ2QfwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0MnZy29bsbAVfNxElcsLqrqEuJhxLKhgYNb9en0enw=;
 b=drzx8dUIXaXUKlvl8rNxnGmxPZ7KH/QalVsIS68IUJ1Un8Y/0GusBLJyIRd5cAHdYxTHHgx8z4ufEGivZwqStTr7zS7dL8jjCORcknCZ5FshHDLtLxVf6PTMRHXKaYrmvlnQwhz/dq+zps3SAvaDXk175A12UNuB+KZ8rmq6S78st0hkRlKWXGRxLSthotDJTGdH907XfmljpaZra5xpK19ZwRWOH7cklSPdacHafvak3Gz4SAcwda01UpxZPtGPalyLIawyZOukwYH3PIEgE2nZBqoWsLeX2kCkHMBgAfQZrQrMcGizDME8JKVLyTY+/alKb13Zj522HX5xkwpMPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0MnZy29bsbAVfNxElcsLqrqEuJhxLKhgYNb9en0enw=;
 b=xcB4UqAGTqe7Ix3txUZ0+mQODhI7Nj5rAterU+2i8AdZ7z27cnS6puSbGGCWL1Gp1BVoZQgzBj08SK5OzFNAXLOyOesNmXZa/oymia2eW2/1poS88h3qdsz3URgKBgV2IANhbhm2Lk0j154ox0O7cjHuW0zdOyq8lDxga/inoU8=
Received: from SA1PR03CA0010.namprd03.prod.outlook.com (2603:10b6:806:2d3::26)
 by PH0PR10MB4597.namprd10.prod.outlook.com (2603:10b6:510:43::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 21:56:40 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:2d3:cafe::af) by SA1PR03CA0010.outlook.office365.com
 (2603:10b6:806:2d3::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Tue,
 28 Jul 2026 21:56:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Tue, 28 Jul 2026 21:56:39 +0000
Received: from DFLE210.ent.ti.com (10.64.6.68) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 28 Jul
 2026 16:56:36 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 28 Jul
 2026 16:56:35 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 28 Jul 2026 16:56:35 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66SLuZJO4155652;
	Tue, 28 Jul 2026 16:56:35 -0500
Message-ID: <307ee173-81ae-4434-aee4-9ddbbc9e6890@ti.com>
Date: Tue, 28 Jul 2026 16:56:35 -0500
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] mmc: core: Add power-off-delay-us support
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
CC: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260722205701.372789-1-jm@ti.com>
 <20260722205701.372789-4-jm@ti.com>
 <CAPx+jO9w0utg5BhsKnUSgdCWeM1prOqoV0gCrTpaeuaWZouXoA@mail.gmail.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <CAPx+jO9w0utg5BhsKnUSgdCWeM1prOqoV0gCrTpaeuaWZouXoA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|PH0PR10MB4597:EE_
X-MS-Office365-Filtering-Correlation-Id: 56eeffd9-d068-4eee-2a1a-08deecf31a1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|23010399003|82310400026|1800799024|56012099006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	364LIRUuDKIECOpqwMif44IL46MHdW72qd/Z+M0FdPiM5CGDIhA0MItPOuN53katuwxnYW8cvXhqTUX2PfXAB9FtP8Xy2PqxZqTGem366D2s3MFNvMQ8oZ5mPOmi8Ai3FbTmVWDVQ81ONdzK11Kpgqy8cd0nnaNk+fygQ6u824AdnPk8KDWBJhVZx1AitJyJkfINcHT5IDApnFW/GDCmzaxPG1b6TYrbfVfstiZrF/ZJebh+oV+9+gw1I02pZWzqIVzhi4LjgK8gIMENBYdS3SkGjbu58R53LhkQ2dvOPfSskzcEKvLgCRgZf65caP/1KJXBnoBXcRdahB+YwFSkldvD4YLmsjl1+54mZJr80WVGE48c7I+dUnesOp9AGuEMDNnaHiCpAn0qo9QzsO0pn4LMmsdgd8/iJeXIWfKoLZyUa2BlyEYMyIcGhGm50TBVpSxY0hZtyZRzJK5QoCUDCvG5zbRwqDFzc64Ugo9WiL0bL/aItLYygIM+IrWdgT4UAoBfqHf7NJpyX6eO1EWbkE4d20ZPsk4M0q+x8j3yJc5rZcs6bNkWaM0G/yDl7LF7GAGmM0Fw/bebkAXFHHSMOgVmoJ9y80D6jCW5RO1hU3VQQukSAp4EMRQgSotvS3d//mE/IfQjtnlooXARM6zxGub7/XwTXZdH4vz/T4ETKHXyUhuPSr8tWxCK0NuU5Rftr5GLAllc4KFZEYDg80O6Og==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(36860700016)(23010399003)(82310400026)(1800799024)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WFvzyUF7PjiTQmHfElvxD4LxV1BO2DlZr1BKNzECn/E0nCWkUcU6J8wfeGLucsYi2rDbRhwJfbaF+PEB4/+DoBTNxTKko3WTDzxvbrnRAAw7cAQPGqhxT5po9JpL+4SpvEPzbLCR9ZX0mvT97gkQ4MlkaGkM3HmfbI2m5UWxkodARzW4isLGDGCguTYesqoV2qkGJm1fN0T/Co2Lko8UGCtn2uTnEvN4MT1vnA0ppL8V9DLGdXWyOczfMXTPCDSCUAMJN78oIPt1+19JVJZsPjiWM3MT26BBuX398aEPQD9JavUZZVYlcHyg/2ehEWija7csByaHwIDIm4GSaq/uQdw5JOzXJB/QlUManvVBWkTUYfNdVehmFsfzO411MEWZx4XXRqqTdF5VCSbKlvZV5eDhVQ32sofmKIytjsnJrubxP4BVo1Sc1uEENZqDIfPL
X-Exchange-RoutingPolicyChecked:
	LGp5R9vRYJvIHTJbe0ir46yrl6KFIhrUXsy1JVrAxkAqdpL12i6LdYfBsscgAm/sLVr0mCT3maFO3gFccD4+9iDcvU3mHAjvYFZ+GmR2P3UAKJJWSUN/pDu++gMzPCXutrdca00VtMLDpXpMDVhBmouEKzsHdtLd/4pNvyko0MMw6A9iCm0P11T4hdZjWkaRhz3Ay43FWYOOYeCYJ5g6MwW2rs8XNQ6T/9ll1ZA757KnCzPZjF/ogiEpuiIdkjrEJJKP6h9uCqvyqiB5dJmsGObpZDMjEN6GtfFhzVlq24/Huo5AdpUxAezA+1MljPAI/wZ2Z+UcLltvs8GEgCMM1w==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 21:56:39.1313
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56eeffd9-d068-4eee-2a1a-08deecf31a1e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4597
X-Authority-Analysis: v=2.4 cv=D/h37PRj c=1 sm=1 tr=0 ts=6a69259b cx=c_pps
 a=n1uwvu+HdmtEBt1mSuDWUg==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8 a=7b_yadTbGr7Tdn0-aBEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: k61xDtuVDwc93lKSEVJmhlTGlCLLxTrw
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDE4NyBTYWx0ZWRfX/KMyKBHjgggA
 pG+fZbR8HXrXivll3PTz77MhIIvcBnaJGeHdvoPW7357ffF9o07tpYzSzFWXFGI+m8VtH4PUIJK
 UN7/QSS6FKhNbsIfgjfdIOhyPL5Y3X0=
X-Proofpoint-ORIG-GUID: k61xDtuVDwc93lKSEVJmhlTGlCLLxTrw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDE4NyBTYWx0ZWRfXzbQYlLuHUr4x
 ZUlIBX7Oczz7y99XM5KK0oSi99WeANH2sFuwt4i2qJG+C3hGZ9hgwlulxLWQha2iRrVAeuH3lRE
 xsjF/zKobr1uz8QVJ0OV/ImLw1Mdh/Mmad/AIkH8z/GvA2rMiwuBcD9ulDe/Itzq043UevZ2c8G
 YofEJ7dft7ZhtjvGrO/zbIQmmA4MW5nal0pqjhGY2dmmi57jeBgH0MPz0Ypb7MqCFEigx9S90ue
 dQ7JebFe0SJEfH/8HlrQcO6o4X060SwgknprDe+qJypaNc9D+RUNgiLjTZtbkfOQbuXR8GAyGMn
 8RprwVMSB2ZvmPtzd/4kupM5QETxusUf6CthCbCZ9/D12iWYUbpIGSDxZC3EqiO/Rj9s5QlVdbD
 vV2OKpNQMp+OydOaf7xgcUtuGlc/U9BQEGxHEtHEx+u7Cp+E5pj10NddKZBAp81v2mlBXwtSA5C
 qpSd4o3GTiSuJNVQhLA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_06,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 phishscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280187

Hi Ulf,

On 7/27/26 10:16 AM, Ulf Hansson wrote:
> On Wed, Jul 22, 2026 at 10:57 PM Judith Mendez <jm@ti.com> wrote:
>>
>> Add support for power-off-delay-us which shall be used to specify
>> value of delay after deasserting power during MMC power cycles.
>> Default for delay is 1000us but custom delay can be passed in to work
>> around hardware issues such as slow RC discharge on MMC VDD rails.
>>
>> Signed-off-by: Judith Mendez <jm@ti.com>
>> ---
>> Changes since v1:
>> - Move delay to mmc_power_off
>> - Fix dt checks and remove print
>> - Move from mmc_host struct to mmc_ios struct
>> - Rename post-power-off-delay-ms to power_off_delay_us
>> ---
>>   drivers/mmc/core/core.c  | 2 +-
>>   drivers/mmc/core/host.c  | 8 ++++++++
>>   include/linux/mmc/host.h | 1 +
>>   3 files changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> index 29e80e5f928e9..9472041fe1c20 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -1388,7 +1388,7 @@ void mmc_power_off(struct mmc_host *host)
>>           * XO-1.5, require a short delay after poweroff before the card
>>           * can be successfully turned on again.
>>           */
>> -       mmc_delay(1);
>> +       mmc_delay_us(host->ios.power_off_delay_us);
>>   }
>>
>>   void mmc_power_cycle(struct mmc_host *host, u32 ocr)
>> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
>> index b7ce3137d4529..fac50a2860211 100644
>> --- a/drivers/mmc/core/host.c
>> +++ b/drivers/mmc/core/host.c
>> @@ -421,6 +421,13 @@ int mmc_of_parse(struct mmc_host *host)
>>          device_property_read_u32(dev, "post-power-on-delay-ms",
>>                                   &host->ios.power_delay_ms);
>>
>> +       device_property_read_u32(dev, "power-off-delay-us",
>> +                                &host->ios.power_off_delay_us);
>> +       if (host->ios.power_off_delay_us < 1)
>> +               host->ios.power_off_delay_us = 1000;
> 
> If power-off-delay-us is specified and the value >= 0, I think we can
> respect it as is.
> 
> This means we need to treat "0" a bit special and bail out in mmc_delay_us().

Ok, just to confirm, then, you want to drop these guards in mmc_of_parse
and instead catch 0 in mmc_power_off?

What if DT parse gets garbled and host->ios.power_off_delay_us < 1 is
passed?

~ Judith

...
