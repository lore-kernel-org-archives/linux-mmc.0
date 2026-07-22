Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9753D3D11;
	Wed, 22 Jul 2026 19:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784749893; cv=fail; b=LFOw/sCPuRbm/aGg1Up586xVSnLsr5XzP9r8L+PuT5rgIHYgDyNpodpyBXqF5G7fWjmB45gFydj1tA+Y3bhX5dZr961Gs4Ocgs4QPik5sqqDMXuKk/iwB6UJTmH27+32DBP+0psuBmMI6iVrwIMKXcnw5RLUEc6neTt7+LJds3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784749893; c=relaxed/simple;
	bh=uY7qbmTx3YhvI8DdHahVW4QNujYw5HWehzXfByjIOQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mXtqpN5D1fzTiucZ4lIyQyBcqRGAq0XW+Y0d+hIhDMIiLesr6vFiIHZ42RXpA9z+M8TDhxjF26Q3NIa5H6y4KVDpweHhLj2auz5GKL7KJrBdlNyYFLIPX5Cbvu1+q4VU2cX9u9dEKM3CvdyxF29qNRR7el7vKuRux4LNi4Dugn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=FMdmqdsa; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=CpQo+Lkb; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="FMdmqdsa";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CpQo+Lkb"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66MHnJXE2309824;
	Wed, 22 Jul 2026 14:51:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=uDDDtPIUYrd5IObg+b6/F1D3Br5FtzZ/d7e3L6jDE
	ks=; b=FMdmqdsav8kiwq6KWbTiSaMRmoBz7ebzhyOF/6f7Xu8VXpm6DdHA6LRMh
	MmLRCPMG57sctpF4GdvvCyUdBAp3SijS+h51OULuHjiazo+Mie/wy7JXivnQa+eJ
	Lk+Huhwu+JnOjb5dmLaZRfT3HBD0qk6SRgM0BLVAc4EbPBgb44SoxlBFmkPJg6zz
	riZ64NeqkCPoMtWAoue2g1FMhB/7y0PmwDtnW6L6VJSOzeKHbGbAaeMVCJandczQ
	CIS2dQ1ANhit+ezSlbuCRnhY2RQgmChQ5XsQ7ys3KOJkqyqZelT7TX5eDKwHt6By
	8OSOChS8XJT0/eSGUv2iGxsQHAwoQ==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012040.outbound.protection.outlook.com [40.107.200.40])
	by m0384305.ppops.net (PPS) with ESMTPS id 4fjw4jjvap-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 22 Jul 2026 14:51:13 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dn9tKayYF5FYPASOeUCOaYCygsooiTNLtqAPdslcKcAZvEgE4q/zQHKeqLHEHeZ+oY1U+fh/a2OwYVUVWADs5sLycEL6exK/e/IRqejf5fSPmRjgoSyDqWKALltzcooK9xJji4gl2Zq3Ubk4vTbHoAYZIHC0jTZ4A+f/HGrai8CUOsQedBhz1QR/s9ZTRvO0QgninorICxGtH/TDe9OH/UUXUaqCzYQpjN0YCFGOGCXa+zxKSNuSYgF55ODmS4/i5Z9pYpuXt1jG7yxg2F05cn/EkrVkFTGscV6WK/ZnwfNV7QAt7N5Ieq+gtvER2ypDL6rmBFH/cb9W3xWYVhM1IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uDDDtPIUYrd5IObg+b6/F1D3Br5FtzZ/d7e3L6jDEks=;
 b=yZAMD9HHOR0OTEhIBFU1UBrCcnTsOIOkg/lczeYqfS0OrC516e3WR8BUg5osKcZvzgJnLrCSZf7aIN2+6GG2rvrCS3errsz9fFFqUZDcK0Bqu9URx29EBNdQLNEVzuNtRuiZlK9CaoToZYqgvMtFROgsQQNgSR77fIIn7Zt1s1NNqSeuRiQ+i71Jt2X7oBbdbRkILzi8RKA5ynFgFxhxnzySBJ1aZo3G0jQNVS5HuyIxfrmbA5E03kThkmAj9cORPLzrVzQuJpN8VR0IhwjbkMAr7hURowq7LWkaszpi2lLyGbkypOiT49BLbEwy01dh/QNZ0eklGWhxemIgdBiq6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uDDDtPIUYrd5IObg+b6/F1D3Br5FtzZ/d7e3L6jDEks=;
 b=CpQo+LkbQVg9+mU2ZFf+uG7DZgok9/6VSQBnaa2aaOl9qKqopt5n7OHn78xswp+PLs2SWBvHGvNCqDRzUcpNyB2S3SLJ9uA44L2AV8hFywrgky4h1iIdpqv1POCjUQIx6gnHqQopkOGJw6myLJe/2bkCYiDGuBBCpgqz+B4CtTE=
Received: from IA1P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:461::13)
 by SJ0PR10MB998059.namprd10.prod.outlook.com (2603:10b6:a03:40b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Wed, 22 Jul
 2026 19:51:10 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:208:461:cafe::5f) by IA1P220CA0005.outlook.office365.com
 (2603:10b6:208:461::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Wed,
 22 Jul 2026 19:51:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Wed, 22 Jul 2026 19:51:09 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 22 Jul
 2026 14:51:07 -0500
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 22 Jul
 2026 14:51:07 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 22 Jul 2026 14:51:07 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66MJp7ut3813047;
	Wed, 22 Jul 2026 14:51:07 -0500
Message-ID: <6c48da60-5683-42d0-845c-698432aca5a7@ti.com>
Date: Wed, 22 Jul 2026 14:51:07 -0500
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
 <305cf4be-2f45-49b9-b933-05ac41092685@ti.com>
 <CAPx+jO8F8UQi=ZSO0qRX1vtfximLWvuqmYkpbqm2+9xeB+qQRg@mail.gmail.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <CAPx+jO8F8UQi=ZSO0qRX1vtfximLWvuqmYkpbqm2+9xeB+qQRg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|SJ0PR10MB998059:EE_
X-MS-Office365-Filtering-Correlation-Id: 74466e7e-886d-4187-2aac-08dee82a936f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700016|82310400026|23010399003|18002099003|22082099003|10067099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	/RrdMy6XK95lY7/NXwsLkxugCg6ey2IEFa+g2pIXGFeaUuLuL3k9c5pZLZAq4eU8yaLVwIfGYv9GOcQUpzgeZcYSZJmy+MW26EUVUoivxVV5ZEkrgaNoORRQ2TIVtzn7MJhCRFNstN6Dj/RpHOeTR1XiaVPUCvvz2M3JrH21s9rzBd9am0Gf0GotFXduBUOkkoSz974AuxmJyIjm9FeSSA6jOUX5ri8Ya4AXr6EtYVkAX2fSZvLsmLmNqr+TfYkwme4ejJr6ZgSVHgPCrgV+OwGjr9ipQm0C2J/XCCEVRJyfTVURQnn8uJGRD2z9+eX9Yrdw4dXSJJlV2IidnvGpx+xcUUyQJcC945VkFkCZDd/0QReYAvX0KmFn5dqdgG1D47sCD3hnBQjW1FYlM12mRcii0ZQubockHdgvwaqzm5nX6Hib7MGvaA7z//Gj214e1CpquyOn93cGRdv4IVGdg3CcX1cID7fbtoYRrmpj7dxtV0mC8hN3MwiphLXFXwJz3w4dQ8TmZspAPUmUbgegs0m88q2to4cgMBRLNlRszc+p2mW1Azt7ZbvDNAgAuKU/0JZom7YlJFRvK34k6wPadEnavnPmTAJtFCo4pkBUzXUd4aeyNfyD1BnnptXc6Dfkbi76XFOwmeju7sRVS36O1Xm8dbY8ojgxVFBxaMaEYr2iEDvbIGudBJs6OjrWofhUS+gr4VOFrs2przor2keb/Q==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(23010399003)(18002099003)(22082099003)(10067099003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	32193kENvEUgewS6LQO/QOJXTqhl2mtHTUnu3XuPQr68mZiita7689yEHqgAOBpDDrFvrveqbJqfqffyh/MywJIZhvcndrxq98MGYlBx07AgLaASmkMEfJ5gUODFNeEsRVo1Q7unYmyJAJ9WFBasphkvmd2eIy9bQqM1s0KTaIFd/ofe6x8ZemzHbJeAGv61fzDr3TJ+fb02IDKQfRBlCEv16UJfOh+G416ULNAoNUq/vEsdmke4d8aFwDWjRbHe0Q8WVv/5HwBQK9lDRJHxkUMqmu3D/KSEDtonGeuarZKs4JlP7TXQHyONHokCBW6WhLJ8G+q602k3NUV98hnKjaLe9GeSCzGwx4B2rKU3cJfLhzk7l8/Vp+BdBV75FdWNQVT0fqwPDrPiGO9eCH1VuS27XBFCpOL8KCZv4yLuTIHoWH/pBlfL+K9fo5+iAvPe
X-Exchange-RoutingPolicyChecked:
	hkhpOIIf4epkoyT2eVNHoz+DpJISRRJT9SRXy6FyoLLD8sJjxv/LyW4KpU1lc+SzljPLlTmZUyG91Z6KqWNYbfNDwWyOpE9rAEzwTjWc1gvoBZnszyV2CDbFujrxK7hthDOpc7dDghAj88+WNnNwv28TJoEyzV4C0tGgGQ5zxMYlxGIM1ii3fLzwAqkxKxODEZOhHZ6kWQJ4blI6BShIlUjFLRzyYS/Q9kEl6/qNhzLWIiXsYqXE0dy5ptjuYgJm7+Xb/ndcGrkrgQOYuzZ2rC1iFC78KbS13w1Cfq297y7FL+LGhwT+WhsMX0Y7fw63ZQZDsMQaB10h2k7xucLB4Q==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 19:51:09.1767
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74466e7e-886d-4187-2aac-08dee82a936f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB998059
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDE5NiBTYWx0ZWRfX83paAUpP/axN
 gE8bUl+EqvFlijyHScRqa8LYP9TxUpmyey0HGJdI7y9tSE92DNvG6IA3Z3UxaI+dOt3AlokAwXB
 wtMya/pgLbwq3D+1kz+qA1tDfQoxPek=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDE5NiBTYWx0ZWRfXzKoxIRleOD77
 aIsDit6izphNnG556FrBzHqUIcfPxVKN6BfQz8oOqmueRYPiLCZnxC5LrooAIB/WbrmdIT9sCI0
 ZMhOfsyKPY32WNThMjQKaiV3E3oHRLbrJXMdWkeAAsKDrfsjJg4uxB3E0DFUGVDBm9cPoQWZdaM
 jLqdA2k4vEVHRWvyuNUI5sXhoOh44n4LhQzEbpYd2+r3SuujgywxwMiuSImhEI54f1TXamMBYqt
 Zz8ZYyBrQ755l5A1yOcyTd+FImNuVIlHFMORVkzNh//s6u0RKuDwwTddUPZ83Ykt48+95JCSzuJ
 ooBSOcD0hFG/n2h7ng+qwEgerK5cw9ccYhu+GfpJck9ZLiig3GhLC9+1P8sqPWV2D7+aA9X6uOr
 +0n3M4M8rngZviEQz8R1tpaOOylkdhrsSX/AcIQ2ukC61aGaYj5QBXb0yMxEqrbEZgSrKdbfv0c
 FIu9HniEwV/u59vGq9w==
X-Proofpoint-GUID: RX5oSLXtDha9fPLpF-1lx5XX1KCAHeXv
X-Authority-Analysis: v=2.4 cv=ONwXGyaB c=1 sm=1 tr=0 ts=6a611f31 cx=c_pps
 a=f2s2IY/meXrRFjAxVkB89g==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8
 a=Bd6JFjSSaEhACtA8hScA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: RX5oSLXtDha9fPLpF-1lx5XX1KCAHeXv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_05,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 adultscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220196

Hi Ulf,

On 7/18/26 8:15 AM, Ulf Hansson wrote:
> On Fri, Jul 17, 2026 at 7:40 PM Judith Mendez <jm@ti.com> wrote:
>>
>> Hi Ulf,
>>
>> On 7/17/26 5:21 AM, Ulf Hansson wrote:
>>> On Fri, Jul 17, 2026 at 1:26 AM Judith Mendez <jm@ti.com> wrote:
>>>>
>>>> Add post-power-off-delay-ms property to MMC controller common.
>>>>
>>>> This property shall be used to specify delay if needed after
>>>> deasserting power during MMC power cycles.
>>>
>>> Please clarify with some additional information from the cover-letter,
>>> like "specify custom delays after MMC power off to work around
>>> hardware issues such as slow RC circuites on MMC VDD rails."
>>>
>>>>
>>>> Signed-off-by: Judith Mendez <jm@ti.com>
>>>> ---
>>>>    .../devicetree/bindings/mmc/mmc-controller-common.yaml    | 8 ++++++++
>>>>    1 file changed, 8 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
>>>> index 3d7195e9461c3..3ff68d32a308f 100644
>>>> --- a/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
>>>> +++ b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
>>>> @@ -275,6 +275,14 @@ properties:
>>>>          not available.
>>>>        default: 10
>>>>
>>>> +  post-power-off-delay-ms:
>>>
>>> For mmc-pwrseq-simple we already have "power-off-delay-us", perhaps
>>> better to re-use that name instead.
>>
>> Besides having the same dt property name as mmc-pwrseq-simple what is
>> the benefit of switching to power-off-delay-us?
> 
> Using ms as the unit is limiting and completely unnecessary. What is
> some HW is fine with 300 us, for example.

Ok then, will use power-off-delay-us. thanks.

> 
>>
>> All values will have to be in us instead of ms and thus will look a bit
>> less clean in code. If it is just a naming  preference, I do prefer
>> the current name in this version, please let me know if we can keep:
>> post-power-off-delay-ms.
> 
> The code is a separate thing, this is the DT property for supporting
> different HWs.

got it, will fix and respin. thanks.

~ Judith
