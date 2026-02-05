Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023080.outbound.protection.outlook.com [40.93.201.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45262D5922;
	Thu,  5 Feb 2026 03:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770262599; cv=fail; b=k5NciPR4Q4Q9USV82+OY9orjjNzCG2tIlmqvxuhvIlKRzhqoVHg3RCErHp9X8CpG/sGrnhD0ALJk4w3J17it2GXgre4D+XJCPWjWxKJAyB5pdZCOIw/zRz/HAjIlxijAwU/v1kzznzS5jS75yOlJGW1QUpBhvWeQhZknxnDEqP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770262599; c=relaxed/simple;
	bh=ynuLTFeO4I5iEoOmjRvxaBKytVd2SAsj1zRE0PfKNrk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JDycUup8/dmyho+vlTlvo3NIM3vi0xw7YpZeGVbLEJSJb0kGH8OuzZxKdQy4TAxa1zGo25wis6cwKLk6wimac83HHY7R540Shdd+zrLnMjbcE+cGx4tZF9SnKs1GS5WHM9G4A0APWpmGyIiS8gEq2QsG34pirq5Qal8gur/85RY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=F0rX7Lso; arc=fail smtp.client-ip=40.93.201.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="F0rX7Lso"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NWPX2u/usOYcWwQ5+2NlQu3uuG90mwz3xOvlG1zSfd/dgUKMA3MkTAS/f8vY8+Tu6HNqPKAzZGfJx+OFNqBRA34wNg9MIj1Lw9NZUp7/oBvuqk95gEmXo0y3WzGX3s4khAfiHZJSWvDQl3AyDTrC7Plic5BMHfnVVi+sX4SzP9sLHm+Oylg/gt0BOZAhQ2sr6IxhYCtbqe8I/QUBzoF9v+7Ra/qMlklOXG2Gp/xYqmKjO+I+ZZVrDCKEV3m6SijJpzsZspGi39I03Y7o2IPxnDgLHkSapeb1WkcTIeCl54PLmIC+Eps9TfcZFGQOk2RF5mVg7V0HCZc52ykIIp5sZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8kcUKNGLEV9ENv/KDx6wGCJzpDASdTr/BXC9ww8iF14=;
 b=psPi+KspnKyUAROcvdp0fu6yqdy+fWHwiwn4Oq66ZB7REA5Sd01BheqTTwGn4UWU0rx7WNrTWhY9Gq62bsAIzS76Mp4ad1+QnrsOFCuiOIpeAF2bx5YTuxqgkIM5Ceagt/zvJlbgFc1oJ2zkR3hUqHNIUJgS+4JBX61uLLw9NMYkKLTSrGJ6Tm4yp2YohBE6PW1Fmq3oVGRxuaLL5+9RTsu7MU9PsO13fFN6cphrNyA3hF3vDYPOtqvDvrZb6BQz5HKkM5Gg9wqf2uYofnpgMa9UuI/VxZaJVljfhh+5F7OyULH7L7Fs68ksmeRLBnPGWHbyVDUTNMGCpwtyY0XGgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axiado.com; dmarc=pass action=none header.from=axiado.com;
 dkim=pass header.d=axiado.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8kcUKNGLEV9ENv/KDx6wGCJzpDASdTr/BXC9ww8iF14=;
 b=F0rX7LsokdlPjE2F+zE+MUZFZW8v91ked/LZ3cxdvjVg8I//pN8+G1MxaQ59vq4KhA6d9pXxrK08aWblWtrfDV4VwokPMWrt309Y3KlCU+3RvFr7up+lHrmZNJuw+o+zu7ErEyZhpwwcOpZtLPxRKmsbV3LuMfwMvu0pZlJzhoVF+/qzEX6jDuUEm9KblanGn+uZvBijRmueVhzkaoCYPjl8ioqXWo6OdqUxliWE28UHekUbnBDZnxtnvPv1mv6MaUYmV4YQgeUiKXGuJHj8ScB9ECG2VMmGeskkyJltQNKxKUkYQj5AgXimY71FeQ4jttZQ3pNwueJ1tic8VWhLJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received: from PH0PR18MB4558.namprd18.prod.outlook.com (2603:10b6:510:ac::13)
 by SA3PR18MB5391.namprd18.prod.outlook.com (2603:10b6:806:2f3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 5 Feb
 2026 03:36:38 +0000
Received: from PH0PR18MB4558.namprd18.prod.outlook.com
 ([fe80::7a75:75a5:694b:2311]) by PH0PR18MB4558.namprd18.prod.outlook.com
 ([fe80::7a75:75a5:694b:2311%7]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 03:36:38 +0000
Message-ID: <47ddca19-3856-46e3-bfd3-80df89dc1b54@axiado.com>
Date: Thu, 5 Feb 2026 11:36:31 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] phy: axiado: add Arasan eMMC-PHY for Axiado
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
 <20251222-axiado-ax3000-add-emmc-host-driver-support-v1-2-5457d0ebcdb4@axiado.com>
 <20251223-grumpy-daft-loon-6a6186@quoll>
Content-Language: en-US
From: Tzu-Hao Wei <twei@axiado.com>
In-Reply-To: <20251223-grumpy-daft-loon-6a6186@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR01CA0014.prod.exchangelabs.com (2603:10b6:805:b6::27)
 To PH0PR18MB4558.namprd18.prod.outlook.com (2603:10b6:510:ac::13)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR18MB4558:EE_|SA3PR18MB5391:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b1b7228-8a3d-4dfb-1b13-08de6467c4c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|42112799006|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z2RXc04zWEJBb2t2RUQxK3JNUjc1WVJYU1ROWTlvbEdOQjl6dHZPYTRLa2Ft?=
 =?utf-8?B?RlM5clpYZ3NNVE8yVGkvd1p6U1FXdVFTYnpCQmRZRDFJTzVHcmFNSFlTVi9E?=
 =?utf-8?B?bVBYaHJGYWxQZFg5SERNQno4cCtWMnBMZVBmUUU3R3BlVitENzBKd3dxZXJF?=
 =?utf-8?B?MXYwSWtuVjZFSklsU1VLMGt1LzFvcGFZVXVoa0c2bjZmZ0hmMW91QmpBQVR3?=
 =?utf-8?B?M2p1RnlBbU11LytLRWYycmVUcU15Qzl0cXlTcWlObzNWd0ZYM3lLWUx2THJi?=
 =?utf-8?B?bXgvTDN6WTZKWktGMDQwZ2l0NXZFM3pacHJ6cnZZSGxMWkxnTUcxaUVtNWxy?=
 =?utf-8?B?TUsrSkJPOVdESi9EYnNhU2JKVzJqczlGYjR1dmJ0L0ZJbXEwKzJQUlQrcXVm?=
 =?utf-8?B?MlViTGgweThIY01YQmZvbWFKOFRKS3VTaHN5M2tCTXpBMHdUQXU5Y3REOWVK?=
 =?utf-8?B?N04wb25XYjdvUE1PQXN4cXQvbzhtQ2IrOWxQZmdzZ1gwN0xVMzhMSnBLbDBz?=
 =?utf-8?B?cm5VNnpBcTY5cWYyMTN4UU9zeU1hNTI2K0tWd1BiaEJLcHBFaHlLMXpsVXR1?=
 =?utf-8?B?MEZtTXpGVXhvMzQxQzZvc1NiZmtDTU4wUlA0QWdWV2wrR2JxbEEwbm45Nm9a?=
 =?utf-8?B?OUt5UnhqYnJBOEZHQ2cycWs2cFliZ290VGxPS1dwMjBEWTM3b1NSbjJMZUM0?=
 =?utf-8?B?MWlYbVFQR1FCMnh0SmJtcDB6TlFpaGhvNjViYkp6dms5UEttbTBIVm4ybDF2?=
 =?utf-8?B?WTlyVmFmblVjczM2blJ1YWM5eHhxUEVNc1JiemxBN3RZWnN6eFYwdjRxcnYw?=
 =?utf-8?B?TkhuYnNNOVR4R0pXbmNhYzdXekdTUEhzanJZZ0grZjFDcXVPSXprWkZZM250?=
 =?utf-8?B?MEVNWWJKMUtjUGI4U21kOXJ0V1gxa3orTFo4VkkvbFRXTk13MWY0VGU0NzlY?=
 =?utf-8?B?eURPdHNIMUlqTzBFeTZXd3UyMmRhYUdiZkhORENZQ25LNDFza0FnQmFpK3hS?=
 =?utf-8?B?WTFrdGJFZHlLZENNOTJOc01LakV3WEpBdGlGT2NsMDlWeG9JT0dIbHdrU3Q3?=
 =?utf-8?B?MjRhcnNlVGlLMThuZzdYL3JUa1NWQmFHRVJpaGl1N0J2WnY1MTN2V0NHQWFW?=
 =?utf-8?B?L05nRDdwRm95RGRKV1YxZEVFMXdwVHFEb3VnWTlyM3Y4dk1EYlZXaEh2ZFF1?=
 =?utf-8?B?eWNIT1RCZUlRS0sxMERRcUFzUCtIb0RRTkZwejZYemJyUzNwdUNzdUx2Umlu?=
 =?utf-8?B?VnFpcUtKM1dkZURsYkdoWXhtWTBpeHNrZmpKZi84NEZvaDFxOFJuakZkQXM3?=
 =?utf-8?B?Vm84c054M0ZraFdGakM5YnlNcmR5NU9zU1ZKaXhvRlBTdlA1eXNZNWt1S3lh?=
 =?utf-8?B?TWJGc3prUm5EeUtVRjBSWC9NYjFPNEx1VWNMT2F0TjZadzZRZ0tJczM1U2Z0?=
 =?utf-8?B?blhtTVJCb0pOdXlCSmxCNHp6c2NKd2dMVVo0QTJWY2VLM215OWFycGpWSFlD?=
 =?utf-8?B?anppZWdTcVdBK1o0V3AwZXhaZUdUQ3lhTjVSaEtGMW14eE14QVJGOE1GalJI?=
 =?utf-8?B?SnBJdEd1RitMdU95RzhmbFM4OGpoa3FCWTh1b3VtR0pQeUZoSmFXV3YzYlhW?=
 =?utf-8?B?Q01xYjZxOHNtM0RKRzY3RXJUZTVjZkx1ZW1pcDZWZHhCbkNuc3htQTZDM2VZ?=
 =?utf-8?B?T3FmRWRiQ0JKbWxCc2ZTQVlJVkVlTmdpTEJnSFdhK0w0QTVZUzlYYXFoTVZG?=
 =?utf-8?B?MWluZWdiT01odUwvaVpHeXBJelIwVzg5bEV6bWpJUWNMNjlXZlkrZ1YwZVZi?=
 =?utf-8?B?ek9jR2hlUHFIalY0WU1PbC9NOWpTQUowdUNZd1pScUNncmx1MnVJbGRHZWtl?=
 =?utf-8?B?UVI4ZUpKUTV6QXFBT1lhWndsSHRTL0RLOXNaZXd4bFZENTVpUTlxSkgrUUQv?=
 =?utf-8?B?L3FxWGhpcXpyN2h0Tm01UU9YZU5jNXRqM1lLN1poS3lSM29uNEYxSVphcXox?=
 =?utf-8?B?MG5HYXprVEZVV3llbi9VSEdlQTlLVS9UZzVLWHM1cEZNSXdCNFFKQ2dtckZ4?=
 =?utf-8?B?cWhVMHNQNzVUVkJMUTMwNkVBYW9qQjhqdzZtS0JwWDc0emVHRUNxYnExekhN?=
 =?utf-8?Q?tkMk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4558.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(42112799006)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFlwK05pcWdqOEwrY0hZS1RjZmUvUSs4Y3JESDExUkdWME9vT3RWWW52QnYy?=
 =?utf-8?B?ZE9QM0NHeUN5MDMxemNyYkhLQnZyWGlsNWZsL0FwTDRWNlRhZElyUDBSd0hv?=
 =?utf-8?B?MXg1TzlmQUVLdUNwUkdmUGVvNlJrRkpySVdJQXVDTVZzaDMxSGhOZFJ2MWxy?=
 =?utf-8?B?VkRHdmhHWkhEeWxRK2E5RTdIMkNTNFd2UTN1OWNzNlpIbFd2c0ppWjQxdTZV?=
 =?utf-8?B?em5iaXBDd2xxOExzL3dXUjd3ekN4Wmc3czZ5bTc1VFI3dklBSElVM3NrUnBE?=
 =?utf-8?B?V25uSmZFTVM1WXVpd2U5bzdvY21ycmpDanZhdGI5WmNhZWZNbWpFVlMxZGR2?=
 =?utf-8?B?Tm12OTJhOGorMmRha0pIcTZnejAycW91QytSNUl0NU1HMGpydWFCTFRtZkVX?=
 =?utf-8?B?YkttMWRCcUdxR284bmYwd3oxK1NjazBuU2ptaERFZlJIVFRlNWd3WXNmeG9a?=
 =?utf-8?B?Q1VEaGZueDN1Sy94MHEyVUEvN3h1c1V5aWkrc0xGR2hSME0raU1qWmV3QVpJ?=
 =?utf-8?B?cmxMdUpyRzhMWmpaRUYyNHZnUXlwbHRqeXI5WVhPUW9Ickw0d2hzRVA4VFpm?=
 =?utf-8?B?TldLd1h6RUF1UUJ5ZGJFZW9QYmpwV2tkTThyVmdnSDFlN1RmelozUCs1dFRO?=
 =?utf-8?B?SmduZFhzSzhINEIrRGVDUFVjMjlVbmh2VzVnS3laaVRyL1pEbVhqTTVrbUNI?=
 =?utf-8?B?ekNXeXp3cnlQVUptSHNMT2E3VlljR3M5M1NiQ0lCQ0YxenBtbi9GNG1pbFJE?=
 =?utf-8?B?QUx5b3d1ODZoWjFsVXREckNBcWY4ZW5lclhYODRqRnh5SkNzK2pRY2ZJc0dM?=
 =?utf-8?B?WGNDUTNYVGVhWFpITzl0RU1xS3hLbStNUkJ1MmxOU2NmbHBvTmhlaHZUSUpp?=
 =?utf-8?B?M3BQcDl4ZjdFajRWQzZrOHZQWVdlOGZFYnRtM0ZKcGVOZnZ1Z1grQzNjUmZl?=
 =?utf-8?B?dXFDMTQvVFFBbWVNdTk5SHdFazl5dysyeEczWGM2dmJ4WnhrM21lZzV4WEh3?=
 =?utf-8?B?QTdPdkFvNC9ERDFnRGNDUGltbFhjZ3ZuVVhFOEJlRHRnVHVpWnJXM0pWQnNh?=
 =?utf-8?B?c080blpTaW1acDFqRldUT1dwd1U0aGtYM3p3TE4waEVCVWp4VVVnckdnSXNI?=
 =?utf-8?B?d0RucytyRkVSbC9Pck9QM0E5Q1BDYjFaZ3ZQc2hHQjUxcjhPUFZha0lxdHRO?=
 =?utf-8?B?YVdKZkhjNzNpbmdLRFRmaXJpcGpDQWlaTkp2NmRGdkNUYUIzZDEzVlF5ZmVp?=
 =?utf-8?B?NFpxMmprTVVMeHZZVWR4TEpyU3N1aVZMNU9lYmZkTlNRSjlPdElHSVRrUWtQ?=
 =?utf-8?B?RkdkWEhqSkRyMTBUdDFEU05sckhISStrTUdRMHZIMk5IN096Q2N1Ynk3MEgr?=
 =?utf-8?B?alRyczk4ck5QYWt0RVp0RkwvcFlsbGdXaFJDSWhwd0pNNDVMbFQxekhWdXJm?=
 =?utf-8?B?U3UrSys3VU5HVlVXY1A0OGFEU3RJeTVlcTNhQjZJNHNJNHhsTWVUZTA1MTNV?=
 =?utf-8?B?MUtMQnhwU2tsVTc1dTMwcWY2c1Q1aU5QeVROcXY5dGZKVXRHNTE4TDlvRHRv?=
 =?utf-8?B?OEw5YU5sb210MGJ5L29PU21XZjRrR2dvbkhGcUxnYkUyZmNJR2V3bit2T2N3?=
 =?utf-8?B?Slo5QTF0REdzY3ErR0RRMTZ4aVgzYmE3UDY1S1MycGhHaFVBWGIyTldaa2J1?=
 =?utf-8?B?R01uTmJHZkN2VEFxRjN0a3RiMFFtbEM0S1RuSHk4WjBLUnMxN0N3Q1RmeVZu?=
 =?utf-8?B?R1k3K3dLNDB1ajBhV0JOazJTNDNSR1lBMG8wWVUvcWFLMyt0R3BpTzBHUnBZ?=
 =?utf-8?B?RDBRbnpMVW1mVzhYMUVQVGYxZlBSLzhJWEg3cW1YNDNUYm1qYURxTHZKODVX?=
 =?utf-8?B?TXh2UjhWY1gxQi9hOUxMVWs5eW90RVJmUGt3clBKT2lRNCtWVUxSaG1ZMDRN?=
 =?utf-8?B?Y283UVBOZWNkYTZMSzV6SHpJc0krdkdvQ1FzV2Vja2tKMVNyZWVJZWdjVFRz?=
 =?utf-8?B?bFp0RVpmeGEvcnlaZzdBVDJEVStXaThoQ3lEWFoxQWlhVWxQRkNocVVQVVVj?=
 =?utf-8?B?d1VlR2VWVVZSRUk1V1NmV3pzSURvZmViT0kxZHhUTW9zc09RZCtUSFM1b1hu?=
 =?utf-8?B?Ly9ZeFUxT0R0UzFVZ1dLUHYyV2s2c1JlK3pvNzc0cVQwUkxRYzI1THBONnFC?=
 =?utf-8?B?d0p6cEpJdXpxV1o2UFYvYy80ZUlOMmxjMG1nZ0dTeXRObjFNNitQWThSbm1K?=
 =?utf-8?B?N0RQY0xTYlh4ZFI2N2N0a1ROWER5K21Zc1cwWEtiUGQya1QyRHNBa0VVcHFw?=
 =?utf-8?Q?hmvdmUsau19OOAYyAD?=
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b1b7228-8a3d-4dfb-1b13-08de6467c4c2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4558.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 03:36:37.9637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4s5MaZLIVph4pKpik332gSL1M4/VRaqUT1OwiXJIGad8h4cDGUTuB4h0QAp3ASZO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR18MB5391

On 12/23/2025 10:32 PM, Krzysztof Kozlowski wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> 
> On Mon, Dec 22, 2025 at 04:45:01PM +0800, Tzu-Hao Wei wrote:
>> @@ -15,6 +15,7 @@ obj-$(CONFIG_PHY_AIROHA_PCIE)               += phy-airoha-pcie.o
>>  obj-$(CONFIG_PHY_NXP_PTN3222)                += phy-nxp-ptn3222.o
> 
> 
> Where is maintainers file update in this patch? Why shall we take
> unmaintained code?
> 
It's in this series 4/8.

>>  obj-y                                        += allwinner/   \
>>                                          amlogic/     \
>> +                                        axiado/      \
>>                                          broadcom/    \
>>                                          cadence/     \
>>                                          freescale/   \
>> diff --git a/drivers/phy/axiado/Kconfig b/drivers/phy/axiado/Kconfig
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..824114e6068da327308321b9884552ad33db9efc
>> --- /dev/null
>> +++ b/drivers/phy/axiado/Kconfig
>> @@ -0,0 +1,15 @@
>> +#
>> +# PHY drivers for Axiado platforms
>> +#
>> +
> 
> Missing menuconfig or other if-block for groupping this with your ARCH
> and COMPILE_TEST dependency.
> 
Updated in the next version with
depends on OF && (ARCH_AXIADO || COMPILE_TEST)

> Look how other NEW and MAINTAINED platforms did it.
> 
>> +config PHY_AX3000_EMMC
>> +     tristate "Axiado eMMC PHY driver"
>> +     select GENERIC_PHY
>> +     help
>> +       This enables support for the eMMC PHY block found on the
>> +       Axiado AX3000 SoCs. The PHY provides the physical layer
>> +       interface used by the Arasan SDHCI host controller for emmc
>> +       signaling and timing adjustment.
>> +
>> +       If you are building a kernel for AX3000 platform with
>> +       eMMC storage, say Y or N.
> 
> ...
> 
> 
Clean up the description in the new patch.

>> +static void arasan_emmc_phy_write(struct axiado_emmc_phy *ax_phy, u32 offset, u32 data)
>> +{
>> +     writel(data, ax_phy->reg_base + offset);
>> +}
>> +
>> +static int arasan_emmc_phy_read(struct axiado_emmc_phy *ax_phy, u32 offset)
> 
> Useless wrappers. Just use readl/writel directly. You are not making
> code more readable.
> 
Removed wrappers and use readl/writel directly.

>> +
>> +     while (1) {
> 
> You proper read_poll loop.
Removed while() and use readl_poll_timeout()

>> +             bool timedout = ktime_after(ktime_get(), timeout);
>> +
>> +             if (arasan_emmc_phy_read(ax_phy, STATUS) & DLL_RDY_MASK)
>> +                     break;
>> +
>> +             if (timedout) {
>> +                     dev_err(&phy->dev, "DLL_RDY_MASK bit is not cleared.");
>> +                     return -ETIMEDOUT;
>> +             }
>> +             udelay(TIMEOUT_DELAY);
> 
> ...
> 
Removed.

>> +static int axiado_emmc_phy_probe(struct platform_device *pdev)
>> +{
>> +     struct axiado_emmc_phy *ax_phy;
>> +     struct phy_provider *phy_provider;
>> +     struct device *dev = &pdev->dev;
>> +     const struct of_device_id *id;
>> +     struct phy *generic_phy;
>> +     struct resource *res;
>> +
>> +     if (!dev->of_node)
>> +             return -ENODEV;
>> +
>> +     ax_phy = devm_kzalloc(dev, sizeof(*ax_phy), GFP_KERNEL);
>> +     if (!ax_phy)
>> +             return -ENOMEM;
>> +
>> +     res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +
> 
> Use proper wrapper to combine get resource and ioremap.
> 
Fixed.
Calling devm_platform_ioremap_resource(pdev, 0) now.

>> +     ax_phy->reg_base = devm_ioremap_resource(&pdev->dev, res);
>> +
> 
> Drop blank line, there's never such.
> 
Removed
>> +     if (IS_ERR(ax_phy->reg_base))
>> +             return PTR_ERR(ax_phy->reg_base);
>> +
>> +     id = of_match_node(axiado_emmc_phy_of_match, pdev->dev.of_node);
>> +     if (!id) {
>> +             dev_err(dev, "failed to get match_node\n");
> 
> What is the point of this? You do not use this match at all, no other
> devices. How can your device bind and still fail the match?
> 
> Drop
> 
Removed.

>> +             return -EINVAL;
>> +     }
>> +
>> +     generic_phy = devm_phy_create(dev, dev->of_node, &axiado_emmc_phy_ops);
>> +     if (IS_ERR(generic_phy)) {
>> +             dev_err(dev, "failed to create PHY\n");
>> +             return PTR_ERR(generic_phy);
> 
> Syntax is - return dev_err_probe.
> 
Fixed.

> Didn't Axiado receive this feedback before? Are you sure that you have
> procedures set inside to avoid repeating same mistakes?
> 
> Best regards,
> Krzysztof
> 
Thanks Krzysztof.

I have checked the comments one-by-one and make sure every comments
are adopted.

Best regards,
TH
