Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2276430C163
	for <linux-mmc@vger.kernel.org>; Mon,  6 Jul 2026 07:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783323634; cv=fail; b=B3kCJImRy5jBUQPu2Ey11heaMpGQgc6ELqDruel+XiRX7FKGBda3VV9FGonG7SBV8vyFk6MJiWuuCS5atqEoVCKrsC7TDQdU0vTqXS5jAQlnS0nN/chvMWohnow3QtwqmTDKi1mTtUgXhpw4sXvqh5Pa9z4mKYMxe9S+Hy3uO2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783323634; c=relaxed/simple;
	bh=mP/t4JrjSNt+MD7n8s6RhRbAjXfDqS3W/Muz7Upj/ik=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HdmQaKUP/ttcC9gU4+OgVc8KR5TedEShlWeYutI3msGak2WUvH0R8zJNHHeIFbwhRWMaAzpE7iEpItpyEaHSsTkyE9GhKunxUUvRHkeVHGkpi3zNA7BWZYZer+cXB1Vc861uglIP66R0DwdnBnzsNCf3KAM78vGBskYjBLoIuY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FUlTc7WG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SdBxxjgg; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FUlTc7WG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SdBxxjgg"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6660F1Dd1374527;
	Mon, 6 Jul 2026 07:40:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=Ctny0IUJjcHBajVJ
	aaMO3e6micQFN2PV/CDz3cfAvMk=; b=FUlTc7WGRwq45x5SOCr+5gwsIcZo56fJ
	yjabDkrQdZXqHli5Hei+oUqK6PD4/FIceXab8LY3vk9YTPtvA7NGfjvqPT2ttB0E
	2blasjtC1Zsl073u0Gqy/Fohl9//JFCwBYK/78wPU6AJ3PTv1jdS1v5I2MCGOHRR
	19IyNFyeOVRumtL9IYPhAkIvKmjuaqYBsjuo2ENOOr9HwvmVdlVy3GwMTn01c3vN
	u5iDTNGYljULKLNmhh+dc/R4JWdO+dVQ27pGbfp8NhPENu/KaFN49Wz4h8jpar+W
	pw0smGtDmPEUDXNVlUH6Y+PjrSuxD1ZVodGz0GgYZ/RdQ/IjYsRyUA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4f6s3935t5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 Jul 2026 07:40:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 6667dHE0031299;
	Mon, 6 Jul 2026 07:40:12 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011031.outbound.protection.outlook.com [52.101.62.31])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4f6rmnujbp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 Jul 2026 07:40:11 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sxwQ6gLQQprmljywLgBOqFQsGlr5OBjgRyZ7/CkcUGYE6xmjdBjbg9KdBDTKi8AWDHQDI/wlzq1tXqVty9UlzBRbi6CfUxZGLLVU7Kywdwxer3AXO8k65taobEiJqijqvAW0o7eKQ7tleclbepnOaiG12TJRXSuUKvZgg9wKaJ2lgKMYmzZnNpbVvpJq1aX935W/sGjNdzXJxK85S9aWRmxr/hddggV9dtiIg+7Hr+7yrwl6d6Yxl3/vLHfk91fQM8/oJzjGkCeWuIqnAsxmsI02/C7O2lYo4abbJyq26Yhm12+pArJMuFF7MSZaV8SL6Xjh4lJwjaW/wJUtUxbEVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ctny0IUJjcHBajVJaaMO3e6micQFN2PV/CDz3cfAvMk=;
 b=FNPFUGFve3Mptw7e1jYXLBdsYejvYKAW8OJEJHHzBGfzuM8S4EiJIQkEqqMjd3xYfHEuTZgFOUtgwmu4GaVl0MXm0N4D3T/vRNlC5/8sbGzQKnuGdC+oLaYIk2sgzTQkRmVAs+b+9IGef8of1kWlpNnrzvPraHYgdMqjVl5ScFywx2RMpg1WkSw9KysBhwQYLv52x+TX0uH7aeu7tqWSfE8oSgohimeNRopDdRevzPQciPIYTZfw6NSGEGPvkCU2MbD0j2LfGrHPUoRxf9HtKAzZ9Ghdg8vsOjsSvSOESHZ+GhmpRhVqPVN8Gs5sz94LX8CHiH49KLEeGW3D0srwsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ctny0IUJjcHBajVJaaMO3e6micQFN2PV/CDz3cfAvMk=;
 b=SdBxxjggMM/rWlKLrG1CQyYT5pFKvy75NqOzT3U/ea0rcQGzQ3bIUQmGwdpw8mCQGQNMZMyktBi0u6P0kpIXncVxitd/QEKV8DVw4IEOPfpLrXGcw6A4WJPiK8YZ9gwwYIwEjfe2Z014Jv9e/Rfv00EcTsPLqTinWSmoSRQcz58=
Received: from DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12) by
 BN0PR10MB5031.namprd10.prod.outlook.com (2603:10b6:408:117::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.12; Mon, 6 Jul 2026 07:40:09 +0000
Received: from DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d]) by DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d%6]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 07:40:09 +0000
From: John Garry <john.g.garry@oracle.com>
To: ulfh@kernel.org, florian.fainelli@broadcom.com, rjui@broadcom.com,
        sbranden@broadcom.com
Cc: bcm-kernel-feedback-list@broadcom.com, linux-mmc@vger.kernel.org,
        hch@lst.de, robin.murphy@arm.com, martin.petersen@oracle.com,
        linux-rpi-kernel@lists.infradead.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH] mmc: bcm2835: DMA mapping improvements
Date: Mon,  6 Jul 2026 07:39:13 +0000
Message-ID: <20260706073913.538598-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS1PR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:8:23f::13) To DM4PR10MB6229.namprd10.prod.outlook.com
 (2603:10b6:8:8c::12)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6229:EE_|BN0PR10MB5031:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bd4c81b-aae2-4c8b-42ac-08dedb31cdef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|56012099006|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	/HxlTMTU2wnutNv7rNVHUMyoaJBQtf55kQAFa/h9a7nIps8WqomnvBi11LHTC2N6JlG4cWUkKLAR8427ibWcMxB7Qrxs3vl4AYwlKpi1xwXPnNW5+Wkas0aM5ib8rao8QOsXNR1EgPkDrd4SHC6+MRuaqgX5n1zjXmlK+nFD7nfQxiyBcvVELUloNYvi0J0N4zQHvNuOpur1t3UxI2Vdha7rUsc1VUDq81LFDZ3RxZxAUq7pk74onnvfT/4lMizATABGPxE0M9dgr0i4HQcEp56w4ko9k2/+S2Erz21TaiLkpdh663KRPxPnLrfLnNOCu352Q82SYwxIMgfGwRDmGrCgaq/S6Io/AOX5OfXDkimJx4fJVeeTP3OjCl7vgUv5Ah9RBEKYjBvEtMexOxLLc8JcntMpVNAi8isl0w31xfJvn1j8ObrXqxVrSbCnOeNjYIYgRdBgJRoAPLuLHZnleOoutFxKE0qVebrThTY6xcDpJld0RzIKZYZowLJozKcUSujzSfsZvSPclqmbiC0IbILXZPuSqDhCNJGUf3817HVLWP6L32yXHs4bp2Z9YsBi2AuvJF6jfyL4WQnhMUJ0UTsXlpiIXPgZzERiXCeRadQKWFPCoyZF2APbvYO6glGqvHlFDj1E7o/+CDzEafHGlEoySnX2+NdtvtjC8MGt1sk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(56012099006)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?spDPXTwlkelqmVx7X64z1n+7SuNVtiI/cC0ZBqCv8dxO3vR+qUhrH7fuR+Wv?=
 =?us-ascii?Q?NRXJ5AJMQfZKW39DqIa74h3VvhU8DEcO24vjuF1qXmeyWTKGwlLp287EZrKw?=
 =?us-ascii?Q?kESEQ/4lRxNUpn9BaNUQYn7sq0zTDdjSfWR85o3tM5Sa1c8EDvI0nIQiH3We?=
 =?us-ascii?Q?+EE51Rrwdf4tfQUaRRW6FtV3ifSn01PdA5sqcyp4FIGikepx+tjG+3FZIZY7?=
 =?us-ascii?Q?vOqVHRJlxLLlGjs2CaczqY3ObvjcPifYXZ/T+D9OGYLxvKq9FGzN0ctU1kBc?=
 =?us-ascii?Q?ZG85y3nREszxLL4Z1AcRzcp1x6aCICEL/MDwiR7FFuXTtP6HClPHzh2zi6dh?=
 =?us-ascii?Q?XVEObpw1adnR6jQAXu/EjXGTRyUqI54DSFmYrn9RBAxKXxQUCS7BtsmYVmni?=
 =?us-ascii?Q?t9DA4JqHDVx7S2Tl6GRllbp5oYdPiDWKddk1O5xJSvmaVof4bWIIrfe6m4U8?=
 =?us-ascii?Q?Ot6HCXLqVYTPUOBZadz5xlQYsxIVITASevir53MvRO47hBjU5D16rOPfBfaW?=
 =?us-ascii?Q?oGxetmxQVbIOpJJfNCmVY9wPJruqcXvi31iOmiPB2pufA1SWkGvWgggF9O8Y?=
 =?us-ascii?Q?QdzyZE6nZfbIpGnAJh54rjLyxp69dO3s62Mvu1bYRWHvGDYxukKvaRMpNGW9?=
 =?us-ascii?Q?P8XH/FkcPJ8uBINLkBwzhyvRBgfHeRGAJGmu8jGN/sOyQWEUbkA4OSj7w4Wk?=
 =?us-ascii?Q?3gIxlaLUAo7emOIsEkXaQDZg6Znoad9jenMeRo9vmEBsO9urRoyPnxHKqXik?=
 =?us-ascii?Q?3FN8z/wVZSvO7ec8MEeFABhiWiZzgcseYT2qdCTD6R8PFHKoGaTJI2HEsWHU?=
 =?us-ascii?Q?PYWXNwajQXONGmXkjSFhl39DNkzRy35PRk/JqmafX594IJEIbAMcPjqdnQt2?=
 =?us-ascii?Q?RWTiO2KFsHsMpAnmtVo12iRkvfXqFbXUlh1jDbiEqnw5S/datYdSrKtBO+FT?=
 =?us-ascii?Q?cC7qT/zlZwGaQr6pX9dq8iNjqK2CD5yfGqjrNCfcfptSez+HLL2nhf6PfXBJ?=
 =?us-ascii?Q?Q+D+6D1RD+CvQlQz2x6o/3+9WmLWti/l83SSNk9XDbI7McNtL0oiCBMjpRys?=
 =?us-ascii?Q?NVabHkcyMy97TPMmTYg44fR6+fq4Y8khythPnzfoMlKygY/zbqWDvtTOUOvT?=
 =?us-ascii?Q?qLsqFFGW7adhDzLw4JggB9xhdXiFYejZmriIq6S/r4IhPiB/4Ttnnj3PLAFa?=
 =?us-ascii?Q?QZX3okuQtsa8Y8dDiMZTT9ubnrui27gnW/LCQ7ynVu2LOQCiF9ioAXNgyZkr?=
 =?us-ascii?Q?wNms9opOgb5F//5+CU3gZt0jQlWIi2e5sSHiMKAsDSkBiHExDlWHyq5vrgGM?=
 =?us-ascii?Q?FeozAV+NpEjoLm++NHiR3ua9nXTl38cJT9KSUIcSgLT09xiRJ7bIN7/4C7+P?=
 =?us-ascii?Q?Y4bR/pCXulX6NclRSqDEyMRDb/NzD8ahKv9AN9tcDoHKHeVtlfmXpuNneBOi?=
 =?us-ascii?Q?wuiH6MKV+LYjSkkTqJRh3HVL8LtzHxvhDBvEL8RQ0C27IDzWrQrLihn9pIqk?=
 =?us-ascii?Q?wqhNqaivx2rZeQJgl0BxBtllRHYttBgJrerZk399h7GHYoR2QLF8MWV3xBEN?=
 =?us-ascii?Q?MV5meVVm9x56LvZ1b/eGbpRVNLZxH6LuWjVLxev3XMjHZOpoS17C13FPfVEA?=
 =?us-ascii?Q?lmXtQumKnGgkjML11z+XWdGznkRdU1t0eSrCSgsgepLljLQ3lfBUEi6blBI6?=
 =?us-ascii?Q?wQWOjQ0gEe2ID+vJohvdDyC8XlIecpGogCNeSAyCNOgZgEa06RvvtqmmZBgy?=
 =?us-ascii?Q?FF1mNv9hOQ=3D=3D?=
X-Exchange-RoutingPolicyChecked:
	sPp3AO/laFbRWm+j7zRujOv02jfTYJHqeASNWd7F1V/DIkRABJKxW3BxrnqCjMxe/wcZqd4aqsbbgpBnnGyD/vAx8ZARH7k+7OZcnpb/QB/A09hFnTI3nB7UCIyePX/roQyk/L2Do+GpPYvmXTUV0qj4ItYE+Ael16ruGfH6Xi4d+sEketyofQEaoIPR3Fw9iJz1HS0UnJMNuwhq5P0XzeO+pLSus+N6ieZ9lGhWl86JGeBZKfo/IlJejhil8AxGlWvviRKLYzSQqrwBwLAxZ0HBUqBrRVj5eEXS2amsKkSHlEMMXMmOUhqr2y+qRabRuZl0joBkLT0csuGo8Zc5fQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bU1dqiAFyRhrfBZ+TDo3e9usE5Umf4WGAkM3Oh1lPb8J/IxxulI4jeCXPyGrVvk9COoxZBdSBNXOKxS20Ac38dZRN1BuCuYfVooknKdofE9DqixvaPqIIhTaE4UU+BQs7Ou79Cj/fGMt9yy+mb54qeaY9ZCSeslw4DIExtX/zdT9NsFX3dKbegVZas6psfNDE7me7qmKEb5Su19xnWpjMia41xNzYk1ddkvbgtWFAVqSLiVl8eyjYO9IPwe7N34ylpDGnHTPGwPE6OAeORoAcQcPrXj0uTJNHtK4dCSPtN1fnWTiJEDWxLEY155hgg8J2D4Bd8upUreQlQEZO45j843zMznRenb5y5pSgh8MXXxf6IAm/OaCi1Dm370wafUZGEWLdL+4du2om5MR22QVTKITSDaBHZqfPIm1VBoIKyrW0nx92tL9CGpW1qWVgNjF88rndzBecQqYFxmooa84Yek9HviYAJxanT8xL4TfIzaJcVMKMTV6eeMVhXQO5zrH1+4hRDwuBEZoxtyriMXn51lCoTWIZMgcm5pFED7C49JkOMO1xXW9922vOgUmWI/ebaTwd72ZrStOuPdNFemvqR+izUP/T2QeaoZzDcdup4w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bd4c81b-aae2-4c8b-42ac-08dedb31cdef
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 07:40:08.9618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W+hLLhwNZoPbMX21PgRju10cpsNA/20GcfoetsuHNVJZIXMNwXnp17fvQfPxs7azKx+ZE60HzfTvYYj1ukK0CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5031
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607060075
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA3NSBTYWx0ZWRfXyIrlRop1Y9BT
 R8pE3gp6WNVT5ajxemqsaZyBCRnrWtYbU5pr0qn/sLPaKwfCSTCDoFMdGMrI2qELTP6GnmpptiA
 jYWZe1CZ6qsmIVVJevPtA384WLPAR6mHWA8qG4VUHXb46/rlJ506Eo581Xp18LOpWAJzEX1Uptc
 vh82FwcMZ9BDfzKdnozuwV7dRBRb3ULujJJbzF5x267GERcJALyNUJA4Tz91xtVn22g0WB9TkTq
 Ff9Yy76AHB9ypX+n1qupLC5q/SxFlGCrncPJFY84O2Wygq2Dzt6sAT+ts8drXMyKrwCYPHIlfNW
 rsdLmU53NQYMrDjbKm1gJRjO2FNhtcqu0lcq4PIk3Nu5NgbcquGjnY5qjxe84KrFKRlda+P4Ix2
 f1L3jxcdEneZwhFQPrkeEMuLNw2NPJnJGvBLfQV8xFb+5bFt1gAjpITUy3IuqsQm95XOAoh1I92
 FaaCSPp1K76fIryFBH+/El8Lzp+m4ZSmWrxxrc+w=
X-Proofpoint-ORIG-GUID: pogu-fGM7OuZc7z-BkPBBvU5YOj37cSm
X-Proofpoint-GUID: pogu-fGM7OuZc7z-BkPBBvU5YOj37cSm
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA3NSBTYWx0ZWRfX7aWpaXzUY+Oj
 xp4V4K86tebVR8gvZc2b8wAh9nQ5alB52FkSwHiMj29enyPDIFbZwXHCJB456Bw5izQLvrmYzHG
 am/ifqWyISQKUcywcqOrPDvNNvEcZAzaSYBYGleEsvepB3jbdXqu
X-Authority-Analysis: v=2.4 cv=RI2D2Yi+ c=1 sm=1 tr=0 ts=6a4b5bdd b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=2dRszUwhYKu9pWU8-Q0A:9 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:12221

As pointed out by sashiko bot in [0], recent proposed changes to
dma_max_mapping_size() may affect the driver.

While the issue reported may be a false positive, Robin pointed out some
other DMA-related issues in the driver which are addressed here:
- the DMA max mapping size is irrelevant for the programmed IO mode of
  operation
- we should not call dma_max_mapping_size() on the MMC host platform
  device, but rather the DMA engine device

In addition, it's better to use the device returned from
dmaengine_get_dma_device() for dma_umap_sg() and dma_unmap_sg(), and not
reference the DMA channel device directly.

[0] https://lore.kernel.org/linux-scsi/d82926fe-4557-401d-ae58-4302fef5657c@oracle.com/#t

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
Compile tested only. And I doubt that this change needs to be merged
prior to [0], above.

diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
index ee63835b3ca0a..a13bb39e53066 100644
--- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -188,7 +188,7 @@ struct bcm2835_host {
 	u32			drain_words;
 	struct page		*drain_page;
 	u32			drain_offset;
-	bool			use_dma;
+	struct device		*dma_dev;
 };
 
 static void bcm2835_dumpcmd(struct bcm2835_host *host, struct mmc_command *cmd,
@@ -494,8 +494,7 @@ void bcm2835_prepare_dma(struct bcm2835_host *host, struct mmc_data *data)
 				     &host->dma_cfg_rx :
 				     &host->dma_cfg_tx);
 
-	sg_len = dma_map_sg(dma_chan->device->dev, data->sg, data->sg_len,
-			    dir_data);
+	sg_len = dma_map_sg(host->dma_dev, data->sg, data->sg_len, dir_data);
 	if (!sg_len)
 		return;
 
@@ -503,8 +502,7 @@ void bcm2835_prepare_dma(struct bcm2835_host *host, struct mmc_data *data)
 				       DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 
 	if (!desc) {
-		dma_unmap_sg(dma_chan->device->dev, data->sg, data->sg_len,
-			     dir_data);
+		dma_unmap_sg(host->dma_dev, data->sg, data->sg_len, dir_data);
 		return;
 	}
 
@@ -1201,7 +1199,7 @@ static void bcm2835_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		return;
 	}
 
-	if (host->use_dma && mrq->data && (mrq->data->blocks > PIO_THRESHOLD))
+	if (host->dma_dev && mrq->data && (mrq->data->blocks > PIO_THRESHOLD))
 		bcm2835_prepare_dma(host, mrq->data);
 
 	host->use_sbc = !!mrq->sbc && host->mrq->data &&
@@ -1281,10 +1279,8 @@ static int bcm2835_add_host(struct bcm2835_host *host)
 
 	if (!host->dma_chan_rxtx) {
 		dev_warn(dev, "unable to initialise DMA channel. Falling back to PIO\n");
-		host->use_dma = false;
+		host->dma_dev = NULL;
 	} else {
-		host->use_dma = true;
-
 		host->dma_cfg_tx.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 		host->dma_cfg_tx.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 		host->dma_cfg_tx.direction = DMA_MEM_TO_DEV;
@@ -1300,12 +1296,18 @@ static int bcm2835_add_host(struct bcm2835_host *host)
 		if (dmaengine_slave_config(host->dma_chan_rxtx,
 					   &host->dma_cfg_tx) != 0 ||
 		    dmaengine_slave_config(host->dma_chan_rxtx,
-					   &host->dma_cfg_rx) != 0)
-			host->use_dma = false;
+					   &host->dma_cfg_rx) != 0) {
+			host->dma_dev =
+				dmaengine_get_dma_device(host->dma_chan_rxtx);
+		}
 	}
 
 	mmc->max_segs = 128;
-	mmc->max_req_size = min_t(size_t, 524288, dma_max_mapping_size(dev));
+	mmc->max_req_size = 524288;
+	if (host->dma_dev) {
+		mmc->max_req_size = min_t(size_t, mmc->max_req_size,
+				dma_max_mapping_size(host->dma_dev));
+	}
 	mmc->max_seg_size = mmc->max_req_size;
 	mmc->max_blk_size = 1024;
 	mmc->max_blk_count =  65535;
@@ -1336,10 +1338,10 @@ static int bcm2835_add_host(struct bcm2835_host *host)
 	}
 
 	pio_limit_string[0] = '\0';
-	if (host->use_dma && (PIO_THRESHOLD > 0))
+	if (host->dma_dev && (PIO_THRESHOLD > 0))
 		sprintf(pio_limit_string, " (>%d)", PIO_THRESHOLD);
 	dev_info(dev, "loaded - DMA %s%s\n",
-		 host->use_dma ? "enabled" : "disabled", pio_limit_string);
+		 host->dma_dev ? "enabled" : "disabled", pio_limit_string);
 
 	return 0;
 }
-- 
2.43.7

