Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E35471D14;
	Tue, 28 Jul 2026 22:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785277732; cv=fail; b=S//0evakG3YH3+4khUacbvLS/B1hAKjLQzPx+QEq86D8yegoqu2QfDB8uW/PZ6uxrwdtbDMBK43+sfEAyQEaP9s1F5r30Qve+g1P+8Tlr6sWYKitjg4VSxK8U7rPya2nrvnmWhc7OW/L0Y7r/AKpD0Yoi2iRHeaSqKctfQxH/tQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785277732; c=relaxed/simple;
	bh=aIGJ/1KUgidZFPeVNMcmU+fWiys8q2JQRRGp41V5uvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jDd3kBUE7BYLhFvOt7cDbPvKfmVZx6ZvkYMRW+TCU+zwA4aCyNN+ny7es+1GIOTEdYDmVJgaOpTbqP3rh3EoVy56jae8TFmwCvfdffur7MBJ+CZY5x3s9CkYB1a+AxYfreSc9mneFCY9rPwJdGm1iFQuV6x0yWIwtqGnSN5Mp10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=X5q51W2H; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=aAZfq086; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="X5q51W2H";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aAZfq086"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66SL5KHG620519;
	Tue, 28 Jul 2026 17:28:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=szuyTgQu+3mPkGdecSrLOJPRvBdgunmGhEOFHec2C
	BQ=; b=X5q51W2HvP0YhBO/HLUdpx/kAJcZf8G0l40EfVQhDLtYe5gm7tWC0Jg2A
	ECBgYuJSQCSJ8S8B2Svhc5+UI+IArBBOgyx1pBuTXXKrcA7beLd58x5UsttzHJjD
	SZsr2PtrSFiY1aiyJaU6eHeoTslphBAeRxkYg4f0pq2NRyAsAlXDMAr+33p2l6OL
	EBL4FZmxzZw4/hEXsPve82pVbd9NLAPTwxTE+q3h4SsyDajktLZgMqTZcWnaw3dc
	FG3+jnacjNRP9ibhTRP65/HNUp2jmjoOrpeWY/2S97J+k7YVAc5bPA0N6B04P9qj
	dLDI7qAPyQORpXT7EMw58OiDErioA==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011046.outbound.protection.outlook.com [40.93.194.46])
	by m0380145.ppops.net (PPS) with ESMTPS id 4fpufxv43d-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 17:28:46 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=swp2cPDVlzkLbV8tcQNaYKzWA2XLpeFu9qZbAfdoLdaiGNil3Z9qYP8bQ8Acr4WVXnB5HyIx6+66wwjytmKdlSqzN7AklEclJwCsKnES0tIwtlktuBcD7SkkaQ29VRTOiKbhgthnmh3T9i4WXGUt3G5WpuV34aK78k9T1azemW1LQE1D/5lLciZXp3cjagNnCHAutSleltPmELdreAdLaO7Ov0knCKImWZwwJFP7NUO+kkEv5rZyb6sM8/RJ41KnSXoAI/+a7w5HAFZhmUgHC0LdFKfJi9hZt1lvQQwbwKEFh+oupCZQVdpwAhCnccSaUjeLBg02QnCo7XalRL/38A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=szuyTgQu+3mPkGdecSrLOJPRvBdgunmGhEOFHec2CBQ=;
 b=W4M/0JJiT5ajwH0mBWWR6VIKIs2s2AqF4MS3hOwRCdfdnBXi+ixHQxVDY7GRnANI50ay9VOfMcfCuPxQc/gtsfa4pBrOqY7lB0RQftwGNPooKpYv8zLinQWhm7LNULsEWVViXfUQlaY/83Oj9D5wGtL0oKb5CwACfrdYw5Yu8ozM/VtKLAN59CuPoWsQgYNmpRW+EogCrnwqijJG6u430XVk2iT/+U7DS/FFy+okkcNOuf90qmvcMx9chl4fdbGms9aON0etJ477zV3rjW/uYC42j1TB9boErM2uklH+ZBks3qlOs/iL0EIyvF7u451dGT4jVaMUQUMpj6Sv527yLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=szuyTgQu+3mPkGdecSrLOJPRvBdgunmGhEOFHec2CBQ=;
 b=aAZfq086JkMEmJKrEDyZl47ryF1QUwf9NpX6UddjCSOw9sO5x6DV9pgbiLCkE0XwFD7jcb5j2HpVg9uHexgiPVd7sfPg+sFDBnIbJYlPJXwxdg87hrIiT/8XFnGrkd38S2rjwSw5XSKWBNPMaU+zU3CMRHyZNkduh8I1qokJVNU=
Received: from MN0PR04CA0009.namprd04.prod.outlook.com (2603:10b6:208:52d::30)
 by PH3PPF262994532.namprd10.prod.outlook.com (2603:10b6:518:1::78f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 22:28:42 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:208:52d:cafe::74) by MN0PR04CA0009.outlook.office365.com
 (2603:10b6:208:52d::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend
 Transport; Tue, 28 Jul 2026 22:28:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Tue, 28 Jul 2026 22:28:42 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 28 Jul
 2026 17:28:41 -0500
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 28 Jul
 2026 17:28:41 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 28 Jul 2026 17:28:41 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66SMSex43575728;
	Tue, 28 Jul 2026 17:28:41 -0500
Message-ID: <6bceddfa-fa5a-4967-a2ca-737db64e741a@ti.com>
Date: Tue, 28 Jul 2026 17:28:40 -0500
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] mmc: core: Add mmc_delay_us() for microsecond
 precision delays
To: Sebastian Reichel <sebastian.reichel@collabora.com>
CC: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260722205701.372789-1-jm@ti.com>
 <20260722205701.372789-3-jm@ti.com> <amPkAhf_LiXGjzC3@venus>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <amPkAhf_LiXGjzC3@venus>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|PH3PPF262994532:EE_
X-MS-Office365-Filtering-Correlation-Id: a3e33973-3761-489e-ece0-08deecf79448
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|23010399003|82310400026|1800799024|56012099006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	JsB9fSeI1wQ6C/7U4pYuaRpzsmt5D8T41iVDR8qL9KBAMP+ly8ppmQvJ46o6biFj6QGUYdg+DSCX25peCpnYBXOtCOV8LsBCppdZAQ/jQnG64oR1YSXXgkpouZTzlJKCBWjTL0mKBgonXiCODCCNRv1EkPp7+snVNXbTQ8dyhWQW2ar9GbI/hbG9zBUzGhcDgnp+lSTMyJxhHkWfAi1DDZ3XWdNdhSTiexAfMAuLgTHHJK6os0fvqI1gJu2fgoMXOfx8CPl+oyRwvn72ClJzKgYKniNTzSjt4bVJszAwVbtR/sGjkB+5sXCm3NQv9KDF4072GyMRX0HeiGGpGpje4DAaPZRu36qyfyb20oqb8HtTCoqwbMKBXkr5UVjMMkkK/MvThnJE5ZHVvg77r2kwY30WBNP4sghP0sytFxxZ4LWAui/X9quFkLGORY4WmfgPBCaNwnmTtMXIEHU2w8mXj/aV17EFLOZQNo7HICuMMpkBCv+ptO4cj30XJ8r2Q5SzDTS1/TEqsAFdp+PxE8pACZW3an56ymC+KDes18TsWH+5LZ6uxa+rgAprs8c8TULkloX4zss8oE1bmV5Ly3uPK7NpL3IeCM+OLOCfY2ZxzWU6H5TQURKVjwA94TMhcZYrfBAyGHCzPjFevZKAybkheSEi9TP68dMofz5XN/Tp5KyA2HJSbq8zLKvcKARJR2egJJPZNjUANjIC2XTZXO442Q==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(23010399003)(82310400026)(1800799024)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5ZUzRPSzMU+FkJmuZGtxuBpmY6x9gJW1/h2Hs+87jr1tXC+SVj5ATSoLBll2OXESlnrM5B7HAyVC7XEXIbjGM4fi5nuBnZL1mXN+ONSllMnENQDiTgVP/3WFSLJXETDKgcnchQy+5GCGf9z14nbPxztvpIdiokdbgvA+GbsnXgXWVSY6rtCrCmE/pqkgXWce/ZuBpVRPD8KPYPkQeiPf2brqEI8FBGjkiiZVOP+W2c226WHW9AvrBz8mwY3y5KCzX3m6icTdEPJOsQ7B6smnl3MEUzZ+65lmk6mVRVkvwSI4uJYtpJbWC/juHDocJzngbzLtCyFplFvUBO1KwigNd7oDQdHjVfDRHLQJpj6FQ7rbLpS3DOt4+kOfdyNnAvgjEJ2ErG6HQhEUwHOXlLgCuOsopkY2vg1ChPt+ZiauP3O/ojluK8YCTnuM/CaHAV4e
X-Exchange-RoutingPolicyChecked:
	VmeYNCgZDtpjfHjMe/i/8NTTlzThA5AguvXTdG6iYaBOfQ57SsmE48EE8YKb1kViRDhAJ6JCfF2HSHAv+A0UHi5crcUiwnh5RMseBT7bGwTs8cQTXUnhcDBhvczigIaqHsO7fww9DPx2ExAiTEnA3+/bSnIilXjWw+7pWn2NeUj+CZM5dB9h0NlGOT1VJT78UgQs+Us+d31PchtZhYsf1dbeOOJyi1MNNVc8COvCg05XtIFTcL8IyctgYjeboeypV8vFaOXv8TwCuwnGHsrG62KbcA6Stq7i8LPBSGMS9T6KmlQlmZykjAbPR4Q6Q53b2d5uVb8C/qZM1YhWG7GJcA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 22:28:42.0881
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3e33973-3761-489e-ece0-08deecf79448
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF262994532
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDE5MSBTYWx0ZWRfX7c8PPCrDll0k
 UuywJfeVFNripKVGKRBdhtqMBCA/A6WQMN2n+lHHgpxFY/js2cEpEBJFbFI5T8AqjaZfFX8CiZY
 8XaScbhbT/zkH5IGQ+Ri85VEhp+81kqLqZ7nMwWp8iJ5mtBaRChTnaaqTQzEwycWbfp2TrVYQBc
 EmM3soDPuENBsvmeF/AMQ68Nvuh58bRmkDIDvZN57H3QFJXvH44oOD1WZyHiefXF9Tfpb4nKKBS
 ENfGewQMatGQdCiVVQuaNLSP3+Z5d8a3v+VI3aGj73N8ggktQctQljMne8CWuHd2VKtP1ISGyEm
 zmEsYJFYRipPoxg0O/lWRFVkrThxeOFM5lDlTrVQU87Rb+7OuSgypUSLaPi49UzOhILQXBAYMx9
 3r7kADzqgDtPoJEdrGROWlDyHc9utE3mIf+qE4ib7ZSUyVf7HUKGS/rQOZgo6npcdnk/b8r/3aQ
 yAAAPSpj1CK/ZSCMp9Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDE5MSBTYWx0ZWRfX1lxmpgm+yAo5
 43/i+43rLrMw57WKTLiIed9oy/B8fsNxsVNbj/jNvgIkr8utdjOZifthDKpYRHmGkARCSdFlgZV
 PE0KNi5mXu2moYeyRPJumlvXMXa0iOU=
X-Authority-Analysis: v=2.4 cv=a70AM0SF c=1 sm=1 tr=0 ts=6a692d1e cx=c_pps
 a=kRgXGWC4h8N5Zk8PQP6WEw==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8
 a=FOlfubG17nqmgHlx8pQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: u9ledypYMolDY963gtGNwtcWT8hbmK6_
X-Proofpoint-GUID: u9ledypYMolDY963gtGNwtcWT8hbmK6_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_06,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 adultscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280191

Hi Sebastian,

On 7/24/26 5:17 PM, Sebastian Reichel wrote:
> Hi,
> 
> On Wed, Jul 22, 2026 at 03:57:00PM -0500, Judith Mendez wrote:
>> Add mmc_delay_us() to support microsecond-granularity delays needed
>> in MMC framework. It uses 25% margin consistent with  mmc_delay() for
>> timing flexibility.
>>
>> Signed-off-by: Judith Mendez <jm@ti.com>
>> ---
>> Changes since v1:
>> - add patch 2/3
>> ---
> 
> Looks like you should just use fsleep() from <linux/delay.h>.
> 

Actually yes it is, thanks!

~ judith
