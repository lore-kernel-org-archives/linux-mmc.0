Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B599F2DC76A;
	Fri, 17 Jul 2026 19:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784315141; cv=fail; b=AosqjcAZZkLnKPfKG9vUFsNM3Z+uW61UmFmoTXu/mrMEQT8EeCPcxCuGgz9HOgxbNpqdl1SffkUxAxz3Cmfmpk0gi5wdEwqAkkQTr6OvwvFU4Kwh/1ypN6vQVv8D5RaIgE+jXFo5me7v3QHd7WhY8KvPj658bihEkXBfvW2KcWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784315141; c=relaxed/simple;
	bh=h8JX6NjP6wfu+/W6cRRovcdEhppo9ggcptRZ4Vfyl0s=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=WNVrvaE1C5IjS+ab6fOq+0oUr4zSgXCzMPZIC9KuqULbofIComZ9ojxazhk+H5rQnCH2XyFfPgAvf0kpM9M4udUxbO2jU02/W9ST4nYJRFqJp93/Vno7MKpTGExUhBWjrXmW0F40PvfFKMk9DXM3ddfoj5nWHE7UcJ8beGIq2cM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=MhUHUNR0; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=sk1Nno1H; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="MhUHUNR0";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sk1Nno1H"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HIlgY43222831;
	Fri, 17 Jul 2026 14:05:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=gNYCGRKYE5fNiV46epWYuWLUKMonD/5Ja6mQJI+YB
	xQ=; b=MhUHUNR0APDYawlyk5AzexYnWhZH56kb2qp70Pj0E1h6veJpLMNTSIvhc
	hoggm0FzzCaN0sTxeCbW8x+KfDY99+aT+SMPWexqWT16xcps/ly3ZxzlDt4Yi9nk
	OTsmtoLB+YpYHoMLInpl4f2xVsO6iWkQJ+fcgvbdovHFUz6G/W/uh+Tgz/RNUtyL
	3b5MFnZq6GMiSazxo5iqz2keeDoKq8c85exs/uWLu0+PAaA9jjjI7aHOllltMur2
	qEQJ5XPsFdLYCB0a6hBb1TPw339fvvriWkwD9sCOL1RDcrVLAwyuWFjIeXAwEwRd
	/bi5Weg2VSoslyqx68JyLSRpADCow==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010002.outbound.protection.outlook.com [52.101.56.2])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4ff2cd00wy-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 14:05:35 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yo9kqB/BailV+AU3uFkm6wuF8AHUi/9/PzbFKuFdc266YHIfljPPxOmRUlFV5k5G1oebuKLygkCQYElmTgptr1i6E/LlfJMHmD1qSSMEvr0txHMGR3VL0T7+CfggGlW2Uzrm8vMnKKmX2EyzOB8t7yWHIq3kbGwxWP+bNoBdBjlT6fNp1E+fjSEpmqKJwWxYuuNvVc+tDcnCEL89Q6e3WXl7zCE3nBN97cSZ5H9RwJLii6qcUTLSdAoAMUWTssiDJzsk37cmuwc+UHbPP3CmSqaZ8/eIKrFXHhLFulaptGVw95JbS+KADE+4fNXkCCu3MZpK4mUCQmd4qlkXkCVyww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gNYCGRKYE5fNiV46epWYuWLUKMonD/5Ja6mQJI+YBxQ=;
 b=LIJ3N/gMdKsEy4sXqsYy8wBd2ER8xUhKzT7ercRoALwHgFuWJWEPXnc4GCXT99svSi4v7YrBhfHO2PhJtnbl/PiXqXUeL2W3DBqgGcFuma1AGSQrk5K1yGpvr4i1k6PK/xOf/1AFdAsG/OoEP3bcix+4PZ5B19kaPEPWntiz5ptY62xdJfv9XDy0ZSAC7ZB1eLPhHaV6mbT0vMTInOXVU8LbdXMgHCudMrHiSdI+ivwYE1eJ+U1e/+tPRZxA/IOMPYNWDfAS5VlDLQO3XBJlkK3wvXCJIHu3UgcEr/AFcASxFlXGMfbId78/unaCZ+FOliUQWvzC4ILkOHWfIyVS4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gNYCGRKYE5fNiV46epWYuWLUKMonD/5Ja6mQJI+YBxQ=;
 b=sk1Nno1HGn3/ClJhN5AyijGv5IE1X47LGLpvL+kqwthl6VUueaJhSc/ulXLhH3xH4QPHbB4iku0SpFPF4gfXLZno3sJeFeCLJ9QC/r0FmcmiNU3+DaipNQg0e+XPpchpslwIb1ycoo7XL64A/YiIazzZGSayUBTl2nCCCpm6DEI=
Received: from DS1PR07CA0005.namprd07.prod.outlook.com (2603:10b6:8:456::9) by
 SJ0PR10MB4653.namprd10.prod.outlook.com (2603:10b6:a03:2d7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Fri, 17 Jul
 2026 19:05:30 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:8:456:cafe::97) by DS1PR07CA0005.outlook.office365.com
 (2603:10b6:8:456::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.13 via Frontend Transport; Fri,
 17 Jul 2026 19:05:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Fri, 17 Jul 2026 19:05:29 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Jul
 2026 14:05:29 -0500
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Jul
 2026 14:05:29 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 17 Jul 2026 14:05:29 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66HJ5SU3264902;
	Fri, 17 Jul 2026 14:05:28 -0500
Message-ID: <0516579f-cd02-45ca-bdf9-7381a52e5a96@ti.com>
Date: Fri, 17 Jul 2026 14:05:28 -0500
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: mmc: Add post-power-off-delay-ms
 property
From: Judith Mendez <jm@ti.com>
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
Content-Language: en-US
In-Reply-To: <305cf4be-2f45-49b9-b933-05ac41092685@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|SJ0PR10MB4653:EE_
X-MS-Office365-Filtering-Correlation-Id: 87f3d79d-1c28-4969-1a6d-08dee4365e67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|23010399003|22082099003|56012099006|18002099003|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	6l+lxoCTUyKVrsRFeD4dbMrp4BGHJB4fitz1sm52WRNK2QIey4sbrHj+1WI0jh9CGWtBPzM5RHiUQQs9yAvbB3bq4G20aR93ylTzNKT2A+yzvuTzwJek5Pzeo/NfJzCM/XcuwYztmeVmX5rijOtZyTxnnuXko1j6CHpuYrdYYI95YHzMZrRrNSnWqLncMOksSilbO1eHJAX3ru79Qxel9RPHddBqoWw10LxvoB5gbb9kVA9IhHWXEJmNrHHb8MNrwDGQUcLO24hmNVm/0OKgylctgHZImu9CCcQzhT9VUq9vT1se05uebyOoto8ASluAQjRdyTdX81+HZmQ2HdKlTSz2A5n1SLmOrxChbK3z+C4k644kV0/w++ecxYZN7TbUQzWE6Ym2FqsdyUUntYII4b4HA0BoymKB+P4DFF8ucYu3hchSjA3MTCpEPJjIPzGBJoECSBhS3HGM+NFaLjV2cv846ITg4wrzzwmJ44P28I+swg9ebmBkhgogkOEW8L0GvOQAwyikmJrunCptV0k6R9tKq3XpeEdwzzqCfaizfv/PdbSqeIQOA/Jqmkc35d8Zi8x6AblbO9jXVKsL/VGG0hat+/hyccJZxKczm1bR+oUoLz4QL38XTEwvHTXPz6afJIbuayqFA4XVJZXZExqQusks8tOKtMq6SvlsvcxDGDa5bqP8d2VixMSiYz1yOuuu/hGJVaPJiNxoG8SiZelk7Q==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(23010399003)(22082099003)(56012099006)(18002099003)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mvPPqowxel5vbEcJw6ULI/pm2PZyRDAxr6D0W2xvHHaaPdjXgk/EOjhphuIb/CpHKxvAe/DmHRMnIp9v5Lvp/qBAVXPzS1RemblD0waWsVN5ZkTmYHrx9FldPE3FPawZxWSIJ+4ND3i6o/WDs4IiuIWaDs8gWzLm65R9Yssuuh8W/88LYHfPdj/bFYkb8OyZ1qdw0nWF9PvOI0Pusvei/ws5AxxELJFSe3eptzGmJxbbXZGN4/0pW/eGC+eN88fcDcV8Z5LcfFizn1hJDF9aiElKPYh3mp/3YSbPRcSqU+MLJZLlHlaUlvLYsvxBGG3v9aNTDf8fdNy1UmDiXCe5K6izHA4UtHWgcZmaRJWdAxIhYmxkcZc0mSEqHsgHr0sFvQV+PbXujM144Hvw636HMXa9z9D2XNhtml6ACfGouQHCZ/i0W6IgjSASseCkgrL5
X-Exchange-RoutingPolicyChecked:
	SYqTB2hPzyaBm/6lq84j9LAwx9vQQINxKeLhHpo1GkWsKi6LbR6kwq9XHy38xmamOy/YiEdnxElnKxQFlWvlLK2oPMFHdermKY+KXUsTmpz2DPSQGPm+dyxyLtdHqASnlJDpZx2WfU3Nj9/Nn1FeafUY8XkQxR9ve1k9ROQGlX63IDiU9/68PsLrYdqKWU5V9NZya9jJvn9nYBNFEESep7LNh9RaSWE8y4ZJ4MJI7Rr7H3orJTqnmQJjjphzNiaIJJwj6deJd5RKJIquYzOBCEjf4mpeJuILZH02SOmlHA3kwr9cl7hFzGGqxoT97fDKXWEhSRdxYmGp8DZ96ZRDww==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 19:05:29.5642
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87f3d79d-1c28-4969-1a6d-08dee4365e67
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4653
X-Authority-Analysis: v=2.4 cv=NtvhtcdJ c=1 sm=1 tr=0 ts=6a5a7cff cx=c_pps
 a=l7cXxZGRKbMfBYROU17HtA==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8
 a=rn6aHjEjXkOhxztvLhoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 3OCdR7kICsqblksFqSkYD3PO-MHCN9T-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDE5NSBTYWx0ZWRfX2UwW92p4DhYi
 IdV4AI70jJOomP6q9v6Z0wj3Ftemy6TKztYujKvMt0dlidOSvNKWESVbBzD4MIYSc/k6aiTDY3k
 1D05sEAecX0j9ND2PDdS8TuIESsjFjUML0BSR3XSzFl/uOGGE7jsIwpsP14fURz+DBb3CZ3UUXi
 wDRCeUlriYw1lJboLhbq9vfyBaqunDPEryv0nmXwcoXRIikXf+DhbXAoiN5wG+z4Y8L/Rr3YQIt
 j5DfJh9g8UbHivqJzPsrISVS7nL9DAbXeEUbZRcxitp/j3gYfR2VRfLg2Ud6QK/0TLVkXitk5kx
 NxMdOY1FZ07mxaXnbgnxryNMb1RHA5+5OhHU8cMfa/efPdIlGGlXG8io5aWTvw+IWEPleTDI80r
 QpL9ek3Sgj9Xa8Lnjn5a4F3la6e48428O2UoIDV9WHczRFjLtbR7RNtgiVDTZcHEK2jF/kEOrhY
 2z2tfRZev40X9r15BXw==
X-Proofpoint-GUID: 3OCdR7kICsqblksFqSkYD3PO-MHCN9T-
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDE5NSBTYWx0ZWRfXyd2ju26DKM/R
 nn9dE+io9OMGnP4aWQ1hVeJ1cZGa+Oh555hiuO74OIQg5u3gnRcUUyV3VQYzUq2uaFGAXX0K0RS
 ro0jZXtsp54+gkVWHGoaj1vqd55gGGk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_05,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170195

Hi Ulf,

On 7/17/26 12:40 PM, Judith Mendez wrote:
> Hi Ulf,
> 
> On 7/17/26 5:21 AM, Ulf Hansson wrote:
>> On Fri, Jul 17, 2026 at 1:26 AM Judith Mendez <jm@ti.com> wrote:
>>>
>>> Add post-power-off-delay-ms property to MMC controller common.
>>>
>>> This property shall be used to specify delay if needed after
>>> deasserting power during MMC power cycles.
>>
>> Please clarify with some additional information from the cover-letter,
>> like "specify custom delays after MMC power off to work around
>> hardware issues such as slow RC circuites on MMC VDD rails."
>>
>>>
>>> Signed-off-by: Judith Mendez <jm@ti.com>
>>> ---
>>>   .../devicetree/bindings/mmc/mmc-controller-common.yaml    | 8 ++++++++
>>>   1 file changed, 8 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller- 
>>> common.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller- 
>>> common.yaml
>>> index 3d7195e9461c3..3ff68d32a308f 100644
>>> --- a/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
>>> +++ b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
>>> @@ -275,6 +275,14 @@ properties:
>>>         not available.
>>>       default: 10
>>>
>>> +  post-power-off-delay-ms:
>>
>> For mmc-pwrseq-simple we already have "power-off-delay-us", perhaps
>> better to re-use that name instead.
> 
> Besides having the same dt property name as mmc-pwrseq-simple what is
> the benefit of switching to power-off-delay-us?
> 
> All values will have to be in us instead of ms and thus will look a bit
> less clean in code. If it is just a naming  preference, I do prefer
> the current name in this version, please let me know if we can keep:
> post-power-off-delay-ms.
> 

Forgot to mention, we are using mmc_delay which takes ms, if we switch
to microsecond dt property, we would have to make conversions or not use
mmc_delay.

~ Judith


