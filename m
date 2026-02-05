Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11023084.outbound.protection.outlook.com [40.93.196.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D896422339;
	Thu,  5 Feb 2026 03:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770262510; cv=fail; b=pqjBMlS7d6mUdj0MKJu478GuKrH4K7wRbo0TXKulBxp4/0+QkDmE1lv/sgP/0gm6pXdOPE9XuV93sAeOcJM5vG3qRCOvb/3gZY75vkBEHlbV8jCA06+CbiSHcbr8M8btIZWw1usJmvFLx4VQpsoqj5jPauFb9khmCtpoKVfa9N0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770262510; c=relaxed/simple;
	bh=2mueho18wz/nKjcd/rSuSGY5VGNLHab3eYcjqSZbQeI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BJMxKjvsRFbbg4mLcVy80m0/0yAQJwcqVbL+VblZbF46iEEu67SYJiUZf1+gguSLP7v3GZBOqwCF1kXfDVVTOuznwJ1EtT28PqSG644HPAkxy5wlM33KuEhRPcIFKkJ5erIOUVywSaBy444xMli4nH3jQ1FyA1g4D6vF+zD81/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=GGfc+YF8; arc=fail smtp.client-ip=40.93.196.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="GGfc+YF8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pGKXPTKYI+Zzzn4XtzpbuMZvWWgVYldjiIlsXuR1zh9nGlapVOlFQ3KY1299BuWiRYRMQzQHGClYMaWrop2+g+2bpLhXHsxfG5mNFmiWMGBXAGlmv0zU0kBsY2nppdldpziMzz1wwghlOLnIzfUXkyUkquktkLnO7PzeI/pO3MVYtJ6xOooy2tb7WycKTYlTbCotM8wVtneKSnqzrBqV8TRbLniPtIV3qO8XTugQUBU/TSqEKURPmqd4q37tuLsp8Zzhlo4vTnGIVXRnpR2IjCNSx77dbz6+CFxNaHxVZHC8W42pqRyjThidG7pHNyIGDVMVT2QRzwBGP6thkVNIWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bZIihGivvHRnlpc880uzWHZN9LzKTsBvLIWERmV/SR8=;
 b=n4YsTcZXr4RWObAafYvgoQFpyzQVXQcB7D40hCgUmy5Te3OM4+9uBe2TzeYYVsGgwOy15D2rYLo7WWXCT79aE0N5WKz/QO7xSCPAF4ZQE0+axXuOv+nF2eCSeC4n2wbUfqdXwpaYgtDlsYuDQFKnvYH1RVOPxUKnYckasPLsLjMV+kF7/5PoSlPMCQ4v6qKT1iXnJClNUoGnngKUWQGrZqHO85VaFF76GcGKiv+XF+YpMKl8TuOPqEAq/bRNIoNCLRz9Ol5EG7/3d9dbxxFF87dNX7to9x0HKAvYGI8n3h1Vlr16Di4Mmpibqa6wU4O8yOzaoX8nDjrQ8gTZNI4IFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axiado.com; dmarc=pass action=none header.from=axiado.com;
 dkim=pass header.d=axiado.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bZIihGivvHRnlpc880uzWHZN9LzKTsBvLIWERmV/SR8=;
 b=GGfc+YF8BrFSMZ6ulrnIbHIp0CIrLupsE7UGADQRY+UdsT6GB97aHY2GCZH2T+M5bMyyOUjc5KHKfLJ1JM4DIeH+L8AltC40nNve3xV4oTN/lHDZsh4JPQYD2pKQ8g5MP+M14gODtC2Ddl/dR1NhbeH0DSkJpko/pRSqqbpkYEoDztNhARZTpw2AJ1GEsLly+P8NBdJXfWqRFneDVdmUkbMAcO0mDYi/HrEeaYHs6HKx8p57z3La4iNrljvTR2LXusdVOUfwS7GhNwU+c9N6DLXU4KdgpDiCy6D4ysspgpMQ1S3fwVSTBf+uzhDgKO0FJwPW9Qlnw+FD9TxwDsCCFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received: from PH0PR18MB4558.namprd18.prod.outlook.com (2603:10b6:510:ac::13)
 by SA3PR18MB5391.namprd18.prod.outlook.com (2603:10b6:806:2f3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 5 Feb
 2026 03:35:07 +0000
Received: from PH0PR18MB4558.namprd18.prod.outlook.com
 ([fe80::7a75:75a5:694b:2311]) by PH0PR18MB4558.namprd18.prod.outlook.com
 ([fe80::7a75:75a5:694b:2311%7]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 03:35:07 +0000
Message-ID: <1eacc9cc-b5b4-46ef-9b60-9644bc9e8460@axiado.com>
Date: Thu, 5 Feb 2026 11:35:00 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] dt-bindings: mmc: axiado: Add axiado eMMC variant
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: SriNavmani A <srinavmani@axiado.com>,
 Prasad Bolisetty <pbolisetty@axiado.com>, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Adrian Hunter <adrian.hunter@intel.com>, Michal Simek
 <michal.simek@amd.com>, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
References: <20251222-axiado-ax3000-add-emmc-host-driver-support-v1-0-5457d0ebcdb4@axiado.com>
 <20251222-axiado-ax3000-add-emmc-host-driver-support-v1-5-5457d0ebcdb4@axiado.com>
 <20251223-ludicrous-carmine-mushroom-983c69@quoll>
Content-Language: en-US
From: Tzu-Hao Wei <twei@axiado.com>
In-Reply-To: <20251223-ludicrous-carmine-mushroom-983c69@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0029.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:5::9)
 To PH0PR18MB4558.namprd18.prod.outlook.com (2603:10b6:510:ac::13)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR18MB4558:EE_|SA3PR18MB5391:EE_
X-MS-Office365-Filtering-Correlation-Id: f66e08c5-805f-4280-8da7-08de64678e7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|42112799006|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V1NzNEJxSGZ0cXkveitVNUpkejJrVEJYN0tCM21KdEFrblBKUTRGc1U4TStY?=
 =?utf-8?B?NUFPdzVQRjB6dzJDZFVxZVdSSDd6aHptTWZtbURiOHFuN0hENVRjcVoyODN0?=
 =?utf-8?B?NkJhRTEraHZFUlVBOHovRzJCaG9wamdpQTZXNU81VnE2clpGcnZtV1ZpM1My?=
 =?utf-8?B?dm4vM3NkRkovcndqeVg3T0dLL0xvZUNTdmNjNTVTeEIvaXNRaVFjWWVUVjQy?=
 =?utf-8?B?RnZ0ZkM3ZTBMOEV6T2lnS2pFdEV3OFVMeG43RTFtTDk1eFdseE9CaC9IUWk2?=
 =?utf-8?B?QTAvc012SjJuaXViQjlEcmJUc0MvZ0crYUozOEVCcGkwbWUxaUVYV3ArNHRl?=
 =?utf-8?B?WGdOQngraXYzRnB2MXhid3ZDVnhpSTE5aXNoRVBGVVFRS3RtK1BXcHlCSjhn?=
 =?utf-8?B?VFExbmNLeUZXOXRzSnR4TDBZY2ZmdFJVNnJHeFN1eVcveEZiQ1IyTmdyL3Vz?=
 =?utf-8?B?NUNFT1V5RW9WWnQ3MmJVUC9Lc3ZWOFVmRDFjdzQ3aWhhMEE2elhKMWt4bHA3?=
 =?utf-8?B?Z2VSWGU0QVRDeldoUm5xRWRWVU5yKzJHaWZFend3REl5Y0Y3ZzhkTG9pQjgv?=
 =?utf-8?B?eE04RGxjOXl6cXk2ZHlPTHVJSXoxOHc1SEhNeDN2MUYwcytUQ3luSkNuWHN6?=
 =?utf-8?B?MmZhZUtYZ3hRYmF4ZXNSYW5ndXBkaWdaYW9pcnJpZStMSlNSUVMwU3NpeWxZ?=
 =?utf-8?B?bXl3cUpoMjZUZVpqNEJmU2lpNFd4L1IzWGtsKzRWYmRKck10OUFaenFON1ha?=
 =?utf-8?B?WnBRMFJnUndUTjEwS2g4bFFFTjlZN2MxU2ZVZUNpdDZKellPbktPRWZOQ3li?=
 =?utf-8?B?NGM1cGhUVmJscXdCY3g5ZEtkc29FdmY2SXRNSGR2TDBkYmk5RjR3ZzN6dG9m?=
 =?utf-8?B?UnF5VEE4NXUyWGhya0xjSUVZWUlqY0FhYU44UnJFM3RUVkdCVkxRMS85ZU1l?=
 =?utf-8?B?cUJCZmdlTkticUF5RXFNWDFKMG1xZTAyZjdLWWVUeExXRmdqelhnUTBuZ202?=
 =?utf-8?B?SS9NampqcWFXalZxOEY5TzJ6dnhHZ2RUa2hzbjRMQUV5bHlpY3VFRlA2RElL?=
 =?utf-8?B?YlNWMUNLOVkxaEIxamZGRkhPT0k4YW95OWlPZExwYVI5K20vWnlpbERFRFFs?=
 =?utf-8?B?L250bmJlbHhJMEFERmNSWG5UdnRSZTZMWmppalFHVkpWaW1ET0hjUEFPeitj?=
 =?utf-8?B?R3ZaTzJ3VG1qSVBNNGNPSVRsWW5iZ3NkSnhBYlZNbnROQXZBSHhiUDZiaHJJ?=
 =?utf-8?B?Qmp0Sm56endIZ0VFK1Zia1QzaGpkM3A0bWZ5aXpwaXJFUlFRbERIak10Rnhj?=
 =?utf-8?B?L3VYZlVjYjVZOVE4N0FvWktFcWl3c0FINlhuSmlKdkJJczMxbUVkT0x5TmNv?=
 =?utf-8?B?TWVRQ0FzcnVNd2VHQXJvUVppMkhmNzBZQzlOaWtLd3NlaTV3M0x3dnJMUy9a?=
 =?utf-8?B?c0lFVjR2cmJHNlh5bXZmckxFY053WE4zQ1lLbXpUMnY2c0VxR2Y1cFB3WXJ5?=
 =?utf-8?B?b25vMkx5Vmt1Y3M1T0I0ckl6TkNUdHdiYjh5elRza2dQNmk5Mm5NVEFFblRF?=
 =?utf-8?B?VytLL0ZzRUIxQjZ4NjN4d0NoeG9IaVA5L2tMUk1lR0RUazhYd205bzBRODNs?=
 =?utf-8?B?YzR1dm01U25mWC8rYWhBUWtuK1dzTkUrNjlHZHl2eDdFVXREMTZxK051SmFE?=
 =?utf-8?B?aUhMVFA3SFk2ZjYrQXMrZmpzSEVKazIyVEE2K084enJhcUVXM3V5SEl5RnZ6?=
 =?utf-8?B?TDdmaWtzMkszS1YvcjhFeFVjcmQxVUdRcXo4QUowNnVlRVBWQko2S1VJQTJ6?=
 =?utf-8?B?aURVWVFCWDh4MGt3SGdEa3p4YWpSblJQNnc2ZmFMWGFtRHNHUXFKKzNraC8z?=
 =?utf-8?B?cFlEaHZ1NFJCY2pVeHdDcWJhS0hOaTlacWxibFh2cllVSC80MGJZdjFiMnBh?=
 =?utf-8?B?TVRTRUxRSEZmUVlrV3I5amw3bGN1UWtiTytGN1BQTDRzK1M0eFRZZWlZcVFL?=
 =?utf-8?B?cWdIWDBTODZCY0FOTlNMclhUZkYrOXFyVW52SDZSVHBZUjBCWkRFZCt1bUxw?=
 =?utf-8?B?V2Q4KzhubE9wS042UWgyb3JWSmdwNUJjeENRcGFzSktUMVpZeFZreUx0N3A4?=
 =?utf-8?Q?invg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4558.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(42112799006)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b1daZVpuMm9iRlJkRzI1b0tsZDIwU2xDUkdscC9uazB5YUxqZyttRzQ5N2Zn?=
 =?utf-8?B?TDRPSnF3eW9HaVZ0d094UTlmRllFckFLR08zWkxtY1VHQ3NRRk5oVzdPM1M3?=
 =?utf-8?B?QUZLeWxIRkJ6Y3o5SStOblJjejAzQndYY05IdTN3SEtMWTJSTTZUcTliSEh2?=
 =?utf-8?B?ZGFOblNDVWtabXc3S3c3R3MvQ2FuRkJTTjZ6eG41cXdhalZjY25uMzA5MFJs?=
 =?utf-8?B?TTB5bGFXNkNOcFpqZWVzSUJWZ1p1bmllY3VJKy9lTkZxZ0Q3VFNVamljWW5W?=
 =?utf-8?B?MHA0MUt5c01PSE9FOU5jMG5UNDZ4ckN1ZUZLWUR1WkpaMkVuai8yTnRCMDgv?=
 =?utf-8?B?RGFkMG5pZ1d0VUp3QWEzVm1wcysrYlF4aDJBMXhYRVdJNWNpZ0FvVWNBOWFq?=
 =?utf-8?B?Q3R6ZXR3ZDJsZXBDSnozUDlBekxyeFVTQ1dHNlM2K3NlNEJycmVLdXFYOWFJ?=
 =?utf-8?B?bnQ2dEV3NkNDY1Q3cXZkeW8rT1l5YU5pTzJVQXRZTitUZFhnMTZHaW9rem90?=
 =?utf-8?B?SGVYV2F4Y3pkNTNZb3pFdFpoTHdlRU1EQzFJdXoyZ3ZCK0JodlZ6L0o4Mk9w?=
 =?utf-8?B?ZVc4R3lwY2RRN2M1NGI0aWxUZlFDQlBwYkMxeTVIa1ptQmlEZlo0djcxU1hV?=
 =?utf-8?B?Sm9SVmRtd1Z4T21xY21HSnkvVk5xaEVUZDFaUjVqUDRGaUtKbmNzaWpESWph?=
 =?utf-8?B?QUNrUjloNCtNMHREb1FRelRCQ3pXcFJuaE1jMjBGS1dtYU05Rk9OOWo3R2Jj?=
 =?utf-8?B?THBMMDFyRGE0ZC9xcS9jc3lJSExNS2ZkS0N4VXh1UU16aWVyWTQwMktqNStE?=
 =?utf-8?B?RW5ES0NqQlpYNGlFL1ZxbWsrcU1zeTdMR2lHN2dVNDJ1bGF4SFc2VjZjWlVO?=
 =?utf-8?B?bkh1cFFQeFhKLzZRMDh2SGNiRURHaUtCNms5NU80Z2R2WFlOWmRqc1pKQ1d2?=
 =?utf-8?B?azR0WndNKzdDYmRnWnpldGtHc3FIY1ZzeEQ0MFBDRStpTXE0MGo1U2c3ZU5C?=
 =?utf-8?B?clVhZGRKL25keU5nbTJ0a2JBOFNGV08raFZJQVBzN09zVFFoc2k0WDJ4WUpj?=
 =?utf-8?B?ZzhRMVJtRDZJUDlaenJqb3pwUnpIRlM5ZUdPTURpcUJXaGJhTlBGMkVnMDRZ?=
 =?utf-8?B?THZDQ0FrMnUzd2lMT2txUnBDejgxVjFJcVgrekhoVVZWMlZGdXgva1JsWEZz?=
 =?utf-8?B?Zm92ZDl0SWQ1Mm9OUy9GQ1R6ZXgvQytrN1JhNmVSdyt2MW52QVh2N1FEdm9U?=
 =?utf-8?B?R1I2SHJOVkZabExLZjFkc0dPK25CQTJsVm5PYXIvUlBualgvMlpjUktJOVVq?=
 =?utf-8?B?UUJpVXBGdjZmelQwL0haakRmMjc3NDhiZHd6S1F2Znl5OVZXeTRjV2IvODdt?=
 =?utf-8?B?bTE4ZXBweWJhVWtHK0hDekhJTXZCdHpEcEpCNC9xYlJsVVRuT0Fld1piMWtr?=
 =?utf-8?B?NUE4bm56SEd5UGRQbS9raUhLZU9Jd0ZPSTNsVXJJVi8xQTdXNkJlOXFreit3?=
 =?utf-8?B?K3ViczJDZkdQSHFqWUFnaG5iS2JMV3h3Slk3TVl0c1BGampGR3RxUDVXZm1T?=
 =?utf-8?B?WmFmbVpIT0FXTWQ2NGlmb0JUai9idjQxK0dBQzZ6aDk3RlV0TU5YQ1V1SU5U?=
 =?utf-8?B?WFJTdHlJUHNWZHFUYk5xek5YbWtLMTNiQ2xJeXZZcExzdGdMQjdQZC85eEhF?=
 =?utf-8?B?M1A4eTZsQTlpcGxXQ0Q2V2p2Y3BrdWFZZTcrdFhUOUdDTXRrQi82UmZPcUty?=
 =?utf-8?B?bWNNcFhHbG92ZS8vN1BBRHFJeE5mMmNhbS9NOEF1Smo2cG5yVDFXaS9IcE5x?=
 =?utf-8?B?T1hUK29ZT2VMSmJnS2YzaEluK0NDS05Vd2lnNSsrRmxQekVWME9IcTMxQkFQ?=
 =?utf-8?B?NVBwZXg1VTNBQTJFem8wV3dvaUdRYitRS3NNOUVGbW9YV2g3WVcweWJBMFZS?=
 =?utf-8?B?dUw3MlZ4TlJsdVhNUGZIcGI4SGFTSnRTR2ZLMkF3Tkx6RHRDYWE0bkdZR2pZ?=
 =?utf-8?B?VEtkVWNVNmFPSCtnZWUvV2cyQlMvaVZSZDBhbk5LRVptRFhuQkFmK1BBQVNi?=
 =?utf-8?B?dSt3MWNIVThkeEJVTmh4VlZ3ZnQ0cUw1T2JrOHFlV1VReGdvbndqVVE2N1NL?=
 =?utf-8?B?aHUrY0Q4aHcwQ3FJUld2YXVNS3IyS3QrUDZ0MFRWTU9ZcE9EWDRGQzEvN25V?=
 =?utf-8?B?MXZPZUJ1L0NNb3czT0V6Q24rWUU4UEpqZkJ3SGF0bzFOcTMyUGlpTVBZczBV?=
 =?utf-8?B?ZnZsT2lHVW50TVJEdGN5MFFsMzZnNjh5OGVyckpSaGQ1YXBRYmJQSDg1VC9u?=
 =?utf-8?Q?W0hdvuu1ym8BxTImKH?=
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f66e08c5-805f-4280-8da7-08de64678e7f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4558.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 03:35:07.1049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u/x5bLM7dynGLzet9xeqoJG48oFhhbaBGnatNwQ5Rp2AVH5y4XAeLwwIF3ZQDAgt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR18MB5391

On 12/23/2025 10:43 PM, Krzysztof Kozlowski wrote:
> 
> No need for a new example. Please writing bindings and writing schema
> docs first.
> 
> Best regards,
> Krzysztof
> 
Thanks. Removed.


Best regards,
TH
