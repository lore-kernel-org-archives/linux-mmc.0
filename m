Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75FC37267E;
	Thu,  6 Aug 2026 14:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786025310; cv=fail; b=pNd7q1klHZi+rJ9919+JzK0yc4rClp5Ek463OkLylyE991CKG0I8ZYdv+BKoCcyrK/Vz4NY6EwOWhhkIrN/Cmkf6U18pGrodY0F0Yz1leNa1m8lrJ9Bf2vEfv7HeSOR+L2H+bXaGemMjVPe2QX0Q2yfG7VLtI77Fdlki996tdAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786025310; c=relaxed/simple;
	bh=3QQoSRDoqkqcVi51rHV7u5+DwLDI4xS95JUo8JLvnJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WcWhxfEqJeWBHntq2ASwEA4iSJu1xNIsFOOL02dG7B+a6OmTVFfXp1mJjMzTgSbcSVapaL+NRYY/tzAQYVm1UJWIaf3KfC9wlUU6JkAuqMamQv7RObwzExSJR+Y5+4kDHLaOKfno9VPr1UcKvOKdbTL6pzZ1tT2Uz8IBV9+X8G0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=nfy0I36n; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jJZ8OpPn; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="nfy0I36n";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jJZ8OpPn"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676BDX4i3936995;
	Thu, 6 Aug 2026 09:08:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=ziikOwFy2AX6/Pi2maMOpL5Owh0Fo5c8GM9VT0FkP
	44=; b=nfy0I36n4q+w95mTgSXIT3KK7jaO4P2wMWHFhgNflDFOSP+AUkw1k4/rN
	UQ5PbpHqlW2dZh+oIOz3uKsxTnzRgzi2Sdt7C18c2Dj8CNp/nydle6F3bfBmMFqH
	TyEK+zfFd51+Wo1jPNJbv0WWSpYxDKAXlAtWHy9CJ1Qh82ogravQXND4GCzl2YXh
	6pkosl6QS3ESXUk23462eafaKbrejCNCFhhOhTjO7um0O+8mNseXjxAygeLe+7dK
	zSIlEwvU1wkmp7+kcGm43q7QWtPf8B/Mh7dkYYBKOnc8VW7Q6Sh4UOgkgYi+x9xV
	87TaM0d4/hsqRB9CqfJ0IaFbDSeFg==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011068.outbound.protection.outlook.com [52.101.57.68])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fvs7393gw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 09:08:23 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=saxXx/RZilxd9Hqp4G7rmOtMLPIFcV5f+7el1ldtbRI3CDL8t7GfdwSJNFqf1gui0WYpNWnz4RUul09WYlyMSTdlwiTs82835djgIS0IfU8CTgPuKNM+hGcFyKKZqy+8zqMOH87rSBSMN8qxnEWmDUdOOB13oxtiUyG3v2bZG2mmzrdZ6veoobpIe1f7DSdm8jYYhywZknyjWY7LTyhs/nAFSqi455j+5A4/5GlluLzXrpUUZM8imjaabZp0AL80s3na/yerPEdICrkgAp0uxxuU9WP348X2CXLBp9DATBdxW9NVW+4W8zF8B1T5gxMv85YPmI/ru/dTMdnW6iTXnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ziikOwFy2AX6/Pi2maMOpL5Owh0Fo5c8GM9VT0FkP44=;
 b=gt0/oNxpKbKXCAtoCrjB+w24N43yEwgmVwJv5inIZUFJ1O9Foc2XLIIyVeHxYtY/nDWrEUoQAzY1cxOVTsxev5BKhkgDJtT2GoUeRomhjFvKc6ApEy1hey7Q9lZkyr9fz1FBdvp2e2qMmJGweCdEtc1scXS4CyW1J7+FkqHlEbwQwFan6cOP6lJkcRe0wPp8+T4YSO+8dgXrYYPjdN4KEDrC4K+IUZQX6ek2/WAJKh7kCzulxPAQkvu90+3xRhpnDAtbv7oatF9G2Jzq/0eCBcj4eiMX284dmPuo8Q80hkoFbgV0QYnQs42BcGq41ham0qQkRWOTzye/jJJfILh0ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ziikOwFy2AX6/Pi2maMOpL5Owh0Fo5c8GM9VT0FkP44=;
 b=jJZ8OpPnXW2KOwIhnnKozuOX5zg5dyqpqrXAxm6BBBrQL4E+sj2OjUmByGjCZ6R3YptRZixy3Ads+lzkekTSKZMzAUBHbP0Jb0dGe/AN23oOdBiAbfQ7hH7ma/sSPPs5/wGaeXzFLZNfNJFOU1qtormgkl+zPYjJ9pwC13Y7Wak=
Received: from CH2PR03CA0019.namprd03.prod.outlook.com (2603:10b6:610:59::29)
 by BN0PR10MB4965.namprd10.prod.outlook.com (2603:10b6:408:126::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 6 Aug
 2026 14:08:21 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:59:cafe::61) by CH2PR03CA0019.outlook.office365.com
 (2603:10b6:610:59::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.21 via Frontend Transport; Thu, 6
 Aug 2026 14:08:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Thu, 6 Aug 2026 14:08:18 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 6 Aug
 2026 09:08:11 -0500
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 6 Aug
 2026 09:08:11 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 6 Aug 2026 09:08:11 -0500
Received: from [10.249.35.38] ([10.249.35.38])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 676E8AGc3447971;
	Thu, 6 Aug 2026 09:08:10 -0500
Message-ID: <a4cb2377-e7fd-4b5d-992e-31c89351aa32@ti.com>
Date: Thu, 6 Aug 2026 09:08:10 -0500
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
 <c5ecd0b1-580e-4447-9459-f7455fa6c448@ti.com>
 <CAPx+jO_Yc1rBcxatzByy6cWAy6JdXcLXqkOpFbAKTcEsK2ASXA@mail.gmail.com>
Content-Language: en-US
From: "Mendez, Judith" <jm@ti.com>
In-Reply-To: <CAPx+jO_Yc1rBcxatzByy6cWAy6JdXcLXqkOpFbAKTcEsK2ASXA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|BN0PR10MB4965:EE_
X-MS-Office365-Filtering-Correlation-Id: 4afca463-5740-4c09-fea4-08def3c42acf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|1800799024|23010399003|56012099006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	7WQuJT2yG4FBhw4tCIuSPK6hOu1R0+36FQUP5g+mnycVTaaWGWDfFTwU7vjZITOOVGcoObGTgTcic0rhQZJv9Mklf8yTKqnnGYNb0gPZVhFKL6Tz3iXboSsrPfqsLkqUPfY02243pgw60yW+CEy+xzumKbPO5SSP8lQYGIv9Ed6UkAORKHT54IDnuBMDtHZhsMvRdqyTB1cmDE3FdSxV/NBWPbMiuzaLHR98fqaDlUmu9d1gTpgjsxS0tTz8PbS/umpVburZeN4Nu51SLgmtlaP8iMpa3x6YEgERy0cbkJKPoB0UHdm0QMWFwAlwqyMVCM/YstZ4sv+e8pmGIKZqdGskU4lUYQ97DqBGAoaq3gUf7iRKCn4AzKRIGTfC0d9R6mSzYQJu8ku5HG0ypHKqP5OmB8DhhyW0o+Cqegm1hVBqvGDJO6b1ltciejzT8OramE+trb7yW4fu9Ko840XMmmKcZmgB9B1HM0M9ojMhaFFEynM8xwNOD30XHNh5CXob7TeZNfBHC8qpHYBYueWmaprJzsv9emr5pMJ+zV1654U+ixbvyfI1QNftVBE1qca/jc8ZlFZbX7/x/8gWXsRCRBc56DlYBZUT8b+U5+7mF/iC9LdfylkAx0YB68tGUBsE1jp4wrVgq3v0wGvm8sNV2j8cAAtBTzzGyQuf1rGDeJRYkp2ldNleKXANSK3QqJVK3owOk6+f4zUBKJnpAdNXFw==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vBBTk9aeKNP2aoeRZIPms4HfGLc80YwBbnqM46eU1655L1BSAewO4cx92GBlO/ItfnyH263mAqpe3TKfYYLcGDDar9Sq7gF2KA0oMFGsT6JUtpsV5Zn37qjzMyeRMYdublLcAnxXG8O/YamXTPrBgTmqqBmYK9l8Ei0mYbAdSz/UwBuxI/Cohcp68tTg23Ghgcs3jTVH6hPRWn8I9V1gMeDjtEJCRJ97lcmhbdHLX4Fr6+SvO2c8Ccv1CVgYZ0Dh7C/oPvk2ie9+xFB1JNuzXkr1jPZwt/J7HBWPO/KGAYNmZlXeMlbUcJeyUB2onlOefZ3mfeGDHRXU1jZwe5HvJ0XQUcpXNPKNTQiVcmhNPkRPbsefW2jdP4GE66GGIQ6fZz4JBKj6gTuto0he4K8jgYFrM1L30dHKoUYwPliEN53QSzvKZM4SQYY9zw3oTyoO
X-Exchange-RoutingPolicyChecked:
	Z3kVTv4b6/Cn/F+NsnLecSgamqd3/RbHW7EpcYj6u2Gu/IY9RgKhqsp8NoqjffyO0cmpKozc3LwoX7pYPfBjX0miDx+bBX5tI9XMI0gZ+mQG7fNRejRUGldQANmLSmoCbd+9En7AZhR85sgzyJvfCwFrRHshKKH9LWsXXU4I/W6dP6cJ3AJs+QHcZJR15vRmQ0K1I1WImU0joFl1ywz7dJhWM7ZmDYk2e41ASMz1AqgLLTjz8IeQPuYX2I743Ga4o9rWscldG5SoYgPtqgBtcuzfxiLsh8Jhg+F3ya7UHC0G9AQ2NPu6uMwB/zkKCT/hz35vNFKWMV09nZXAsIgRiw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 14:08:18.9618
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4afca463-5740-4c09-fea4-08def3c42acf
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4965
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDExMCBTYWx0ZWRfX160iLEwsl0ba
 qv83bNdYcXj2fwkz6oG7t3PWC/3AuLhGzyHxINgoj0jOAlzHKwaxc9z5ND1Or6Q00iQr3PIhz+c
 2Fld5JsNNs2eJNKHjjrWYddc6fZ8fGHmDF5o6p7lxa2oALurQFakR0Gv70OQvwPx1iR9GZ0A+7w
 0PhHMmNX1nS+51vGHq1KRJNUfFSJf7kvmz4oBA832JRmE+UZx0ArS+VaZa+Tp3cRNuBagRn3z4X
 Rb72ZCidZyS6Y/KsQEHoB2bMgrUW4V3ZbiYgC6ULnDyC8uSrOztWxGGlVNKXxbCUvVnW2c2Jx1R
 cfJ05bVh8nq+59SDP3UuSeZFJxv++RUT4gSMIRgCW68ARQWBthFSGm88u5cy4h8UJlXyCmBhpkf
 axYKI9MxqGu11QB7JUYk2oRTGXe7jO64qvgJj8B4ThBL+Tx/oQ2p2Vi7LWTq0PxaI/v6nqWHD/o
 wAL6CVz64g95uHZI9Pg==
X-Proofpoint-ORIG-GUID: xo-L2BdGVTrlswOFxnzoF-ibe8jrm_1r
X-Proofpoint-GUID: xo-L2BdGVTrlswOFxnzoF-ibe8jrm_1r
X-Authority-Analysis: v=2.4 cv=dtfrzVg4 c=1 sm=1 tr=0 ts=6a749557 cx=c_pps
 a=lgH93Z6fMBj3OFKE3BLqTA==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8 a=LabPNrY7txzJhcC7dNwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDExMCBTYWx0ZWRfX53m/+ZK41HhN
 vghlH2qnosbT4GYQuJjKl4IqKBeC3PPrEVwYhz+5Pzx5NcDRtHoT/VLngR3YAeIXFZ21zugrW/r
 CLoZTyS5LidJm36UNd232kHPKki64u0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 spamscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608060110



On 8/4/2026 6:02 AM, Ulf Hansson wrote:
> On Mon, Aug 3, 2026 at 4:31 PM Mendez, Judith <jm@ti.com> wrote:
>>
>> Hi Ulf,
>>
>> On 8/3/2026 7:27 AM, Ulf Hansson wrote:
>>> On Tue, Jul 28, 2026 at 11:56 PM Judith Mendez <jm@ti.com> wrote:
>>>>
>>>> Hi Ulf,
>>>>
>>>> On 7/27/26 10:16 AM, Ulf Hansson wrote:
>>>>> On Wed, Jul 22, 2026 at 10:57 PM Judith Mendez <jm@ti.com> wrote:
>>>>>>
>>>>>> Add support for power-off-delay-us which shall be used to specify
>>>>>> value of delay after deasserting power during MMC power cycles.
>>>>>> Default for delay is 1000us but custom delay can be passed in to work
>>>>>> around hardware issues such as slow RC discharge on MMC VDD rails.
>>>>>>
>>>>>> Signed-off-by: Judith Mendez <jm@ti.com>
>>>>>> ---
>>>>>> Changes since v1:
>>>>>> - Move delay to mmc_power_off
>>>>>> - Fix dt checks and remove print
>>>>>> - Move from mmc_host struct to mmc_ios struct
>>>>>> - Rename post-power-off-delay-ms to power_off_delay_us
>>>>>> ---
>>>>>>     drivers/mmc/core/core.c  | 2 +-
>>>>>>     drivers/mmc/core/host.c  | 8 ++++++++
>>>>>>     include/linux/mmc/host.h | 1 +
>>>>>>     3 files changed, 10 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>>>>> index 29e80e5f928e9..9472041fe1c20 100644
>>>>>> --- a/drivers/mmc/core/core.c
>>>>>> +++ b/drivers/mmc/core/core.c
>>>>>> @@ -1388,7 +1388,7 @@ void mmc_power_off(struct mmc_host *host)
>>>>>>             * XO-1.5, require a short delay after poweroff before the card
>>>>>>             * can be successfully turned on again.
>>>>>>             */
>>>>>> -       mmc_delay(1);
>>>>>> +       mmc_delay_us(host->ios.power_off_delay_us);
>>>>>>     }
>>>>>>
>>>>>>     void mmc_power_cycle(struct mmc_host *host, u32 ocr)
>>>>>> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
>>>>>> index b7ce3137d4529..fac50a2860211 100644
>>>>>> --- a/drivers/mmc/core/host.c
>>>>>> +++ b/drivers/mmc/core/host.c
>>>>>> @@ -421,6 +421,13 @@ int mmc_of_parse(struct mmc_host *host)
>>>>>>            device_property_read_u32(dev, "post-power-on-delay-ms",
>>>>>>                                     &host->ios.power_delay_ms);
>>>>>>
>>>>>> +       device_property_read_u32(dev, "power-off-delay-us",
>>>>>> +                                &host->ios.power_off_delay_us);
>>>>>> +       if (host->ios.power_off_delay_us < 1)
>>>>>> +               host->ios.power_off_delay_us = 1000;
>>>>>
>>>>> If power-off-delay-us is specified and the value >= 0, I think we can
>>>>> respect it as is.
>>>>>
>>>>> This means we need to treat "0" a bit special and bail out in mmc_delay_us().
>>>>
>>>> Ok, just to confirm, then, you want to drop these guards in mmc_of_parse
>>>> and instead catch 0 in mmc_power_off?
>>>
>>> Not exactly, if mmc_of_parse() doesn't get a valid value (>=0) when
>>> parsing for "power-off-delay-us" it should not set
>>> host->ios.power_off_delay_us, but rather rely on the default value
>>> that we have set in mmc_alloc_host().
>>
>> Ok, so
>>
>> if power-off-delay-us < 0 -> use host default
>> else power_off_delay_us = power-off-delay-us
>>
>> And in mmc_power_off(), if power_off_delay_us = 0
>> what would you like to do with special case?
> 
> Well, we need to bail out somewhere. :-)
> 
> I guess mmc_power_off() will call mmc_delay_us()? In that case,
> mmc_delay_us() could just return immediately if the delay is 0?

Ok, will do that. Thanks. Will send out v3.

~ Judith

> 
> Kind regards
> Uffe

