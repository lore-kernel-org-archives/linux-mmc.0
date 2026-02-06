Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020074.outbound.protection.outlook.com [52.101.56.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BB6346E74;
	Fri,  6 Feb 2026 08:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770366198; cv=fail; b=dMQ/F+eTNYqF2D3RtuKUfLPlNnt9llR8ECKTUjsUqLC4G3cDPJUOAiKTdAewQev22L9q/RS7gwafG3nbkSXba16weWIBoZv2iO81Q2LWrD7hmcO4iAYqc06H8OQZ8GhFvzqugM+2hkN96DO6xApAHkykKSQI+I5xZ/FHpByJ2RA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770366198; c=relaxed/simple;
	bh=CA//isqTli9HVrkLoKHf66vRxcfAO85EOW7CzFgx/2g=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=kykMRL8bGeRpbWvH62Z5mzGsoGk1z0vA/JyNHzjy7I7/K1oPm91Eb1hmTJFHcGpHONwUMPY6FZ8TENIBUkKH8jx/BaKOSxe4TFQu1E9mDd+Ml8zavGxbqk6a0QGgxkNNA5AaCvkWYJA1CZJbw/omXG5QXizndrIO465RdgcSw5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=M71nyoJZ; arc=fail smtp.client-ip=52.101.56.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="M71nyoJZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n5hvpVymWWiFktFFZe3wCSCek774Bs70BP8zceWZ7sQaSWIGuxWZzRfTdL+d2xEdjO2JWMGjNmUF6aZeSdlYo33EpjSYKxTZ74KqPKtsREqpY27WwvcSoR/EP8Y/b5FYdQITbASUSMJL7b5vDEWQAmrc9rxZbrL88fHtPV3LBxTkZ5gk8EdflgZpqQdDZGG1eVSNxc0LM6nptXPD8SxlafME9Lrr4ocNvnga1HTMDney/1lkKY5W/HNjoSBStl2JrO0vCUiSClYbZosq6I8u9kvXqYV7Enu8vuRqFvmXPEC5ErrMeJ8rB0uFUEbWBJhi7CxNfN9FShHTnuWbcr78vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OXJZWgUr52qkbZ0WNpW4tH7jGKr6+6ZxXy67fAWoKdM=;
 b=AIxy4XjiJs2XV42j00qJCfTASxiZU0RMehnLPpbYjEMgYMBxluHmaMbcXCvQs55/5l2bB7mTtU+2maBeu8tXhrjtXTjtP+rEL3pv24ho8xYD0Pwe0JRx5UI4/HTxA6aT7wzBG77sasEndNsl9a2mCi7nNqbtH7kVP4TeKvr8I8kuNru2EZMBj33g2VzS+Hpj3fCORX1HO8wBMQEq1aqJlpIAH4SxDqtA91Nn1CZemNeGfUxA18wng17t30JIn3h9YngurgwWs8bgNAGGymQ3bNY975/qM+l/Qss7XBFA3HPIOMzfFXNR0kg4AMcwnEYRndr2h0LhpPBnqhpS/OYwAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axiado.com; dmarc=pass action=none header.from=axiado.com;
 dkim=pass header.d=axiado.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OXJZWgUr52qkbZ0WNpW4tH7jGKr6+6ZxXy67fAWoKdM=;
 b=M71nyoJZifrDHbKq/Pn4ryIDyfIFGZJAvEeai2Sq6P487GOWAOLMWoQKEMZpFgbQzK+N2r8aDOM75doRleI0P6J9Qti/xWkkBxPNy2JHcgs2qAODun9Bckh1qwJcPyWNt8rjr0ShiSZcihllez+OPsyqTKJoCHAT+yG70U9wWaX5fbe7MzPPDO3n81YVESI+rmWTU2dsMdFHATT9w+MKvMnM95r16i78YzmL+ZNC21ypRdpn8gnfuHZRJR7budMLzJtV4QqKop5GfAnK7sbGPBoADif5KeszXYcouoGl223QKiumLRiK1iPcO2xnzfUCVVEwkZJR2Mf+LYpSY7Q7oA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received: from PH0PR18MB4558.namprd18.prod.outlook.com (2603:10b6:510:ac::13)
 by DM6PR18MB3667.namprd18.prod.outlook.com (2603:10b6:5:2ae::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 08:23:15 +0000
Received: from PH0PR18MB4558.namprd18.prod.outlook.com
 ([fe80::7a75:75a5:694b:2311]) by PH0PR18MB4558.namprd18.prod.outlook.com
 ([fe80::7a75:75a5:694b:2311%7]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 08:23:15 +0000
From: Tzu-Hao Wei <twei@axiado.com>
Date: Fri, 06 Feb 2026 16:23:07 +0800
Subject: [PATCH v3 1/2] dt-bindings: mmc: arasan,sdhci: Add Axiado AX3000
 SoC
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260206-axiado-ax3000-add-emmc-host-driver-support-v3-1-ef83b09325be@axiado.com>
References: <20260206-axiado-ax3000-add-emmc-host-driver-support-v3-0-ef83b09325be@axiado.com>
In-Reply-To: <20260206-axiado-ax3000-add-emmc-host-driver-support-v3-0-ef83b09325be@axiado.com>
To: SriNavmani A <srinavmani@axiado.com>, 
 Prasad Bolisetty <pbolisetty@axiado.com>, Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Michal Simek <michal.simek@amd.com>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-mmc@vger.kernel.org, openbmc@lists.ozlabs.org, 
 Tzu-Hao Wei <twei@axiado.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1002; i=twei@axiado.com;
 h=from:subject:message-id; bh=KqVaSA0SxIPP/WLkfIZdG/wk2jww0OvEZJZpXe7D0tg=;
 b=owEB7QES/pANAwAKAXgQMF3EWvHXAcsmYgBphaTyRwHT5Un6FV/E/yRHbtbSFgm0xD1aDrSre
 H5dZLu9Ex+JAbMEAAEKAB0WIQSZyWINOowtFmDvdYF4EDBdxFrx1wUCaYWk8gAKCRB4EDBdxFrx
 11/uDACYPIe2uyXXnIjPVSzscXPaGeECWyH212Q9aDQyCqJNL8+Z7EvF+vzgJj1QSP8VuBtm9aB
 5Z5DEg9VbmttGl0lHtG18p+vCv5muBvQQtWxG7fFGQL7VSFzUGn6TwU5XYg3s+sjz2mQWpj5Xzc
 cWBbnZDvGdWWaEdKZX4+6N8KompqtpQHgwq0TBZbGkMQTu6o66YHKNcyeRFxHtsQVrUAQ/IFz1F
 aLTnZTnS6sfiY/qKGO0wiuWgYMcm21wk6yf/IiJ2opa1OoGA1kJ7eqD/DjzKGyEUBux+aI1pECe
 lb/X7aiaMhH6DLE0tvaOjvypsfJQ9FPaeEBsvv6HKCFlFNwwmLwR76BZ4T8ApLlUN2uoHlFJ+n+
 dw5JLh9GB5NbmOPhrvO1i9AScwp2YuwKtk8MYfy38B4vHLNFln3dAt96vV/mHAe+jrgC9wpV4Cs
 D7oFTwAdofZMHRrpv2yn5+PzMB6xkWBN/LouF7byJOM6m9Kbe/6B0NzqUYUrQsCgCGAhc=
X-Developer-Key: i=twei@axiado.com; a=openpgp;
 fpr=99C9620D3A8C2D1660EF75817810305DC45AF1D7
X-ClientProxiedBy: PH8PR22CA0016.namprd22.prod.outlook.com
 (2603:10b6:510:2d1::9) To PH0PR18MB4558.namprd18.prod.outlook.com
 (2603:10b6:510:ac::13)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR18MB4558:EE_|DM6PR18MB3667:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bf2567f-1769-4585-24c7-08de6558f9d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|1800799024|366016|42112799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R0ZGOU5qa1dDRWE3TkNaNGcrQTB2S1BKYTZIcExPcFFuTHZERWJ0R20xYXk5?=
 =?utf-8?B?cEpPditialNGYnJ5VFBrempzZ1NSdjUreExvL1RqbDU4SitWQ1AwV3RXd0NR?=
 =?utf-8?B?a2VRcDJ1RUxBclBMemd3RzJCOTh1djVlb0UvL1JTOFBzTS9nTjJPeFBkY0Mx?=
 =?utf-8?B?NFUyMlNITDRDb0FLd0hVQ21HK3RyNjlqb2dEelFrSzBMc1NaODBwZWlWRXhz?=
 =?utf-8?B?MmZySXdaejVwWXNIaU42aktVWlRHRksweitEamxUNTNrMXlKWjNXWU9MQ1BZ?=
 =?utf-8?B?ZGlCTzhaZXphYjVEM3RyY2tYNWhpdlN5R3g2OFhyT3dyUjQ4Q0EvUS9EMVkz?=
 =?utf-8?B?MGhnWStkWFU2bWYyZ0FHQWhxWHhTL2JlU21IM25yc000cUdQbVd5b1NSdHJt?=
 =?utf-8?B?dmtYK2N5K1NUOFpWV1lyVVdEeEdtMGkzdTBOekFkbmwvRlgwcFdnRWtLRnNw?=
 =?utf-8?B?UUpaRWZKSWc0MFlYbnRISTE4OUpLY0NyZTlscGVSQzJNUFFYbmxpcEQ4YVU1?=
 =?utf-8?B?bDBLMEVXdWFPR29JaXF3dVBNRkh2VUpSOVQ2Z0ZLckF0VG5JRHBqL0R2ZVBE?=
 =?utf-8?B?K0IzaytrKytkcUlzdzZiajBoOXBlUEUwTGxuTGVDbVZxcmNUSnBkclNzNFJM?=
 =?utf-8?B?NzR2amRCUEhUMmJaM0RKS04yL0pubEZLbVRqTzRXQUhaSVY1cU9lenBrdmxQ?=
 =?utf-8?B?UEtQN091L0oyTkZiRDFqVVlkdzVSSFloMS9wYlNzRWhvaHJ5V1lTSUh2b0lD?=
 =?utf-8?B?VUExT05PT0N3ZkJtNllqaitnMWdnNXVJdXZENVJMTmVXWmpDWTFJTDVSSXJJ?=
 =?utf-8?B?RE1MbFJNVWNzRDdkd09IM3lIbGRiWWNSbFRlMVRIdEF3WE92TC93T3pxQWg0?=
 =?utf-8?B?QUNVU2Nmd080eHJvbmFaQnV6OXRQMGNKNW8xQ3gwVmVnM0JTQjhnZXBuOGhH?=
 =?utf-8?B?K3B4RDVpSkx0alU2eTR3Z0VJUU1iUi9ma2RLTTVLeFdkNThwdVdLalBTQU5t?=
 =?utf-8?B?eW45QWxlMTAxb0hKS3pmT0V3RFZncDYyNzJSUktYUiszY25GdXdXYmQ4dHdr?=
 =?utf-8?B?a05qZ1hKa1dDcDFRZzh2aEMwQ3BjQngwTmFZcDU0VitsaXVMdXFpcmtUL0Fn?=
 =?utf-8?B?cDlwT3pUd1IyOGxDTnhTT1pZTk96dWdiYUJPbmhFTENxRHhmdGc4N2lhQUNL?=
 =?utf-8?B?cEhkMmIwcEtkMGMzZUVENVk2eDgySnBPWDQwOEQvWGY2SFJsMnVUZzB1akNk?=
 =?utf-8?B?TW4yQVd0QTg1cVZVd2RyeTQ3ZHZKN2ltQ3YwcGJFSmNFbm8rOFBZUjFDZEFK?=
 =?utf-8?B?RjhYVFlGOWV6TUhkS2VPWmcyVHdrN1VtUU9NQnlOSm1tTXNHcHd4YjJ1K29O?=
 =?utf-8?B?aGp1KzNJZzN0bHN6Y0haSFlNTlZKOEJqM2RCWUZxL0U2MnpnOUhCUXQ4QnQx?=
 =?utf-8?B?OEhGTXV0RnhZZEpJVGcrY0Vta3pJVGh3OWF6cHJ6OE5RanV4aFFQOWI2NUJ5?=
 =?utf-8?B?YldNTExtejF1RUprTThQSnZ4VEw5c09TR2dFNTVicnU0NDJZWHBJNDFiVTQ0?=
 =?utf-8?B?ejUxSVpBc0pIQ0w3WnNiRFA4WDBHNnF1QzZpN2phZXlJZlpoS1FaY0hzNG5R?=
 =?utf-8?B?VTdNeGFPODlQcnVRKy9EcmY3QVE2ZzNwMXZFeTdGR2I5Vnd3NmI2cTNCMmZ4?=
 =?utf-8?B?QUpKQ0lwcWtGdHJJK0RpSHl3UlNVbmhuUktsL1dqYlFpalZnQUJKNGczT1k1?=
 =?utf-8?B?clVkVFB2NUN5UEZwcDVTV3d5YklDMzJkVlFqcS8yMHMwbFBFL1FSNlBnamFB?=
 =?utf-8?B?WHozNWVobnNheWswanQyd1JKN2hoeGpNaVZDZ0I3aE9JNksyaFFSOFBzakNR?=
 =?utf-8?B?WGxtcDhLSlhPZ2g5dm5OcTVuaGhYU2FmdlRLUDU3NzE3L3RxTnh3Qm96Y0Zu?=
 =?utf-8?B?M3pkL3ppcHFHY1ExTW02K3huQVdvdW5KMlFrVTRsQTZzVzZTcU4xVFZuMDRw?=
 =?utf-8?B?c1pqRU12T1dCWENoQVNOeVNPODRtQ1dRLzVKbDR3N3ZVc2tOTVlCMFBnSEF2?=
 =?utf-8?B?R2xCcXkyVUh5V0J2RjBaVUpDckFGSWpjei8zVENYT29lZitWczkzbnZaenk0?=
 =?utf-8?B?Vm1VWkI0ZFFSRityMGowVi9HMUZHL2wwNjlWQWwvcEJjcHVMY1cwNEpTSVoz?=
 =?utf-8?Q?E0iRVw1JkilYIGuPSz70E7K+hgRhfrn3554hOLZ3Y3OK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4558.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(366016)(42112799006)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UW9kV1dRWkFWWTNxSGtBbEdjYTZKNko1bFFzdVdwNVAxN1ZydE1nK3J0dG5E?=
 =?utf-8?B?bGxjRzZ6azNKUW1Jbk9aMlpTYlpwalRaNjg0QjA4cHdoUTFsSHRpSkZFVHRR?=
 =?utf-8?B?NFdtN2dEajlnVitRYWhsZ2NrbTE1RkV3a3BYMnJPblUza015K09nMG5zSjcx?=
 =?utf-8?B?VkhoT1N4YSt1VjZ5eDl6b3BRL3JOb2hSZFY3akV1K1B2bTFCRDhmVXpoMThY?=
 =?utf-8?B?d2tEUFJaMkVMVFpqWFFkT3dLajMwQkFwekorelRTR0JYS2ViVURDZ1QzeGFv?=
 =?utf-8?B?ekFRckJwOC9hVUZFbjROU0dPaUdCdVhCem91N3Q5dm5uaXBWVVJmZTdoK0t0?=
 =?utf-8?B?MWZsNVNGQ2tuekVlK2JOQmEvMXg4dGF0SFQ3VjRWMktwa0YyTG1ncnZZR1dO?=
 =?utf-8?B?V3lRVlBIV3NuWStXMyt6NEc4UThiL2IxUnBzVTFvdmpDSWlxUXh2ajRZVSsv?=
 =?utf-8?B?L1ZWQWNrYVMzeWcrN0VLZWRibzdIVEx1bmNQRWVnUnpzMjQrWWRKV2E0OUVP?=
 =?utf-8?B?SjhkVEtNWGUvT21IQnMyS3h4RmVwMy9oRlp0djNUSW9QdDdaMXhXVVlMWFVE?=
 =?utf-8?B?eUhMenZ1dzVzdktndW94dHd0U3h0T3A3bWhYSFM5bnNVTW5MSncrSk9YODA2?=
 =?utf-8?B?TnhJN3hLUWxpVnF6bCs4Um1uT0xYNXN4cnU4cE1HcUR6U3psZ3VBNVg3azZB?=
 =?utf-8?B?MHpVNEY0cDcrclNjMEVtZm9EcHRsTHhYYm1oa0NzNVVwTXZOYVp6U2RTTjlG?=
 =?utf-8?B?ZHZNZmxvamRGOTFWWStaY29zMVBOclp1a2lOZFp5VG05SEthMGwzZ2lMdXpV?=
 =?utf-8?B?cEI3SkhVMks3Wkc1Q0ZWbVlBWEpuMkk2UXlnS09neGIrMExmQm5NQ016M1Fq?=
 =?utf-8?B?bFdrbU96cXUraE90dkZZaGNIYWdwNW9OUnQ2VkQ3T1RyVituWTJkNjlQU3BB?=
 =?utf-8?B?MXdKdmdhdGpsczhSb00zaTJjRkk5Yk9VNE5za08zdjhoMngzcVA5RS91dkVX?=
 =?utf-8?B?YW5ZU2VQS3dXOGc5NGFpakZXT1M0NlNPaWNiTHdFdXRVZncyRy9TYkV4dFdJ?=
 =?utf-8?B?UW41UlgwWENPdG9NUW5xTEQxbW92YUJMakpITmg3WUI2eEpzSjM3TXNpRGg5?=
 =?utf-8?B?QnZhenZhMW84NUtSeU5YdFlRaEFyNmdlUDhSWHEvRmJiTngvQmhaZXlWR0FS?=
 =?utf-8?B?b245em5ha25Edm5YSHE2Nkl6b3BrbnFRVC94QmlWdUp2eW9HVGwrNjNTWE5v?=
 =?utf-8?B?ZElwL0grQWhpV2NQYjBNczBXVEFIQVBLTHhVR2NEdjlWNXczM0JOMnExSkp3?=
 =?utf-8?B?K0pSNHVrWmdMeUMrUHFBY3BjZUZUeFM1VDBYYWk4V2lLWW1OTCt6Y0JZb2x3?=
 =?utf-8?B?Ym1hTDh1ZlkxcnlBdnYwazRXQmtTZ3VpcmRhb3M1YVNIS0Y3b0NTcTFaMTBV?=
 =?utf-8?B?ckFXTzZFUGpnVzFCM25SZzFSWWlVUU5TNXluVWlLM2phVFZRTHRJaVc4TEtl?=
 =?utf-8?B?RVBqVDdTa09mY3VRV1hhalF5SXo2ZU9OWHAxUDFKMTFEVnNvNlRoa05oMWhG?=
 =?utf-8?B?cEJwQTdQUHJFcFZaYUF2Zkwwd3dLMjZ5SEpZVUJXWTdkT1AyS2N4a1oyR3R1?=
 =?utf-8?B?WjZnMG9BaGF4M2x5cGJGSUJvU20rcEY2Mkppd3NhcEZVdkJodXc2N3hTSlhx?=
 =?utf-8?B?WWg3ZFN4bHV5SWpWMDBEREZjRHFqazB1elZjUG0wWm9DbVFrUWVMdkVFaDY4?=
 =?utf-8?B?OGQwZGJFeDRIajdKOWNibTMzekE3R1VISEl6TmtOSEpIcE9JVWF6WEdHNmVK?=
 =?utf-8?B?eWduQU5VemJXSy81RlhmWjR2MHFMTnRLa05FU2pxWmZ0eURVajZsOGtPVkN6?=
 =?utf-8?B?TkMwUnhZNmhrWlVPU1BaTTVPQ3UyZEdHMFdFKzZvT0hLZE5YMzBYR1QzOHdw?=
 =?utf-8?B?dnAyNjdZa3l4T0NheElZcWRyRld2anFaRTZoMFU4bWE3YVhjMzBKSDVrOEJC?=
 =?utf-8?B?aUI5QmRKUlRONCtXaW9MZU1XT3M1WTRLWnVFdGdqcWJUdnZmclgrRStQRWor?=
 =?utf-8?B?VWtZVnJ4UWE2WXhSWkNDRUZMZk1vNUorS2g0OVMrcTZZamQyeTlYcDNndTUz?=
 =?utf-8?B?SWtYajkvdHdIR1RPbjl3cmVwLzN6TVRGRGZRNjNEM2dublByOXZ2RVQ1aDhh?=
 =?utf-8?B?ZzVYSWJZZUZPWFo4dVZPczB5RnJ3bHlxdHEycmNmM0t5dmpydm4vUlZwRjFo?=
 =?utf-8?B?Y0pvK2pldGJ2cUF3Q3J5Vk5xVlNFMUZnTWFySHZPTWlxQ0wrd1c2R0dNOHNM?=
 =?utf-8?Q?ZrXi212NMdudZZuO+z?=
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bf2567f-1769-4585-24c7-08de6558f9d9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4558.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 08:23:15.7291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AUOgyR+98KWI/DDlOwNy7dKL6H7HciRS5EmAflWf9JJbQd0YSzJk7UAFlRolbkpG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB3667

From: SriNavmani A <srinavmani@axiado.com>

Add compatible strings for Axiado AX3000 SoC eMMC controller which
is based on Arasan eMMC controller.

Signed-off-by: SriNavmani A <srinavmani@axiado.com>
Signed-off-by: Tzu-Hao Wei <twei@axiado.com>
---
 Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
index 8e79de97b242a698a2c555b0b94e2975b1761710..17dfe220503a6722b9ab446cb6e1aeed56099caf 100644
--- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
@@ -106,6 +106,9 @@ properties:
         description:
           For this device it is strongly suggested to include
           arasan,soc-ctl-syscon.
+      - items:
+          - const: axiado,ax3000-sdhci-5.1-emmc  # Axiado AX3000 eMMC controller
+          - const: arasan,sdhci-5.1
 
   reg:
     maxItems: 1

-- 
2.34.1

