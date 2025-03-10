Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997F9E545;
	Mon, 10 Mar 2025 03:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741577506; cv=fail; b=j4Yofv3ryI91KHuhufbZS5EFG0TInL/RQhLzLpvuxtooT2yHaz5l7RLzVkPGeJfzy5xPStWp5D6+UBQcPTz07LUNZDAVhBqFn2RmfO5ju9oIG9AYiw4+U/1RBrCveDPLt2cqllBeUAoU6ndxWyCjEvNNakjBNBKND+Lf9EAU9U8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741577506; c=relaxed/simple;
	bh=FuHoL5npgYqWQrtgyJykaeJBuakYDitLZyV5Yqj3g2M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YOKvGWjtSRPciMvRamG4Qj9LMaLKLQ2j62PXriAvXiK70EaG5i/ZEaUPwL8Qwte74sFQufAIbFgAPoqbmeoPuUXBuygakLMteuUo9Brfpns79BB9Bd4JMlG9cZ2/sWwTlgzz4nIkX58pgrYMRCWR6YANuNNxmNhZ5P+j+8NB0uM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=rX+tBt4i; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=Nmz2jBge; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="rX+tBt4i";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="Nmz2jBge"
X-UUID: 29d81b52fd6011efaae1fd9735fae912-20250310
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=FuHoL5npgYqWQrtgyJykaeJBuakYDitLZyV5Yqj3g2M=;
	b=rX+tBt4igVsVM2Go0dLk0O8sCLr8X2gowhmqTi5szi/DBaABX17Gz6SgVwAbwjyny1w7sY0nDOR9lJ34QgtDxeupmRee0Rin2AVYonS4d6cOVy4sMKbvA6Ze/QVozT865RvAcuGh6srYSu7N511SDwAwA2f9FCaGedt0cEVAcxI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:f90969fb-57b9-47a9-9e3d-64576cc2c342,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:b3d620c6-16da-468a-87f7-8ca8d6b3b9f7,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 29d81b52fd6011efaae1fd9735fae912-20250310
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <axe.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 776265722; Mon, 10 Mar 2025 11:31:33 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 10 Mar 2025 11:31:32 +0800
Received: from HK3PR03CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Mon, 10 Mar 2025 11:31:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ub2uerl6AkBIzGk7UHwwKa7jynUPaciDdCnjxXekVJJXRGdLm8zd6ryON1OekXZwvg9j7Tn0/Y0jdExxUlbqCBNQkX2eNqXyiw0RfK3XDVQZ80qtSgD9zoTvBPVvEsccMi4qkwTpJCnl+7mP/K5tMnAOw+UC+Xbe+5OmmqkhpVn70Gww/MIp2/Gw0X4sxLi0x1VvBfiykW/HGfsOrCrlWbyE5oLfqK/Tm//QdiFPKeNiImH44yqA4XTtgxK1CuA3j/FDtyvUuLC2X8Cmz1CmK9PWFT28JpKRnM2gwg0wf7OIrIDeFibl4VvuMas8bloRBU4WRhr2gmBuSat2j5nNqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FuHoL5npgYqWQrtgyJykaeJBuakYDitLZyV5Yqj3g2M=;
 b=QKL11g3QxV7sY5pZIM2Ta3yTfgcJC+pYcM0abYKzBjWqizQOoip4yVHaRtpLPpoax66IMw2IaUhJiz73YjsoBE/O0nTtT8RUECBI0EHY3dI31gtxq0NDJl4vVpaZZ9B0l9Naj6GXEJDJcs2tNsKcWs2oDBR5O1qoGLdHvGEY5cOEzmtzXA56VDglm7YwnJY/KCXED4PKYd4i9FTGxJHG9/hrocp8ZN6cAdw0EIzNXxupZfWKmepCe5qM8tfCEXHxXZalAMR+sHulrh0uxR3igsmESZoDBvi/RjPYogjbwhKWQbbWZ3fDMiD7LCkAoqI3JAlO1PonLQ5uPjnJAb8ACA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FuHoL5npgYqWQrtgyJykaeJBuakYDitLZyV5Yqj3g2M=;
 b=Nmz2jBgeB74ptWgmoyiizJaNp3PAVwX4QrEmDcezDaCo8/ctS4k9rPvW8n1uwGb5om5lIa0WS080Y8ae8s8Yw/rGfbp5CoEu+hkeD8zXI28vE4/5l/OCJ9JK1RCZ4d9JHaatigwsY7UIry/g4cGUxQTbCySJJksKtDlxLaJ3GNU=
Received: from KL1PR03MB8416.apcprd03.prod.outlook.com (2603:1096:820:12c::7)
 by JH0PR03MB7786.apcprd03.prod.outlook.com (2603:1096:990:14::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 03:31:31 +0000
Received: from KL1PR03MB8416.apcprd03.prod.outlook.com
 ([fe80::1816:49d1:d866:bb7a]) by KL1PR03MB8416.apcprd03.prod.outlook.com
 ([fe80::1816:49d1:d866:bb7a%5]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 03:31:31 +0000
From: =?utf-8?B?QXhlIFlhbmcgKOadqOejiik=?= <Axe.Yang@mediatek.com>
To: "conor@kernel.org" <conor@kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	=?utf-8?B?QW5keS1sZCBMdSAo5Y2i5LicKQ==?= <Andy-ld.Lu@mediatek.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	=?utf-8?B?V2VuYmluIE1laSAo5qKF5paH5b2sKQ==?= <Wenbin.Mei@mediatek.com>,
	=?utf-8?B?WW9uZyBNYW8gKOavm+WLhyk=?= <yong.mao@mediatek.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	=?utf-8?B?Q2hhb3RpYW4gSmluZyAo5LqV5pyd5aSpKQ==?=
	<Chaotian.Jing@mediatek.com>, "robh@kernel.org" <robh@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	=?utf-8?B?UWluZ2xpYW5nIExpICjpu47mmbTkuq4p?= <Qingliang.Li@mediatek.com>
Subject: Re: [PATCH 1/2] dt-bindings: mmc: mtk-sd: add single burst switch
Thread-Topic: [PATCH 1/2] dt-bindings: mmc: mtk-sd: add single burst switch
Thread-Index: AQHbjnTYCsmvU5APUkGIYiImQzZRM7Nl1OqAgAFq/QCAAJP/AIAD6QMA
Date: Mon, 10 Mar 2025 03:31:30 +0000
Message-ID: <322f45738a1d0b1bbcd1c5921c9bc8d955793ae6.camel@mediatek.com>
References: <20250306085028.5024-1-axe.yang@mediatek.com>
	 <20250306085028.5024-2-axe.yang@mediatek.com>
	 <3e84fda8-2566-4f18-8ef9-850c84789c34@collabora.com>
	 <f84800fac589429157cd84034ef2f4541d3486a7.camel@mediatek.com>
	 <20250307-bust-diving-a57644a51543@spud>
In-Reply-To: <20250307-bust-diving-a57644a51543@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB8416:EE_|JH0PR03MB7786:EE_
x-ms-office365-filtering-correlation-id: dee41a5d-3104-48b0-164c-08dd5f840cba
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dnd2eit2TU13Y0JiRWljaG9WL3hsWndZRUxqVG96RnF2ZVFhS0REVEpGWllZ?=
 =?utf-8?B?cWZ3emUwb1JVVjR4bWg2clhqVDVFcE4xeHBSOEpzTUNXdTNKWHpnR3N5bm91?=
 =?utf-8?B?dTErSS9RUG5HYWdvSGpXdG0yZy91TWtFaVdvVVlEdXkyUlhHQlFhZGczTXNN?=
 =?utf-8?B?UlVvZVpHT3ZGdWxuSnBOSTZtNjhROE5IbldtaW1lelRFM2E2anF2ajE0ZFVq?=
 =?utf-8?B?eU50ckdIUW1aQVpKU0UvQVZOQzlaYUdkd1l2WlloWWgyWkhyd25Ic3FOeXFz?=
 =?utf-8?B?Q05NWjY5WiticDRhOWdyUmRyZkJVMFVVQ3RRby92TzFLK1U3VUlYTXNIZm5q?=
 =?utf-8?B?WndpT01ZTVJJTjEzdWFNcDBHdTRvaWR4M3JhNjJJeWxiTG1Ic2lWSXdYcm5x?=
 =?utf-8?B?TUQrcGhsT0lGZ0ZZMXV4VDZsVS9LRVBVaG8vZ29va1RTWjRoL1hpWlc1TFBs?=
 =?utf-8?B?WldhMTFkdFNiVzU2SjZOVlZMZjhjMm5xUTUvWFJoMVF5ZjZpUEtFR0Vudi96?=
 =?utf-8?B?UFUyWHROQTVmTGJQWXNscisyMGl6akNpWXlKVkkzUVhEYlZvYTdVeGJubUtu?=
 =?utf-8?B?QkkxRkhkaUtYaUtudjNnT1VPa2h0SXVLd01KNVZ1dlNFTlNrbVBIQkkyaTVh?=
 =?utf-8?B?QmwwWHFDd2dSRmptRjRkdlA3M0Z6cGZPQzNqcmxIdWpXaDJnRG1Wb3g4OXlD?=
 =?utf-8?B?YW1hVVNOOE5VRTBoMnA1NzdnV2dSaGg2clE3NGZhVVY0V0grbDJJYUdqMWg0?=
 =?utf-8?B?SEFqbkY4VzJaWlhWSjJxZy9TeFdOVTBKazRTUlI1WGdGLzBzZStJRVBTUkpx?=
 =?utf-8?B?VmpMZjZVN3lHR3h1NlhRNXl6MVJCQnJ5ZC95M1BOdFRuM2p3cHR5c29TbmJo?=
 =?utf-8?B?bm5CdlpxMkZxbFl5ZlJXZTR1SjJZNUZIWWpKakVPaW9ITmlXb0hkcWVXajhn?=
 =?utf-8?B?cnBmYXdhcXJFbjB0cDl1SFNaaHFsNTJTcEJxUVAwekkxTnFyUks3Y052empV?=
 =?utf-8?B?R0N2QnJuY1BxNXJHZ3pkYjhNVTJLWFN0V20wN3l4Z0VVQmhvZ2V2a2Vhdm5u?=
 =?utf-8?B?bWJVSHZ3c1E3VUdiZXF4VTZOTW1GSEwreTRQRWwyMUEzV2JJN0QySGcwc296?=
 =?utf-8?B?aUNiRDRURDJGSm5SNkpXdFZmTXVqaEduU3IrZXJGbTg1SmFtR3JidmtJb3VM?=
 =?utf-8?B?Q25scktBKzBldExLV3BLZzhuTjhVNXhoVUk5Q0t1dHN2VEkwTERPVFJUa2lt?=
 =?utf-8?B?T2NQTy9DZGN0bXZZa0M1ZVZSdHdLWmF6Y1dOZVJMNVdPK3M4clQ1MVNkRkEz?=
 =?utf-8?B?dzRlTitjSXZ6dmxCMERZeXdoSXMzcWxxU2VtMXZod0plSFhhZnFFNUYvWTM5?=
 =?utf-8?B?RkU0eXVJaWRoaWp5bjBFQURRU2FuZFB3aWIxVEVPUDFucm5DOUxwQ2hrdlJt?=
 =?utf-8?B?NXBFVGx1VmlUMktCN3BnOVZCdVZVdXgvZWRvd2Y2eXBtTXhsWHE5UkJLTWFE?=
 =?utf-8?B?b2gzL1VpbUhNbG5oSk5yZStDVytuM3ZiT0MvR3hlaGhMc3hXejBDN1B5SlZk?=
 =?utf-8?B?WExyRzR6d21YOEtvU05WZmg1a1lCZ0Zjb2F4Uk93a0I1bTN2dXNYNmt5ejdP?=
 =?utf-8?B?dGtZRnlVcjBzYkcybzcrYXV5MGJrUCtkYWVXdlVra3pQWWhvWW04RTg1azRi?=
 =?utf-8?B?M2NGTlorU1hiTktoUDRpaitoQlp6eGZNb1RpVklpVCt0YnIrNVFXUW9BZ2Rk?=
 =?utf-8?B?UlpKZ01qZW5XOWRMczMzaCtPM1lmNjZlbW1naXE3TTVYQjVuNGtCa1ZIMXAw?=
 =?utf-8?B?Ym8yemNqTDNRN1djTURYYzBVQ2VqV3ZGRjZSRENaaGVEY0JUMWVyUXpEdkdP?=
 =?utf-8?B?TjFWdlAvaFNvbFdHTytFaGZhV2hjdkhqVUZ4ZzFNejZoSTB1amI1Zk8vOXgz?=
 =?utf-8?Q?+8ZGNwOQcCPDG/Jqyk2bSTqkLqXj3WhF?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB8416.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TWU5em5vNmR3MUxmZDFTcWJTVjdKZ2pxQWV2M3hwa0tBQ0lqMHRiZFhRY0dN?=
 =?utf-8?B?eEo5SnVFVEpvazBWRnE2Y01CM2djdUVWNzFuaFp4ZFM1ZEFlWGZBakdEaytj?=
 =?utf-8?B?ZXFwOFNVRU93alBvK2VCTHhseUJYaElYZlgzZVdnNmJ6bVlwV0R4bklCTnhJ?=
 =?utf-8?B?ZUpiVTVuV3QvYlpHTEZ4S3hSOTRoOWhoREdXR09zVHNTYU1QWkhYc1FyWGpx?=
 =?utf-8?B?SUtxeWV6WCtzV05KK2gvZ0FNbE1jTkN0TXdtSDBGL0s1ZnVQelpveHp4UWhX?=
 =?utf-8?B?cHE2Q0NYZGpTM2tpY2d2Ulp3STVCc3pROSt1cVVrditrQU9hTXRIVHdPNWp0?=
 =?utf-8?B?S2U4bng2ZHVFZThNak16djExZkdOU1I3NTZiR1AwWkppd2s4OVIyc1FxRVRt?=
 =?utf-8?B?YmZkdW5VTmZzcWtSVWV0cmNnNzIvVjl1U3ZwQ0h4SSsvZHc5WFNmNXFZOWNO?=
 =?utf-8?B?NGV1aWVoZGw5Y25Fcjd0ZEcwbHBSWEZiNjh2blZZV0kwend2Q2N0QTh1dWJZ?=
 =?utf-8?B?S2t5WXZPT3dnNk9MWWlyZXlUVVU2b3o3S3RuVkNTbE9sNHdocWhQRXlzREM3?=
 =?utf-8?B?empZMFFKaHowM2VUelErNFNrem84cXNWcld6blF0N0R3WHErSGt6T20xcEl1?=
 =?utf-8?B?VDJPWHpPdW9XbGlkNXc0QUlqZncvL2J1V1ZlTjVDd1VQL3A1YXFxVnkwR2J2?=
 =?utf-8?B?SEtXT2ZOZnk3K3QzVjAwQWsxaFhIdlkrRzRwT2FFcW9YeEF2b1lsOVQyL1Vi?=
 =?utf-8?B?ZlhZT1VTNnhWL3MxQjJnNzR2L1JzVEVpM01kQlp1cE0wd3pnWTZOMVNKOUVv?=
 =?utf-8?B?MktqaE9ta0hXRHhuVmhXOE56b1VpazZWVHA4R2Z1V05mQ0JMZTlSTDZwcEx6?=
 =?utf-8?B?ZTA1MG14bUVvQXVJdGpMdXo5Vjc5dm5MNjJtNlkzUzhlUTVsR1AzZGV4d2o2?=
 =?utf-8?B?VEdxSEZJMW5ONDZzQmM2LzdKS01rZU5WVTYyb0c4cFoxM013M09KRFRtZ2Ja?=
 =?utf-8?B?ODA0S25xckorMHhVVDJBVUlZT0VEdnh6YlhiTmlVeFFOc0dvQXFoOWp4Q09G?=
 =?utf-8?B?SkhoQU92b25rMDJWcytzSS9SK1FrUVN5dzEwSjFOUkplSytnbHpxY2hmdnFP?=
 =?utf-8?B?QlJjT2FqcC9qcy9PMUlFQllkRFVmQmZUWHliSWN4VXFibE42TWtOR1NLdC9B?=
 =?utf-8?B?RStmZmpEY09VTG5HbXlQWGNlTEVSNHRTSmpPMmdVWERKcjNZZ3E5M29jUmJx?=
 =?utf-8?B?ckJWVGYvNS9iK3ZFU0lsMW9oeEdDL3psQVJ5SVZzdDdmZU5MQjFpOWp4QmpP?=
 =?utf-8?B?U1NuV1BOTlRudlhXMnVkaGw2TGR4ZVlZSC9IVDNSMGFVS1dZeU10bDM1YjhO?=
 =?utf-8?B?cjYza3hCQmtxbi9MdWdCVWwyMG9BWTY0aUUvU3FGSlNLRzFwRk9EeDRCT05k?=
 =?utf-8?B?dFVKSGRvaERnbVZKTSs4Rm5IVWJjdzM0YytualoxNWd5QkZMVmNtbkRLUk51?=
 =?utf-8?B?d01mTFJXbWtrR2QrTVVoVkhjc1VVUjR1ZWFGQ0pZUUcrMkVWakhPZm5mcmNU?=
 =?utf-8?B?K2FIdjhjVlNFKzRJcFc1YUpLS0hzMXJVT0xaQktFSWxUbGVrUjc5VzJRTWJ1?=
 =?utf-8?B?RmpBNitDVmRCUkQxRVFoUEZ1UW0wMko5RXlyVHppZE9tUWFCUlpXUXkyTVBG?=
 =?utf-8?B?b1h1TmFsbkVDbUtTZEN1eW14YTRXMjM1SnE3M1FaSDgzVGtZcHZneDRoS1Jz?=
 =?utf-8?B?V2ZtNXJ0eDNHclJ6ZEVuSDdKb1VVMTQveTNDVmtveCtWTGhFMzljbTNRQjBI?=
 =?utf-8?B?T1FudVBEV2VlazVuNUVlb3hhMmxVVzRxM2MzMVFDc1Q0dEVGZzNnODBkOHph?=
 =?utf-8?B?QnNZNmowbExCMWVtOGovclJwY3lHZktlZUtBTU5zUlR0ZTh5Mm50bEg1Z1k3?=
 =?utf-8?B?TmxjOTlnblJ6S01NNlRSRU05Z1hHUW0wUFZRTytpMUwvY3hqSmtUVUZ2SDdn?=
 =?utf-8?B?amlCMzdkZmFnNkxWdGczZkUxRUNPM1l4L2U3NGpaS0ZZVWU3U2lYYnBsZm1k?=
 =?utf-8?B?b1R3MzBleFdzOVQxNW9kUndvcW9aU2dFVzBZZVFWbkZ4WUdmN1RDS0V2Mkw2?=
 =?utf-8?Q?eFvwWPJcqFT+hVmPHjRkFMpdR?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B0E182981CB28F45AC96B1FA09B1B23E@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB8416.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dee41a5d-3104-48b0-164c-08dd5f840cba
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2025 03:31:31.0055
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xOjwftvwmEWBbAuhuiGT6W9ryDBpEaUMkeNyJm29uWiR3xPKftDKTR06fxFWIS+Ebvm0iuocXSlw0nV9efIKNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7786
X-MTK: N

T24gRnJpLCAyMDI1LTAzLTA3IGF0IDE1OjQ4ICswMDAwLCBDb25vciBEb29sZXkgd3JvdGU6DQo+
IE9uIEZyaSwgTWFyIDA3LCAyMDI1IGF0IDA2OjU5OjAzQU0gKzAwMDAsIEF4ZSBZYW5nICjmnajn
o4opIHdyb3RlOg0KPiA+IE9uIFRodSwgMjAyNS0wMy0wNiBhdCAxMDoxOSArMDEwMCwgQW5nZWxv
R2lvYWNjaGlubyBEZWwgUmVnbm8NCj4gPiB3cm90ZToNCj4gPiA+IEV4dGVybmFsIGVtYWlsIDog
UGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzDQo+ID4gPiB1bnRp
bA0KPiA+ID4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4g
PiA+IA0KPiA+ID4gDQo+ID4gPiBJbCAwNi8wMy8yNSAwOTo0OCwgQXhlIFlhbmcgaGEgc2NyaXR0
bzoNCj4gPiA+ID4gQWRkICdtZWRpYXRlayxkaXNhYmxlLXNpbmdsZS1idXJzdCcgc2V0dGluZy4g
VGhpcyBwcm9wZXJ0eSBjYW4NCj4gPiA+ID4gYmUNCj4gPiA+ID4gdXNlZCB0byBzd2l0Y2ggYnVz
IGJ1cnN0IHR5cGUsIGZyb20gc2luZ2xlIGJ1cnN0IHRvIElOQ1IsIHdoaWNoDQo+ID4gPiA+IGlz
DQo+ID4gPiA+IGRldGVybWluZWQgYnkgdGhlIGJ1cyB0eXBlIHdpdGhpbiB0aGUgSVAuIFNvbWUg
dmVyc2lvbnMgb2YgdGhlDQo+ID4gPiA+IElQDQo+ID4gPiA+IGFyZSB1c2luZyBBWEkgYnVzLCB0
aHVzIHRoaXMgc3dpdGNoIGlzIG5lY2Vzc2FyeSBhcyAnc2luZ2xlJyBpcw0KPiA+ID4gPiBub3QN
Cj4gPiA+ID4gdGhlIGJ1cnN0IHR5cGUgc3VwcG9ydGVkIGJ5IHRoZSBidXMuDQo+ID4gPiA+IA0K
PiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBBeGUgWWFuZyA8YXhlLnlhbmdAbWVkaWF0ZWsuY29tPg0K
PiA+ID4gDQo+ID4gPiBJIGFtIG1vc3RseSBzdXJlIHRoYXQgdGhpcyBpcyBub3Qgc29tZXRoaW5n
IHRvIHB1dCBpbiBkZXZpY2V0cmVlLA0KPiA+ID4gYnV0DQo+ID4gPiBhcw0KPiA+ID4gcGxhdGZv
cm0gZGF0YSBmb3Igc3BlY2lmaWMgU29DKHMpLCBhcyBtdWNoIGFzIEknbSBtb3N0bHkgc3VyZQ0K
PiA+ID4gdGhhdA0KPiA+ID4gYWxsIG9mDQo+ID4gPiB0aGUgaW5zdGFuY2VzIG9mIHRoZSBNU0RD
IElQIGluIG9uZSBTb0Mgd2lsbCBiZSAqYWxsKiB1c2luZw0KPiA+ID4gZWl0aGVyDQo+ID4gPiBz
aW5nbGUNCj4gPiA+IG9yIElOQ1IuDQo+ID4gDQo+ID4gTm8sIGFjdHVhbGx5IE1TREMgSVBzIGlu
IG9uZSBTb0MgYXJlIHVzaW5nIGRpZmZlcmVudCB2ZXJzaW9ucy4NCj4gPiBVc3VhbGx5IE1TREMx
IChpbmRleCBmcm9tIDEpIGlzIHVzZWQgYXMgZU1NQyBob3N0LCB0aGUgbGVmdCBob3N0cw0KPiA+
IGFyZQ0KPiA+IHVzZWQgYXMgU0QvU0RJTyBob3N0cy4gVGhleSBoYXZlIHNpbWlsYXIgZGVzaWdu
cywgYnV0IHRoZXJlIGFyZQ0KPiA+IHN0aWxsDQo+ID4gZGlmZmVyZW5jZS4NCj4gPiANCj4gPiA+
IA0KPiA+ID4gU28sIEkgdGhpbmsgSSBrbm93IHRoZSBhbnN3ZXIgYnV0IEknbGwgc3RpbGwgYXNr
IGp1c3QgdG8gYmUNCj4gPiA+IGV4dHJlbWVseQ0KPiA+ID4gc3VyZToNCj4gPiA+IA0KPiA+ID4g
aXMgdGhlcmUgYW55IE1lZGlhVGVrIFNvQyB0aGF0IGhhcyBkaWZmZXJlbnQgSVAgdmVyc2lvbnMg
Zm9yDQo+ID4gPiBkaWZmZXJlbnQgTVNEQw0KPiA+ID4gaW5zdGFuY2VzLCBhbmQgdGhhdCBoZW5j
ZSByZXF1aXJlIHNpbmdsZSBidXJzdCBvbiBvbmUgaW5zdGFuY2UNCj4gPiA+IGFuZA0KPiA+ID4g
SU5DUiBvbg0KPiA+ID4gYW5vdGhlciBpbnN0YW5jZT8NCj4gPiANCj4gPiBZZXMuIEFjdHVhbGx5
IGV2ZXJ5IFNvQyBoYXMgZGlmZmVyZW50IElQIHZlcnNpb25zIGZvciBlTU1DIGFuZA0KPiA+IFNE
L1NESU8NCj4gPiBob3N0IGFzIEkgc2FpZC4NCj4gPiBlLmcuIEZvciBNVDgxNjgsIHNpZ25lbCBi
dXJzdCBiaXQgc2hvdWxkIGJlIHNldCB0byAxIGZvciBlTU1DIEhvc3QsDQo+ID4gYnV0DQo+ID4g
MCBmb3IgU0QvU0RJTyBIb3N0Lg0KPiA+IA0KPiANCj4gU291bmRzIGxpa2UgdHdvIGRpZmZlcmVu
dCBJUHMgdGhhdCByZWFsbHkgc2hvdWxkIGhhdmUgZGlmZmVyZW50DQo+IGNvbXBhdGlibGVzIHRv
IG1lLi4uDQoNClllcywgc28gY29uc2lkZXJpbmcgYWxsIGZhY3RvcnMsIGFkZGluZyBhIGRldmlj
ZSB0cmVlIHByb3BlcnR5IG1pZ2h0IGJlDQp0aGUgbW9zdCBhcHByb3ByaWF0ZSBhcHByb2FjaC4g
VGhpcyBtZXRob2QgaXMgbW9yZSBmbGV4aWJsZSBhbmQNCmNvbnZlbmllbnQuDQpBbm90aGVyIHJl
YXNvbiwgd2hpY2ggSSBkaWRuJ3QgbWVudGlvbiBpbiB0aGUgcHJldmlvdXMgcmVwbHksIGlzIHRo
YXQNCk1lZGlhVGVrIGhhcyB0b28gbWFueSBTb0NzIHVzaW5nIE1TREMuIEN1cnJlbnRseSwgdGhl
cmUgYXJlIGFscmVhZHkgMTMNCm10WFhYWCBjb21wYXRpYmxlIHN0cnVjdHVyZXMgaW4gdGhlIG1z
ZGMgZHJpdmVyLCBhbmQgYSBzaWduaWZpY2FudA0KcG9ydGlvbiBvZiB0aGUgU29DIHNldHRpbmdz
IGNhbiBiZSByZXVzZWQgYnkgdGhlIG5ldyBTb0MgKHdpdGhvdXQNCmFkZGluZyBhIGNvbXBhdGli
bGUgZm9yIG5ldyBTb0MpLiANCklmIHdlIGFkZCBhIHZhcmlhYmxlIGluIHRoZSBjb21wYXRpYmxl
IHRvIHJlcHJlc2VudCB0aGUgc2luZ2xlIGJ1cnN0DQpzZXR0aW5nIGZvciBlTU1DL1NEL1NESU8g
KG1heWJlIHVzaW5nIGEgdTggdHlwZSB2YXJpYWJsZSBhcyBiaXRtYXAgZm9yDQpkaWZmZXJlbnQg
aG9zdHMsIGJpdDAgZm9yIG1zZGMwLCBiaXQxIGZvciBtc2RjMSwgYml0MiBmb3IgbXNkYzIsIC4u
LiksDQp3ZSBtaWdodCBoYXZlIHRvIGFkZCBhIGNvbXBhdGlibGUgZm9yIGVhY2ggU29jLCBsZWFk
aW5nIHRvIGENCnNpZ25pZmljYW50IGluY3JlYXNlIGluIHRoZSBudW1iZXIgb2YgY29tcGF0aWJs
ZXMgYW5kIG1ha2luZyBpdCBtb3JlDQpjb21wbGV4Lg0KDQpSZWdhcmRzLA0KQXhlDQoNCj4gPiA+
IA0KPiA+ID4gQW5kIGlmIHRoZXJlIGlzIC0gaXMgdGhlcmUgYSBwYXR0ZXJuPyBJcyBpdCBhbHdh
eXMgU0RJTyByZXF1aXJpbmcNCj4gPiA+IElOQ1Igb3INCj4gPiA+IGFsd2F5cyBlTU1DL1NEIHJl
cXVpcmluZyBpdD8NCj4gPiA+IA0KPiA+ID4gDQo+ID4gDQo+ID4gTm8sIHRoZXJlIGlzIG5vIHBh
dHRlcm4uIEJvdGggZU1NQyBhbmQgU0QvU0RJTyBob3N0cyBuZWVkIHRvIGJlDQo+ID4gY29uZmln
dXJlZCBiYXNlIG9uIElQIHZlcnNpb24uIFRoZXJlIGlzIG5vIGJpbmRpbmcgcmVsYXRpb25zaGlw
DQo+ID4gYmV0d2Vlbg0KPiA+IGVNTUMvU0QvU0RJTyBhbmQgdGhlIGJ1cnN0IHR5cGUuIGVNTUMg
YnVyc3QgdHlwZSBtaWdodCBiZSBJTkNSIG9yDQo+ID4gc2luZ2xlLCBzYW1lIGFzIFNEL1NESU8u
DQo+ID4gDQo+ID4gDQo+ID4gUmVnYXJkcywNCj4gPiBBeGUNCj4gPiANCj4gPiANCj4gPiA+IA0K
PiA+ID4gPiAtLS0NCj4gPiA+ID4gICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
bW1jL210ay1zZC55YW1sIHwgOA0KPiA+ID4gPiArKysrKysrKw0KPiA+ID4gPiAgIDEgZmlsZSBj
aGFuZ2VkLCA4IGluc2VydGlvbnMoKykNCj4gPiA+ID4gDQo+ID4gPiA+IGRpZmYgLS1naXQgYS9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbW1jL210ay1zZC55YW1sDQo+ID4gPiA+
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9tdGstc2QueWFtbA0KPiA+
ID4gPiBpbmRleCAwZGViY2NiZDY1MTkuLjYwNzZhZmYwYTY4OSAxMDA2NDQNCj4gPiA+ID4gLS0t
IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9tdGstc2QueWFtbA0KPiA+
ID4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbW1jL210ay1zZC55
YW1sDQo+ID4gPiA+IEBAIC0xMDAsNiArMTAwLDE0IEBAIHByb3BlcnRpZXM6DQo+ID4gPiA+ICAg
ICAgIG1pbmltdW06IDANCj4gPiA+ID4gICAgICAgbWF4aW11bTogMHhmZmZmZmZmZg0KPiA+ID4g
PiANCj4gPiA+ID4gKyAgbWVkaWF0ZWssZGlzYWJsZS1zaW5nbGUtYnVyc3Q6DQo+ID4gPiA+ICsg
ICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvZmxhZw0KPiA+ID4gPiAr
ICAgIGRlc2NyaXB0aW9uOg0KPiA+ID4gPiArICAgICAgQnVyc3QgdHlwZSBzZXR0aW5nLiBGb3Ig
c29tZSB2ZXJzaW9ucyBvZiB0aGUgSVAgdGhhdCBkbw0KPiA+ID4gPiBub3QNCj4gPiA+ID4gdXNl
DQo+ID4gPiA+ICsgICAgICBBSEIgYnVzLCB0aGUgYnVyc3QgdHlwZSBuZWVkIHRvIGJlIHN3aXRj
aGVkIHRvIElOQ1IuDQo+ID4gPiA+ICsgICAgICBJZiBwcmVzZW50LCB1c2UgSU5DUiBidXJzdCB0
eXBlLg0KPiA+ID4gPiArICAgICAgSWYgbm90IHByZXNlbnQsIHVzZSBzaW5nbGUgYnVyc3QgdHlw
ZS4NCj4gPiA+ID4gKw0KPiA+ID4gPiAgICAgbWVkaWF0ZWssaHMyMDAtY21kLWludC1kZWxheToN
Cj4gPiA+ID4gICAgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvdWlu
dDMyDQo+ID4gPiA+ICAgICAgIGRlc2NyaXB0aW9uOg0KPiA+ID4gDQo+ID4gPiANCj4gPiA+IA0K
