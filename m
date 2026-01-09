Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023076.outbound.protection.outlook.com [40.93.201.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CEC334C1A;
	Fri,  9 Jan 2026 09:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767952135; cv=fail; b=RCG6PHBM+9+ZzgPLl2kNYFk+3E4FJNkcDRN7FJ6HGCwYPi+hiqcG/wjyyI1swwNtddF+QXA6tg8bO//LmpE8pWmqDRQ2GAM7OWYXWkrZ9EWlVzSZ/sUZPFvf/ncJtDsBkpsLDhiOgCARQkr+SfWTdna18Eur8y9G+RKYbq7iGbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767952135; c=relaxed/simple;
	bh=ost9PDy/+iU6nuPyc3UHe9dl5m0hTe2O/6Wvo0DjT3k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ai+wg24c3ejD0y4TLbTm92jnwy7WROuv5hy9yfT/SJCy3dQjnulDLuX9BiO6rQzhzwXRhTYMFzL1+BAAmz0DZ25bYYP0yXqo4KDcKaR/8LxtUxCHj+QJairrMfXrtJNSfdJZstfmqCdcKypeZSJ6To2n+HEWZ4Yby199SnfLcow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=Xb4ujURU; arc=fail smtp.client-ip=40.93.201.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="Xb4ujURU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QH2Ww78yoqF1UY//STEjQMbpP0gaxKDA47iZzYUAl4D2UNIOgVgmzmVKi6M3NQQ47HSmOhN93/ofvq4dmKnmfzJAdY733ChG6+IP4nVzU/+gM4FuKir0/ZFRGmJQUKG1a/2DI5ywnOCR+cu9q2g9tJ02veyQWswGd+iaxBaheFcS+eBzWsfq7v1q8biFhk7hc8wgEfcFOLacG6htq7TAchb1Mdd7AH985H4sPVBx+Uj7f2P04ii8pwQ3oJ+8jjaldhGH0LWr15Dj8dRoGJxWb8xM9zMaHrcGEe1EW2iUJqOtBxBNr9oT/ZNnMpRuIXm63uLaboGHRD+ssykAC/GraQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3C1rp2Bp5b7VCeYB7mBgqrXuu4mud9RyfFKRrujuBu0=;
 b=VnUMJA+Gjm/jTDkmncA3P3wQq8TNrmz65o2CMbkNJK5gcI/lXNkdisNgOPrhi5ju3E9nFXPOp7Ljb7hYYx0Tb8mEclvbVwpjjOM+ohgbZ+47fEP8SiucYTBaFcgPCAqiZ2jOk3O5A3woWYDup0/S6fhypxkeAkJ6Mu8i2HGf7AIztp3w1dsWEpBCT4tcHqULiv4ySB5kcv5buyjaaw9KTAWHcK5rgAQ5Lyk7EekTrLpLAyZXJus8lS3RyMh6+RUhnCD6IuXPTpdy9QiSAlwl9X2YFW3+fhocSVROKwrzO3RWQzC/30llVSymKBCkjuZm4wIn/dl1NsRuka1oDlJgMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axiado.com; dmarc=pass action=none header.from=axiado.com;
 dkim=pass header.d=axiado.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3C1rp2Bp5b7VCeYB7mBgqrXuu4mud9RyfFKRrujuBu0=;
 b=Xb4ujURUZfAVrFNJw6QmbU3C/K+f/PiFRlBCJVG1JDz1yPSBCCBVxmegFvA3nl5S8Uou5jDfKIBT7uytFNJc6GCAD2b/DXyNz5Qk/91pN/pNoVy49IJuiHfvHJDzQjcDfQVc0MqA2wdC4hL4nWQ2W/8evAFFSxew8tF13WsOLv2qXMGpGEFCsX/GO8rtxJg97nmyJbNQrDijrgq01bL7YouCG/dgC5HCP34YJ24FRrTv/iHlp34Mo2y4e2545SEBnwtVKw4Z++HLtHrXpOd2dumUFLqXk6X6WxOnDPlqS9SV858u5+ao1h9oXl7ffAB+WZjpuC6Q6m/HDorrtMQNiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received: from PH0PR18MB4558.namprd18.prod.outlook.com (2603:10b6:510:ac::13)
 by IA0PPFE0CDC467F.namprd18.prod.outlook.com (2603:10b6:20f:fc04::c48) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Fri, 9 Jan
 2026 09:48:52 +0000
Received: from PH0PR18MB4558.namprd18.prod.outlook.com
 ([fe80::7a75:75a5:694b:2311]) by PH0PR18MB4558.namprd18.prod.outlook.com
 ([fe80::7a75:75a5:694b:2311%4]) with mapi id 15.20.9499.004; Fri, 9 Jan 2026
 09:48:52 +0000
Message-ID: <108cf065-e2ac-4ab7-9c39-6e52cb5439fa@axiado.com>
Date: Fri, 9 Jan 2026 17:48:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] Add Axiado AX3000 eMMC Host Controller Support
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: SriNavmani A <srinavmani@axiado.com>,
 Prasad Bolisetty <pbolisetty@axiado.com>, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter
 <adrian.hunter@intel.com>, Michal Simek <michal.simek@amd.com>,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org
References: <20251222-axiado-ax3000-add-emmc-host-driver-support-v1-0-5457d0ebcdb4@axiado.com>
 <20251223-black-auk-of-priority-8b48ae@quoll>
Content-Language: en-US
From: Tzu-Hao Wei <twei@axiado.com>
In-Reply-To: <20251223-black-auk-of-priority-8b48ae@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0028.namprd04.prod.outlook.com
 (2603:10b6:806:f2::33) To PH0PR18MB4558.namprd18.prod.outlook.com
 (2603:10b6:510:ac::13)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR18MB4558:EE_|IA0PPFE0CDC467F:EE_
X-MS-Office365-Filtering-Correlation-Id: fe369bf5-5618-45c9-d4df-08de4f644bb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|42112799006;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c1lLcGFmdFVGaUVySzRMQ1JkRWE3eXZNcmpFd1RuL29Pcmw5M09zanhRRTdu?=
 =?utf-8?B?QzMvOE9aRXBUblFoVmZ5ZWRDMEtqYXd0YmhCbloyQWZMQTZHcnFvbGFONUZS?=
 =?utf-8?B?NFNtYU5zVjVsWldsSW1xdWpoNFhPSzFpN0NpSkluWnVrRFNZclFMcXl2WXY2?=
 =?utf-8?B?MnFaNzAxZW9ZWm1iRFZhRVhCU2x5MWFybngwRk1uamFzSSthWDZDU0VaWkVh?=
 =?utf-8?B?eTZsSk1oRmpjQTQzUW84R3VGdlBPRitUeVBUdGMvSGJBWjFQODVLcHVHYmFt?=
 =?utf-8?B?U2JQUS9wcHp6QjZrZGhqN3d5dEorN0Qvdkh0ZW5SZCtmTTNaRGU1Y1VJSXBB?=
 =?utf-8?B?WThrcmd1cXRnRHRHbVVISmJRamxmTkk4S21TKzVUZzVkeEYxR2VCWU9rRHE4?=
 =?utf-8?B?VXorS0FxbHN5aTJNRDFpSTNJSmVHSkJwd2VRNWtsTXBHTmt2NlRrb3hybmZu?=
 =?utf-8?B?ak9hNE4wakFXd2MzUDJWSWRKZE9pbk1rTUVQRWNLWTU1ZEkzc2wxdXU1d0Rk?=
 =?utf-8?B?M09weU9MN2NyQUxuSGx4Q1VMM1NqNXg3aTJ4TTh1Ym1YYzJzRlJuZnk0Tjgy?=
 =?utf-8?B?K3d6dktUTmpaYW5jWjdGK3B1M2R3S0UrZlhSV2xqRnJLYmVrS0U3SDZ6ZEVu?=
 =?utf-8?B?V2NlMzM5aU05VDZvRVptNHhOMlpqWWlBRDN0aTgvTnBjT0RrUTBjTG9MeVlD?=
 =?utf-8?B?bGQ4UkNRR2JKQmgwRUUxQnFvR2hDWlFBSTdUYlc4VTUxbC96VmpFS1ZrVUtH?=
 =?utf-8?B?OEM1a1dSZnYvcWRxZlJNcXBwTkhJYXpxSlc3WlpDRHZna3U5TmxBRytQVmw5?=
 =?utf-8?B?eE56bCtKK0hGMEFpNzUyVGpMcHJXWWdYYlZMclVJOVBtOUlEVlVwQnhIR1Rl?=
 =?utf-8?B?NXdUMFdPeFZRVjIzZFdLZ3g4YVhiOHhSa0pWS293a0xBSFZRMm1YV1pXaHdo?=
 =?utf-8?B?SEtwQkNRdlY1VjlFdTQ2Q1VvWjh5bUJIQnM1R2xEMEtpZkVjdjVjejJEb01R?=
 =?utf-8?B?UktnNzNURkdQV0E2UEhvclZUVXJKSC9SejVDQUdtek8vbUYxczNzT0JTMVpV?=
 =?utf-8?B?S1hhVndCQTdIbStlKzBZcWZTbUtJaXdveGZta0J3M1NUWDJQUUxQNEVDWXZ4?=
 =?utf-8?B?SzUrQm9mZllSTm92Z09WNU9KbVhCWHBpMlhHclNiSVcxVDJXL29zVXk4dVRC?=
 =?utf-8?B?dkNscGUvMXNZYm53dU9VWldNOEJOUnZ5dm1TekxoT3ZRM3JJZUQ2ZUlmZ25V?=
 =?utf-8?B?bVRYU1NsbmRrMFcwWEV1RWQ3ZnZwVUpOLzIrSHB0N04wdlVmYmhBUXpCSWxk?=
 =?utf-8?B?WTFQbmZhK2VPbWFqNjBRVVZDemYyQ09JeEdEbDA0dVdIeFl0b3l4dkwwQjFz?=
 =?utf-8?B?b3V4WTRLRGFNdkYvdE5vdURIcklmbFp0NnZxY21IYWVDQkZvVW9jbFhObDdw?=
 =?utf-8?B?SG9KMTk2elVFbmlkak1kVG51VkxHV1JOaHgwcXBFOEpsZGpMdWJPUkhScWxi?=
 =?utf-8?B?S29LZlFQZ1RteE96QjM4bjZMZ0Z2NXREYjJzQ3BoNHE1M0dQaEQ5QVM5Nm5Y?=
 =?utf-8?B?aWhycDBXOEZHeGxsTjNSS0RaY0t6THBBYStONUw1WjJzK252MW5VeTBFOGFp?=
 =?utf-8?B?aDgzZTJ0S3RRZmUrVmNUdGluTWVXdWtFMmlqOHowRFpFbkNLSHJZbE8zREJM?=
 =?utf-8?B?YlRqUkc2Y1BwYkJQdU82YloxOTVuZ3BjSEFGcWFNVnFLeXAyWk9tVGpkOUlJ?=
 =?utf-8?B?eVhoSk5VenZ6OUVneWNBSnBtZDd6c2FUcFdWVzlOdmdvN0RyVXEwTG9Jb2hF?=
 =?utf-8?B?ejlTc1lKVXpTZWQvZ0JDUHJyUWVmZlg1c0JZMWYwOHJiVEJkY1NlWXhRTjdN?=
 =?utf-8?B?Z1M5dWxuZnlGaERQVDdVZ3A5cEZMc0pCRXYzWEtCeW9WV2JTM0FWMkFRWkVB?=
 =?utf-8?B?bGpPQ3UyYTdiekFrN3g3TlBrTlFicnk0RDJZNktkTXJMWjE2bVRlM1RzRXVQ?=
 =?utf-8?B?b1NzUXZhUjh3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4558.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(42112799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cElpSG92eXZRbmJUaExkNWNlM20vdUFlSUw2dWx2ZXJJU3I0bWZhMVBwUmRl?=
 =?utf-8?B?ODRTRXRNam9jSG9lejdVKzIzRWpRZUorN2VRa1pFN3Flemk2TWMrZTB2TkJJ?=
 =?utf-8?B?NGhPQzVaRHRyVm1teDQxSnc1eERZN1lkVEVCZVZGMWlxSVh4ODNhYVh3M3JV?=
 =?utf-8?B?ZExVbWZzY2I3ZkVoLzZSNng3enVSTE1Gbk5pWnRRUmZrV2hISHlSL2ZVK2pT?=
 =?utf-8?B?N3VveWM2bTNqZXE5a0RzRUl6WlRHVHdPVlhYSTN2NEl1RmZ1eWRTWTNISWRj?=
 =?utf-8?B?ZkxRSmM4OXU4OWlLWUJxMFlocGFKVlI5SVRyZllSNTdna0FjLzBieXh0Z0FR?=
 =?utf-8?B?d3hiVFp6NkJSOHY3ZjF5RjkrTzJKWVZqOUlQcGtzenFhRk0zSWJ5dXdEWisx?=
 =?utf-8?B?b2JZQ2hBRlpxamJ6akdUVmRXNUJxY0krR1dkQXNzWHNYb0RPbnlleXdmaDFt?=
 =?utf-8?B?TkFMSmlFS1dSL1NPb2ZlZ3BhSjV6a3c4M1dsdnJ3MFN4TGRFNFZSM2hyZ3Mw?=
 =?utf-8?B?emdxWlgyRHhLby9UVlFMdG9NQ1NRellIVkFPUE44aU5qT3dBbTZ0L2pOMWxk?=
 =?utf-8?B?ekR5N0RFdlQ2ekI3b0dWTnJBYllURkNPcXJ4OGJFbk8wODZWWmhtenIyUERm?=
 =?utf-8?B?UGhjM0JpTi9vNjZpYUl2bW5yS0M2c0dtTDR2WHBORElNK3hVUml0Vnh1OEsy?=
 =?utf-8?B?OU5ERE1RempsWHpFMEhuMkhiNElZVHlxNFltSEhFZVJ1VmhzQ1FseGk2Ykpq?=
 =?utf-8?B?TzBUam81LzdCbG00VDQ5a3BMbHJaR3pzbjFYRU5SK21xT2JEVTBFSUhsQWxG?=
 =?utf-8?B?cGRucXFEMFgwVCswa3QxSWZ6SUZNSnptN2FUNnh2OUowMG5KbVBDdVgvVERu?=
 =?utf-8?B?dHhIS0NId0dpR3RkTjdqZkkxMW4vOXVVNWtSNGVxamtvRW5qY3Q1UW5nYzU3?=
 =?utf-8?B?WjRiLzdURU5ENmx4Z25tV2QyMjRhS2hKLy8yVjlNalJLQmtyV0ZmMG1XbW1u?=
 =?utf-8?B?Ui83U0NxUmlzd0VFdTNlcWVJcXppZ2l6NHZUVlJDalZDTHk3N2pZSmxSOUZL?=
 =?utf-8?B?UXFKZlo3K1BmcGZONzV4WE04QXJsbTJLL1lObnJxbkR4WTZ4czRBM1VHWWVO?=
 =?utf-8?B?dXVhd1FrUXdYazJXZFNHYWRhVWlLRGk4MmNpSzRTWWdZOGwrenFXeS9odWR2?=
 =?utf-8?B?Tyt3OThBUnA1bWFDZERNZ2NxVGRkT2xVU2xSN1ppcGF3QW93UXFNMFp3cURy?=
 =?utf-8?B?M3R0d0VSVFJ2ZXYrNDczeVBEWElwMFdKakhhZmZlbnZBanNJYVJkN1pUS1Vy?=
 =?utf-8?B?aEEza0JJcWJhSUwwNGk4azV1bCtlVmpycGhHWlhoNDh4RGw2blROK2xKWkVT?=
 =?utf-8?B?MVh6U2RqSGV3OFFDRjFIL3Fmc3JiQVNGOEpsZnEycmZsRHFSblI5K2Z0Rjdr?=
 =?utf-8?B?UUpPcVVDLzNXZHBmTVI1WWV4bHpqeWRkcnVBUEgvRDV0ZGhLdklwOU1RQkVy?=
 =?utf-8?B?ZEFLTExUaE9oaVF5bmJaQVhyNGltOEhSalRkb3V4VE9yK3JSa2RycVpCR2xx?=
 =?utf-8?B?cm9XZjhTai9SbVZHbVhNM3JObU5UVGRmY2VONnJ5Y2ZVN3kxV1IxM29QMmUr?=
 =?utf-8?B?eHYweEtqcWZPRXVSczgzVEl6OVFUeWFpZnZtUjROL1pQYjhmWWhOWFlPMmE3?=
 =?utf-8?B?T1k4ejYrRHRWT21VUzNkQisxbUdYMU1hemJxUVJ2ZUR5T0t4Zmk4RFdFVDdC?=
 =?utf-8?B?U1VTRmFYbEx3a1Q2TFlsQ2dnejR2UTRyTDlWbUZLb2VCOEVHUmVMZ0pPd0tx?=
 =?utf-8?B?T3NPWjNxN0hhanpYTWY0eDluNys0S2wxTHFEOFNVTUp4aDlMdW5WOGdrdWtj?=
 =?utf-8?B?NkxnQjRHeGRzMXFUTmxSN05wOUtkWlVaMDlsSUhUVndJNVVUKzBmbFhCWGtl?=
 =?utf-8?B?bENwbWEyaG1DckY0NTRxQm5wUGdXckxEcW8wRTFZU2dId1R1SzZhUGVFVzZP?=
 =?utf-8?B?TVIrTmRpU1NyWWZuOG8wTU5MQjhldGwwdnNGRmw2MUcxR2luZ04xby96WkR2?=
 =?utf-8?B?Z29PUktVLzlwMmtCOVRqaUxRelFaVDZ0NlIwTkk3RkJVMy9NbmhBRkkzLzhB?=
 =?utf-8?B?SmFQc0NQeE1PUWhtUllpQUxQcS9XU09mcEJhWnJHYis4T0VSSGJZREF1Y0V1?=
 =?utf-8?B?Q2p0UU1SNjNNNS9RWFhVTTV4R2U0Wm96TWYyZVU3eWY1QmdrM2ZVWXV5M1Bu?=
 =?utf-8?B?ejY2ZHdaSk5Tai8yc0VFLzArWlkxdmFweFlsbWZxNU0raU9yYUw3d2FPdzRR?=
 =?utf-8?B?bEZqV0RrRU41RlJUUTJLUlBrMXl4UFEzZDVGV0prK0MvbHpTQnhYdz09?=
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe369bf5-5618-45c9-d4df-08de4f644bb3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4558.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 09:48:51.9928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BmoiXx+G5vt4fipNRfAYN4WaYJomPdHC2GQdjJLP/5nQDz+soLUCxZWB108zri/N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFE0CDC467F

On 12/23/2025 10:33 PM, Krzysztof Kozlowski wrote:
> 
> You completely disorganized the patch.. dts is mixed all over driver
> code, you combined two or three completely independent subsystems into
> one.
> 
> Read submitting patches in DT dir to understand how DTS must be sent.
> 
> 
> Best regards,
> Krzysztof
> 
Hi Krzysztof,

Appreciate your review comments. We reorganized the patch series per your review comments, separating the DTS changes and applying the driver code changes to the respective subsystems as following
https://lore.kernel.org/all/20260109-axiado-ax3000-add-emmc-phy-driver-support-v1-0-dd43459dbfea@axiado.com/
https://lore.kernel.org/all/20260109-axiado-ax3000-add-emmc-host-driver-support-v2-0-934f1a61f7c0@axiado.com/

We will also sync up internally and tighten our review process to ensure this kind of mistake does not happen again in future submissions.

Best regards,
TH
