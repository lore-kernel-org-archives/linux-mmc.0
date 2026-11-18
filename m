Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.3
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795019346;
	b=mznaW2NpSHQM3pk/+Y9Hq6Rm9xuC2FXtnUZzz8Dfq+foYmvCaSSJQuhrrE2bJx3pQhM4
	 gS6PQbhvZYT0L+sD7Na48PhBjsBVo0lVt6Zj1UsXyipZ6yy1iV5+mCZzqOmLj9Vxg0+R+
	 LcHT3L5zH9ZS0mohU6GitWRfRlTkys2wIw8XQVYvChaAcy+Xy9whi4YLrXoHKHvemSplM
	 HQOKVYVbqZLL0jtp49HRNMzxky1/UUb2yDrKd0NKJsZHXiwgOJR3qZldCo+Rd+m6gTxB+
	 qfQxdIQIFcZ2fwhc71igdPqvuJ8CuMOZ2mMT2TdtNMrUSvwA6is8znMhfOuHMli+DAA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795019346;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=5TLR5lrhBxnZ3+0KfXPdOxbRP/l2BF6QG9MgRDSexhM=;
	b=lstGDftdOAZM1c5HIY5qHqogF6HJUG9uatl+eUVWpSFxgJ+g16CBczbJB8iC8vQhCnCA
	 1ozjuQJlG/fNq6RntYr/5XNXBaymJbxXjlURrczau6n0Jc/GioyspYc3o/MqSF6z1FhWs
	 PXFMRVyoJrkuVzNvLjWNEhb7w83JGcrxDsVFvBpGVPkl4v7C8m2esEQiMLe73Vm3Rtedy
	 A3SGXoZyVGiGLr0OYrh0OD2TRTnEKJgL/ypHiWIM+zaFi1Vv0z4hkO0wmmTNrCYi78oCI
	 d1z97zMlvvwhHqCT3pNpfBMtO/mPSXaIkLGiYX9GKQ44AtLHt5126MgOY0lREgZaQcA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cherry.de;
	spf=pass smtp.mailfrom=cherry.de;
	dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=UZ6OdbOR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.3
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012003.outbound.protection.outlook.com [52.101.66.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CC8606A32C
	for <linux-mmc@vger.kernel.org>; Wed, 18 Nov 2026 16:29:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51CC8606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=UZ6OdbOR
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f6EK9ON0d/TTpZQKSog/X/lxo5lzfz3K2y5HxlfX13GfVZfDWK7LCL/PRMaFrhOZHhByPzq3PHJcK+dgZl6USWTdiQ2UVnCqNNZW2HVJIKokzFRU1arccRvraCmrn2siM3pPOakjVKnwwchc8QoDpJAQDcHuQOH7WRvIgjQ6RP1UxJ3xwvVdF9wzxqTjKhX4cpG5ms55DcnGiuO40tAbu1sJpKPb70uf/ijd/NkJamPDod4pULh1+j+igqRqhcFw3LKjYtpdwQxOKckGeyA2ltUYaUNhXa/qXTCtnG5NfzwHM/f9wHhcWz5YNrQgGuLwpnmmJOo+rWZtwEJsSl5Bfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5TLR5lrhBxnZ3+0KfXPdOxbRP/l2BF6QG9MgRDSexhM=;
 b=XG84KaoZ9+t+JIw3bXT2KNrRmQ/nkEPN5Yp5GvqkeVwtfIrw/VL9ql6QvTcEPDhEopIk3Tp/mom0NW1IA28ySrZJHUoPWOl9OdHJSdo4PIPCqnSBuakeTZOk28Rt+jTVrctDYlVbZyilOaBYLEyjegoHem6s48wlRR2XgoEA+yCIRxiL5UaZbTG2a8xSPn8ce8gGnn9XoKdThFO41mS/+vKCKepFCSJzcAxQDH7Flc+iIkSWrBhyFQFQMadd1znVsjeDR88eM7hkfAgCMoE/XP+TWeuz54++vl70RDJcy3I37nqPg11Ah1csJ8Ru/U3UqaU9B5wB8W/IFfoWjDo6og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5TLR5lrhBxnZ3+0KfXPdOxbRP/l2BF6QG9MgRDSexhM=;
 b=UZ6OdbORvwyk+S0JZmz8AgIEz/XXlxZ570gOo02tZqwwpFfUjyucKZ9mGWYYr/3hUGr9yUV4x/b0A5Xv1Qrqi9kvaRgN5TM66PD99hPN26P8GK7348O7i1SD96XYw/uKiaE5f4TOaS7YN+qexbUseabyRyuod7cLUvVexmUniTw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12016.eurprd04.prod.outlook.com (2603:10a6:150:335::6)
 by PAXPR04MB8460.eurprd04.prod.outlook.com (2603:10a6:102:1db::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 16:28:58 +0000
Received: from GVXPR04MB12016.eurprd04.prod.outlook.com
 ([fe80::f2d4:9db8:9a4e:b0bd]) by GVXPR04MB12016.eurprd04.prod.outlook.com
 ([fe80::f2d4:9db8:9a4e:b0bd%4]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 16:28:58 +0000
Message-ID: <717bb590-4069-4564-ab9f-03afd42da5d6@cherry.de>
Date: Wed, 18 Nov 2026 17:28:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-of-dwcmshc: Prevent illegal clock reduction in
 HS200/HS400 mode
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson
 <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-rockchip@lists.infradead.org, linux-mmc@vger.kernel.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Yifeng Zhao <yifeng.zhao@rock-chips.com>
References: <1766387485-205480-1-git-send-email-shawn.lin@rock-chips.com>
Content-Language: en-US
From: Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
Autocrypt: addr=jakob.unterwurzacher@cherry.de; keydata=
 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
 ldPHIqbIwpfecQ==
In-Reply-To: <1766387485-205480-1-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0133.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::17) To GVXPR04MB12016.eurprd04.prod.outlook.com
 (2603:10a6:150:335::6)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12016:EE_|PAXPR04MB8460:EE_
X-MS-Office365-Filtering-Correlation-Id: d68a1f17-59d2-49db-c7a4-08df45910c03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|261102123227099003|10067099003|261021121427099003|56012099006|11063799006|261022105027099003|261026140227099003|261022075727099003|261028144727099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	Hq+N57v+pDjHGIBMJhdp+vBhEXwZVyS1OsE865zdcO1+eZFLkeaeJsYmFpJq5EzshuDrYhqfVJsujA+n70+YeUC2hnEVm+pIUU30vGQkdvdM74D+cbvWvC5jD/D6yUea4mD9ulgnl11MgJVOzrSD99DBiwvrHnjef9JFzH3GtYnNk/nWtbOCEwoiKLgBVwHqKx8/SszF6LrneXvqxpEGiAc3WsyiqULuHnJDGPHAlHT5+avx4KFa5scsLMkYzHHdrfK+ntVdEHWN9LyDxCHvRCWgTPEp1eX30/iovgrMDRdKzLkOKx96DhRYgiTR1XqV/S8NCZN5cYjX6JIgEWIQuX8bbe608k6INnY60ATrRhk1662DrLINJmm/OGCFimxTRFXHmFA54TEiG2vt0pDX/NftepTgb18RuxL9dXu2K0erYnhnvX8fpP3juOUfjA9QZln/3JQE5NtHcR/P8M+QRA/5pHjooaz7k6FybwRBnLwQn4dlGttt54uiOfOT9GuFuJ9f2akCbxcJV4qrzTmEQEv9fbRkDPSl6IdqAfCABtGLdExEMf4zR904OsZmDeUVIEkDMkOFg17OMozfR57Tp/4XvzT32iXHNorb+cWq2LzgqG0zd4jsi8BO9/sgCiEb698MCXI7bWk7QMH+zKpdMvZgiv7B1zBZ01h2KLblNIc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12016.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(261102123227099003)(10067099003)(261021121427099003)(56012099006)(11063799006)(261022105027099003)(261026140227099003)(261022075727099003)(261028144727099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aHF3MTF5NjI2L3dhUGFVWXE4aWg4L3FuU2hHMTZWeDYxbmZSamV3MEZSamVW?=
 =?utf-8?B?VUVxdW14VlZpdXFIUWJ6dkhHQ09pQ1Q2Z09TWE5SdUUvVS8wTzI3LzhNdTQr?=
 =?utf-8?B?UEc0TEhvV2VZQlBRS2IxejMvVWxJVmFGclVpY3ZKalRLZ3lweFJPWkJvTzJv?=
 =?utf-8?B?Ykg0SWhSMTUwWksraGM5TlVPclk5YnVCYlB0aGpjQWxQWnkwV0wzQ0pzQll5?=
 =?utf-8?B?MEZyazU0VGM4Ukh4YnVZQkhpR0xLd0hUOWphOHdkOWUrZ0g0RWFVeDhBMzFT?=
 =?utf-8?B?dEtJQUNRT0c3NW1VclFrS3VVeS9IdUdZRzlnYmFkUXEzZ3NtT3l5MDBsVmtO?=
 =?utf-8?B?RGMyWjNzekFOS0tzWENkMEFEVzRYMEtleVk0alNJeXRoYWZTUXFOVEp4NTJI?=
 =?utf-8?B?UlM2c0pLT0ROU3pHaVB3dVpJUzErSGV2RlFFTm0veEJTc1RuQldsY2krZmhk?=
 =?utf-8?B?dExtVzVXVFFXd2pybTYvVEh0ODJhN0hYQUdwUzlvQWNhNjhqbU9FSjJYL2dM?=
 =?utf-8?B?YkZGRUZqODdnb1lPa01VeDcvdDlRbFJML1NCM21LdndncE9VRmlveG5IUFBU?=
 =?utf-8?B?cC8yK25DRGRMamRSR1dyZld6NVUzd2VxT3U5aGt2ZU9MRjFDL1dZWTVEQ3U1?=
 =?utf-8?B?cWZsTEdYbUJ4ODN1MkZweGx3MjZLRXBJWXdMK1QrK1VmbC9NRHpwOW5STjVa?=
 =?utf-8?B?aFBtSGtja2Y1YzB4UEpydFlVTFgwY3hkRi9LTjluN3BJN3hhTUoxL2FHa1VT?=
 =?utf-8?B?bEZuWkthQTZJV05kOGh1TXpmMit5MnlKSnl5MEFlUko3N092Z3RPeUNQc3ZT?=
 =?utf-8?B?RndCSTFlejJ1RndVOFIyRVppQVREVk56RGk2ZFBrcGlFZjFWY2JLUnpJV25P?=
 =?utf-8?B?aVRPQUxuU0tTNlJwZzU1clVkM3plbDhRMFJtTlRpYjI0aHQvNXZSMDY5V2Fz?=
 =?utf-8?B?dVNIN0tQaUZ6dGZzYk1QQmNOVVhybFFUNWxmaERjUDFaendqMThkdHE0QTBz?=
 =?utf-8?B?bDdDQWJKaTZHWkg3NERTWXY4UGx6QTRJcTFKSCtOMlNjRTNBTHVxcE51WnZx?=
 =?utf-8?B?K0pmOTByVlBRK2s3L2pNeEloaGFBVmJ3WXVyUktDbHV2a29wM211RlA2VXo5?=
 =?utf-8?B?aFJoNXFFSDM5UmhzU0FpYVhOY1E3RTlEVXE5ZU5EekY3b2NHemJTczRacTVT?=
 =?utf-8?B?USthRlR3dVRLek5sT0d3TXBEa1ZMb1h0WFpWbzdocWdwR3Y0MW8zY0loRHF6?=
 =?utf-8?B?OXlWb1A5NXRJa1diazNtNHJtVVBucXB0VkZ6WEtIVHIxd2ZyMmh2Q0oxZTd6?=
 =?utf-8?B?SG5QU3NQWi9YNjQwaHhDWFo1cW1IRGd4azF3VXd0L0lpb1FDU0RtbmtDVldL?=
 =?utf-8?B?Wk52USt5SlZhTmh1eW1yTmtwNlJUWEY0M2JHRzhxajdQRkF1OXlLU0Y4ckFK?=
 =?utf-8?B?eCtLd1F1MEpGTWFDWWkxU3U0TEVSYmRmTUxsMm4zMS90ZEVwL1RJekc5YUI2?=
 =?utf-8?B?QjJVNWFMOTI2b2hRclpLcWpEdy9aL2RyUytoSGRPaXFvSElEZ252azhoZ3U5?=
 =?utf-8?B?U2VQTVl3U2laYUl2aW5GSVVwUWFQRHkyazdnZUhJSlFWQ3VzZUZGYlFSSDZm?=
 =?utf-8?B?UTBla0c1a0NvRXBrZkZnT0FkLzBjMG1JVHpZWDFLd292N1A4T0tVeG1zdDNv?=
 =?utf-8?B?THVBL1JTd05lZmdhNG83eVNUOHdoUlR5VnJreXlTYy83WFcyYWRCQzBLVmpj?=
 =?utf-8?B?c0tRWjFZWUZDL1duaDlJa2dKNWtRODdyUFpZcmtDMTkxOEpSdERrWU5pU0gy?=
 =?utf-8?B?ZHZCajZWY3FZOWpTRW56VzMzclNjS1JnQmlWaTNFTzdmZSt2L3FDR0RobG90?=
 =?utf-8?B?Nk02ODZrRVFJNUNuSm83WXRVQ2poK3FMeiswQy9TNEVqZmlBT0ZOWWJZS3ho?=
 =?utf-8?B?S0s3QUU4eUR5REdqeFIzZWxzbnFoSTg0Ynlab2piQTBBUjdMK1RiY0RkYy9l?=
 =?utf-8?B?YXhxNmlabjcwY0RqV0VYdFV2ZWNHdnFtRDIrcWpneXNvcXRDemw2Mm1OZ0R1?=
 =?utf-8?B?WXp2NUNYU2lGaG5Cb1NobzdyVWhTY05GbDBqUDVJdk1ncFhPLzRIOHIvVGQw?=
 =?utf-8?B?T1pYN2M1ZjlUc3FmUUljbWZlQ2dubVQvV29FQ29tZkpXQ2VDU3F3MFNDNTk3?=
 =?utf-8?B?SjdDbDN6ZWZYdnlDWWpRQ05TUjVDdU9URStuUzNDaEVMK0lFVzJxUmo3RHNS?=
 =?utf-8?B?M05PWmhYNGxmNlNBemVIZDR2Q0ZtREdMQVJickVCRDUyZVFEelNuOTRjYTFs?=
 =?utf-8?B?Qy9LanM3N2VPQjRtdDhlYjYwU2NUYTlUL0VtaXVVbm9kdlV4NVpYU3JDK1Rk?=
 =?utf-8?Q?N8oeD7zZw1/Wx32U=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d68a1f17-59d2-49db-c7a4-08df45910c03
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12016.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 16:28:58.5495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yl767V1w4MmhJoVg5M/kGT4XxlKXuYt3HZUCcQXYlXEjkulR6ekACAoZN+HrSrOFz1OaDyTyPyIUWeCdBizYowG6JxCrM5cX5jwUUbHuXCA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8460

On 12/22/25 08:11, Shawn Lin wrote:
> When operating in HS200 or HS400 timing modes, reducing the clock frequency
> below 52MHz will lead to link broken as the Rockchip DWC MSHC controller
> requires maintaining a minimum clock of 52MHz in these modes.
[...]
>   
>   	if (clock <= 52000000) {
> +		if (host->mmc->ios.timing == MMC_TIMING_MMC_HS200 ||
> +		    host->mmc->ios.timing == MMC_TIMING_MMC_HS400) {
> +			dev_err(mmc_dev(host->mmc),
> +				"Can't reduce the clock below 52MHz in HS200/HS400 mode");
> +			return;
> +		}

Hi,

Booting v7.4-rc3 on RK3588-Tiger, this error message triggers three 
times (I have locally added "clk=" to the message for debugging):

> root@tiger-debian-debos:~# dmesg | grep "reduce the clock"
> [    0.585607] sdhci-dwcmshc fe2e0000.mmc: Can't reduce the clock below 52MHz in HS200/HS400 mode (clk=733137)
> [    0.585625] sdhci-dwcmshc fe2e0000.mmc: Can't reduce the clock below 52MHz in HS200/HS400 mode (clk=52000000)
> [    0.585636] sdhci-dwcmshc fe2e0000.mmc: Can't reduce the clock below 52MHz in HS200/HS400 mode (clk=52000000)

Should the error message trigger only below 52000000,
that is, "<" instead of "<="?

This would get rid of two of the three messages.

Thanks,
Jakob
