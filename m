Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719057346F;
	Fri,  7 Mar 2025 06:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741330755; cv=fail; b=V9VnZZ8SWLPqF41z/N+kDlPaStPg18HDrDYkBFrkmHeOUik2MQSvVGUXnr6q6Hu4Ag0eyp8b3bIMb7TXzXPbVR/ki47QdAqj/whEWXisHAti/mKu9HmnK8L9k8qPKQHhkGbGjA7GH3TW2EFjNuQxuf3IWcz0qYWy2Ji3Cq2bmwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741330755; c=relaxed/simple;
	bh=mS2XNjaz47fcMU2FzuLCm+UB1zMKSXM0koEB26ph7r4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d9YtSOpMjwePTzT3kEwHqCpE1i2esktaqDk3fl6Xed4AYvRIngiljx/8VaWtNJDuwNgPq+JPd9Xoo1tMs2D96yOahnbTvzf6rYManqh6kgfQQZwV3+QQs8RtkArBWRxvH2ntxIqN4TEKs+i5wigqrTeK5b7WQCO6HXlouUvCd4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=HsNqskZw; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=g1o4oaJ9; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="HsNqskZw";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="g1o4oaJ9"
X-UUID: a9e8127afb2111efaae1fd9735fae912-20250307
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=mS2XNjaz47fcMU2FzuLCm+UB1zMKSXM0koEB26ph7r4=;
	b=HsNqskZwMdW6GwhwZizlrSAFwjmRsbx/CVWcZCLw8DZ888yJrTUf7epts0LhBcfgzbCljrpYnGPt36Sz0JrOQ4LGkKRxXUJAfyNL8REgKqgK7pfQm8Kr5wTYDgKTMSLUgOs9x7CHJPCbKRoVf6xbcH7M8TtFChgDGlatFMfYH+M=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:50422511-65b1-4d04-8e52-1646f6cb19d2,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:f6bd23ce-23b9-4c94-add0-e827a7999e28,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a9e8127afb2111efaae1fd9735fae912-20250307
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <axe.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1247594171; Fri, 07 Mar 2025 14:59:07 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 7 Mar 2025 14:59:06 +0800
Received: from HK2PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 7 Mar 2025 14:59:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VkNd35QtRbHgSb/llT49IAq4M7naT1f5SvdubxlonUqYTJ0LlHw1E+CKlBShElsj2L6o3xCgIG88DGFhkgB61aWrRJHrSIkQOmtGKKQa6g1uYLh4SCZ6XuJG2DuAFoyjUfyMkK23C6lgFv5pJKKiVkqWKjk6KMhIomFDdLiipCQlFvMOWoJvcJRRnnzYS8svxZuFGldNXfEkQ+aT3Ii1uvg7ESx8rBbBys/qHr3lPGXSCV46oLq5YLOmJLKhqFgLv0CYvoq4W0ZQcly7poPb/Tn2oyv/BkmlFrsWepbs2goeEaJ9N2ivmreJ/YYRbNeUQNiF2VLmvKcRrb6GVrt6sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mS2XNjaz47fcMU2FzuLCm+UB1zMKSXM0koEB26ph7r4=;
 b=m8EVk4FjniUYZdD8j1hlM1HRqEtvFzPAMLhzRa4AEiY897PzBdmoRfcfWK26+3eJpByhy34sowRcMM4570oWRIRh9LKdXBBFEVB2SilJgTMog5c9VSl/UchG7TQlA0juZJZFIYCBOYwmZFZlXJiOK6wCn362CyIUdEa7d8GTat+ly/otOY68M5AP1oLhu0zTBkj5v6RDth0kn0UhU0vn1cLXdTD/6z2h3Bqpa86biXSDH5zhkvOJOxIJOy85plg/LAti4d+Cor+svtzeu59UCcjDQAuDjtxIE5YYYAbjonWTdPLpqXqoGiuKG1LY6jKdjCmlzpnGqhn1I2p+HWjT4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mS2XNjaz47fcMU2FzuLCm+UB1zMKSXM0koEB26ph7r4=;
 b=g1o4oaJ99ZYgbsfqcsExupJxwypeT9tMIbfGg+zl/W4bXQFQizkmY15i9MQ7CrmISbPI+uo0Xk9MQhE9q6uV4uVw6YdshEET+dyjzBD7kLHS2kJKyV/hcCQpI66Cp4EGoPrQOmDbmdWAmKQEDnlN9GqA7tEKghbAh1DJrj8D394=
Received: from KL1PR03MB8416.apcprd03.prod.outlook.com (2603:1096:820:12c::7)
 by TYZPR03MB7675.apcprd03.prod.outlook.com (2603:1096:400:423::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Fri, 7 Mar
 2025 06:59:04 +0000
Received: from KL1PR03MB8416.apcprd03.prod.outlook.com
 ([fe80::1816:49d1:d866:bb7a]) by KL1PR03MB8416.apcprd03.prod.outlook.com
 ([fe80::1816:49d1:d866:bb7a%5]) with mapi id 15.20.8489.025; Fri, 7 Mar 2025
 06:59:03 +0000
From: =?utf-8?B?QXhlIFlhbmcgKOadqOejiik=?= <Axe.Yang@mediatek.com>
To: =?utf-8?B?V2VuYmluIE1laSAo5qKF5paH5b2sKQ==?= <Wenbin.Mei@mediatek.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	=?utf-8?B?Q2hhb3RpYW4gSmluZyAo5LqV5pyd5aSpKQ==?=
	<Chaotian.Jing@mediatek.com>, "robh@kernel.org" <robh@kernel.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "ulf.hansson@linaro.org"
	<ulf.hansson@linaro.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	=?utf-8?B?QW5keS1sZCBMdSAo5Y2i5LicKQ==?= <Andy-ld.Lu@mediatek.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	=?utf-8?B?WW9uZyBNYW8gKOavm+WLhyk=?= <yong.mao@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	=?utf-8?B?UWluZ2xpYW5nIExpICjpu47mmbTkuq4p?= <Qingliang.Li@mediatek.com>
Subject: Re: [PATCH 1/2] dt-bindings: mmc: mtk-sd: add single burst switch
Thread-Topic: [PATCH 1/2] dt-bindings: mmc: mtk-sd: add single burst switch
Thread-Index: AQHbjnTYCsmvU5APUkGIYiImQzZRM7Nl1OqAgAFq/QA=
Date: Fri, 7 Mar 2025 06:59:03 +0000
Message-ID: <f84800fac589429157cd84034ef2f4541d3486a7.camel@mediatek.com>
References: <20250306085028.5024-1-axe.yang@mediatek.com>
	 <20250306085028.5024-2-axe.yang@mediatek.com>
	 <3e84fda8-2566-4f18-8ef9-850c84789c34@collabora.com>
In-Reply-To: <3e84fda8-2566-4f18-8ef9-850c84789c34@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB8416:EE_|TYZPR03MB7675:EE_
x-ms-office365-filtering-correlation-id: e8ee338e-4415-4cb6-833d-08dd5d458bdf
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?V1dyV3VqcWkxeVZ1RVZIL0thbWdBT2tWM2lRSlM1M3NpanNsOFZXR0N3b0c1?=
 =?utf-8?B?cGY1R2lFL2hGUVFHaDNnTWNpWUFrK0Y0TlRGaXhSK1k0REV1eWxYQzVCS2pT?=
 =?utf-8?B?K25RVGtPMjNZa01kaXZjVnZLRDRSd0huSUFVRnRmZEJKNGRaUFNDYndCOFRV?=
 =?utf-8?B?TzE1NWJ6V1NPcDZDcGhOem1KajUvTk1ETXZhN2ErbzZDeTIwQU1UbEpJbHhS?=
 =?utf-8?B?Z0pZeG1ibW1DeU5NREs5aHRWS0NkMlJpRVlUWjZOS3MzVnZYKzRaejZxOE1M?=
 =?utf-8?B?MURPbUxvRGgySENIaENIcy9Pd2JnTXNrNlp3M0pQU3c2V0RnMmFBRHpnUnlm?=
 =?utf-8?B?cU9YQlRZMWpudzBqcXg2WHhTOWwzbFRqblpBR0xOZDkvNmNGelVubG9KY3lX?=
 =?utf-8?B?TEpFTkFvNCtPNHZDMVRvNHVUQTUrQ1FrWWRUZWVXTFJIbXFqcXlXTklrYjVX?=
 =?utf-8?B?YWoyVVMyd0ZuNStPdTg3SFU4QkZ1OVdTaVdnZE84cG5xNU5CajdEd1B5bFZi?=
 =?utf-8?B?WmZGTjVrZFNOV2djb2M5TEZVTUx1S0szKytXN0w0cERlTk8yaGxVQ2x6K1gy?=
 =?utf-8?B?WHFsUzNjMkFLaGVwQmhyU0VOK1FaUWU0M0Z2bW1XNnBwRGpQbkFVYnZOTDQ1?=
 =?utf-8?B?M0NWWlV2dUUyZWg4WEthbG1MSEEydlAxM3ZnR3d0c014UHNKTU4rdnY2MWxV?=
 =?utf-8?B?ZTE4ZnRVTXlScnVrK3hkTFUveGNnRG1uMnFOTDVlM2p4aFNucXJoWGtUdXh5?=
 =?utf-8?B?M01uZ0h1dmt0Vjh2aE1NNmtpOFdPMU5RNEJxQkZ1ak1qY3NGUFBEdllIUUR4?=
 =?utf-8?B?V3ZyYW9qN01ycmh3c3VWL25nRThqTFBWODFCNkJxTDFVNEdZU042SldvaTBQ?=
 =?utf-8?B?UGJTVlVSOEJEaDJYemZNYVZnaEtjdTh1N0ZUbmRGUEtYdmMwaUlqZkxpUWlk?=
 =?utf-8?B?cmJCbFhYdTV0WW5JOVVXNWhSRjBiYVF0bTJEd0dNUUhZb29vQlJvNmhqWVRB?=
 =?utf-8?B?Q3IzL0V1ME9EdGJhaGRSaHpJcm50YjhqT1BlMUFSMWFjYWNiL05aZUxHcE9F?=
 =?utf-8?B?Ym9xMUd4MFBoL0I0UElUWStXQ1JoZHdMWVVpNUo4NTlzM21SdEpVYndnaGR4?=
 =?utf-8?B?TzB2eVByQzlNbzIydEFqK09NNVJuQllVbitBWURLYS9Eb2pxdEx2OFI2NjM5?=
 =?utf-8?B?eUprL2Z1SG13akRuQzV2b2ZMTDlobC9uVjUrTkxHc0VZRlpjM1B2L0w3N1Iz?=
 =?utf-8?B?c0FjZTJxUXdFb2VjR2lBR01MeEwwL25OeWQvaWhSTVNma0RXY1NnZWtUR041?=
 =?utf-8?B?UE1SNzloQUdmRmVCWEs4ODBZTmJXZ3dheWZKbTFxbmtJd3Fpd3B5T0FqWUtn?=
 =?utf-8?B?OTgvU2d0UGtIaVN6di9SK2lzUzFmemNFWnZON1dEYzVReDRIK2twYzArT3lo?=
 =?utf-8?B?N2M0QUhkVkk0OFgzSlJyY0NPRkhjcGdiZUtBaDR5eHMwN1NIOGh2aXdTWDN3?=
 =?utf-8?B?b3pBSnBOemUrWDFxa282d3FKUUtIU09rTkpubW5wRlFVdUJkUEpzanY5c0VE?=
 =?utf-8?B?N3N6ZWFuRFRjTFhwUDh1QVRuRitibkZmMkwxRnZNT2JtdE43MUt5OEFBTFZv?=
 =?utf-8?B?c01wUEFOcE5nUWpaRy9qdSttcVNvSEdZK2phWDhKOUsrRC80NkdTRXU1bm9G?=
 =?utf-8?B?M1Jvai83dkRTbGIwZEwrQUtET3lnWFVRYWkzbjFOMmZQaFhSZEdJd1pzMVRQ?=
 =?utf-8?B?RzFISzlKNktDa0dMNExtZXpWSEVZV3hGYjc5VUF4TU5WYmp5QVR4bzNGTHAx?=
 =?utf-8?B?TmNlVjJyM3RMa3VVZmQ1dDJjRVloWmhrR05CWHFQSDI0NmZ0Zy9vUWZ2K3JC?=
 =?utf-8?B?MVdZTHU5S2V5N1diczBpNEZYVmp6NEgzSEJpUWRnLzVkQ2FxcHI3M3pzMmhV?=
 =?utf-8?Q?n35HJTYVoutfhAFdA2vv1JIcY82N15Pv?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB8416.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TkxvaDJQdDVHWGVzVHFjTXJDYTRyc1dIam1RS3Y5ZFh6Z1diNi9jUGNBbkYr?=
 =?utf-8?B?aElBTjRCeTREcVFQVzQ1ZVhYaTRuY0ZHVVE5c3F3dUpmNEQ1QUgvTkljWWd0?=
 =?utf-8?B?eCt0Z0FwbXFaa2J0bEczMHgzYnhiSzFPYTlkUDdxVWVKRU5wazJBUkpFWWJ3?=
 =?utf-8?B?cEF3Y2w4WlVvZnZMalVoeEZWQ1M0N3ZVRWlWYVFwOUt6dTExMTdZeHNvQ1o1?=
 =?utf-8?B?N3BYTlR0ZCtRRkZwN0ErTlp1Y05MRVhBU0NMUVVoQVJ3S3hBbnJGdys3cGF2?=
 =?utf-8?B?eGFHcmFRTXllSk1aRFR2VXFEeHNCYzFIZnRRQ2ZKZ1ZNZHZGT2xFSTBRcXN1?=
 =?utf-8?B?S1ZUS1p3S3E3alVJclJEejBaTTB2TkRWalNIdklMYlRVK0FCVXRQY0FkNGxm?=
 =?utf-8?B?b1daWmNiRDRIY2lzdzJuWFJUK09GQjFtTWZEeUxjV0JQV1hCNVdmeGgyQjE1?=
 =?utf-8?B?VnBBMG9NRTJWcGo2WHFxbm9vSkFtamlqS1NwaVVZMXh0bW1zVlpkd2I2VC9j?=
 =?utf-8?B?RnVsbUcxRkxlUEp0R2NzTE1ZT2hzNVZna1RVZzJycjNDeUxjNm5kaGRLbXhL?=
 =?utf-8?B?RzZZK1JyQkluSmhHNUxXcEpaRWpuQW5xK1lNVXE5QnpGM2dqQndudFBQamM5?=
 =?utf-8?B?emF3SmMrNDA3R1FENWhidVNhS0gyVXYyZm5pMHlodTYvSUFJSUY4Sm9WYXRY?=
 =?utf-8?B?UXI4a0ZlbTkzeVIwNjAwUVhWRy9lN0ZzN3dHby94QmYzTzlwcDZ0bEZsZXU0?=
 =?utf-8?B?cjQxZmw3S2FjMmdMbGtWNVhvMmpBYVUxVkFRMnl2MjZVcHkyS3lGODRZM0cv?=
 =?utf-8?B?eHhBMSt5VXJxS1Z3S25iU1VwWFN2TlFHNUhKeFBCSkV6bnNMOFB4dHNhSkpm?=
 =?utf-8?B?SUZEMVRoTE8zZnU2d0MzNHp6Zjc3ajZpUGlqZ0NTQUxuNWxVbGUrcSsyeVpo?=
 =?utf-8?B?ZnYwelBUYVF0aUUwU241cFRRWU4zUkl3c3RCTUZjei82N0plUEZlS05GUnpK?=
 =?utf-8?B?STVDR0dNcG8zZ2YwV2pkQnJ0bys2TXdsWDhpMUI0bndxdVd5cXUvOERIZjJ2?=
 =?utf-8?B?QVZBbzNSWFdKNE5GQVdZamx4NXVFMzBiT3BHUHl5WVNld1gvMWVwMWNTZ0Vv?=
 =?utf-8?B?MUxPRjVjaFJRYzMyR0FKbVlRdVFiQU5Kbzd5RU1IekF0LzdsZXdoYzdCaEU2?=
 =?utf-8?B?Nmg0QWhTQkNicWFJSWFtM0RMd0I4RXpOeHllT25CUlRjSVNqMWxQQkwvb0hu?=
 =?utf-8?B?ejBDQ0xNR08wM25TL3N6MlVjenNQUUxUOVlBVG1jdVpYY1NnZ01lei84S3I1?=
 =?utf-8?B?WDg2bmRML0FRRVJwSWE4RUlzK0hDeGtyQ0pQbzRBNDdXdk5pa2ZobnRFTDJI?=
 =?utf-8?B?cEVpVU5tS3N4bEYvcE5Oay8raTIvRUhaekQ5WEZreU9XVlRGM25RbnFpTTg3?=
 =?utf-8?B?Yytlelh6VHBzWXp1U2ZXQWlMK0I0SDZ0Qmo3ZStsclpJeFh2RlY2ZmhDem4w?=
 =?utf-8?B?NkExZnVWUURYdm40Z3NXMG1aUFhOemk1Q1RyS3RiNjRZR0NIRjJUeklMSW1n?=
 =?utf-8?B?ZWFGb21qa054K2pQTmNLUjBJSFVxTVFQcW5jQ2NtOUl1bDFOZjMzNk9ra1do?=
 =?utf-8?B?djBFZkdvMnpoUHBNSFlHYk9DMWVpcTlGb09KdjZidDJsNncvcVpqblZyNWZU?=
 =?utf-8?B?L3VOdXM2ZGxnbEZoRXdzYXUvSit5NWZQQ1hPM2pJMk5TWUQzYlZqRzdya2ps?=
 =?utf-8?B?Y3JET2Zac1FuaVNlNVlybi9Wc0FnNEd6aE9NandBY1ljWDVoU09NK0NsZ05l?=
 =?utf-8?B?VUltZjR5Y2UzMXVNeEgyaVZETG5tQUNvUDl5SUZ2UEszZEdZWjQxT2NmOFJN?=
 =?utf-8?B?Ty9LS1pXdFExU0JVc2hTaFhRU2lPelZjUGR6aGw2cTA1dEY2a0llaE16U1JW?=
 =?utf-8?B?TDZEN0dyWGpHM08rQVM5OWVIaG1mU0lQWFcwNWhQTk12eityYlJtQW9lbFV0?=
 =?utf-8?B?cnpLWUM4OEdUK0p6c0dRTU1ZQmVuY1lValZ3RkRkb1Y5cUZEbkxhdUtEWEJN?=
 =?utf-8?B?YUlTRDg4NzMvczNjWWltT08waytFbFlZRFl6dGpzUmpiN0ppdnJHTzZXeGkx?=
 =?utf-8?Q?x1JwL48FaBo7xHH+85Ej0e6Cl?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E9BE5A39CA36B54A8319BAF7E45741A9@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB8416.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8ee338e-4415-4cb6-833d-08dd5d458bdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2025 06:59:03.7051
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XnC8Y99087ZvNiGk0m1Z+fmLFW6PL3tpCN4ijLNbJ6N2ONP27mM6XUhxQpoK5z65D+XZ7+g/fUNhuWHEFX9Mag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7675
X-MTK: N

T24gVGh1LCAyMDI1LTAzLTA2IGF0IDEwOjE5ICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBJbCAwNi8wMy8yNSAwOTo0OCwgQXhlIFlhbmcg
aGEgc2NyaXR0bzoNCj4gPiBBZGQgJ21lZGlhdGVrLGRpc2FibGUtc2luZ2xlLWJ1cnN0JyBzZXR0
aW5nLiBUaGlzIHByb3BlcnR5IGNhbiBiZQ0KPiA+IHVzZWQgdG8gc3dpdGNoIGJ1cyBidXJzdCB0
eXBlLCBmcm9tIHNpbmdsZSBidXJzdCB0byBJTkNSLCB3aGljaCBpcw0KPiA+IGRldGVybWluZWQg
YnkgdGhlIGJ1cyB0eXBlIHdpdGhpbiB0aGUgSVAuIFNvbWUgdmVyc2lvbnMgb2YgdGhlIElQDQo+
ID4gYXJlIHVzaW5nIEFYSSBidXMsIHRodXMgdGhpcyBzd2l0Y2ggaXMgbmVjZXNzYXJ5IGFzICdz
aW5nbGUnIGlzIG5vdA0KPiA+IHRoZSBidXJzdCB0eXBlIHN1cHBvcnRlZCBieSB0aGUgYnVzLg0K
PiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEF4ZSBZYW5nIDxheGUueWFuZ0BtZWRpYXRlay5jb20+
DQo+IA0KPiBJIGFtIG1vc3RseSBzdXJlIHRoYXQgdGhpcyBpcyBub3Qgc29tZXRoaW5nIHRvIHB1
dCBpbiBkZXZpY2V0cmVlLCBidXQNCj4gYXMNCj4gcGxhdGZvcm0gZGF0YSBmb3Igc3BlY2lmaWMg
U29DKHMpLCBhcyBtdWNoIGFzIEknbSBtb3N0bHkgc3VyZSB0aGF0DQo+IGFsbCBvZg0KPiB0aGUg
aW5zdGFuY2VzIG9mIHRoZSBNU0RDIElQIGluIG9uZSBTb0Mgd2lsbCBiZSAqYWxsKiB1c2luZyBl
aXRoZXINCj4gc2luZ2xlDQo+IG9yIElOQ1IuDQoNCk5vLCBhY3R1YWxseSBNU0RDIElQcyBpbiBv
bmUgU29DIGFyZSB1c2luZyBkaWZmZXJlbnQgdmVyc2lvbnMuDQpVc3VhbGx5IE1TREMxIChpbmRl
eCBmcm9tIDEpIGlzIHVzZWQgYXMgZU1NQyBob3N0LCB0aGUgbGVmdCBob3N0cyBhcmUNCnVzZWQg
YXMgU0QvU0RJTyBob3N0cy4gVGhleSBoYXZlIHNpbWlsYXIgZGVzaWducywgYnV0IHRoZXJlIGFy
ZSBzdGlsbA0KZGlmZmVyZW5jZS4NCg0KPiANCj4gU28sIEkgdGhpbmsgSSBrbm93IHRoZSBhbnN3
ZXIgYnV0IEknbGwgc3RpbGwgYXNrIGp1c3QgdG8gYmUgZXh0cmVtZWx5DQo+IHN1cmU6DQo+IA0K
PiBpcyB0aGVyZSBhbnkgTWVkaWFUZWsgU29DIHRoYXQgaGFzIGRpZmZlcmVudCBJUCB2ZXJzaW9u
cyBmb3INCj4gZGlmZmVyZW50IE1TREMNCj4gaW5zdGFuY2VzLCBhbmQgdGhhdCBoZW5jZSByZXF1
aXJlIHNpbmdsZSBidXJzdCBvbiBvbmUgaW5zdGFuY2UgYW5kDQo+IElOQ1Igb24NCj4gYW5vdGhl
ciBpbnN0YW5jZT8NCg0KWWVzLiBBY3R1YWxseSBldmVyeSBTb0MgaGFzIGRpZmZlcmVudCBJUCB2
ZXJzaW9ucyBmb3IgZU1NQyBhbmQgU0QvU0RJTw0KaG9zdCBhcyBJIHNhaWQuDQplLmcuIEZvciBN
VDgxNjgsIHNpZ25lbCBidXJzdCBiaXQgc2hvdWxkIGJlIHNldCB0byAxIGZvciBlTU1DIEhvc3Qs
IGJ1dA0KMCBmb3IgU0QvU0RJTyBIb3N0Lg0KDQo+IA0KPiBBbmQgaWYgdGhlcmUgaXMgLSBpcyB0
aGVyZSBhIHBhdHRlcm4/IElzIGl0IGFsd2F5cyBTRElPIHJlcXVpcmluZw0KPiBJTkNSIG9yDQo+
IGFsd2F5cyBlTU1DL1NEIHJlcXVpcmluZyBpdD8NCj4gDQo+IA0KDQpObywgdGhlcmUgaXMgbm8g
cGF0dGVybi4gQm90aCBlTU1DIGFuZCBTRC9TRElPIGhvc3RzIG5lZWQgdG8gYmUNCmNvbmZpZ3Vy
ZWQgYmFzZSBvbiBJUCB2ZXJzaW9uLiBUaGVyZSBpcyBubyBiaW5kaW5nIHJlbGF0aW9uc2hpcCBi
ZXR3ZWVuDQplTU1DL1NEL1NESU8gYW5kIHRoZSBidXJzdCB0eXBlLiBlTU1DIGJ1cnN0IHR5cGUg
bWlnaHQgYmUgSU5DUiBvcg0Kc2luZ2xlLCBzYW1lIGFzIFNEL1NESU8uDQoNCg0KUmVnYXJkcywN
CkF4ZQ0KDQoNCj4gDQo+ID4gLS0tDQo+ID4gICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvbW1jL210ay1zZC55YW1sIHwgOCArKysrKysrKw0KPiA+ICAgMSBmaWxlIGNoYW5nZWQs
IDggaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvbW1jL210ay1zZC55YW1sDQo+ID4gYi9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvbW1jL210ay1zZC55YW1sDQo+ID4gaW5kZXggMGRlYmNjYmQ2NTE5
Li42MDc2YWZmMGE2ODkgMTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL21tYy9tdGstc2QueWFtbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9tbWMvbXRrLXNkLnlhbWwNCj4gPiBAQCAtMTAwLDYgKzEwMCwxNCBAQCBw
cm9wZXJ0aWVzOg0KPiA+ICAgICAgIG1pbmltdW06IDANCj4gPiAgICAgICBtYXhpbXVtOiAweGZm
ZmZmZmZmDQo+ID4gDQo+ID4gKyAgbWVkaWF0ZWssZGlzYWJsZS1zaW5nbGUtYnVyc3Q6DQo+ID4g
KyAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy9mbGFnDQo+ID4gKyAg
ICBkZXNjcmlwdGlvbjoNCj4gPiArICAgICAgQnVyc3QgdHlwZSBzZXR0aW5nLiBGb3Igc29tZSB2
ZXJzaW9ucyBvZiB0aGUgSVAgdGhhdCBkbyBub3QNCj4gPiB1c2UNCj4gPiArICAgICAgQUhCIGJ1
cywgdGhlIGJ1cnN0IHR5cGUgbmVlZCB0byBiZSBzd2l0Y2hlZCB0byBJTkNSLg0KPiA+ICsgICAg
ICBJZiBwcmVzZW50LCB1c2UgSU5DUiBidXJzdCB0eXBlLg0KPiA+ICsgICAgICBJZiBub3QgcHJl
c2VudCwgdXNlIHNpbmdsZSBidXJzdCB0eXBlLg0KPiA+ICsNCj4gPiAgICAgbWVkaWF0ZWssaHMy
MDAtY21kLWludC1kZWxheToNCj4gPiAgICAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9k
ZWZpbml0aW9ucy91aW50MzINCj4gPiAgICAgICBkZXNjcmlwdGlvbjoNCj4gDQo+IA0KPiANCg==
