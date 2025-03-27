Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C851E8479;
	Thu, 27 Mar 2025 02:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743043733; cv=fail; b=UvjpYB8uAYHSqtwziDagQKCcgi0UywJroN1YCLtXafJY7oeA+Ut5C+7+uguSs9qB1InbYlTr4ZfutGTYnXubabhsnssZ5OgXEUzmgpygQqGWOZ6+0ki8faCxHZS917AqZ6U8EUrjG3XpyYL0rzWhdDn7BUCvkQ2R+tiFRZdZ69c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743043733; c=relaxed/simple;
	bh=DSLujPpgOT8sbLbNFZ3TazctLQ4Y3FyeSuavrDxsupQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hvQzM/7+YPqAowmMl7gAs9oUPgCKcSJLCpPuSK7l3yjinjl8JKn5xR6Gr0bxNrMPoY/EQdwtQbt10zmwT/Dw2M4843Ivc2OH3W3Bi1pQ/k0tmT/HLSO0XRt0zn5Dkc13rBo0O/EJ4qN7iMsLE64SyhcyET3insUHvTjUrNaJn1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=PkR1+40V; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=m+1sVQKP; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="PkR1+40V";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="m+1sVQKP"
X-UUID: fede00ac0ab511f08eb9c36241bbb6fb-20250327
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=DSLujPpgOT8sbLbNFZ3TazctLQ4Y3FyeSuavrDxsupQ=;
	b=PkR1+40VLPsBejOX30yZQJPTjjBUZVjPSkFbb9BNA92Mzg+ZlbhFglAbazljfY8ah6YNJkuUmTQ95L+5w+Gtqhp2lGoXev12O2ijDZr8qad34YssXo90gub87RUmF9+UXPoMBo6DLkfM0aYn2xVX6+JGtbHKNllG6e8STT/uZH8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:2a372d84-14eb-4e3b-8ad9-28b67131a8e8,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:b1edd8c6-16da-468a-87f7-8ca8d6b3b9f7,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:nil,Conte
	nt:0|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: fede00ac0ab511f08eb9c36241bbb6fb-20250327
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <axe.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 467516313; Thu, 27 Mar 2025 10:48:42 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Thu, 27 Mar 2025 10:48:41 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Thu, 27 Mar 2025 10:48:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=okszRz21/59Be3Sj8mkxT2tjcLrQq6pfJeKhN3smRd51VO5SVnE7hpYw/LqE3r4nAUvKvCcEPTb1KhkCqWDEhX7j3BWG1hLWpnEmTzJEvOnBH7qjLRcMb/5OnKKdcil9Spzqc4pZNrntr5VCIwiRtW7cOkVxIMkojPCfAH+LPmUgz+zrBDZa7DzmhNfezg7nLgmnJauwFqHUEQD51jKEcMPcF+iszggidZweSpoJPwAact3i+Gn3KnBbzXL4jiA/BumKRA1ORfnDdv7FoRuGI5cEybjJcyfBZ2CsEYDHw6poWAjEp67AXvZzdkAcA8U8N3U7AakMVkcAggOYkd72Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DSLujPpgOT8sbLbNFZ3TazctLQ4Y3FyeSuavrDxsupQ=;
 b=n+Jfksp6SWW414SDENhk3rebJlGfbX5jjC8btLiMnetSai+j8CdERrkqt84o8O/0ZdtlIV6qAePpI0H/aog185Xm4fXka6zxlmN2xG+5b23GyipC1P7eyXEyqBG3HCowyZW63vfIduhoVemFakjBnDzmaqFMolBXlAle+v9r9oY1sh5PToSRaN/4Hd+6cLwCWjbTic+qegPN8+yRtSxdV8FvUUs6aBaEvPdxZ8waIfW13XR7sodtPSDHdn9/xWde550DhQMD3B6uF0TVrtSooFHrL5s5ah31jSpQVsFfKBc7aw+eNNbq2sfCJKQ1dfJrldUHm7bLqM2X/QWlyMSIUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DSLujPpgOT8sbLbNFZ3TazctLQ4Y3FyeSuavrDxsupQ=;
 b=m+1sVQKP7smq38HEDuIx42cazTitis6TFTPYE5SMkI1RaY43HU67YDsn31owCnHDrEytkF8Fs4ZKFNXjj3ujy6xYyv7zQsrI4ijWqDosY8b2N9Ooh8Gv35X40MBzaqkpBAgmRQMxpj/19h2gcLxwTAfTdFXkbwVoWSQ2VgbmmvQ=
Received: from KL1PR03MB8416.apcprd03.prod.outlook.com (2603:1096:820:12c::7)
 by TYZPR03MB6576.apcprd03.prod.outlook.com (2603:1096:400:1fd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.27; Thu, 27 Mar
 2025 02:48:38 +0000
Received: from KL1PR03MB8416.apcprd03.prod.outlook.com
 ([fe80::1816:49d1:d866:bb7a]) by KL1PR03MB8416.apcprd03.prod.outlook.com
 ([fe80::1816:49d1:d866:bb7a%5]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 02:48:37 +0000
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
Thread-Index: AQHbjnTYCsmvU5APUkGIYiImQzZRM7Nl1OqAgAFq/QCABnhcgIABW0IAgBQuXoCAAIBaAIACplIA
Date: Thu, 27 Mar 2025 02:48:37 +0000
Message-ID: <8958413b4138d815d582927f7702b35ffc20f122.camel@mediatek.com>
References: <20250306085028.5024-1-axe.yang@mediatek.com>
	 <20250306085028.5024-2-axe.yang@mediatek.com>
	 <3e84fda8-2566-4f18-8ef9-850c84789c34@collabora.com>
	 <f84800fac589429157cd84034ef2f4541d3486a7.camel@mediatek.com>
	 <b09f618a-eaf9-4258-ae2d-67eff1cb249f@collabora.com>
	 <f8ce830d831aaba0d2748d31f8ba4a9915b7a14e.camel@mediatek.com>
	 <52d2f247a3058b96625bcdf5ab370282dfc9fb0e.camel@mediatek.com>
	 <3572d6e2-8950-4937-bed5-624bf5bde7f3@collabora.com>
In-Reply-To: <3572d6e2-8950-4937-bed5-624bf5bde7f3@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB8416:EE_|TYZPR03MB6576:EE_
x-ms-office365-filtering-correlation-id: fd143b10-5084-4a87-a39e-08dd6cd9dfec
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?OEFMdnJvM0VLckk4eHBzcmxXQ21wNElCeW9vUVl1ZU9uYXN2eEcwM1hTMjQ4?=
 =?utf-8?B?VVNaMVFoZUgzSVNwdTdFOXd0UDRZQk5vVjBGTmc2UjkyU2hSVWJyalR3ZXZ1?=
 =?utf-8?B?RDQveTlNQ003YUI3WisrdURxYkI2a0Q2OVpkdE44aCs2bnZIZWE1cWFLekt6?=
 =?utf-8?B?QnVQMzlTWitoV2djejhoajIxcHYxZ05CNm1BQk5vWTgxMUZYZFhTMHFadjVR?=
 =?utf-8?B?Rkl2am1ubk9tcXdEL2RyZ045WGM0anpvTDhIRHFlamtSMWRtTTE1SjExMU5u?=
 =?utf-8?B?WXQ2d1RNWktCRVUwVTE1dk1LaWR2SldlSnlLVU9vR1FLTUZYN0RtaFNPRkl4?=
 =?utf-8?B?amYzSE9wYW9ESVEyeFZCZU9LMHZNOXpYWm03RE4rbGkyQ2hCZkpQcTVjOVRr?=
 =?utf-8?B?OWdjSDRvWi9DK2tvL0UvazV3STkwMzF2SEp2MnZSMU5PMkxSenNrUWw2ZndZ?=
 =?utf-8?B?SG9EU0JmUStGTGxrdUhLSG1UbE5mL3BIVjJYTlpXdU1SSnk0QmtkZ2IvVmZz?=
 =?utf-8?B?ZXRoQVplM1BUS3dkMm9CVDFrN3RWdk1BaUEyRVZVNHk0ZHJnS0p0M3RQUERu?=
 =?utf-8?B?czl0WmFXR2JxbG56SjNTTnU4cU1LWDk2ekxxdDhHdEYzOEpHZjRWWGI2N2tm?=
 =?utf-8?B?M002U0JVbjFzK2l6ajJ6MjEzeVgrMTJIdm1xanIvcVJadFhUWDkvVFJUd2tI?=
 =?utf-8?B?WXJSVmtuazJMU1hOYWR4bWZHb25tdHUrTnloNnQxNnpzcStpelpOMWpqYms3?=
 =?utf-8?B?RjRLbFFYeWRiUmpOelA0Z0ZkOExtaEJBTE1GK1pFTWYzNW0zODI5TWFCNVBB?=
 =?utf-8?B?MTd2R0phSy96cSs3NXFJMHBML3pvZDVvdUh6bzU1aGhYUDJZZkVvUkxUVjJ6?=
 =?utf-8?B?MS9nWHdSN3BLbGlsTld6QlJHZTlzZVdLckU4cXZmWXl5K0phZ3hlaEhWL1Ex?=
 =?utf-8?B?akp4d3M5N0FuVVg5ZFJDTmNkWnpGa2hBZUJnZktCZnowR3dZZ1BMd1FHeitS?=
 =?utf-8?B?V3lSeVIyU1VPU3pwd3Z6NVJkUDloTDlzZnNPY2x5U2grWkI4WWk0d1kvZXZy?=
 =?utf-8?B?Q2dGNmt2a25IeTdza2o0K1hOTHIwZGRWMXh5SGIxRmhwL0tvV2c0YUV3R2Yx?=
 =?utf-8?B?ekVpek9ZWTE4UHVtM0dISHNxS2JTdUptZmdQNVpnTnd4L09ZT2lmWnpuNVdF?=
 =?utf-8?B?cnp3TXhRM3dtN1hSS2w4cGl5dm9wSWlncTd0aDQ4OWNHMDJYazdZN20vUStw?=
 =?utf-8?B?SGgvNUk5d3l6cW9lSnR4ZHJtOUdkbG5BUjVkR3YyeVpyem1qQ25ZbE1lcm5W?=
 =?utf-8?B?SThYdVg3UTNFRzNaK05rL0JZUzMxeDNPcTQ2Z2E4L3ZjQSsvVjJlcXRJQ2lG?=
 =?utf-8?B?aFFmNDhDRS9pbDExMDVJcVhyU2grVTZmN3BNNjMxbEFYUXVMdTlNUUtlL0lw?=
 =?utf-8?B?Z1BKYVRaeHI1eElFb1FHY2xsejNJZVVtRGZTRnUyM3RUd2tSWGlaTGVESEkx?=
 =?utf-8?B?YmpYUlpRZTBMWmNVRmpBekVaeEhqakE5ZURoYnNtZ3Uybk14NTgwWHgrbjh3?=
 =?utf-8?B?UGdzcVB4VU56VitEYXhqamlYa3M0Sm1pOHlxRXJVcitlV2lpY1JpcFU2Ym42?=
 =?utf-8?B?UVEzbFRIYjdxa3lkS2t1VWpsd1Q3eklaSzg0bkZheEFBVW9oQnVRd2EyYWN2?=
 =?utf-8?B?d0dEUnBrcXM4MEZaRTRvMlpPVVZrajJlUGIzSnN3NEZYdXljVk0vQ2ljTGxH?=
 =?utf-8?B?elBla2g5WklsNHFpL3M1a0hZU2VFa2o3Vi9pTTJ4V1pwZ3Bxb2hHN3lqQ0dv?=
 =?utf-8?B?TmtkZU9HUDNON2hONVIxTDFoRWthOHRpTzBqeGFKSENVaTlWSjRya2xoK1Qy?=
 =?utf-8?B?NWFHR1hjRllJN1NReXV4MklxcmJKYjRkb3hjSHpaYkJ4MGhKVGJQUTJ5K0d4?=
 =?utf-8?B?b1g2aVpnK3ZSTGQ3aEFObXE3Ym5wVndoTm9LVzU3ZDZ3QjRVZUhQT0JmT2VT?=
 =?utf-8?B?MG5zeWo3MStnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB8416.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OGRyU1hpZGZrTWs5QnczYTREU0NMYUsvUzZxTnhxcG83Q0JaSGg1Z3VXYUVJ?=
 =?utf-8?B?eVRobjc4WU1zbmFza3M1bkFXa2tRcFIzUk9JRmVBNTFxcUZoNjVpd2Z4cTdu?=
 =?utf-8?B?S1dDeGR5SUxmNkVHeHEvNFE3SWhNOFJpcDhFYUNMQjJrME1hMU5rU2tSQmVN?=
 =?utf-8?B?bWhhVXJRTitVdlJyMU1pVFovcmQ1R3FMRE9ydE5sb01KR3VPQTBMUm1DZEsz?=
 =?utf-8?B?eVJYWENWaThrK0lOQWZXQk81K2pUQ1RRZFZ1Q09ITmNaYWpYUVFLR3FtUmc3?=
 =?utf-8?B?U0NyUm5GalpaRnVYR2VlZXlaTzlSb1RyNUs1enBCM1FUbHVtQmRiS3MzZUpo?=
 =?utf-8?B?akpvR2ZFS0RRbE9HNHlmQUhBSG13NU5rWVRGTERjSk5yakpONGtPbCtzUGNL?=
 =?utf-8?B?MFRjdE9oVWk5RmtoVlBxVS9sSzc0T24wV2xHSDMvQUJrQW9FblN1SUtMcHZx?=
 =?utf-8?B?cEovTEFEUlBtaE04bWZSdFhEY0R6NjlkWnlBMklhRlM2V1dPYzNMeXFlNENx?=
 =?utf-8?B?ajFRNzJNMCtVQ1dEUlg1QVpDREVrWmxnTXFXN3preWk0ZDcyb2VUKytuUlJL?=
 =?utf-8?B?UDJuV3VBbm1mTDc2VWs1RGE1Z0tOYnVIbHMyVFQ0RFBDZkd4UVVGRFA2S0Jl?=
 =?utf-8?B?TXRCQzdFNUhqaUR1b3NDVzQxS3dhVkdSa0ZPMHdBYjMrTUxyeWV3TmJNbEhm?=
 =?utf-8?B?a2wvQmJjdDVwN0Z2NVRvZXhzcFhOOVZ3MGdIUFhYTlhyM3k5NVkwZkJQaHE3?=
 =?utf-8?B?WUJyRjAzSURrcmU2VmhRNlorTTY4dFE2RkJ0WTIvN0YxNHlGUmRVREdLblhv?=
 =?utf-8?B?Rm5vb0lxSExWTnRNOXc3TnlpUG1tWE9sSzE0ZjE4QzU2QjRaQ2wwZWYyODNV?=
 =?utf-8?B?ZW1scmxRcUx1L1hzLzZUNlo1MTk4U2M0WjNJenJhbHJHTHFqWENOUXUrYkty?=
 =?utf-8?B?Nzd5Z2JLekdETDdDazYra2J5WGNsZjFrdng4K0RRSDErNGZIc1FVTFRZaGht?=
 =?utf-8?B?WFlGa01wUkVkd1ErNk1GOGFzUlhrU2hRbTFJWnFOcFdUQWxTMkxpQWxHb0Vp?=
 =?utf-8?B?U3VabUFDRmpzTWxPRjFWRnEwdmNXclJwZXVMMG02TzQvSnkvZlVRYk1ybkh1?=
 =?utf-8?B?Y3RKMVZOOTVLaFdGK0hodXJHWndWaGpyNmE0UWlVZjc5T1VzS2dLVHVqTlNr?=
 =?utf-8?B?YmU4YVJSRnZjTEZWUkxyN2lIcm52WTArMDlDNVdrNzN0YjI0dllJeTd3b2FK?=
 =?utf-8?B?V1YycDZ4YjA1NXc1azFERmYvRUhPYng4Sm44SEtRdDI3SFR0Sm41T1lkeHBP?=
 =?utf-8?B?YzJ3NmZZSFljNGNNclllakJ5Q3N0b0k4RWE3TytxNy9tUm1RZWIrSldEb0li?=
 =?utf-8?B?VFYxSjk4M2RuU1drOVcrekQ3ZWZ1akpFbUpZdFRNb0txQldPR0RnMXFVTWIx?=
 =?utf-8?B?K0lvV1ZnVXE1SHZ1aUQ0M00wTGFubkNqLzFYUENjVU8vVFVkc3ZPR3N0K3R3?=
 =?utf-8?B?bUloSjhNMVlCYTZUYVNlNEpiRUd6aHpRWUxoOUhYTXBGbDNwOUpEUjc1bmlZ?=
 =?utf-8?B?YW54UDJ1NUhPYlBITTl0RHRHanBaWmlpZGNOVUZUZ2gyZ3ZsN2ppaW9QNE9C?=
 =?utf-8?B?WlR1S0pSR1VsTzkxNGQ1QUZTNXU0ZXA2MU9UYTFwMkdWUnV5WnFkS0xSMk50?=
 =?utf-8?B?aWlOT0xIZ2xlSkU2dmxqNmlTeU5tK0lkZTNsR1FWOFVZWDBUSTkxUHY5RkpB?=
 =?utf-8?B?czBkR1dUaVJlNCtEbVZrelZkREtpRXhWNGRER2F2Q0dnNlY1d3BtUGZ3WUNM?=
 =?utf-8?B?eFJxc3BodjRldklMc0VYQ0JrMjN5cDMrNmxKNXRIUXFNNWNKRlIzaEpxQU5G?=
 =?utf-8?B?Q0JCL3F3aVZYVXUvYlJOajdKTGVwQVphYk1CaDBpYVllS0xTZ3FuRjdKK2dZ?=
 =?utf-8?B?SS9KZjZ1aWx6L1cyaFAwK1IvWjRtU2Z0OUlBUnU1N0ZydERYQmlPK2R5bm9C?=
 =?utf-8?B?TVZKMTZ3UnVjY0ZpNE1mVGgyK0NZYk1OaU1iZnhrWkFpVjV1WjUwd1FxcEox?=
 =?utf-8?B?OElqU3lPbUt5T0FWSDE5L1lWWFk2OHo0U0o2b1pXc2h2ZFc0NlpEZGpNTjgw?=
 =?utf-8?Q?2tNSU6+mReBGvJZIi/dt8Whl7?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CB2ED44AF0F7A44FA52EE899BE45D486@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB8416.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd143b10-5084-4a87-a39e-08dd6cd9dfec
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2025 02:48:37.6951
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +fjdnTq59tO+lsflRFCZnAZIzwjI4kUXy8Lx4fck5aOfbB+aLVaWGeIaWJSGALVQgo1ZfLQq13zH9/PFvgu5/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6576
X-MTK: N

T24gVHVlLCAyMDI1LTAzLTI1IGF0IDExOjIwICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBJbCAyNS8wMy8yNSAwMzo0MSwgQXhlIFlhbmcg
KOadqOejiikgaGEgc2NyaXR0bzoNCj4gPiBIaSBBbmdlbG8sDQo+ID4gDQo+ID4gQW55IGNvbW1l
bnQgb24gdGhpcyA6RA0KPiA+IA0KPiANCj4gQ2hlY2sgaW5saW5lIHJlcGx5IGJlbG93Li4uLg0K
PiANCj4gPiBSZWdhcmRzLA0KPiA+IEF4ZQ0KPiA+IA0KPiA+IE9uIFdlZCwgMjAyNS0wMy0xMiBh
dCAxNDozMCArMDgwMCwgYXhlLnlhbmcgd3JvdGU6DQo+ID4gPiBPbiBUdWUsIDIwMjUtMDMtMTEg
YXQgMTA6NDcgKzAxMDAsIEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vDQo+ID4gPiB3cm90ZToN
Cj4gPiA+ID4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9w
ZW4gYXR0YWNobWVudHMNCj4gPiA+ID4gdW50aWwNCj4gPiA+ID4geW91IGhhdmUgdmVyaWZpZWQg
dGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiBJ
bCAwNy8wMy8yNSAwNzo1OSwgQXhlIFlhbmcgKOadqOejiikgaGEgc2NyaXR0bzoNCj4gPiA+ID4g
PiBPbiBUaHUsIDIwMjUtMDMtMDYgYXQgMTA6MTkgKzAxMDAsIEFuZ2Vsb0dpb2FjY2hpbm8gRGVs
IFJlZ25vDQo+ID4gPiA+ID4gd3JvdGU6DQo+ID4gPiA+ID4gPiBFeHRlcm5hbCBlbWFpbCA6IFBs
ZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Blbg0KPiA+ID4gPiA+ID4gYXR0YWNobWVudHMN
Cj4gPiA+ID4gPiA+IHVudGlsDQo+ID4gPiA+ID4gPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2Vu
ZGVyIG9yIHRoZSBjb250ZW50Lg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4g
PiA+IElsIDA2LzAzLzI1IDA5OjQ4LCBBeGUgWWFuZyBoYSBzY3JpdHRvOg0KPiA+ID4gPiA+ID4g
PiBBZGQgJ21lZGlhdGVrLGRpc2FibGUtc2luZ2xlLWJ1cnN0JyBzZXR0aW5nLiBUaGlzDQo+ID4g
PiA+ID4gPiA+IHByb3BlcnR5DQo+ID4gPiA+ID4gPiA+IGNhbg0KPiA+ID4gPiA+ID4gPiBiZQ0K
PiA+ID4gPiA+ID4gPiB1c2VkIHRvIHN3aXRjaCBidXMgYnVyc3QgdHlwZSwgZnJvbSBzaW5nbGUg
YnVyc3QgdG8gSU5DUiwNCj4gPiA+ID4gPiA+ID4gd2hpY2gNCj4gPiA+ID4gPiA+ID4gaXMNCj4g
PiA+ID4gPiA+ID4gZGV0ZXJtaW5lZCBieSB0aGUgYnVzIHR5cGUgd2l0aGluIHRoZSBJUC4gU29t
ZSB2ZXJzaW9ucw0KPiA+ID4gPiA+ID4gPiBvZg0KPiA+ID4gPiA+ID4gPiB0aGUNCj4gPiA+ID4g
PiA+ID4gSVANCj4gPiA+ID4gPiA+ID4gYXJlIHVzaW5nIEFYSSBidXMsIHRodXMgdGhpcyBzd2l0
Y2ggaXMgbmVjZXNzYXJ5IGFzDQo+ID4gPiA+ID4gPiA+ICdzaW5nbGUnDQo+ID4gPiA+ID4gPiA+
IGlzDQo+ID4gPiA+ID4gPiA+IG5vdA0KPiA+ID4gPiA+ID4gPiB0aGUgYnVyc3QgdHlwZSBzdXBw
b3J0ZWQgYnkgdGhlIGJ1cy4NCj4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+IFNpZ25lZC1v
ZmYtYnk6IEF4ZSBZYW5nIDxheGUueWFuZ0BtZWRpYXRlay5jb20+DQo+ID4gPiA+ID4gPiANCj4g
PiA+ID4gPiA+IEkgYW0gbW9zdGx5IHN1cmUgdGhhdCB0aGlzIGlzIG5vdCBzb21ldGhpbmcgdG8g
cHV0IGluDQo+ID4gPiA+ID4gPiBkZXZpY2V0cmVlLA0KPiA+ID4gPiA+ID4gYnV0DQo+ID4gPiA+
ID4gPiBhcw0KPiA+ID4gPiA+ID4gcGxhdGZvcm0gZGF0YSBmb3Igc3BlY2lmaWMgU29DKHMpLCBh
cyBtdWNoIGFzIEknbSBtb3N0bHkNCj4gPiA+ID4gPiA+IHN1cmUNCj4gPiA+ID4gPiA+IHRoYXQN
Cj4gPiA+ID4gPiA+IGFsbCBvZg0KPiA+ID4gPiA+ID4gdGhlIGluc3RhbmNlcyBvZiB0aGUgTVNE
QyBJUCBpbiBvbmUgU29DIHdpbGwgYmUgKmFsbCogdXNpbmcNCj4gPiA+ID4gPiA+IGVpdGhlcg0K
PiA+ID4gPiA+ID4gc2luZ2xlDQo+ID4gPiA+ID4gPiBvciBJTkNSLg0KPiA+ID4gPiA+IA0KPiA+
ID4gPiA+IE5vLCBhY3R1YWxseSBNU0RDIElQcyBpbiBvbmUgU29DIGFyZSB1c2luZyBkaWZmZXJl
bnQNCj4gPiA+ID4gPiB2ZXJzaW9ucy4NCj4gPiA+ID4gPiBVc3VhbGx5IE1TREMxIChpbmRleCBm
cm9tIDEpIGlzIHVzZWQgYXMgZU1NQyBob3N0LCB0aGUgbGVmdA0KPiA+ID4gPiA+IGhvc3RzDQo+
ID4gPiA+ID4gYXJlDQo+ID4gPiA+ID4gdXNlZCBhcyBTRC9TRElPIGhvc3RzLiBUaGV5IGhhdmUg
c2ltaWxhciBkZXNpZ25zLCBidXQgdGhlcmUNCj4gPiA+ID4gPiBhcmUNCj4gPiA+ID4gPiBzdGls
bA0KPiA+ID4gPiA+IGRpZmZlcmVuY2UuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiANCj4gPiA+
ID4gPiA+IFNvLCBJIHRoaW5rIEkga25vdyB0aGUgYW5zd2VyIGJ1dCBJJ2xsIHN0aWxsIGFzayBq
dXN0IHRvIGJlDQo+ID4gPiA+ID4gPiBleHRyZW1lbHkNCj4gPiA+ID4gPiA+IHN1cmU6DQo+ID4g
PiA+ID4gPiANCj4gPiA+ID4gPiA+IGlzIHRoZXJlIGFueSBNZWRpYVRlayBTb0MgdGhhdCBoYXMg
ZGlmZmVyZW50IElQIHZlcnNpb25zDQo+ID4gPiA+ID4gPiBmb3INCj4gPiA+ID4gPiA+IGRpZmZl
cmVudCBNU0RDDQo+ID4gPiA+ID4gPiBpbnN0YW5jZXMsIGFuZCB0aGF0IGhlbmNlIHJlcXVpcmUg
c2luZ2xlIGJ1cnN0IG9uIG9uZQ0KPiA+ID4gPiA+ID4gaW5zdGFuY2UNCj4gPiA+ID4gPiA+IGFu
ZA0KPiA+ID4gPiA+ID4gSU5DUiBvbg0KPiA+ID4gPiA+ID4gYW5vdGhlciBpbnN0YW5jZT8NCj4g
PiA+ID4gPiANCj4gPiA+ID4gPiBZZXMuIEFjdHVhbGx5IGV2ZXJ5IFNvQyBoYXMgZGlmZmVyZW50
IElQIHZlcnNpb25zIGZvciBlTU1DDQo+ID4gPiA+ID4gYW5kDQo+ID4gPiA+ID4gU0QvU0RJTw0K
PiA+ID4gPiA+IGhvc3QgYXMgSSBzYWlkLg0KPiA+ID4gPiA+IGUuZy4gRm9yIE1UODE2OCwgc2ln
bmVsIGJ1cnN0IGJpdCBzaG91bGQgYmUgc2V0IHRvIDEgZm9yIGVNTUMNCj4gPiA+ID4gPiBIb3N0
LA0KPiA+ID4gPiA+IGJ1dA0KPiA+ID4gPiA+IDAgZm9yIFNEL1NESU8gSG9zdC4NCj4gPiA+ID4g
PiANCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gQW5kIGlmIHRoZXJlIGlzIC0gaXMgdGhlcmUg
YSBwYXR0ZXJuPyBJcyBpdCBhbHdheXMgU0RJTw0KPiA+ID4gPiA+ID4gcmVxdWlyaW5nDQo+ID4g
PiA+ID4gPiBJTkNSIG9yDQo+ID4gPiA+ID4gPiBhbHdheXMgZU1NQy9TRCByZXF1aXJpbmcgaXQ/
DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IE5vLCB0
aGVyZSBpcyBubyBwYXR0ZXJuLiBCb3RoIGVNTUMgYW5kIFNEL1NESU8gaG9zdHMgbmVlZCB0bw0K
PiA+ID4gPiA+IGJlDQo+ID4gPiA+ID4gY29uZmlndXJlZCBiYXNlIG9uIElQIHZlcnNpb24uIFRo
ZXJlIGlzIG5vIGJpbmRpbmcNCj4gPiA+ID4gPiByZWxhdGlvbnNoaXANCj4gPiA+ID4gPiBiZXR3
ZWVuDQo+ID4gPiA+ID4gZU1NQy9TRC9TRElPIGFuZCB0aGUgYnVyc3QgdHlwZS4gZU1NQyBidXJz
dCB0eXBlIG1pZ2h0IGJlDQo+ID4gPiA+ID4gSU5DUiBvcg0KPiA+ID4gPiA+IHNpbmdsZSwgc2Ft
ZSBhcyBTRC9TRElPLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gT2theSBidXQgaWYg
dGhlcmUgYXJlIGRpZmZlcmVudCBJUCB2ZXJzaW9ucywgYW5kIEFYSS9BSEIgaXMNCj4gPiA+ID4g
ZGV0ZXJtaW5lZA0KPiA+ID4gPiBieSB0aGUgSVAgdmVyc2lvbiwgd2h5IGFyZW4ndCB5b3UgcGFy
c2luZyB0aGUgTUFJTl9WRVIvRUNPX1ZFUg0KPiA+ID4gPiByZWdpc3RlcnMgb2YNCj4gPiA+ID4g
dGhlIE1TREMgSVAgdG8gY2hlY2sgd2hldGhlciB0byB1c2UgSU5DUiBvciBTSU5HTEU/DQo+ID4g
PiANCj4gPiA+IA0KPiA+ID4gVG8gYWRkcmVzcyB5b3VyIGNvbmNlcm5zLCBJIGhhZCBmdXJ0aGVy
IGRpc2N1c3Npb25zIHdpdGggdGhlDQo+ID4gPiBkZXNpZ25lci4NCj4gPiA+IFRoZWlyIHJlc3Bv
bnNlIHdhcyB0aGF0IHRoZSBidXMgdHlwZSBhbmQgSVAgdmVyc2lvbiBhcmUgbm90IGJvdW5kDQo+
ID4gPiB0b2dldGhlci4gVGhpcyBjb250cmFkaWN0cyBteSBwcmV2aW91cyBzdGF0ZW1lbnRzLCBh
bmQgSQ0KPiA+ID4gYXBvbG9naXplDQo+ID4gPiBmb3INCj4gPiA+IHRoYXQuDQo+ID4gPiBBY2Nv
cmRpbmcgdG8gdGhlIGRlc2lnbmVyJ3MgZmVlZGJhY2ssIEkgbXVzdCBzYXkgdGhhdCB0aGUgc2lu
Z2xlDQo+ID4gPiBidXJzdA0KPiA+ID4gc2V0dGluZyBpcyBpbmRlZWQgdGllZCB0byB0aGUgSUMs
IGJ1dCB0aGUgZ3JhbnVsYXJpdHkgaXMgc3VjaA0KPiA+ID4gdGhhdCBpdA0KPiA+ID4gbmVlZHMg
dG8gYmUgc2V0IGluZGl2aWR1YWxseSBmb3IgZWFjaCBob3N0Lg0KPiA+ID4gR2l2ZW4gdGhlIGxh
cmdlIG51bWJlciBvZiBJQ3MgTWVkaWF0ZWsgY3VycmVudGx5IGhhcywgYWRkaW5nDQo+ID4gPiBi
dXJzdA0KPiA+ID4gdHlwZQ0KPiA+ID4gaW5mb3JtYXRpb24gZm9yIGVhY2ggaG9zdCB0byB0aGUg
ZHJpdmVyJ3MgY29tcGF0aWJsZSBzdHJ1Y3R1cmUNCj4gPiA+IHdvdWxkDQo+ID4gPiBtZWFuIGFk
ZGluZyBodW5kcmVkcyhtYXliZSB0aG91c2FuZHMgOigpIG9mIGxpbmVzIHRvIHRoZSBkcml2ZXIN
Cj4gPiA+IGZvcg0KPiA+ID4gdGhlDQo+ID4gPiBjb21wYXRpYmxlIHN0cnVjdHVyZXMgZm9yICph
bGwgcHJldmlvdXMgU29DcyogKGN1cnJlbnRseSB0aGVyZQ0KPiA+ID4gYXJlDQo+ID4gPiBvbmx5
DQo+ID4gPiAxMyBjb21wYXRpYmxlIHN0cnVjdHVyZXMsIGFuZCB0aGV5IGNhbiBiZSByZXVzZSBi
eSBuZXcgU29DKS4gVGhpcw0KPiA+ID4gYXBwcm9hY2ggc2VlbXMgdmVyeSBjdW1iZXJzb21lLg0K
PiA+ID4gDQo+ID4gPiBTbyBJIHN0aWxsIGJlbGlldmUgdGhhdCBwbGFjaW5nIHRoaXMgc2V0dGlu
ZyBpbiB0aGUgRFRTIGlzIGEgbW9yZQ0KPiA+ID4gYXBwcm9wcmlhdGUgYXBwcm9hY2guDQo+ID4g
PiANCj4gDQo+IEhlbGxvIEF4ZSwNCj4gDQo+IHNvcnJ5IGZvciB0aGUgd2FpdCAtIHRoaXMgZW1h
aWwgZmVsbCB0aHJvdWdoIHRoZSBjcmFja3MgYW5kIEkgZGlkbid0DQo+IHNlZQ0KPiBpdCBhdCBh
bGwsIHNvIHRoYW5rIHlvdSBmb3IgdGhlIHBpbmcuDQo+IA0KPiBVbmZvcnR1bmF0ZWx5LCBJIGRv
bid0IHRoaW5rIHRoYXQgdGhpcyB3b3VsZCBiZSBhY2NlcHRhYmxlIGZyb20gYQ0KPiBkZXZpY2V0
cmVlIGFuZC9vcg0KPiBiaW5kaW5ncyBzdGFuZHBvaW50LCBidXQgdGhlbiB5b3UgZG9uJ3QgcmVh
bGx5IG5lZWQgdG8gbW9kaWZ5IHRoZQ0KPiBwZGF0YSBmb3IgYWxsIG9mDQo+IHRoZSBjdXJyZW50
bHkgc3VwcG9ydGVkIFNvQ3MgdG8gZGVjbGFyZSBmYWxzZSwgYXMgZmFsc2U9PTAsIHdoaWNoIGlz
DQo+IHRoZSBkZWZhdWx0Lg0KPiANCj4gQnV0IG1heWJlIHRoZXJlJ3MgYW5vdGhlciB3YXkgb3V0
IG9mIHRoaXMuDQo+IA0KPiBZb3Ugc2FpZCB0aGF0IHRoaXMgbW9kaWZpY2F0aW9uIGlzIGRvbmUg
YmVjYXVzZSBzb21lIGNvbnRyb2xsZXJzIGFyZQ0KPiB1bmRlciBBWEkgYW5kDQo+IHNvbWUgb3Ro
ZXJzIGFyZSB1bmRlciBBSEIuLi4gSSB3YXMgZG9pbmcgc29tZSBjbGVhbnVwcyB0byB0aGlzIGRy
aXZlcg0KPiBhbmQgZG9pbmcgc28NCj4gbWFkZSBtZSBjaGVjayBhIGNvdXBsZSBvZiB0aGluZ3Mu
Li4uDQo+IA0KPiBXaGVuIGEgTVNEQyBjb250cm9sbGVyIGlzIHVuZGVyIEFYSSwgdGhlcmUgd2ls
bCBiZSBjb25maWd1cmF0aW9uIGZvcg0KPiB0aGF0IGluIG90aGVyDQo+IHJlZ2lzdGVycyAtIHNw
ZWNpZmljYWxseSwgSSdtIHdvbmRlcmluZyBpZiB0aGUgRU1NQzUwX0NGRzIgcmVnaXN0ZXINCj4g
Y2FuIGJlIHVzZWQgdG8NCj4gY2hlY2sgaWYgd2UgYXJlIHVuZGVyIGFuIEFIQiB0byBBWEkgd3Jh
cHBlciBvciBub3QuDQo+IA0KPiBUaGUgaWRlYSBpcyB0byByZWFkIHRoaXMgcmVnaXN0ZXIgKG9m
ZnNldCAweDIxYyksIFsyNzoyNF0gQVhJX1NFVF9MRU4NCj4gY29udGFpbnMgdGhlDQo+IG51bWJl
ciBvZiBiZWF0cyBwZXIgYnVyc3QgKGZyb20gMSB0byAxNiksIGFuZCBhbHNvIFsyMzoxOV0NCj4g
QVhJX1JYX09VVFNUQU5ESU5HX05VTQ0KPiBjb250YWlucyB0aGUgbnVtYmVyIG9mIG91dHN0YW5k
aW5nIHRyYW5zZmVycyAoMSB0byAxMykuDQo+IA0KPiBJZiBhIGNvbnRyb2xsZXIgZG9lcyBub3Qg
aGF2ZSBhbiBBWEkyQUhCIFdyYXBwZXIsIG9yIGlmIGl0IGRvZXMgbm90DQo+IHVzZSB0aGUgQVhJ
IGJ1cw0KPiB0aGlzIHJlZ2lzdGVyIHNob3VsZCByZWFkIHplcm8gSSB0aGluaz8NCj4gDQo+IEVz
cGVjaWFsbHkgdGhlIHR3byBmaWVsZHMgdGhhdCBJIG1lbnRpb25lZCBiZWZvcmUsIHRob3NlIHNo
b3VsZCByZWFkDQo+IHplcm8uDQo+IA0KPiBUaGF0LCBlc3BlY2lhbGx5IGJlY2F1c2UgdGhlIGh3
YWRkciBmb3IgdGhlIGNvbnRyb2xsZXJzIGlzIGFueXdheSBhbmQNCj4gYWx3YXlzIGxvbmcNCj4g
MHgxMDAwIC0gYW5kIEkgdGhpbmsgdGhhdCB0aGUgZXh0cmEgcmVnaXN0ZXJzIHNwYWNlLCBvbiBj
b250cm9sbGVycw0KPiB0aGF0IGRvbid0IGhhdmUNCj4gdGhlIEVNTUM1MCByZWdpc3RlcnMgKG1z
ZGMxIGFuZCBtc2RjMikgc2hvdWxkIGJlIHN0aWxsIHJlc2VydmVkIHRvDQo+IHRob3NlIGFuZCBu
ZXZlcg0KPiB1c2VkIGZvciBhbnl0aGluZyBlbHNlLg0KPiANCj4gV291bGQgdGhhdCBkZXRlY3Rp
b24gd2F5IHdvcms/DQoNCkNvbmZpcm1lZCB0aGF0IHRoaXMgYXBwcm9hY2ggd2lsbCB3b3JrIGZv
ciBhbGwgU29jIGFuZCBJUCB2ZXJzaW9uLiBUaHguDQoNCldpbGwgc2VuZCB2MiBhZnRlciB5b3Vy
IHJlZ2lzdGVyIGNsZWFudXAgc2VyaWVzIGFjY2VwdGVkLg0KDQpSZWdhcmRzLA0KQXhlDQoNCj4g
DQo+IElmIGl0IHdvdWxkLCB3ZSdkIGJlIGFnYWluIGF1dG9kZXRlY3Rpbmcgd2hldGhlciB0byBz
ZXQgb3Igbm90IHRoZQ0KPiBBWEkgc2luZ2xlIGJ1cnN0DQo+IG9wdGlvbiBpbiB0aGUgcGF0Y2gg
Yml0cy4uLndpdGhvdXQgcmVseWluZyBvbiBzcGVjaWZ5aW5nIGFueXRoaW5nDQo+IG1hbnVhbGx5
LCBub3QgaW4NCj4gdGhlIGRldmljZXRyZWUsIGFuZCBub3QgaW4gdGhlIHBsYXRmb3JtIGRhdGEg
Oi0pDQo+IA0KPiBDaGVlcnMsDQo+IEFuZ2Vsbw0KPiANCj4gPiA+IFJlZ2FyZHMsDQo+ID4gPiBB
eGUNCj4gPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gQ2hlZXJzLA0KPiA+ID4gPiBBbmdlbG8NCj4g
PiA+ID4gDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gUmVnYXJkcywNCj4gPiA+ID4gPiBBeGUNCj4g
PiA+ID4gPiANCj4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiAtLS0NCj4g
PiA+ID4gPiA+ID4gICAgIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvbXRr
LXNkLnlhbWwgfCA4DQo+ID4gPiA+ID4gPiA+ICsrKysrKysrDQo+ID4gPiA+ID4gPiA+ICAgICAx
IGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspDQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+
ID4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9t
dGstDQo+ID4gPiA+ID4gPiA+IHNkLnlhbWwNCj4gPiA+ID4gPiA+ID4gYi9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvbW1jL210ay1zZC55YW1sDQo+ID4gPiA+ID4gPiA+IGluZGV4
IDBkZWJjY2JkNjUxOS4uNjA3NmFmZjBhNjg5IDEwMDY0NA0KPiA+ID4gPiA+ID4gPiAtLS0gYS9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbW1jL210ay1zZC55YW1sDQo+ID4gPiA+
ID4gPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvbXRrLXNk
LnlhbWwNCj4gPiA+ID4gPiA+ID4gQEAgLTEwMCw2ICsxMDAsMTQgQEAgcHJvcGVydGllczoNCj4g
PiA+ID4gPiA+ID4gICAgICAgICBtaW5pbXVtOiAwDQo+ID4gPiA+ID4gPiA+ICAgICAgICAgbWF4
aW11bTogMHhmZmZmZmZmZg0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gKyAgbWVkaWF0
ZWssZGlzYWJsZS1zaW5nbGUtYnVyc3Q6DQo+ID4gPiA+ID4gPiA+ICsgICAgJHJlZjogL3NjaGVt
YXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvZmxhZw0KPiA+ID4gPiA+ID4gPiArICAgIGRlc2Ny
aXB0aW9uOg0KPiA+ID4gPiA+ID4gPiArICAgICAgQnVyc3QgdHlwZSBzZXR0aW5nLiBGb3Igc29t
ZSB2ZXJzaW9ucyBvZiB0aGUgSVANCj4gPiA+ID4gPiA+ID4gdGhhdA0KPiA+ID4gPiA+ID4gPiBk
bw0KPiA+ID4gPiA+ID4gPiBub3QNCj4gPiA+ID4gPiA+ID4gdXNlDQo+ID4gPiA+ID4gPiA+ICsg
ICAgICBBSEIgYnVzLCB0aGUgYnVyc3QgdHlwZSBuZWVkIHRvIGJlIHN3aXRjaGVkIHRvDQo+ID4g
PiA+ID4gPiA+IElOQ1IuDQo+ID4gPiA+ID4gPiA+ICsgICAgICBJZiBwcmVzZW50LCB1c2UgSU5D
UiBidXJzdCB0eXBlLg0KPiA+ID4gPiA+ID4gPiArICAgICAgSWYgbm90IHByZXNlbnQsIHVzZSBz
aW5nbGUgYnVyc3QgdHlwZS4NCj4gPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gPiAgICAgICBt
ZWRpYXRlayxoczIwMC1jbWQtaW50LWRlbGF5Og0KPiA+ID4gPiA+ID4gPiAgICAgICAgICRyZWY6
IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3VpbnQzMg0KPiA+ID4gPiA+ID4gPiAg
ICAgICAgIGRlc2NyaXB0aW9uOg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4g
PiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gDQo+IA0KPiANCg==
