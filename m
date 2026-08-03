Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B8B313540;
	Mon,  3 Aug 2026 19:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785784788; cv=fail; b=m3wZgn2YgVlWTdQeGwPzUW8ioRhS3R0doqcnw4dl+JfZzxqhwa8LX0FJMcpIWZ/MR0I277jplqZQ5fbRZevuvrgfr2BPwRlo1b++ivdaG1syEN3UTW35q8fT5MBnuaoQY97Ws9yngzSAtufsB9HgnNNTOtXxb9Iy1wGlQlN/h0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785784788; c=relaxed/simple;
	bh=XiCgZukHVIbg4YE1PRxPnttK2xfB9Nk6rR3YIkZ2jxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mzwK06Z/fakg2kqxfOs1EOvR6S/g2yX1BMMtUZH/uX0/EnCHEg6XagFSAcT6LJMl/GnEO9BrhEmoiuFuRXSP92WD/AuybnmX7QrKjKOKrRT4nJyOT3GegXww4JdeHX0XKdFkdLJdFT766Iyc0kyn6FS2/pX8SOqQUkftEHcHUBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=aUdIQcST; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ZCZ+q2/V; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="aUdIQcST";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZCZ+q2/V"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673H0YPZ449119;
	Mon, 3 Aug 2026 14:19:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=tBQy5XNwLAMoHnxt6LJSh3hPJLJIJ11gEIGX6koOK
	0E=; b=aUdIQcSTd/mgWfygo/POj4xWUZPE/m4eGfuHudQvdmC0Ok9gnN3b4qAoc
	d20GdW/bdq0HoUp8QtIE51aKw2NwDTzXJdjXKj/pE67qMstYNUUfwPpNxT0OP+Bb
	Mz0hLJ8AUesJtPbtRFNzED5VJCYcuc6+yIs9GhmnhovAVt+XFED3gbii8994dXI8
	lqg1gGoFR0XQsInRRfaQgZYtTBNV8quWl7h42UOeDzSphFyE50PsnnBjMhBaFM/6
	IJhTA+2xJ0TeWUz+qAHPFTCD0BAJ3QToQVYrzgdRiPfUsnbklw2dGG6HI1VLf06u
	TuwXllletQpvnfaO6JVM4jzkksUfQ==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011051.outbound.protection.outlook.com [52.101.52.51])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4ftt0akemw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 14:19:19 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OUkLLZhm11xGNQQU4F4c2lj0hTY96MOptSME1ov4wXmMB6pyPgjZe53V2CrtqYovybow/AAoguJ71oBR6Z04zXfV8awuFxroC+6i3PtqlxMfYus+m/1yIMw8q0xTQ/zD6/pdy/6wHD++GMlwTaaWwufN3RLB0zdwMeuA3AIDtUbprx8JF/qvOUrOQ69t2VINdvZVXgsWtfYWXLAEVPlNHY/zULY1jrqNFwv5RPImlTBCviB8I/UpaPSS2QY+bq59r+xzZ955BZPX3WyY6ih0i7KLBkrrKxUl46XKV/NixCk6RkfNJTnlySOTyovkGsUr6V4Jh06dt5QnVbSt3W7uuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tBQy5XNwLAMoHnxt6LJSh3hPJLJIJ11gEIGX6koOK0E=;
 b=keCAk6iVXDaIKYA2/WmjOLiMLh/qNp8YIF4CCCde9ZeSQY/tWK/zepzMNk9YfeYdgdQ2uF1BvUtDwjt9YCUtBT4sOqAAJ1Cn5tw96sJxIoddGDDkxBNIjELNwI0jUFkwv4or+GEoFtP/X8DZXuB6nRlHZlOPOy0h6+YiF0VvoxQgBdMd5B5JWB9GlkmOKGmVPCqf764MwEeb2TW6cPPYMMU6xt2tzy8bv+w/Jnfq2qb4sSUP4bo7J3T5AeFN4MbNvXMOmK3EWlfgtOK/XXjlVQooa9vcG28leovRMVTSPtytAjl455FlfaNWUo2CCZs0Av1/uzteHN5b7SnsV+1EwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=bootlin.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tBQy5XNwLAMoHnxt6LJSh3hPJLJIJ11gEIGX6koOK0E=;
 b=ZCZ+q2/VQu/p36Ie6d4J40H5LdzKACGHOo+Zi7u5NgS7fqk5FApYexUYuh3qYkYG6CAZ9PNhV7rxXF92q6HpywF7utltzdIEziJlNEXMJrpzCWCBUim9MQpQBJPawefPcRpU5c/yPtW2ojJUYOkZACI07t8xbkWFbxgIaOzOjo0=
Received: from BN9PR03CA0630.namprd03.prod.outlook.com (2603:10b6:408:106::35)
 by IA0PR10MB6843.namprd10.prod.outlook.com (2603:10b6:208:435::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 19:19:12 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:408:106:cafe::64) by BN9PR03CA0630.outlook.office365.com
 (2603:10b6:408:106::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.18 via Frontend Transport; Mon, 3
 Aug 2026 19:19:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Mon, 3 Aug 2026 19:19:11 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 3 Aug
 2026 14:19:11 -0500
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 3 Aug
 2026 14:19:11 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 3 Aug 2026 14:19:10 -0500
Received: from [10.249.34.24] ([10.249.34.24])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 673JJ9gV3047682;
	Mon, 3 Aug 2026 14:19:10 -0500
Message-ID: <a3d58d30-afd5-4aeb-9a0d-f67b324dd16c@ti.com>
Date: Mon, 3 Aug 2026 14:19:09 -0500
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] mmc: sdhci_am654: Move tuning_loop to local
 variable
To: "Diogo Ivo (Schneider Electric)" <diogo.ivo@bootlin.com>,
        Adrian Hunter
	<adrian.hunter@intel.com>,
        Ulf Hansson <ulfh@kernel.org>, Faiz Abbas
	<faiz_abbas@ti.com>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Pascal
 EBERHARD" <pascal.eberhard@se.com>,
        Thomas Petazzoni
	<thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
References: <20260803-am654-sdhci-v2-0-a5ee5be86133@bootlin.com>
 <20260803-am654-sdhci-v2-1-a5ee5be86133@bootlin.com>
Content-Language: en-US
From: "Mendez, Judith" <jm@ti.com>
In-Reply-To: <20260803-am654-sdhci-v2-1-a5ee5be86133@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|IA0PR10MB6843:EE_
X-MS-Office365-Filtering-Correlation-Id: f7c7e641-6a8a-421e-57c2-08def194196b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|4143699003|56012099006|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	O4AVWgpW2AyKGumdKfBlpB9KAl2OSjN7UoP2hwjcjyKd1VAD4oNxH1uT8MfnQtg1uRisk3OHg+eFwOYy8AdBDCitId+r2njpVVV9ET3SBqnD3vydC0o3B3Nt0gJ7ocmSacg1UO0Xt8NVyrX6ZvTCRu8J8yXkiqxxyS9Z6j4ptxhQLoXM/CfobwyEboA+vr/4Pbes4uVb4bWD+tGPY/1taQVTrh0+bjJaMw/+539vaQti8wRYRsPvIMDxBgSTDZ+0iX5+11QGEJn0Gf14eQiSQLHR4bCZ6U6M9uf9UCuXVahKSTAbfVUX6Nt5tw1dzK8uwrRJQ9jFkGzoRpShYjOe7RmJJNnd3uPGDeZK8qf1aTE8qvcpepAMw0teRKGSb2j2kDVAt+EGspHBguRhUyROBDC3aRK7gkXjp5vd8KSqiuDheOy+FX6Lh5vX1FgcZUUkrl1BswUOykhdwH52scCaSoxbMq48O6iOW2Rq3HuUmHREWTgLzSwjhSi7/f57/GtgC3PgQ2YRsWXWBBqSljtPT4eWGC9SZYWHYgwmsxnxojJlnaviFq+fg8aU9OmDC9cn79Vlpz5hWz9rMCmT8hnEB1AfSE7gpg0Pa2SxhU8duwy3g782oZm4QqC8XS0NnMJ/Bu/G2zYiQcMb39Wlkd+mnFBJh7cKd4WVsNYggIvyfn5bYORN4/KMHz3GCNFhMOg/vRUN0VG0hFTgcl3ZcmZ3aw==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(4143699003)(56012099006)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	HYSKs7WSsHM9RBTQradXffNdSY1DkE2a/g7KW5VvgrZjQpG2WXrCG3agHqj0XUee/RWC9Z3krnKwEAqmkyhoAvdKkOmDxqtkaX8CUlp5680XTMw5dulF+2uHmym+wnh9ri4Dji31naY3w80Cl7mUbg3/biJDkaJTAEj9/GkZ/hzz8Zo73uywaK4Dbyl2fpXvk0JRFWJeUL/27cTbP/w6FuHBFM4yuDxEQXA7SQezMqjPyq/amxj3VVLFB8ZpI5Mnn7MLLBbONYl1Ut+qCCDLG1h+TBzp0bZVcHZ6Jls5uOhCLFxr9en7NnYFAFGHbhESTI+0QGi3YGVjE4YU9KcFfxyr7myViQFDdXTieL3XDhD+MBGq7eM9Y8ybeLzCFURcWNbEnrYK8BwJKvQHqh2oldg4OPzlAZeT5ns2nbEyNbnLozCXofaWvYfRCCAH5Voh
X-Exchange-RoutingPolicyChecked:
	rPeBAN7Fq7M3HcUAfKOToSUkJZdO047koBS40NHVaf6AqlCPktnRR3etcFSKSTB0zAQguuvEOryanuW1Auoc2qk9tibd6mZslxbsg2ZQT1OD83bIbbH/DqATS7Ds8QaUAwffTguv58MjIPAe8e24KS0EiIemkEOq3mvNyn/DkwcOOyu607RbiRk51Z7O0gpE0EiB2MtnFe1IQoqJDdd498xI0svWPoGloozrWsZuPfbwUrfrWlkRJGz4quW90X4KRADoQuQFDGhakfiVPaVbLapsbzr4K/oQfp1U9QGhkBTFyHK3Dk/5ZsKHN9B2YJHJLGvbgRqiOqCiTztR0YNhDQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 19:19:11.5960
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7c7e641-6a8a-421e-57c2-08def194196b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6843
X-Proofpoint-GUID: Pa-jk5ToyCR6SngVSHuqJcMEKCns3cNx
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE3MCBTYWx0ZWRfX0p+IzP03uCY+
 zttFvDSpFM0kISQfRQrgmT7unG2OIYlGOkEgtc+sovLm5GRPyhVfe/bV4hSyTp6VLI0inurd5R0
 ZCDOQzO8edLVyvw8klI15e7IU7RHniU=
X-Authority-Analysis: v=2.4 cv=EpniaycA c=1 sm=1 tr=0 ts=6a70e9b7 cx=c_pps
 a=6DSn5gaiYX6F7sdBrIJkYg==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=P-IC7800AAAA:8
 a=sozttTNsAAAA:8 a=Y7SjBM_y-0BIdtrp3LUA:9 a=QEXdDO2ut3YA:10
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: Pa-jk5ToyCR6SngVSHuqJcMEKCns3cNx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE3MCBTYWx0ZWRfX/fx1q8JPXjJB
 Z9iyQQ9oc+2hSxF0/eXVHC+gpjIx4DXTX5Db/LS4+Yngnn3eumr4L5BKtw0OjJnotvJb5Iw11eJ
 c1WvLDZSKdQ6vDdy/uWUAVW2Tn5IgbQls3V1CAhI9azYG3haM4rgn0Y8IbzxDCPR1qIQMhBr/MW
 v6Yo3qbRSIUKKPCj3EYaQoNlTlmX1oslNCwin/s+eiy5B7KoYqDrcKR+VrC/qnxzK+grRRPhV+j
 vLZYqbLf9Gz1T8eQl2mys8ic1LWl1vYQ65AUemvVaUFy0kXp/gCNSt86RUYPlWBVbT5NhbUgMOK
 gIqSavxHYJhMoBppJDWBvrImt1krcY6DpkVYI9EYVngg91BP87kW5FV77tPSg25lswiwsN4q4vB
 3NYhEG0f/fvf7xOMO2vVmhjJHbYCVOA0HMwhJahzo3mWTbSWWwnDZmMmU2acod9SrCN1KDhfb0L
 5ovq0yGOanVY/aup38A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_04,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608030170

Hi Diogo,

On 8/3/2026 8:47 AM, Diogo Ivo (Schneider Electric) wrote:
> The tuning_loop field in struct sdhci_am654_data is only used within
> sdhci_am654_platform_execute_tuning() as a loop counter that is
> initialized to 0 in sdhci_am654_init(). Since it shouldn't persist across
> function calls, otherwise every failure expends its "budget", move it to a
> local variable and remove the struct field along with the now-unnecessary
> initialization.
> 
> Signed-off-by: Diogo Ivo (Schneider Electric) <diogo.ivo@bootlin.com>

Thanks for your patch. Seems logical to me.

Reviewed-by: Judith Mendez <jm@ti.com>

> ---
> Changes in v2:
>   - New patch suggested by Sashiko
> ---
>   drivers/mmc/host/sdhci_am654.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index d235b0aecfdb..35c3efd92112 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -151,7 +151,6 @@ struct sdhci_am654_data {
>   	u32 flags;
>   	u32 quirks;
>   	bool dll_enable;
> -	u32 tuning_loop;
>   
>   #define SDHCI_AM654_QUIRK_FORCE_CDTEST BIT(0)
>   #define SDHCI_AM654_QUIRK_SUPPRESS_V1P8_ENA BIT(1)
> @@ -576,13 +575,14 @@ static int sdhci_am654_platform_execute_tuning(struct sdhci_host *host,
>   	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
>   	unsigned char timing = host->mmc->ios.timing;
>   	struct device *dev = mmc_dev(host->mmc);
> +	unsigned int tuning_loop = 0;
>   	int itapdly;
>   
>   	do {
>   		itapdly = sdhci_am654_do_tuning(host, opcode);
>   		if (itapdly >= 0)
>   			break;
> -	} while (++sdhci_am654->tuning_loop < RETRY_TUNING_MAX);
> +	} while (++tuning_loop < RETRY_TUNING_MAX);
>   
>   	if (itapdly < 0) {
>   		dev_err(dev, "Failed to find itapdly, fail tuning\n");
> @@ -806,9 +806,6 @@ static int sdhci_am654_init(struct sdhci_host *host)
>   	regmap_update_bits(sdhci_am654->base, CTL_CFG_3, TUNINGFORSDR50_MASK,
>   			   TUNINGFORSDR50_MASK);
>   
> -	/* Use to re-execute tuning */
> -	sdhci_am654->tuning_loop = 0;
> -
>   	ret = sdhci_setup_host(host);
>   	if (ret)
>   		return ret;
> 

