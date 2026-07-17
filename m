Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABD6207A20;
	Fri, 17 Jul 2026 20:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784319049; cv=fail; b=OajO7fM7as74FC/t5hJ/6GPQ0WSr05rh6QzZVoWRCs2eQRkJUQhazS/9WAdF3YBnD2knwE20eBNMh4hnUa2BXNhuQTQsW8DyRnkNM9XJsduzv7RhFlxuK0BFUlRj1Z9mYKyn6k7E+Op+IH/6pth6tJKJ6/AvNgkRSceKhzu5pLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784319049; c=relaxed/simple;
	bh=JmsxRIBA10c/AVgQ8dCa45aDb+U6L7i7teKM6E+n4UA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Hd/oqUvqXolvSRSOa3wCdwznlCzqG1Xya/mTaf1J4OM15hwH4x+kCZIDXwZvA/ibjeXer+gtVuxaOG3aF0AY6AMtbKm4hNquvwBmX/k+H2r2GQtbub9KtBw1VePQ8As9685HSWxuUkmSHYT0BgTeIakcKUtj4lwOVL5vDatrmYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=Xngvgcu0; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=EPyrqsat; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="Xngvgcu0";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EPyrqsat"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HK4cHO3373164;
	Fri, 17 Jul 2026 15:10:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=Mqyv4OWqRCTa6V05lm4ydi7DzPMIr78VlUst3Re0Q
	2E=; b=Xngvgcu0LV7Xqh2IbkUHaQiuHj8VajVIpZ4eZ2wd6HAVVJtDAZfi/9mnQ
	WSKGHnZkm7i8PgBicmNGDASsWxxIEuGfCZbRFS9JoXnsj1zpWyvblYd70KIFAqRh
	eDJ/O9U8Z37xXV2moXi2pOV7q8+PhbcB1CNmByJzthHeV6WS3tk3QF1j3gv8d1iN
	pa/eTvLxpkKBOdpQH91m2AehXUnfGWmLnNfVstJnnwOipPIFPZuKvopUEmjIMusE
	eSc1QRGFHv9LlJCFdTI967LrH/CBCQ9kk0CyWd6WwsQsb/O+q0CID+hJ4X9Ajey+
	9Fcyxty9EiOFiYUkJbPA4NsFX/56Q==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012055.outbound.protection.outlook.com [52.101.53.55])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4ff2cd0b2c-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 15:10:42 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l/k5NF4k4Usn55TP3Aann11TehUlinVHtrMis93Nm5iMyypiV0mKq4fiSFACm0ZU45kSgjoIuQOlys0+mYY0b6yjVd4HjW5gZNfMi0HdfyZN+7NSenwdRK2ZwKuYT5/WD34Gg6rOW8bN78NBow1xotjSz0O2STyMWxMav6AqTl/731QD3m/8Koa+GgeIAWjmJZ/htYcAWT6mJG/vXrSWKSXbfC4+KAXrDjKiJFUxbPa0QyKmdHjV+wJhSfKr/wzPh8ikt/DL0MNtMZaw9Ex86LOtYOyODNWwzO142GA+nEyBlGBIwume/EzYK1LZv2yI7+6TFyYX/gQDpES/naSmHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mqyv4OWqRCTa6V05lm4ydi7DzPMIr78VlUst3Re0Q2E=;
 b=Dk6ja06rd5mlmZQdxKOQMFLnrRDbNK30W6UBVVoIbqwcRtMPFftd65fNO7KUc6pLy1rSJS5CstdjaMI+2eREcz8uptq62FqDYV/F9kAnd+iOGEv0pCKhp1Ja6wiEk3uwz0Euz5xcHlp2hnAoSZzwh9E8TaVLpZToEx9XpmhA+YntJ1EVJhWXBYU+qr+8EcwMeskj3YpGaWB+ae1mDc+N/q5H9+HNRc6Cf1C998VaFsC5D8yDST7aMJtlAOKZCY+DRilPajEEdylhG5mpA/aqf+7JXsEPpjBIMOArDuEiNEWhyiOFoL+DxL7rQ2UjhjY5IvIN12ylo833jU2CXaxuXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mqyv4OWqRCTa6V05lm4ydi7DzPMIr78VlUst3Re0Q2E=;
 b=EPyrqsat8JJy5dfG43sO2D1/7IRWd0WQ1Fx0u/EiipKZ0E5K/kFvtPjxsG9jwMv1R+FI2BJWgARSzqtf9tKDIcWm+LGN7HPfDThrp0rgGWra/oMDL2wbzMDfLe6Tm3YqV7KGTTBI318Phbo8cFUbshdwDfovAnvhs2kgUY1Pa4E=
Received: from PH5P222CA0001.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:34b::12)
 by IA4PR10MB8567.namprd10.prod.outlook.com (2603:10b6:208:566::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 20:10:35 +0000
Received: from SA2PEPF000015C7.namprd03.prod.outlook.com
 (2603:10b6:510:34b:cafe::61) by PH5P222CA0001.outlook.office365.com
 (2603:10b6:510:34b::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.13 via Frontend Transport; Fri,
 17 Jul 2026 20:10:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SA2PEPF000015C7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Fri, 17 Jul 2026 20:10:33 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Jul
 2026 15:10:30 -0500
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Jul
 2026 15:10:30 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 17 Jul 2026 15:10:30 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66HKAUmh3963917;
	Fri, 17 Jul 2026 15:10:30 -0500
Message-ID: <937ce2a3-329d-4341-8942-76071265946b@ti.com>
Date: Fri, 17 Jul 2026 15:10:30 -0500
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: mmc: Add post-power-off-delay-ms
 property
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
CC: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260716232641.2659710-1-jm@ti.com>
 <20260716232641.2659710-2-jm@ti.com>
 <CAPx+jO-a3+mv2msL+12Ag-xs33es2+Wxbr_uKRMY3rbN7eL-cw@mail.gmail.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <CAPx+jO-a3+mv2msL+12Ag-xs33es2+Wxbr_uKRMY3rbN7eL-cw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C7:EE_|IA4PR10MB8567:EE_
X-MS-Office365-Filtering-Correlation-Id: 446a9a8e-370b-483f-ba56-08dee43f7585
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|36860700016|82310400026|1800799024|56012099006|10067099003|4143699003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	wLvY5GQtvftlwMQOSDVuMBunU1lCvu0wNTnUCWsE484sZICHR1k2Yq1Klc1QSFCuUpGU+t+WruhgATuOvhQ1oOkaiEP66zSa4rdq0w7/W+JFWEIin3IFMNEIylgdmXwxZIzNPDNPInq3LvjQ14gEIOBuVyIQlZew7UUEj/XZqPVYAyszq8E7+86TIyK6poUqu95FANYwXyIu40OX7g62LEmPFgp85uQp4IzoHKLPTv9PQkcgihussEuIXe8ZZ6JhFb707B2+RgXh6v13dABUaveRq3GowPHREfYy0cYAqlZk2SzlkupSt5Fccy3sIns6a/njY5Ed7tcSL4bOpK5QUr0awcrdIXgBD8gACYfFMhcme1nOaYPJeX9qGLH2COCcEikr9HxDn10FmREus9cEgIp2SjxrHRBvtpr64hraBhKlKI25TvW7Ki0+6NtpzvkcBeeQuwpcZSk0WX809Ij85LJIZPF3U0kwB8ypMsqh0YoFJvmYMaPd4Q6DiXA7mzFJyakv7lydW1Lfb0BWv+QiQayAnW/+IIXa7z6nzOxqaoGKEaWDuUXgnzf4nzZyVeztJUSAAZVzasS0V47iC0WMxOKF/+N4fZ4WxvDnQJK09kX09+mUa7EE2G7XkzSm+T9Q2TtInSBqf8WMhojD6VIJ/603cD5fNJiAm6LetQ71aaZot2VLx/OQlHtCZqw++zJx
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(56012099006)(10067099003)(4143699003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	I5W1IhyPFG7tpNu+QlqN5Hr2N984CCBJHLHM8Uem0TeXdpL0WxDt0MGzIyvfr+rqMwBDKXWOfW9RAO45JX/GWrgSyJNoFOqAAStsmqBCMGh4vOutMTUI+FejA7MzQGTihUABW4CL5kC/gPuY4Wwl+t5serj3hTviJrce21ID9s6s1PlV7ZlxZ3bCc5sk3fS6OHiirfsl3oHLvvzbpAkiXABG/N23ZpZTmDfr+z9KWZXFfsFlBNHH4G5pcm3IL6D6+ihzo9Z7rk4Y90ebh/JZiHX1kTAHQlOF/bfT2c/UgjAeexfRFpSLfrypePhJMa9ujDnEBeYpgFdsrWzYlewlZ0J48ro5hmfUFsHMYBopYYf4eOSi3yQYYcBnkLyvacM0MBEeQ640nmKFfy2nzHFyIt0uiC2Wa9O/tP12HQ/Y1Cd9tQxX3U0NQ3FxIwK1Zsp+
X-Exchange-RoutingPolicyChecked:
	UYNe8/Alyzph5XOWXsOIJr4/eJwSeE92hUw5PZR7faH+vzl3DazEZ/AYMdy7G6WNGYS6cFWvfDO98NLvxoVbDa8sNnWZ7h4MXHIh9uSoRP97NS3VKHpg9aznx0AXUaHvn3IwXypued4TUU9m/iN0eQ7O6i+8YYXYBFw7uWiq2MmnOn/1KETPHHlAaZ+7590eOZHYEU4kjgkdm5JJ3anRwT+vJqIZD4t0PjqE1QGC9UaVfqiUoGcw/Kte+LFLgCZv/KXHYrc8dUt2wgypMFEAXP/1s4PvS72aC00FWd253anboYZ/qNIr8knzOwPW+EF5GyBHZuuBnymkb9x7ReF5gg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 20:10:33.8254
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 446a9a8e-370b-483f-ba56-08dee43f7585
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8567
X-Authority-Analysis: v=2.4 cv=NtvhtcdJ c=1 sm=1 tr=0 ts=6a5a8c42 cx=c_pps
 a=ffjDj9JMBHEDizK9ymob3w==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8 a=AHXOreY6v0qJajSZz38A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: GEOC7uMDp5qG-ixaq6bj43ANEJF2imwp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDIwNyBTYWx0ZWRfX58MzKjPD3eQk
 c4V0+A8eP1ep2qfKBxhS7n83wlUd61cRUG/cyHM8AueXYD1Coa/AUAt2Een22MAMWCTTDeHp9xo
 CrQXOa6NNE634utTgX+7CA2ijycf8vJhIohmRG6IBJkhUImYz32mGwBy/ahZxrrUVEjA7A1Hsk/
 1wbIqWqh58vo35qLu/+xvGoDSmsbGhyW+hdO+qiRhvqR4VJHhHYJRFqca1L+WTDZVtpDNa++LKS
 XtjNPPOFgWA5gcSsHWWO3IEuLISIYT8TOwCNrko1jhVeg6+WSbbjPSw5vdqNr2ygThmSqQWynbl
 y4pSEirv84aiUkkNbnIdy8EF/eriWlBA2jP80wRbZBQuqzgIW02+NPj+mwcNfVOb+lTl8gW2O27
 sO7WEFL4kzOVGFJ78adYJolTuD0r+2jCSQf+xz1bGFlEhM6eLZJv0RpE85s9o6aMsAPCfVxt/N9
 C8QpSQWdPC3aEVTKNsQ==
X-Proofpoint-GUID: GEOC7uMDp5qG-ixaq6bj43ANEJF2imwp
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDIwNyBTYWx0ZWRfX4V2gymPEszE+
 xbBwLzKpjPznkRzimCkX6AgJYgB7Poxg2JlZNllkR2Sk/hUgqFjGsWREZ8U+QHugfwt+ZQw7zcV
 p2s6me7Pm6pez+K+iAsXjesCR5mJErQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_06,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170207

Hi Ulf,

On 7/17/26 5:21 AM, Ulf Hansson wrote:
> On Fri, Jul 17, 2026 at 1:26 AM Judith Mendez <jm@ti.com> wrote:
>>
>> Add post-power-off-delay-ms property to MMC controller common.
>>
>> This property shall be used to specify delay if needed after
>> deasserting power during MMC power cycles.
> 
> Please clarify with some additional information from the cover-letter,
> like "specify custom delays after MMC power off to work around
> hardware issues such as slow RC circuites on MMC VDD rails."
> 
>>
>> Signed-off-by: Judith Mendez <jm@ti.com>
>> ---
>>   .../devicetree/bindings/mmc/mmc-controller-common.yaml    | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
>> index 3d7195e9461c3..3ff68d32a308f 100644
>> --- a/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
>> +++ b/Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
>> @@ -275,6 +275,14 @@ properties:
>>         not available.
>>       default: 10
>>
>> +  post-power-off-delay-ms:
> 
> For mmc-pwrseq-simple we already have "power-off-delay-us", perhaps
> better to re-use that name instead.
> 
>> +    description:
>> +      The presence of this property indicates that the card requires a
>> +      delay (in milliseconds) after power off before the next power on.
> 
> Again, maybe something to indicate this is specific like "specify
> custom delays after MMC power off to work around
> hardware issues such as slow RC circuites on MMC VDD rails."
> 
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    minimum: 0
>> +    maximum: 10000
> 
> Are the above limits needed at all?

I would like to keep the limits from minimum 1ms to 10000ms just because
likely someone will go ahead and add a huge delay and wonder why their
board just crashed. I think 10000ms or 10s is large enough, what do you
think?

...
