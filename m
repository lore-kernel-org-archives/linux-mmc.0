Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012061.outbound.protection.outlook.com [52.101.43.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC9B231A3B;
	Tue, 21 Oct 2025 06:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761027064; cv=fail; b=lkhnVV1EkDxv98TPXIx24iTBx/jkNtXjQBZatSm1rg2fNcsHMNUIq8UdyWkJvfv8aN6ZTgQ1+DkglKKZh3CCZRzAX2Y6PzCLBEmF1NcnG0CxslvHYxgETEF7yMqq+fcVuoYJ2rt8QI20LR+SyIooZX72aLUqTCjWaTsZzbbWUSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761027064; c=relaxed/simple;
	bh=O1BYHmBsenoW2h59+oCoulgRXMhWjEhWBJEBVNT2cLQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bDHzQybNPE8Vv1usDS04aYGw09oaeIxPDwgcg/3aKMYvrcOqEPhCSC1nfRwaPUQLBAenPlDMp2FC9sBDOUQrQoBm3aQQzqoqGBb/HnGsTGrlr3biYFG9JlbkY0mSfpALoR+f5b3+z1Xrx3op//bW7bf4P4vx1bfv0y9vgABf6xg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=To+Ic9YC; arc=fail smtp.client-ip=52.101.43.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="To+Ic9YC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lVZWOMx8o5Nr07FVcgnx5E0IAUdLqHEkeyzQgFW68g0MFJPtpNCg0uhmOfyJvd/Zw6AYQBmz+ETZrbdIXNrm4diEqa992n5O8G9yo3mtkx8jSaZIvkRrCda+CJ5VnrjV+fMJPo1ZmAr/lkqVdGVs4RhY2NX6rUWXdSZM/nzp4+l9nBPsR5IdBK7//QRI/E4NvVNpXaBIDN9Rqr0IaNW/mxpnOVP0pH26mZLBUnCpEQ1WIZjJgXAAmmOS+HPjLhcCcEyelXa4qE8wxmgC/IMRMpruDopYV9MFZ61Xfg0MWo9qyrx2zt0Vuz7Y6ZaNsZNjOA88v3ZoGhs3qw0wG59gUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ghvcuS+gIYruORqrIVU8+dTVNHORCyYwS405idPF1VI=;
 b=sSrDsJRn8PMrEeNi9sxr/tjnjZrlmLl/atfbIwsx4EKcjonxdl0GSQILF3xvlKPsLEYH0szaz52OfXvMe/SLsGOGopLjhQV25QbV75eiERu0RlRYuoJAu7GawEYO1ujKlxmOzu3JLhmiXCs6pfVxJQP+Dum+/+DVD+xTDLT4YmiytPduVf/zz01GfqeZfXZ8s4bJhEPllvngiYv2eC45bdeo6ALHZujCrySoFkpeVqN3yUqpIE7Gc32Vn2xBnjK/Z7urL2yI7ux1pTJYNOyT3M3ZRRjb3dQQQvJgevb50a/zts76tLDWc5+yjWu38/ck+1wJKDSLmtbHlcTsibvMAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ghvcuS+gIYruORqrIVU8+dTVNHORCyYwS405idPF1VI=;
 b=To+Ic9YCLH+ksyWuoyqXdeRfclf6iEOhyszO9U1awEyNzYMcVlDdY/G8LYMtxhV9T++gvBt+zW7k/9Lr2NUYsC5sUmuJ3Xo9V+wlJVMtNHqm8fI7cQgwtvM0Py3neEPGYbCNwxn9PDTRfctFqPxCCf0e7Lzw+TqSJfxR6bGBytc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CH3PR12MB8329.namprd12.prod.outlook.com (2603:10b6:610:12e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Tue, 21 Oct
 2025 06:10:58 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9228.015; Tue, 21 Oct 2025
 06:10:58 +0000
Message-ID: <d1b6ab53-f45b-426d-ae2e-8c94d1cc885b@amd.com>
Date: Tue, 21 Oct 2025 08:10:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-of-arasan: Omit a variable reassignment in
 sdhci_arasan_probe()
To: Markus Elfring <Markus.Elfring@web.de>, linux-mmc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Adrian Hunter
 <adrian.hunter@intel.com>, Andy Shevchenko <andriy.shevchenko@intel.com>,
 Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>,
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Anand Moon <linux.amoon@gmail.com>,
 Christophe Jaillet <christophe.jaillet@wanadoo.fr>
References: <5fc18699-74ae-4f31-8794-bcbdc5ae6008@web.de>
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
In-Reply-To: <5fc18699-74ae-4f31-8794-bcbdc5ae6008@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0192.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::17) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CH3PR12MB8329:EE_
X-MS-Office365-Filtering-Correlation-Id: 0712547d-cf9f-4297-fc93-08de10689a2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WWlraDFLcmVoZmpIS3E1azlicmtNSk1XelVub3hKRDFsbktEQ1o5a29IdnQ0?=
 =?utf-8?B?djgvYi94WVZTcVFhUjZCeWUzeVAwL0hINVZjMytLZHVkekMxYVNYNllrSG11?=
 =?utf-8?B?QktDUU1yWHBBclk5akNES0VIZ2NOb3hoK3k2MzRIS20rM1lZWUprWVdGaDRH?=
 =?utf-8?B?WTl1RGpQZU80WHE0ekJ5SkNBaXYxNVNVcDQ4MVYzcllOcEdFMjZzakJTWENl?=
 =?utf-8?B?UUwzbTkrUHlJSUE2d2hQZ3FwS2R1UEZqRDU1bytyTCtPcUFaaWRNa0pkQzJP?=
 =?utf-8?B?NGtwOWQxUmhURUtBVXkrcmNBNnUwam9vdWNhOWRHbnVvUFl0ckF5TXRaZy9K?=
 =?utf-8?B?Q2wyYkNCbEhIVFgvd2pYRmVBZ1Q1M1A2eU03MEc3ZkE1ayt4Vnh2OE11R2Zk?=
 =?utf-8?B?NXc5cGUrUjV0NnRBUlVsZnZDQnJkb0praXhLVUhGL2NpQjREblIvRU43QXFP?=
 =?utf-8?B?Q1V6Ni9wRFFsQjV2SExDVGx6WHc1RmRsRWZadFFpeXE0SFdaVDExK0IrSnE3?=
 =?utf-8?B?OXhhOVFidWJkRThubE9KYTZTSDM4Vm0vRWxydjN1b2g0ejU3K2c0cEZyV0tu?=
 =?utf-8?B?OXdhbHFRTXI0eHRieVdLeDVtZEswQVQxMXJVK1FUUjBYb0lSSWk4VC9GMUt1?=
 =?utf-8?B?K0c3UzdYbEYzMVV6ZzlhQWxrc2RHMHQ2eHFPeFBVb2IzbnJ2TWF2QnNwSnhT?=
 =?utf-8?B?c3VLeHBNdVU5UVJWVGxVOFQva0Rxa1VWS3pWSEM2aDVjUGdKRzBsdm5wTTlp?=
 =?utf-8?B?RHBJRjR6eXdrbUlVYjZEc0V3K2I5Qm1HUHM3L251MVlqajI5OUpNblFNcTA5?=
 =?utf-8?B?bEF1Mmp1YUVWNGRxVnphdlBvUlFhRDc3Z0htVmloYWxHTXhWMFo3bVRCYytT?=
 =?utf-8?B?MnBtWUxNazdtT3ovL3dzdFZNV1JCcFR6ejFzRUVoOC9Sdk5PQlRBWVd4SDNK?=
 =?utf-8?B?V2MwMFVnRHNwQUVKeGtJQTBnTC9IUHR4ZktxbW84K3k4T2JQcnZSdlUyd3V3?=
 =?utf-8?B?SE00TE5WMXdrVWFabzNpU2xaTnN4UEhhVGt1RkhQQ3hTdzdHZE9HaG41UTNV?=
 =?utf-8?B?U2F6dlQvV0xBWjhYK1NCZUM1Z3RqVHdRMUlqMU05a1B5NkROaGMwYUx4ck5L?=
 =?utf-8?B?SXJyVjhheXZRL1lBVEFTNExxaHBycTRrendvUzE0akVtM1I1MFZnSEY1MVlD?=
 =?utf-8?B?MG5NM2FHMXNKTHYzZ3pPYUo2U0I1MnhwZnNuTkRHQ0Y1R3lLNEZCTGE5aDl2?=
 =?utf-8?B?Y1ZzbTczTkMxeHhScVhTYzJyait3MG9RWFhlTWpVSU0veUhrRlZVNG9sZU9z?=
 =?utf-8?B?Ujl2eTFIQmxxV2RZTDMydVpCUTBQbS9oTC9kdUcyRjNzWU5wTlJnbEQwd05i?=
 =?utf-8?B?OWkzREF5TnFYanhKZWRGUzFEbXVhcEk2NWV4d3A3NXYzN1lNMGxVc2hFNitY?=
 =?utf-8?B?eVIzRTBwYWZKblI1VEwwUjh5WFRmS2hsS2Y5TEg1TXhmekdseE40UlY1SXVm?=
 =?utf-8?B?RmordWFSbVNRTHZDQjlQWTNWZVhOVWwyakhRSjh2akFlUmFGWjRTVEIvdlYr?=
 =?utf-8?B?akxaWWtBWTdGTzBDc1JDMWR0cldmanc3SnIvclY3N3dSZmZmTzBwQU9VWnZQ?=
 =?utf-8?B?anhodG9tUjJzYXpRdDZJNjV0aTZzd0FySkxqKzZIUktmMitmb25XU2Vpdkxr?=
 =?utf-8?B?c1FDd3ZUYmN5dDErU2VONytMNjVZNDlNQ0w2Qmt2SXg5cTdhWWp6TVg0VzZs?=
 =?utf-8?B?bHcxMTFpUURlbU5QSzU5QndLZkxieDR1aE56S2VTK01MUkt3WGFUMWtaZzhj?=
 =?utf-8?B?eDFhb3BrRUF1eVdjVGV5ZmZ1YjRENGhQcmlTWXBiOHIxMVYzbVRweFRTZVFE?=
 =?utf-8?B?ekhWY0VGOTdxUUdFc0N2UklhRGFSeHFna2Z3eEU4aDZUQjQxbDFhVnN6TXRu?=
 =?utf-8?Q?lPGv6jx6WcvCjEGlT59Cbh+BEjA1QMcL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MTREemJzMDBmQmQxb045bXpOSlgvc1JpaXZyK0FwcURMVlMrV0ZOZVVqZlgv?=
 =?utf-8?B?QkUySDZXN01HWFBNS3FwczNucUR3MUNsd04rWGU5Z3F0bFZOTFY0RjFWSTYz?=
 =?utf-8?B?RzNHdUg5YVhvQ3JXcmsvYjIrcmFQdDNLQ3JxR0dqWllBVHNaM3pBTEM5cVFR?=
 =?utf-8?B?SEhtUWpReTNvM3FuYnA1dUlQenZ4OHJMOXVlcit5OGppMjBhNyt1eEFqQ3My?=
 =?utf-8?B?WElvaU94aWo3ck04aVBHNmpIRmdCaTExNEpTbS9tMm1oQzBVQ0xrQ0dKWUFH?=
 =?utf-8?B?TzB2UHMzTm82VUxxMHFKTHVtWjVtekxCcGdJbU0vUk5UUDZDYmtDVW5UNXEy?=
 =?utf-8?B?S1lDLzFUd1hvQ0RmaktZU1ZNazNEeGlCSVBXV091TTBHSG1BWk94TlMycTcx?=
 =?utf-8?B?SFVTRjkvYThaNWgyNzhzNUVLWllYZXRlbDJYRXlpc3k1N1N1ck5vZHc0OGRr?=
 =?utf-8?B?clZ0QkcvbnRhV2cxektWN2JEUGJ2S1lVbkhob1ZsYVlNTlkrYmpSclZCWThx?=
 =?utf-8?B?NGc2WHZram5ad01tRHVpK0JjWTh6WTBpRnNuUHRsdWFsNFVSdFpTOC9Scmxn?=
 =?utf-8?B?WFBoRDJKRGF0eDhzRVVCVE1ERlNBWHUweFhZUzJEM1FxWGpRMmlBR1RUSmN4?=
 =?utf-8?B?MW1DTXhYcHRYRjVUNXQrdHZSbDJaNHlsd29rdFFJd0c5cVhUbVFoWXpnUmc1?=
 =?utf-8?B?ZmFTWEJwdnlpOVFMT21MZVVLTktlWjByYmdIbWxma2ovRWo5WnlLWlRjb1FC?=
 =?utf-8?B?TWNDVzBnN2FzaEsyYWxLaVFteU1jR3RKeXV2VElMSFlSemlqdDc3SHRtbTVz?=
 =?utf-8?B?eG9tZVltMldJajQzTU52SHJ4Zk10c1lUMUc5THJaZ1JPbEZPOWRSTEtLcEc0?=
 =?utf-8?B?ZllWeVRlM1VYS0pyQnB6UXVQVmR5OW13Wk5UaGtDZTFMUWNpUlBLZXJnTFJm?=
 =?utf-8?B?VXFxVTVrSFFFaHpZNjVsbTExdlZEQk5qRDFRSktGWlBTRDVCdXRFVnBvZmt3?=
 =?utf-8?B?SHp5TU9CUlpkNnF0aWp5eldzS1FoYkNwTkV6eVlaUXNyZFhsd0NMMzY4Z3Ex?=
 =?utf-8?B?a1g0Qk5Cb3Q0VXJhQ3V2d251L3hXZ3NodnRHc3p5TDErYkxDSzRmQ1YxSTBa?=
 =?utf-8?B?cGt6MjFPdks1M1BOTjF3ZUZiazd5NlFtRTY5MHZ1RHd4bW9TekoyNUFsTVR6?=
 =?utf-8?B?ejVkQ0dINzV2c2FPYnZKa2ZWd1daVWR4WVhMSzNyN0I2c2hyZ2JwZXRoTlAx?=
 =?utf-8?B?cWxBbFpHSHVKYitjV2srL3hFVHF3UXBSOHNpcElhQ1lNQ0o3Y2dteWRGZjJH?=
 =?utf-8?B?OXFreFZHeVEvc3V1RUhuOGVYVjlEdldDeFZNLzlOMGNMUjg0QkNRZ0hzYkUy?=
 =?utf-8?B?QnQ4SWM5K0EyalRQdnpDa0puZ2FWL1h1aDdQVm1pdU8vMFJIdzFqZGJrQmY1?=
 =?utf-8?B?QThpbVdUcFZTVlhMeStJTlNYVTFxSjVZcXNmSFJ5ak9OMkVkNnBBakVWZHNC?=
 =?utf-8?B?cEZqVWdYSzRuYW15bmZ6SFdRMldMcWpIQXJHMTBBWUNFSG44QlRhNDBDZWhB?=
 =?utf-8?B?blBrVmprTlFTLzZ0MHByb29vNG54U3hJNEZyWkovZ3BXVGhjdy8zaEdJblBB?=
 =?utf-8?B?Uk5CbVFpWWFCZ3kwU0EveFFyM2Z5eS9XVXlpTC9PanMyYyt3bVNDdVd0cFd2?=
 =?utf-8?B?ck8xNEg0SHlkOTQwM2FRZmQvRk9ROCtpbkZEZW1IZElpT2xpWnhsbjN4cFlO?=
 =?utf-8?B?dVFrTmkvYU5JaHo1MnlNZnZWdWs5MzZPMHBXS0NHRC9Mc1l6dVBOZlI3Nnlt?=
 =?utf-8?B?dVlWeUV0ZTBRM3NReDhFYTdUdVpRbldCRXJEbE5vM2pFT1RHLzNDVldReFNa?=
 =?utf-8?B?amowWitVVnIySGVoNVJvUGFHMjlqT3pObG9vV0d0S1grUDlNU0tOSlpxMEtq?=
 =?utf-8?B?ZGNhMFlneU5lS2pUTnNQLzNXQ3gzc0FTbk5zc2R2cnRuRjNFVGVyQmZCdVdj?=
 =?utf-8?B?U3hxcHM0cmZ4a3J1MVJBL3BLUDhyMDgwanpIVG1BMExKVHNWRG4zeGx2cENw?=
 =?utf-8?B?QmxZMi9YNHFzdUhaZGJhbmVpZmNRZkZnL1pNYnhCdm16QkFDZnBaa1AwbmJG?=
 =?utf-8?Q?1ITFy8sRESfpSmRJm4P0/G3tb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0712547d-cf9f-4297-fc93-08de10689a2f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 06:10:58.3574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HW/FJ9NKr6n32scfep44BDMU2BORsHMHmnJul5tAeqkVs6PbVIN3pDNGlAopMyyy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8329



On 10/20/25 15:22, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 20 Oct 2025 15:15:07 +0200
> 
> An error code was assigned to a variable and checked accordingly.
> This value was passed to a dev_err_probe() call in an if branch.
> This function is documented in the way that the same value is returned.
> Thus delete a redundant variable reassignment.
> 
> The source code was transformed by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>   drivers/mmc/host/sdhci-of-arasan.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index c6f09b53325d..b97d042897ad 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -1991,7 +1991,7 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>   
>   	ret = mmc_of_parse(host->mmc);
>   	if (ret) {
> -		ret = dev_err_probe(dev, ret, "parsing dt failed.\n");
> +		dev_err_probe(dev, ret, "parsing dt failed.\n");
>   		goto unreg_clk;
>   	}
>   

I don't really mind.

Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
