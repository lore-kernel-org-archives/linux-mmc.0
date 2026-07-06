Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273D8298CA3
	for <linux-mmc@vger.kernel.org>; Mon,  6 Jul 2026 14:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783347906; cv=fail; b=GA3WLCjUSfFEWclmR6spshLmtUyRpcJQrnRXRGuzgpfQcngQzgd+VpTr45nUlwIemOE5qMwiGGbU91vZJfw8eMY7kmnOr0iqiAwItvcGmtZbGmQFBPGcTq7WiimiMGbSsFVwP5lFSTFI8xQ0ugAMN9g1+19XxFtEcfDPJB3HZi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783347906; c=relaxed/simple;
	bh=SaY9g3CbkKPXk5kd+sBh7/1xe38hagnpgZNLsBTFQ+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LdiJ1H0Up5Ysd74S2ZNgJXPvhPy26gd0TgcHRNx1aIAxdzVtraGBsjnqqHig1d/K5zW8U0+Z0PPpgZm1RqxC3qeqoOxDPq0QpMZiMOLAZse2xBYwLdhJ42fEtivJ8ULeNW4ju7Yw3+TAJ7USzlhzyB5qgPFqvtkynJToCpRaeFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=QcF9ZL2S; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=trkB/bEi; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="QcF9ZL2S";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="trkB/bEi"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666EFmVb948183;
	Mon, 6 Jul 2026 09:24:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=LtF2qBbUUtyWm6+Jsfu7fuym6C8f7hNnkL6nmSq+W
	lQ=; b=QcF9ZL2SoxL2o/8ckp4bn1u85EK+wvdtzLqwz8tZ2DzDwV/V848EbzPDy
	mS7zZioPRaK5uaqGVLBcnlVJD8SFbytL51WviLQuCykvH0/863Dgs3XNH40s3rCT
	WV8iFvdotLxbqSoyHBKaUo+MMofeJehhI5BdDgqsV5HoIbNPi34prwehZd4s8p+z
	27d8LmiKi1ns9LnerFS5FrNPN+237DWkBIevAOw9rRPl6DceEQOb3h+ko2GR4VmP
	SgA3Ki67Z/flzCpglbXHYjpThPJDRPjRMmA2enPNE0XE9HqeCm1GJ/FBHVxPHqeL
	vv1s3XFGxHhVBue2XK2kqxgrkcZrg==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010000.outbound.protection.outlook.com [40.93.198.0])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4f8bafs43a-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 09:24:58 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RIWG2xdWvZT1gS7/y67G7wouXc6LaZkAiFVuQP5J6IfKxCnDmnObmlXpthZ5fp41+Q/EeA1+u6YkrrjI/6HITsa1Y9jhcoABwizTsD2P8GHVT/v8yWhb4dIV8tEl9vgt+pnLKWFhrVkl3Iy2jl8hSTSyZTfR3Hz8XIgQ26ODS9KOmfCzXBbFwOEXy9nYQZqS1mjJZsCU3pGCH4/ly8uLpcV2eJEXK/MaCLKGg50iqp9vadZDrUoy7+cau67MMbmkH3bhEz7Fa7qjoi4oeCDydcuO2UkQ8urjtvfe8azMMuW0eww6/HIAGU6l32yhcNrGV1S1CEw1xenTkfpvzgdiOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LtF2qBbUUtyWm6+Jsfu7fuym6C8f7hNnkL6nmSq+WlQ=;
 b=SpxRb5wPnIWfwxW0x3lg+ib3J941lQju+bSjVigs3slfHaeevq1b2gtOhsdRNZwnyvWKbfI/ksuoCno8T8OyyzbFCRXdtkdProa4tpHQoIeIvkAagBp/W7ODJ6PwWmLVWVKiXaIT+1pjfIHdcen4/4SfZhYMtfCS1LeXflTkFEZpub9FRiQPQBLLcgIpHEqliyaUbS/40Uv0yE+xLQ+RLeopNeqHnXlqP22oCZHdJSRwoIL0bNHVP29uDIIYxSzcEWYkxfpAOUyn9CPphZ+lOZq8r4HQpFbVSFh2MhSibRTsLZrkId1/UWoNyGPxqp7Zsys/eJUcX1SS9QJx3QPJPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LtF2qBbUUtyWm6+Jsfu7fuym6C8f7hNnkL6nmSq+WlQ=;
 b=trkB/bEi+GAJ2kqaG8mVE+cE36xyu+1kJrk1Ch8y3zRdybG8h6ddzCz93EoTGAbeSVIc+rKw7/UatgRbcPiBUa6H4lfLUIkemdHCYf7DdiInJAyPv8ogV345pXh9HH7GOdi/fDVN2mTPGbFS4FX+EnfbdauUQZ0HIbskh8hp2K4=
Received: from SJ0PR05CA0069.namprd05.prod.outlook.com (2603:10b6:a03:332::14)
 by PH7PR10MB6578.namprd10.prod.outlook.com (2603:10b6:510:205::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 14:24:50 +0000
Received: from SJ1PEPF000023D1.namprd02.prod.outlook.com
 (2603:10b6:a03:332:cafe::89) by SJ0PR05CA0069.outlook.office365.com
 (2603:10b6:a03:332::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.3 via Frontend Transport; Mon, 6
 Jul 2026 14:24:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF000023D1.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 6 Jul 2026 14:24:48 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 6 Jul
 2026 09:24:19 -0500
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 6 Jul
 2026 09:24:19 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 6 Jul 2026 09:24:19 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 666EOJF02100890;
	Mon, 6 Jul 2026 09:24:19 -0500
Message-ID: <9c090582-43c9-4008-934a-c50e61183ed7@ti.com>
Date: Mon, 6 Jul 2026 09:24:19 -0500
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add myself to maintain TI AM654 SDHCI host
 drver
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>
CC: <linux-mmc@vger.kernel.org>, Moteen Shah <m-shah@ti.com>
References: <20260618220209.211875-1-jm@ti.com>
 <60f3ff8d-3754-4aaf-90ff-a886ffb84ded@intel.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <60f3ff8d-3754-4aaf-90ff-a886ffb84ded@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D1:EE_|PH7PR10MB6578:EE_
X-MS-Office365-Filtering-Correlation-Id: e94c931a-f0ab-41f5-d89f-08dedb6a55c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|23010399003|22082099003|18002099003|13003099007|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	41MhkWn8dbV5EwICsf7Zc2dZXyj4z6EZER5ENjU0p9Kx/MkDHOs78tsmASZIUmZxGQ7/7XBVYgPcrwBLekBZTLhfVs7RRIr79G6Mvdfo6YtLBsCaeJprq29IgmD3Ad1DOwO+JYicFCuRCbZhDhXF+2DLeZvuMVFbAJ2y62/cI/pbNxx732P9DkBUF4rwisGOH3XRvflAZJMbXkBEWVXLyIt+FGhHisfCZgeTGlzqq15nFDur/86F5aG3TaRMonnZTqZAxNeeh9rjVQyhD/V5mWFA71+TBKWKwOTG1FcsVLImazIpoTOJ4wlEn6NIjHR0FEJrnCGk6rdmZAKN9Ir2SF6/Xi96p/OqwUcGyObXWiCOIhrFrBjfQ0X/EizovszDF/yXSow97UCq5ujU7LLRMafnwhjXsx2ILkbhTvFxWQbjCMA4C9XhoGEyu28ZljFohooMOlLDPPyJ/4/sEwHTbl/2s4aHLlFH67uQrD3lJ30gx6L+jzTx7uKN/N/pZHjJYfkklFLznTamHiyMOU6u4nDOZXsj3iRLF9DhbHKBL+G52/CndPQ9tkdHcO9eUkb50Mhd6WI0oT0+fkdY3Dt7yg5XZVioKRa2jMSDC/8152mv+yf6hjHc6QU9aXIYvwNx9nD8y6GbyYxLxf//e1uwyJWKh5BGu8vWmyLi5yD8ZtiOcOtSERvnpySo9w3B/OVeIvM3jZah0t45lIIJJNVRFA==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(13003099007)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NEnqxTISmt1b1ir1uRWEVKnS0BagLILl+RS/ljz0WvaxQvSoC9g4uzUm3QuJW+KU7odpxlL5VDsRVJXYTu1uG8TdWsMb3AtLKXvsnoRv66AXm7VMzyFH9s4zLh8VpPmfuUQW3YW//0iZfT9GSKyxMbiuqQSVIgZJIgfCvJdkvnuAkOeQPLsiNoyNVLWj+BuFSZUcO++qVmiDZtNKCEzwzqaRB/mA4DXxabrOYUoL2U5Z3hpGiRcEzBEw1keWN5nII5jP8jLgLACr9FELFH/NKitisBezZbXwmMQaPOShRSdM4ICywn/e5XWfBTNUc3uhNQrnrYW5PTZ6UnQ9+RuhcfHMr0jefERUYtnIxpIbwoBGsuSp/x8QW6O2AQcH/Pajvn6khJ0BlsSt0e+LSP81sU3Ctm50558cUf9zYclMF72KhU/SvLkYpx74+43kLs9Q
X-Exchange-RoutingPolicyChecked:
	NmlOUTkIVB2XoiEbGlAhnrdBuu5/5WxrbVAMutkDzjPZayMrpNjQDs9orNhgPpcPXjE/MAmkN3ICmUSp57bZ9Y0IVEvl4ytCRoZOYaOgwNuVEMvNSf1eHP9gk8cIaNCL3cJ4S0hUseREOQRaHeNsiT/9tgivGI8OJRQOfrIGD5qCOwJVYpdboDkObywV8baO8vlkmiSaDpfwR+SbTBqTAHFNjIXEmcoXMI8P5u7WDQB4G9q1dFTNfCsjPLGX3yECIVwmCzmhX+aZlks2JLeRVatkXWvcF9M3Zq46bSUufPtuZjp3+H+l7f3U22KVrmD7wATQgQE6/0N/JZleqJHNlw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 14:24:48.4121
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e94c931a-f0ab-41f5-d89f-08dedb6a55c4
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6578
X-Authority-Analysis: v=2.4 cv=Edf4hvmC c=1 sm=1 tr=0 ts=6a4bbaba cx=c_pps
 a=1KNXh0H2uH8UbroYoe6UKA==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=xq3W2uTSAAAA:8 a=sozttTNsAAAA:8 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=pGLkceISAAAA:8 a=6Tdb4O0--z6LR3nFcqoA:9 a=QEXdDO2ut3YA:10
 a=P5L7wpMTXyg1GfFA3Gwx:22
X-Proofpoint-GUID: AjISbu0SlqAIXgjVKtK6Q4lDGasGBVSF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE0NiBTYWx0ZWRfXwl+Szig1YFlc
 bPADoj+PYuZAZu6lLIWMwM7gNwBr1utfY6irl/uogZW4hfA3WCaWIvtd5SsGqwxVa92512mvPWd
 B1dvI8k5G/zQOaHSgQF2t/ZG3K6ybfH0xVZRx/mbHQUceSoXJel+GfLw0WetGHJDkHZG12Yyx+8
 ptbcBNqLHRbElj2dYWwE+AqYxq5secANxlEZiOs1gmviL73rTWSF7TK+2MnKUUvG196ZIun5mJJ
 P9QXp30pxYLb3SwBFzjf5FXy4oXqGENfTiMMxSAL3tQQhtymKeTDkfvZa8CHG/tzXG2CoPWwC4S
 1vRnRE6PNQgOyQ81bRybvMmei/BArCkOZxbkpqvyQp0D+XFplc7Cg/bX3T81SWspS90gASKhL31
 MMYK+jFEzKSPrWuXAp/5oxxAsTQ8hHwQc4uEXYfA1bH71Gya3GjQ31vi88+BF7o7H1RFxejTgPM
 cmr2o13KBG+mVf2G/vQ==
X-Proofpoint-ORIG-GUID: AjISbu0SlqAIXgjVKtK6Q4lDGasGBVSF
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE0NiBTYWx0ZWRfXyZ/ErVz4WRmT
 SNpG6TlFXvW+cyQB8ukmVcIJBzBQkUIrw0AGFWE2PHRg/4/YX9SGABWa17LOL0ZmyDzT5YLPJa9
 /AISj1m3/OajeV6e0Hf5PC49ReZM68M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 bulkscore=0 clxscore=1011 impostorscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060146

Hi Adrian,

On 7/3/26 11:50 AM, Adrian Hunter wrote:
> On 19/06/2026 01:02, Judith Mendez wrote:
>> Since actively working on TI AM654 SDHCI driver, adding myself
>> as a maintainer of this driver.
>>
>> Signed-off-by: Judith Mendez <jm@ti.com>
>> ---
>>   MAINTAINERS | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index b2040011a3865..97b9b01275729 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -26640,6 +26640,13 @@ Q:	http://patchwork.linuxtv.org/project/linux-media/list/
>>   T:	git git://linuxtv.org/mhadli/v4l-dvb-davinci_devices.git
>>   F:	drivers/media/platform/ti/am437x/
>>   
>> +TI AM654 SDHCI DRIVER
>> +M:	Judith Mendez <jm@ti.com>
>> +L:	linux-mmc@vger.kernel.org
>> +S:	Maintained
> 
> Should probably be "Supported" rather than "Maintained" ?

Sure. can fix and respin, thanks for reviewing!

> 
> Otherwise:
> 
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> 
>> +F:	Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
>> +F:	drivers/mmc/host/sdhci_am654.c
>> +
>>   TI BANDGAP AND THERMAL DRIVER
>>   M:	Eduardo Valentin <edubezval@gmail.com>
>>   M:	Keerthy <j-keerthy@ti.com>
> 

