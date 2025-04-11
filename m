Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2041.outbound.protection.outlook.com [40.107.20.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF87347C7;
	Fri, 11 Apr 2025 02:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744339517; cv=fail; b=ZLHWQuWshLpn4ODHaDe3KuLBuGR2MWcbGwnJNA/FkbwF+MsdBMAgZC0O5lWTPTc18SIei+ssPGqcgLbhIY7BmgqTkHp5ALf5WonPNFDASqbQPnvMKmC9AwKqOQUKiFlZA1pD1u5KihKKTL0VBVONyx3Yhw6T8YhGOcmNnOosZt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744339517; c=relaxed/simple;
	bh=S2HeeKz951fBgWHSroLL8od5xr6CSChc1GnQ6vpKg/s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FEDCRA1/moVIomPz+gEGXrwLhqinrfYJN6MI8mSF2Dhh3oSkLjoYZ3Jnv+f2NQWqIpDEpEy93JrqK5G2YpBiRNGmzsdJWAi2ElYQeKAVRphavCZSrCVzJ5wjKLlUzsb8q37Ze2ggIlH06Ktqcfa28/GBvFNNak90xDGTmYVyqTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AJdIaCzh; arc=fail smtp.client-ip=40.107.20.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AJdIaCzh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VN3IrATL5qvubd7oa2svzS7xIO1J0I6g8WHFFlhPcqfgNJy3f20DPbZRrCSWuS9mQqbOM50jETQQ8WWLBFbAXilg83TtQfdUqvP2hj4ujDdbOjYKfBHeDZxoKJgMkIsKPHTOvA4EKVZZ5yAZcyeznRuvVyQ/VhGzNdmbhIrK6li+Lqn6xMoVKbHBRX8UipMmUjH+3cUd8Im3BzyyPwNFDVhp+jmTmRymksvRISjOE4npTrIqXLw1MbvEzX2pGezW5hmuRAIqb2VnohmTPMa8A3AKYFGtG9W1/3OCYAjZ1u8HTq9przB1E3YdoyvpYsdiU8kG8r1aJSa352Cgwz3vbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S2HeeKz951fBgWHSroLL8od5xr6CSChc1GnQ6vpKg/s=;
 b=EySdQa/vKuKuq/2Aal5DmYG0aXc3BEkmmcsRn2us62sUg7MqCncS+IPHYDq6LRP7DufnXvYzBPOG2fD2Wcsc8wvONt5N1FOxgzRN9JFZjf3nHUpz6IMV/OQMojnl3zw5Y076csxxU2D145+tfUHXX3VCz//1DXRkIkR+Adsum2ltSU6IV6VbZjhfLGPnca+ANiudGllEMjo66o2iGYoGXn5DeawddmbxdCgP0LiEsT3JBZScYwx/sk3iqE8Mv1SH0bskUgNNSAHvBfOoRU21v13nOyNaTB0JoTQXU5ZWmdg+qTkeMBgZpEE+PGaQ/YTbduoh9N8jFuV0Xd8ORw8veg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S2HeeKz951fBgWHSroLL8od5xr6CSChc1GnQ6vpKg/s=;
 b=AJdIaCzhUSLctqHSzcQPlM/weV1yxlHrpk3oZIL9UWwO+wRnZtJr9aP6mSRbDtVwA8xqAHdnyRdZBV+G1xdJq5V5/Pa0Yz0yc+KggZC7Yo9UEQXru34EYIAhDeQ17dufbBUSsA6MtVHxw/1D1Yp/iNIifqB45xlX9cfmkSc7RpWggQzNGGNIXgIlzofSUjAdlExXdaIBXSdVVWQQ8bfwwbM5rbZgHIFHDYE6aNPqbCtvL/XDUFpTgsgOUO91C3/gNwk6zQa2wWaBWRSyqMbPUTMsi0bJUT1WfXuo9qtISDU8NYmctEUlXaT0OYoPcVRjzuOAnTIJB/MNjoZhLAH0qQ==
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by VI1PR04MB7198.eurprd04.prod.outlook.com (2603:10a6:800:126::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Fri, 11 Apr
 2025 02:45:10 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%5]) with mapi id 15.20.8606.029; Fri, 11 Apr 2025
 02:45:10 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: Arnd Bergmann <arnd@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Luke Wang <ziniu.wang_1@nxp.com>
CC: Arnd Bergmann <arnd@arndb.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, "Ciprian Marian
 Costea (OSS)" <ciprianmarian.costea@oss.nxp.com>, Josua Mayer
	<josua@solid-run.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, dl-S32
	<S32@nxp.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mmc: esdhc-imx: convert to modern PM_OPS
Thread-Topic: [PATCH] mmc: esdhc-imx: convert to modern PM_OPS
Thread-Index: AQHbqiI0z3rE5XwHokSTjqOR7uzdj7OdwrhQ
Date: Fri, 11 Apr 2025 02:45:10 +0000
Message-ID:
 <DU0PR04MB9496EAB4A567BDA8948D434690B62@DU0PR04MB9496.eurprd04.prod.outlook.com>
References: <20250410140921.849213-1-arnd@kernel.org>
In-Reply-To: <20250410140921.849213-1-arnd@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9496:EE_|VI1PR04MB7198:EE_
x-ms-office365-filtering-correlation-id: 18d32d88-d773-40f4-5a91-08dd78a2e0a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?VlA2YVdZZ1NkSy9NK3NSTzhndGdsL3JhWEpmWjAxT2xwWnZXVThnWjg3cW0r?=
 =?gb2312?B?SnlZMGVFaS9UKzZWRzBBR0o1d0dUb1Z2dklYbzRBZ0NlaEc0SmhDM2VHS0VC?=
 =?gb2312?B?a1FtQWtITjNTc3RsYlVLTEQrUEY0YnVHbTBLZkxtMDRXU3FVWFIveE5QUTNF?=
 =?gb2312?B?TWtRc09aT2dSckxLcWF5NGZHSi9ieU1SeUcwc1FEaGMwaUlub1NramJnVWRs?=
 =?gb2312?B?OTRGbmllZjJ2Rm85emZIYlljOEZHcVpHbDVCaUJtU3RxZFFvTGc5azZWVTJm?=
 =?gb2312?B?d2UwUDlMRVpmTlRMTk1oMEl4c3FKUWYvVnArbFB0SExRWW93Z2lTS0hDVHpG?=
 =?gb2312?B?OFc5SXA4YWxPdDQwemdYVUZELzlMdXFVYkZuR3ZOTHR3WllIS04wV0s0ZS94?=
 =?gb2312?B?VHhrcG1zZXlLWHN2SzlyMWhKOUpWK1Q1bzVLcUZUZWtONTlVQ2pHZzlCOWtL?=
 =?gb2312?B?ZzJTb1lwYWhzZ3lFcm1XMXRheWxkWEExanlvc2RYQTdUck1qWlRTbzc4WFVS?=
 =?gb2312?B?NmJQTXVBWFVUcGxOM0lsSlp3UjdWMkNrV09HbnB1MmpwbmFJTk1DaWo2YnRQ?=
 =?gb2312?B?YXF1dWlyQS81YWZPT0p2L1VJTEF4SFRGYlhqYmc5U2lxeng5a2lLSXViRmww?=
 =?gb2312?B?WTZvTE84Z0lkSnU5ZHNyUEo3Q0ZPbW1Ecjk2d0JCYkxFcU5mWGVnd2E3U3FY?=
 =?gb2312?B?alBseGEra05mbTRYaGhYVVB4VVg2bDdLUmdLZEVTcGwrRllKemJIYVErK09S?=
 =?gb2312?B?YUtYbkM4dlpSN3loZ0ozTkc2MDkxdlZ3amEybGRyNFlFRzlRd1VURkFhcmxm?=
 =?gb2312?B?SXZmL2krbSs1RmZXZSswdlV5N0J1YmRxMWhkWmg1WlJIeGZML3Rid0tOKzRW?=
 =?gb2312?B?OXVDcHFmRS9OdkdIMmcydWlqV1BWekdxWkUzQWJpZzJBeGNnRTBtMEgyeW15?=
 =?gb2312?B?c1F6WjBQZlM0R0txTGwyd2xBa2xBWFA5MUU3VXZHUEppNHBkWHh5L2lISnNO?=
 =?gb2312?B?cXh4VFNUckt1MTJwUVZLTUNLUHhDdUVkVGR6OENoRkMxcjRqcEJvZkdmQ3A0?=
 =?gb2312?B?Ny9pZk5MM3pYK3R6REdKbDBVRzZkc01QNGFjcm1ZQ1VFRkNRbVZVZjR1T2Vv?=
 =?gb2312?B?RktFVExxT1ZpbEJyWTRsZXVONEU4aDUvTGdqbnp3Z2krbWpTdE5vNE1tWHhJ?=
 =?gb2312?B?U2tESG1rdmd0OCsvQ2ZHclFOTk0vcCtkdXZPTnhsdC93UVRtQzlLcFFXbVl3?=
 =?gb2312?B?MG9KK1JjanVIcnBQUDRGNkNMS2taYThMSjIxOHRKQzVyRVgyRkU0elRSTkNH?=
 =?gb2312?B?dW9zOFFmTWVxWHQvY2kvajZDV3RqL3c2ZUxMRitQYk5TQVlEdG53aEYvSG9x?=
 =?gb2312?B?bURyTXNTcE96UDR5bzdvMm9ZTlBoSlk4YVREY0hFYkJmeFVHcnEwaWJJekl0?=
 =?gb2312?B?bmhEVGRkZHJpMjFhOE1iWmg3aUdNbmUwZm5mZm9vRVFyV2Ntd284MnMxTDB0?=
 =?gb2312?B?ZjBTbmcrUUtYMFZjOStkaGtvS3hhWWwwMWF5M0VJcENnUEdvNXROS0RPQUpE?=
 =?gb2312?B?SE1IbFBKL2VmZ1J5WHpKdm4xR2k3Ri9sRmlEUUVrMEtOUUE2anY3VFNyYXlv?=
 =?gb2312?B?SGJCNGs1TVJBd2p6TGEyS2ZPR1BzWS9lQm5YS1d4ZXFhUUwrckJNNXBkaThE?=
 =?gb2312?B?aGFQUTV2UU1vbUtBMXZoZjNTK1NaMDVpblZlRXhQbkpqcUxBWmtHdlZkVndJ?=
 =?gb2312?B?Z0dzNXdSeGFENEc1WHk2cVBhSkVJK3pLL1lOT25iVWg3MnVGcFRWdHZZL2J0?=
 =?gb2312?B?UHBNcTRHcHY5U3UyNEFBM2cwRkVIVGlEcE4xb0IyM2tUOEQyM2NpZm9lMHBO?=
 =?gb2312?B?d2VQTzY5VDZkU3hscHlhQTM2cXM2djNTdkY3b1oyRis2a3pQbnNHYTFVeFc2?=
 =?gb2312?B?SVBQeDBDV2Q5bjZWNFFyeURnejdnaVUvUWFiNHAwdUxzNElCZGhQTnlPK3Vq?=
 =?gb2312?Q?YM+YpJR8sCBZDIGbj6YN96/35J0Fp4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?b3dOU2dXTVEzdjY3Tll2VGJRdjU1cGp3MWcvL05lV25sSi9ocVViZ0dqeGJz?=
 =?gb2312?B?Z2oyV0JPUkkwVFhFdUpEdXAvODNFdThBazNhRFhlSXFyTXpOVTBaWS80ckI1?=
 =?gb2312?B?NXNybUNRTzg1SERZanJOcHk4TTBDTjFteUxSMGRzbFRTajZVY1hWK1VoQlll?=
 =?gb2312?B?UWpxc2ZxTTc0UlNhUzcxbEcxYlZFbGIxUEQ1cUt4TUNveDlZYkZGdXJoNmpo?=
 =?gb2312?B?U1dYUVJjN2pIQXI0Rm16M0xsMDYrNG5ROENaczZuUmpMT3JYeDBRYW9xLzRz?=
 =?gb2312?B?TEQzaE5KMXd5NFdST2ZseVlwQzF5aWw2dm1Ud01mdTlEUFJwcHBlQ0x1dGhY?=
 =?gb2312?B?WHZ4clhaQmFIVWFJMVVXUkduTE1tcmIwTlYwZUJIVFI0OFZLYmNxRDhpMUY2?=
 =?gb2312?B?SnJSUWFkUGt2S3cxOUJPUnQrRWZuSDEvSG5pMlNRelM4YjhwbVFPb01Ub1Z0?=
 =?gb2312?B?ZEZqL0drNDlGaUFvOGNxMU9HT2NYWkNzTzd3ZXBqYVNyNmpFVVdySGNNdWFi?=
 =?gb2312?B?dnIzQkdlVzQ4N0RtSXpBS1pRd3U5WWhHSzR6ak93N205cEE3c1NCcFNoYk5P?=
 =?gb2312?B?aEJNT3JUT2hLWTFnN3lHb1hCNUNUa0ZwVllhay9pRjMyajdZWURIN1MxUVN5?=
 =?gb2312?B?QWpLU0tDME8wUXBBb084MDFka1k4QkY0YkliYWp0QlRSdFE0WHVJeTU0QjQv?=
 =?gb2312?B?S3dDTUhqclB1Zm1hQ1h4U1JNbWNmN1NLa0FLRlB5Vzh3YkJPbEwwR0l2TG81?=
 =?gb2312?B?eE1ySDRHQW1QUVI3K2x3YmxKYXVRVEpNcnpFcW5CZnpvMFRrNnpNY2ZPZWUw?=
 =?gb2312?B?eHIrQVg5c2hlanVtUlRIUWlvTGhKbGdjUTQraXgzMmRzSFN0QU5Jek5wbVpl?=
 =?gb2312?B?ZWpNUHM4K2dLTzI2RE9XT1pVSzMzNFhpWUlzcnNzdEtjVkxRYW5NSW14RUp3?=
 =?gb2312?B?N0RjNWtxaDIzQ3RaNW5URE9lcXA3ak5DSGhXakFBeCtiKzJJNCtYTVBpSU9G?=
 =?gb2312?B?VTVsWkJYWWlNb0NGZ1JSdk1UaURCMFJIVHErUjEvUnFvWUlET2FyZHZnVllx?=
 =?gb2312?B?L2toNHNSTzRpZVhOckJhR1UvWkEzS2JkcXpKNjA2Mk5tcEFmUzVpMHNwVjZr?=
 =?gb2312?B?OXdBb0l1emhrMExBaDRIeUhWeGpZZEhNeGxKODQ0ek9CSU5iUkVkQmdHQjRG?=
 =?gb2312?B?WkZGQVBLNDF3YnlFVlcvZllHY0pPa0RYNXMvNThUMlc1R3lIdEVRamVRc0Nl?=
 =?gb2312?B?Y05wYmZCZWNjd0RRL3hzRWtGOS85bGlxV2ZFSmUrYkRzSTgrbmFvRDJGYVRW?=
 =?gb2312?B?bDBPMDRFYnVMZDZJSG1EWE82b29vZ0I2SEJ4d2lwUmRRQldHckxCR3VxVGk3?=
 =?gb2312?B?Wi9QU2Q5ZGZoQzF4U1dvbjRmVm84b3g2TTJOc2FZZ2F6UVNpZTBHSUdERnhH?=
 =?gb2312?B?ZmZPWTRRZkZtR0dzdEJVdWlkOGxLVk9hZlJSSG5OcEVrZjNOTGR0a2RmZDdr?=
 =?gb2312?B?OXhxcFhxdXBnU3BlSGE1U0llZjY1WC9TS3pIZVpzWFFQQlBDWjRxVDQyaU5k?=
 =?gb2312?B?ZktUUlFaUFhmb3NKOG9XREcxYTBaQkNJaEFkUXRhMmJVQW84RjVHZThYS3hp?=
 =?gb2312?B?SjczWnJQamx1dWw2NXh0bGxkZ0F5Z3ZJMGlDMVlJNDRCSGNsVEZyTTVvYVA5?=
 =?gb2312?B?dlQyYjE1NjZUYjJtc3Rvazc4bG83SkpiYzduem1XSWhVK1ZVNlVpNElsazRh?=
 =?gb2312?B?aG9oZDlRc3phK3FUeDFBSzM3VzRvcjRERkg3RUpyRjFHOHRmVVZXcTRWSEtZ?=
 =?gb2312?B?S2FCL3ZuOGhpK0JLMURHSUZPVS9pU1pBcUZJOWdvdm1nc2k4ckY1TzJYb05q?=
 =?gb2312?B?eXNQdGNBc1pwNmkycS9VN0hncWxJNzZGMnlUU1VDbDZOdmIraFYzYUVYV3hL?=
 =?gb2312?B?Y1kyL2ZJUHlSSEpNNnAvTVc2L0wzc0tlcUlQNDhVdmQydVFZdlNES2VvenFU?=
 =?gb2312?B?ZlU5b1Y0ZFZHMFh2bWNBckovN2ZMcnNLV1F4V1M1ODcyMUR2OTJXY1dKZFUw?=
 =?gb2312?B?alo5bGh5aTYvd25KQVZxa1ZOSVMvNWdVQmJhWU54MGhPT2xsdUJKRWcrbW81?=
 =?gb2312?Q?kyyI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 18d32d88-d773-40f4-5a91-08dd78a2e0a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2025 02:45:10.5200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T32uc7KC7f+Gb3EA2vdB11rTW9kCimRKYDxgrj+z3skFcI8vQSu0Ed3r/h8Ccv988oA+mC57XaD82OBTTT06ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7198

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBcm5kIEJlcmdtYW5uIDxhcm5k
QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjXE6jTUwjEwyNUgMjI6MDkNCj4gVG86IEFkcmlhbiBI
dW50ZXIgPGFkcmlhbi5odW50ZXJAaW50ZWwuY29tPjsgQm91Z2ggQ2hlbg0KPiA8aGFpYm8uY2hl
bkBueHAuY29tPjsgVWxmIEhhbnNzb24gPHVsZi5oYW5zc29uQGxpbmFyby5vcmc+OyBTaGF3biBH
dW8NCj4gPHNoYXduZ3VvQGtlcm5lbC5vcmc+OyBTYXNjaGEgSGF1ZXIgPHMuaGF1ZXJAcGVuZ3V0
cm9uaXguZGU+OyBMdWtlDQo+IFdhbmcgPHppbml1LndhbmdfMUBueHAuY29tPg0KPiBDYzogQXJu
ZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT47IFBlbmd1dHJvbml4IEtlcm5lbCBUZWFtDQo+IDxr
ZXJuZWxAcGVuZ3V0cm9uaXguZGU+OyBGYWJpbyBFc3RldmFtIDxmZXN0ZXZhbUBnbWFpbC5jb20+
OyBDaXByaWFuDQo+IE1hcmlhbiBDb3N0ZWEgKE9TUykgPGNpcHJpYW5tYXJpYW4uY29zdGVhQG9z
cy5ueHAuY29tPjsgSm9zdWEgTWF5ZXINCj4gPGpvc3VhQHNvbGlkLXJ1bi5jb20+OyBpbXhAbGlz
dHMubGludXguZGV2OyBsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnOw0KPiBkbC1TMzIgPFMzMkBu
eHAuY29tPjsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtQQVRDSF0gbW1jOiBlc2RoYy1pbXg6
IGNvbnZlcnQgdG8gbW9kZXJuIFBNX09QUw0KPiANCj4gRnJvbTogQXJuZCBCZXJnbWFubiA8YXJu
ZEBhcm5kYi5kZT4NCj4gDQo+IFR3byBuZXdseSBhZGRlZCBmdW5jdGlvbnMgYXJlIHVudXNlZCBp
biBjb25maWd1cmF0aW9ucyB3aXRob3V0IHBvd2VyDQo+IG1hbmFnZW1lbnQgc3VwcG9ydDoNCj4g
DQo+IGRyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14LmM6MTU4NjoxMzogZXJyb3I6IHVu
dXNlZCBmdW5jdGlvbg0KPiAnc2RoY19lc2RoY190dW5pbmdfc2F2ZScgWy1XZXJyb3IsLVd1bnVz
ZWQtZnVuY3Rpb25dDQo+ICAxNTg2IHwgc3RhdGljIHZvaWQgc2RoY19lc2RoY190dW5pbmdfc2F2
ZShzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCkNCj4gICAgICAgfCAgICAgICAgICAgICBefn5+fn5+
fn5+fn5+fn5+fn5+fn5+DQo+IGRyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14LmM6MTYw
ODoxMzogZXJyb3I6IHVudXNlZCBmdW5jdGlvbg0KPiAnc2RoY19lc2RoY190dW5pbmdfcmVzdG9y
ZScgWy1XZXJyb3IsLVd1bnVzZWQtZnVuY3Rpb25dDQo+ICAxNjA4IHwgc3RhdGljIHZvaWQgc2Ro
Y19lc2RoY190dW5pbmdfcmVzdG9yZShzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCkNCj4gICAgICAg
fCAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+DQo+IA0KPiBSZW1vdmUgdGhl
ICNpZmRlZiBjaGVja3MgYW5kIGluc3RlYWQgdXNlIHRoZSBiZXR0ZXIgbWFjcm9zIHRoYXQgc2ls
ZW50bHkgZHJvcA0KPiB0aGUgdW51c2VkIGZ1bmN0aW9ucyB3aGVuIFBNIGlzIGRpc2FibGVkLg0K
DQpIaSBBcm5kLA0KDQpUaGFua3MgZm9yIHRoaXMgY2F0Y2hpbmcuDQoNCkhvdyBhYm91dCBhZGQg
X19tYXliZV91bnVzZWQgdG8gZGVmaW5lIHRoaXMgdHVuaW5nX3NhdmUvcmV0b3JlIGZ1bmN0aW9u
Pw0KDQoNClJlZ2FyZHMNCkhhaWJvIENoZW4NCj4gDQo+IEZpeGVzOiAzZDFlZWE0OTM4OTQgKCJt
bWM6IHNkaGNpLWVzZGhjLWlteDogU2F2ZSB0dW5pbmcgdmFsdWUgd2hlbiBjYXJkDQo+IHN0YXlz
IHBvd2VyZWQgaW4gc3VzcGVuZCIpDQo+IFNpZ25lZC1vZmYtYnk6IEFybmQgQmVyZ21hbm4gPGFy
bmRAYXJuZGIuZGU+DQo+IC0tLQ0KPiAgZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXgu
YyB8IDggKystLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDYgZGVs
ZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2Ro
Yy1pbXguYw0KPiBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMNCj4gaW5kZXgg
N2U4YWRkYWVkNjk3Li44NzQyNjIyZGE1NWEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbW1jL2hv
c3Qvc2RoY2ktZXNkaGMtaW14LmMNCj4gKysrIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2Ro
Yy1pbXguYw0KPiBAQCAtMTk0Miw3ICsxOTQyLDYgQEAgc3RhdGljIHZvaWQgc2RoY2lfZXNkaGNf
aW14X3JlbW92ZShzdHJ1Y3QNCj4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgCXNkaGNpX3Bs
dGZtX2ZyZWUocGRldik7DQo+ICB9DQo+IA0KPiAtI2lmZGVmIENPTkZJR19QTV9TTEVFUA0KPiAg
c3RhdGljIGludCBzZGhjaV9lc2RoY19zdXNwZW5kKHN0cnVjdCBkZXZpY2UgKmRldikgIHsNCj4g
IAlzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOyBAQCAtMjAy
MSw5ICsyMDIwLDcgQEANCj4gc3RhdGljIGludCBzZGhjaV9lc2RoY19yZXN1bWUoc3RydWN0IGRl
dmljZSAqZGV2KQ0KPiANCj4gIAlyZXR1cm4gcmV0Ow0KPiAgfQ0KPiAtI2VuZGlmDQo+IA0KPiAt
I2lmZGVmIENPTkZJR19QTQ0KPiAgc3RhdGljIGludCBzZGhjaV9lc2RoY19ydW50aW1lX3N1c3Bl
bmQoc3RydWN0IGRldmljZSAqZGV2KSAgew0KPiAgCXN0cnVjdCBzZGhjaV9ob3N0ICpob3N0ID0g
ZGV2X2dldF9kcnZkYXRhKGRldik7IEBAIC0yMTAzLDExICsyMTAwLDEwDQo+IEBAIHN0YXRpYyBp
bnQgc2RoY2lfZXNkaGNfcnVudGltZV9yZXN1bWUoc3RydWN0IGRldmljZSAqZGV2KQ0KPiAgCQlj
cHVfbGF0ZW5jeV9xb3NfcmVtb3ZlX3JlcXVlc3QoJmlteF9kYXRhLT5wbV9xb3NfcmVxKTsNCj4g
IAlyZXR1cm4gZXJyOw0KPiAgfQ0KPiAtI2VuZGlmDQo+IA0KPiAgc3RhdGljIGNvbnN0IHN0cnVj
dCBkZXZfcG1fb3BzIHNkaGNpX2VzZGhjX3Btb3BzID0gew0KPiAtCVNFVF9TWVNURU1fU0xFRVBf
UE1fT1BTKHNkaGNpX2VzZGhjX3N1c3BlbmQsIHNkaGNpX2VzZGhjX3Jlc3VtZSkNCj4gLQlTRVRf
UlVOVElNRV9QTV9PUFMoc2RoY2lfZXNkaGNfcnVudGltZV9zdXNwZW5kLA0KPiArCVNZU1RFTV9T
TEVFUF9QTV9PUFMoc2RoY2lfZXNkaGNfc3VzcGVuZCwgc2RoY2lfZXNkaGNfcmVzdW1lKQ0KPiAr
CVJVTlRJTUVfUE1fT1BTKHNkaGNpX2VzZGhjX3J1bnRpbWVfc3VzcGVuZCwNCj4gIAkJCQlzZGhj
aV9lc2RoY19ydW50aW1lX3Jlc3VtZSwgTlVMTCkNCj4gIH07DQo+IA0KPiAtLQ0KPiAyLjM5LjUN
Cg0K
