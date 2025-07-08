Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E367C1DDA18;
	Tue,  8 Jul 2025 19:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752003203; cv=fail; b=aESUIrE8g4idAz/xx0lxGEuyqv6eO6rYuvtDCZQkn5hc1VT0ltgm9bpXc7/lyrSY88aBJJ2C0+2m/LlMbJsjM2LYna0r26FqhSwrgrB/GSMhG7KB83KFqdaMAY6Ca+/tMKmv2cU4c7I5ciVplu/oiIFgYROST7jyHqsj8p1muQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752003203; c=relaxed/simple;
	bh=8PzYLkEP3b0gB6Xhb3lFnWjjIzIg80/jFvgHgA6lB3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QqdAK2ORZQT5/N540N7Xb25KnLz1my8SNzypgOTMKXN4eWf4eQyzugYOUJxaA5F9rzoWCiK4YOysLVWnty7qm96FTeo6wBWChJyu5UPBmWu8SdQf0FjgB8Vcv0jm1IW969z98FtDdkHbSE2PVaq1YI9sS0jimk2vULOWFReic+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JSNd/c9b; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CzKjMRdO; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JSNd/c9b";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CzKjMRdO"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568JHaBV017026;
	Tue, 8 Jul 2025 19:33:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=hUoNuwCLkFeif4UCCw
	jNacuVP6HrCg0+3CHlBPleDtw=; b=JSNd/c9bXFyesI4bOjsyQpbAzcEzPGlq5g
	rPVJmHNgUQqkVlWKlfGkCEsAEuNRvKHJit9md68utlwmXbjKgW9N8Ep8hs3Y6qTp
	g0VYqoIpJhBBiBYhbc7Jc31zwoDUfiPRdZWrr/H1/sViw1708ZUWzX25o/Tjfqqq
	H+H6mu213k8iLFB4zUvGGaC24VTkjVXNUew00ChV8l1jxmbussKgYUhMYyCTuTni
	aIFZZsNZvT+d4yzz+MEyGM/UOy/NlD0gRit2eeKx2bFs4e9hajK5bxDZikCxUNCw
	NcaDcGNNEcj1QY9IWt/N2oqR5dTc7hhr1OwsBeNCcAZC7+oTJaQg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47s9bng0yf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Jul 2025 19:33:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 568IMAZn014128;
	Tue, 8 Jul 2025 19:33:14 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptga2642-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Jul 2025 19:33:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dOcOXX8Kkk5TFB0oqNDLJcDSBQa+px5K1g9WeQMhDZABb2BDzHRQZUicCEUrP0esCHGVjyooga0G6wezKDHoRVGTOAGfwukR7B1Q57ARO5v30SZqakd4nwfa3/G2opei63BsfPWK9bCEN2zz2nmjcfNQjswSux62M7bWYZvuIINPrjaNvBRuqxwubkc+PYmn+aaA7J/aJSKAR/ZLUK50sof08RvSuyylWFqizPqZAIha5am274HAQWN5w8Ngztj2i0YPGNA01lR0bMtAMitXWq1oENPcWBhmiKtuMxy9o5kGDOr/dKuYsZNYZ2S/kuzOrgvHLALRTV6EbkOOIcoB+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUoNuwCLkFeif4UCCwjNacuVP6HrCg0+3CHlBPleDtw=;
 b=BP4pSj3mbvdIfyb3h/E+aYb7n+Nw8pDFYngSGkjRskwKr65Xk/JYdRwho3J4zwdhazwLUyNRudfhwOtUCLt6veaJZy/aMaWnwxqCpqHo2oTDtPew62zUf27+obApWoiYxFJmAz1fWqI/MRzGswdOnKm/GhxmJlqu9N5MGmbEOGmP1dhMc62lZtkG3I0ZIXMptqr1Ir/N+SSgDZ9TNnP6GXxFK2w4H3ZXVZHuyBeBQhVCKkH/f1n1P3oppF+U7xYaBzTo+hjzIys51BSESs3yDaC+x75eVvUDE7dZqLHQ0D2+3WRwUtWNm7Ml6pgSq9vq1rPoz6+ReU6y14tmuo7WMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUoNuwCLkFeif4UCCwjNacuVP6HrCg0+3CHlBPleDtw=;
 b=CzKjMRdOEm+IjCbUNHk09+ybYCrfZLy6BW0yaMP8k1ac4r5J7hjto8xanAw//rteVPcHqh1y2xDappPCNf44hZSQgbq3aWHo991d2CI940IAFhDVdd/Miwo0CEXvn5Q+DAqn3XydfWvB1QoJYQ2XRLvwYhyGjnWNPAgd4NphXuE=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ0PR10MB5645.namprd10.prod.outlook.com (2603:10b6:a03:3e2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 8 Jul
 2025 19:33:12 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 19:33:12 +0000
Date: Tue, 8 Jul 2025 20:33:10 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Uladzislau Rezki <urezki@gmail.com>, rust-for-linux@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: add mm folks as reviewers to rust alloc
Message-ID: <8ccd13b7-3708-4167-b62b-cc7e2b3ccced@lucifer.local>
References: <20250708183747.104286-1-lorenzo.stoakes@oracle.com>
 <676fbd97-8de5-49e1-b378-18f9c918a51b@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <676fbd97-8de5-49e1-b378-18f9c918a51b@kernel.org>
X-ClientProxiedBy: LO2P265CA0205.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::25) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ0PR10MB5645:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dc6d3dc-6c10-425f-318c-08ddbe5646da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NGcBqYIO3inkvq+3wELZpMIXwb1Ja8kxNVNL/LLMSOPALWQceCeXXEC44mCZ?=
 =?us-ascii?Q?fCVlKCOOOUeiZwPw1bbd6hw8KFa9pC0GvU/oyi9PUWpA4n4ffJyuUnFOk5ht?=
 =?us-ascii?Q?57JAXb06sE1j273XvyBWGwaWwn4JLmZ88ssnagHG3aRjSWqCIXmujbdi7wtC?=
 =?us-ascii?Q?DEtIFJQx5HcVwPxhvaOJEbVGDLNhQIXJ6uTvpVcMo5eviFM2CFlP6jEGsb94?=
 =?us-ascii?Q?IGXUEJ3iDXlqadQS5sXwS6+VLBDyIMHSl7TaTKjkTpS8P3te2mrhjDT5WRqG?=
 =?us-ascii?Q?uP66CYdtEoxlJO3wWcgD8d5d3cK1iWlXzIGhdSEp+JI11umuthrQjnMVnWN0?=
 =?us-ascii?Q?4LOMFWl/NdmaO9jaqyRWL3kd/ojE8W3PiT9Nc+nAqXMn+8x10nPzzXpTkM5L?=
 =?us-ascii?Q?mJqixgHhfgKFixwCTvgJbnZTyZR6m2Jjb2D/9KEDZqbMCNuNcWfqw0VbX0cP?=
 =?us-ascii?Q?eacx6olF+jKBB2Asiem5O2YFcZV01jf8LfvyRmNQVR5lyHXoY9L4ysDtyUei?=
 =?us-ascii?Q?+psWMEjlLnKt8HHZ4Ohv6VLs/gG3LZFq0Kt0a8cu9kZK+o5vxhKuNJU62LW4?=
 =?us-ascii?Q?sG+QnnHvrz+NyAvk0nPOqwlr6iJ3A9NuWfoq+nz40mKjg35aOwl2fQfPU+qH?=
 =?us-ascii?Q?zLdcgUBUuixIco5jEF6P0vpCE8+3WJfbRFIEVgp938OxiQNzIiwrOGdJ3T46?=
 =?us-ascii?Q?GrzayZh892Ck+6UUtf88gX8fnDs3YNgG4vG3+piuvs0zdx3l6rfpenXm7Py8?=
 =?us-ascii?Q?JiO3y06nLvgfezeiHDJMzjZ2gxxtgr9Sn58+FuaN8dsgivxVMEW1XLqrRLR5?=
 =?us-ascii?Q?cnFmaGfsrlQd8usiEEIttGg7J/YTadzGM56xzZ0VoZ54dM+O9A9712uNs9fU?=
 =?us-ascii?Q?hUieESUkF1R/NlNLnJhDKVBYz/pAwTfworaMVA09MBP3YnlCzedPQ7yZO3mC?=
 =?us-ascii?Q?tFIFnHhU8NyF7X1vQjLVMaUJUbymCa/OIEsFhgC0pW/vCXY343S5HLHhI29W?=
 =?us-ascii?Q?cuYrYmviXz+TC0nGWDn0jS0nJGi8uQ2On7kH3BHNi6d0vdiqcF/9pIQGkCrD?=
 =?us-ascii?Q?nx6TTrePuVvSV2+lnOW0ANevDt0w+ELRYmfAjVLS71Ku0X17WacKoXLXNWAG?=
 =?us-ascii?Q?0AHdiKwNzVO8aN8sR+Zyu11qXHqPrez/vlbcN4vfnpGhgFA2jQXvVJFNeJX7?=
 =?us-ascii?Q?TvRDNz6yEAfbFnINOPixYPdWM05LI7P11r4yBu0gQFm26vwCUthlnSIwTZOb?=
 =?us-ascii?Q?SY+eX0J/w4tdW+LNfXRnouOWvi5RMa/HO+PNYDB4VliweZsidKbRWrCanFzX?=
 =?us-ascii?Q?qOO2NCGqtqGjgx4HGLVem5L6Lx9w3FLDv8yrUu8SxVIJ0kIXTicKQM2sRhSm?=
 =?us-ascii?Q?S8E5ImmifY6FNPQwzk+wR+tsBvS4hIzJ3kiPeozmof5PBDjwsduECHYU2nt6?=
 =?us-ascii?Q?GaIEzkGxcyQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CAatM3eZNvVELTYEByS3ecOFUj3pyPYDEmE5bOxsTpvq1UARDBRDbO8v9c3i?=
 =?us-ascii?Q?UfmrhfX9I8o0iQU6R6cIj+qPmGV5QmK+4+yTk2K5OLkoAlYdj6+bOoC60TAn?=
 =?us-ascii?Q?0oF2YqwmLnpuOEtm6pLGYgpvoQBswtwxf2CnokYpES8ZhANmtzBDQA7DtVMB?=
 =?us-ascii?Q?cT4600/ePohA9jzm5e5NOFM6oOxpce+B4etwfusqPMKHbX89YvnGNuS3djqc?=
 =?us-ascii?Q?Mor1FWtt/kAV9P1xxzRXmkCFRD4GGBCk/qKX7ICN86MmheXZvroqYNXq1Wis?=
 =?us-ascii?Q?MgC582xTSafwtpRhmpFDFzSd+4k9cfwrOT5abvqROjwCzk8wZNgtWR9EZ2vC?=
 =?us-ascii?Q?aSkyQos6sr1BgMxwYHDRrGar1wyxXwsvnweRnnua+w2rlvfR1Ws7429GeRWG?=
 =?us-ascii?Q?uY9nAA3lpyH1tHWBjX/TCefuDC+ZpzqotFontceW6ZqBc7de1M6fgplnRKzc?=
 =?us-ascii?Q?vgQT8aTeqWe14ukFf0GO7EzWCdk460IQlzphfIAJ5QdhdHtUW3zOKR9Zn7R1?=
 =?us-ascii?Q?U8ZudUuWjiM2cYQRyjRfJR/Mhs04x+YeGQYJZstwRDJ489rTeFyS0ETnHJAn?=
 =?us-ascii?Q?e6zDQb0GmZ87tI3vCGuCIPtqNBvSAm8LEs3SLBTbMBFasOLK0n4cEU1hsQI/?=
 =?us-ascii?Q?nlKRsEsxAvv2/Y1E+S3DfXs9qSNGDAYsupQ9YqvxND9zl1eUK/jpRS5Cjg+s?=
 =?us-ascii?Q?OhNTqQ4JtLjvdbW1+IPIP6YwQXhmOZX01jNKI7Tn1Z1J1Ps3v13N4jrS7Y1o?=
 =?us-ascii?Q?gNSO9mTeqGEje0spFQ9hDCeLGmzFDu2FnTvOEgpZzEZMBOoaGKH+rNEJqH4j?=
 =?us-ascii?Q?FEofUuMsIUhV6dDWkYxYwJlgvbAYeOrauOVqZ6vlIRkAjk7o5MxTJKT6/QNC?=
 =?us-ascii?Q?HjnjqtU7Y+WVJyg+Do5M4KOgyRDQArsBnXh3J8uHbyBCwrrJ6Q90jAu29FDa?=
 =?us-ascii?Q?XCVR3w5wbmRnlSm+7jXHl0s4f6SFttV/xEvXRFK99xcJEYc6tp5dFoscbUTC?=
 =?us-ascii?Q?sUsLxu5AvjJtc0bdGeQYnpUWwoNV6CRHRVq9JBhybN9ejmdY5FmEAkluu/Sv?=
 =?us-ascii?Q?R5vkU3kvoh9JcDr5aVBaZw3EF2ZwybHqDa0aHMADXnWElYRI7hhZkdf0tZbp?=
 =?us-ascii?Q?tYDD5dlgfIY+pFyRuJo5RdamnbbTNirYffZrGJLlpONKcgrdi5k03jUoN7XS?=
 =?us-ascii?Q?gAqZ+RA0Ot7XS9CjYTH9JMFdQwiC3izyBVH/nfvKoRh6zzq+ch4Q6yY4aJO+?=
 =?us-ascii?Q?Fgu3RF6FdL/TiE+JNmjTwc3NMNVtQozZwfK+OVG7o9Y+2EvZSrYrrRuRATC6?=
 =?us-ascii?Q?I12AV6HQMhebDeo+gALweSc3Q1ocOLIi0+cZp5XRFVpF/UJEafTLSsbxTZvd?=
 =?us-ascii?Q?IJN7utgQffyvDEx5L9zMGcOBGFW20mT+3100INRI1XEj8+kJGSVHfzTWImST?=
 =?us-ascii?Q?aVpWaAt5Q5QClTPJ9Fbydby96700yIsWOF7/w0rhPH+h92zvMKWJwdL/7BZf?=
 =?us-ascii?Q?KKnSpPeWDXnlbqC/wG83OO5suJM9rRtPM30hCIDh3L5CMTBl4epf7i/5/OCG?=
 =?us-ascii?Q?pXSDUZzgoGUsGsb3c9pMeuiqVmcwZOpKWQGYLHkHdKal3vBmSThN3p3dic/e?=
 =?us-ascii?Q?pg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LWwZmt4CA8CMa/pa+9QUMq32tJ0dsOOdgn4f6zCcs8GrTho/YIA//g9iYG0FljENiyrMuXqdLGg7udaW/5U1Uo7DxMq7ljEObU9AwApQxjDcjbipNr358ie1BfHrCUo2tfTJZGey++Id6onUTSHhZVW2OGBJtYOxXTuJC94MPNZP+oQj+ht5XQoCpA2haWV7MY8nOXZmGn9gXppmEYdwqeGGjw7+Ol96ez26dAn9HxHOLtEq+1I3Ya65MZ7XgL1byizBlKE4Qc5kd5nWfwdi2cj9fAYdGsbk7PFbCuZsJXCB01vH73bQ1ogd0E7PyHVV4HWmnxh7lHmar5FpiHx0Cc05t7cQaXrofqmJ+K8amfTxpE0fy3DxC8zMTR/ydNicsx0rwVGm7Ozza2YAukljg+OttQewppU7+USg4MjJ6HKPz4+7X1bfVmGm0X5imrumoe9DCcX6epYn3shSsHB3zpZZtfZAvMhNwgF7VdtOkNfyNnqGXzjOrCNiboC/M1qnKjvRZcLudnSLm7EeUFZBVwY7o9GbhiEdvnexfYdaPIVvDIkNe8rfCDdDS8EzTn1Oxh3154+NV7AREbXKE328dmbFbiVFNwhPMbl4XPBHMW4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dc6d3dc-6c10-425f-318c-08ddbe5646da
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 19:33:12.2414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +QWGv2vC8ve/lppezeFXVJGVoSIAcicCmS+yRkUOP5tt5azWKLmJqc5UIIcqv+aTF9NHsLl66dbcJ+mw3lcDELgJK5YFZAag9T9p/kzkPIs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5645
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_05,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507080164
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDE2NCBTYWx0ZWRfX+t7rce2tnJGh G7gI4M3RTTl1MUxfEIFl17d5lJP/LSLRtckSqh7L3xbNh14vHcux4PzhJNXAqgJDz5fHn6fmEkJ FPj5YvBkyD/Zl212xOzwhu80YxGToN0CxaFZTrrv09tOTpUDNPSzvmj3JYFNL8HjKxk6qhWDKJe
 AJ1ZdsSVFlvPMxEuMbwgnmjyrjbe3b3YCp0IiJatngVBDpwGxCAzwQVCjtTG/6WS1wCm1UKSFN/ vNfj6td1yqNPI/EPCYcM+y/MgpYK1RHcnxT5n8cIXmNvuDx2T4yxp9R/1B2Gd3f5u4B1Ufl203q ZaYakS3vIZPov6dHdtBd45J4jwNS6wEx54q76RJInKW4mvX4c9Jx+J7NBiKHf9a+NafI4jHkTEL
 /5WI8fcSOwG9nCQ634Rj5vqIOhjAJmOYtf8dy1Lkgrt3nPOMCzV9MFGi4bWQPrZs2D8b66oq
X-Authority-Analysis: v=2.4 cv=EPIG00ZC c=1 sm=1 tr=0 ts=686d727c b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=NEAV23lmAAAA:8 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=r7HjW-EcTq5xBnAfIOIA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12058
X-Proofpoint-ORIG-GUID: I4FWzxAMg-hYLtdN79mwE3JGTzrL4KjN
X-Proofpoint-GUID: I4FWzxAMg-hYLtdN79mwE3JGTzrL4KjN

On Tue, Jul 08, 2025 at 09:31:05PM +0200, Danilo Krummrich wrote:
> Hi Lorenzo,
>
> On 7/8/25 8:37 PM, Lorenzo Stoakes wrote:
> > The alloc implementation is a thin wrapper over slab/vmalloc, so to help
>
> It's much more than that, as far as MM is concerned this is true (no need to
> change this in the commit message).

Ah sorry, feel free to adjust.

I think as we were talking wrt mm bits this was the take away from _that side_
rather than rust one :)

>
> > out on the mm side of things and to be cc'd on changes, add some mm people
> > as reviewers.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Thanks a lot for sending this patch, it is very welcome! I will apply it once I
> have an ACK from Vlastimil, Liam and Uladzislau.

Cheers! I have pinged all concerned ahead of time so should be formality.

>
> > ---
> >   MAINTAINERS | 4 ++++
> >   1 file changed, 4 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 71599ab6bd56..54dd937160ac 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -21751,6 +21751,10 @@ K:	\b(?i:rust)\b
> >   RUST [ALLOC]
> >   M:	Danilo Krummrich <dakr@kernel.org>
> > +R:	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > +R:	Vlastimil Babka <vbabka@suse.cz>
> > +R:	Liam R. Howlett <Liam.Howlett@oracle.com>
> > +R:	Uladzislau Rezki <urezki@gmail.com>
> >   L:	rust-for-linux@vger.kernel.org
> >   S:	Maintained
> >   T:	git https://github.com/Rust-for-Linux/linux.git alloc-next
>
