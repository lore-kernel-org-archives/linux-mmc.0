Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E85B3C4562;
	Mon,  3 Aug 2026 14:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785767490; cv=fail; b=YiknDXjjRgjQRj6ELQOjv6Xv2LaR2TQe93t+oscPdpFxsi2ApTpTLmCLXl8V/iw1Thz5Mf11dssNFcth2UXRzllMX1pvHho1LeRm56cAwLGj6T1Bl/tmqlrQI+5c1dDKmiVtemFiX3Prn6p/QKvA5cQdmfuyuTIJz/7BjEa88a8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785767490; c=relaxed/simple;
	bh=5Xk4Ogvcp56xH6qrM9KC40L7oqaWbSBarNVnZvBCAfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JDOQGxZ3fZgT6VrDxceVytCLCvp7BvZl2JKrTvbdODtn3JKr56m/wmvog8N0Jeu48wGAGZSx6getmQOV0Bx7InNodpLa5mVIwR28YbfYLAiEAQFGIuWS77ekvaODUA2jt4RHg2XkQNGEBSYqnnJ9IGrqd/fny1Q4KlJDFMb/TiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=eLZVnA7x; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=a2lY5qq8; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="eLZVnA7x";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="a2lY5qq8"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673EF5XD096293;
	Mon, 3 Aug 2026 09:31:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=AvtG8pCMuG5YzRTsMImVjtZRO54CQrJ5Y+bsht8gC
	sA=; b=eLZVnA7xZCro31K0GKAkcXWdpxfjWVlMzTeig+I++2GTIYowIcUGVFT1j
	MIvoEeZDM40CzfLt9n14N2QvMKeFo41Y2UjseaG5rM5VzyoRvJfLoxuDEpT5q0/g
	EKibfn7OHeuaw+AhvqSVJ+hGyew8M1HZKPdgAILAYmw/QpYcCtfuWh9fa+jwto1B
	zF6uiO82bHV+GKDKR+UQSDRqM3LGvViR8jX5pAm9lynQLnz/n7xmoDJBVU4EKXLf
	qkV6FgO9OrOvbel20Bmc4KaRT/BxN2xpSH4t7/bIL/FvcID+nkCSmIhQc0ve6Bes
	HUFuB4zOeGhIyk2AYFzaXln+VJqNw==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012043.outbound.protection.outlook.com [52.101.43.43])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4ftt0ah5sq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 09:31:23 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y8+qY3QRma8lNbCN0hb1MOC/kxYycuC+39z/5hyEUz1+G4XyPM0+9vfmyJWauCKVTFu2r3VlCA4TmA0Z3dEEDAxAfGm+zmTVjPnMZ8T51NVz+SAeWxTBVNEIy8bVlPvmCPAFfvRDrp4sgu1LbuxHYeYoFzFVl3n5P15nIlY7S5ZlOnJi+mNrj1CCJJFlNPDrp0ojQaE8NzTZT4hyf+tzH3e3Dv1Zd+wS2rvOpti/NVHL6Aqu/kNOrYS7GQPV/qESHaUdikKj1Zw//RPT4f/rl2rHIF3kFGmNhNpZt1Rq/oraBvfObr+LOsPu2DWZaHymooJjcLkvYQUKuqV7Bc0DyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AvtG8pCMuG5YzRTsMImVjtZRO54CQrJ5Y+bsht8gCsA=;
 b=L2EErEJYAsBPvOt8D8q4Onh5DPsRUsYRPw3SDfLtTGDo2ubRfZWZOiIMHdNFa0QygcvkNOGepGwXHnkEO630kGOiohfDPOGWQiFSfwkp5FjnimcYEIeMqWwCOkuWvimP5hqNM1FD8PGDYF7tDWh44dg5Ejp9iVJeuiaV5nNf82IHvMYqrEN5K2eV2FKKvVYRj2jz6zV1OS+hDSMzSCdJSh5IBOlh5vwfKA0euCu/dmJySeHztGpLftaQDRFEg5h7lq0DR9etmYh5Mc/PcIVT0xs4DnYru605+J8EQca7Rb3OV0wXCWXCrsNabcQ5OBtwLpwtMA+NW2ervRMYAGaNMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AvtG8pCMuG5YzRTsMImVjtZRO54CQrJ5Y+bsht8gCsA=;
 b=a2lY5qq863eeWZbMGNIOd//kAdZgPNci+eaXCQ70iHo59KRc8aqtcczRDRylx50artkklUk6cDyM0EVCz2tHsT8YKcGRVr+zrxE+W3rzGqURXALFCMG/ZgdCs/c2wfAaH9qTgoBQtxiF+zof1ZmXrhM6kSNyXMRhceWV7NQGIKo=
Received: from SJ0PR03CA0285.namprd03.prod.outlook.com (2603:10b6:a03:39e::20)
 by PH7PR10MB7011.namprd10.prod.outlook.com (2603:10b6:510:273::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 14:31:20 +0000
Received: from SJ1PEPF00002319.namprd03.prod.outlook.com
 (2603:10b6:a03:39e:cafe::77) by SJ0PR03CA0285.outlook.office365.com
 (2603:10b6:a03:39e::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.17 via Frontend Transport; Mon, 3
 Aug 2026 14:31:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF00002319.mail.protection.outlook.com (10.167.242.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Mon, 3 Aug 2026 14:31:18 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 3 Aug
 2026 09:30:25 -0500
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 3 Aug
 2026 09:30:25 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 3 Aug 2026 09:30:25 -0500
Received: from [10.249.34.24] ([10.249.34.24])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 673EUOEa1943452;
	Mon, 3 Aug 2026 09:30:24 -0500
Message-ID: <c5ecd0b1-580e-4447-9459-f7455fa6c448@ti.com>
Date: Mon, 3 Aug 2026 09:30:24 -0500
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
 <307ee173-81ae-4434-aee4-9ddbbc9e6890@ti.com>
 <CAPx+jO_3tHk7KWjRs2dCBJC8j9FnKz64Fp2BtcmKSZSTNUGd_w@mail.gmail.com>
Content-Language: en-US
From: "Mendez, Judith" <jm@ti.com>
In-Reply-To: <CAPx+jO_3tHk7KWjRs2dCBJC8j9FnKz64Fp2BtcmKSZSTNUGd_w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002319:EE_|PH7PR10MB7011:EE_
X-MS-Office365-Filtering-Correlation-Id: 43188ba2-1d4c-4d8b-844a-08def16be1f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|22082099003|18002099003|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	HpOjoBpRTH83TU3QxTEZPjYlFhLTz+9hoQjqJkWAMeV5fJj5+Pz+CUGML1bAq+DJ08nngndj0vi5mpqb2KHtk32IA9N+N2o/60hO0yOWXbenZRc9D/M9c76nCogns74jaCvZndPC6MuMFMFh0jbgDgoH6mRPtHjOrlretgU3hEbYskxym0jLXfp+M9X+IPFZflSF/9L9stAtukCqb3hJB6qwLgUAxG61DW6NrPlHgeBP9fgBWgYhCNwRlO2MhimCvwe12HifVcu5eS3p2OAzsUoqObNQRjX018riSi+rP46+Q7vP1M6klVC8ARIn9E3zUzWf6/PMSOXZN7f1aSnOIM/HecsRt1g2CapA4ZiRq+eR3BgvPmWMxdnvpPHLetFCXz+4tBPfAuYQZwvvvrmtANX4gw5geSSL2VXte1L7jPvSznh/2niHER1VNt1D4dzpvaqWW7eEHFjUeXD5GpNxp4Az8/atEiMViDYfjW5iURKYO0zDZjFvgMlcSE9tWNo3w9A12aQDW5nqyPRqv15JYYiFo9Qxm9Ki39KN0mUjTg622wJRVndPaNsaS03b/RzpHr8YfnG68F3/6BeO8+yFvaRY7rQ4BhUEC/MTIJEp/MqV8ht36RJT2HJjqKGQMWZfGwuf95qdjejPk4orUnruqjaDUoVzVCgoB1JFb2oUmhvZB1c9aaJ668lirSzpxIPexG7JMjgX6SbJZIK/rP8cXQ==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MUEOf8tssNzfWLuUvsHQCAWk2eFWmmA5WWQzyA0Pjg0wfNA8k++TRLFVDe0kPtij4Sm8tsc/9+mQKVFiVyRJQLY82UVYit58sKsEu6dIOcZiG2n0DKtPpUmtRaRLH1Tpgu33cgaD5q1DoP5giSrm9toEUuUsZDQGMxVKVmanKy0FVjXJhJgvf4x18ES2/KbUNUHyMTIJQ9gHiHMYtxgQKsBjkGRh8ArJ2zQI7sPyOI+G0bPBEYyqObBAarM5ZF2oMsMXUci6ZnUcwHwGIriSnsRSJZ4WFrLAofpS83kg0vm7qO7VJb+KM4iEvFEe7PV1XSwMgmSpX27SnQKxPWwhTcOrQkkt3yq7lZWsy9pHIf2uZeaSHZIfikq8y4noULC8FiLEQlDWQAZgJVSAJStpf8NmZl3r6sN4VQTG2TGKb3HGJwYdvU0bYCs8PNLlIzzG
X-Exchange-RoutingPolicyChecked:
	kvBPqrnvTimIrGCSCluaMMr/ikfUkgg9TKeD48z7OUqsLzgeEH1HpSjKH0h1OKGzg7/wv5B9rpbPt6nUp0PiWPFu57799D++tR+xvpJLDkrCE+OFpPViSZqpoUpOLCteEvpnUHuCYsC+fokK76J+vyQ3PxEwS80Hi11MjHltRaurf2QlUkZn+or7TFhsjyh0Kc5uwnFBPMT3kmw3Jd8mYj0j2R7C6c0CKdPCxcpkitPKhHbMQpCXtOqdjhQkWGcEnM6AaxqMhOzUVti2S02y/QsWCo8ON1FCv9S51RnDcCbs5vXgV+9L17MzTy5dyXGyCSUKglGNFkPtDHpxXXYcXg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 14:31:18.6358
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43188ba2-1d4c-4d8b-844a-08def16be1f0
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002319.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7011
X-Proofpoint-GUID: gwUKC5KiBgKA6fMiILUkDLR1NyLiHNnl
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDEzMCBTYWx0ZWRfX9uvVgxDwA60l
 xz57qhyTREiHWGBFKnvYK8H0Xtsk0OsVXLPNT+2xJYtjVxqqtmsPyTjetTf6G+Miraj6Y5wISZP
 roDLnBYq9QTlh+OJmQE1LUIl0eL/9TU=
X-Authority-Analysis: v=2.4 cv=EpniaycA c=1 sm=1 tr=0 ts=6a70a63b cx=c_pps
 a=qH/fS2hzlQnCJHG7LpbWtA==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8 a=kiscE5o-xquepUd7VNQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: gwUKC5KiBgKA6fMiILUkDLR1NyLiHNnl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDEzMCBTYWx0ZWRfX5brAHeKnrzqh
 CuljT2xebauTXNm8O4HBZsyXnRMzvsJCMyRvyp9oy/hZykHNREmAFKUSb7jBucJrojHSLUBML2N
 P1zgA3rF3aeKV5ZiS6pEZEAgpft4myJrCONVBKenk7QFy7bn1ithv+06fpwtG9tjaY9t4viwkQv
 10q6b9KqERJrkR+XDwZOiE5/XS7j9iWr6GfivbfWyX+sFzJ1VjOVUurpxd+7SSR53KBnUiv5QJL
 aN5aYwI+xEUI9bctQnmIrsheZqaRKGYxd2cQzPyWWiEx6T/g3mUodFLYa66vV5h4kSGxVoZA5zn
 eBXYR00dVIQNM0fVIEy3QI9stLahLyv4IyusdfDS3cPjlgeeHl4+z9x+K+kiuDbCwAuya8e5EoZ
 v/Zp2JTVY1ClLNW6JV/26vrBZ5jZYs15vSZ8ifNmS46eow8/cYbDgz2yij9shw77qb1Ics1HEkP
 nEq1AtAN0Ql4sdtH8Aw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608030130

Hi Ulf,

On 8/3/2026 7:27 AM, Ulf Hansson wrote:
> On Tue, Jul 28, 2026 at 11:56 PM Judith Mendez <jm@ti.com> wrote:
>>
>> Hi Ulf,
>>
>> On 7/27/26 10:16 AM, Ulf Hansson wrote:
>>> On Wed, Jul 22, 2026 at 10:57 PM Judith Mendez <jm@ti.com> wrote:
>>>>
>>>> Add support for power-off-delay-us which shall be used to specify
>>>> value of delay after deasserting power during MMC power cycles.
>>>> Default for delay is 1000us but custom delay can be passed in to work
>>>> around hardware issues such as slow RC discharge on MMC VDD rails.
>>>>
>>>> Signed-off-by: Judith Mendez <jm@ti.com>
>>>> ---
>>>> Changes since v1:
>>>> - Move delay to mmc_power_off
>>>> - Fix dt checks and remove print
>>>> - Move from mmc_host struct to mmc_ios struct
>>>> - Rename post-power-off-delay-ms to power_off_delay_us
>>>> ---
>>>>    drivers/mmc/core/core.c  | 2 +-
>>>>    drivers/mmc/core/host.c  | 8 ++++++++
>>>>    include/linux/mmc/host.h | 1 +
>>>>    3 files changed, 10 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>>> index 29e80e5f928e9..9472041fe1c20 100644
>>>> --- a/drivers/mmc/core/core.c
>>>> +++ b/drivers/mmc/core/core.c
>>>> @@ -1388,7 +1388,7 @@ void mmc_power_off(struct mmc_host *host)
>>>>            * XO-1.5, require a short delay after poweroff before the card
>>>>            * can be successfully turned on again.
>>>>            */
>>>> -       mmc_delay(1);
>>>> +       mmc_delay_us(host->ios.power_off_delay_us);
>>>>    }
>>>>
>>>>    void mmc_power_cycle(struct mmc_host *host, u32 ocr)
>>>> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
>>>> index b7ce3137d4529..fac50a2860211 100644
>>>> --- a/drivers/mmc/core/host.c
>>>> +++ b/drivers/mmc/core/host.c
>>>> @@ -421,6 +421,13 @@ int mmc_of_parse(struct mmc_host *host)
>>>>           device_property_read_u32(dev, "post-power-on-delay-ms",
>>>>                                    &host->ios.power_delay_ms);
>>>>
>>>> +       device_property_read_u32(dev, "power-off-delay-us",
>>>> +                                &host->ios.power_off_delay_us);
>>>> +       if (host->ios.power_off_delay_us < 1)
>>>> +               host->ios.power_off_delay_us = 1000;
>>>
>>> If power-off-delay-us is specified and the value >= 0, I think we can
>>> respect it as is.
>>>
>>> This means we need to treat "0" a bit special and bail out in mmc_delay_us().
>>
>> Ok, just to confirm, then, you want to drop these guards in mmc_of_parse
>> and instead catch 0 in mmc_power_off?
> 
> Not exactly, if mmc_of_parse() doesn't get a valid value (>=0) when
> parsing for "power-off-delay-us" it should not set
> host->ios.power_off_delay_us, but rather rely on the default value
> that we have set in mmc_alloc_host().

Ok, so

if power-off-delay-us < 0 -> use host default
else power_off_delay_us = power-off-delay-us

And in mmc_power_off(), if power_off_delay_us = 0
what would you like to do with special case?

~ Judith

~ Judith
