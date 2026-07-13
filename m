Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26651271A71
	for <linux-mmc@vger.kernel.org>; Mon, 13 Jul 2026 12:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783946254; cv=fail; b=kZ1jfZRFRipQKACg5pl56QZV65UWsbLQ5pGLlJ0/MhTOvYv2I+4n9ZER0+lYNedtCYp7teQDRGGroWLEzh6CB7HYWyq2iqCaS1jMjOcs31gpfHNjfCisiWz7mZ5gCfDWi2IJJMnJuVNcGkDiJhQTl3KWApLx1FmD97PTG6K1mnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783946254; c=relaxed/simple;
	bh=5MwmV7Vod1xz4sGjtMLiA8rfd3vfN3vGq90m2Y9dI+E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QDC6eau7HMA0O5jrSBcw16OgZUUN0OOE8DUKJaMP6aSzD2o9fRDcC2DVPA6K4QA41pn25sTr0vB2GLnKDJGLPN8UhpYr/1rgiK+Pev7wnDAlKL1Lc0XcqtPOLzAWCigLrV3XOynZkwveemv0dqcKNiQNZcupF+/zIHvKZUuGS24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=sKeImSCq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Gw52L7pi; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sKeImSCq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Gw52L7pi"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DC8wXq1379961;
	Mon, 13 Jul 2026 12:37:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=8gJYveKHvttF2TjOtbjblBkCm14Pok2YHWEkNY2cBj0=; b=
	sKeImSCq1LvjadGSpicIo8dfyDlwpk2wDq4+uNOcjMAtFfYpo0R64ZnGThkm11W6
	xBzFlBHrOlHdbUBn1vH9AsdQOGl/IYY/ubzAHtOkvTSnCxTSJJLm8HK3hmus5Kta
	GDyPAYaWSCuqFLUDA0slrxRN8dbu+PZtgFNwUSCfNGJ8vgGsz36aLw8IMr32Ei5U
	czJU+Bf6+oDXuF+17lqPYxQuxX1NBf4ncFXqHyCO+xMPUHlsuzWcwhWuKQnG3eO4
	nP0jfV6mPkKEQP8JZK0AagBUoo34fcyRubhL5u/09rAiRIJA7c9eDNi0YdtCwMYW
	o9c6g5q5sE7ye05OHeWE/Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fbed82301-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 12:37:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66DCWvxP020501;
	Mon, 13 Jul 2026 12:37:19 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013027.outbound.protection.outlook.com [40.93.196.27])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4fbc9d0ckj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 12:37:19 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EV4vlWYOx4CXCM5bq/nFGWLiO31hOJmqpKZEUwhzYqx4yF395B8BoiXgQiGaaYFtyTWfNW/v7qHYCbtz/kcYAZcjMen+NQz8Nn/YVeyR6Q/NJbQMOjdChuwUovULfB9g20sVifIB6esQmDyX5ak49cTnxJtudAIyVmOJ1Dz6/mNXhqK4KPCab9VrpaVvnsKtxkSryVwRl0czCZ3DFKTfKxwnU9wdwwiTU0AW9+Fy0oR/UI3X8H8/HAV/mCzeoV8XyC4Q+ynojnV1pldutxDxu7g3vMNS+EW+VH7oBimJCWxcDWkcRubr7/q59dMd6Y/eRD4PeyD2FaxJKvRNLNSGLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8gJYveKHvttF2TjOtbjblBkCm14Pok2YHWEkNY2cBj0=;
 b=NIYsQGlolcDcURydIdfhtUYTSGldJZnRTEQbj+6cgEdBIdqL+oWC55jBsz3/Dk4x55+j5MItPhzlgfFSFFcKHYryHSWVTX47CrmQy4E/gAi7M40jbvlIPnssP2XVtIgvm9SZxBavdPzTVjsohieJWHVYuTfAbsvIEJ8iBhEbcSfmf38kI4S1PiysbbNdFmbr+T+HlfduepeyjYYHDYrdUCZJ0Omk6A0hyCuob9UXLA4puvC54d/oOeRF1XsH71NU5d5HFab/dtqIsc39sRV1HY9BlA/2+j4AmrlzfqEFdhz1i9I8vrxwg4VA7hBkneOrvHwWek0GEmHqhfp15zYucw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8gJYveKHvttF2TjOtbjblBkCm14Pok2YHWEkNY2cBj0=;
 b=Gw52L7pig9OILJBDey+cmUcO8aZTCJTV2k59R9ezW69Wumk7DqEsK0b96oH6yPxjQSUzkEpxtpy1FzcK3Cc+L/3PE0d3eno2Wl0e3NwL+UrGfYZwdImJ6oxrXCvZZ/M7+djgoCz87JDoKaoi+/BU3vyg1lQjz6/l7wcy7pxrIPM=
Received: from DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12) by
 CH3PR10MB7188.namprd10.prod.outlook.com (2603:10b6:610:121::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Mon, 13 Jul
 2026 12:37:13 +0000
Received: from DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d]) by DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d%6]) with mapi id 15.21.0202.018; Mon, 13 Jul 2026
 12:37:13 +0000
Message-ID: <2d1de9f0-c351-45cc-8b49-37780ab94106@oracle.com>
Date: Mon, 13 Jul 2026 13:37:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: bcm2835: DMA mapping improvements
To: Robin Murphy <robin.murphy@arm.com>,
        Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: ulfh@kernel.org, florian.fainelli@broadcom.com, rjui@broadcom.com,
        sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        linux-mmc@vger.kernel.org, hch@lst.de, martin.petersen@oracle.com,
        linux-rpi-kernel@lists.infradead.org
References: <20260706073913.538598-1-john.g.garry@oracle.com>
 <CAPx+jO8KJLdpb-H_MGzbOuQA-4mMi0r03Ba-EvLCfG8Q0sk5tA@mail.gmail.com>
 <ba056712-027b-4996-9b15-8f70d630ff2c@arm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ba056712-027b-4996-9b15-8f70d630ff2c@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0049.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::18) To PH7PR10MB6228.namprd10.prod.outlook.com
 (2603:10b6:510:213::11)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6229:EE_|CH3PR10MB7188:EE_
X-MS-Office365-Filtering-Correlation-Id: 367995d6-d715-4930-cd54-08dee0db762b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|23010399003|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	MEA2zLtCL0E1h8/SPUUra7OWwhwKnZ1alSNR6fdmHOBWI13RYC8NvigUDw5lHCMjR3rV6/WUlRBmZk/aEGDRJB+EX72CmQ6gNOjOmMwp+VoE7M1hHU6IlCMWt11ig0YfpZGh+o8+1zNpu43QPC80ogiTZ0Q8LNBC5ixr1RWR978PStyOSwR/bRsYSuEKRyN4Ra3LmGfG3uxnAP6Ppxh2eOMTqpCtMO0Ox+MP83THnJBN+uLzTR6ZbG0txmk+SsWxYCWpBm5+rrvFxL7eTKGCNo3so5+H/AFeSU8iVd5Or7QhPmVcFlfmya/9pgFU6RM/ZPSONGSe0XBc9twC4uYvZLO/PPTjIhKNx6UBIhXZhvTfX5KeVHVsOFRgTpNmWS2dEf6D59FIwJj7hEebmC8JvuMxR6o/Z0wcri2f8cCvIl3N9N75Zej6OdkFdeOZZacBiLXu0YoQ1DH/7qMZZ+5O5GI8OMaf0kz7BwIzv4zvEwH1GW5rhgfJ4yfZ1/b72jhFfPUVh4lBItTkDVS9DjLbOF5PrwTzma2CynJ4kIqbYuDhNab6I8r302sFU+aG6WInBm6NWGgbeuViv/3XU5OEt3UXmBIbziJR+W/TYrY4FxrWmRXrBPDB7pzTTd/yJBidlF25KkWwR2onpvWmw43kT5b1zt1k/M1WE6XXNl+6+vA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a3NubVFCcThSTy9SaU4xVFBnNGxzM3ZYRzN0WHRIa3hmb1Z6emk5Tk5nQzFM?=
 =?utf-8?B?YmE3YkJWV1JBbHVGQmZPRFFrZ0pvYURiMmRLRllFTzdCMExxQ041dVZnZitD?=
 =?utf-8?B?VU9KZFBxVHR3WHliMG52RDJZd0NCTTJZd0xKYXBxNDB2ZXozb3BpKy9SOC9U?=
 =?utf-8?B?dER0blladnNBYlF4WGNHaG1qUGhNM1J5dUdtWTVxQjh4aTJGM2xaaXJTeW4r?=
 =?utf-8?B?N0IvaVQxRCtQVXJTZHdiTDJzbURFYW9rbHZObzRSbjA5QXZ1U09lMzkyVlA4?=
 =?utf-8?B?OGlnYXM5WTN1aGZkNm4yekxnSTZoSlcwRGlRRjgyQnZMK214ZU5OMkRFblJZ?=
 =?utf-8?B?TDd5SHVwUFF6aWJUem5rcUZYR1RrUktpTkdZZVhUa1FpVUlJMUhjdFQ4Qll0?=
 =?utf-8?B?bUpkcU10dVBsVmRCNjg3eFVnZS9XV1NnRktwNmVxYjdyUVBjam9CcDZET05w?=
 =?utf-8?B?dit0QzJkSEdDNzhnbCtwUVMvNUVlQmdqTlFGYUMzNWJrVG11M0VFT2ZFZVZW?=
 =?utf-8?B?QmFlMzlORUJtdHZUTVRIS1JQNUFpNTVWOEU1Sy9adm50OW5wYzhXTENteGZB?=
 =?utf-8?B?cXJtZVZ0MElXZWthZDk0OHk3MzRHQTgvbHFWZkNaNElxdjFwbzIvVkFDVDJa?=
 =?utf-8?B?bWhOUmV0eERUbDJwQTBtbTU3TzRiZkI3NmppWG95YkJ6eU82MElyS2Q3ODF4?=
 =?utf-8?B?dktmVTAza01Sc2RPMHhOOVVERUxqZkt3M0hSd2M3eUE3R1pzQW5GVkdtcWNm?=
 =?utf-8?B?cC9URDBLYklWZlNMemsvN3pwK0o4UW52T1U2Y0lHYURTNmkyYTlmWWdZbmt2?=
 =?utf-8?B?Zkp2WWNPZmcxRDczSEs5ZUVidEowbjFRcnJ5OEVvQnZPREVwQU9XMGRpdmNt?=
 =?utf-8?B?S2hEZ1orSzhUQWJsTTgrV2pMMVZORUg5aGx2MS8zbU8zSm55Vi9jVXU3QjRI?=
 =?utf-8?B?RUVlcVIrNlNNY21kcGt6QWJpR1VFTlZnTTQ1cjlmWlpIWUVEMkY5Y2JDSHdV?=
 =?utf-8?B?YU9HL0Fja0VPUk5IQ2NBYy9GUmpnVTJZaDU3dXQ4Q1pZOUR6S0YvbFJxMXRJ?=
 =?utf-8?B?TXlPTWxrY2dJK3dEQVhNWnNtUUhzY3E2b244VUFmNW9ib0xMSUkyczI4SmlI?=
 =?utf-8?B?bytqTjZITEVsczJ4SkZxdTdlWDB2MzFzSGQvQk5LcTZkaE9BelY2Z3hUcG9p?=
 =?utf-8?B?b01QeU0xb3pYV2xUNWNRakZvTnYrUVZPL0hxVEVvK0lQUkV1b2dhekFKdnFq?=
 =?utf-8?B?bmlZWXVpemhFdXUveDRJdXJma2dNSStCVG9yVHkrMnFPUTV3NWFWSDdKY0NE?=
 =?utf-8?B?b2RPakE5Lzg3TzF6bHRTVG1YeE9rTk5lV3NVMlFnOVZHejZhWFJSbnFOcHA0?=
 =?utf-8?B?bGVrTlhpYWVNalNyTXA1TUV1MVNNeG51SGY5enM1SGIvb0FMTmlva3hkZ0Vy?=
 =?utf-8?B?SFoybXp4dFp0NzZrQ2k5cDVRRzFUYzRjZi9XZC8wdW5ZUTNtaVdCTklLMVZ4?=
 =?utf-8?B?ZUcrYTYvMVZ6NDZGQmZ4bU1sNWdpc2JjbDdOSitRaEVNTU5XTUwxY0NTVlF3?=
 =?utf-8?B?TUJ2WXRVOUhxVStNeDhwa0puRVg5VUdzSGgxN2prd055RHZnUGZNdmFJdmR0?=
 =?utf-8?B?WTB3MVdaNUlkdnZZbm5zV3ZVaVlVcEFCWWZPcG5sMzAzMC9mdFNOeWtSUGJw?=
 =?utf-8?B?QS9BWGJkK2VJSkVzWUhxTFdxbGlFZFRYZVFtbnk5TGUrRkk5NFVDVitTcENm?=
 =?utf-8?B?SURxVElZM2pSV1RBTDJCRnBZTStCRG90NEtONHJySHhBYzJTaVpoNWg0MzI2?=
 =?utf-8?B?ZkxTenVHdWwrYVJsQlN5YVNQZXNZN2ZJUVhNK2xWQWRMOGFweDFnaVFUdExt?=
 =?utf-8?B?Z2pYNncvY3dqeGVSLzVyc0Fma3FTUVE5eG1XUmN4c0xRUUtKT09PRDVVYWpx?=
 =?utf-8?B?bit6RHl3ZU5BcDNvamw1R3I3Z3p5WEhEM3B5MmNUL3FscHd5OVVpL1ZFT1dy?=
 =?utf-8?B?cWtOZGphUGF0eCs1Mmk5dlBNSUJtS1NJQXNwVzc1U0wxMlpGL0ZkdTNtZnBM?=
 =?utf-8?B?WUZ5NUJxa3RWUFZhY1pWc0NsZ1dDVlJUeUhsQXQzS1dwZ1loTkI5YmpITng4?=
 =?utf-8?B?Q3pKb3NEZUdEaFRXYUVJdkNIMDFmeGtYdlZEVFAwbFduQWhLY3ljRUV3MTUz?=
 =?utf-8?B?eVdkTjdrazZZYXExTzJnbmlSWEtkVURiR2JSNWNwZDhWRHZMR2Y2YjZ0VkJh?=
 =?utf-8?B?U0JCSHFTeDk1ZDJUMUZKZzl0MitNN2xMQzRYbkVQK29la3kzWXNWTkJNWjN3?=
 =?utf-8?B?QlpyWDRFcnhrVVpaQ3MxYXMwRktXZ0x1NDlJaG1GMUxYdnJoTFJoWXdHakxQ?=
 =?utf-8?Q?aR7NOvyiq50QsAyA=3D?=
X-Exchange-RoutingPolicyChecked:
	ph2uxk/M3s+ktW9Lts4MtnWhb0X0T0528oU5RzxbJrDM8HrndYCZeBDl5w7ZhXFaur9nrvfjY1k2jQixLndlyyyteDfmaBzQRO38e0wGJw/yesBFAoKs3vIPN3cizqTt7j1594F/9wvrnmGaBnvRH35cmXHVej5QecHp+apHuFZJ+xfT62u96kBxHLN1ygKK4Nv2T7KXtjumjHM4rZMhkE2lgFdewrf5f7nRQIKAuNe6S+WvK0awmq9dvwGaY32heseZRvgW9ICEw8IalXTGs6tN2X+WfWq8dgXEOB2V5ho7Z4FoxuMBnELVIKHWGmwc7mxNSYF+w9qo9tfiSTVTog==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aWk2Fp7k9QQ/ykePx0Zg/YenCADikMoIq8kbXHi27vRz07RHBV39S2vSfHudx1R8SV+Y2XsD0SFDinT52K0aTmqf1yc/aCDYzixtTv0Iro9riiOmv1L6JnA2bFtz4Hv4kdUpWvx6LBIoLQPLkqYGZigoQc3zNKfPjBH39OhvDoKDHxCV/W/dGc4vegpq1tN8n9xBUQmwY+ot8Oso70FgKKtkH9aApGOTH6OibdvxViCvGcM/pQZfzr9IXERIutPpYzLyuaFttViUrIR54uOMORoVp4az3ZW66XZfLAvLP4ljFCSVDDKlS8quBRwsHJ0bZ+Ownsj+rqPuHcJr8gyT7HNBPNC1OC+Nbj+cyecbXIB94xuvqM3SM8FiWZbNUfjNzRIJivoQPLRvhMEJz3ZNBqIn5EgDscJzbRJOZaBt6tvY5mt+Eq3S7DIE1IPan13oHp3h10yRHefhf0piU2mwhcJj6PbQK8TzyWGi5k0XOpeS/OToVrkegwvzOdaL+/nz/sJZmrCOpUq5rs6sLuD/yH3XEdg29+RCXDWqrRzrZbHnuqSl/fHAUm1xOCHBcFk+Sjf5XB6KbPLE3XCSOArMEHPHXfkEkksJVgODzEK6ujs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 367995d6-d715-4930-cd54-08dee0db762b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB6228.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 12:37:13.1880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1UZrsRc6HzYhKc6pnw1ouoVIXghswHEXyNKO3ritmqlJVXHi+n8S0DEUmoLIFb3aTmD7BnsixP5/rKY1vH3qLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7188
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607130131
X-Proofpoint-GUID: 3278Tr_RidNTYzYxbptXyPSB1KEPF1bP
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDEzMiBTYWx0ZWRfXy8iYgWTiT0eV
 WbrRUsFtseLNG5nuzU7pB5ZvdZWgzDOU0gQEH39V8pPZkLtHP9+bXafRg5EyI7tUw9hFYTR4N7A
 CXps/18exnNRGbsqRZs3hlr+NIJmlKwpLQZPqz7WANqor2cPd98t
X-Authority-Analysis: v=2.4 cv=JKALdcKb c=1 sm=1 tr=0 ts=6a54dc00 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22 a=Cb6DdAEkG4z7Kls98fcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 3278Tr_RidNTYzYxbptXyPSB1KEPF1bP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDEzMiBTYWx0ZWRfX1lfT73/c+wMW
 ylqFoccSebwsqdTZmjB5salOF2+qGw262QCRxeeL4cS7nTve6UvMV5Wo5r3FTa0jhM+YLWPKPlh
 4NhHqSnS/x2XZkSu1vrC36p9o4j6mTeePrvOMaX16JJQczGvX1wpRBwcCchhL+HR/EQ3v0v5oIl
 IEdXe0EaNTIhO5SrfCXqZw/laXxhYro7jwN67gjU7cgeJRdm8QnNN1Whas8I4VGaF4agiwCCChz
 M4U/K+ADBp333S6M0Zo5yzS4wAv5spIQwQ6a3+OGuCVogpk8BY3QyrNLrIVWH/mIgjsTZ2cYbDt
 Vht7Bp5pBq4c9+kK6hOrNTkSRM9AgXhWwQ2SawshQvYsBcqV9AGVtMrz2TJgjvRFFnKDld6t2bj
 OtvYQrAaWN4s4OemIjIXmIQJu3GL52fODwKQozjPaDoFctrM+kspuEMhnNtBD+BE8HqbANxV5Md
 hjzQd8xy6ysB4+6YKvw==

On 13/07/2026 13:19, Robin Murphy wrote:
> On 13/07/2026 12:25 pm, Ulf Hansson wrote:
> [...]
>>> @@ -1281,10 +1279,8 @@ static int bcm2835_add_host(struct 
>>> bcm2835_host *host)
>>>
>>>          if (!host->dma_chan_rxtx) {
>>>                  dev_warn(dev, "unable to initialise DMA channel. 
>>> Falling back to PIO\n");
>>> -               host->use_dma = false;
>>> +               host->dma_dev = NULL;
>>>          } else {
>>> -               host->use_dma = true;
>>> -
>>>                  host->dma_cfg_tx.src_addr_width = 
>>> DMA_SLAVE_BUSWIDTH_4_BYTES;
>>>                  host->dma_cfg_tx.dst_addr_width = 
>>> DMA_SLAVE_BUSWIDTH_4_BYTES;
>>>                  host->dma_cfg_tx.direction = DMA_MEM_TO_DEV;
>>> @@ -1300,12 +1296,18 @@ static int bcm2835_add_host(struct 
>>> bcm2835_host *host)
>>>                  if (dmaengine_slave_config(host->dma_chan_rxtx,
>>>                                             &host->dma_cfg_tx) != 0 ||
>>>                      dmaengine_slave_config(host->dma_chan_rxtx,
>>> -                                          &host->dma_cfg_rx) != 0)
>>> -                       host->use_dma = false;
>>> +                                          &host->dma_cfg_rx) != 0) {
> 
> Hang on, doesn't this whole if condition need to be inverted? It's true 
> upon dma config _failure_, thanks to the original use_dma logic being a 
> bit backwards here.

Ah, yes, my mistake. It should be:

if (!dmaengine_slave_config(..., &host->dma_cfg_tx) &&
     !dmaengine_slave_config(..., &host->dma_cfg_rx))
	dma_dev =

And I don't think that the first dmaengine_slave_config() needs to be 
undone in case of failure for the second call.

Ulf, how to handle a fix? should I send an update on top of this patch?

thanks


