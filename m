Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CB52EEE89
	for <linux-mmc@vger.kernel.org>; Tue, 14 Jul 2026 08:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784018732; cv=fail; b=MEWQ9d3YSEGHJYxrcPtwCIdPoJzS9yqFWUrbz/NFQaddPpKUwmBh3jLN1720IBnskYhSb4ydzxxSSX9aiNDIpTlAtAqHLnxWWyNTysLFuukBKvJ0vm8SLJY12veiWvRumNQu5HtoUHQeEpzHMJhCLfia45DpwCdazgzwp+AlGAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784018732; c=relaxed/simple;
	bh=+/+yen9NVu1Cx26vwNR5Sp42ON01Q3Uv0POaKmLuo44=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=SkmMPtHgDZIwIuQE4NkEkGk951DxlhIR51TrTVCYaZEeuVDSNrwmhmVLQmvGwMwlqf6lo1iHbiq7Kbn1R3hGQ3nsRcOe15bPf7iIbVz5ZIaYoeAhIURLPU/I2WjaF8NIRrYHaG1qC0xg5MvXIKgDyvXXXKy1MHMUq60/4LMEe7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pvXrB9ZM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gzzOnxRu; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pvXrB9ZM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gzzOnxRu"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DLFGA11377394;
	Tue, 14 Jul 2026 08:45:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=TCPakeBng7AvE4gI
	Pj6rY2lBpfXfXCVFJOmd1ZqMJyw=; b=pvXrB9ZMc2rG0nWsYksC1e5gwfXkBNrd
	drL2AAUdJWAkwl8twrI3RJJ20eV6tUYeiDd7OOynlpnCLkSa9NuSTYlYoQC1eUDS
	K0Q+kCuF6eQeb9cy5xrRl7nymK/rWPXGJYx0Rf9Hnqqf1a/hPNgC2jfoV4spncCL
	tR+WB7Wx/AWoqjiBzmVlVhiE/S/F0U4yIIhFk24aaYZgn9ILtcLk1wRRj61IpWyF
	hgBTfMxLutCFrgY/EkQg0KUmY5cYX9VwnUHoFtXFA4gyAXuyk/Vk3uKJqt1RFaP+
	vGcjzb1NYhs43d8N/hFDatLvZjpO0YeRrih06ftkSRP44b7NR/yBvw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fbed2br91-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 08:45:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66E8h9XI006499;
	Tue, 14 Jul 2026 08:45:10 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013043.outbound.protection.outlook.com [40.93.196.43])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4fbc9depa8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 08:45:10 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pMeqBLEUSTYzXhxHAE8kwLxTCajgN0AN3bewFxWpfOmAownW7IVFreLyfs+N6JlXRCq1yCqApMFus/kphoQRCXm6eYSLUJuploqO1C8Oq/9s4m7ifHIWcf0w6u1zc7kmIwhjK28fNZxvxSojXsHuIky3hC66AH3MRFB66w6jV3C5JTyzMMF7e/XpfKKdMsDCv/NHEvRXlJUlRN1mpLFaQMmabhwZWh/ZU4Recpu+d2NPUhDjLf0HUAgcoCN6N1PCTpVCzWwWH5o+o5cKWR9Nt60c6s5eLxaQhM+Uq1ra12IbySki7YVuWwSefmuw+oiCfBI0qjLTATvs2Kj/5McUmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TCPakeBng7AvE4gIPj6rY2lBpfXfXCVFJOmd1ZqMJyw=;
 b=erD64VVl4DcUxUbpLsuuM9byQCYpbhlcAqo3csec6K9E+q9mv58OF9FU/dObR7tlFyltqEv7W83uK8kuh1+zBsm9bQLA3d6K78eD/zdWz3iU+m423uRI4VZyr6Few7r6IU8JIYDWgOZ/SLzZwnPsLi/uYkz0HpWBZ4Ea8qjybeLx3NLb65o2rD68r/Zn60TEkHp0J+hmI1nN5xe1lKqA6AYowdMralIkSWBge9IlsqBx3+nQZz2Hcch5CMOeuoyTD9H6FX4v42V6ULGt41tp27l6f9JlAUcWxrg3EXuHUQ+dAkx4YLWioHCAcTo/yTFZGo2QMrmUzrZ08Yea9IeCMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TCPakeBng7AvE4gIPj6rY2lBpfXfXCVFJOmd1ZqMJyw=;
 b=gzzOnxRuDMmVYcYNmDsTdN4bZVWTuwskjEF4pkHsW2pDA7/1cA0MyiCIgXFnmFuCceKL2eteLnQRejM+lmIMumjoXOeRM9T8EcaYNjWu0ldkON/kLT8oX67VPhSl4uifY36RbnH4QT9mblIHbu2zAH+/LHJk2dIIuwYmGJ8x/Hs=
Received: from DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12) by
 SA1PR10MB997557.namprd10.prod.outlook.com (2603:10b6:806:4b1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 08:45:08 +0000
Received: from DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d]) by DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d%6]) with mapi id 15.21.0202.018; Tue, 14 Jul 2026
 08:45:07 +0000
From: John Garry <john.g.garry@oracle.com>
To: ulfh@kernel.org, florian.fainelli@broadcom.com, rjui@broadcom.com,
        sbranden@broadcom.com
Cc: bcm-kernel-feedback-list@broadcom.com, linux-mmc@vger.kernel.org,
        hch@lst.de, robin.murphy@arm.com, martin.petersen@oracle.com,
        linux-rpi-kernel@lists.infradead.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2] mmc: bcm2835: DMA mapping improvements
Date: Tue, 14 Jul 2026 08:44:56 +0000
Message-ID: <20260714084456.3356354-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR17CA0034.namprd17.prod.outlook.com
 (2603:10b6:510:323::12) To DM4PR10MB6229.namprd10.prod.outlook.com
 (2603:10b6:8:8c::12)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6229:EE_|SA1PR10MB997557:EE_
X-MS-Office365-Filtering-Correlation-Id: a63211de-e307-442f-534c-08dee18434ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|6133799003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	UuGUGgYlYwudEM9Zopc/wo917OnASLIcoW6bF841jsCarjlPDHbgzUSowne5jYTIrWoY5s55usV4BPyCp7DNrBwUUNep30DdLUCQozr5PR55jO29f/Ao4wPDTTSc3vhZs8WbO89lmQxH5ID7clJ9FoB6TM9Z0VXVzc8pihHbrcMcGnbHjydCFTFmnGXGv9c1d9Gi3OEX66AKY9zNPiuz2rpxwvr1YklSrQmAVG87y7vUqBoe1vC8gNTiu2Y0FKZ03IM7PLQlQZ0bYdsY1T9ralBMh8gG9KQ7sSJuaaARGTNlsxqZ/AjmR08BGSvGpDYWRINvAAoKEHeVE84N4MM0ey+kDngLEOEogKSEntoJupO3+VbEH0l+pVqavozdkHGvK4LEXpcZw16h1T9Gu8qAHFatr+C38KmT+zJRUmYMAlmLCwL9tp7mnsc+4ehI1VsNp8XMT2eyTfEIaUpduldxaTEUTeiVmWdC3QKwUGnOLTGMcjAQEhAy25aGJOwcCW/qbTBdmwnqOh1bp43v1nH/4zCowlEDoPEVgzo8uy8myM5RX/+rbaAT6y98SzzyPVooyVPJkl6Cu2JeNNdJ/GQx8d1uXsf/spK1a7iX/YdgwYNY1WvhfmrOeOVYEBItBOdgxGwX+txLyzN2P7uX7fPJmFeQy1o+JPf2EMz9jJWS24M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H5RGDb8zEVULQgns67JoYvJjgZ/h9z9lpMxgtNc4PKp3knDq/4frG+Kz3bPt?=
 =?us-ascii?Q?GirKyDg9Zik0KAoX7U+sYVqvXV4ssh2jHZXmil5uAX1tkKEWknWVSf6L718+?=
 =?us-ascii?Q?sXTMakbYEtDDtJwyw+aZH8D9LSyv/o14OWsaI9lydHSHUzn3DS6HmQ2umvo8?=
 =?us-ascii?Q?ykzQo5LIigNBRhgC/UYOJsjYX3aWzQkXZVXhtEAJb4uMpCLgu9vTa11lNVGY?=
 =?us-ascii?Q?a5/9cF41kYUOeAEi7IlkoXk2M9elbRYevTuEEkCGV4J6dkol1So/MgaQ5Fpg?=
 =?us-ascii?Q?/uR3ML9sthn81aUvsmtbQr63lEvDLoInIvBs3SB4vgLjKjBxPPPJx4NT4/sS?=
 =?us-ascii?Q?L6P+0KiGLx4080uD0fNa/xEreFJbzMrjn9GhyBdOU+4riaIk7A0DXEg92kdl?=
 =?us-ascii?Q?8tNA1q94YvAQ+4HmoU3TN7gq2RdvUAKLjXizwyDqzPTCBT3sKIVXY+XN8J8f?=
 =?us-ascii?Q?SfUYFM5Pr84MpaZf1umLqbyovQHXfJxjkYRG6FegJk/EnIHD5WZYhAJ1ga9o?=
 =?us-ascii?Q?TFP1gM/7bxyZr6PYFPI9AvK5syeWWjTBEG86jCb4gy8aM5tHrvbeYpoRQwTl?=
 =?us-ascii?Q?5IDU4waZ516dZHzgQhDGbri+lkiYiCRtd30yZv1s4/5OY6u90j5QbuoZ3Aod?=
 =?us-ascii?Q?SoI0ZVXnIFgXNQIvqk/jbElNXzWEzyRpKQRErht6sPymKMJDecwmMq9V34rm?=
 =?us-ascii?Q?HiOnELwxe9m8kVRM9ItV7pj5jkKZ0LxX8LMmiHUrXHhy1xCI0XldSZJxbBUn?=
 =?us-ascii?Q?ZM4wG3Sq6R9j0APXJkmrHymJ59/8nszKHr7oWx5z40o/e+UNUEmN60FV1vb3?=
 =?us-ascii?Q?DOxSsXXkfVzDmLBiIYzJqgsaDSLgA6KPXJDQnEcdmxoMQN5am6hy2oeHahnt?=
 =?us-ascii?Q?iSWyRcfYy3KXrMnqDjD4xAW0fI6ghkMW9yLO9YgLnSsPOxpOMHZpxmSM8LtH?=
 =?us-ascii?Q?RIz7CTM0ITUhbmaFtkh7vX3xUFj+Y9i9bgGBQ/kZAvx+KQiyimQQhyELWQR2?=
 =?us-ascii?Q?oMdcas6zW/0AJod/XjyNOWMbhejzVNeDXetdv4Wz/ag+QEDDLuYMuc+3WcNW?=
 =?us-ascii?Q?eh7vjCaDnkIIMEif9JqyOuM815xnQc9+Q/SgW62MCLT8sknc0zFLI6u2Wc6b?=
 =?us-ascii?Q?VaM4iSlp3k6x1h2+7/lPPDdVeI8hkA5btaKrgJoaS/ZpDgSfpimlAvjHhwTg?=
 =?us-ascii?Q?styBKmFpTRWyYCZE/1g4ILi1foBJWPGG+otSglmw49qaVTp2egaK9JBc7rDs?=
 =?us-ascii?Q?pf/4DrJik1rdY59ODtYSZLcpq2n2tIRFhhUxkfrCDC0r2oCr/2OWWOqCG9dJ?=
 =?us-ascii?Q?y6XgVQ2QHJN80W0vo9MrDFSCIxwaxQ9CI+cGqa2txN8kK/RhU6ovumraVOon?=
 =?us-ascii?Q?PtFwLrGRdhm4lA97gthMHEFgSWkYxRQw8HArGvd/qzKZSNztvyBshw1sW3rO?=
 =?us-ascii?Q?ncHzLMDMFF7GBy3ySk4MKebPfl0XOmdeBO8OzY1v4t/hR87KsNkvb/oqNPHT?=
 =?us-ascii?Q?U+GMMmFHZKU+xHixZsEA2XkrUsDz2ht7O4SiFgr4VV924L2HnZUI2YVbEL6Q?=
 =?us-ascii?Q?q5fpgfMWkgxtyLF9zc0Zsp2iZ5lIWdB+LhxmBQTembLM0s7pq+fl/mle+QGD?=
 =?us-ascii?Q?k13bBPpKajaxkYeWB5jqcKUJgI+cEw/MqaYeF+aflEsGSyH3trImSKo+wE1p?=
 =?us-ascii?Q?51s9lkTZUi5VHPzh+lrhIG60ozan1hyhdXavUKM3Xz2ZGiAshMXDVbG+AB70?=
 =?us-ascii?Q?KL5mfCv+lA=3D=3D?=
X-Exchange-RoutingPolicyChecked:
	P5F/3oLnthDok9xoJwrG0fLnnC8eYhFkfygSaDvtoaM+k5THRkc9cUpp+1NqDU5TX3RuYP06ce736vq9HPmUTLTvRfevHlC6HEtoLQfVr5Brn0HX0V7LhfHYymGBb/HR4rJM86/rJVVlW/cTSkupBX4+v59sjT9WgwQTPSqgU/qTVzXMLoYKMOBTALsaUYQMd/Xba4fZEt33YMUJOILBY6Qgf6mNPZgtfY/sL/ZujyjyO9hitjhjd3LAJ0yQwt/XC5bQJ0MeU7UXKfgtuSSXb6AMFUlqEmmC2gArEX/8u5v3IEW6SOf9usRMY7Z5dchhHHdIBbKoYyjuB+9AdirBdQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	o2wMFuhyvrFTmnc3fnlKULECAr+3RcQwGDoIIo+5dDw2VxNz8lPsYh5mq48Be5Pnz8su2WYcBi/j/q0+u9DRukdx+Q1PCaJXsW5LGkG8mzzwYungfUWB/AVdZFjdTsIx8H2CR0kpsPaBe5P9umeu5w8ab0ojK7WE3ADFQXDkteXQ5nRwQXGbAOgkH6y5IP0+N5j4rNHhML+2v/q1MONqk2qBzFk6GEIynGI9C8TJLE7j05iUBHVKE3ON+4dNmF5hUB7+CwirhXteT/CqZtYN34CVcExsDp+Mdtrp0FUjz4CWU5oXNx5mNBpkdLRsNzwSPp4xL0MsohnobKaD2WhRtLb8d1M4+XFhIDfEi/UrEJ4ZFSuQRa9JazvS2fy2lJiEBgQMxQ3Tx0aab7SUhIE5NjGDxyLK1PQn9jaiwNEi4+HuuTgXEZ55IMdGh2W9inpPwjD7vOTFvsCG+4/HNaA+Zczj7Wshj36Wv2KPDtThqtnR/gAmJsVsbMboLFh127/R7lkNumTRDlFEeouyT/JJl/J0DQseX5oI2XK9GpB3lfb5OSt4PIzddscpJKIwJcwXZ8MwOng36Fy0DS0+4vvD6IwoQHjTLscVM09vFoKVpa8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a63211de-e307-442f-534c-08dee18434ac
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 08:45:07.0589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WrEKX3zeewo9ylklF9M+A8yBw7RoVyQ9jl5+VAIGa/hVhDEExoOK3MQR1K0LZMrV88Z+FMXQkjfLZORYozQ+9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB997557
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=999 bulkscore=0
 spamscore=0 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607140091
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDA5MSBTYWx0ZWRfX/aHmKFZ0QN6j
 eB6v4lk1hLa5uyZJbtudrHrOITT7Eu3vtM1ALb6psCH3eHnOWwO4a3nMuz1vuKnRvkgPVIceTnd
 /YWU4Iken0mWSHupTxsfUwYVntqPDJId5S4XMpIPOJ4n6uHolDoRi8T1sObygQhWh2RNwo2xFNK
 l+HuVNwtgAZLEfJJodbVTuthpsOEcjyB5Eq91xY0+I4HKkSquobJwRg4GJ28ZhYYUXvD+L/98zx
 085QIdzI1VWitJK6U8vhAN8f5v6M7PqCVXEAYbq/HH1SctIxaYyXCcp5jQitiZBMiemO0rb5hKx
 2LVnCcSaf+P6KU0CeQeVFktDSdSUYoyAebl6J2HxJmAFnSxahQj6Tn70T53W8j9Fm7uruqW1cWm
 lB36DlWPM/pMrDJs+Uo2T1ZM8CTxPqTguipgWKPjkrc5OSFfDox2Eq6UDxnmeSwvwx7X9cln/Jo
 d/R0eexUOGOZWLUQqnw==
X-Authority-Analysis: v=2.4 cv=GcknWwXL c=1 sm=1 tr=0 ts=6a55f717 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=CTe3vKi2XHbYApGxVx8A:9 a=WmVTiCyuxqgg3mnwYu6p:22
X-Proofpoint-GUID: ieTXXpYhW1X4NpP7h0cczkRs7FLMgXds
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDA5MSBTYWx0ZWRfXyolCzrrqB96a
 B5LoMBe9LKHHaed47+WmfPZwRfiFYDb9P7R9QbNM15o6iJmnp7UEN/DZ3fQM+9fTNHfDLQcuYsh
 J5dCEQHaxYHqEtO3eCT8mj1x9JHVg7kWeB6VOU2Q98Ag23lGygdu
X-Proofpoint-ORIG-GUID: ieTXXpYhW1X4NpP7h0cczkRs7FLMgXds

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
Compile tested only, so HW testing also would be preferred - this HW
seems to be on rpi1 (which I don't have access to).

Differences to v1:
- fix logic in bcm2835_add_host() (Robin)
- stop unnecessarily NULLifying dma_dev
- use dma_dev pointer in bcm2835_dma_complete_work() -> dma_unmap_sg()

diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
index ee63835b3ca0a..c949a3eaae794 100644
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
 
@@ -1057,7 +1055,7 @@ static void bcm2835_dma_complete_work(struct work_struct *work)
 	data = host->data;
 
 	if (host->dma_chan) {
-		dma_unmap_sg(host->dma_chan->device->dev,
+		dma_unmap_sg(host->dma_dev,
 			     data->sg, data->sg_len,
 			     host->dma_dir);
 
@@ -1201,7 +1199,7 @@ static void bcm2835_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		return;
 	}
 
-	if (host->use_dma && mrq->data && (mrq->data->blocks > PIO_THRESHOLD))
+	if (host->dma_dev && mrq->data && (mrq->data->blocks > PIO_THRESHOLD))
 		bcm2835_prepare_dma(host, mrq->data);
 
 	host->use_sbc = !!mrq->sbc && host->mrq->data &&
@@ -1281,10 +1279,7 @@ static int bcm2835_add_host(struct bcm2835_host *host)
 
 	if (!host->dma_chan_rxtx) {
 		dev_warn(dev, "unable to initialise DMA channel. Falling back to PIO\n");
-		host->use_dma = false;
 	} else {
-		host->use_dma = true;
-
 		host->dma_cfg_tx.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 		host->dma_cfg_tx.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 		host->dma_cfg_tx.direction = DMA_MEM_TO_DEV;
@@ -1297,15 +1292,21 @@ static int bcm2835_add_host(struct bcm2835_host *host)
 		host->dma_cfg_rx.src_addr = host->phys_addr + SDDATA;
 		host->dma_cfg_rx.dst_addr = 0;
 
-		if (dmaengine_slave_config(host->dma_chan_rxtx,
-					   &host->dma_cfg_tx) != 0 ||
-		    dmaengine_slave_config(host->dma_chan_rxtx,
-					   &host->dma_cfg_rx) != 0)
-			host->use_dma = false;
+		if (!dmaengine_slave_config(host->dma_chan_rxtx,
+					   &host->dma_cfg_tx) &&
+		    !dmaengine_slave_config(host->dma_chan_rxtx,
+					   &host->dma_cfg_rx)) {
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
@@ -1336,10 +1337,10 @@ static int bcm2835_add_host(struct bcm2835_host *host)
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

