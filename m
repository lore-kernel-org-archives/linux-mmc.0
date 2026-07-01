Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE943905F5;
	Wed,  1 Jul 2026 17:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782926668; cv=fail; b=LlOrxF0zhj6Mtu8W7xz1UO9pB4bQtc5Mh80Gc1ewIMdlks2VA8Hhe5mnlo49h0tHdGhgHYCC7lgzrrSPfI0rUZXflwQx9I6fHOFwEMhQGglVykb+TPyTbxXPG/GrIMOkhL709pBADRyJ3NUYCZvzWATU+bAmbb/zSgf0r94zv8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782926668; c=relaxed/simple;
	bh=G1rwx6ffwbQxxUTX4OS+dEk67rowdVnbeYgyILLx+5A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dokELBjbzuCX5kynHSrA1OqnVo1T5GofkDCHK5cXq1UN3aS8Xrlh1hUpoMz2WzK0vYWPWRMCiz51/CVfhgivKM2au7kJx+96qeokOc75G6e4acnzF4xGYRPCvyS67o9m5rjeuTRbJyDr/T2N7C67HML5V0PXNypYaWW3Z2x0A7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PTd1bgZo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aShkwOOi; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PTd1bgZo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aShkwOOi"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661EHKf62839092;
	Wed, 1 Jul 2026 17:24:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=G1rwx6ffwbQxxUTX4OS+dEk67rowdVnbeYgyILLx+5A=; b=
	PTd1bgZo6SIIbpMGcUT3D4qqhPN3Iz+8OXzGKPqIOQBnpQXaFv5H9vTt6xmLu7kO
	Xv6X+HeHXLwSp8//Awso0gol+WnyoXHMJjg99m4SJGkTGdE3FCtHDmrdB9vb/OM7
	a3WrFBZRdHH4+tBzKDeU4e9Xn4KErn9D1hFA6TqyJsidK0rRxVTPGjWr7yADzcEL
	ARqQ0CitGYdBhR6oUTyMruyPNK6qRz2PzNYAUVa5ypm1St42R8TKVgkSYaj5yPbx
	2+FOl889S31nQQvc2RigcB8+SdyZqm9fe+DGbtVVDra/LazB5TZLX7XAIMmoRzmj
	s1x1abSHR1nqAxMXclrKcg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4f26p46p38-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 Jul 2026 17:24:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 661HNVKv006767;
	Wed, 1 Jul 2026 17:24:21 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011056.outbound.protection.outlook.com [52.101.52.56])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4f24ys0g9m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 Jul 2026 17:24:21 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mo6Fy/svuFRwkGdeJop2gtB5tdd7XXC8g19MevQR5R+q68K9flH11O7VAOXacD0TZRnKO3kRt6FIgkiyuGDRlFrPE3tfS3nH2/YZrYmwYIGDFTccDR9VrS9dPNgX2nv6u+CfKznxu5OzwqLX0uF8mqr12rAVBPHnDIX89bPUb6ai57WMyckIdzmJcoQI5Drilil9UfDT/L1W+8oyGiJC8PzDE8g7Vl/p1KP4dc0RpNrvy2FoKp8HeL91FwscbgPeZrKzWSLHN5A1pyDRi5f0QrGqS6xmk2i7RZ4fadoNwsSmU7wzg3/zrYpxirwVp9fmemB4Q2T00ZUKXaATShPfeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G1rwx6ffwbQxxUTX4OS+dEk67rowdVnbeYgyILLx+5A=;
 b=y18ercFItWPv2yAqOb/IcySv4AsWFQSRNy1rh+nQf0bXjtmc0l9kXfFQ1QZTbptaIueIraz9bJ63VvIBOQ3rI+9sfM7+2B9dDCs4Br7BoJpoaKg/fawZC50L+A86jKND0hFyNljdW9YsyTf5ZzJ3czQRRjHlNnppkPKGZVeH8B5g+f5TZLS+1nfGEUTs3JD9l/JJ4+H/QYTor+/ErplVSHKhNOXEIpNvwHekH87aIVeYzeBRisVk0R4pF40wPnio1NTt8iJusUZZ728o9VsD6l6GGLQ3tHdH57r1CVo2nJdaHI7lYmshuKStoNGfbZ2AOxxZb8SiYJHSVYfSxMWpjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1rwx6ffwbQxxUTX4OS+dEk67rowdVnbeYgyILLx+5A=;
 b=aShkwOOisEq04rbxaBA7YU77d37y4ySU+Woz5qAKiw5qy0SXaQ18EaAerpRvWbJArhdENYAPgYYZ7Y+62JxR+X6g8CS/tnUumi4ZqbO3Q6G3qhkdMJKujtkIT14YK/QLyxzZT5D4rsfNTcNq+Bm9WBbaJBgUIXPxTykVwFua/4g=
Received: from SA1PR10MB5735.namprd10.prod.outlook.com (2603:10b6:806:23e::16)
 by DM4PR10MB6181.namprd10.prod.outlook.com (2603:10b6:8:88::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 17:24:15 +0000
Received: from SA1PR10MB5735.namprd10.prod.outlook.com
 ([fe80::92f:d492:6016:886e]) by SA1PR10MB5735.namprd10.prod.outlook.com
 ([fe80::92f:d492:6016:886e%5]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 17:24:15 +0000
From: Satyansh Shukla <satyansh.shukla@oracle.com>
To: Ulf Hansson <ulfh@kernel.org>
CC: Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [External] : [PATCH] mmc: dwcmshc_bf3_hw_reset: Log eMMC reset
 calls
Thread-Topic: [External] : [PATCH] mmc: dwcmshc_bf3_hw_reset: Log eMMC reset
 calls
Thread-Index: AQHc/xDIvzvvZM5Dska05au+fu6HhrZY/Vj4
Date: Wed, 1 Jul 2026 17:24:15 +0000
Message-ID:
 <SA1PR10MB5735E6FEC39BC2AA383FAFBC8EF62@SA1PR10MB5735.namprd10.prod.outlook.com>
References: <20260618105319.217717-1-satyansh.shukla@oracle.com>
In-Reply-To: <20260618105319.217717-1-satyansh.shukla@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_3c76ce46-357f-46de-88d6-77b9bbb83c46_Enabled=True;MSIP_Label_3c76ce46-357f-46de-88d6-77b9bbb83c46_SiteId=4e2c6054-71cb-48f1-bd6c-3a9705aca71b;MSIP_Label_3c76ce46-357f-46de-88d6-77b9bbb83c46_SetDate=2026-07-01T17:24:14.608Z;MSIP_Label_3c76ce46-357f-46de-88d6-77b9bbb83c46_Name=Public;MSIP_Label_3c76ce46-357f-46de-88d6-77b9bbb83c46_ContentBits=1;MSIP_Label_3c76ce46-357f-46de-88d6-77b9bbb83c46_Method=Privileged;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR10MB5735:EE_|DM4PR10MB6181:EE_
x-ms-office365-filtering-correlation-id: df9ff92e-eb98-4fac-bb61-08ded7959371
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|18002099003|22082099003|38070700021|56012099006|5023799004|6133799003;
x-microsoft-antispam-message-info:
 6BM5IQIKkkgVZCWj31yB6Afa+Ituh9eo5L855jo6QLjrHLjw1S//8R4gXMjkEORGJNAiL7u9J6WBlTxXIq4jxi+V8gzLMDdS31fc2lgbFjKNGd+bkSkb2MzhdDT0fFBlpAwwv0WxaLdnQC/JacI0Y2PIsDOq/9ea/oh3S+NZo58EhbF5KiCotokSv9xIuLS2JDE9lQqL4uwhRIObB9alReOdaGY778Xm2CTqhz6y1zRP+7HfV8c5z5T1J9XOytvpLfODqii3YerLHtF3sVBs2Tv3TOdQQxXvYjs6JRD+oHp9n+aZMlP5yrp+GGhU7AeBktUqeLDXOk2fzUXRePqUe+TDA5mQw9QcEXCVhoMm474+WRqrvDg+o60q+KmBTIlIAnIJB6AwxTKEv2pdj9P1ffVhzJrKr2xWJ1i3n1iStYT5XGfpe5y9sisJXIGmkN+i9yz6dtR+GdYPL4EGjoFbgPaN23AYbo5NpkonDP58WaCJT/w4i5b3fvHUVR6uBXe9UEOijw/yo229Ul+8KJmMo5lr4vqyLy/bwAZVcgitNBnnR4aHCkPpApVamdoU1z5wq/JTlKPBpp79nh52WpWWfuJrqPftyjERhR9wStZPoJsVcluZX4GrfEpo0VmL1k3Thk0rirr5lgrsHpjZuwrpaNY8K7abvBcpxJgmAIcvnq6CsewjrvGLBquHrMJlcLZt+1w8bmmss/VtheuPeFkQLw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5735.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(38070700021)(56012099006)(5023799004)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?z070QIhVtv0HkyR3Fl0YHR/zuIaKhvee9NqaWbk5Rn9VJ02xj3oEpftMg0?=
 =?iso-8859-1?Q?cRzYbrZohVarg24ZOOOZr6M1z7ic1bqlA3r/DmFXxlcv5kyH1ChOeIC+dg?=
 =?iso-8859-1?Q?/3t6D0r+gribufHHEKpDa82mrLNZc8ELAHVlg70u6otMM0+95YJHSLfvMs?=
 =?iso-8859-1?Q?ks63KWb6bd7p0cgLKOwImdpIq8sx/xm55FPULfy/DMSTHV+nnKN7dLWiAv?=
 =?iso-8859-1?Q?cr71LBUY/a7bouHnMj3dz8jxKdUGsJxCX69P2mXkma8+GIF40EmrkPMPrb?=
 =?iso-8859-1?Q?qHc/eT/JigKX5yISa4Hw4gPlbF6P0B+tNaRgZvRYG2GXQMe6CT9YaOSLYM?=
 =?iso-8859-1?Q?/4xnnI812GbO4tv3D2Con7XTe+qZPYSTGyjpTE18MsBFn2NzyL3fpo51k4?=
 =?iso-8859-1?Q?K6C3gdxWnAXS+Nk4Pkc5I6yn1LhLXoplBlAwtovpmWW6NYWXJzXh4xqrpb?=
 =?iso-8859-1?Q?c5Wv1jwF/v8UtjikeeksYTv7/1f/UoCJF6mgKyrirvg9j5bji40Ok3D5wO?=
 =?iso-8859-1?Q?yO3dihWY9cLEc2ZpR7boobel6ZwX0W27zMmhqkOfVOlprFxLrWK7acjrUX?=
 =?iso-8859-1?Q?tNzLVXit2zpRJ/KOIFS4U3kxdGNnwvN/pCM0KdEuz+jDGG8T0zNWh2M00L?=
 =?iso-8859-1?Q?QmVZUE+EHRVTLRcv2N/a8gXSDoc1ZEfh//LONSgfuc33gdX2/v55K52u9r?=
 =?iso-8859-1?Q?2fsFOvPFOn2JUJgBDXRi/PrxRmqPS3qfSVJKsl3rZ0yIFQ7E7tjAW2pWvl?=
 =?iso-8859-1?Q?qGECFYNIwU7MumV1JrmR6emaFR5XcYngciG6wpsVNpMZumrn18/qfOaqbf?=
 =?iso-8859-1?Q?p5Grc0P3t2ZuPVR+h2F1yDLwB/w4PkS/SZoW02+bhqQdEyo48d8zWp1873?=
 =?iso-8859-1?Q?bpd1yTgV2jN10pBMb5lod4h7ur7ch6kZu07eBEQTm5jLCrQbQ85T8OQkPW?=
 =?iso-8859-1?Q?PrTn2NUCJI9VAjmNloDDSKljXRrsxA4gTWTVWjRq2+oNn/g9mtms33S9vR?=
 =?iso-8859-1?Q?7OwRM5nONHFm9YOM5xW8aLZCG6dB31WvcDFkoeO+KREhZoxlq/4vRSMsnU?=
 =?iso-8859-1?Q?qWuzPu1smZkuIwFRiA4Y7u8MOQHfPV6cP3BpbvKImFICbNwqbI8jZC+ETQ?=
 =?iso-8859-1?Q?8xyHxkfgkogl71pgzBK8t1uVNWHWYF+zCDDadHng/MnS89wlaCSaEDOcKZ?=
 =?iso-8859-1?Q?224NH2Jtryek3FhdeBm6U1ymqwzNgqPx4SSmuRPOQIDaO7JrDKs+1uDx23?=
 =?iso-8859-1?Q?/SaZKDiiooinuLGStvKdPnz+pHNz3SaoJH/sQEbFLKb4bZg2Yww5UvArju?=
 =?iso-8859-1?Q?5q4G7WBRdBnWGnWSA/deCyXQXJI8O60PjpOFa7Canm+Thu5pGMH2bbDTIM?=
 =?iso-8859-1?Q?jbho+QVmZ7VsK/a3sRul/YMts4ecviZxkMA/GLR95vubyMI/Cuub1tsE8d?=
 =?iso-8859-1?Q?98nFcqvHnfx6DPsC8CsVZ9FSlUJaz2iWxM1UjUC0qbFDEKZTavo4Qx6tyW?=
 =?iso-8859-1?Q?Q4+zkY0Pcd0FzQ1aFTKT+MVIk0RqEgfMrPhvq4UormYPB3CoiekIE+ZeUc?=
 =?iso-8859-1?Q?4YispDI6a2SBOu7MSHuIJaE6JUwt7DvB8bYPWfXH0SIu41ghceblvj3zCq?=
 =?iso-8859-1?Q?W3OsIG60QO2NzOKNQCvlCVCzlqdXtOFPU/qj2DHjGHM1lq50eyqfn3BZST?=
 =?iso-8859-1?Q?yIVPCJSAZTJl8CS3Y+4V5gBOkARvvRgMT4S3tjNLTTaw42ZZUEmlwkoqF0?=
 =?iso-8859-1?Q?C5mqgNICROZfX1FkmSWUH/kgRESG8kolSAXkbt5It1ygKrNatESUnPMxND?=
 =?iso-8859-1?Q?D2yOZ5GJOA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	px6o+4WfIyaYX9a2UXye6wGsKo9c1AfLlneJ128An1g3+cKge4LVReNNkI6Qx81Teq10Flq40QCBOaI90n/B/la6c5GGlMylPn5mkLtSAYcYffLRFFV3kSZebM3yj7dgJDPGys24sut9AKjzbu9kfge5KQohhQ1BY9nsXmJycTifhouwYw504ubL6Vw1f7pMQLWQUOHHshcdlxeFNCepaOcy7GN8MOGHUmdbf5xnWynpxx6vvSUO4OnLypcx4soRC4YT0pler+32lBdbPNvOU1aHTuHETz0WvEV5KW+eW27KTnSyesgL438JiZ0peTHN+S2BSGZC2GJLntNJE78bNw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0qrQVXKOhKknfir3CpIsGD1fXxiS8yRP3DyR8JHAS2ZcgK4SkkJbLOvEMfwK9/fa47JYShGaFGxqIp30cCNt3IvEYqDEHHoKi2XRZ4Ge0TcCKMdOkEHhttx00PNC/5h50WGhwfebUz0aNnzB3FA5o2BCyCAjeO+u3j+G7sqp7T25QFd6iZV4Jepvm5ayDGmOSo6Uxy5v+Eg2U0Vi7HU7VoaXF4zfZCnuFSEq6jPeHOVf7nA2BlbweMorTaR1RoVEHsxWEULtJ7k6cCwwgONCxL+0+J156/GZYd1YhoWALYuzHh2pI3ybaXT1JSEtytzpOx2Bkn/EtN3wSCOByntAjUGuAnT/0AEH0Z6Xz/llKAseZmQPKxON7LVTbKuXn60WtTrxGmm6bsjCQcFeMAEcVqya1EyFmNfbFA9CaMWJUz9ih8Z29WXYxhQ6a+PTo7r9MkuWudrnZtvTtUbQ2l+mQ+6tsQSdiZ6V/lQ0swiyZe6hDHIRvfCWmEMgJ3jUOetm8hRMlywRlhD5Y8sQs2r/lp+H463YYu3sZXlFPh9jApQAPoRDSTrtPdWR8e+r3hk/vzbPVaH6jFl1DJO6LwAJncqEdPJPdyUsH3sdUk5L6sM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5735.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df9ff92e-eb98-4fac-bb61-08ded7959371
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2026 17:24:15.6900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b46S311hfzOja+hYNGo9eW+sllhrslT7YhYhloDKiEaZ4pzD2o8jG9wADeg5+5FcymtIKvE1oD+E9zUwuSKKgOd+ND0TUCbQDkR/Jb4s0dQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6181
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 lowpriorityscore=0
 spamscore=0 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607010185
X-Proofpoint-ORIG-GUID: Ak96_bSh9y4BPvWTYCMsSqj3Qk0oASlE
X-Proofpoint-GUID: Ak96_bSh9y4BPvWTYCMsSqj3Qk0oASlE
X-Authority-Analysis: v=2.4 cv=DK6/JSNb c=1 sm=1 tr=0 ts=6a454d46 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=RAioF0-LDSMA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22
 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=zgb3mG8yJQ1J5MugOGkA:9
 a=wPNLvfGTeEIA:10 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf
 awl=host:12312
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE4NSBTYWx0ZWRfX8f6WTZ8QDeuz
 GPK4MEbuc0lo7IRf2v4bQkgsj4JqFiqpUNwYYCm4zBTMMzAP8SqJ76F8qP3p3R7YZR5kvuu62p5
 c8b/vrwFPE7j7Fd5e8/fK2K+W44bfc3cT9AH+JvqfdPza2M22oXsNOcUZJwAxYAsFYP7qfvyctN
 knG7CVJv0AbmizH2S9OaP6qKwOKFtVUnx6bZ24oht8Tg4L5naemYDvo19tRiUv7bk7P5gAJE06Q
 iS5zvFujYPh2hxvyNSiBIUubxx2NYt5/w64QcmNBPd9eQ1oWYSscOd3dOVoXHkgJZ4+kkYFQoC+
 EYDWd8+SZdL3v1RSfnkcuQ2UKcalry6PN/bc4kxm91jofz/oviGtFYHezKBcpVIQFcBZOSx8g0r
 lp6XvTTrCxTUm2OfcdGTMTsSpb8KsWMPyPFdSpWX/um9QD/2yRZUHXbLuxouHBIIDyQBfdXukr+
 B8ewpguuuRrgTRruNX8vhLYsB4A+hkg+YeCxVv1M=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE4NSBTYWx0ZWRfXwPCdNhyVJnET
 C4dV1YAZzUekFbslPz4p0pQnpVKUcozXxjFbJRA5tP8snIrLl6nDSzrkNZ+NYixw+T1A7bx0hk8
 KAW+04RLqJDHFBNpixqLBUKgt8in0jb/GPSYA5vtwxrLAP/INIEa

This is my first upstream patch submission. Feedback on both the change(eve=
n though it is tiny) and submission process is appreciated.=0A=
=0A=
Thanks.=0A=
=0A=
=0A=
=0A=
________________________________________=0A=
From:=A0Satyansh Shukla <satyansh.shukla@oracle.com>=0A=
Sent:=A0Thursday, June 18, 2026 4:23 PM=0A=
To:=A0Ulf Hansson <ulfh@kernel.org>=0A=
Cc:=A0Adrian Hunter <adrian.hunter@intel.com>; linux-mmc@vger.kernel.org <l=
inux-mmc@vger.kernel.org>; linux-kernel@vger.kernel.org <linux-kernel@vger.=
kernel.org>=0A=
Subject:=A0[External] : [PATCH] mmc: dwcmshc_bf3_hw_reset: Log eMMC reset c=
alls=0A=
=A0=0A=
Log when the BlueField-3 eMMC hardware reset path is invoked and=0A=
whether the RST_N SMC call succeeds.=0A=
=0A=
This makes it easier to diagnose cases where the controller recovery path=
=0A=
depends on issuing an eMMC reset, and helps confirm that the reset sequence=
=0A=
was attempted on affected systems.=0A=
=0A=
Signed-off-by: Satyansh Shukla <satyansh.shukla@oracle.com>=0A=
---=0A=
=A0drivers/mmc/host/sdhci-of-dwcmshc.c | 3 +++=0A=
=A01 file changed, 3 insertions(+)=0A=
=0A=
diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-o=
f-dwcmshc.c=0A=
index b9ecd91f44ad..8acd4652a12b 100644=0A=
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c=0A=
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c=0A=
@@ -2019,10 +2019,13 @@ static void dwcmshc_bf3_hw_reset(struct sdhci_host =
*host)=0A=
=A0{=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 struct arm_smccc_res res =3D { 0 };=0A=
=A0=0A=
+=A0=A0=A0=A0=A0=A0 pr_info("%s: resetting...\n", __func__);=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 arm_smccc_smc(BLUEFIELD_SMC_SET_EMMC_RST_N, 0, 0, =
0, 0, 0, 0, 0, &res);=0A=
=A0=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 if (res.a0)=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pr_err("%s: RST_N failed.\=
n", mmc_hostname(host->mmc));=0A=
+=A0=A0=A0=A0=A0=A0 else=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pr_info("%s: RST_N succeeded.\n=
", mmc_hostname(host->mmc));=0A=
=A0}=0A=
=A0=0A=
=A0static const struct sdhci_ops sdhci_dwcmshc_bf3_ops =3D {=0A=
--=0A=
2.31.1=0A=
=0A=
