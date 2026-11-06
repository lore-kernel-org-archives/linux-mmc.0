Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.61
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793945832;
	b=sFAmMZM2GG3J+6g0atfq+xnT58VWdoRwQ7BNlKrgZAss/5jozNU0gyRzCEgsE98JvkMV
	 pT30SUdfF8ltVhWFSLhopotx4UnC0uO64yPIY8foA4FCWV5pFKEE7PzIMubI88dGLO4cA
	 5dBwTTJ34THV/XmyFQ++O9KQGn/5pLiLa6BTERI0g4MFEaeWf0kWg4N8TpZcqma4ix1yb
	 juwe+pO0tZZn7SBiuDTHPHhZEbwyB0zkBb3E8EuBOOV19LV0AikB3CkTDGXued3uxJiH4
	 v3tkg+hQby/2Sp5rmQ8mGsggQroRpfODjB3gs4TXWdptA1vAPESF2VVBVZaq1qMtjkg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793945832;
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
	bh=LqTKVy8plPhqOUXuSBvixfNBbEFBB0vJEmfNdQNi4LE=;
	b=qvjn2UbqfYOjF4B+2mh48EEaWy99N/T//smwVQTs6UkZbMFYdTM7JqnSlTV8yGEIwy1p
	 wOSTqgWR8Hjt1/5x4Jf4F6oT6djaLUqfs9pGu+TnOX7F3JH56z3GVnib3SfsDHp1A83vF
	 zH0o5lhyZeJDk3e0Dt46hpahQj8qPpYg9PgJCaJlLF/I1VbKbLlYIwyers6C1+iSLtnk3
	 FE2OP3vkoMfyzIUYJXQxmd1sdOCiwHcWU1/WT4Je/KvE29fTRx8lpc54vWcCrwePxWrTp
	 03ZcuRctkncgs8s0sVMkP2gdNJCfZ+kUDkLi1cmU/QL/Ctr0ACl3AKzlbCFdFBWfH4g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=altera.com;
	spf=pass smtp.mailfrom=altera.com;
	dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=hkbrUasH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.61
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011061.outbound.protection.outlook.com [52.101.62.61])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49C9606A337;
	Fri,  6 Nov 2026 06:17:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E49C9606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=hkbrUasH
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cwX2vMUcJUp0KQYPMP0ZUp+pnxzozD2zcpmEou9/d30yl7lI5ev/2RqW5awomIVgI78tyJfl/xuczr2wPS98hmCebKtZY4hP8jCCJZHqf3HLyPrf2Ydjy7IpR6gWTpzE4DKauX5RaCJ5dSvy5G8PEz8SI4niBcbCqpuY8ZENfvB+GKKpeVUQZrBM78U5sEHGFvndkBH6q7w4unHcFOAlQf8XCx/BNuHM8tkzv75YYDT7jUSgvquPIXrCsY8SPfO7CB2pTdre9I5uUmkRiN9o4aIHMx4MmDTeS0Jw/JRhtYQp9lQeizSv4A9EG4lgXOSavL6sLEdxGjsKceQeVdDDOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LqTKVy8plPhqOUXuSBvixfNBbEFBB0vJEmfNdQNi4LE=;
 b=xRblbHn6dWPAP3ZFyBW07LGhXYjZ7iPq1ZPpuNGRZ+jdAX3yr26AH7/InkkDzyJyezOmTQHc0gb3QKz0sEYyP1gNHofg7uyHTjJerI2DQG8A1tdd+3PxB1RaqflN5vw4l6iW9tSDYB6grTsnH1ymviOcJFNr41chcO7pEvATQKhYUiBXXKFJH5d5l/WbY6otK3sAXikwEqmqEHcosUPJYxb2L97RxuQS7Mc1KygZdsDfQrz+QZEQWm1/HxFotKy+ygrxcMb/lyweKbGo1e8TgjkSfZ+K4NNwu1TrtZuY6lJvMYbREEIHAhlrVvfjgs8XUkNs6lKcHx4PoFD2ea2jlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LqTKVy8plPhqOUXuSBvixfNBbEFBB0vJEmfNdQNi4LE=;
 b=hkbrUasHv38dbV1U1Rdy60kOQFExHCQrnaIHFyA80Og1D+T6w4AHUTvf7uZ9tP7Vlqa4keY+WE4qzrxpqXQ3HAw6SjCYbd/NOUBtY1SvnwfWa4IZhbfwCangthROXJaExzhFlUMJbB+NOTsp81vfe1jheuFoK5WzEWvwt/CKhhGewLxA6KbDxoIrkjVxoK9l3O9WYZu9gRKM62S+eZDtP1wjyRx7He8mp6ylYh++T0aQV3eJ/t2fBl1RQIzMWJJU2Yws+cOHtdyWeuBl2WCjb9nodroy7cH5wNSXlZgqGRTSdx6hsS1ERMszF62NC5Of37+1DGbeAPeBHIRlR92p2Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by EA8PPF1471CA897.namprd03.prod.outlook.com (2603:10b6:30f:fff5::845) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Fri, 6 Nov
 2026 06:17:06 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%3]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 06:17:06 +0000
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
Subject: [PATCH v3 2/4] mmc: sdhci-cadence6: program PHONY_DQS_TIMING for extended-read DDR
Date: Fri,  6 Nov 2026 14:16:53 +0800
Message-ID: <20261106-sd_cadence_ddr50_v3-v3-2-cb50afece614@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261106-sd_cadence_ddr50_v3-v3-0-cb50afece614@altera.com>
References: <20261106-sd_cadence_ddr50_v3-v3-0-cb50afece614@altera.com>
Content-Type: text/plain; charset="utf-8"
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
X-MS-Office365-Filtering-Correlation-Id: 3cebb1b0-b3ad-4194-27dd-08df3bcd9492
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|261028144727099003|261022075727099003|261022105027099003|261021123027099003|261021121427099003|261009223027099003|261026121527099003|261026140227099003|11063799006|10067099003|261102123227099003|55112099003|22082099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	yNLwQF+pUBQewX5yHmJ2YlWmbwLm8AQeIoaE4RiViZeUPg/GmxekpF9ZTTMjHIoxVugJx9q5ADzshWgmgWwRFGjbfFVPqwtZBEKTG9ErCkEjfYGaEOjfcYtMSrhwf9OT3tGv2J/o452PFpSgDwba2KEeIDa/a17p7e/waWFKgKh1cv6lo3gGGvHViBvI7IVuaTHnQ9xg6bHCgma/3NBQwyyc+SmOHo3ikZhKPkcbifpV7OQJAz4dU2/4wqva7MQQ6t5tDhGVGtvYR8xcCBrjSt+R6nYuGG8OCxIjmFvvKICRA1EI1oObFfZ9e+LFhankZIOuYh4qA55FioMTYajWST5AK671BdpLtt3qX8AV+7BlY/fnqVWzTo/ssI6LgaOyvqh5wh4F9BviBV7RdK/y/EuKFG1Y/P827fCJA7uEYctFgj8X4AK7ykq4duchRnm4CK7IjUXAxzLr5mylvc5zPa8rLXad5EdGOkT7jLuNccHOtZeukWU0LZ3NRBDUIUXy8OnovfbHFnJVtIf9rmO1FQR3EZmrHr0NY02tekcGdVv8GABDHLsH/9k8KsjrCwC9xXCEdjfj/ML6y44EoGSga15KUt9BVfqb4ILrLNkzgRmkHZ6nEx26iThk3DgmFYVJY0d8iwAY/SCyGqHRMnJEuXhX//cklIQScsVHRUoav8Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5950.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(261028144727099003)(261022075727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261009223027099003)(261026121527099003)(261026140227099003)(11063799006)(10067099003)(261102123227099003)(55112099003)(22082099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?clRUOHdkbkFOQVFYbG91dDFSQm1WS05jV0l4WEhHVmRubTVZTWtuMk9aZXd5?=
 =?utf-8?B?aFNvT3QyNGx5N2g1S3FmdUVEWTR3cFVWL1MwMmNpRy9nRmFXa2g5ZVVoc0kx?=
 =?utf-8?B?anpvejBQWVZ2V3JpcDVRKzh6VE1MQUkzUzdya0RxYThpUVhjUzZ4ODJra09s?=
 =?utf-8?B?OWJUUDE2T2IzMjZuaWlrc3B4b3k5SUxkMjBkbUNoaHpobUdKMHRhRnJZY1I4?=
 =?utf-8?B?NWNPWkQ2ajlNaTFKN1d4UkhTSTFLMFJFaFZJcDNobnRCOXBsY1hRTTRNUzB4?=
 =?utf-8?B?dnJIRGZDS1BwaUhUcDl2ay9aUkhiVXdJaDBhamRlbURBSFpkQjBwSUtZUU45?=
 =?utf-8?B?ZzNzYVNyVEpNT2IwQ1lrOTZMejEzSXdibUdZVUlpR1VoWDdZNkVmbGREOUJL?=
 =?utf-8?B?RHhyRDVvb3hCK2tYTjZtczk0OHloUlRhV2tUYitqK0NzeVVySE5zaXJPTFJy?=
 =?utf-8?B?RnlkNnJNSksxLytKZzNMRFNxWHBrem5BQWd5WW9TeWREbDJwWXJqTXF3ZHZ6?=
 =?utf-8?B?eUhWQnRzaDR1b1RIVVRvcFFMSUpjY3FNeUtjMWFCNCtzem5uMWpNbUF1cjV0?=
 =?utf-8?B?eURpcDM1ZlB5aTROckd5aU4zUmQzNU96aUc3djRyNi9xaWM3K0s4M0JjNlN3?=
 =?utf-8?B?SVNyd1BMNFRvYS9KbVVxOFhSMzhRSW9JZzNzcm9iNnhWMGlTQjNVNlZjZW4x?=
 =?utf-8?B?NldiQjN3bEpRVWdSd3RMQlk2QldZbWlCbjl5bExMT2UycDJvMWpxZkNKNzZ2?=
 =?utf-8?B?Nm9LMVBMWlhZK1JZQjhuaXZNSUlCM2Y4dnZqTXRteDZnai9Mano5ODdaNExx?=
 =?utf-8?B?cGxPQnREeFVRRm5saVY4UDVpSkRHRklGcEJWWlRmZmVwb1M4bUJTUzVBTk5u?=
 =?utf-8?B?dnJQRE5sNW1DanBPL1VZWXdYMG42V2FqN2t1dXdsNWMrMWNEYm5LaGxLckRm?=
 =?utf-8?B?c29BcTRaL2ZvOGM4YldVdUREcGdmaGpMT0g1L2xCdHVtcGVEbk9oWUNaOWZC?=
 =?utf-8?B?K2JQSkxwZUNlL0dWQjN1cmpVVHpINkNZOHlQczBpMGVrbnNMSkRKOTZ5eC9F?=
 =?utf-8?B?dGcrSEFqV0xsUU44MTVxV2JnR2MwNlhlVVZsQnRxQzVWbkZZaEFheGE0Qjlz?=
 =?utf-8?B?SExkaXRCTlpsV0s2MWkxSWhuN2M2TzZtTXlES3gvbHBlNVdkenk4Uk1NcWk4?=
 =?utf-8?B?VW92bUo2VW04c2VFZWR6RnZCNm5JQ2pDb1VYc2FBamFrQ1ZTbEYxK2xadndp?=
 =?utf-8?B?L2VaK2w4VE1MM3kySEJmRHRkYzUxQ0wxbWo5WHh0bnAvNmUrQjJUUlFRMGtB?=
 =?utf-8?B?YklwbXpnZVI5WTcwUjFTU1NUM1dMV05ETzByb3FpM1ZyRUFoWUVNMkRTemNZ?=
 =?utf-8?B?c0w5VHo3WWVIa3BBaEJpRVdhcjJXRVRwT3VMWndjbHl2TzcrOHlMTWNlekpY?=
 =?utf-8?B?QUo1MXVsS2MwMXQybThuSXpjTmRRQVhPc1JVbkZWQVNOcW5leU5iK3B5Tm1l?=
 =?utf-8?B?NkNmQmovclJXUmZGVWI2MXhOdTQ0b0JkUmk5WlJTNzN4S0Fzc3p6R0twWmoz?=
 =?utf-8?B?anBtcU1WKy9JeVdNY0xyTFlnc0M4VUtkNDkrck5wcTlmdXRpYzV0djdhaFRz?=
 =?utf-8?B?aitDcVRQOTBzeVFYQmVadGdCMCtGOWN0K0VFZkE1R1hCSUxLVmhTemlXRzgr?=
 =?utf-8?B?UlpJUUxCd1dheWVVUWlhMzgzUVBWNjJxTmR2alRVaU14VC9kcS8wZUJPekhX?=
 =?utf-8?B?RmZzMk9nc2w5TVNoTi85dWtiT0RjelZtZlhXYmpyT2JIWmJVdnAvaXFmcm9p?=
 =?utf-8?B?Q2htMXBjQ1FMZnAyWnhFZHJOZmJ5dGJLdFc2Sno0azVMVlFhNFJFMkFkT0tL?=
 =?utf-8?B?bUNWZUVadmtXZkNVTE5SUmlhSVpFTmoxMEk4L1FiY1lRK25tSzBwMVJhR0FO?=
 =?utf-8?B?U3c0RGtTSWZlRWhpOEVGRlJ5c3VqZHlHV01OVm1mZUt5UlZQci84OC9KRjBx?=
 =?utf-8?B?TDhKbFRBMDF5U1g3eXdQdUJ5ZEQySWxxTGVqbjhxQ1d5QVlUR3IxMGhkQnp3?=
 =?utf-8?B?QW9qRm15aDNTbnZGRkpxK055UTV1Sm1lWW1OUmg1RU44VmtDdGhKcU5UNjhF?=
 =?utf-8?B?cDN2OTlpZ1BuOWZTNUk1NU1EckkzV3dpSmUyK3J5NFQrMTFGTllyWWxJc3RQ?=
 =?utf-8?B?Q0ljUXN0SUpmZnBQRUdpL3NVeWo0SzZlNGREVHBCTG1CaHVqamF0b1c4eUxk?=
 =?utf-8?B?em00d3JrT2dXeVB1M1dhTHU5T3FqeHdkbVJEelhWZmgvUm9XdGpUZ0Fqb1Er?=
 =?utf-8?B?dUFtWUVqSlMzcktLTWpXNVExUDU3K01kUFhrQ0ttQjZxT0MzazA3dz09?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cebb1b0-b3ad-4194-27dd-08df3bcd9492
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 06:17:05.9355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1OewFUmEqUputINqj6xlAZX0zPtsA3L53MPuKgy/t4iiUF1lHJztHK4jcFNnhhed+ZUR+COtWZNegl9K2crCXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA8PPF1471CA897

From: Tze Yee Ng <tze.yee.ng@altera.com>

The SD6HC PHY left PHONY_DQS_TIMING (phy_ctrl_reg[9:4]) at 0 in all
modes. Per the Cadence DLL PHY documentation it must be the rebar (RE#)
pulse width in clk_phy cycles minus 1 in extended read mode, and 0
otherwise. Leaving it 0 in extended-read DDR duplicates one DDR edge
(the silent odd/even edge-capture defect).

On this integration the rebar pulse is 2 clk_phy cycles, so extended-
read DDR needs 1; confirmed on DDR50 hardware (1 captures both beats, 2
corrupts reads). Derive it from the extended-read-mode state and apply
it only in DDR modes, since SDR extended-read samples a single edge and
is unaffected.

Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
---
Changes in v3:
- No change; retains Adrian's Acked-by.

Changes in v2:
- Added Adrian's Acked-by.
- Reworded the commit message to drop the "generic to any SD6HC-PHY SoC"
  framing. (Adrian Hunter)
---
 drivers/mmc/host/sdhci-cadence-phy-v6.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/mmc/host/sdhci-cadence-phy-v6.c b/drivers/mmc/host/sdhci-cadence-phy-v6.c
index 22d56bb46d75..8d6a9c26c139 100644
--- a/drivers/mmc/host/sdhci-cadence-phy-v6.c
+++ b/drivers/mmc/host/sdhci-cadence-phy-v6.c
@@ -90,6 +90,9 @@
 #define SDHCI_CDNS6_PHY_CTRL_REG			0x2080
 #define   SDHCI_CDNS6_PHY_CTRL_PHONY_DQS_TIMING			GENMASK(9, 4)
 
+/* Width of this controller's rebar (RE#) pulse in clk_phy cycles. */
+#define SDHCI_CDNS6_PHY_REBAR_PULSE_CYCLES	2
+
 /* Default PHY settings */
 #define SDHCI_CDNS6_PHY_DEFAULT_IOCELL_DELAY		2500
 #define SDHCI_CDNS6_PHY_DEFAULT_DELAY_ELEMENT		24
@@ -143,6 +146,9 @@ struct sdhci_cdns6_phy {
 	bool cp_use_phony_dqs;		/* bit [20] */
 	bool cp_use_phony_dqs_cmd;	/* bit [19] */
 
+	/* PHY_CTRL register fields */
+	u32 cp_phony_dqs_timing;
+
 	/* HRS07 register - IO delay Information */
 	u8 sdhc_rw_compensate;		/* bits [20:16] */
 	u8 sdhc_idelay_val;		/* bits [4:0] */
@@ -517,6 +523,13 @@ static void sdhci_cdns6_phy_calc_dat_in(struct sdhci_cdns6_phy *phy)
 	if (phy->mode == MMC_TIMING_MMC_HS200)
 		phy->cp_read_dqs_delay = phy->hs200_tune_val;
 
+	if (phy->sdhc_extended_rd_mode &&
+	    (phy->mode == MMC_TIMING_UHS_DDR50 ||
+	     phy->mode == MMC_TIMING_MMC_DDR52))
+		phy->cp_phony_dqs_timing = SDHCI_CDNS6_PHY_REBAR_PULSE_CYCLES - 1;
+	else
+		phy->cp_phony_dqs_timing = 0;
+
 	if (strobe_dat) {
 		/* dqs loopback input via IO cell */
 		hcsdclkadj += phy->iocell_input_delay;
@@ -715,6 +728,8 @@ int sdhci_cdns6_phy_init(struct sdhci_cdns_priv *priv)
 
 	reg = sdhci_cdns6_read_phy_reg(priv, SDHCI_CDNS6_PHY_CTRL_REG);
 	reg &= ~SDHCI_CDNS6_PHY_CTRL_PHONY_DQS_TIMING;
+	reg |= FIELD_PREP(SDHCI_CDNS6_PHY_CTRL_PHONY_DQS_TIMING,
+			  phy->cp_phony_dqs_timing);
 	sdhci_cdns6_write_phy_reg(priv, SDHCI_CDNS6_PHY_CTRL_REG, reg);
 
 	/*

-- 
2.43.7

