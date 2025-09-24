Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013031.outbound.protection.outlook.com [52.101.72.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE00927E7EC
	for <linux-mmc@vger.kernel.org>; Wed, 24 Sep 2025 07:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758700406; cv=fail; b=oHTEATP4RBRkmxUPG/IqCIbymUhIuHCL1hkajeB3xDeCF2Pv8AStuWhNjKer71Ag3iSdL8mQm5t3COf79vflYY7GjW5sfqGOfoZJcjODDWCz5lkJLTlqQlMmCQ+gbSL3HOibOhea1SJaSAU81x8jysW3Qp3zTbN2dFYG1yPezA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758700406; c=relaxed/simple;
	bh=i5+SQL+b54lKVJ7P7yZ++7tNkkyllim99mt2iQib0og=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZkCz/j9WWN/A/pumHaEfQDlp609gN8fV6gaovoU7SUYmx9mML3iVNeqSAYH+Ha8DP6ntV4L+Zfr4NzBySpygANiU4dm+NG+znda0rOdhEehBwQ1Suyj9yZqHdOVgK+XU9tBQSU5yLHguthl94fEPfGZPxEyBv7BbMXHg6zsr8yA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=lPcxPEwT; arc=fail smtp.client-ip=52.101.72.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="lPcxPEwT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sztzu1w4S9mVlADkGLvuDYl8vl9RxrEVrmxEfG6JNfxjDBU9k17VgrQna5fQ3p5pL3fozxwuCRMEyI7u2QTzLvPsnzxDMC0LH/2SnfU5jV9bZsAwvzY3y9d5P/fRmg+gD8Ld/UxMhutzhwXUCcEYCWZcxj4EE8qmlEnFgWOFVsqNxckmKKmpwIBe736qjoau3bkef0QOSF39YrBjC9+Smnt6+gUPsH2zwT3C0gB18ms52NSdNYoZ8OioqdfxehwO+O3Xs3/QeeyE7JR/rb/Y6l4bzdvN0uVN4Wbf/j2GHizuB2ZhdKPTAIGBwivZpXvmEWI721BGQUYrQM9jAKAvtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LXcjxtsZLFhKdgWu7r0g/x/uoA1Q3bZZyKwQF6urs2g=;
 b=f/Co09Uq5vteBVXIB4ZyFq6KGBa70ZWUWDCYFWOPwwaPAkAob0ZF25dWi6U8KDCxrH9hzSEZiL9meKlrrWEVypHib49CtMN9pzlMUET5BOP7/ugMU8O4Ug29T97Yrd4ytatscQKlpjPw9NLUFFtW49jqkDiNopPxajqyTrth7Zj0L1uXbfY2iHKFfnq3AMGYwwLPTqv0FW9dNARwxYP8NnCpn3RIke2Ms8Yl9zp0gdKVicn8DO7okoULOma3XeCdQjjhhd4XN9JbCw6uxwy9YXVZ1eLKMbbS8PwATAy1z04gKXLzVIyvCW/GyfaiFtxzqWPn2E37x7XoMiGTDeSCFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXcjxtsZLFhKdgWu7r0g/x/uoA1Q3bZZyKwQF6urs2g=;
 b=lPcxPEwTkDWJ/DmLLN/ECFuRpBomYXYaKvLKvJatxJhde3qBbW/bClWYeX6KXhpFrJzttgEyZ0uekqZgSEE3WeDG4fUli30lqN8Cp2zp/+YeUG4C1ZE7lZc98IIbjDK37+NMM8CniozVztD08eMR51oJh7rd3xiLACE/iWrLrwRUnqPxGEaShe/iZGNMTbKtLkY9IfqSqbeAuhjyk5DpfKTxJnmpBl+M+LCKXUHf1bR9tdk7bCR0YdhNZLNVpfgdeFgjNvbrTZgHwEUaftvK2HgCo9sc0PQ284v7JyE5OA+xqwv95pgqhdyX86Y6+U8WgCv0G/3rWxKLunRREzFvbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by PR3PR10MB3931.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:40::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 07:53:20 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%6]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 07:53:20 +0000
Message-ID: <fc592d6d-5f6b-4afd-9e4a-e77987a88a56@siemens.com>
Date: Wed, 24 Sep 2025 09:53:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mmc-utils: Correctly handle write counter overflow
 status
From: Jan Kiszka <jan.kiszka@siemens.com>
To: linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 Avri Altman <Avri.Altman@sandisk.com>
References: <167acbaa-c61f-4d75-b2b6-9acee22ddee9@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 xsFNBGZY+hkBEACkdtFD81AUVtTVX+UEiUFs7ZQPQsdFpzVmr6R3D059f+lzr4Mlg6KKAcNZ
 uNUqthIkgLGWzKugodvkcCK8Wbyw+1vxcl4Lw56WezLsOTfu7oi7Z0vp1XkrLcM0tofTbClW
 xMA964mgUlBT2m/J/ybZd945D0wU57k/smGzDAxkpJgHBrYE/iJWcu46jkGZaLjK4xcMoBWB
 I6hW9Njxx3Ek0fpLO3876bszc8KjcHOulKreK+ezyJ01Hvbx85s68XWN6N2ulLGtk7E/sXlb
 79hylHy5QuU9mZdsRjjRGJb0H9Buzfuz0XrcwOTMJq7e7fbN0QakjivAXsmXim+s5dlKlZjr
 L3ILWte4ah7cGgqc06nFb5jOhnGnZwnKJlpuod3pc/BFaFGtVHvyoRgxJ9tmDZnjzMfu8YrA
 +MVv6muwbHnEAeh/f8e9O+oeouqTBzgcaWTq81IyS56/UD6U5GHet9Pz1MB15nnzVcyZXIoC
 roIhgCUkcl+5m2Z9G56bkiUcFq0IcACzjcRPWvwA09ZbRHXAK/ao/+vPAIMnU6OTx3ejsbHn
 oh6VpHD3tucIt+xA4/l3LlkZMt5FZjFdkZUuAVU6kBAwElNBCYcrrLYZBRkSGPGDGYZmXAW/
 VkNUVTJkRg6MGIeqZmpeoaV2xaIGHBSTDX8+b0c0hT/Bgzjv8QARAQABzSNKYW4gS2lzemth
 IDxqYW4ua2lzemthQHNpZW1lbnMuY29tPsLBlAQTAQoAPhYhBABMZH11cs99cr20+2mdhQqf
 QXvYBQJmWPvXAhsDBQkFo5qABQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEGmdhQqfQXvY
 zPAP/jGiVJ2VgPcRWt2P8FbByfrJJAPCsos+SZpncRi7tl9yTEpS+t57h7myEKPdB3L+kxzg
 K3dt1UhYp4FeIHA3jpJYaFvD7kNZJZ1cU55QXrJI3xu/xfB6VhCs+VAUlt7XhOsOmTQqCpH7
 pRcZ5juxZCOxXG2fTQTQo0gfF5+PQwQYUp0NdTbVox5PTx5RK3KfPqmAJsBKdwEaIkuY9FbM
 9lGg8XBNzD2R/13cCd4hRrZDtyegrtocpBAruVqOZhsMb/h7Wd0TGoJ/zJr3w3WnDM08c+RA
 5LHMbiA29MXq1KxlnsYDfWB8ts3HIJ3ROBvagA20mbOm26ddeFjLdGcBTrzbHbzCReEtN++s
 gZneKsYiueFDTxXjUOJgp8JDdVPM+++axSMo2js8TwVefTfCYt0oWMEqlQqSqgQwIuzpRO6I
 ik7HAFq8fssy2cY8Imofbj77uKz0BNZC/1nGG1OI9cU2jHrqsn1i95KaS6fPu4EN6XP/Gi/O
 0DxND+HEyzVqhUJkvXUhTsOzgzWAvW9BlkKRiVizKM6PLsVm/XmeapGs4ir/U8OzKI+SM3R8
 VMW8eovWgXNUQ9F2vS1dHO8eRn2UqDKBZSo+qCRWLRtsqNzmU4N0zuGqZSaDCvkMwF6kIRkD
 ZkDjjYQtoftPGchLBTUzeUa2gfOr1T4xSQUHhPL8zsFNBGZY+hkBEADb5quW4M0eaWPIjqY6
 aC/vHCmpELmS/HMa5zlA0dWlxCPEjkchN8W4PB+NMOXFEJuKLLFs6+s5/KlNok/kGKg4fITf
 Vcd+BQd/YRks3qFifckU+kxoXpTc2bksTtLuiPkcyFmjBph/BGms35mvOA0OaEO6fQbauiHa
 QnYrgUQM+YD4uFoQOLnWTPmBjccoPuiJDafzLxwj4r+JH4fA/4zzDa5OFbfVq3ieYGqiBrtj
 tBFv5epVvGK1zoQ+Rc+h5+dCWPwC2i3cXTUVf0woepF8mUXFcNhY+Eh8vvh1lxfD35z2CJeY
 txMcA44Lp06kArpWDjGJddd+OTmUkFWeYtAdaCpj/GItuJcQZkaaTeiHqPPrbvXM361rtvaw
 XFUzUlvoW1Sb7/SeE/BtWoxkeZOgsqouXPTjlFLapvLu5g9MPNimjkYqukASq/+e8MMKP+EE
 v3BAFVFGvNE3UlNRh+ppBqBUZiqkzg4q2hfeTjnivgChzXlvfTx9M6BJmuDnYAho4BA6vRh4
 Dr7LYTLIwGjguIuuQcP2ENN+l32nidy154zCEp5/Rv4K8SYdVegrQ7rWiULgDz9VQWo2zAjo
 TgFKg3AE3ujDy4V2VndtkMRYpwwuilCDQ+Bpb5ixfbFyZ4oVGs6F3jhtWN5Uu43FhHSCqUv8
 FCzl44AyGulVYU7hTQARAQABwsF8BBgBCgAmFiEEAExkfXVyz31yvbT7aZ2FCp9Be9gFAmZY
 +hkCGwwFCQWjmoAACgkQaZ2FCp9Be9hN3g/8CdNqlOfBZGCFNZ8Kf4tpRpeN3TGmekGRpohU
 bBMvHYiWW8SvmCgEuBokS+Lx3pyPJQCYZDXLCq47gsLdnhVcQ2ZKNCrr9yhrj6kHxe1Sqv1S
 MhxD8dBqW6CFe/mbiK9wEMDIqys7L0Xy/lgCFxZswlBW3eU2Zacdo0fDzLiJm9I0C9iPZzkJ
 gITjoqsiIi/5c3eCY2s2OENL9VPXiH1GPQfHZ23ouiMf+ojVZ7kycLjz+nFr5A14w/B7uHjz
 uL6tnA+AtGCredDne66LSK3HD0vC7569sZ/j8kGKjlUtC+zm0j03iPI6gi8YeCn9b4F8sLpB
 lBdlqo9BB+uqoM6F8zMfIfDsqjB0r/q7WeJaI8NKfFwNOGPuo93N+WUyBi2yYCXMOgBUifm0
 T6Hbf3SHQpbA56wcKPWJqAC2iFaxNDowcJij9LtEqOlToCMtDBekDwchRvqrWN1mDXLg+av8
 qH4kDzsqKX8zzTzfAWFxrkXA/kFpR3JsMzNmvextkN2kOLCCHkym0zz5Y3vxaYtbXG2wTrqJ
 8WpkWIE8STUhQa9AkezgucXN7r6uSrzW8IQXxBInZwFIyBgM0f/fzyNqzThFT15QMrYUqhhW
 ZffO4PeNJOUYfXdH13A6rbU0y6xE7Okuoa01EqNi9yqyLA8gPgg/DhOpGtK8KokCsdYsTbk=
In-Reply-To: <167acbaa-c61f-4d75-b2b6-9acee22ddee9@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0053.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::17) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|PR3PR10MB3931:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d28b45b-62ba-4c0f-6421-08ddfb3f6dbe
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TXdqaDZ1bDdJL3JtSVNveHQvNlU0bGlRdFFrUFBwTUFldkVzd3p4OWRncTBW?=
 =?utf-8?B?MGVWcTJ4QkJNYkVUVnB0STZhc0E2MW5MSkpqaGtGNWxGOG9FdW91ZEpob0xj?=
 =?utf-8?B?bnFsUURydUlzK3BCRnRVTEx6a1ZhZTM4L04rcmxzbExoUXp0UW5JTnFoa0Vx?=
 =?utf-8?B?TTdCZThUbHlCOXArNkR1a1U4YTdXQVJSRUE2Z1laWmwwYVpiWlZGdXZ5aVFK?=
 =?utf-8?B?cHpOY0lpc0xKZzZIeEhpdU5jdUJOY2xnYUlEbUNuRE9xdE1kMWp0T1N1cDR3?=
 =?utf-8?B?d0RCQ3pFN1I4Zyt3UzViejFXNllJRlMvd2dmZHlYWUl1aHdySjltL2ZrTTNl?=
 =?utf-8?B?cFJWUGkvQ1NTeTU4WFJ6dGlyenROeG1FZzFVWENPMzVqbEJvWEZuZkxsR1ZZ?=
 =?utf-8?B?ajZoNmNhbmZBcis5YWVlMWQ2dVdmY0dZOUlLTnJNc3NEdlNrMG9STVpPYmNU?=
 =?utf-8?B?KzRjZW56SjZaVmcyKzNiNyt6WVE5a0RZSEhtQW50Nkl6K1ZOODh1WlRidmtE?=
 =?utf-8?B?cUV4S1ZiRTJpWk1TY0tGbzFLM2RCUTE2VlFad3pFc0NDYVVSeUM5YW1QWjVS?=
 =?utf-8?B?MnFRMlZoNGJNaEdHZE5xdDFiWTNlK2JQaXlmbEpaNHZGRU4rdWRETTN1b0gy?=
 =?utf-8?B?bWsvLzJGenZXSWt1Y3A4YnZWbzZnMEd3UXAxSk5yMUZGWVJFdGZKeXc0c3dm?=
 =?utf-8?B?TGlxdnFTVnJmMjlwcFBDMlpGVmxXTVNuSHB0cVdvTksxYzlEcm0yT1Vmb0Vp?=
 =?utf-8?B?R2ZQbng1ZHQyWlVlRHBZWnNnVWVXUSt6QTFrWHg2Lzc3alBUa3JQQVNwUEcv?=
 =?utf-8?B?aWJuQmhFdHRjUHlxQi84ZU5rNjVtWlk3Vzl2OWJmN2htMDU3R2cyK1BxNFAx?=
 =?utf-8?B?eXZ3dXYxdEdrbWZFbS9mTEtLRWVWVjluem93cFJlL3pzNnRPVGhLYzh2QlUr?=
 =?utf-8?B?U090ZEoxY2JIalBOLzNveFpPMWVPSnY4MlF6TklCOTRtaTR6T3JBRm9NQW9i?=
 =?utf-8?B?VktNMTdLd2VBWjNxZlNnTE9sUjBRejFwWGhyY21kbFB4Tml1dkNENnBuOUhp?=
 =?utf-8?B?NFNsRi9IczZtUld5SklYU3daOVN4R25yQTV6RTVLcGhuQ1JTS25JbVlpRG45?=
 =?utf-8?B?Tzl1Qk5HOXQyM2lWM05ycThWWXYwQTdkOTRXRHMwVlRKWmV4aUM1OXNVWTE2?=
 =?utf-8?B?MDZub1B0L0VZNFR3Tzg2S0ZScDlET3EraW5uTE1yK04rWU9ob0lZYWQrM2hn?=
 =?utf-8?B?UXFELzhCYzJOcHBsMFlvWVVSU3M0NVFIYmROUkRla3ZHSEpYaHJZMERWbTlu?=
 =?utf-8?B?RGJJUUZ0UEN3TTNETjV2Q0I0VHRCOHg1dGJ1VW13RVN0VlJDemFlMG5Ibkw3?=
 =?utf-8?B?T2EvNFU3Z0dBTHIvWGdoZnVCZldYaHFzR2xuRklCdnlJR2JXVm1aVTdrWTNl?=
 =?utf-8?B?VGxnVk1GVHBkSUJ2Y3VPWjhXd0lwNHRoWW5Nd29BczhIc0ZHc1o3VkE4cWMr?=
 =?utf-8?B?a1E5TUFYdlpBVFVEWVNSYnhsSXFQckNMYnduZHFBR1A4dWRmcUtiUEdrL2My?=
 =?utf-8?B?blp0MTdSdkQzZTJpeWN4bHNQbm5VdU5DVFBvYitzN2FVWW0rcnhnOEVMQldE?=
 =?utf-8?B?cm1PNVdWZ2o1dmtYUXE0TzVMNnJHd2xUVFpibUlGd2FLa0JoMU1EQXJSdzd6?=
 =?utf-8?B?UlRwNFhkbEFEWWZPd2pJQ1lzSnZwMFFsR2FTeHMxbjBQa0hSRmlDdnI5bnpo?=
 =?utf-8?B?L0QwMGxqUklwUXVVcmpSOEVzaXFwVnFCV0J3MERjOFM3NlVGeHRyMFFaa1lw?=
 =?utf-8?B?ZXBpenQ1dHY0d0s4alUyMk55WUVQMmVxY0VYczhVSkVleGVKcE5MVStZd3dY?=
 =?utf-8?B?NnJFWHhFL0JwRUxCYzA1anpZMnNPWVNOMkRYa1Vqa1BnRHdTcXBWRjVMTHlN?=
 =?utf-8?Q?VYlELSJkiFI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S01qaFVGRzFyR2RJNVQwM0MvNnBhRTYzSlZ3RmF6eHV0eEd1UEFHRWF4Y3pt?=
 =?utf-8?B?cUZqMTBkU0ROV3ZCQmxkUUdXdGFaYjRJc1J1eWxCT3JGVjRLcnYvZHFFZXJF?=
 =?utf-8?B?YVQyandFdDlrZUtYOHJOZTJYcWhON1psN0diZktyMlZodHRlNlErckRLaVB6?=
 =?utf-8?B?MWllVHIxVFk3V20ybGZJemdqQTZVN0tKMGpvdXI0dk9iQk1GTTU4TVFscE9I?=
 =?utf-8?B?Y2d6UGYwMDFJSDJaVU1PUkR3V1FjelBKMVpaVTBPLzBSOGpTYXhhSWdHcU1n?=
 =?utf-8?B?QUR2ZHJFYWdhZFFNcmcxMERVR2o3VTZHYTljRTlUTlRib1Y2YVh2WFJrS3JR?=
 =?utf-8?B?YnNkbHRoYmx4NHJXMVE4VUlLaGtOdno5NUtaZDAzb2lneEZiUEU1OGlhSGNn?=
 =?utf-8?B?L0RIZ0RQb2s3VXIzeFJIYkExbTZPUmZqZEpRQWR6YnRJcE9PSlUwSms2Mk9P?=
 =?utf-8?B?enRaeUw0WFdLenlDZSt6UHlwWEExbkNBbzNEajFmalBHcE5XNE1HbFpBRDRQ?=
 =?utf-8?B?YlBuaE00U3VOUGNIS3FrS3hGQzNQbEtFMXdJTGVFUTRJWG1JTUZDazlLM09k?=
 =?utf-8?B?cmVUaGYrK1RLTGVpWDU5a21HMXY2T1FNQmFCeS9GNzcyRC9DOXpFVG9FZllP?=
 =?utf-8?B?alZSZGhtam1NanBvUlhHa1c5NGRMNW9zTnlwcVEvV0c0Y1FFZVRCdW51RG85?=
 =?utf-8?B?R01ZRlZvM1hQd0psVUFiY3A1MldCNDZQUlUyZmtJVWtmTXNTTDkyVWozbXk4?=
 =?utf-8?B?VGZ2Nk1PQzJhVTNXd2NDSzRiZEFGMXdTakk2M1QwQ2lMTGJ3U1gvSEZEYm5q?=
 =?utf-8?B?bnVZK053VGlObzkwd1Z1R2dmUHJaUHpPdkJKNmtMTDNJRThPck8vcWNNMDFp?=
 =?utf-8?B?QkloRytXTW4yNExjN1lXLzRXcS8wTjg3NExHcEVsV0w5ZzJwQnZmVHNPVFBG?=
 =?utf-8?B?ZG9PLzV2K0lrdWtSaXJHK3IvRUUzVFdyRzQwOXVPZitmbE9ETEIvVkhjdnFv?=
 =?utf-8?B?dkQrTGZxeitHL2hqY1VXWFA3MG1qaVVWUDBscDRmeEY4OVJMby8yZ1BOTnkx?=
 =?utf-8?B?VkwzMjFUaTRZcUNnYzJwa0NUTmZKM1VPWllkVE80WHlTaTlhRC9MRXJCa3RT?=
 =?utf-8?B?NHNRSXM1dDJkMG93VTJ5QUNFYXNxcExZbENZR1FQMFMzMGdNVjV5dVYvM0k2?=
 =?utf-8?B?M1RJOCtHamxIcDUyQmFkZkFiTm1zQWQxVlg5TG1RMnNQOUVlQWxrd05DanRO?=
 =?utf-8?B?N2hxR3VqcnRmVDRQcEFmWUFiY05zOUtCRjBiSVE3aUhQZkI2L2dtRllIVGIw?=
 =?utf-8?B?YVI5c2M5TEljU25zVEk3Z2NFYzNkN0svcExxQkhXZklUbDMvOURZaGljZUZn?=
 =?utf-8?B?Qm16WXUvaHVpN3pMeEh2U2g0eHh3aDZYYUZ2VkV0a0xHM0p1b1pWNzIxUnYy?=
 =?utf-8?B?VmN6QzA2WDVKRW1FNGIyS1NkTkZTY2wraFBQRmtQdE1ZZVRDWUtKcEtsdy9x?=
 =?utf-8?B?dVcyRUl1aHB4N2pNVjFiUGVRMXUxU2pVVG5qRFRqcXhISnVSUHRmamUzUHdp?=
 =?utf-8?B?dDhySWNCRTNnenI3dHp2M0UwK3NNWXU1TjBPc2NSN1pJOXo0UkVCYnVQUncz?=
 =?utf-8?B?QVdBNWluajlWdGYrZlhYTElnWVdvM2tRVjJpQitqUlRGdGIydmcwYWRuT2Mz?=
 =?utf-8?B?djB3cGIrNy9uQXRYa2lLZDI1MjRmWGFTOFVkQThnVkpadVR3dTFvOGVZOEcz?=
 =?utf-8?B?Wnl2czNRd0xSdy9Pb3hYZVZGUjNpMHAzbzBMOU80d1U1c3huMThzQ0ZML3FP?=
 =?utf-8?B?RGZPT1BRdzFCek1qY1o2bFh3TkhjZmhPOU1CV3JPbHV2d1VjYTg0ZEp6dDc2?=
 =?utf-8?B?aXF2TGdRUjNSNDhwT1VqZi9DUVF1UlJQWDIxUFhBQVBlVUYyejk4eVlnS3Yz?=
 =?utf-8?B?bXFBYjV5RXY1ZG5YV1JWSzJDTlVSWXpIeXFWa1oyaGh5TmpCenY2QVhaMnJl?=
 =?utf-8?B?TER5dUp3Nk8vLy9xM0J3aDdBdityaERzeXNTZmZXSTZ2Q0ozaGgrVml1UDk5?=
 =?utf-8?B?UFRSTENuUFNzd3JMZ3JaYkNsN2FSK2E0TWJUSGtrZHBibWZiVGNCcWhtK3Jk?=
 =?utf-8?B?ZllNcVVjc2dhTlA1bEVyOW5OSXAzcGk0c0tjSTdONTc1dkRqVXFia0xhc1Ru?=
 =?utf-8?B?RWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d28b45b-62ba-4c0f-6421-08ddfb3f6dbe
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 07:53:20.2133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KYgFvnGawrnOufYg+dm0wi2cYqj2aBNREYc0zXYc0sJcJhEorQ647QA3hgdkxoakNhl2zlh3Z4t2IfdJmMx1vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3931

On 01.09.25 11:26, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> The result field of an RPMB frame will have bit 7 set as soon as the
> write counter reached its limit (0xffffffff) - even if the operation was
> successful. Handle that correctly to avoid false error reports.
> 
> This was found and fixed over the RPMB model of QEMU after adjusting it 
> to expire earlier.
> 
> Fixes: c6cb053ec59e ("mmc-utils: RPMB: add support for 4 rpmb operations")
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> 
> Changes in v2:
>  - use operation result mask, rather than masking out the counter status
>  - handle all result evaluation equally, even if not practically needed
>  - massage commit message
> 
>  mmc_cmds.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index 16c6b2e..429a9c7 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -2103,6 +2103,8 @@ enum rpmb_op_type {
>  	MMC_RPMB_READ_RESP = 0x05
>  };
>  
> +#define RPMB_OP_RESULT_MASK		0x7f
> +
>  struct rpmb_frame {
>  	u_int8_t  stuff[196];           /* Bytes 511 - 316 */
>  	u_int8_t  key_mac[32];          /* Bytes 315 - 284 */
> @@ -2295,7 +2297,7 @@ int do_rpmb_write_key(int nargs, char **argv)
>  	}
>  
>  	/* Check RPMB response */
> -	if (frame_out.result != 0) {
> +	if ((frame_out.result & htobe16(RPMB_OP_RESULT_MASK)) != 0) {
>  		printf("RPMB operation failed, retcode 0x%04x\n",
>  			   be16toh(frame_out.result));
>  		exit(1);
> @@ -2321,7 +2323,7 @@ static int rpmb_read_counter(int dev_fd, unsigned int *cnt)
>  	}
>  
>  	/* Check RPMB response */
> -	if (frame_out.result != 0) {
> +	if ((frame_out.result & htobe16(RPMB_OP_RESULT_MASK)) != 0) {
>  		*cnt = 0;
>  		return be16toh(frame_out.result);
>  	}
> @@ -2442,7 +2444,8 @@ int do_rpmb_read_block(int nargs, char **argv)
>  	}
>  
>  	/* Check RPMB response */
> -	if (frame_out_p[blocks_cnt - 1].result != 0) {
> +	if ((frame_out_p[blocks_cnt - 1].result &
> +	     htobe16(RPMB_OP_RESULT_MASK)) != 0) {
>  		printf("RPMB operation failed, retcode 0x%04x\n",
>  			   be16toh(frame_out_p[blocks_cnt - 1].result));
>  		exit(1);
> @@ -2573,7 +2576,7 @@ static int rpmb_auth_write(int nargs, char **argv, uint16_t addr,
>  	}
>  
>  	/* Check RPMB response */
> -	if (frame_out.result != 0) {
> +	if ((frame_out.result & htobe16(RPMB_OP_RESULT_MASK)) != 0) {
>  		printf("RPMB operation failed, retcode 0x%04x\n",
>  		       be16toh(frame_out.result));
>  	}
> @@ -2621,7 +2624,7 @@ static int rpmb_auth_read(int nargs, char **argv)
>  	}
>  
>  	/* Check RPMB response */
> -	if (frame_out.result != 0) {
> +	if ((frame_out.result & htobe16(RPMB_OP_RESULT_MASK)) != 0) {
>  		printf("RPMB operation failed, retcode 0x%04x\n", be16toh(frame_out.result));
>  		goto out;
>  	}
> @@ -2783,7 +2786,7 @@ int do_rpmb_write_block(int nargs, char **argv)
>  	}
>  
>  	/* Check RPMB response */
> -	if (frame_out.result != 0) {
> +	if ((frame_out.result & htobe16(RPMB_OP_RESULT_MASK)) != 0) {
>  		printf("RPMB operation failed, retcode 0x%04x\n",
>  			   be16toh(frame_out.result));
>  		exit(1);

Any news on this one?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
