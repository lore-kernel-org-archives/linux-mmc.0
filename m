Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEBA2C182;
	Wed, 12 Mar 2025 06:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741761028; cv=fail; b=K6WtnvCl+yASYEV9LKbgKPOOl/Z9zJ93BqBK30P4VR+0PatVv+laObT+WMlMHOP77akM/nBFNXSSBPtXJR5iGZv3Ec/ueWhf3sZODFZmrWyNcPUtem+0oGbQg5aO3+lulYeYsWHYIm8Yo+ArhrcexUW8V+yHmz3FErXmTuMBHgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741761028; c=relaxed/simple;
	bh=TP2c9A4OqABNT+q9+pEI5xaC6OdJ4yO/Po8E5Q8rFgk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l6IOsNXAiRBFXW7mKUkD1UT1JfDuuK5Cnr5sAIRwFUHyz1L6CqKLAFwo689TlMlwRTF1xUiKwUgJ7L/V/uAUIyI9g5Jz9BG/yhVDDs29GW5Xr0xiLc7EZZp2ZGqEFVAG7YF1WTqD6Tnr5JnLdf74u54hr9iBnKSLxbVsDtOmHJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=i23/Gijz; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=Ns/i4oep; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="i23/Gijz";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="Ns/i4oep"
X-UUID: 794ebd2eff0b11efaae1fd9735fae912-20250312
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=TP2c9A4OqABNT+q9+pEI5xaC6OdJ4yO/Po8E5Q8rFgk=;
	b=i23/GijzgfPkH1m1JCq2yV4fVkHSnt7eDWVAFCvMKEa51v2WMCiDt9lBE5x3M8EHmFZKff225/sNI1+rGUBXrb89L8nokHwQrvOnw3UBD+cWLZvdEbsWnZPviIIXwvo9m75+QuYogwWNsdCQHFlkA6QKvQyjTycxFKEZn0GXqYY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:65dad52d-6228-46be-9a95-ed454cf0a139,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:e497448c-f5b8-47d5-8cf3-b68fe7530c9a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 794ebd2eff0b11efaae1fd9735fae912-20250312
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <axe.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 439964341; Wed, 12 Mar 2025 14:30:21 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 12 Mar 2025 14:30:20 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Wed, 12 Mar 2025 14:30:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mdwg3WO8GdoRdRBbGg1pnG+36ceBOwUe8GPsaRf+V1hYjq8AI65I4QoAyQAYqYAQMjbHWTk2qNljWmHAqp+rKR69J31Qo4MyutmpG3tlsrEyCI7AsyXMeti2iopHEHoZEwZWZNn4mTJEvEta419gQ9SH0dqCYF4Sj1S+aGDZYpqZM0s+KbNbkPK+E6a04QgL8SKLNHTDTU0uZFGN3knPg+bvS6UM+pPguAjoGcGzkpj6ML/XaoITdBguZWu7gDhxISojMO3WrJ5Tv71gS886+eMRcIgKshv88hyrPrKJpidaJS15BjmUK5UkpGPiED95l0xhyM1JhV+FaDT6IbDvXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TP2c9A4OqABNT+q9+pEI5xaC6OdJ4yO/Po8E5Q8rFgk=;
 b=TvXDgV9zSfRstt9FAT0X+dqGWwWJJW26ivR/sQ5ghWaZ6Apo0AqbRx7J75dm0TWxD18pQGBayjukYs0JLNjnlseJ99D5BA0nPP+ZCjCtKYjt0KhVlxdANvnBQ3LmMYbgjqyWmzEhr7LxM1nz+ZeXY791jkzqKSekyEL8ALBsaDxVxk3sW7pEFxoLPkoX7YV9/4xyMeXD+/mqcpgd8sup4w5DdGqfvjMJsCPqxU7T7JHyaixqmM/oGXWb3PNCxUVw3jkHzGvKRpyWeNxiwLLOElMsEYsRaldVmlFSf8l5z5NvpBuwPEXuIIoYBeGQD6rW8gWreNEPDsB8jDzPAGcn1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TP2c9A4OqABNT+q9+pEI5xaC6OdJ4yO/Po8E5Q8rFgk=;
 b=Ns/i4oepgpItUju6S3BX9xNe5Uqou+9YN1gfPW1zaJwR1S2NFkw1V7R6lHVwCR4hmmI8suWRmLuqgTjwEDzL3rq+kyzjS4xFx7V9cdUupXwerdyo+hSLZAaWBI3G30G/AvTwUmyWLPXF1/OwU8mRSdEaYTyh1BWlINaaBAcs4X0=
Received: from KL1PR03MB8416.apcprd03.prod.outlook.com (2603:1096:820:12c::7)
 by SEZPR03MB8181.apcprd03.prod.outlook.com (2603:1096:101:199::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 06:30:17 +0000
Received: from KL1PR03MB8416.apcprd03.prod.outlook.com
 ([fe80::1816:49d1:d866:bb7a]) by KL1PR03MB8416.apcprd03.prod.outlook.com
 ([fe80::1816:49d1:d866:bb7a%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 06:30:17 +0000
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
Thread-Index: AQHbjnTYCsmvU5APUkGIYiImQzZRM7Nl1OqAgAFq/QCABnhcgIABW0IA
Date: Wed, 12 Mar 2025 06:30:17 +0000
Message-ID: <f8ce830d831aaba0d2748d31f8ba4a9915b7a14e.camel@mediatek.com>
References: <20250306085028.5024-1-axe.yang@mediatek.com>
	 <20250306085028.5024-2-axe.yang@mediatek.com>
	 <3e84fda8-2566-4f18-8ef9-850c84789c34@collabora.com>
	 <f84800fac589429157cd84034ef2f4541d3486a7.camel@mediatek.com>
	 <b09f618a-eaf9-4258-ae2d-67eff1cb249f@collabora.com>
In-Reply-To: <b09f618a-eaf9-4258-ae2d-67eff1cb249f@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB8416:EE_|SEZPR03MB8181:EE_
x-ms-office365-filtering-correlation-id: a870da8e-d590-41f6-5fff-08dd612f5ad1
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TmdBT1FsVjBGUVd2L01LbThPejhFdnJPN1FZQkk4N2REREw0TEVjWEtFanBl?=
 =?utf-8?B?NlhQTk95aVVXVFVmL2Q1bCtaZHQ0VGFNeElnZVpmckQ1a25wRjRSYUFwa0p0?=
 =?utf-8?B?SEFGZlB6MWtLQ1ZodGtYN3dNM0ZrUWFHelQ2dVpqdkFibmF0d0NoelErREtz?=
 =?utf-8?B?Q0J5ZE5oVmZ1alhYZHN5a011d2N1SExoREVNMGhyNkZLeXlzdGV2dzI1T01X?=
 =?utf-8?B?NXZmSG1zUTV0NUkrZmtRZWZKeTAydXhNTXpzcTNESlJzaHJEWmhtNi82MU1P?=
 =?utf-8?B?T0QxVlEwOVdheURpNEVKaXB2dWl6Vk1YeGlPWXBNSDlnQTd1bnBsUUFkOExm?=
 =?utf-8?B?WG1JZHhnYktveTljMCsydW1TZTlpb25pcklIS01ZUlVxdEttNUVVZENZRDFn?=
 =?utf-8?B?NUVPeG54eG1SRThFdE5zanZBZkRLWlNCZldMVEh0RzBJT1VMeEhJaGFIRGQx?=
 =?utf-8?B?NHNVZzZPQWVvSHFXNkFQTmVtMnRsZ01Fd1NoZHB4NmppNm5qdFdXd1dMLzhB?=
 =?utf-8?B?N1FJZUFaSlFITDl4M2ZCcVNOZEsvaURRMkdrUG1qbkJKYmcwQUhTc1V0K1lF?=
 =?utf-8?B?TXNtTTR2Y2dpZ1B2MTdzbDVjSWgwQzFZaC8vdUpPdnhXbllIaUpjYUV2TUNn?=
 =?utf-8?B?TE1iZk50VTh5YVMwMUpTc21nYm1DU1dFc3JYbzhPbXoxL285OFMzWXF4Zm5l?=
 =?utf-8?B?aHlaM00zeDVCbWVOTEd3N282eUJuRkxHNHdPVUdhTDAvQ3BuWWpCdHpTczNV?=
 =?utf-8?B?ZnlnWmsrdVkyU0FYcjN2alVCb1ZmUko3OEdOUVB3M1NjVUx1bTdHdlhiNDMy?=
 =?utf-8?B?MlBQdFNjNzl0aFpLaDZ5bFhTT3VxOC82QmtMR0F4L1ViUUk3dTVJMjNPMFln?=
 =?utf-8?B?ZXEwMnpHb1AyVWVCU2hjbnVNMXNYaHpObUp4QVZGc0lVRDVyaW8yZ1FyOXNs?=
 =?utf-8?B?SDk5OWd1aTQ2aXcwOTZLeUphOGFBVWhjY3hHWlNCWWFyWmQ0emdvbyt3Kzlp?=
 =?utf-8?B?Y1o3emh1WlUwM0RtUDBIVGJlMWJMT2RkY2xmMjc0b2FNNkZTcVd4UzFWZXdI?=
 =?utf-8?B?MjJHNWZ3T2wrbjhaUWpibG8xQmIwcDRPTVFUUGt5V3FaRTdraUgvN3gzK0Nz?=
 =?utf-8?B?YWtWY2pyU1VRNnVYdXNSd2JZN2swSVFOaDQyU25rWjVNdTZsTTl5Ri9NQUFG?=
 =?utf-8?B?eno2akpQQ01xdlFNRVNKeDllSjBMb2dVL0p4U2hVc2hOYVlGeTUzeFU1UnU4?=
 =?utf-8?B?elJSWHB4bFhkSHd5MVNBRzVEMEtUNG5kYVB6NXN4QjRNeXpOcktlTm55cHVF?=
 =?utf-8?B?eE43WFk3MEQ3a0JVbEZZVU5PN043dmxYRS85amZTMlZmcUExTGRQVWRMNkor?=
 =?utf-8?B?ZlMrZWRUY05LNUlFQlA4S2ZNejU1YjZLMzRRQ2tiai83ZEFyNkZ4RmJDME5q?=
 =?utf-8?B?c0d4TnNPeWFaQ3dXTlFMVENxSnI5ZmVLSm9LOE92RnNuR2REb09wYTJCOU9i?=
 =?utf-8?B?TUtqaUFaSkkySHJ0NzFMNWkySjRmNjRwdG5ZNUFMTWJmTm9qSDJDRE1uOFFG?=
 =?utf-8?B?T2czTG5BVlpUYXdNT1MzR0tmM2IzT2R3WUQ0Z1ZLTzdOSFkwbXFFVlFVcGFG?=
 =?utf-8?B?Q2dsSWVuRjZCWVBhNUsrM0NOOGs5WDYyL2Uxc1ducGZLbklRd002eWh4UjJx?=
 =?utf-8?B?VkdwS0w0elk2dVZSNDNPRW4veGdZYjdHaHhpdlZsUitudUtrcG5RU1VnTWlJ?=
 =?utf-8?B?Z0kxRFpQYk9MMU42UzA2YkF1UHFaZ0xYcUxTSVA5bURSOGZiQTlPUVRqUWxX?=
 =?utf-8?B?dFczUURNcEpaQm00bG5QSExndS90MGx0OGE2MHJZeXhqbVBEWkp0cTZhalVZ?=
 =?utf-8?B?MWc5cUw0cDV2WEhkZDJteTJsTUdSb2Y0K3N1Z005QlI1bDdZWkxJYzFvVVRO?=
 =?utf-8?Q?ki0Qa0rWFa0ngySHD+m8uu72OvXyALkH?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB8416.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WnZiVnoxSzVuSjlhRlVUOGNNamZtR1JyQXFsdEZNWmVNR0w3NDVwb1FrUGtG?=
 =?utf-8?B?S09mZWtrb093OFpqZkNpUkRsV1dSb1JTcEYwTTU5QUlMTVZ2YWxpeGo2bG5a?=
 =?utf-8?B?dlVVUHRmUDJWK3M0TnpBc05Gdno1QW9oMmlhRFBXVUpUaHZhYTN6NE10VEpH?=
 =?utf-8?B?SFZhWk5yY3VHUG52SjJJT3plK3RFTG9abVUrbEJ1SEttQ2NtNXRIdnVsci90?=
 =?utf-8?B?MlFndi9KejQ0YnFnVGJpd1hmM3ZxYmpaL1FTM1lBcmlyTG1jMmp1M0FHL2px?=
 =?utf-8?B?WUtKRTRwVWlSSUtmeWQzUTB1S3UrOHdFenQxTk1HL2JOVlFjVkE3ZUEvVDhQ?=
 =?utf-8?B?d094ZVVRNVZiRGk0KytRbmdhUjJzS2p4WW1QN2V0b1kwOFh0TWE3cDkyMCto?=
 =?utf-8?B?bVhLa0R2dzhtbGdFU2hjdVc1QUx4VE5NTDNhY3BjcTQzeGtRU3VhTk8ycVBW?=
 =?utf-8?B?bENHcE8rdy9wdWFLZ3psRjRFY1ZuSmRHSTJtMytXNUlDRXNtS2dFL3pCREUr?=
 =?utf-8?B?UFh0SE93WC9ielBOZXQ0SytVZmVWK3pIZXpOK0IvaGJMWjV3QzR2emxDdGF1?=
 =?utf-8?B?UWtROCtFaklrWlhvNlZwV2o3aXJvVEx1Ykt0Y3N6VmhpZDR0R1BrbzBqclpN?=
 =?utf-8?B?R2NRRHVjbGhleGlxZU9YVXdjMXowd0dDWlNkaHM3d1p0SHh6MG54U3QwS2lu?=
 =?utf-8?B?S2JHMDBKb1EvSmFPWG5Ed2t2R2xtWEdOQStXcFI2ODJMdk9KME9CYnJUTDYv?=
 =?utf-8?B?VzZQZEVhOVVZZWp1U0YvMGZ3biszZndiVW9BNTVRd3RQSTBQK1VRKzNaayta?=
 =?utf-8?B?d29KTHZuZGsxNkZkV2FYUnhRR2pEbmRUZnFCc3BoRFpHWHArMGpZeVhhUGJ4?=
 =?utf-8?B?clkvczEvT0g1Tit0d2paQlVCSTNBWENlUEFFaW5DZHVWUVZNaUx1TWY5U2J1?=
 =?utf-8?B?N2NGNlJvaUF2bytMUlp6Wm9neDRrN2Q1akpWejFlUjExOWdsd3ErUDZqcmd0?=
 =?utf-8?B?aXM0Um9BWHVMNGFQeTNHNnhUcG4xeGd6SWhTVW9udmU4UFg4d09xckdBNG9o?=
 =?utf-8?B?Myt3eUpzUHFHWTJKWUtJR1pjMjJrdEpIOGFud0JHZm43TSttZk1MYUFkemJH?=
 =?utf-8?B?cmk0ckw1ZnBaQ1pjbEN3ZG1ibThhVlRveklmV1YzaHk2ZWErbVE2SVZGMjR6?=
 =?utf-8?B?Nmtzc1lnTnNZU2ZTaXd2S2R2YUt6V0xiZ29DcTZJRmNrbFBLUEZybjd3eTla?=
 =?utf-8?B?M2cxdmlsdG5uRFBHbEZNUHJOWk5nYWdEajlRT1k4eitxclcxTTJoUzkxWFBL?=
 =?utf-8?B?VkRaR3cvUmNKMzFTNVROeEVrWnF4MDB5UUdsYVhUMVJTQ0ZuOWI0UERYTk5K?=
 =?utf-8?B?cG9kTTc2NTROWmFwbFRZUm9LcVNldFB3aFdRRDFyMTBoUXZJWmtUZGFzUlhh?=
 =?utf-8?B?bWtRYno5dTI2dExGY3VVSUhlMHFJV1B1WTQzRVhGOEMwcUZjU3BzS09QRG1u?=
 =?utf-8?B?MUpseEpjclhjN2ZnSlUvOXd6cHh5bklRQStoTlJNdmJwNU1RZGZHeW16aFBZ?=
 =?utf-8?B?clA1aHdPMTlZZk5DS0FlMmc0SWluZmlVd1J4YmNiRVlLNysvV0owNUhsMTlx?=
 =?utf-8?B?eEczOEhjNVppalJZUWcwdjNteDhDdGcrZ1ViVWVoQkwvWWNjMFhIZUZjRUFz?=
 =?utf-8?B?YXJ2TGZoUmFUZlF5cVFVTDQxSHZhZTRBZTMwdXorMWxuWWVlR2p0WEN3dFJW?=
 =?utf-8?B?MVVRdkx4YnJsWTNvbTNlaVNpQTEwTGx3S1dHRnhrL3hLeTNwVHd2ZmFPdnMv?=
 =?utf-8?B?Q294bHB1RnJSN290TXZhdFlQazJ0SXpMTFpqazZLenU5V0xtRzFpa0xkVTd3?=
 =?utf-8?B?YlJPdktTNXozNDNzV3hKV0Q5dUZEaitFSHlJQXZHNGEra0FwV0pmWHB4bWJH?=
 =?utf-8?B?VXBZc09qWTU4OGNmTFlTazZTMjFhVklxNG5wRkFaSTlsbWx5eGUwa1pJZytz?=
 =?utf-8?B?WmRhUzlseVdSbEdWZnl5R0RpTElVejFSZk45b1JSSWhWWGNHblI3NFE4dlds?=
 =?utf-8?B?bUphTWZRN2NaSDNUUCs4WGpIS21tSzJEUm5LcFhOWHdhY21Mb1hMbGlqb3ln?=
 =?utf-8?Q?3bVb8NGvqEj/UknI6QTQYYh3w?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9779EDF2226211478728D59E03326719@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB8416.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a870da8e-d590-41f6-5fff-08dd612f5ad1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2025 06:30:17.1442
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 34UT9UXpl0blkAuF0UwqMKGEKqGTKNLot0G4iaeZfiQEXXMbE5K0RP9mOaNFSM6e/L4QM9Xa4EkrdTDPuU4jAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8181
X-MTK: N

T24gVHVlLCAyMDI1LTAzLTExIGF0IDEwOjQ3ICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBJbCAwNy8wMy8yNSAwNzo1OSwgQXhlIFlhbmcg
KOadqOejiikgaGEgc2NyaXR0bzoNCj4gPiBPbiBUaHUsIDIwMjUtMDMtMDYgYXQgMTA6MTkgKzAx
MDAsIEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vDQo+ID4gd3JvdGU6DQo+ID4gPiBFeHRlcm5h
bCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cw0K
PiA+ID4gdW50aWwNCj4gPiA+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNv
bnRlbnQuDQo+ID4gPiANCj4gPiA+IA0KPiA+ID4gSWwgMDYvMDMvMjUgMDk6NDgsIEF4ZSBZYW5n
IGhhIHNjcml0dG86DQo+ID4gPiA+IEFkZCAnbWVkaWF0ZWssZGlzYWJsZS1zaW5nbGUtYnVyc3Qn
IHNldHRpbmcuIFRoaXMgcHJvcGVydHkgY2FuDQo+ID4gPiA+IGJlDQo+ID4gPiA+IHVzZWQgdG8g
c3dpdGNoIGJ1cyBidXJzdCB0eXBlLCBmcm9tIHNpbmdsZSBidXJzdCB0byBJTkNSLCB3aGljaA0K
PiA+ID4gPiBpcw0KPiA+ID4gPiBkZXRlcm1pbmVkIGJ5IHRoZSBidXMgdHlwZSB3aXRoaW4gdGhl
IElQLiBTb21lIHZlcnNpb25zIG9mIHRoZQ0KPiA+ID4gPiBJUA0KPiA+ID4gPiBhcmUgdXNpbmcg
QVhJIGJ1cywgdGh1cyB0aGlzIHN3aXRjaCBpcyBuZWNlc3NhcnkgYXMgJ3NpbmdsZScgaXMNCj4g
PiA+ID4gbm90DQo+ID4gPiA+IHRoZSBidXJzdCB0eXBlIHN1cHBvcnRlZCBieSB0aGUgYnVzLg0K
PiA+ID4gPiANCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogQXhlIFlhbmcgPGF4ZS55YW5nQG1lZGlh
dGVrLmNvbT4NCj4gPiA+IA0KPiA+ID4gSSBhbSBtb3N0bHkgc3VyZSB0aGF0IHRoaXMgaXMgbm90
IHNvbWV0aGluZyB0byBwdXQgaW4gZGV2aWNldHJlZSwNCj4gPiA+IGJ1dA0KPiA+ID4gYXMNCj4g
PiA+IHBsYXRmb3JtIGRhdGEgZm9yIHNwZWNpZmljIFNvQyhzKSwgYXMgbXVjaCBhcyBJJ20gbW9z
dGx5IHN1cmUNCj4gPiA+IHRoYXQNCj4gPiA+IGFsbCBvZg0KPiA+ID4gdGhlIGluc3RhbmNlcyBv
ZiB0aGUgTVNEQyBJUCBpbiBvbmUgU29DIHdpbGwgYmUgKmFsbCogdXNpbmcNCj4gPiA+IGVpdGhl
cg0KPiA+ID4gc2luZ2xlDQo+ID4gPiBvciBJTkNSLg0KPiA+IA0KPiA+IE5vLCBhY3R1YWxseSBN
U0RDIElQcyBpbiBvbmUgU29DIGFyZSB1c2luZyBkaWZmZXJlbnQgdmVyc2lvbnMuDQo+ID4gVXN1
YWxseSBNU0RDMSAoaW5kZXggZnJvbSAxKSBpcyB1c2VkIGFzIGVNTUMgaG9zdCwgdGhlIGxlZnQg
aG9zdHMNCj4gPiBhcmUNCj4gPiB1c2VkIGFzIFNEL1NESU8gaG9zdHMuIFRoZXkgaGF2ZSBzaW1p
bGFyIGRlc2lnbnMsIGJ1dCB0aGVyZSBhcmUNCj4gPiBzdGlsbA0KPiA+IGRpZmZlcmVuY2UuDQo+
ID4gDQo+ID4gPiANCj4gPiA+IFNvLCBJIHRoaW5rIEkga25vdyB0aGUgYW5zd2VyIGJ1dCBJJ2xs
IHN0aWxsIGFzayBqdXN0IHRvIGJlDQo+ID4gPiBleHRyZW1lbHkNCj4gPiA+IHN1cmU6DQo+ID4g
PiANCj4gPiA+IGlzIHRoZXJlIGFueSBNZWRpYVRlayBTb0MgdGhhdCBoYXMgZGlmZmVyZW50IElQ
IHZlcnNpb25zIGZvcg0KPiA+ID4gZGlmZmVyZW50IE1TREMNCj4gPiA+IGluc3RhbmNlcywgYW5k
IHRoYXQgaGVuY2UgcmVxdWlyZSBzaW5nbGUgYnVyc3Qgb24gb25lIGluc3RhbmNlDQo+ID4gPiBh
bmQNCj4gPiA+IElOQ1Igb24NCj4gPiA+IGFub3RoZXIgaW5zdGFuY2U/DQo+ID4gDQo+ID4gWWVz
LiBBY3R1YWxseSBldmVyeSBTb0MgaGFzIGRpZmZlcmVudCBJUCB2ZXJzaW9ucyBmb3IgZU1NQyBh
bmQNCj4gPiBTRC9TRElPDQo+ID4gaG9zdCBhcyBJIHNhaWQuDQo+ID4gZS5nLiBGb3IgTVQ4MTY4
LCBzaWduZWwgYnVyc3QgYml0IHNob3VsZCBiZSBzZXQgdG8gMSBmb3IgZU1NQyBIb3N0LA0KPiA+
IGJ1dA0KPiA+IDAgZm9yIFNEL1NESU8gSG9zdC4NCj4gPiANCj4gPiA+IA0KPiA+ID4gQW5kIGlm
IHRoZXJlIGlzIC0gaXMgdGhlcmUgYSBwYXR0ZXJuPyBJcyBpdCBhbHdheXMgU0RJTyByZXF1aXJp
bmcNCj4gPiA+IElOQ1Igb3INCj4gPiA+IGFsd2F5cyBlTU1DL1NEIHJlcXVpcmluZyBpdD8NCj4g
PiA+IA0KPiA+ID4gDQo+ID4gDQo+ID4gTm8sIHRoZXJlIGlzIG5vIHBhdHRlcm4uIEJvdGggZU1N
QyBhbmQgU0QvU0RJTyBob3N0cyBuZWVkIHRvIGJlDQo+ID4gY29uZmlndXJlZCBiYXNlIG9uIElQ
IHZlcnNpb24uIFRoZXJlIGlzIG5vIGJpbmRpbmcgcmVsYXRpb25zaGlwDQo+ID4gYmV0d2Vlbg0K
PiA+IGVNTUMvU0QvU0RJTyBhbmQgdGhlIGJ1cnN0IHR5cGUuIGVNTUMgYnVyc3QgdHlwZSBtaWdo
dCBiZSBJTkNSIG9yDQo+ID4gc2luZ2xlLCBzYW1lIGFzIFNEL1NESU8uDQo+ID4gDQo+IA0KPiBP
a2F5IGJ1dCBpZiB0aGVyZSBhcmUgZGlmZmVyZW50IElQIHZlcnNpb25zLCBhbmQgQVhJL0FIQiBp
cw0KPiBkZXRlcm1pbmVkDQo+IGJ5IHRoZSBJUCB2ZXJzaW9uLCB3aHkgYXJlbid0IHlvdSBwYXJz
aW5nIHRoZSBNQUlOX1ZFUi9FQ09fVkVSDQo+IHJlZ2lzdGVycyBvZg0KPiB0aGUgTVNEQyBJUCB0
byBjaGVjayB3aGV0aGVyIHRvIHVzZSBJTkNSIG9yIFNJTkdMRT8NCg0KDQpUbyBhZGRyZXNzIHlv
dXIgY29uY2VybnMsIEkgaGFkIGZ1cnRoZXIgZGlzY3Vzc2lvbnMgd2l0aCB0aGUgZGVzaWduZXIu
DQpUaGVpciByZXNwb25zZSB3YXMgdGhhdCB0aGUgYnVzIHR5cGUgYW5kIElQIHZlcnNpb24gYXJl
IG5vdCBib3VuZA0KdG9nZXRoZXIuIFRoaXMgY29udHJhZGljdHMgbXkgcHJldmlvdXMgc3RhdGVt
ZW50cywgYW5kIEkgYXBvbG9naXplIGZvcg0KdGhhdC4NCkFjY29yZGluZyB0byB0aGUgZGVzaWdu
ZXIncyBmZWVkYmFjaywgSSBtdXN0IHNheSB0aGF0IHRoZSBzaW5nbGUgYnVyc3QNCnNldHRpbmcg
aXMgaW5kZWVkIHRpZWQgdG8gdGhlIElDLCBidXQgdGhlIGdyYW51bGFyaXR5IGlzIHN1Y2ggdGhh
dCBpdA0KbmVlZHMgdG8gYmUgc2V0IGluZGl2aWR1YWxseSBmb3IgZWFjaCBob3N0Lg0KR2l2ZW4g
dGhlIGxhcmdlIG51bWJlciBvZiBJQ3MgTWVkaWF0ZWsgY3VycmVudGx5IGhhcywgYWRkaW5nIGJ1
cnN0IHR5cGUNCmluZm9ybWF0aW9uIGZvciBlYWNoIGhvc3QgdG8gdGhlIGRyaXZlcidzIGNvbXBh
dGlibGUgc3RydWN0dXJlIHdvdWxkDQptZWFuIGFkZGluZyBodW5kcmVkcyhtYXliZSB0aG91c2Fu
ZHMgOigpIG9mIGxpbmVzIHRvIHRoZSBkcml2ZXIgZm9yIHRoZQ0KY29tcGF0aWJsZSBzdHJ1Y3R1
cmVzIGZvciAqYWxsIHByZXZpb3VzIFNvQ3MqIChjdXJyZW50bHkgdGhlcmUgYXJlIG9ubHkNCjEz
IGNvbXBhdGlibGUgc3RydWN0dXJlcywgYW5kIHRoZXkgY2FuIGJlIHJldXNlIGJ5IG5ldyBTb0Mp
LiBUaGlzDQphcHByb2FjaCBzZWVtcyB2ZXJ5IGN1bWJlcnNvbWUuDQoNClNvIEkgc3RpbGwgYmVs
aWV2ZSB0aGF0IHBsYWNpbmcgdGhpcyBzZXR0aW5nIGluIHRoZSBEVFMgaXMgYSBtb3JlDQphcHBy
b3ByaWF0ZSBhcHByb2FjaC4NCg0KUmVnYXJkcywNCkF4ZQ0KDQo+IA0KPiBDaGVlcnMsDQo+IEFu
Z2Vsbw0KPiANCj4gPiANCj4gPiBSZWdhcmRzLA0KPiA+IEF4ZQ0KPiA+IA0KPiA+IA0KPiA+ID4g
DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAgICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvbW1jL210ay1zZC55YW1sIHwgOA0KPiA+ID4gPiArKysrKysrKw0KPiA+ID4gPiAgICAxIGZp
bGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspDQo+ID4gPiA+IA0KPiA+ID4gPiBkaWZmIC0tZ2l0
IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9tdGstc2QueWFtbA0KPiA+
ID4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvbXRrLXNkLnlhbWwN
Cj4gPiA+ID4gaW5kZXggMGRlYmNjYmQ2NTE5Li42MDc2YWZmMGE2ODkgMTAwNjQ0DQo+ID4gPiA+
IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvbXRrLXNkLnlhbWwN
Cj4gPiA+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9tdGst
c2QueWFtbA0KPiA+ID4gPiBAQCAtMTAwLDYgKzEwMCwxNCBAQCBwcm9wZXJ0aWVzOg0KPiA+ID4g
PiAgICAgICAgbWluaW11bTogMA0KPiA+ID4gPiAgICAgICAgbWF4aW11bTogMHhmZmZmZmZmZg0K
PiA+ID4gPiANCj4gPiA+ID4gKyAgbWVkaWF0ZWssZGlzYWJsZS1zaW5nbGUtYnVyc3Q6DQo+ID4g
PiA+ICsgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvZmxhZw0KPiA+
ID4gPiArICAgIGRlc2NyaXB0aW9uOg0KPiA+ID4gPiArICAgICAgQnVyc3QgdHlwZSBzZXR0aW5n
LiBGb3Igc29tZSB2ZXJzaW9ucyBvZiB0aGUgSVAgdGhhdCBkbw0KPiA+ID4gPiBub3QNCj4gPiA+
ID4gdXNlDQo+ID4gPiA+ICsgICAgICBBSEIgYnVzLCB0aGUgYnVyc3QgdHlwZSBuZWVkIHRvIGJl
IHN3aXRjaGVkIHRvIElOQ1IuDQo+ID4gPiA+ICsgICAgICBJZiBwcmVzZW50LCB1c2UgSU5DUiBi
dXJzdCB0eXBlLg0KPiA+ID4gPiArICAgICAgSWYgbm90IHByZXNlbnQsIHVzZSBzaW5nbGUgYnVy
c3QgdHlwZS4NCj4gPiA+ID4gKw0KPiA+ID4gPiAgICAgIG1lZGlhdGVrLGhzMjAwLWNtZC1pbnQt
ZGVsYXk6DQo+ID4gPiA+ICAgICAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0
aW9ucy91aW50MzINCj4gPiA+ID4gICAgICAgIGRlc2NyaXB0aW9uOg0KPiA+ID4gDQo+ID4gPiAN
Cj4gPiA+IA0KPiANCj4gDQo=
