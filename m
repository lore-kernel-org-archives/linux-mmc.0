Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022143.outbound.protection.outlook.com [52.101.43.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3259A1A9F91;
	Mon, 12 Jan 2026 06:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768198263; cv=fail; b=iufpI/4ZThN+r7N3FZXOsIBpB2Z86R1zhKY0erSmbxoYFMtAZtRkha71FAlUn72nrrWDSqSTP23fw1OoA1tRrgtkvJVB72e7wvVmdG9DgmYcJ4a8lhrhcCL+6I1Fe9cdc++Bj1PIZSwpZC51K+62Lh97KLgVcGJ51mILyE3pPDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768198263; c=relaxed/simple;
	bh=9t9U7RkGFDZQ5WLB8hKaMOx0S6aBC0mYpNcOELkFULA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f7nMRSRaRIPt9wsSRUZPO/kOUvm+nvnSD43tl8ni7z0FOR3wf086CkaHa0Rbr6viik8FjTfi2u9QX7WU2sGh5QwxJxFurlKtJ03SP9FiiewNkYbKF3a/qQ8BBbMWIvncpIFKEtGRu9Q37wefxIKyDFI7SxaanT5k6CTHG6zo/Qw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=Ot7HBUT5; arc=fail smtp.client-ip=52.101.43.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="Ot7HBUT5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YDlmUt0hwjlc+nvoMtnn+jZB1BKTcDGlSNy5LVnr7o7w+Wx6vAmPWboVPm8UAv4zowLIxHyC24aQRrY050vUV+og0q19UdzxZLskO/6S0xTtxQPfneyOY/JkRL4g0OEodb1u0E3w1N2ux/ANA5N5Y0xLYdPA+vuQosr4XhXwMd689PZGOG4dYpIeoop7wgrSasDtS/lCtS3QGAlIB1R2foRbA50cs+CfbBf4zK1o4uTyeq3LM8J6HFRW8irnC3qZ8j9081xI1UhtMHMSdu/ctiHL8TLgq72vQBkYg6SQHtI3K1fNyTEvVdpsJSOl5lJ1cLmMfFm823cVrs+vupLJgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQWAbTfHBUuvaWuVGK0fU0/Xk4ZqhziM/7HefOMC/7c=;
 b=dMjjbsQ2u63QvH0GpN2lUCqbbyyoklRqILyPs4qYVjo6jvpHBUbPvO/aVZDpMK0IXaiBnAZEEtWiVc/OgO428zKu+0GMnmblmEu6U1xRyOfh9AE3AGc6f7GZGkBJpFoeEuQ8ZFbE179mFEkO7/9SWQia3dTp6mQfBPv/KUPlRl9KR63uJ3TsJ4AcJPlIkELD1I7bNT9e95zq4bI1LTvxZAvZ2rfi5C35+9mRB6IhO1+LH+FU+dMy/OWJxQlJXXtE8DeGxMxR7UqUd1DnlA9fQZpgLp7fZD9K7fq3SR4lUapvIZaWTc3co9DlwzZm57r9IWg6RntUVKIIxshtPc6uHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axiado.com; dmarc=pass action=none header.from=axiado.com;
 dkim=pass header.d=axiado.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQWAbTfHBUuvaWuVGK0fU0/Xk4ZqhziM/7HefOMC/7c=;
 b=Ot7HBUT5rd3CBYrQD8dsH7As3zCShvmNi2n/rvFDzVT6F+WJQR4JgExOx+eX4HY4YsQ+TAi83sChV8Bbb06t90Kg3BkzCZFgLDzl9CTo7Mb6a10rsdiS0DserK1zQ2wOT58DZroyX0cQhuPgRxrwwAO4x4ed0La3X41tnkiqxYt2q7FVRcmRriwB9XagqQUa0BcR+TvkfDbfWjAfspqnUy7KXbYf1MEgOyRsvkkoS/19f1sxs2gyfaFLO3q9tSpsRPixrHGR5gkQ+QodzIs7s7TpVBZl3MHiYYlFo0o1wZRmMIQ2aEhvS8BQKx8Uk68cWPk+Y1Jl9cFfCuyvouCbCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received: from PH0PR18MB4558.namprd18.prod.outlook.com (2603:10b6:510:ac::13)
 by SJ2PR18MB5714.namprd18.prod.outlook.com (2603:10b6:a03:570::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 06:10:59 +0000
Received: from PH0PR18MB4558.namprd18.prod.outlook.com
 ([fe80::7a75:75a5:694b:2311]) by PH0PR18MB4558.namprd18.prod.outlook.com
 ([fe80::7a75:75a5:694b:2311%4]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 06:10:59 +0000
Message-ID: <92a051a3-f9e0-4009-b6af-74ee2a95ff13@axiado.com>
Date: Mon, 12 Jan 2026 14:10:52 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: mmc: arasan,sdhci: Add Axiado AX3000
 SoC
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: SriNavmani A <srinavmani@axiado.com>, Vinod Koul <vkoul@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>, openbmc@lists.ozlabs.org,
 Neil Armstrong <neil.armstrong@linaro.org>, devicetree@vger.kernel.org,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Prasad Bolisetty <pbolisetty@axiado.com>, Conor Dooley
 <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
 Michal Simek <michal.simek@amd.com>, linux-mmc@vger.kernel.org
References: <20260109-axiado-ax3000-add-emmc-host-driver-support-v2-0-934f1a61f7c0@axiado.com>
 <20260109-axiado-ax3000-add-emmc-host-driver-support-v2-1-934f1a61f7c0@axiado.com>
 <176795814783.2967277.2609413382098901076.robh@kernel.org>
Content-Language: en-US
From: Tzu-Hao Wei <twei@axiado.com>
In-Reply-To: <176795814783.2967277.2609413382098901076.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0016.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:a::8)
 To PH0PR18MB4558.namprd18.prod.outlook.com (2603:10b6:510:ac::13)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR18MB4558:EE_|SJ2PR18MB5714:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f3ea597-a518-4a39-ccb0-08de51a15b19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|42112799006;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M2g5RlhXdmE3YWJQQS9KbU96anZKMzM1VXdyK3orMFVtam85emlDazI5U1Ey?=
 =?utf-8?B?MTRyeHpRb3JOYzVSWGdmbnVmZXZQeEF1ZEhuZW5RcytSTS9nV3dVSklJbUNU?=
 =?utf-8?B?NUo4ZFN3RzdBdXdGcGRaN29CazEvNUE1R2JkTnFTTVhNVEJKQ0F1aG1ZQ3ZS?=
 =?utf-8?B?MG8zd1Z5clBZd2dlTDhncjNZTG16V0FVM2pKeWZFK1hSZTlzeWlHZisxVEFk?=
 =?utf-8?B?ZkhlS0tyV282ZXF2UGNsUGpsMXM1SjIrTng2V3VHMEZvR1NvVjlydTRvbTZs?=
 =?utf-8?B?S0M5Z08xemQzRGpXQUpqV2ZuSnJRQ2ZNdzlwSmJwTXNvWHpmVkpmcFNYZ2ND?=
 =?utf-8?B?eGxhL2paVURJVkNsTWloY0xBa1VYL3UwNVpVNUdaSE9BTHczSkQ0MXVUSXBT?=
 =?utf-8?B?NzhoNjVoWXRQZEowd2J0NEpmNFlFU25YOEptVWZxNTBBYVcvZWc1dlh3U3VN?=
 =?utf-8?B?RkVmd3JtS01za0RnZVRMWkhPWUs2RUIrRmR0TFBmd1B2Nkk4N1JiRm1Kcmpw?=
 =?utf-8?B?WGtWT0lYTEpaTDlHcit2YjdCWWdTTVFpTVhacHZabzdSaHp5dEZtRjUrc2o4?=
 =?utf-8?B?SnE4dTFLYUJWZzM2TUNZbVVBSzY1bGs5a1BYY3JDbjRBdnViaXZhQXcyZUZ1?=
 =?utf-8?B?akpBZmw4QWozcXlYWTB3QVpvdXdaZjg0YmVMeGwvQzliNVlvL1pKV0R3K0kx?=
 =?utf-8?B?VGcwV0s2eVZETytaOXJpTGVPSG8vYWlycE1mS1VFbE5tR1RKaXVEMFFEYll0?=
 =?utf-8?B?RUhXSmpRWWVXUnFPdXkycFhDcFArRjVUcWpBS0IzS0prN0gyWVllUzR3UWE1?=
 =?utf-8?B?R0ZlY0NEc1BabmhTVzY4MnNlMy82d2htTEd2NktUeko4WlZlMENlWGtGQlJ5?=
 =?utf-8?B?Y0NwTngzeHdONk1UemRVNTZrZkNNekNuVTNSdjJ0YkJtdEtBMmtuTk1YKzBu?=
 =?utf-8?B?VGpRVzJnWDU5RXJmVVBRbDJHajNOdFErUVhRSFhwZTU2Vk9CdGd3cGtGYndS?=
 =?utf-8?B?TmlvUjVQVW56SnIvY3dpWFhDeEFxTXRWZ2daRXRyQytYckVTS2ZBL3RvaEVL?=
 =?utf-8?B?NWpsNnAyOTg3d0FEQkcybUExUmdlVnlqb25JenI1UWhicldvcWVqekUycW4z?=
 =?utf-8?B?WnNTbFFOanRJUUxTZlM3aWFOOVRIZkxoRjlxS1gzTHBxa2cyQ3RWZUF0NFlR?=
 =?utf-8?B?ZjRDbEpMdTlxbjBiaXgrQzRjOTl5VnJJeHIzTDlUWlE5MDRNQmhHRFFodURa?=
 =?utf-8?B?b0dLeTZIS1loSjd1cTJDWEVCSm5zbHBKdnF6NnVKbjZSNGFXS3VhOUY2OEJk?=
 =?utf-8?B?bWhWZG1lMzQ5MG03dFFzSGpFQktzU1J5c3RVT2dwcGhNK3Y2cG5aQnNxeis5?=
 =?utf-8?B?bE5uUTZtL2xaVXBKZFNRSlRKZTZzWnRDTkFhMi9TN0p1NjVUdzM2UW9TeHdj?=
 =?utf-8?B?VmRyQTlDSTZpN09RZ1lsVzhyZGZNSjhqS25ab3BBYldHZ213STVQbWppUndi?=
 =?utf-8?B?UTVwbGNaUGprcHNKeEhlTVo5TWN3NlZPbXNDd2VNdEROdTlTb3pTOXJYekRZ?=
 =?utf-8?B?dFNLWlRGQUtGSjJ6WnNSbFQxdVNoVzEwQnl6ZXkrM0s0K2hQWEJmanFSOHcy?=
 =?utf-8?B?VnR1ZXNadEIxZmU5ckpDSHlHZkptdThGQ0dmU05ROVZHb0tNTko2VVFIMjNE?=
 =?utf-8?B?R1poeW9tTVhoMnNtVzl0RThJRHJJTThlRk9peU1NWityNlJISHFTeUVXSk9y?=
 =?utf-8?B?Y1E0T0czdXhqWWdSQU1yOXp0dG1Kb2k1YlhId1FKb0pOMGRRMXJzSjNqQ1NI?=
 =?utf-8?B?a1ZhaUxWQ2VxN0ZYdGtpSnl0MmV5S2tDUEE1QVZYZzNwdkVzK09VV3VYMC8y?=
 =?utf-8?B?VUY1WUs0ZGIwL0xOYTFmTEN4eCsvbmlWYkptc2VteWVDWHkyYWVLYnRoazN3?=
 =?utf-8?Q?8t42yQKEQ9HrBD1ZlEHWtyMmLkTCPchF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4558.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(42112799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFAzZS9uR1BLSTJrWGQva0daQ25nV1ltaDQySU5xcGVOT2hBK0VmanZjSGpB?=
 =?utf-8?B?ZlY2d0RmN0xXRzk3WXI2ZzhweVBsQm5VbUVIWlZUOU9IeWF5ckZjSDVnUElP?=
 =?utf-8?B?SlIrcUR0NlhlTnlaTEZ4bUcxbXducnNxc1VZWTJ5bFI2UkdoNk1DcXlRbHlm?=
 =?utf-8?B?Qkhpck5FSzV4L0VteDRyVEZTMHNiZmRDbURxT3FCWmRvR0N4RHV1QmwzWTBD?=
 =?utf-8?B?SmNsSDZ3ZGtkNXZZNU55WW1zdGNmYXV5QnphcEtycUU4TGZkSGdZalVBWDJK?=
 =?utf-8?B?UGc3ajRRd0wrUU0xM01jQUQyK2NxSCtaQnZIcjJ2QWwvbTdTOVpqTkJGNEVz?=
 =?utf-8?B?ZXJSL0FzK253K09pR1VpL2wzQTNma1FaV0J5dVlCajJCdlpURzlUWmphRGMw?=
 =?utf-8?B?ekN1eThHc1Bhb0k0N0pzdDU0QWtERmdNcFpQWGFVUm16Sy9VNURtYXBBSXN0?=
 =?utf-8?B?dVdMVDNzQVQvUklKWTFLSktGelNsRmYzVTJMcnlLMUdwckkvUUxGeXZ1TmJk?=
 =?utf-8?B?YWd6NWViakV0UTNaUjJUcjFSZlZaYVZvMzl0OXVnS0FvVU90eUV5OThkVmdh?=
 =?utf-8?B?VjAzVmRJSVdqRXV2MWx2aHB6U3pBUHh2MnptcDUzRm1GaGc0Y1V0azdrT0xI?=
 =?utf-8?B?dkJ3ZUpDcDFRdmZ5dmpmNEJSbnpjY0FtdDhCdUdsOVFvWFJ4UDRJR0NlbFBV?=
 =?utf-8?B?RlAyOEZIMjZncWxxUklBTzh3UjhVeDBINnRlODdlQmI1ZmRtek5rbEsvK3Ey?=
 =?utf-8?B?VnFuY0JKNjJmQ1B6RVA4YktVZjgwYzhHcFBRS0JSWWtqbmdneWk0YUd0QlFC?=
 =?utf-8?B?UENzSEs2MWk3MDlNdS9vY2hSaVpxSGQ3QytyZVNFWnBNbGlRMjYwZmVrVkxx?=
 =?utf-8?B?aXRnb1IvMUMrVzQ0RzVPUGF5dHpmRkhLU3dCMEdteVVnSlErL1RrbXI0SVpj?=
 =?utf-8?B?S0pJcFNnMzJPdzVmdkRXRFpPY2M3SEcycVN2Y1NzbXpuc3BUZjd6NjBKY3Yz?=
 =?utf-8?B?b3RiNU8xNDkwdmUxUmNlRi8vK2FSS1Z3bTlEdXpiS1hoRTM5b3dMbmVYMURT?=
 =?utf-8?B?cE55ai8yby8vdHF3UzNSRDA4WENVUUh5U2xFY1ByKzVLUTJ4bC9mTUhoMUZS?=
 =?utf-8?B?TndXT0c0MitEYnVlenJrd205VHkrZFlvOEdZU3UyeU1zTUlhNWpYMlFIa0pL?=
 =?utf-8?B?QXgvZGRvdUx4enViNDQxOG93bytUSWFNSWJYN1FIWjZtL3RoS3pKODc3Q1Yz?=
 =?utf-8?B?Mjc2dnhQR2twb3dnWFNaejhqdlY3V2piYnNmNjhaSGdOU3NsYXlYSHI3a3BR?=
 =?utf-8?B?bWkyZ0pvUE8zZVlqZHI5L2ZGVFV4KzFMUzIvakFFSWczeUY1TmdqRUFMN3BT?=
 =?utf-8?B?U0hZVlZEcjg5QStQU1lmTXRBNjdCSnpEWFh4d3pTc29FamVpWldDNVFibHV1?=
 =?utf-8?B?Z1gzWWtGZFpvK20xMWxLM2s2ZExsVTNHekpwT01PNHg2VUYyVjl2Ymhjbm5O?=
 =?utf-8?B?dFJNekp3NEpoKzcwYlJsR2dBOFVPWWFlRFpENmVVVitVWUNHMndrZzZHcEty?=
 =?utf-8?B?Vjh5dGt4YjJYRHFMWFloRkJ2d2hOZWUraWwzdzBkSWlCcWtYQjB4ZTFwMXA0?=
 =?utf-8?B?YytGcy9mWkxadUp3VjVrQTZrYzNNY0JGSUYyd2d6cHNVcTdmclc1NmJFTEIy?=
 =?utf-8?B?MjRuaHFweHdUc09NTHFLdUIyN0dSNkNmRWF6WlRSM2tlR1dMdmFKeDhWeWxQ?=
 =?utf-8?B?MXU0TElYRUdIN3AxZXU1eWNzem1Ta1psR3lpR3VSRGxHbFZJa0pWb2FOcllj?=
 =?utf-8?B?TzVmdkk3OXVocm9DTHFlUnFNSEt2WG0zNUtmYW0rblA5SFVOaStzNTZ0TUsy?=
 =?utf-8?B?L3NWdzkzZGYwZytXaitsTUhjb1Q1cE1WcWNSSVYzd2d3YzNiMjQ1azFTU2pD?=
 =?utf-8?B?cTdOUVVDRDZmRlBJaExGV243RXBvZXVpbkxqZldEeUpyV2wzUmFxeWdLMXhK?=
 =?utf-8?B?QVdiNnFCREFvSVRlU01Pc3ltdDFkUUc3T0ozWk0zNzFpSWs3M2YwSW9PK1RM?=
 =?utf-8?B?UG9TdXpWKytkeit3NSsvOE5yK29xNjJjYkROUXVaTXQwT2l5dWVvcEpETUw4?=
 =?utf-8?B?Y2RrbmtLaWM0eTczQld4N3dkN2hTVnY1L3Q3MU9ITW9QNlZYYU1OQmJJcWZF?=
 =?utf-8?B?WmFmTDZMcVVEelNHMGtOcTJvcHdRd1l4TXNZWnYrYVhYV01IODdZcjFHRnRL?=
 =?utf-8?B?ZTdHTkRIUVZHNHFISkdzbS9tOE9rT3g5WlVFVGg0YnRIUUl4Uk9jZ2JWZ3NB?=
 =?utf-8?B?cERmb1dDT1MwemtPU0NORHpFVGp0ZHQrb1d3SzlaWDlQRXRMb3J3UT09?=
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f3ea597-a518-4a39-ccb0-08de51a15b19
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4558.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 06:10:59.7079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uOpsKLj3rodkahUymOlJbBieYRfkNDh9y/lmimGOkmTW+xbviUtgFq4zDltcuYLz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR18MB5714

On 1/9/2026 7:29 PM, Rob Herring (Arm) wrote:
>>
>> Signed-off-by: SriNavmani A <srinavmani@axiado.com>
>> Signed-off-by: Tzu-Hao Wei <twei@axiado.com>
>> ---
>>  Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml | 3 +++
>>  1 file changed, 3 insertions(+)
>>
> 
> My bot found errors running 'make dt_binding_check' on your patch:

Thanks for catching it. I will fix it in the next version.
