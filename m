Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795081552;
	b=ud+CjR2BuuVafC4wVLUxG+oe1pJv3IWjDpiLLGAyP/WArLVhYFOWuzZX6yVlzKPwufjb
	 TdpfJp8cLLDIgKHKrTXcgYlj21T+ajA3mdtFDzW6R7E5JwzLphuPZh3zOHLghEjv5iB80
	 RpYrRYrsMrYlBUL73lzJx3KabEil3qZfFEuv06VeQHl86twKGS28DqgIpkFfrXAXLLB8G
	 6psC8fgB0oZjifF/G8IGDseciP9qJ+VAosQltqJYtyWVcfOsnzZBI0bUJh7Tor/JLCpvG
	 qRe73DCfEYSYE0DkixNwIeaFDooqPECFUkWTCPZ/h8lse/RBTdbodD2vlQwjO6/Gsgg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795081552;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:Content-Type:X-Mailer:
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
	bh=P7Q5GjQN2NZeg26BaGpYbQqwviCXw6TNnmsVB3gqqsw=;
	b=1+tiQbq0RpyQq7Vi4Hd5LrekPCt/oUuIClPZBSXIiLk4kY/HByPHjy3PBXA3moYaxRNP
	 J8xy/Cin2iOBOlUxx6Cp9kZhXEJkFUGwNImmBOGh84RL9ZIVR3H+xwk8qp4HMLVC/nL5k
	 hVcYFEhaGg+HT9yxvMXV6C+GNHnEBFxVxrifZy/13TJG4rt2/IwGDNymICEEsYcjH0//H
	 jgh0pu55IpnR8aAH6c00U8fZuHiIP3BX6PsNNwrqEVGmF6u5QDrTBqFO7xQoBAI9oudVg
	 NiCzq0zS4R9VxPZtDGDiP5yw49vGr4U9kMM1+K59Y3tcJLiA95A8uvvDE56Qe+ycyRQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=altera.com;
	spf=pass smtp.mailfrom=altera.com;
	dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=ieCCxrZB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.49
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010049.outbound.protection.outlook.com [52.101.201.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B204D60A260A;
	Thu, 19 Nov 2026 09:45:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B204D60A260A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=ieCCxrZB
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EtUQYKlL2XG8AhjXHzJCCneznib8ydiVKsOb9aY68jj89O+gF12g/fc0xfj47mFoO1Y7FKnBBf3/vk0Yl3dXcpXqKPMviDACrxrFX2eiFMMzzteBHJQt92u7g/j56aHMPh6XQQc/6wlNsF8++51lJCkIbCUwXMjreCdlHc6MK02dEEz8s/9Jp0VvVCV4BeJfKb8ljIXKnOWZPH7GvRusWYY83CmgC6kUlkBCF6YPH0lpnf6L3RLFQVeR9W7fSoII4hFkcMujDq2oqRJTUpkebS4E5+Lammd9KdhlIwcIhmmP8Yu8LfIW3XxDLGmvGNnC6+omyLBwu26vm4v1fPnVQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P7Q5GjQN2NZeg26BaGpYbQqwviCXw6TNnmsVB3gqqsw=;
 b=Lx1CCYWnEhX9TA3YQD0RL22GoStK4wfczHGpVqVGTXQIGFT2XXVRnX1VyiTl29amDTxPbLHYr4mG4dxZAYBZ7TrLyp9tXmR54QjTvp9KEDulHlnWgHc/wMQGynD63DaCYbPxIMkYEUNYSsK1wn8Hp5JIoLalMAFd7W459Dobe39Lu0egW/UkzdwVFkiIn45CSgNA9gL2WVSbRbgBDcbyeEkLcJNZ41D6D8G7fIQL5CIkc2kjtUcO5dH7lHjC+CERc/7wipaI7yax7qFPWsPLDmeIIgvVh2NrtuLcyMKtEqC9uIS7oTdf+pQD2JGkaci7XAkkU8BYvOnanWY1JgepbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P7Q5GjQN2NZeg26BaGpYbQqwviCXw6TNnmsVB3gqqsw=;
 b=ieCCxrZBgZp+g7XO4HRetS8g+OVpUujEwTA4yfLv3hYcBASqwLlxAlRhx9A12gJ03G//G1FGVT1P6JdrkG1qahRKr2W5TkA5VbtLu3mzQZifj146Wb83GjBP8F/TQJqbor10mNke6p+WvaOTA2S2RK5VhQtGFKfZF00h/Aww5shUuob7peFFqxcucnobWaLyP3G2st2vSMvDEa6BIJnmhCVp+0JR3EX5+mVNRBLdaTP0UuvN++lQJV6fKYTdHodJU6xfyBRCiRcZvgvuGTgnN/WjJfNZ2iaSkIwpbNsIRvhEWsFTcijNFONXB1D8Vh9EDx2GGnRLmcm30uAXpxzdBA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by SJ0PR03MB6987.namprd03.prod.outlook.com (2603:10b6:a03:43b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 19 Nov
 2026 09:45:49 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%3]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 09:45:49 +0000
From: tze.yee.ng@altera.com
To: Adrian Hunter <adrian.hunter@intel.com>,
	Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Ulf Hansson <ulfh@kernel.org>
Subject: [PATCH v4 3/3] mmc: sdhci-cadence6: tune SD6HC DDR50/DDR52 read path
Date: Thu, 19 Nov 2026 17:45:35 +0800
Message-ID: <20261119-sd_cadence_ddr50_v3-v4-3-95a94a0aaaf3@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261119-sd_cadence_ddr50_v3-v4-0-95a94a0aaaf3@altera.com>
References: <20261119-sd_cadence_ddr50_v3-v4-0-95a94a0aaaf3@altera.com>
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.16.0
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR02CA0015.namprd02.prod.outlook.com
 (2603:10b6:a03:54::17) To SJ0PR03MB5950.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|SJ0PR03MB6987:EE_
X-MS-Office365-Filtering-Correlation-Id: 4aae887a-aaed-4594-6ae0-08df4621e483
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|261102123227099003|261026121527099003|56012099006|11063799006|10067099003|261022105027099003|261022075727099003|261021123027099003|261026140227099003|261028144727099003|261021121427099003|261009223027099003|55112099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	58Z4eIVjqqNgeCZ2fIdnrzlkemVLdStGWKa2fOZH1ocSQGFPAMkCIrFyiLggt10R47WwfOiuyV9nxSe+qRjjbrAcAO8RVZtR0VeOkYn6PZEjyV4eSm3eWr91V1Y+NR3FdATtJc81U3E56I5oI68mwdWzVMNHs6uNdt/cZdBQqEZ/4d6EujeFwuIOY1QziD+A+SxSv3gvx9XWI9rnh+frdIY4GejIXJmjCk2LQM87dBUdEPuYMtdN6sdDKB7CV6CUetWXT6Y/B3T2u2Mq9KQUJAgzuZgVf9vB7yuG+m71emG4/vOm1NcYzKnELvEwY+lASQc8H2hjPWzdiL21zzbn63Z+Lpg1evpTDHYgJmz57HdVGAxuH+aJ5ht77jEhxQCjtrjysymlAX8jRnEWsXosCEDeKpTVG6zhptUFwCHnCMwdyX3HFxdtIo61q6gXVNW7TqgwTWDlSpvKfQbeOuG1TTNM1cWfxK7A34/5oiv0gqxuWzozaOOnH7zU3FnMzLE2j/ddFnXsM37Si6xdS88zQnOLkByyZhoX5OK60kmWehDjpECUwqSJypl/XJRgcYGqjH9mIxwBvUtTKREesqjQ6vcr/h9LYvVegy5I/eizXRCErXHJWQH2Jf+qeCVHPiM3IZ/dnNRfz1sFNPvalEGR7sUGp1QtbMCudV38i/KJwyw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5950.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(261102123227099003)(261026121527099003)(56012099006)(11063799006)(10067099003)(261022105027099003)(261022075727099003)(261021123027099003)(261026140227099003)(261028144727099003)(261021121427099003)(261009223027099003)(55112099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a1NoanZWNVNBMEd2UEdPb09jaHQwNlUxbFBUVDNKUGhIVk5qWTN3dEorSGtS?=
 =?utf-8?B?VUNIKzF4Q3d5TGhFS2JHbXJKQnJNUGF3YlpOaXVkTmFtUGx0ako4dk1ZMThC?=
 =?utf-8?B?QmQyYUtScFl6c1Z6THJhZXhRU296TE9pbkxpbFg2OXBZdm5IQTBVbkR5dVY5?=
 =?utf-8?B?WHc4R3NOVHZDbU5aZjFnU2FoSkc2d0dPMjVMUkcrdjVWTVlYOHFEZDFWR1FR?=
 =?utf-8?B?SkFkMGkrUGRWN09mcFNOVStYdzkyb0hHNG9GS1BsZmlVSzZad2R1UUQwelRh?=
 =?utf-8?B?Snk3M3FIbCtSVkRIaFMyOGJxNUxsZGMvVEw1WlRZOWtHcjlvYzcxeUlCNDdI?=
 =?utf-8?B?M3lINHVBeldHbnJVM3BDdGlZS1dQMlp2OW1TQWk1cGV2bVBaT3ZORjE5dFdW?=
 =?utf-8?B?b05Xekd4Qkt3cVNEeXlCbEFUNG5jNXMyOHZPYVdvU0VibFkrSm4wWm9DZGtE?=
 =?utf-8?B?Y2pmRm0zU3VFSmVvK3AzSDQ4dGlMYXJ0bGowcGYwVm92dFk2Z1NFUnp4eE5C?=
 =?utf-8?B?SVFtcnRWczh6c3QxYTJycHY0K2hJcE5paTN5TEt5cDlMTEVkZjNPTGQrempX?=
 =?utf-8?B?TU9vNU1nMlcrZUFrNlFwbDV2MEltZm9sLzBPaXliYVNHVFFCWFkrYUNnTG51?=
 =?utf-8?B?OHNJQVAySnFRM3o3TC9MSVVFazMxWkMzcE1iMXVzSjVvRnczYnB2cy8wOHZn?=
 =?utf-8?B?MjdBTkFvbFljOVczcHcvdnB1TFVsT1FRdmJ1V3pZY0JHVFgwVnRoaVpxZXNG?=
 =?utf-8?B?cnFsSGZrNkxOVjBJckxBOW5XR2pnK1QvU2VlZlNYalM2VVZjMElPanMwMzlK?=
 =?utf-8?B?SlBCUTAydEY0ZUV3VHFHeVdCL2hOck42bCtrR2NtL3llOUljdFhXTmQwWHlp?=
 =?utf-8?B?UXJrUGZjTTB2UnR4cnU0UXE1TFlsbHkvUks2MnNIS3JnOHlIM2JjY2ZkNmxy?=
 =?utf-8?B?ajZmeGROb0tQYWhleExZSWVmUU5aZDBSK1o3QXg2VDRWNTVIQVVQanh0clEy?=
 =?utf-8?B?bUhia3RTS1k5aHZNbkVseTh3cEh2dFBUS1hpanlyL2dLSHU0dTV4OGpVOEsz?=
 =?utf-8?B?elJET29saTFFTHhISkxKY2txckNTN2xYc0xnaXZJTVc3eDlLNEdKZmlhdkRi?=
 =?utf-8?B?U1YxNzlCVUQwY3JQZG55cDk4MUxWRnRPMUQyUEU5bXFydHRNT3pXSDFUWjZ4?=
 =?utf-8?B?by8xUXJ2S0gyY1lwS1gxcFM0RWhwN3YvWVFkQitocG5rZ0dUWTRPeExXKzFx?=
 =?utf-8?B?cmxzblFuL0J4MWlhYW9ZTUQ0emdyck9TREY4ZkRORTQwamppRnMvTHdFcmxM?=
 =?utf-8?B?bFVlaVUyTFZUdFRGeWtVTXFCT0JXMGE2M29Bb0FyYU1Td0ttZlBFdVJuRlVu?=
 =?utf-8?B?dVZaNDk2VFFEOHNDN29uSEJFbEpjdTA3RG1oM3p1ajNPTzVNNHBPcDNDTC8r?=
 =?utf-8?B?Um9CekEzUDI5YmRLT2J5VTdTcWRaRzdzWG9QS1BPVXAvN0E4bFVZdFRRa3Bx?=
 =?utf-8?B?aXFES05HajZyK1dEdWFYSEtKdUQ0YVJucDVTVXU0akdRZWViM1NZV0doTmp4?=
 =?utf-8?B?dklXZFN2Z1VwZjlkQmdWZ0JxYm1IbGtCZHJxaTBjWGtycm04MXhuU1d5YXpD?=
 =?utf-8?B?Ui9pSzc1dTJWRlRrR0J2d0FPM2FQMFRMbUpoL0RTTUptelhoQUlkZjdaRUFh?=
 =?utf-8?B?NGRuY3ljL3JoTlppVWhaWjFLdUdlck1pNG9OOUk2TmpFZlduYWRsWnF4ZGM0?=
 =?utf-8?B?NkpOMGNCendIUE51b2JkZStoL2hIVzlFZXhDK0JoVmxZMzM1TkJDTkZ1U2FU?=
 =?utf-8?B?anJzczBLaE0wU0VUZURMYUxEcVk3RWVMV2taKzhFS1cwV0YrSUJnUlAxbHU0?=
 =?utf-8?B?Unh1SU0rVkVoN2dtK1FmSGs0Nmd6NXBuS1Byd01IMTBLeXdLc1dqNWVuR3Z1?=
 =?utf-8?B?QlhxK2JoSXhPU3p0YkJ5OHRXdGdZbXdaVXhGZmhVaFo5NHBVTmpoSTN2K1Ft?=
 =?utf-8?B?WHVGdmNTSE8xTGJROEFzb0EvN0l4eXpMVkZSUFd0eUdKK1RrN3R4Nll6aXBl?=
 =?utf-8?B?T2pTV0kyZXZXYW1RMklQaGlpZjBJaXpONTladlYxcUxtRG1WbmM1dFU4Mlpo?=
 =?utf-8?B?aTdTZVVKT1hkdmd2RjhVVFJ5dTgzUnJHNElqTEFIdmZIQktTUGZPampwYkJn?=
 =?utf-8?B?eVBHb1p5MDFlNnFUQ1J0ZWVMdVB5cUNqbjV5T05aZ2tQZ3Jhc1A2WmlLeE5q?=
 =?utf-8?B?aTNEdzk3Z1poTXlQSk1yRzVncmdCOGlsQWMwaTE0R0VHT1prOVBNdlZEeEY5?=
 =?utf-8?B?YytXTUZISUpHMk8zTFYwZkFjSWpnYXRpQnNmTDI1RG5DaWdvM20xQT09?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aae887a-aaed-4594-6ae0-08df4621e483
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 09:45:49.4076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4NK3cfC6lE2te1uhhsAyt0evIkF4PJez/pJkDLSOF5CMDmW2IR1z3ayCD5HWeLzVZf+5UiKV8hFSWdoEMEAojg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6987

From: Tze Yee Ng <tze.yee.ng@altera.com>

DDR50 and DDR52 have no CMD19 tuning, so the SD6HC extended-read path
relies on static PHY settings. Two things are needed to make it work.

First, PHONY_DQS_TIMING (phy_ctrl_reg[9:4]) was left at 0 in every mode.
In extended-read mode the RE# (rebar) pulse is held high for half an
SDCLK period, so its width in clk_phy (sdmclk) cycles is the SDCLK/sdmclk
divider / 2, and the field must hold that width minus 1 (0 otherwise).
Leaving it at 0 in extended-read DDR duplicates one DDR edge and corrupts
reads. Derive the width from the clock divider so it tracks the
integration rather than a hard-coded value: e.g. 1 at divide-by-4,
confirmed on DDR50 hardware where 1 captures both beats and 0 corrupts
reads. The field only takes effect when the fabricated phony DQS is
selected, so the computed value is written in every extended-read mode
and clamped to the 6-bit field. This timing model follows the Cadence
SD6HC PHY documentation.

Second, the remaining read-path knobs need board/SoC characterisation, so
read them from device tree at PHY probe and apply them in the
extended-read DDR modes (DDR50 and DDR52):

  - cdns,ddr-read-dqs-delay: read-DQS delay as a count of DLL delay
    elements (each cdns,delay-element-ps wide), written to the 8-bit PHY
    field (0-255);
  - cdns,ddr-no-lpbk-dqs: fall back from the recommended loopback DQS to
    the fabricated phony DQS.

Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
---
Changes in v4:
- Merged v3 2/4 (PHONY_DQS_TIMING) and v3 4/4 (read DDR tuning from
  device tree)
- Derive the PHONY_DQS_TIMING rebar pulse width from the
  SDCLK/sdmclk divider (t_sdclk / (2 * t_sdmclk) - 1, clamped to the 6-bit
  field) instead of the hard-coded 2 clk_phy cycles, and apply it in every
  extended-read mode instead of only DDR50/DDR52. 
- Dropped the cdns,ddr-phony-dqs-timing override. 
- Stored ddr_read_dqs_delay as u8.
- Dropped Adrian's Acked-by from v3 2/4 since the patch was merged and
  substantially reworked

Changes in v3:
- Read cdns,ddr-read-dqs-delay directly as the delay-element count and
  write it to the 8-bit PHY field; dropped the ps->element conversion
  (divide by cdns,delay-element-ps) and the FIELD_MAX() clamp.
  (Krzysztof Kozlowski)
- Hoisted the repeated DDR-mode test to a local bool. (Adrian Hunter)
- Removed the probe-time dev_warn() that validated the firmware value.
  (Adrian Hunter)
- Unwrapped the of_property_read_u32() call to 100 columns.
  (Adrian Hunter)

Changes in v2:
- Updated patch title to "mmc: sdhci-cadence6:" since it touches only the
  v6 PHY.
- Renamed the properties to cdns,ddr-*.
- Read cdns,ddr-read-dqs-delay-ps in ps and convert it to delay elements
  (dividing by cdns,delay-element-ps), clamping that quotient to the 8-bit
  PHY field. (Krzysztof Kozlowski)
- Read cdns,ddr-no-lpbk-dqs via of_property_read_bool().
  (Krzysztof Kozlowski)
- Dropped the v1 per-property range checks and redundant FIELD_MAX() write
  masks. (Adrian Hunter)
- Apply the overrides in both DDR50 and DDR52.
---
 drivers/mmc/host/sdhci-cadence-phy-v6.c | 52 ++++++++++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-cadence-phy-v6.c b/drivers/mmc/host/sdhci-cadence-phy-v6.c
index 22d56bb46d75..f3a878e86f9b 100644
--- a/drivers/mmc/host/sdhci-cadence-phy-v6.c
+++ b/drivers/mmc/host/sdhci-cadence-phy-v6.c
@@ -126,6 +126,10 @@ struct sdhci_cdns6_phy {
 	/* Active delay element (ps); doubled when one SDMCLK requires > 256 steps */
 	u32 delay_element;
 
+	/* DDR read-path overrides (SoC-specific) */
+	u8 ddr_read_dqs_delay;
+	bool ddr_no_lpbk_dqs;
+
 	/* PHY_DLL_SLAVE_CTRL register fields */
 	u8 cp_read_dqs_cmd_delay;	/* bits [31:24] */
 	u8 cp_clk_wrdqs_delay;		/* bits [23:16] */
@@ -142,6 +146,10 @@ struct sdhci_cdns6_phy {
 	/* PHY_DQS_TIMING register fields */
 	bool cp_use_phony_dqs;		/* bit [20] */
 	bool cp_use_phony_dqs_cmd;	/* bit [19] */
+	bool cp_use_lpbk_dqs;		/* bit [21] */
+
+	/* PHY_CTRL register fields */
+	u8 cp_phony_dqs_timing;		/* bits [9:4] */
 
 	/* HRS07 register - IO delay Information */
 	u8 sdhc_rw_compensate;		/* bits [20:16] */
@@ -505,6 +513,7 @@ static void sdhci_cdns6_phy_calc_dat_in(struct sdhci_cdns6_phy *phy)
 {
 	u32 hcsdclkadj = 0;
 	bool strobe_dat = (phy->mode == MMC_TIMING_MMC_HS400);
+	bool ddr = (phy->mode == MMC_TIMING_UHS_DDR50 || phy->mode == MMC_TIMING_MMC_DDR52);
 
 	if (strobe_dat) {
 		phy->cp_use_phony_dqs = false;
@@ -517,6 +526,33 @@ static void sdhci_cdns6_phy_calc_dat_in(struct sdhci_cdns6_phy *phy)
 	if (phy->mode == MMC_TIMING_MMC_HS200)
 		phy->cp_read_dqs_delay = phy->hs200_tune_val;
 
+	if (ddr && phy->ddr_read_dqs_delay)
+		phy->cp_read_dqs_delay = phy->ddr_read_dqs_delay;
+
+	phy->cp_use_lpbk_dqs = true;
+
+	/*
+	 * In extended-read mode the RE# (rebar) pulse is held high for half an
+	 * SDCLK period, so its width in clk_phy (sdmclk) cycles equals half the
+	 * SDCLK/sdmclk divider. PHONY_DQS_TIMING holds that width minus one.
+	 */
+	if (phy->sdhc_extended_rd_mode) {
+		u32 rebar_cycles = phy->t_sdclk / (2 * phy->t_sdmclk);
+
+		phy->cp_phony_dqs_timing = rebar_cycles ?
+			min_t(u32, rebar_cycles - 1,
+			      FIELD_MAX(SDHCI_CDNS6_PHY_CTRL_PHONY_DQS_TIMING)) : 0;
+	} else {
+		phy->cp_phony_dqs_timing = 0;
+	}
+
+	/*
+	 * Loopback DQS is the recommended read-capture path; allow boards that
+	 * need the fabricated phony DQS instead to opt out in the DDR modes.
+	 */
+	if (ddr && phy->ddr_no_lpbk_dqs)
+		phy->cp_use_lpbk_dqs = false;
+
 	if (strobe_dat) {
 		/* dqs loopback input via IO cell */
 		hcsdclkadj += phy->iocell_input_delay;
@@ -680,10 +716,11 @@ int sdhci_cdns6_phy_init(struct sdhci_cdns_priv *priv)
 	sdhci_cdns6_dll_reset(priv, true);
 
 	reg = sdhci_cdns6_read_phy_reg(priv, SDHCI_CDNS6_PHY_DQS_TIMING_REG);
+	reg &= ~SDHCI_CDNS6_PHY_DQS_TIMING_USE_LPBK_DQS;
 	reg &= ~SDHCI_CDNS6_PHY_DQS_TIMING_USE_PHONY_DQS;
 	reg &= ~SDHCI_CDNS6_PHY_DQS_TIMING_USE_PHONY_DQS_CMD;
 	reg |= SDHCI_CDNS6_PHY_DQS_TIMING_USE_EXT_LPBK_DQS;
-	reg |= SDHCI_CDNS6_PHY_DQS_TIMING_USE_LPBK_DQS;
+	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_DQS_TIMING_USE_LPBK_DQS, phy->cp_use_lpbk_dqs);
 	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_DQS_TIMING_USE_PHONY_DQS, phy->cp_use_phony_dqs);
 	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_DQS_TIMING_USE_PHONY_DQS_CMD, phy->cp_use_phony_dqs_cmd);
 	sdhci_cdns6_write_phy_reg(priv, SDHCI_CDNS6_PHY_DQS_TIMING_REG, reg);
@@ -715,6 +752,8 @@ int sdhci_cdns6_phy_init(struct sdhci_cdns_priv *priv)
 
 	reg = sdhci_cdns6_read_phy_reg(priv, SDHCI_CDNS6_PHY_CTRL_REG);
 	reg &= ~SDHCI_CDNS6_PHY_CTRL_PHONY_DQS_TIMING;
+	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_CTRL_PHONY_DQS_TIMING,
+			  phy->cp_phony_dqs_timing);
 	sdhci_cdns6_write_phy_reg(priv, SDHCI_CDNS6_PHY_CTRL_REG, reg);
 
 	/*
@@ -863,6 +902,7 @@ int sdhci_cdns6_phy_probe(struct platform_device *pdev, struct sdhci_cdns_priv *
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_cdns6_phy *phy;
 	unsigned long val;
+	u32 read_dqs_delay;
 	int ret;
 
 	phy = devm_kzalloc(dev, sizeof(*phy), GFP_KERNEL);
@@ -901,6 +941,16 @@ int sdhci_cdns6_phy_probe(struct platform_device *pdev, struct sdhci_cdns_priv *
 
 	phy->delay_element_org = phy->delay_element;
 
+	/*
+	 * Optional read-path tuning for the extended-read DDR modes (SD DDR50,
+	 * eMMC DDR52).
+	 */
+	phy->ddr_read_dqs_delay = 0;
+	if (!of_property_read_u32(dev->of_node, "cdns,ddr-read-dqs-delay", &read_dqs_delay))
+		phy->ddr_read_dqs_delay = read_dqs_delay;
+
+	phy->ddr_no_lpbk_dqs = of_property_read_bool(dev->of_node, "cdns,ddr-no-lpbk-dqs");
+
 	priv->phy = phy;
 
 	return 0;

-- 
2.43.7

