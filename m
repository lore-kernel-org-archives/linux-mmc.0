Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013013.outbound.protection.outlook.com [52.101.83.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E07C2FB976
	for <linux-mmc@vger.kernel.org>; Thu, 25 Sep 2025 15:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758815703; cv=fail; b=O2FDRFHQSPBGmhB7055yDd41yJlEdiVMhncJmjjFchkfd53gXh6DufDf7R6iEhzHI0YvtD5cEF804rsxQJKLB8KBBSWr3A7Fa44l4tGIut+GZkC7capNgWzoZVwTbbmkyz2lpDX8EwtJsTBwTRfozXvbi7F/o4WGiIhKuJb8L2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758815703; c=relaxed/simple;
	bh=45TrmhEXrWXDxhIkuGnwoomKwZt4wDJAowDcXrP6zTE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oVZkpLz2NWAmqtbI+ynBsPZjF1JSuKQAOor15OyghU/TU4r5TmJSg9uxqFqU2aFZimcrygiXBTPXiQs5PDjoEvM6QZg9yQlx9kWs9otH0NEJPT/DiYDg3fZNLl/X86B+9GPAD42UvUZBARdcc1AhVo/LFsPiw72NEs71LTYPArI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=GVym5UJ5; arc=fail smtp.client-ip=52.101.83.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="GVym5UJ5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WNFhsAjZH1X20LGe4dal2jIZRvyJqSmbxhhKW6F3lcZPVJdMVca3eh365MFInJJpLaROJYUVtedLOMBNfzNK1+DCPzxXUV5Axqjt32o1NGlKkD1qXe8LjOdh2IlL48/LkAa0omJATkR32mAJFY9vc/cmK8SQOJSAjNGlzBG8WnaSAZYCtph24y+JI7q7ehffQ5CV+zJXGZ82oGdU9IWuABt9oM7/250DOcfQKbH9euPhXmPHabIrCXcb5tO4sXrBGGBERNEEBsMp95YHvNzq1QhRcIqYz3dDFR5SQA7svpT4vV1U4ClEKxWNdTTndOVZVF0jYMMwIklscH+52KYZgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q5xYDZL2SGpNB4kQGSoeeFq4aiiZ/gX11OkPQ/GISWA=;
 b=tvk3QFNUhsWNVZIT9UeNWe6RW3dT0qD/Nq0oQvK+EwT5oTdccra6/pLiBm+02gvzFdrsmLHE9K9DMKVyKD+EA6m49V0gDkPny7Z1gYqt8qSUPbcAiAUqOx4/Q/zZNVBWP8oSTNE1iKdK2ySwVjGHpKM27o5k90SQlqw/UOI0pt/C3Ejhu57TunNdzpWdrEIgUlngo0OvyoLnR6WTBG7L6LTAbg5HZ3xnk638HwI4w41yDcbwAoqfJaY6kS9AAJCq3vAYBkWnpgoGJ81F3FqeC4FSYqZlA0JV5VZvM/X1AatzePAX1eHitUwRxTq4RHS4eCpW075LTNNCPTUczmgFzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q5xYDZL2SGpNB4kQGSoeeFq4aiiZ/gX11OkPQ/GISWA=;
 b=GVym5UJ5U3Q0vLTeXdjhWYe4hQ3mBeFlPsx9rSh78aCBaSHCyP0gZNLzNb+ynBgtXRFxnHSZDLj6z2DGXR4Z9x+ssCj8iJdnEDjCztpdl5l9VtR50yXrHJcpH0Z+Rm3VbxOEGXBHYOhvSE5bWw8Du6SSICHMz6Bmdqf2K6AUb9ZrVBzOA4UlJzfYT0esQkoFAT9bPN6dI4pdZYafPQ+Gp2E9cJs5yPRTir2pFEFtA1o7o2NwcdfrvGQuJrC9hYDB6ufnTN4bmSTH3Xdz3dRarOtbq9uvKCQc3aZPnzG1FPB0xcr28CeWw3FcJ0qpO73oROfwGCwdqiPxmNuoiJOZzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB4PR10MB6917.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3ff::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 15:54:53 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 15:54:53 +0000
Message-ID: <edad7f10-887b-4603-9bf4-d22629d11cd7@siemens.com>
Date: Thu, 25 Sep 2025 17:54:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mmc-utils: Correctly handle write counter overflow
 status
To: Avri Altman <Avri.Altman@sandisk.com>,
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
References: <167acbaa-c61f-4d75-b2b6-9acee22ddee9@siemens.com>
 <fc592d6d-5f6b-4afd-9e4a-e77987a88a56@siemens.com>
 <CAPDyKForTu9xdtPbYZ-DyLPGrnx7c6aXE8E1qoz9U_yZzAhRWQ@mail.gmail.com>
 <PH7PR16MB6196BB890A60C66FD6B300E5E51FA@PH7PR16MB6196.namprd16.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <PH7PR16MB6196BB890A60C66FD6B300E5E51FA@PH7PR16MB6196.namprd16.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0216.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB4PR10MB6917:EE_
X-MS-Office365-Filtering-Correlation-Id: 79a7ac44-85ab-4fef-d355-08ddfc4bde09
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bVZWeUs5RUdrdDN1N2p4NFZVWURLcGMyaEpjRkRwU2twNW4zWlJRQzEwWk9B?=
 =?utf-8?B?ck5JcWFLWFlLa2VJK3NXY3NZcnNRRzV2d2pBK0wrS1ppNU9NZmNGZTAwTnZo?=
 =?utf-8?B?M0ZLaitreVUzWUhLNG5PWkl0YUd6eEsrNGYyOG1HRWZhNEVMU0F2Z0t1dmo1?=
 =?utf-8?B?RDlMTFczVncwL0U2Tml5ZUc2czRKQUd3ZHBYNUtlYmhGdzZGWVdGS0s1MU40?=
 =?utf-8?B?c2lYNUtMUjRQWlVuZWduWjFtT1NTRHl5QlltSEFua2ZXcFVRMkZtOHBXWEpo?=
 =?utf-8?B?cnVXZTdUZFVMcmJHejR3OWI5YmthZXA0bnVuaHI4OTNRU2dWWmMzZzE3NWVi?=
 =?utf-8?B?dWtlcVpYenZkUGRtaHJzSGR5UDRqNUJQZ0J4YVdVdlZ1T29HT1lMeC83RjVI?=
 =?utf-8?B?RVF3ZjRaY2tkM2trVG9PZlZmbkZXcVo4UURJR2xuaVVHZFNGeUxzWGw1ZkVj?=
 =?utf-8?B?TnhLamMrQ0tEWHVEWXYxYnV5ejFHOWlOdGt4TWZWazE4UE9wTkJhUW9WTVhw?=
 =?utf-8?B?bVY5YWVucGswUDU1LzRLMEc4VWhhcGhTdlFoekxqRnF2ejlNYVVidWJROFpw?=
 =?utf-8?B?SGVuQkp4Y2N3NGs1cldjUlBaVUY2djVhKzVEQjI1VjM0Q1VjMmRldVYrS1hM?=
 =?utf-8?B?RWY3U0lqRm1CcERsbjNURFN6QmIvUVc5Rnd5V2tjSmFobmd4RENnWkdySDc1?=
 =?utf-8?B?YlF3cEQyRXdRUjlPZGI0Y1gwTXpyN01USXFqVTE3d1dleHFuQ3dCaGxSWUlT?=
 =?utf-8?B?Z3pQZDFzUGdGNzduU0RmaGtTYkV4K0w1Vys0KzJndHlhQkR6dG5GVWRvTmc2?=
 =?utf-8?B?YnBkYlJjay9HcDB6U1ZjbHRnekRFN3VXYU9LZ2JqV1pHRHBKMGdudUxHeTcz?=
 =?utf-8?B?TzB5WUJhYm9yOGRhMTE2RU5XWEFhaHpJOFEyWTh2Y2Z0SGpCYUVOa2tWK0th?=
 =?utf-8?B?SndhbkErZ1JLSVlZWVQrWnV4cXowUC9QY09heUVIWGUyVUhoRkFicksxSFRW?=
 =?utf-8?B?L3NJTktDRGRZa0ppWGtYcVc3Qk1oY0p3SWFuU2UyaXMzYW1wVlZBNXpZelBW?=
 =?utf-8?B?Y29hdU1HZSt3SkFmWHMxakp1YjBMR1VkN3lxM29acUtNMWlrZnJFVVdWWEVy?=
 =?utf-8?B?c2hkOXBqRTJvUm5JV0Jjelo1bzJ2QnhyU1UwVkZDVW5BT1pWbkEyTzlMOEdM?=
 =?utf-8?B?YVJGckYyRUx4QlRZQ2xkOFluc1dhYzhoTFdJN2dlUm44Qzl3aVJpRENpYVlI?=
 =?utf-8?B?TEdrOUJFaE5RVXM4RHUxblRIc3Q5MHlEd0duMUxvMkZnMFFNbHk4Vm5iZ0dW?=
 =?utf-8?B?Tm5qKzkxRml6dkpraXBjNEpYckFqV3JyYW43aGxhYTh0U0NrVzIvUkFlSjJw?=
 =?utf-8?B?eW4yTi9OQ3RuaHY0NlptakZLTk4vT2syaWJjalpmaVlnRjMrOUc3d0gwM1Ny?=
 =?utf-8?B?OGppZ2MrNTdLQzNUKy8zZUkvQm1xMXhLSVlHZHhZck16VFk0bHVMS1VqN1Vq?=
 =?utf-8?B?eFpTWHlDNkM2OWZnZHV5UXYyM2ZOOVQrNy9URm9jOWR3U29hbVVRSC9YVjRl?=
 =?utf-8?B?Q0d4L0lVRlp4b2dtQlU3cS8rcUZka0FtU2V3Qld6TkxKOUZ3bHlEYUdkcWw1?=
 =?utf-8?B?c09mWjMyazM0Y211cGc2TTJYOXhwdC9LR3o4cmo3Ym1meVpyTTRIUCtZYXk1?=
 =?utf-8?B?ZEhRNU5LMVExMktXVFNpRUVNeHU3Vm00T0hJanI2VGI3QnRLVkp4cXNKQ0Rw?=
 =?utf-8?B?czh4d3NkaFc1ZlhVUHd5cXNNbFF3c1Zyb2NId2ltWHN4QkFhNnBRN2FEd1Zq?=
 =?utf-8?B?a24vanpxNUhWcHJ2Ky8rTC9VeWFkWWw0Tkl4QytpOEkySnhOQnZiOVhKV283?=
 =?utf-8?B?WExianVtQXdqMjQwMnhNNUZBdkVjdXdTaC9SMmI4ODllQVBzN0o2RXpjcStD?=
 =?utf-8?Q?6OYehhTOIHA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T0dMcU9XbTIva2N1MHpjZDRXQzNKL2NBVE1jWXp5R0p5bGhmMiszNE9zN1BC?=
 =?utf-8?B?ODZwTXZ4R2t4SkJnVWRhdHZjMDdNTHNEZHJaMTNDbEkzQ0doaWpSamtoU2ZY?=
 =?utf-8?B?ZDN1MGZoMVVoWHFsRlhQVzg3VjR2VXUybmRudmNUcFRPcGh5VTkwaVRXU1hj?=
 =?utf-8?B?dEVXOEJBR0ZvOXZFbXIwdDZwSVpKTnhEeVdMaEpOZk5vUlpGZkhMZXRzdjFm?=
 =?utf-8?B?VTcyc21Jc3c0WU1JQjhYNkw1U0NWdXVGQnNSclhZVjZTa0dOYXI0NDFEZ1M2?=
 =?utf-8?B?RlFieFVuRllET2tiNjRQcmhqdlYrQ1FjU2ZpaU5rQzZRV280S0NoSDYrVW1p?=
 =?utf-8?B?VHZkRURYTFNxeW9POXZNdWJqT2lubFR2MXF1ZEVZWkZPaFVhejFFZXVxaFRS?=
 =?utf-8?B?WmV3clJCUVQvQStSUktreFhSTXRWaFJocUh3aXo1UkVkSllXWGo0RVVsaGlv?=
 =?utf-8?B?Vnh0aVNsSUJUM1d0ekFVQ3pKK0d0TlVwZm50MzF4S1dubFhEcU9tR3p2azA5?=
 =?utf-8?B?ZlNUa3lFd0FkUG5hamVZemNSMG1XVXRpL3NvSkpsbkZvVllTNXdhU2tKaEls?=
 =?utf-8?B?d3J1dVR3MGtkSm1CN1AzMld1MDB5L1BadUtIVHpoY3orRUJVYVhSbFV5Wm9O?=
 =?utf-8?B?SnBpQVhFN1dTNDFyTkwxT0RsVTNRci8ycFF1TXdwbGpaZFovcHZIZktmWkpL?=
 =?utf-8?B?M0F1alFWSVdhSitGRUZGTERYZDdlRCtxMTVXcXI1VjdhYmxlNm8zSXRiL1lP?=
 =?utf-8?B?N1hnQzJjRFl5T1NFa2J4SlZIMkg2SGJUczVKbnNkK2V0MFJsNTBDS2ZGOTZN?=
 =?utf-8?B?STRVd1p4ZUI0UzBMTUwvbkdNcndheHdyMGcwU3czejFGb1JsWUF2cnkvUk93?=
 =?utf-8?B?RlY4THBzdERqV0ZZTG1qWkN2dXFCNW9UdFlIUHVTMzdPeWkxQTYrdHRqbCtU?=
 =?utf-8?B?aDRiOGRlM2RtdUc4Z2R1TXlQZjVLWkhoVjFka0lCNEs1MjU5eEFIbmp1YThn?=
 =?utf-8?B?NmhIalpjVGFUY3dpZStubEpaeGZDdGxydllha2Y3Mm9PdCtSWUVqTG95ay9Q?=
 =?utf-8?B?azhKaitRNE1EWnJjODVWRWE5dDRvNHJUUTlwaVpjZndXVGlMQk1qakRha1gv?=
 =?utf-8?B?WW5ZTXpDUXlXNCtBYkdGSUJjUGNhbFAyKzMyS1ZKeDVKQWYwQlhTOWdOMFdV?=
 =?utf-8?B?K1JVOE5mR0d2aWIxODdyL285THVWYkg3ait4V1QxNmUrMnZGYm4xTzcrQzZh?=
 =?utf-8?B?RXhqQStHWCtZQUdiclVmRWhWbmN2T2JFSVhQblhWcGM5Q3dTbUFjSEdpa1Fp?=
 =?utf-8?B?MGVCUHY4YTM5QjQ4cXA1dERDM3J2NWpHbDFVNlc2Q2x5d0xnYVNtM0xKbXZh?=
 =?utf-8?B?dURvbnJ2TEkxUExFR1JHdWxYVENQcWtmRjIyYS84YUNnNERoR1JzdHdKNHNw?=
 =?utf-8?B?RENsOHJrempXc1U5YWtlM25kc1Q3MUxuRVhRclZhT0RuUWpXazh6L0Vqc3Jj?=
 =?utf-8?B?dTE3b0RZMnJLVGdoMk9iejFyQ3pXMHNPWFNMaHZpZzZPc0RQQitYNDVxYk9l?=
 =?utf-8?B?eDdHaGtPc0JtZ0MvSWVpdE5iSFpNYkoxU2k5SHlNeHM0KzF6TG5hVngvemtj?=
 =?utf-8?B?MGFtODhkY1JCSitzZDNNSmpUeVlzeVgxaWVaNDhvK1dIYVA2M0dKQ25nUWtJ?=
 =?utf-8?B?YXJ4ckZHRjZFbXdzOWJxV3J3aThrSHBMbGh0NUwxZk1uUGEzdEIyWkh0TVFJ?=
 =?utf-8?B?azY3S0dsZmFwY0tmSzFxVzJxUDFoOFRxWnpWTDkxcXZaS3JKZGlhV0NKeFJr?=
 =?utf-8?B?MkVQVjFaN0V6bUpOMXJQL0pGV2U5SGxqSFFaWk9ndkZFS3BYWHorcEQwOER3?=
 =?utf-8?B?ekladC9XQUhjcnlDRkFnWTZIUi94YjRSd1AwRklGeVlZeFJZNCt3WVc0cUpD?=
 =?utf-8?B?Nmt6QklqZWxQMW1WazVWb2EvZFo0SUhjS1JOdWFZS01ReUhPRTVjSCtPT3Ry?=
 =?utf-8?B?MzFwN2tPTUZiaEJIZDVRQlZocUpMbXRBQkpRdHh6SS9yUVhpNndyazdSbmh4?=
 =?utf-8?B?aDhHU0o4RmhVZE9OeFZzSXF0cHZlMGxQTGROdmszU3puZlNtMHI2L3U5OWN2?=
 =?utf-8?B?dSt6SHdaSHU4NGFCemFhNk5JeG93dnJCMHFVMDhocG9scVJiL2YrTUs1RDN2?=
 =?utf-8?B?bWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79a7ac44-85ab-4fef-d355-08ddfc4bde09
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 15:54:53.5777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DaAeX1nEggqwcGOOHxPnh2t44DC/ZBqyQ+BxPT+UpMr/3g+DaM6SiXt098hRBHRTEmZxxuxU3OhmTStSPKyNiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6917

On 25.09.25 17:43, Avri Altman wrote:
>>>> +#define RPMB_OP_RESULT_MASK          0x7f
>>>> +
>>>>  struct rpmb_frame {
>>>>       u_int8_t  stuff[196];           /* Bytes 511 - 316 */
>>>>       u_int8_t  key_mac[32];          /* Bytes 315 - 284 */
>>>> @@ -2295,7 +2297,7 @@ int do_rpmb_write_key(int nargs, char **argv)
>>>>       }
>>>>
>>>>       /* Check RPMB response */
>>>> -     if (frame_out.result != 0) {
>>>> +     if ((frame_out.result & htobe16(RPMB_OP_RESULT_MASK)) != 0) {
>>>>               printf("RPMB operation failed, retcode 0x%04x\n",
>>>>                          be16toh(frame_out.result));
>>>>               exit(1);
>>>> @@ -2321,7 +2323,7 @@ static int rpmb_read_counter(int dev_fd,
>> unsigned int *cnt)
>>>>       }
>>>>
>>>>       /* Check RPMB response */
>>>> -     if (frame_out.result != 0) {
>>>> +     if ((frame_out.result & htobe16(RPMB_OP_RESULT_MASK)) != 0) {
>>>>               *cnt = 0;
>>>>               return be16toh(frame_out.result);
>>>>       }
>>>> @@ -2442,7 +2444,8 @@ int do_rpmb_read_block(int nargs, char **argv)
>>>>       }
>>>>
>>>>       /* Check RPMB response */
>>>> -     if (frame_out_p[blocks_cnt - 1].result != 0) {
>>>> +     if ((frame_out_p[blocks_cnt - 1].result &
>>>> +          htobe16(RPMB_OP_RESULT_MASK)) != 0) {
>>>>               printf("RPMB operation failed, retcode 0x%04x\n",
>>>>                          be16toh(frame_out_p[blocks_cnt - 1].result));
>>>>               exit(1);
>>>> @@ -2573,7 +2576,7 @@ static int rpmb_auth_write(int nargs, char
>> **argv, uint16_t addr,
>>>>       }
>>>>
>>>>       /* Check RPMB response */
>>>> -     if (frame_out.result != 0) {
>>>> +     if ((frame_out.result & htobe16(RPMB_OP_RESULT_MASK)) != 0) {
>>>>               printf("RPMB operation failed, retcode 0x%04x\n",
>>>>                      be16toh(frame_out.result));
>>>>       }
>>>> @@ -2621,7 +2624,7 @@ static int rpmb_auth_read(int nargs, char **argv)
>>>>       }
>>>>
>>>>       /* Check RPMB response */
>>>> -     if (frame_out.result != 0) {
>>>> +     if ((frame_out.result & htobe16(RPMB_OP_RESULT_MASK)) != 0) {
>>>>               printf("RPMB operation failed, retcode 0x%04x\n",
>> be16toh(frame_out.result));
>>>>               goto out;
>>>>       }
>>>> @@ -2783,7 +2786,7 @@ int do_rpmb_write_block(int nargs, char **argv)
>>>>       }
>>>>
>>>>       /* Check RPMB response */
>>>> -     if (frame_out.result != 0) {
>>>> +     if ((frame_out.result & htobe16(RPMB_OP_RESULT_MASK)) != 0) {
>>>>               printf("RPMB operation failed, retcode 0x%04x\n",
>>>>                          be16toh(frame_out.result));
>>>>               exit(1);
>>>
>>> Any news on this one?
>>
>> I was waiting for you and Avri to reach a conclusion. Avri, is this good to go or
>> do you expect Jan to send a new version?
> My point was that, given the Byte order of the RPMB data frame is MSB first,
> we only need to check the lower 3 bits, and the expression above doesn't do that IMHO.

As I wrote: The spec says that all 7 bits define the result value - it's
safer to include them all in the evaluation.

> Hence, I couldn't add my reviewed-by tag.
> If, however, someone else finds this code useful I have no objection to accept it.
> The patch in its entirety is fixing a valid issue.  Therefore:
> 
> Acked-by: Avri Altman <avri.altman@sandisk.com>
> 

Thanks!

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
