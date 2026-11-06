Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.61
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793945831;
	b=D8BW5tTwY6Pvu4lc7V/cgBnmu3pvGkJtB+YwoiSbSB8+TUcFjNlXUBVP6LeqIDup1iNg
	 e3Mdt5t41KxJJKO4dPzXQYONDvNMDWFuuiLnDl7As84vawsF5OMg4Zg1WVOy2A24t1PSw
	 yLWgOUQNfXPl1JYqJ65HaZGdHB2uq6SFAuqowQu7fYF2qijdWLSgf57U3YRvm6WG4rgyT
	 BrMOMQNtu/Y9qXYBDSSMpNJrsTfPTy1CoAyyj1QKwVS/meyLancPrrfeSaGOgvn7g38S+
	 UmuA6f7ox5D2x9SahxaIW0I50Kp21Kvsl+OZijSIw1S5tZDjTE3+MjLv6RjVjZKooag==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793945831;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:Content-Type:X-Change-ID:X-Mailer:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
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
	bh=6/wQ6IWZoTborttxvY4fagK1AN/Oynczyi0FEHE7YwQ=;
	b=nVAo/ZHpmuh20nkXMkbd7pLASCJkVGJWpOr5sLVgO5szHawTnq2CLljLTHzcdIR9JKbL
	 WO6cxd0dU3L3UbFEVBCmxZnQ5zCvuxsQJKxRvhrnuEm05QPqlMSOuw4yI6oAXChbDcz40
	 dHaNtwjI4Kp4hDDmFCL2vch4ayN3f9wqohj8CBtInQwd9swxpdN5g2i4Ag+nDlv9/yKu1
	 hmwb16EhrhbLrQlFrjdvxEFB3VuG+WWzzFZKAjdw5LkwdlyZxvQ9xaXxuBskGrNigSApX
	 JLqX5S/3tqnfqH5PJgvFCYHqYORvVWGjxJcvXKqdoVvdVfHKHRXnQgAzhFuZeEHLkcw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=altera.com;
	spf=pass smtp.mailfrom=altera.com;
	dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=fl5cUIzD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.61
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011061.outbound.protection.outlook.com [52.101.62.61])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BD0606A326;
	Fri,  6 Nov 2026 06:17:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11BD0606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=fl5cUIzD
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eGROamA/rNi/sDHj+DRL6xMY8o++NIJgh90a3kgLeF7kHTPetND4xllydgxtexjTC5/JsV12HelvjMneqpTHqhNj19a8qPaq3MJw0p+3JDPkCC30b4ESTf64IrBtOrmxES1y36uK/Ma7SnLfH4JK7XBPRWzEaJltzeVo1lghw/PfzGxC5is5GpBCl7u4a3H40f7yeVghGjC7j9J+72RTZ7sQKPXW5joPF7Lt7p0j0fm06bQfsN1VYVQMpwHa6ESstqyb/SSFBEiZpIrhJmBM5ByCTAO3oYCjaG7vm/LFJZ4QHPdcMzeSpk3JWOPkfQrU48NiqIz0n/w+vHA3GHtT3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/wQ6IWZoTborttxvY4fagK1AN/Oynczyi0FEHE7YwQ=;
 b=FwYM68LIbqLsDLvSb85IMQ/Mulr1pggDJfnCz9KFc4jdeKCTF/4UWJF93vEWLTi2tWgp3tGvaLrn6EguJHCkiAj7Jo4ew5YN12J38meYDAxiRc2gsYts9kbrjDB9P+k/ISxaTi3JYwWNR8Xxxm/S+JtMiwQgLvnsvOYoSC97HskhlcIeCrDN1oSi0jL/bW3yfKUTGoMOPurW26nLNbIJ7W/uLgOhg04sSaucRlQH9faLvp6g+CkZkdvrutP7evy73lnPonouyj/JMdfK/lvs8xkck5Onjk5q1kGVO1f+lBGlXPzfZKhxAfTRkgJ+u4KVIUSdh0LO+jWNriZCQ3OoIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/wQ6IWZoTborttxvY4fagK1AN/Oynczyi0FEHE7YwQ=;
 b=fl5cUIzDRxhHsclmunJx5urrLEFqyjbbYKX4bRg4IHz7dBvaHw0KcJUi5ebX95Wv7sNywqIktk/APlP7JARqf0TMYBdzaykT7HlUL8ziFU1vxnlrT/y35lXO2s2FHL0K8SMcVZ8JemNr+yNQRXq75Okque1LUi4UgWMQ3F+5I/+5rrszhvLjx9JplafhzVRPgOwPp915k/L52ztNK9dYCfhEIBmP+kPtrhZQDY+MGEkvOfF2PC629SEO2pzTZ3wrvFxc3AS0S6wA+J5QgyKB+BF3xu7VPSuW3IGqOKgVHFtG4gr+AcwWW9SbbhE+IoJB81yxPSnyYzYvnEpGJrJZYA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by EA8PPF1471CA897.namprd03.prod.outlook.com (2603:10b6:30f:fff5::845) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Fri, 6 Nov
 2026 06:17:00 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%3]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 06:17:00 +0000
From: tze.yee.ng@altera.com
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Ulf Hansson <ulfh@kernel.org>
Subject: [PATCH v3 0/4] mmc: sdhci-cadence: SD6HC DDR50/DDR52 read-path tuning and fixes
Date: Fri,  6 Nov 2026 14:16:51 +0800
Message-ID: <20261106-sd_cadence_ddr50_v3-v3-0-cb50afece614@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20261106-sd_cadence_ddr50_v3-35f970f31364
X-Mailer: b4 0.16.0
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR05CA0045.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::20) To SJ0PR03MB5950.namprd03.prod.outlook.com
 (2603:10b6:a03:2d3::20)
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|EA8PPF1471CA897:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d57405d-64f8-45ec-5fb8-08df3bcd9166
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|261028144727099003|261022075727099003|261022105027099003|261021123027099003|261021121427099003|261009223027099003|261026121527099003|261026140227099003|11063799006|10067099003|260925021311599003|260925021911599003|260925022911599003|261102123227099003|6133799003|55112099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	N+8jal8AfWZPJ6asFdVbeQTiXLsGfrma67D4P0dkQcSnOJqFUfuGaVLqMptmMvLN2BrD5mgpvR7uRrlF/x6oGv777lH15MjR8AyvoD53VitR0q4cAGmi9MGGhb2PLG8eQn/CsYh95g45U85eP8Xh+1fOXJkZ9IR8w+prLFUW1GFc9ni96wpO6o2Mwkb10X/QUu7ZTacqndL6AhEXsfd3Lo8y4VOJI1q2yjXiydyqxh44FlGXj/UT7OKpOmKrk1h+KSLmWx8EDx5jqe9Hl5Fre3ztyWPt8uAqJ/RoeDSB4ryD0gJqnym95DW2UOT6vGtkJRgoqyVGbk9yZYAcIH+Sqs89gGciE632lXLvuRsuPKDRKvVeONkuJ5nDjI+b2Lf3GVX7xpiCYU9v8ljmnlx6HDSlv4tAEpXSs0mrGeIpJIjpQ+KhnICUM3r97Paxme3ilacTVMfKXhb463mXd6duuMUW5lnsUtDmyyZOavyOlhueViDA5o8d3ErZkG6RxtF8vZSxygbTNRT88yLayQVQBTRwVRyb3Ay5Rop23cPb8oKRYsXQykLR2JFjNAav6DY39yBKirU+n6x/0ujdch5yRjuoP9VkZHbjxWE4jnztklUgPZQUqIED6driq7FDfkxL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5950.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(261028144727099003)(261022075727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261009223027099003)(261026121527099003)(261026140227099003)(11063799006)(10067099003)(260925021311599003)(260925021911599003)(260925022911599003)(261102123227099003)(6133799003)(55112099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b1U5aHdRbTVGZDBla05zUlJ3UjhCS3U5TDVGMGhNNHFCTWVRYmwrWmorV2x6?=
 =?utf-8?B?eXo2cWFSUjBXYU9ZbkZibFplSkNDbGMzcmhzc29wcHpFc3EzbGVvSUQycjNE?=
 =?utf-8?B?SC84NjJnQXh2L2M2elhtOTFiZis1ZzhicWlHWE93RW9vZ3IzSGgzbWVSaGdF?=
 =?utf-8?B?a2JHeloybklQS0xoS1IyNE5tVFk0NGI4eDZDYlRkLzlNcVlvYkt5elBYZE1w?=
 =?utf-8?B?WGpZY0RYaTBCNUxweis2UUhSTlZLbWpmb045WlVHNjA1NFdIZ0xvcVl3SnlC?=
 =?utf-8?B?S1I0K0t6ZEc1clYwcGFqMXNwNURVRm9NdS9vd1RhbFlmS2d4Nkp5WjlNUWVn?=
 =?utf-8?B?UXJ1MTUwTkhOdlJSSHU0dmt0T0UzUFhXakhrYWQ3QUROK0U1UGM5VkU1WFFW?=
 =?utf-8?B?eExPUDg1RCsrdGM0NWdvMzU4aGg4UU5jd3YySjVveWxkNEh6bE1BRE4xM0Y4?=
 =?utf-8?B?MnU1bGdsNDEvcjgxOUdQbUdFajQ5UlhzcW5rbUc2VVBmVVpudk5QY3oyeENV?=
 =?utf-8?B?VlROcytIckJjZmFwZDVqd0phTkxwOHhLbjErWGFXcXk1QW0reFhwTktBOVdr?=
 =?utf-8?B?TTI0L2JDVXVJdS9wTm5wRWt5c1VrbndRZGJRTDdmcGo0RWM0VGVTS092VDhk?=
 =?utf-8?B?S3lFS1Z6V2dKc0VrdWRlOHV2OVFuTWpGVk5iVEJ4aG5RZm9TL24rcjZ3dkw5?=
 =?utf-8?B?QmRFa2pZSEtkbXpFU2htdFkveUd1Y2x2c25EaHA0WTVLeDVtYWF1QjNBa0tr?=
 =?utf-8?B?b1pvbHQ5R3hPZnJpWmh3dHBKZjZXcDRWaitJUUtoTTZoNVh6Nitoa3VzLzBV?=
 =?utf-8?B?SEVtZFFPK2JReklGMGhzOEtTVGVCbDJPUGNlWTVHaVBsV3RhQkFCR1V3NWIx?=
 =?utf-8?B?eEVPa2c1RGtwK2R5TXBiVUE0aEIrSWRXeFBmRGpWUk1wS3RhZUdVYmdBVE0r?=
 =?utf-8?B?WW1aZTZpMkw3RUVTQ0c0bXoydjlUN2htK21vRkdDa2VwSXZIczhXNnZmRG0z?=
 =?utf-8?B?UGNvRUU2TnJETmt3cEhzYUJaMVBMYTdvd3pld3ByK0tyQnkzWWh6TUUzc1lV?=
 =?utf-8?B?c3k4OFczVFFWU295aXBWTENHbVBYQzdlNnZKRjJpdm1SU3c5UnJYQkVCQk9v?=
 =?utf-8?B?bkhRTTBUMm90eld1d1BFVFpKZjcxbEM5TFV2blBxU0o4dGtJaGpFUEZZTlNw?=
 =?utf-8?B?WEJ1NFZaSTJKSldHWHUrTlFIdGY4SzYxSm9iRzc4dUV3bHlraC82aUlKcko5?=
 =?utf-8?B?Z0FkczZxcnkwL0o0dlVGUXdJNVNhT2psY1VQTG9XRE1kRlVTS2JlOHlFeU1Z?=
 =?utf-8?B?SnVSZndTeDVWbHltYWd6Z0RsUm1oeVd2UWZ0MVExMmppM2p2eUJjQ3ZJZUQ1?=
 =?utf-8?B?bzFGSHRJUW9INVY5eXh0MFA1UEVLVktsNXlrSDR2TStwTTRQYlNzV1ZOWXFB?=
 =?utf-8?B?Rk8zQTMxdVdidU4zTkovMGZQdll4K1VwN0R0YjgwRjZQMFpsMkdwS3M0K0FJ?=
 =?utf-8?B?SWNwSHNXbng0ZE9BeHZUZnlTOGFZUk9xdDcwTFhUdDFDSW0zMUdTN3VSOW0w?=
 =?utf-8?B?S0tnTHRxMFBpWDdmekV0OUFXNGNOQ2htd3JnaURkMkYzdXM3ZWR3QWNjTzh6?=
 =?utf-8?B?U0lQQkFKMEZkRHM4aUJFcDlhK0EvUktoaDJIdzk4Y3VIR1JrZVF0ZnR0UWpE?=
 =?utf-8?B?bXpUeGZjK2NmMGM2YlBBMVdJZ0JDN0Q2OGJXYmlGUUZLZEJtU1dUeFJ1V1o3?=
 =?utf-8?B?MVd3SnRTVm9jNi8zYUdSVCs5Yy8yVHQwdCt5UUI2M0tCWDZveUpwTlJFNFpv?=
 =?utf-8?B?L2V5QTJqM3g5eGpFamNya0plaDNyMmM2bG9ucEVYRmFTUE9GVWFRek1iQWVp?=
 =?utf-8?B?Q2NXcU9FYlhIenRUbUpYWnltNkxhUEowUmRsWCs3eWZIakdPbWFiWHViZm10?=
 =?utf-8?B?YzNHamR4bjc0NExlN2J2TnhzV1JXRHVXdHZrcUVUQzQ2U1Y0VXhZQm1sMkwv?=
 =?utf-8?B?aWhEQnZhMEpVbDVxN2k3K1FnVHJGZ0pKanFaZWhhcGxtSyt3a3NaOE9nQnhz?=
 =?utf-8?B?cWxnUm9BQWJ2SHRhL3BNSUxVb0gzWmdxTHNPUzc5ODl3NGtYYm0zbkRuNzNQ?=
 =?utf-8?B?SWx2YjZOUkRweHJQUFBFZFk5dEVWVXA5T3NQait1TnJ3RnkwVkpDM3pMZ3Q2?=
 =?utf-8?B?eVVkZSs0YTFHM1ZpRUhzVXRvdERZcXJYVlZmWVFXU2hXSmU5aHloR1hSZkhV?=
 =?utf-8?B?RWY5cE5BV3l5Z0xoU3BZcFBnUjJUcFRIZHVYQUt0MU0xNndDRk5weHp1K3pQ?=
 =?utf-8?B?cllnak9qMzlGR0gyb2xVVnAxeDZacEludW5MWXAvbUttS0c3WDBFUT09?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d57405d-64f8-45ec-5fb8-08df3bcd9166
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 06:17:00.6506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gxa9Py5G+QCU6MZVycNr7M/TEqjVrhC0Am6j8lz5RvcwRYjIoTInJEUEMnvOMdT2BQ6nuDGms0Nbbnp3HjpB0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA8PPF1471CA897

From: Tze Yee Ng <tze.yee.ng@altera.com>

This series enables the extended-read DDR modes - SD DDR50 and eMMC
DDR52 - on the Cadence SD6HC (SD/eMMC v6) PHY. Neither mode runs a host
tuning sequence (CMD19/CMD21), so the read path must be centred by
static, board/SoC-characterised PHY settings. Bringing it up on Agilex5
also exposed PHY issues affecting the existing tuned modes.

  - Patch 1: abort a failed tuning command on SD6HC. The software tuning
    loop never aborted a command that errored, so after a CMD21 command
    error the eMMC could stay in the Data state and time out the CMD6
    that HS400 selection issues next; mmc_send_abort_tuning() clears it
    (a no-op for SD).
  - Patch 2: program PHONY_DQS_TIMING (left 0 in all modes); in the
    extended-read DDR modes it must be the rebar pulse width in clk_phy
    cycles minus 1, else one DDR beat is duplicated.
  - Patch 3: document three optional SD6HC read-path properties for the
    extended-read DDR modes (SD DDR50, eMMC DDR52).
  - Patch 4: read those properties at probe and apply them in DDR50 and
    DDR52, and make the DQS_TIMING update clear USE_LPBK_DQS before
    reprogramming it so the loopback/phony selection takes effect.

The new cdns,ddr-* properties are unused in this series; they will be
consumed by the socfpga_agilex5_socdk and socfpga_agilex5_socdk_emmc
device trees, submitted as a separate series.

Tested on Agilex5 SoCDK: SD DDR50, eMMC DDR52 and eMMC HS400.

Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
---
Changes in v3:
- Patch 1: replaced the post-tuning PHY settle (v2 1/4) with aborting
  the failed tuning command. Added Suggested-by. (Tanmay Kathpalia)
- Patch 2: unchanged; retains Adrian's Acked-by.
- Patch 3: re-expressed cdns,ddr-read-dqs-delay-ps as
  cdns,ddr-read-dqs-delay - a count of DLL delay elements (0-255, each
  cdns,delay-element-ps wide) that maps 1:1 to the 8-bit PHY field -
  instead of a picosecond value; added $ref uint32 and maximum: 255,
  dropped the redundant minimum: 0, and used plain description: text.
  (Krzysztof Kozlowski)
- Patch 4: read cdns,ddr-read-dqs-delay directly as the delay-element
  count and write it to the 8-bit field, dropping the v2 ps->element
  conversion (divide by cdns,delay-element-ps) and the FIELD_MAX()
  clamp. Hoisted the repeated DDR-mode test to a local, removed the
  probe-time firmware-value warning, and unwrapped lines to 100 cols.
  (Adrian Hunter, Krzysztof Kozlowski)

- Link to v2: https://lore.kernel.org/all/cover.1791459448.git.tze.yee.ng@altera.com/
- Link to v1: https://lore.kernel.org/all/cover.1790074790.git.tze.yee.ng@altera.com/
---
To: Adrian Hunter <adrian.hunter@intel.com>
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: Ulf Hansson <ulfh@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
Cc: linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org

---
Tze Yee Ng (4):
      mmc: sdhci-cadence: abort failed tuning command on SD6HC
      mmc: sdhci-cadence6: program PHONY_DQS_TIMING for extended-read DDR
      dt-bindings: mmc: cdns,sd6hc: add SD6HC DDR50 read-path tuning
      mmc: sdhci-cadence6: read SD6HC DDR50 tuning from device tree

 .../devicetree/bindings/mmc/cdns,sd6hc.yaml        | 30 ++++++++++++
 drivers/mmc/host/sdhci-cadence-core.c              | 11 ++++-
 drivers/mmc/host/sdhci-cadence-phy-v6.c            | 57 +++++++++++++++++++++-
 3 files changed, 96 insertions(+), 2 deletions(-)
---
base-commit: 2febfc8acbf712439b6d30c99b108641d881fd75
change-id: 20261106-sd_cadence_ddr50_v3-35f970f31364

Best regards,
--  
Tze Yee Ng <tze.yee.ng@altera.com>

