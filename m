Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34016218E91;
	Thu,  5 Jun 2025 13:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749128778; cv=fail; b=dcEOfkh5RMXSvmFZUMBN8yeSAlfHZyBdViLEcp0l8weIV6cGbtuAPbv4f0vUv6Njfb3yGvrc7iz17FqqSgYwAdkXAC96spA521a/xm35UosVzU8I3X3Hyh8k40RF37WGFKclTeoeihLA1r6gOQdlOsZ/IjRpa6R+LGHKwHRcyVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749128778; c=relaxed/simple;
	bh=dFr3w9vasqBpb42r/ZZVWtv+fJNfB+/2sFUTvoky2V8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FiqBP6Nzdgl0CcTYsGvLreOb0kK+UyE5oGIx6kNFuCTXbOlaUVU8AamYuvexPBWBJiWpoQ40x/kKztl4M9FCuZ39R+kz9MNsEb/afGDxLvvb1dWhTmuSXeUVyOjBXnEHFklycEhVO1cy06Pul+hLRhN5a/77SA2It0J/jUqRi0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aHio6u5+; arc=fail smtp.client-ip=40.107.220.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aHio6u5+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ciX8OAzuajkMinA7XrBmRjU4uyaMzggcUWPaHEIkQdXSA05SDVk+/2KaHMUidhnsgWIQyVRNVxtpdTFjynQFPyDnNn7nJHPiYPThy7vthYQWVuG0O4F4lzDPQLKWg44Qng2qZstrmOEI72nsfA/7KYVz57pTpTfmTi/xUhCT5HBOTUXfgWh5r6NpMuzm7nrzStZW0WDfcJaGw5EPF9p3W0XF3TuUqowM+HJihS7ffiG5QK8DvEb2jk5iuH5vZ8l93Xf7VzC+iUu1l4IbQNzXodlPz6LyRHBOnp8qDlW2C3/pt6UGFKtfC6Tp6hw4nD+uqZZzTkU1OQrmRcGj4OwRNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CbJK9vWWtyLratkSry/8cSiaLDvyaepDzZutEwO7uzM=;
 b=aEULLNkMjWZc/mv5UxBYXyHwh5eSWeBHqKN09yjrBqZZ3YskWZBe8YLFF/Z6w3JoGHBJfLWKw/anV7Ngyr9XrwweQD4rL+d1Yj1P3nIgKkbhENqYoYWlgAIv9kqe0AcKi9VkgzuFb9YQN7HeqMaOCob84RKZJBx3rvmmaJmscVymxRVBzSPt4dt3O+qOD0eJwWEAvj/N34GJ8FUvS8JdqubEb/+S8+wsML/ADsO+sQFPlIZhFPd/lSMjadx8XorGeLBu3mI1Uo2z8kgdFWA6KuVyPZOdVsH/2C6QguC6kgaHJgzYZ2Nmd0TIiw6ElCDFKqhgzyOBiNgGZmyNBxX3nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CbJK9vWWtyLratkSry/8cSiaLDvyaepDzZutEwO7uzM=;
 b=aHio6u5+ZW7LfEiGiLykw4f3fXswHertTsGD3bZZtxKRfRl3flAtQe8m8qzVc4ITIPPSjyjp7hiTTi7DdvdqcSVJSN1Fk2ILNlzbstNPdzX5aySMULTLx7NgOywnHqEgfGEgNbgLAbwIUg3WSak65EMaSiKrpvnHboZP+3xL/6E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by IA1PR12MB6555.namprd12.prod.outlook.com (2603:10b6:208:3a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Thu, 5 Jun
 2025 13:06:15 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.8792.034; Thu, 5 Jun 2025
 13:06:14 +0000
Message-ID: <ea3d2867-3f5e-46cf-9db0-fcd7b29eeb36@amd.com>
Date: Thu, 5 Jun 2025 15:06:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: mmc: arasan,sdhci: Make interrupt optional
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
 git@xilinx.com, Adrian Hunter <adrian.hunter@intel.com>,
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..."
 <linux-mmc@vger.kernel.org>
References: <a527f5adffc6efe4c1ad2ccc40e1e095d73efe74.1749027112.git.michal.simek@amd.com>
 <20250605130331.GA2370690-robh@kernel.org>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 xsFNBFFuvDEBEAC9Amu3nk79+J+4xBOuM5XmDmljuukOc6mKB5bBYOa4SrWJZTjeGRf52VMc
 howHe8Y9nSbG92obZMqsdt+d/hmRu3fgwRYiiU97YJjUkCN5paHXyBb+3IdrLNGt8I7C9RMy
 svSoH4WcApYNqvB3rcMtJIna+HUhx8xOk+XCfyKJDnrSuKgx0Svj446qgM5fe7RyFOlGX/wF
 Ae63Hs0RkFo3I/+hLLJP6kwPnOEo3lkvzm3FMMy0D9VxT9e6Y3afe1UTQuhkg8PbABxhowzj
 SEnl0ICoqpBqqROV/w1fOlPrm4WSNlZJunYV4gTEustZf8j9FWncn3QzRhnQOSuzTPFbsbH5
 WVxwDvgHLRTmBuMw1sqvCc7CofjsD1XM9bP3HOBwCxKaTyOxbPJh3D4AdD1u+cF/lj9Fj255
 Es9aATHPvoDQmOzyyRNTQzupN8UtZ+/tB4mhgxWzorpbdItaSXWgdDPDtssJIC+d5+hskys8
 B3jbv86lyM+4jh2URpnL1gqOPwnaf1zm/7sqoN3r64cml94q68jfY4lNTwjA/SnaS1DE9XXa
 XQlkhHgjSLyRjjsMsz+2A4otRLrBbumEUtSMlPfhTi8xUsj9ZfPIUz3fji8vmxZG/Da6jx/c
 a0UQdFFCL4Ay/EMSoGbQouzhC69OQLWNH3rMQbBvrRbiMJbEZwARAQABzSlNaWNoYWwgU2lt
 ZWsgKEFNRCkgPG1pY2hhbC5zaW1la0BhbWQuY29tPsLBlAQTAQgAPgIbAwULCQgHAgYVCgkI
 CwIEFgIDAQIeAQIXgBYhBGc1DJv1zO6bU2Q1ajd8fyH+PR+RBQJn8lwDBQkaRgbLAAoJEDd8
 fyH+PR+RCNAP/iHkKbpP0XXfgfWqf8yyrFHjGPJSknERzxw0glxPztfC3UqeusQ0CPnbI85n
 uQdm5/zRgWr7wi8H2UMqFlfMW8/NH5Da7GOPc26NMTPA2ZG5S2SG2SGZj1Smq8mL4iueePiN
 x1qfWhVm7TfkDHUEmMAYq70sjFcvygyqHUCumpw36CMQSMyrxyEkbYm1NKORlnySAFHy2pOx
 nmXKSaL1yfof3JJLwNwtaBj76GKQILnlYx9QNnt6adCtrZLIhB3HGh4IRJyuiiM0aZi1G8ei
 2ILx2n2LxUw7X6aAD0sYHtNKUCQMCBGQHzJLDYjEyy0kfYoLXV2P6K+7WYnRP+uV8g77Gl9a
 IuGvxgEUITjMakX3e8RjyZ5jmc5ZAsegfJ669oZJOzQouw/W9Qneb820rhA2CKK8BnmlkHP+
 WB5yDks3gSHE/GlOWqRkVZ05sUjVmq/tZ1JEdOapWQovRQsueDjxXcMjgNo5e8ttCyMo44u1
 pKXRJpR5l7/hBYWeMlcKvLwByep+FOGtKsv0xadMKr1M6wPZXkV83jMKxxRE9HlqWJLLUE1Q
 0pDvn1EvlpDj9eED73iMBsrHu9cIk8aweTEbQ4bcKRGfGkXrCwle6xRiKSjXCdzWpOglNhjq
 1g8Ak+G+ZR6r7QarL01BkdE2/WUOLHdGHB1hJxARbP2E3l46zsFNBFFuvDEBEACXqiX5h4IA
 03fJOwh+82aQWeHVAEDpjDzK5hSSJZDE55KP8br1FZrgrjvQ9Ma7thSu1mbr+ydeIqoO1/iM
 fZA+DDPpvo6kscjep11bNhVa0JpHhwnMfHNTSHDMq9OXL9ZZpku/+OXtapISzIH336p4ZUUB
 5asad8Ux70g4gmI92eLWBzFFdlyR4g1Vis511Nn481lsDO9LZhKyWelbif7FKKv4p3FRPSbB
 vEgh71V3NDCPlJJoiHiYaS8IN3uasV/S1+cxVbwz2WcUEZCpeHcY2qsQAEqp4GM7PF2G6gtz
 IOBUMk7fjku1mzlx4zP7uj87LGJTOAxQUJ1HHlx3Li+xu2oF9Vv101/fsCmptAAUMo7KiJgP
 Lu8TsP1migoOoSbGUMR0jQpUcKF2L2jaNVS6updvNjbRmFojK2y6A/Bc6WAKhtdv8/e0/Zby
 iVA7/EN5phZ1GugMJxOLHJ1eqw7DQ5CHcSQ5bOx0Yjmhg4PT6pbW3mB1w+ClAnxhAbyMsfBn
 XxvvcjWIPnBVlB2Z0YH/gizMDdM0Sa/HIz+q7JR7XkGL4MYeAM15m6O7hkCJcoFV7LMzkNKk
 OiCZ3E0JYDsMXvmh3S4EVWAG+buA+9beElCmXDcXPI4PinMPqpwmLNcEhPVMQfvAYRqQp2fg
 1vTEyK58Ms+0a9L1k5MvvbFg9QARAQABwsF8BBgBCAAmAhsMFiEEZzUMm/XM7ptTZDVqN3x/
 If49H5EFAmfyXCkFCRpGBvgACgkQN3x/If49H5GY5xAAoKWHRO/OlI7eMA8VaUgFInmphBAj
 fAgQbW6Zxl9ULaCcNSoJc2D0zYWXftDOJeXyVk5Gb8cMbLA1tIMSM/BgSAnT7As2KfcZDTXQ
 DJSZYWgYKc/YywLgUlpv4slFv5tjmoUvHK9w2DuFLW254pnUuhrdyTEaknEM+qOmPscWOs0R
 dR6mMTN0vBjnLUeYdy0xbaoefjT+tWBybXkVwLDd3d/+mOa9ZiAB7ynuVWu2ow/uGJx0hnRI
 LGfLsiPu47YQrQXu79r7RtVeAYwRh3ul7wx5LABWI6n31oEHxDH+1czVjKsiozRstEaUxuDZ
 jWRHq+AEIq79BTTopj2dnW+sZAsnVpQmc+nod6xR907pzt/HZL0WoWwRVkbg7hqtzKOBoju3
 hftqVr0nx77oBZD6mSJsxM/QuJoaXaTX/a/QiB4Nwrja2jlM0lMUA/bGeM1tQwS7rJLaT3cT
 RBGSlJgyWtR8IQvX3rqHd6QrFi1poQ1/wpLummWO0adWes2U6I3GtD9vxO/cazWrWBDoQ8Da
 otYa9+7v0j0WOBTJaj16LFxdSRq/jZ1y/EIHs3Ysd85mUWXOB8xZ6h+WEMzqAvOt02oWJVbr
 ZLqxG/3ScDXZEUJ6EDJVoLAK50zMk87ece2+4GWGOKfFsiDfh7fnEMXQcykxuowBYUD0tMd2
 mpwx1d8=
In-Reply-To: <20250605130331.GA2370690-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0085.eurprd04.prod.outlook.com
 (2603:10a6:803:64::20) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|IA1PR12MB6555:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d68960e-d316-48dd-3f9e-08dda431c069
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b2Y3UFlpczlCdnQ4NUNsQnVQWnkxdE1vUlpzemdTblJ3Uy9WVEFXaGxmM0JT?=
 =?utf-8?B?cldDUHZjOS9hV3p6RCswUlVML1Z3VTEwV2NacHBXbk5CNHlMZ2gveFBlWGdh?=
 =?utf-8?B?THlmRkpEQ2h5SnpDTWo1Z01YYjVoT1JyOE1MbWlGaWZDS0Vsc3FQL2t0S0Qz?=
 =?utf-8?B?SlJYZGVjVyt1dUE0NVJLVk5oWkd0aWZqR09qNEdvZ2J5c3l0M0lQRHlJYTJJ?=
 =?utf-8?B?NTBGOCtRSlFqcEhDYWhuZ3JuK3puRlpZVGZxNTR3U1lPcGlsT0tHNm5GbEo2?=
 =?utf-8?B?MUVMTzljZzk1cDk1S2ZqTWxiVUN4UldrVGpyRXJWSTBmOXBWeHZremdXRXFR?=
 =?utf-8?B?TStEUEh2QVBzcndFdmJ4MHNRV1BuVlc2RnRZNld3MFFsZ3B6dlZBdTRJb1Uy?=
 =?utf-8?B?MlM5NGZEUlNGL2xDOCtpQllpUHlnb3M3VXZJSE1kT0Y0TXBoUGUwRFZWNnBO?=
 =?utf-8?B?ZWdYU2FxR0U3TWhvTjcwTGo4VnJKMWYveVd3MXdIalYvMlFmRWxMdTNSTGdB?=
 =?utf-8?B?NjNuYlhISXV3emVSNnFDbWJOb0lJUlJ3WDM3UDJZMkZuN2hlNW5hMkVtc3Bi?=
 =?utf-8?B?WFpZeGpIQ1NDaHdKejVQQmVKNkt1ZEQvSVA4M2x0Vm02TGhENDlHa0o2OWxE?=
 =?utf-8?B?TjhDZFhUN1FmSEZ5V1J6YTI5ZHFaQmdYc0ZJT0gxS3JOV3duR1lHaGJScTNF?=
 =?utf-8?B?cCt0NnFwQzRyQ0JTYjd3WVhqaWlFVHArZnN3VzZ6dUtSRVdMSGUrK29ucS82?=
 =?utf-8?B?RCtSbGdTdm8wUXBnMzNjd3Z1NGRXMlhkY0oxUURNWWNUcmx2bS9tNW5Ra084?=
 =?utf-8?B?ZTR6Q2JWclNKRWFESXdMQnUrV05EUFN1K2lMek8zOWJwSUhvMTVPVTM1emVt?=
 =?utf-8?B?aUkyL1hQYzIrM2NsMndwUnZoV1RTNzRYYm1WdmFqSmNlck90ZXhKOHNyLzV5?=
 =?utf-8?B?UG4rUytjdnZPV25jSXNycnMxSC9udjhqT3VOOWZBRnJKUEdVTDlzcWVqNzls?=
 =?utf-8?B?WDhFbWpnL3JYd1YrOGxLNjByd09nR1lGWkZSakF5VmFnQS9URk4rUXNoYnpk?=
 =?utf-8?B?MFBkdXEyVzFuVmJHZlU4aFJRRjRFUGRUMEt4V0xCK3J0SytpdTlHTUNBRmdW?=
 =?utf-8?B?SGYvL1RBcWFOczdWa0ZQcGovbGg0N2VwSW53QVByMjVjMU1rR1BvdFJUcW5w?=
 =?utf-8?B?NTRiclIydUVpRkc4N3A4S1Qwd2cxSWtiZVlzOFRVdXZPK09wVk8zQ3l0cU1O?=
 =?utf-8?B?OFFnTFNFbnBTeXh0TUYzUlZSa0N6NDZDbkxsc3BpRHVpaTk0Q0haYUdKN2dr?=
 =?utf-8?B?cXhudDlJQWl6QjBuTVdpNUhUc05qbTM3dGxlcWNuUkxWMFhWaTk5Y01zenE2?=
 =?utf-8?B?THIydVRIc3hqZTZZMlFNOWppTmhxYjNETjN3R21UaitDcXFJYklsa0xZd3lv?=
 =?utf-8?B?NDNOejlweVFYK080UmxxOEYvTlZQM2dtOHBJZEMwMzY1NVp6NFVwdFZWb2xz?=
 =?utf-8?B?NUdwWTZsQWhUU1hvcytVRjhrK1FaSWVheEd3NkRxM3ZPWlM3ZlFocmFaVzJh?=
 =?utf-8?B?aFdxN2JHYVZ1R1dxWU9NSzZoVjBSV1BTdzRKNUZYNjBjTTk0QkFqZ05sUDV6?=
 =?utf-8?B?NS9zbWZkV1U5NEhyQmsxU095UFR3S0VZQzVrcGxzYlVQS0hOb1FJVlNaL0Fo?=
 =?utf-8?B?N3pZa3ZWQ2MydWFYeXk5dHVoNURwNFhnUTl2RkxFYjhvVktiVFdGVWc3bFd2?=
 =?utf-8?B?VHkyV05TNlFYVVVOZEZQY0Jpeis0ZTZHRUlGMkdQN3Q0WXFLNkk2Um5sOWNU?=
 =?utf-8?B?bS9BZHV2Rlc3SVYyTGtISlB5ajN0MUdjcTl3ZDZwK0tlVU84UEpUK3V3VzlO?=
 =?utf-8?B?cG51TCtGNFdRcVB0Qk1xTUEvQ2ZKbGxuRFlYTGFWUEM1cUhKMTBSNlp4ZGNX?=
 =?utf-8?Q?9DI76Bfr2vA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SXdMU1FidnU3elVUcDRjaHZCYTlsUllHSHp0MFFlQkN5THgyR2RKemdZSC9h?=
 =?utf-8?B?OWhSTzVETXhmem13VWFZRDgrMlpQZ1c2OTI5RTFqQ3BoTnB1V0kyNWlZajNa?=
 =?utf-8?B?Z2luUnI4WUlUOE8xd2RidEUvbUxZSmdnVlBMSllQY0RINVA1TCtacDZRN0Zt?=
 =?utf-8?B?MkkvQi9qYXoxblNEV2tYT25QWWFqSUwwcUJqRlJKYktDN0RBNnV3SHRCYXgv?=
 =?utf-8?B?dngvRVo3ZCtLWnBOWmZFeXM2ckw2OUlsS0J6bXBKbXp6VnNCdHpReTJpNUt0?=
 =?utf-8?B?QktuSzBLV1B0a1NHTnpuZUp2WTJVcWx0L1pobkRYNlVmQWR4UHFGRTJsOXRz?=
 =?utf-8?B?dEFPMU5tcTNnVWJNNFZmUjMxTE9TWVYrZDBnUm5GSWJxejYxOHlLWm05THp0?=
 =?utf-8?B?NUhSU3VCZ05vREZVelAyQnFIcTUzNUxlREQzVi9xMHl0cmJTc3Q1Q3c3aEt0?=
 =?utf-8?B?a1M4c29FcHU4MklpQk1VQnltRVFzNnIrVlFLS29sMDR4QnFmaWgxYnMwUWlN?=
 =?utf-8?B?WlFXVjV1S1FhenNzYzVnY1pDcjBVNjRFUUI1UjhkRndFN21KSmtVN2h6Tk5z?=
 =?utf-8?B?SmRqSTc0NUkrYVZkZDhJa3hpQzBtN1V2Zml2TlVVODJVWUpzYlMzdVhBZUtD?=
 =?utf-8?B?eHMvOGcrSVNDdmJnTXN3TGdKT0Q2VXJxQWpCKzE0Y3V3YzBWd2hBQ05hMHBJ?=
 =?utf-8?B?ZDYxaDZua05oYlZINVdCTllWYVJqeDM2elRSRzd3UktDSVBqQmJtUTM1aHph?=
 =?utf-8?B?ZU5qWkZIM2JQMDVFWmdYckNqVERWdjlUNXVzMnN4V2tqcE5oZmUyb05VM2s4?=
 =?utf-8?B?enp5MGdPcXppL21VRjlINTg3USt3ZEEzaFRmakh5ZnRWWmxOUUtIL09hcHNN?=
 =?utf-8?B?cU1FVnpUWlFwejltYzFld3JMUC8zdFpPbW52eitMVCtvSnZWZWUxckpqTWxn?=
 =?utf-8?B?T1gxNHR2MnFqQUFiL2RSQmRjVTNIQ2VjNG5DRHVHWFRPb2UwNG9KZGxVK05s?=
 =?utf-8?B?ampseS8zRm4vdFEvNzJwTjlySS9GNzk5NThMWDMzVy8xTklmT2s4RjBqUnZu?=
 =?utf-8?B?THFBWHNNOThPUFBCaTZOTE0vT0g4eUo3RHFNbHFlS0xDV1ljbDA5THZBZGx5?=
 =?utf-8?B?R1N4Y2FCZ3FtaDcyZ0g0YmhHZUkvSndOenVHK3BFb0xTSHRrc1FvWUZWYVJZ?=
 =?utf-8?B?S3FMc3hIQmZhczlhZTRjR0VFRkRyMjViRzhlbTJUZFdHT0ZlVUd0Vkg1MWF1?=
 =?utf-8?B?NHFSWFVtaTJXZEdQOHduZXhucHJETVFUd25mVHp2MTEzZ1hyS3FhSlJMOE9r?=
 =?utf-8?B?RUpxb2dBQVlxZFVYMlUwUFZyZjFsaUk0cWdzY3NIU1VPY2wrTGhoek9IeEFN?=
 =?utf-8?B?aUVYbDVHQ0NQWjhrelB2Z3NHM0tFeWNSYVhHUlpxSzMxellBd0M0SkZQeHpS?=
 =?utf-8?B?NndoNzhUU1IwdVRPMTJnc0VRUWRvdUxabTNsOGtsa0R6WFZZanhscnhua0g4?=
 =?utf-8?B?RktSa2VYeElOeFNNM2F1Vi9SWGxwTDllMXMzbFRPSkEraDlXcXJsZjVaNm1K?=
 =?utf-8?B?aXc5OTJ1Y0h3dU1JMUxCZnBxR09DRSs0SWFENnBzSzNOcVVCb3o3bGxLeTcy?=
 =?utf-8?B?cHg0bDVPWXk0TCtGUGY5RUsvZVRPSTg5VUJJWU9Fa3JoUmdiTzFtOWVTQ3Ri?=
 =?utf-8?B?UGV1UGszT3pHMm5FMG9LNDh4dldGUHk0d1l0T2Q1RUJ1bFIxVUxrMUNjU3Jh?=
 =?utf-8?B?ZGs3ZU10OVgxWHZhWWtjZzBGYWVlczJCVm8rU0FXUytrK25sSE4ybXV4YzNj?=
 =?utf-8?B?MExES2F0SEMvUXlNVS9XNWtFOGo3ZEZRM0ZHUU9vcStBWk5wa0VLTGFGbjFK?=
 =?utf-8?B?RGZaQ1orUUpvcmdzeGR1RkFnNVJGbmJ0VmNuTkloaThPdnNoclRKQkVNQlJ1?=
 =?utf-8?B?WTE4aUF4U3I0M2NHdHZHR3VpYzAvbE1IZ2pISmdRUlg0ajhXYXFSWVhLbFZy?=
 =?utf-8?B?RjhyUXdxaGtaSFZNWFNoRGxVS1ZNL3lFT3lzUC9WeVc2Sjl1cVFCaWxyMjQ3?=
 =?utf-8?B?SGFtU3dPVXVPaVlJUTdqNXh6TmxlaFRCV2dZaEszYUY3Uk13d2VuUW5xbmJm?=
 =?utf-8?Q?r1ZO43ffIPlHQeUb3p0ZPU7xY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d68960e-d316-48dd-3f9e-08dda431c069
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 13:06:14.6448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9qyzdLykl4gVNUkxlNqFGT6ifJZ5E6QlFsMIaisVyvTMo1/CnaH5zFMOL7EZ6PwD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6555



On 6/5/25 15:03, Rob Herring wrote:
> On Wed, Jun 04, 2025 at 10:51:54AM +0200, Michal Simek wrote:
>> Bootloader (as U-Boot) is not using interrupt which doesn't need to be even
>> described in DT that's why make interrupt optional property.
> 
> That's true for 'interrupts' everywhere. It could also be true for
> clocks, resets, etc. If the h/w always has the resource, it should be
> required in DT.

ok. fine.

Thanks,
Michal
