Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8181754B;
	Tue,  8 Jul 2025 18:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751999885; cv=fail; b=cDiyG22B0R7qPRplAnz6BLKrk19ppkjut0vxFT7eBnTtxnYT1UC4qdsmszXn73QHmasaWFrADghzwKbB5xptHqrZ+AIrUSxIRxXl/dmE6U7QyuOBVNHrbd39of3KiYK+ABL1o2Qx+xKT9y2S9Gryp7pttpsls+fsT5idccARoN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751999885; c=relaxed/simple;
	bh=pGhuuruOJK+nRH0K3Qgg1UtJQKFCDXewC/bZuFlDF50=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=CliQxw3RaeBUMXlxj5FMIRS0AUq6ltNWQR7Y7RLyz5T7Gj6OTXL9FrMvAHnrJPtUkDO1vXXbDO6JRziaiFQKKP3FOIDtcsMNt+HYaXw9xMV1tE7EI9CO8SbViNtnVJ5ZkwTN4fmDOUXK5961tehJ+kvUK2IppfSVN14ljaVled0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oKSjdycS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hTq+/r+h; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oKSjdycS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hTq+/r+h"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568I7OJl009831;
	Tue, 8 Jul 2025 18:37:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=nRaAccY2cdwyP5hi
	L5AYiXtERzA1hoAd0x6gvTjDMCk=; b=oKSjdycS1fuYI5iVZy6OKFaq7kXQmNje
	baJo+ZAWm5KltULRTVHqxjr0lT//wSFn00so5TqwKpkwQ92tca/Su45UxPcUETf/
	/GsPjSg5VzuO3yIn1VM2yQKiFTRNaqWHhVSGQfSWWXY8pA7QnytHQaitEMIfsh2C
	t2yP/7LaYRZL0C4nVC4x/O9hM1WkgD56jf6Nup2vrbMpg9lN5AWtapia6N6tT5wi
	4wQTSr+LK0e6fi+GCTyIAhUZvDr1UwJKk+9DA3NevS/0t/F1+2R8Cba/xkEfDMJ7
	Sf5imhDqebfABFapj000NCg2YqlOiUbh91neMCtXPnzNgcKTYuRUAg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47s8aw028j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Jul 2025 18:37:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 568IH35i040586;
	Tue, 8 Jul 2025 18:37:57 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptga7tws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Jul 2025 18:37:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UznyZuY02JuUpcHj3MOjxhnG5gDgSKMLIwryVu5FhR/E9m1TBT6lTERYezi9Wv6NEfjbVr5+qYmNTTSqwleI50mjsw+vg36fPz5q4h92FzsLeWQVe6h7X4o43/LYQQZOs5+RxmtDckJTVm/O3gjT5rxllwxpxZ9mFIYQ9K/YcdrcOt0nezHwWFKrl+Cs/PmxW+A2LnjBhTwmdH7cgG3pcoqCH9Yk+F5Vz5yb2xc8GXnCh11ZfYlZvryMUL5lkuHJB4kVCBiuGntyOcSiSNOzzBpBxcgyqwjyYHUAcH7rIWPVnjDBY5HV6Eks/cZjH2N2lFRfzDVSY1b5TrU0tDO6WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nRaAccY2cdwyP5hiL5AYiXtERzA1hoAd0x6gvTjDMCk=;
 b=a/86OYknz6Pb/YwDe1rAQMOYDuuU8DKEZZ3a38kEP+xvtSAja2gFjgbScNCgFI3P5TOFNdF05aZKPHBov39dvVvB5q9tlUjY3hKC0o5dZsghdpflJ8Boea6U0f/p9XEkb0QOla/qXcJ2QTzJLadlnkUAXgVXRJjuhyFiLKQJUP3Xnn769FbzpHG+p1BciP8ugUBHl7L1k0IolGOcCO4a1vfAuAs3XZ4V6lCtgTnULJCUO9bF/5/UDNF31mYr4ddWMLDkhnK97tQZsJGGEkH8BwoV8rPDLP4kT2dXR0TeHQ4a/JM5bSjsls4evhDUMf4hJTssAA6OExuL7aQ5pij7rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nRaAccY2cdwyP5hiL5AYiXtERzA1hoAd0x6gvTjDMCk=;
 b=hTq+/r+hUTcvjbQESce0LLUiGDri5dylUb7fyD1p7mRYGsWrn/8EFWXduvGaTRPvG6TdRe2WjgfiysRLtG6q9yJ0Qpxx0XE4vDcrjMk1nI8siQz1TW9c+86S18T1iXlJKZI5d0uk6A4/Ml1bNfuVVoy9Kz+NthudRlZOw9k2Zqc=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA0PR10MB7665.namprd10.prod.outlook.com (2603:10b6:208:484::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.34; Tue, 8 Jul
 2025 18:37:54 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 18:37:54 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Uladzislau Rezki <urezki@gmail.com>, rust-for-linux@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: add mm folks as reviewers to rust alloc
Date: Tue,  8 Jul 2025 19:37:47 +0100
Message-ID: <20250708183747.104286-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P265CA0010.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::7) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA0PR10MB7665:EE_
X-MS-Office365-Filtering-Correlation-Id: 9032e748-cf51-4430-24dc-08ddbe4e8d8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UVW4JG+YchddPIeIGoEtAf3Wh1z4T38wjcqDebjiJ/Q1YnPJgpKsqat2bE6n?=
 =?us-ascii?Q?Hsdj5o+I4d7g3kmBqv0QkmoBEVhpik17gA3mCdS0RIUlIlDe1S0PlbOnk8ru?=
 =?us-ascii?Q?oar6uyfsxxRvalqkVfDD5BYnf6fyl3ZSCpLdM4wBHJUpjo+LkSJMzfE0Hj+g?=
 =?us-ascii?Q?jTx3U8GNoG3ndZ9Q4wE8lzzex+w+ll2sqabisDBczIT/uezaQsecscy49V0X?=
 =?us-ascii?Q?B372+CJzz+t4y19Q2xfPdNCwPIX2OKMBrx3Yfeyz0zgbwZlm8vmglRwlGszM?=
 =?us-ascii?Q?zgPuOPWonbc8fh419Fe4WElLB3EixQFDDYw/s7FKXJ22UpzwYtnJX0ZQZk9p?=
 =?us-ascii?Q?gPlhuQ2va8036K82Vovca94uPjJ9llv8wAws/PyVkYLyQlye2h6GKo+PLoxo?=
 =?us-ascii?Q?RcXCmdZgP3PRUV5Mo25GK59viIAV1AjzVzq30nAE1xfMcDYXzJNzyrZhdglA?=
 =?us-ascii?Q?H+el/sEcfQdDAUKAIEHvjN+mrUWE4NvY5LJXD18nsD0sf6tAXN3ijRYFkMYq?=
 =?us-ascii?Q?/HXxhcwIAaE+zX8wMH9jCDZu7wEWKkl9bnuuc0K3Id+znyVorNjNd1hzHTRm?=
 =?us-ascii?Q?mVvE+1PJZ4CEnl5XTsXr3CS+rNhiOxGepDEC0T4Z4I2Vneavkks/9hik6PPX?=
 =?us-ascii?Q?z2DA0KD9JEWe5et+qUlINxrLgaziJX1fXSS5S+7K7wMDqd1k2UmoGvNdWNF/?=
 =?us-ascii?Q?S+Q7uLquLQD+nm4I1tTA24TSRJ3Q9pRIkiFe6ptrxQoq+b9rzcXr8/5umxoZ?=
 =?us-ascii?Q?TJdpIeTnHRx4i+BHhDckTVv20cbBoRFFrX7z37ZhBt9OZV+5ojWRH5J0IQa1?=
 =?us-ascii?Q?0vS7xHledk34aMNi69Ia/v/UMYcce4SsZm+0XFgWrTuOvbAzQCOu4leq+TIL?=
 =?us-ascii?Q?mZ2wrtS/sBEO+EPn0DwPlP9lZj6TliYbbiy/6OcqorCWWpGoJHhVm4XO9pSq?=
 =?us-ascii?Q?qmuqAOJFalg2K/hZl8wTQpZWtczR+qVPwLTRTDwjA4N1ecKRlYOlqL7pl0/L?=
 =?us-ascii?Q?YxEPhJObGb4FtCva1CJE/WPKcx2jVflk/aPIYHdcnpG3e/Uzoq+QmGohGi6W?=
 =?us-ascii?Q?RC8eaReQCVWjsntzrAk1RobUYWUOcGEKsK8Zxpx+Y1Dd2fT10FecSdsMhUbE?=
 =?us-ascii?Q?YHyIPKO3iMMpuvm7zqCa0710nyWTyye4BX8nXQ5xpsOSU+t1xryRL3xad/rh?=
 =?us-ascii?Q?m6AMspgMiKhcSbSOAwHXGt6uEraP0ZxVEaxOMdAd1Yjjlb11Xh/dSJlyPWbU?=
 =?us-ascii?Q?MPVy0AyAMtkwU21EtLMbykJzJz7Ufwj25Kpsarhc/4x+dj6LzaA72xF4mm/l?=
 =?us-ascii?Q?f8nlZXwv+BWxMDa0wS2UVNjoqZSb6iLEhl0OCEcicKYs5SMhkXc9V+8hjh7B?=
 =?us-ascii?Q?U6XUU7/lvk71/ZuBW8OuvKe5QH+ng2k8ThpsHa0TxUSOOrflCAE97Z25zi20?=
 =?us-ascii?Q?Z5tgp6OytD8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CZzfpCIv4UZfTS+Vh/Utf/iEkFaRhWAJNGTB2QR9V82GKBznyYhrif8yaVd4?=
 =?us-ascii?Q?W6uquYrHWhJpLoiI9iDpeZfkIubUoRSN6B3ydky/KyziN7Y/yYpTK1NGu9X3?=
 =?us-ascii?Q?eN8Vt8NhMXAT8xqcF1DDKy0DURQODG/80CrWiuoMXHO13rHTY8Y5tuGKMF0E?=
 =?us-ascii?Q?PGip6rrPwg1/rV+c4rv7r0v09Y+lpyuav48llc26Q2wVoVI3/04GK9wJ85Nj?=
 =?us-ascii?Q?Zl/3wmDLCW/V6j0mzeqSo5iztfRtKtmFqWHXajgESHk1AxN7mkZMxPSuqTaI?=
 =?us-ascii?Q?l5EKUTdmJQ2v2vB7zoom4Zzm8tQENchxlZGU8BN1f73hFy+vyxudMaG6e3v+?=
 =?us-ascii?Q?lABFnq/1f0nPbHnm1hq9D0UDe/y5GSbNYvgHqutJKUAruLWMmKKerYN6+Xuq?=
 =?us-ascii?Q?jaoC1o5BtpbXOdLmHuKRFPdvWKgDT0VP6gt2EOExOCh+Pe54mMtn+LeE9ovH?=
 =?us-ascii?Q?Ml/jNv3fKnTAclRk2b4v+PVoZZtTsHmHheX6NXzXMqvbcVYSOCkv1kLtFw6Q?=
 =?us-ascii?Q?9KJzs10AI6Y2WFy2OU1sVNzSn+QDRPO3KsQuBnbTtsRZ7Ppv8miELMUiVh0d?=
 =?us-ascii?Q?gswtg0r1D+x3Z9V8ekDJV4kKGW4Vgl8odORIqm7oq/FzbYVaickXwOiYgsI/?=
 =?us-ascii?Q?RJOBB7+0AbyA+C8VN8wyaOqFxO9cUVU3qNd0Kq4Rf3pdYCrlGveYxUOQsmDB?=
 =?us-ascii?Q?3Indi4IhiUrRq51PyVlXSQSHm4Wdo07TYhkKuZ8NYruKLBxoPgxRNLmlkrKd?=
 =?us-ascii?Q?n0JLXSU1iv5gtbawM7gObFAPmsgY1ICSdUGLdBz2dWYGf80tEaChQ4+7C5sA?=
 =?us-ascii?Q?NnTbL/NCNzursiO+jT0t5EuuNfgkPv3CWd/NeRj/N/+IG7JzZ1bfO7U95zVW?=
 =?us-ascii?Q?8FGyszQW9Rw6Wv9En5hEqKSm1U2v4Os+cFBWGMCP2/NKKAYKqKlyOBbW5gaX?=
 =?us-ascii?Q?DJIOhvwNi0KNciDibJp7+NP9+TETFz4+zllR9IoITwTExmRuYN3sznjr7/z/?=
 =?us-ascii?Q?ESJP2cJMxEwZmusC651U/wrfEwTUCnxEXbM3G/7Wkt0j9ow7XVvU6JDapIOF?=
 =?us-ascii?Q?cU+lllFQOghvaYSjfhdHJmsLaxptdlAcs4JkcyswUD6+4LEQKR1yNHltojlF?=
 =?us-ascii?Q?kYQc6dPTlp+n306Z4ucpnKYPyfx6LToSwaLSw5W+TX74HHpPevwZkYrWnm0y?=
 =?us-ascii?Q?Y1yxgaT/Zbhw48jStyYq84qaEzVzMaTR73S0hycxY/AOka1BPUBQCx/qVMIg?=
 =?us-ascii?Q?JE/hY+1Asee1cnEXvTZCp8K3G20JT+sByI9sEHh8cmS/QpBNryS53Zp6fvXT?=
 =?us-ascii?Q?LKJMKUpbVxowMBbGasTtsX0RmdIjRG5ZVlKhfB6TrhV8EnnisdfVRLI5j6qy?=
 =?us-ascii?Q?+SWkEOvrLjR3otBpaBwqIIZDSJfLcCeJu9QcIfEN6K2FBGiu/OQ47KJIPlYj?=
 =?us-ascii?Q?0Nz5zOhrRPc5CU77DmIqhEuAwZLK/5LI/uEKLo12qRoa4BrrXCREbmvpsQjw?=
 =?us-ascii?Q?xgO74dWYO8azaFxNTZIzHyQBlIDeF0QTS2FWu7jHMI3fLtcQ5QYBiVeC5PIq?=
 =?us-ascii?Q?rh/JyLmWn5iNsxZE73yOxhSzMAlBr+knglRWya4y29MRTm8328TWESz6TVmT?=
 =?us-ascii?Q?UA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8YKvjkuPPLmZEIRzY/RQJTvTMN7IIo2QdvVqDSFAk7zxJ3w76hvdL/kDY9YFMiQTPdTv/FdTsYxwDNN/BZzhU+HJQhuonWT51j3rLd7n4YJYXrhXYPz3NC8KNrI03l63aklG6ZQToJlbBzKOADw0Ee5MbdCFeLxH0mplX6qYjtl5rLcwzFuF7NkuI2trEAE9u0pE4GTAaIPh7Iry+porHlvxoQOMx3B0zXvL+79CmXef7DdOBeuD1qum3U/6fgFN54pZaF96tATtk6XWdpz/x/0WyLo/sDethrvUJ5YQnihPev9nx3a8S3CAc9P+rlVMuXhVfxId4i9FCtYGAaVdmAOyAoD8UxDHdpB+xhGWdMmOTff4xyAXeR9yQHvzCXsxeYT5Ccdi1HSeiIdK0bC3jze1cRSVQLVAhoVcshkFp4LXLgqWc2DeMWUmp+lAnVPsWNiAben5dR3K2MjttG/Lvc0cRvav20COVRfKuQ/Q14fuFGawOdxpA4RkzwIutjCM2EU1GayndjII+jdqXC95/OowCQiEFU5sjuitljJMXEBHa9UWA2LT/Xt5HPwHGCFiNybnfIbIBJFUqwy2kd6bk2NiRPrx8+K7cePA911Owww=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9032e748-cf51-4430-24dc-08ddbe4e8d8c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 18:37:54.8832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ngO1RvBYCSazJK5JhbYYktcXJyh0XywWeNLORu1HOfYy024d7fKICDS29u2J2IKg7DWY422ccH2Txbxg6LKQnCpPzh96YEufhuYPQWGp6LU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7665
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_05,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507080155
X-Authority-Analysis: v=2.4 cv=A8VsP7WG c=1 sm=1 tr=0 ts=686d6586 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=NEAV23lmAAAA:8 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=H_ZvEehTYD-q0aTlugcA:9
X-Proofpoint-ORIG-GUID: Gntd8O0FJqAHQr-MNHkQgQxTjqms6JOG
X-Proofpoint-GUID: Gntd8O0FJqAHQr-MNHkQgQxTjqms6JOG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDE1NSBTYWx0ZWRfX0iyeU+6VN0i3 FCHc2XmcM6Jn7IWOKl0mEeYUAim22OjkR3Dj2AHqXa3BoEf67ENI31YBAQ1bbHkDQ++Og9idDg+ f5KDvI97pfMQX2XHXxZ7js7Ebmxn6/6dGQmLsvvcaXPgk9RzS/Ui0xKnzdhUIZYaaD+ifTcFXdM
 VbQtLoAH1ItMoEdU6v/iX+rrF/wP+BVTi2tHzr9nkfqPdCJ3BlaZRP7iJ5itzlyUdvaBY342ty0 R/5l3PUf8nInSwl9PSTofxfmG8TOFuyvi4aVBJ7szZzV4nHIfQMEvolMlY/lPH3FyIgg5xPSYMl VUxOtfOK1R62FSsB98IksOy5OAAfAcrv2y8SRYqvcnCpCc6ZQUSL9Da6TmFkXy+6qakNwaa9qmd
 k7ClpNe1haoKDCMVVyPvBBM85DInlyKzgeHNItYKVVr8b6ECKnUbkewutBcKUGPdNiMSNn1A

The alloc implementation is a thin wrapper over slab/vmalloc, so to help
out on the mm side of things and to be cc'd on changes, add some mm people
as reviewers.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 MAINTAINERS | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 71599ab6bd56..54dd937160ac 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21751,6 +21751,10 @@ K:	\b(?i:rust)\b
 
 RUST [ALLOC]
 M:	Danilo Krummrich <dakr@kernel.org>
+R:	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
+R:	Vlastimil Babka <vbabka@suse.cz>
+R:	Liam R. Howlett <Liam.Howlett@oracle.com>
+R:	Uladzislau Rezki <urezki@gmail.com>
 L:	rust-for-linux@vger.kernel.org
 S:	Maintained
 T:	git https://github.com/Rust-for-Linux/linux.git alloc-next
-- 
2.50.0

