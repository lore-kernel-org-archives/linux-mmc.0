Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2047.outbound.protection.outlook.com [40.107.20.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D05C4A1D
	for <linux-mmc@vger.kernel.org>; Fri, 30 May 2025 02:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748572301; cv=fail; b=J82U3UTTvPuGmVqezEhVVIKSa8AEET+ISV2y9UHpNcjimdwdbAJprITuf0DYDIK9tBn31/GwNFXfCnkLtRyjVQYxjKHIqu64GE6yrkj6bgPHRQ8QryuWX2STyMdh6oEbd2wDOqwL0MhkyowbbLXETinwK4JCWdbjIJGnTz3cZGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748572301; c=relaxed/simple;
	bh=jIX04U1Jomz0yvs7fm6v4GLZnsK3sB6IdVRuhWAOs64=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JRVWSN2jNm1NdHA8kXNjzHwVnOLugnFoY+zzjHVq54b0p7ndL6I+7pVCqnkIF4k5YuSFLTkHTlVlAOj9b1xwi+/jLmBYRZhdGDQUDbt+Txq/UK3Sd8l7M+90frU0Misq8+aj/3ffg6SeU75kD2BWlJujSbgSBlN6/O8FxuBQzX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=N75QTaFn; arc=fail smtp.client-ip=40.107.20.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="N75QTaFn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XCQXHGyX7Hpu8joCLqGAaDSGxjwRVCIkuYfP821QnrNLze5vvHkAoYmkjUXuyYuhOdMVQGgJBh5wZsNUwwHqR71ZxuUYHBhRz8rLzCjr9f3R/LEnEl268pPt0KjVwajgwToYK9KpvXuabp53GoakoJwwTKs3EoMFu+iAKXvn9QOwsD7MYlX5d2T15J26v0u7TuCy9bNp1OfTDQeep/UU1DGlpm/TLJmxmkqueEKZuZSyUtynjBlDMKi/LqlyydrZUJ1dEO3qBsydO5ccHGuNqpwWp62Kl1gZZyW0mNw23+quZqxlB6zdevnPnjSN57OtP9kkczAYsfjsTRvAXaPnEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jIX04U1Jomz0yvs7fm6v4GLZnsK3sB6IdVRuhWAOs64=;
 b=MfWUL9OfVSraCq/SiTUOHOwHJ3KV1SNoiMkrYQ7YdnGc+Dtxed3uLvoSnjrV7L1swbkuDPAJ/eZ5wmfo58D4VwpzO0F6Xh3Pxsh8kNHoqP4r6NKVaPpsZVUya7WXJ0yr+CxSx90xjyRCrYsM6UGrwlYa3CcwXtxALMe6YVP/DcbT5xzX4pByrhMvcaaNLQ/wtnQY6CFBELcG4tMdQdaQ+FDay462n7TNa30zpYPqZbO7Hq86wtJeHngjVVGwy0M5YJ5IckZD6pBWruyc/UZNSz+KRX1zyiqdrRiezvCcGHloHPW9vLWJ+PCc6vOpUthxcFuaDhOTaRmqy1Kwxu+DWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jIX04U1Jomz0yvs7fm6v4GLZnsK3sB6IdVRuhWAOs64=;
 b=N75QTaFnGS8caFAhzLt0lBfE+WqNlfPvI0qQjAvQ5f396xY0F1wvKW6rvdFYAiJmhjNTIld4wax6xKZuaPc3vftwKRuDWQx55TJyKw8HGSl7zFzkfRQTLnpXEWb4JefqK6Xfp2xS4ssCvKEFULrvcZdynbmcTWsxM53ex3vaPBIfGyC4BDdy9ugY9h7ZaYEbngIeka9H+SAahNBI1r90c40P4Rlu/QRYX/ZahNlDbh0WyZdLeymOKD67t4okh7p5qRBLR7/Xg9tQ6K/fjy2oDhYg77SXfDb3WuqWvvRd9Gvq6gmqe4ejxcEtUTTJFc2eD9Ucj7iwROS0Xgb2IlbTeA==
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by PAXPR04MB8736.eurprd04.prod.outlook.com (2603:10a6:102:20c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.30; Fri, 30 May
 2025 02:31:35 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%3]) with mapi id 15.20.8769.025; Fri, 30 May 2025
 02:31:35 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: Binbin Zhou <zhoubinbin@loongson.cn>, Binbin Zhou
	<zhoubb.aaron@gmail.com>, Huacai Chen <chenhuacai@loongson.cn>, Ulf Hansson
	<ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
CC: Huacai Chen <chenhuacai@kernel.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Fabio
 Estevam <festevam@gmail.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v2 12/35] mmc: sdhci-esdhc-imx: Drop the use of
 sdhci_pltfm_free()
Thread-Topic: [PATCH v2 12/35] mmc: sdhci-esdhc-imx: Drop the use of
 sdhci_pltfm_free()
Thread-Index: AQHb0JmNgyXJIfGczEmmti6U2U7mJrPqdIUw
Date: Fri, 30 May 2025 02:31:35 +0000
Message-ID:
 <DU0PR04MB9496B60B9439601BF3B0453F9061A@DU0PR04MB9496.eurprd04.prod.outlook.com>
References: <cover.1748515612.git.zhoubinbin@loongson.cn>
 <ab38dd89c744cc93db8d4fcd477cce7d104fc719.1748515612.git.zhoubinbin@loongson.cn>
In-Reply-To:
 <ab38dd89c744cc93db8d4fcd477cce7d104fc719.1748515612.git.zhoubinbin@loongson.cn>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9496:EE_|PAXPR04MB8736:EE_
x-ms-office365-filtering-correlation-id: 16d44830-bd69-454a-c253-08dd9f22190c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?ZkVnRk52ZnFHMXZMVkRzcC9MNUdQT2VTZHJLWjA2WXFuVFFEM1dXWHZWdDRm?=
 =?gb2312?B?SDI5Wm5IM1d1bU1DYlBiYXhBam9WUWwyQU9FZlpHaFhGSy9QQ2wzWHVBeE8r?=
 =?gb2312?B?WmNoanNiTjhhWWk3YlVWa24zOElYZHF5N0JGM210UGJRTkFiVXRFOEU4c1Bt?=
 =?gb2312?B?QktwZ2JaRUpjbWhJQkxsTE01bUlGdXVBdlFGdXJmald1QVhIOFkwV3ArR24v?=
 =?gb2312?B?TnhybHJHTVpJMWV6SUVuTUdDcGZUdjMwSzY5aTVabE1rMG5VWFhYbzJhdVE1?=
 =?gb2312?B?MVVOQ0Ezd0ZpSmpIdloyWXBpbGgwRlBYbFM2Nys4UDZuY1J4aWxmcWc3VXJt?=
 =?gb2312?B?aHlRR0NJd255MFgyNHVJK010TStPcnpRTUt6VzBzay84NVRIRDZQQzdHOE0v?=
 =?gb2312?B?WllxcWRwYlFjeGdERkhycXhIVkZnYjRRUXJoWVhYZ0RMM21SdEo3SXpEdG82?=
 =?gb2312?B?NjhtMmJzT25qVVpMNFZRNkp0NkdidHdIR3NPRG80dy96a01yUlo5UHNOWmpo?=
 =?gb2312?B?dWJRZ2E2NzBVd3F5ZFFBMmtId0IyMFRBL0p2NVJFcEN3WkVkSFVyZTZLSy83?=
 =?gb2312?B?Q255bzBQMFJRV1B3M0VYYXhIcXpwc0pRbzd2SmJaUEV3d2J5VDhCbHMyMHBp?=
 =?gb2312?B?ajBpYi9FZlBQUlVieUxaZVZyVDVMWldBNi9MT1dCc3A2ejA0VmxzOUJ1YTMr?=
 =?gb2312?B?WUdDNE83akZSdHdtb1kzVGlLYlRBU1kzUjJVZ0xGVC8xS2I2NVdCRGdZdXFw?=
 =?gb2312?B?eDVZeFJoaUJiQ2djbkR5UEJlZisrcWZoYmhqb3Z0dndSYjRTYmhUZWpnc0pm?=
 =?gb2312?B?UVMyWjNpS1V6ODhKeXVIczZaMkNTYkdUTmNoaVh3YzFkanVVSUpaVENwYlRV?=
 =?gb2312?B?N2NjMkxOakpCT2p0S2E2S2NCR1RoQ2VOYkQySXRlZ1JTeVVWLzZqb0FIVGFG?=
 =?gb2312?B?ZGNQYkYyNGx0elIvQ3FOY3RHNytBVVhrclJTd1JIck5GZ1oyUG9OQWJFMzdD?=
 =?gb2312?B?WEswb2FtN3RtdHhoOEV2dnZLayt6dnY3b0Jub0xmZkl0TFdFUis4RFBIUVM3?=
 =?gb2312?B?eTZyMm9XaUtNVHNuaG1sVWRocjNtMFBLRUY0RUpEZWJMMHFqcWJueVBDWElx?=
 =?gb2312?B?QlJvcUFOdHZISFZUNUhxTDI3cTE1RmNjTFZLWitRK1RHUlVKQmVIclNudW5D?=
 =?gb2312?B?WUFBZzlhR0ZsdUZ1Wk5rR0h5bCs5WDgweEN0bSt0bjYxK1h5ZlRMeWlBd3Mz?=
 =?gb2312?B?d2dSeUJHQkxub1NmNFE5Z3VkajhDU2hBWno2bjM3Q0w4dVB2MU8xWVhXVFRn?=
 =?gb2312?B?SUlackprRWhTVXRmVzB5bXZ2QmVSTnlOc0N2YjltRlRab0JsdUV0ZE1EbUpH?=
 =?gb2312?B?SkJ4c1kwNXFMTUJta2JYODJvclUwcFNKV05xVTc2SWtKUjI5Q2pINmE5Qzh2?=
 =?gb2312?B?U3pHTDVkMHljSVhRQ0RlN1VzUnFBLzZoWmZ1RkZVQjJ2dzJyYjM3ck5MUnh2?=
 =?gb2312?B?UEhGN2lZdFNXN3lqOENWTnVZNTRTcFdieldaN0Ixbnhzd3JuM2kwNkhiZm1j?=
 =?gb2312?B?eSs0ODVhczdST2lzeXV6T2RkMEZhclJ2VWt0MHVxY25ZcUhacnlNNVFCYmNF?=
 =?gb2312?B?UDBNMTl6ZWI2c2ZGSFVFODcxdEM1REphZSt4Rm5qOTFqWWdvWGh0RERtTkVI?=
 =?gb2312?B?dk0wckJvaEp0MTVhdmNQWVNKQmNhZG9MVU00M3ZUNC9lYmo2OUYwVitJZmdX?=
 =?gb2312?B?QWxUU3NybVpZZ0FGYWVyZkEyTXZ6SjNpZXo5aWFDTHJqZWhBSnI3b3R5dm41?=
 =?gb2312?B?RXpnYUk3aDV1Q2Q5NWw5V0NBZHJFZXlueEtlU0hWVTM4c2d2cnE0QVYrYkZ2?=
 =?gb2312?B?QThOaGVYRmRIMkQ3MVhkazYrbEpDWnNDOUVkU0dMbVVuMDJSM1liN1JsOHhz?=
 =?gb2312?B?K1Vrb3lrN2xlb09CTVI2eGNnZUZqZWlDOWRwZFRTaUdRYUNUWHJNRWtMaWxB?=
 =?gb2312?B?bXZGcWszK1dBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?SlI2cDhhdzBZWTN5OUs3VGQ5eFdSd2w0ZElEUmpCSlYzZXNNQUcrempNMEVo?=
 =?gb2312?B?bklCRUEvOGhMbXNMMGVQQ0REVnJ4R3RPc2VDbXVJemtBR3NUTEtTZWJGNG9G?=
 =?gb2312?B?TVFPRkV2TEdNcGhuZzN2eGFwZnNJTFhNbm5pbitFeksyK0xKZElHWFVJbzhs?=
 =?gb2312?B?RDFWWTczZ2lkRGY2Mk15YjJQSnZSZG1XVURBVWc2VXg5SFZ3STg1anN5eXdW?=
 =?gb2312?B?MDJvOHJseENnUXdoQmVTKzBpTE9FKzN3Q24vakdBa3lWeEFYNll0SGIyVkdH?=
 =?gb2312?B?K1VFaW9rVnJGUXlBWFFEWUptZjhpVE9HRFNZM0FCQjhVU1RMaXFsSzFwd3Vk?=
 =?gb2312?B?b25oZ3dEK0tLdUFUQUdTSHhrTXpQbmJaVDlpc1I3d3hacWdsa016TlliUnJM?=
 =?gb2312?B?QS9HYXo4WXBVcXViQnhseDh2N29oNFNySzllYVUvNFFXdkVkei84ZVJQcnM2?=
 =?gb2312?B?TE9VT2VzZlV5akNpN1NkNi9yWEk4WWh6L3E5WGF4TllJRUhtOW44ODIzSmRm?=
 =?gb2312?B?bnVaY2YzRUFzWWhQWHdCcWRwRVBDVVZCMFdGVXYyelpkNFJDaFhuWXpiWEIw?=
 =?gb2312?B?TkFhWis2UEFrdE1xMVRoclo5Nk1aWEZKTHdVN3J1dXMwVU9SbGxvUk5Pbkhz?=
 =?gb2312?B?VCt1WCs5NGlxT01RVWp4QTNNOEpxNXIxVm05VktYaHYwVWFvcGFFY1ExVFc4?=
 =?gb2312?B?aVkwSm9MUWhGaVRFYTNXeUJCcllncWk4Qm9Udis0TndWM2RkOVNIdE9QRWM2?=
 =?gb2312?B?eXZGbmM3MUJrSWFmZFp6aXBWTm11eTJRQVZQU0JvcVhlZXcwKzRtTE40NndZ?=
 =?gb2312?B?Q2p6RmNpcDJwOGI2eEpXT2J5M1RJM0R1cVpnZlMyZWt6U3hmZW5JdU1IaEVF?=
 =?gb2312?B?eWU1bGU5NDAvcVpWMVVoY09Lb1FJcWt3aXd1QnFZcEZGKzRlekRRSU1uZEht?=
 =?gb2312?B?ZG5EeVBXSVFwdCtuaW85Wk5jU2M4TG9uS3JSQTI2Y0g1NnROcXBGaGYzZnh1?=
 =?gb2312?B?YmlONmNITkNzVmdUdFc2S1AyTlhDaEwyajNZd1lpaUNnRmsrdUJsQ0EwR1pC?=
 =?gb2312?B?UzNVWGcrNmgwUzNKSEV2MDVEMVNDM1dhS0EvalZoNkhaZDNnTWdwVUs3aGE2?=
 =?gb2312?B?eDZuaklsWThac2pISWQvdHJGT09mR2U1Uko4NTlJYVUwTk14Zjd4ejE1d3E4?=
 =?gb2312?B?ck9mVXY4c1ZqbVlCWUV2blRZelV1L045dkUxUmsxZnk1V1F6SVArSU9lTjVy?=
 =?gb2312?B?bzRXL1FwaXFsYWsrL29iaEJValVjdTM3NXJaMEhjbThtRGRCYzU0SHlrdzVN?=
 =?gb2312?B?bGZLUnhVMTBSVDVWYXhudHp0MVovdDRSbDk4aEdmUmR2K2JSWVgyeGFSVXdV?=
 =?gb2312?B?Z09EUXBiWWU5UGQ4T09EdE1MKzZ6cHZWbDNFQTIxbkgyUmtEVmhtSHdkWDY5?=
 =?gb2312?B?OXZOdmJCREtpZHFMUHNLSTVQeUlnTkluTmNmOThYWkVIVG9mZXZKeHFZa2lE?=
 =?gb2312?B?dHhBZ2pMbElDRDk0NWlIN0ppQnZjTXdJbTFwZnRTenBtVCtSV2lyMHJQWDJo?=
 =?gb2312?B?ZUlha2hlYjIzYlRmL3ZhV2JLN2JwalMzelJDMUZuaFFsbzBFQ2RvaDF5SGhV?=
 =?gb2312?B?Sk9pdlpwczE5VkQ4Uml0YWd0NEErZ2JuT1dzUEhxbkNnVFljRmNiUHRUUnBK?=
 =?gb2312?B?d0pNY2RMcmV5TzNvbUVEL3dlcFlnYy9DQ2QvaWFmS2RyNWlUS0lNenVQbk9E?=
 =?gb2312?B?c0hIUXVDVjk3eTNhN2lmZXNjdStvSkhLU0tFNHlPWG9paXFScHlmcWVlNnF4?=
 =?gb2312?B?T3UzS0ZZM1pmckl1bUJ5RkFSTVB0YnpGdHdRMEU3Mk1zc1FkTGFzeUR6YjFS?=
 =?gb2312?B?OC9BeXJ1YlJ2YXNFc0xMT1RqcXBuUVE5NUc1ZnBJTTlpa2VuZUlmY0RNc2xU?=
 =?gb2312?B?Y1Ric0ZwWWttR1RvdzJBbFg5MSszbHJ2TzhKWno3WnNWYytxQmhJT0dwWW5V?=
 =?gb2312?B?S05GRysvSVpsZ3RxSTE4aW1EbTlTZzRPcnpXUWQxRHJPN05FZkNlYnNRVkhk?=
 =?gb2312?B?a0Noa1RIZ0M1cXpRNmlvRDkvY0ZNbjgycnlZTWY3NUE3MGRvMk9NZVgvVTZk?=
 =?gb2312?Q?501Y=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16d44830-bd69-454a-c253-08dd9f22190c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2025 02:31:35.4063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: daXU84mjWcvWf8dJWqGCEWCpYxfsFvaeG8EffLOnMr78gTldIgzEv9ncGFof1yMM4Fn4co+l8zoLbqNNgobOFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8736

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCaW5iaW4gWmhvdSA8emhvdWJp
bmJpbkBsb29uZ3Nvbi5jbj4NCj4gU2VudDogMjAyNcTqNdTCMjnI1SAyMDo1OQ0KPiBUbzogQmlu
YmluIFpob3UgPHpob3ViYi5hYXJvbkBnbWFpbC5jb20+OyBIdWFjYWkgQ2hlbg0KPiA8Y2hlbmh1
YWNhaUBsb29uZ3Nvbi5jbj47IFVsZiBIYW5zc29uIDx1bGYuaGFuc3NvbkBsaW5hcm8ub3JnPjsg
QWRyaWFuDQo+IEh1bnRlciA8YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+DQo+IENjOiBIdWFjYWkg
Q2hlbiA8Y2hlbmh1YWNhaUBrZXJuZWwub3JnPjsgbGludXgtbW1jQHZnZXIua2VybmVsLm9yZzsN
Cj4gQW5kcmV3IEplZmZlcnkgPGFuZHJld0Bjb2RlY29uc3RydWN0LmNvbS5hdT47IEJpbmJpbiBa
aG91DQo+IDx6aG91YmluYmluQGxvb25nc29uLmNuPjsgQm91Z2ggQ2hlbiA8aGFpYm8uY2hlbkBu
eHAuY29tPjsgU2hhd24gR3VvDQo+IDxzaGF3bmd1b0BrZXJuZWwub3JnPjsgU2FzY2hhIEhhdWVy
IDxzLmhhdWVyQHBlbmd1dHJvbml4LmRlPjsgRmFiaW8NCj4gRXN0ZXZhbSA8ZmVzdGV2YW1AZ21h
aWwuY29tPjsgaW14QGxpc3RzLmxpbnV4LmRldg0KPiBTdWJqZWN0OiBbUEFUQ0ggdjIgMTIvMzVd
IG1tYzogc2RoY2ktZXNkaGMtaW14OiBEcm9wIHRoZSB1c2Ugb2YNCj4gc2RoY2lfcGx0Zm1fZnJl
ZSgpDQo+IA0KPiBTaW5jZSB0aGUgZGV2bV9tbWNfYWxsb2NfaG9zdCgpIGhlbHBlciBpcyBhbHJl
YWR5IGluIHVzZSwNCj4gc2RoY2lfcGx0Zm1fZnJlZSgpIGlzIG5vIGxvbmdlciBuZWVkZWQuDQoN
ClJldmlld2VkLWJ5OiBIYWlibyBDaGVuIDxoYWliby5jaGVuQG54cC5jb20+DQoNClRoYW5rcw0K
SGFpYm8NCj4gDQo+IENjOiBIYWlibyBDaGVuIDxoYWliby5jaGVuQG54cC5jb20+DQo+IENjOiBT
aGF3biBHdW8gPHNoYXduZ3VvQGtlcm5lbC5vcmc+DQo+IENjOiBTYXNjaGEgSGF1ZXIgPHMuaGF1
ZXJAcGVuZ3V0cm9uaXguZGU+DQo+IENjOiBGYWJpbyBFc3RldmFtIDxmZXN0ZXZhbUBnbWFpbC5j
b20+DQo+IENjOiBpbXhAbGlzdHMubGludXguZGV2DQo+IFNpZ25lZC1vZmYtYnk6IEJpbmJpbiBa
aG91IDx6aG91YmluYmluQGxvb25nc29uLmNuPg0KPiAtLS0NCj4gIGRyaXZlcnMvbW1jL2hvc3Qv
c2RoY2ktZXNkaGMtaW14LmMgfCAzIC0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgZGVsZXRpb25z
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXgu
Yw0KPiBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMNCj4gaW5kZXggYWMxODdh
ODc5OGI3Li4wMTFiNjBkMjFhODAgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbW1jL2hvc3Qvc2Ro
Y2ktZXNkaGMtaW14LmMNCj4gKysrIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXgu
Yw0KPiBAQCAtMTk3Myw3ICsxOTczLDYgQEAgc3RhdGljIGludCBzZGhjaV9lc2RoY19pbXhfcHJv
YmUoc3RydWN0DQo+IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIGZyZWVfc2RoY2k6DQo+ICAJ
aWYgKGlteF9kYXRhLT5zb2NkYXRhLT5mbGFncyAmIEVTREhDX0ZMQUdfUE1RT1MpDQo+ICAJCWNw
dV9sYXRlbmN5X3Fvc19yZW1vdmVfcmVxdWVzdCgmaW14X2RhdGEtPnBtX3Fvc19yZXEpOw0KPiAt
CXNkaGNpX3BsdGZtX2ZyZWUocGRldik7DQo+ICAJcmV0dXJuIGVycjsNCj4gIH0NCj4gDQo+IEBA
IC0xOTk3LDggKzE5OTYsNiBAQCBzdGF0aWMgdm9pZCBzZGhjaV9lc2RoY19pbXhfcmVtb3ZlKHN0
cnVjdA0KPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+IA0KPiAgCWlmIChpbXhfZGF0YS0+c29j
ZGF0YS0+ZmxhZ3MgJiBFU0RIQ19GTEFHX1BNUU9TKQ0KPiAgCQljcHVfbGF0ZW5jeV9xb3NfcmVt
b3ZlX3JlcXVlc3QoJmlteF9kYXRhLT5wbV9xb3NfcmVxKTsNCj4gLQ0KPiAtCXNkaGNpX3BsdGZt
X2ZyZWUocGRldik7DQo+ICB9DQo+IA0KPiAgI2lmZGVmIENPTkZJR19QTV9TTEVFUA0KPiAtLQ0K
PiAyLjQ3LjENCg0K
