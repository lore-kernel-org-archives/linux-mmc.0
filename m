Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4F5481DD;
	Mon,  9 Mar 2026 07:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773041473; cv=fail; b=DcrAT/OQscRivmvsQMuUxzUtBscp/tSynV+IvR6hds5yn4lExNEkVOQUTRwxBCnQt3tTBG2wlnWZu5hcuUX07sorOxQh/EbD89a2VeR2/d+bWxJaKliXnfh318M7a5aTMGFc3Qi8ARqDKKwiy4NaDuGkeZ8lLfQ7aGgCS+SzUJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773041473; c=relaxed/simple;
	bh=a81NqLZ176n2n41UwZScW/1xkg2Crauoh1VVdQmMpK0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GqlB4V/fRCpWZp+ym21VqYHW+CA5vWIrgrZhtR/XcuyFm4wo+qKlUPApQ9Z8JDWbSdXvHcw2Z4FqXhg1E9q5z+Knm/mH6fdj+3wPIwvvAQwHsC3EpQA8sHpmcV6Ta9un9xKegLsmE4CKeGBy3gACJWs6OJbI8V+JS/j6WjkugaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=HLF7UDPz; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=rhp2yu2q; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="HLF7UDPz";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="rhp2yu2q"
X-UUID: efce00861b8911f1a39cd589f645bc18-20260309
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=a81NqLZ176n2n41UwZScW/1xkg2Crauoh1VVdQmMpK0=;
	b=HLF7UDPzazMuodq/zNeQ4z7s8CqEzXRXDm8+3be2xIK+9bVhQnk0MSJ3L4MWLrL5lwNtIWQgyQQcsypKIpW4exyRUyUHylhbdhcsLWdmfnjXv1X9nxXbsqxTdIvRQNudWPWLWat7niIyX53WaWy8rmt0tU1aANWgAeOv8PwHki4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:359420e2-8289-415b-9007-a2d6f7386094,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:89c9d04,CLOUDID:aadeae7b-8c8a-4fc4-88c0-3556e7711556,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
	TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BE
	C:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: efce00861b8911f1a39cd589f645bc18-20260309
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <ot_cathy.xu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1791343015; Mon, 09 Mar 2026 15:31:07 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 9 Mar 2026 15:31:05 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 9 Mar 2026 15:31:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QybRFDvPzOtzW8td/8LIwvplVxlKCa3/qWdPIgLiJ0qFcsTrS5d2mi2siYM1dBZ6vXMw9fJQ4cnPO4h00zU2ze/vr/FBzaVTKsmrv8zkCfDy2ASz6CRLoVcMIKSLNIeNFJWzJUwJVx/GqtTTgaoHbIrHoOwsF/y5/VKpF/63vX9LNawYr+SvhZ9i4yrbIDVZiqRNMe+/9zWtka0IVfHkQyWl/ajnT5cAO/qKsPZ6c3nI5vEYLSPZQVtEhWbirqidiSkYMzJgEWeNkw4D/L1pu4QoN4u0Vilt9YwoNLhKv7GCA4U2FsfcFMyxB8bf7EpyK/oiKf19ZqULg8oKvm0GIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a81NqLZ176n2n41UwZScW/1xkg2Crauoh1VVdQmMpK0=;
 b=q0iNetCrsUy3sf2I70sCdq8EFHoyJqs8hRMhszBwPjvxcJdg2HR0NOCQoitw9C4fhlwz+CSRc6VrrGVbU33fxHau2JJa8DjbjHO1DwMuX8Xm59wXbyn0HqmeQrkhap4eo/Tnb8T8LP1v1c7c9l97WV8LOKztDDbeB6cvSsaMAU4sqIvZ04VszHQH6ubATwTE/esLjqRJamymMcZVa4lbOuxhQDhQF1UpIhw+J559trGeymgs11mnYwztA3yvVzXa0RmQGEetIK0kp66aNva8IdFeuJUr+kuZ85IZ4RVu1xFvJPzrRZfJYDv92kyEyE4Lq6AJ2kcQMS/b1DBOAUnVMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a81NqLZ176n2n41UwZScW/1xkg2Crauoh1VVdQmMpK0=;
 b=rhp2yu2qz+iDshjZJaHlOxTKsfhigkNH+Zbzcr8eEjnxXG1+7ib6Znw31jn43SYWWRfG5FNl364KPqZVdKyKTh0UfuInumrvW46Na1+mAt8pm98wV4ScC5a7f2pkVIxFVOW1HApqCz/vBWsnxv2QYK+r5q+PFlkOKqR17u5cgTU=
Received: from KL1PR03MB5683.apcprd03.prod.outlook.com (2603:1096:820:70::6)
 by TY1PPFDC458EFE2.apcprd03.prod.outlook.com (2603:1096:408::a6f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.24; Mon, 9 Mar
 2026 07:31:01 +0000
Received: from KL1PR03MB5683.apcprd03.prod.outlook.com
 ([fe80::b014:3bb3:f2b7:f8e4]) by KL1PR03MB5683.apcprd03.prod.outlook.com
 ([fe80::b014:3bb3:f2b7:f8e4%6]) with mapi id 15.20.9678.024; Mon, 9 Mar 2026
 07:31:01 +0000
From: =?utf-8?B?Q2F0aHkgWHUgKOiuuOWNjuWptyk=?= <ot_cathy.xu@mediatek.com>
To: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	=?utf-8?B?QW5keS1sZCBMdSAo5Y2i5LicKQ==?= <Andy-ld.Lu@mediatek.com>,
	=?utf-8?B?V2VuYmluIE1laSAo5qKF5paH5b2sKQ==?= <Wenbin.Mei@mediatek.com>,
	=?utf-8?B?TWVuZ3FpIFpoYW5nICjlvKDmoqbnkKYp?= <Mengqi.Zhang@mediatek.com>,
	=?utf-8?B?WW9uZyBNYW8gKOavm+WLhyk=?= <yong.mao@mediatek.com>,
	=?utf-8?B?Q2hhb3RpYW4gSmluZyAo5LqV5pyd5aSpKQ==?=
	<Chaotian.Jing@mediatek.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] mmc: mtk-sd: disable new_tx/rx and modify related
 settings for mt8189
Thread-Topic: [PATCH] mmc: mtk-sd: disable new_tx/rx and modify related
 settings for mt8189
Thread-Index: AQHclXtHHfZq3s4DFUqyTgcl4hoOQ7Vym+sAgDNmeAA=
Date: Mon, 9 Mar 2026 07:31:01 +0000
Message-ID: <5b265fd7d6cca3aee7a092907924ca4721df0b4d.camel@mediatek.com>
References: <20260204020709.24604-1-ot_cathy.xu@mediatek.com>
	 <CAPDyKFrGgf1+vYVA6S1SJTZ8+n9WJo91e1VWeWq8p3RNHz1qtw@mail.gmail.com>
In-Reply-To: <CAPDyKFrGgf1+vYVA6S1SJTZ8+n9WJo91e1VWeWq8p3RNHz1qtw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5683:EE_|TY1PPFDC458EFE2:EE_
x-ms-office365-filtering-correlation-id: 34115e1d-1286-4230-19a8-08de7dadd08e
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: Zz9hnombnoOR+xXjpE/rB93oRl0vB+psfWtEKkR9+9iD9DkixEtkLNA/jekG8JY9fVmjUTmnp9J1w9nJ7MJOM6sGebNkNSYm2yx5lclkbqV2yef4fx7RQcth13QVxxvH8Q24lX9mSNKMnWnoK5X4uWlxT8JjIypSgz4+k01fYq3npaw1QCwBoy/YfFVRt3u0f/aDvWKsJN7pwwrcA2TKRB5WrdoAYcBfwS3vkD5/4zQVizx1CDkOxuZ7lq088WDTCb4kuwpzEVyn0bBZS/KapqoxR3l/a5DPpgC8WfgCHsoTnLphZYjC8b/ayE81Ms7AW7i4LiCnFaYGPkQDtZnKXK6mZMPuWUSPoKlB5rz4bLSTlIy08SFDsUBrFUvdy+EFJ/ZNHAupZFs0VeHDKKhpiD6zbvPK/g7G3NTozhTi99aEgko+vxaSUeEOlzeW7mBmhOavMdB6W6MqmXz5PKRWUZf67GMFXMi4jZbT61m4CINoKCySZ5+MxZnv/AqrX5cd5Lmi6MTm6oHWFhcxajJObZF04/5+m0uThWv4s5Q/93uIryDu2qAaCVT3ViNWx5K2G+4N5hqLsuT7IMrbPHxSV4XPKBVvKtpxWUUf7im0PE2D082nzhPDRKjbe/vZUeFrzCXZDB5rYG2W8FvN9SySDsajt2rp9M6DNQNR/BdKrzItXmpGa34MBisMNloQESquuI0cnpIi+b7e/qpAUJZen1YrW+9E8cxOy9LUaeytdwi09Uq/Lezu9+JsKidS8ANKZ1B822S0crrd8dKYo0QqqGMUK/zX+xZa/eBb2q46YCQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5683.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MTZvamo4cmg0ajc4M2pnT3lnVFQrWG9DekdtQzZkcVUxNUZnK2RYU3pyaStC?=
 =?utf-8?B?MjR4aVZQcVptNFArUURrb29lWkhNUThBZGlCQzJrbnpmaXVzWkdpRjNOdGpM?=
 =?utf-8?B?dklCUk8yeGZwWTBqVFVXSVBPN2JmVlRhZDFBNlhrK2VWbi9kWFJqdU8vV3NW?=
 =?utf-8?B?Tk1aSTRFK1dqTFJXWENDbmNCaCtjMWcycFdoaGJwMTI5TGI0bDBpSWh3dkpI?=
 =?utf-8?B?WlMxWjJKY2l4RDR1SjVOb0poRTMwaHIzb3h0R3Y3eHFldmx4U0ZXOXdSM0JD?=
 =?utf-8?B?ZXVBTVYyS3N1dUVMUy82ejIrZFhsY2o0aVhuWkVJdnZkS05zRGNQZ01GbUVX?=
 =?utf-8?B?RWdFYzUrYzZTWG8wWnVzNTVPQXFpa3l0amR2aGFJc1QxdlBIWE84d1hDcVBa?=
 =?utf-8?B?L2hmWXhkMFpWZzNNeEd6QTQybzYyZndtQ0VPWjZhSzhOZUVTbit6MXV4UEEr?=
 =?utf-8?B?UDVFbEoxLzk5VVErUWEvT0ZjUitEYUhUU1BpaFkvOXhPejMxa3hUTHN6ZzhK?=
 =?utf-8?B?QmdGNE1USStVU1NaU3BMalFkYWtFL2ZQNlI5WVlrTzVNRTQzc2g0cmt3cUdz?=
 =?utf-8?B?ZFZKOFFmMDBPaHpRaVN0bXNveUpGeTQ0ZVFZS2JDc3A0Q0w4RUVLK2FlV2pN?=
 =?utf-8?B?aW9sU0drT25JMXEyZDJrb1pENXBtOE4weERwaUQveWpad1p5U3dMdVVDYk5K?=
 =?utf-8?B?TFZEM3VyeUdRaVo5OHQxVFczMWdKZ011NCtmZVNvY0lUUy9OSzZJb2dmaVpa?=
 =?utf-8?B?a1hvZXNNRGtYVFdicUs4VWg1L2trWmc1UFBIUkxTcDZzb0Z4WXB1YjE0SGwr?=
 =?utf-8?B?ci9hcGhNamJYbkw2ZWRucDlUb3g5cU8wRWdkOFpzR1lnblVIRUtvMGxKZ3dt?=
 =?utf-8?B?VFMyTjJzOHN3UlExbERndkRGTVFtUDhvblBHNHgxaklOVVk5eUJ3ampLOTJJ?=
 =?utf-8?B?NCtzLzgyejlLTGJIL3VmNTVpdmhndy9uUHluSFlSWnQrTklXdTdYUmNqZzE5?=
 =?utf-8?B?V0ZVNnhRSWxiWWh2cjNTUlRhdVZBWVpQUGtZMEhXdmZJUTdDVHNzL2loaEcx?=
 =?utf-8?B?RzBaNzhYV0lsZENNUWdJQmM1YVV6VEpKNmVERy9hL08xUnhvbklNNHJGUy9V?=
 =?utf-8?B?ZHNXaExHNDBxKzlmd2RxMnBtZFlmbWRYR3lBamFCeml6TGFpbkk0aXFaWXM3?=
 =?utf-8?B?K2dPTitqTXRFcnd0YzUydXVPdXZTYlRkRTJkNEdEU2lKekdqc2VwOE5qWTNm?=
 =?utf-8?B?L1JoajdvN3hWR2NRUjNBWTY5alV4TDk0V0dHRXVWNXYyYkdwWWxnZEVXYWlK?=
 =?utf-8?B?TWozTThzSERMbk44QndNRUFNNC80VWNZZFRqT3pmd1RyTDZRdzArc3BtNGRx?=
 =?utf-8?B?UTFUY25RWkZCOVJPMXhvdDJyL2VtcjkxZkdjaHFEMWNJY0VzdmRvMk90WDRQ?=
 =?utf-8?B?MEd2RStMbkQ5Ry8zZFVOZ0h4VFdobVZNV0pVeVBtaGZOZGx3QVNkbUxhVEVw?=
 =?utf-8?B?SHFEZXVna09rQ04va2hMZ29DNVBhUHU2Qzk5aHNlbk9mTlN0OG54SkE2Znhq?=
 =?utf-8?B?UFIzV0ZIS1NtNnFwS3ZqaTRiZ3g3L08xdEg0UGY2cEhKWnI4WDdaVWRVTFZS?=
 =?utf-8?B?NVM0eVcyUVFibHZkZGFJVUlCVHl1U0N0WFZLZGRoZVZvVEZYcVV0cnM1UjFT?=
 =?utf-8?B?L2NVTHVUcnpBUXZjQitpbzVuSTdXU2tLci9HelRGMnhHOXlodnk0YVY2VUJH?=
 =?utf-8?B?bGtTSHRjM3pFTVo2STRwVU1kQzBBL2VhS3EvQjNmOTRxbnFjR290aG9HR0Zl?=
 =?utf-8?B?REVhSTNibVB0V0F0TFAyenordU5tdUlYQ2VjRjBZM2hXV01RWlk1WnA3ZXJX?=
 =?utf-8?B?dmk3Y0pLNUlzWDJONzl4U0JlUVRLY1ZaZUhocm12aUhYamhrVEJWZ295THQ0?=
 =?utf-8?B?T1UwYTQ3NkViUDRiQUptZFM3c1Brb2V2cUdJeEl3dWd4SVBJYldOQ1JZNXY0?=
 =?utf-8?B?Y3BnYko2elRYREw2T1B2MVlBZzluajhPWnkrMVZHc245NUVBZ2NYcVhiQ2RB?=
 =?utf-8?B?aGVVaHcxLzdSK25UeTYyTkg4N0VFMmp2SGNSUWlxZTVTREUxUjI2emphRVhw?=
 =?utf-8?B?ZHZHZUEvQVdtUEg0M2QwQzU4bXlwNDUrRTVPQUxJMVNHMEV0TjVkdmUycGov?=
 =?utf-8?B?RmgyMDBZanBDVFF0YUdHY0pXK2x1MTVyWTVyZGREUWNVZDNpand5blVoSXJk?=
 =?utf-8?B?ODRKUEJOMTRTN3VVSDhZK1A4TTZGTWR2eUl6RDdmaDNNVEg4MkJBbENLOGdW?=
 =?utf-8?B?ZDQvSGtLNHVJcTZFSHZaWk14YVU1ZHFrSlc2SjhrR0ptMkVUTnJWUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0289F24340CD2E49B8AB8291842BD53C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: OGCCclV7gRri0GRDeH6UQW7D4Ca0uuKWLL6A2jxAfks3ubA5FLtngoVLYJk8OkXM+WXcI5cago3fCBxvvh5MusMwmo6ZuHM4Wu45BhquvR9lVtgtifiWpfThYsqawGFwbhLBaM/CiOs7P22ZWX/zQsey1GVgb36C8jqeMnTy2eRcSzn86I7kVfqHBRSPl9g9GtGsPZ3G5Xosd1Rhrf1Iw6TI3gPWr8pMzDxQ8bzkq0R5P/D5fn0mQ3vA7+iTxhAMLTE7PqTWjRxU2NUUB6xfbwfCpQbCXTEg0x3hNrjIbD7KPoU8sIRRLRl33VwDJeitI2Ll6lGmMxmuGQeLHqCkzw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5683.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34115e1d-1286-4230-19a8-08de7dadd08e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2026 07:31:01.4443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: umufS5NHYMBXCHwehUAaSbYOAi5yikKzyGnAkFh3jR4ZeSPt9bQQJLZBeCybe1P9RqEiy1M0VI2R9rZSZvXBKRVmEH2BxGMO0hVOwNpTnJU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPFDC458EFE2

T24gV2VkLCAyMDI2LTAyLTA0IGF0IDE1OjM1ICswMTAwLCBVbGYgSGFuc3NvbiB3cm90ZToNCj4g
T24gV2VkLCA0IEZlYiAyMDI2IGF0IDAzOjA5LCBDYXRoeSBYdSA8b3RfY2F0aHkueHVAbWVkaWF0
ZWsuY29tPg0KPiB3cm90ZToNCj4gPiANCj4gPiBEaXNhYmxlIG5ld190eC9yeCBhbmQgbW9kaWZ5
IHJlbGF0ZWQgc2V0dGluZ3MgaGVscHMgYXZvaWQgZGF0YQ0KPiA+IHRyYW5zbWlzc2lvbiBpbnN0
YWJpbGl0eSwgYW5kIGJldHRlciBjb21wYXRpYmlsaXR5IGZvciBtdDgxODkuDQo+ID4gDQo+ID4g
U2lnbmVkLW9mZi1ieTogQ2F0aHkgWHUgPG90X2NhdGh5Lnh1QG1lZGlhdGVrLmNvbT4NCj4gDQo+
IFNob3VsZCB0aGlzIGhhdmUgYSBmaXhlcy9zdGFibGUgdGFnPw0KPiANCj4gS2luZCByZWdhcmRz
DQo+IFVmZmUNCg0KICBUaGFuayB5b3UgZm9yIHlvdXIgcmV2aWV3LCBJIHdpbGwgZml4IGl0IGlu
IG5leHQgdmVyc2lvbi4NCg0KICBUaGFua3MsDQogIENhdGh5DQoNCj4gDQo+ID4gLS0tDQo+ID4g
IGRyaXZlcnMvbW1jL2hvc3QvbXRrLXNkLmMgfCAxMCArKysrKy0tLS0tDQo+ID4gIDEgZmlsZSBj
aGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbW1jL2hvc3QvbXRrLXNkLmMgYi9kcml2ZXJzL21tYy9ob3N0L210ay1z
ZC5jDQo+ID4gaW5kZXggMzAyYWM4NTI5YzRmLi5iMjY4MGNjMDU0YmQgMTAwNjQ0DQo+ID4gLS0t
IGEvZHJpdmVycy9tbWMvaG9zdC9tdGstc2QuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbW1jL2hvc3Qv
bXRrLXNkLmMNCj4gPiBAQCAtNjgyLDE1ICs2ODIsMTUgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBt
dGtfbW1jX2NvbXBhdGlibGUNCj4gPiBtdDgxODlfY29tcGF0ID0gew0KPiA+ICAgICAgICAgLm5l
ZWRzX3RvcF9iYXNlID0gdHJ1ZSwNCj4gPiAgICAgICAgIC5wYWRfdHVuZV9yZWcgPSBNU0RDX1BB
RF9UVU5FMCwNCj4gPiAgICAgICAgIC5hc3luY19maWZvID0gdHJ1ZSwNCj4gPiAtICAgICAgIC5k
YXRhX3R1bmUgPSB0cnVlLA0KPiA+ICsgICAgICAgLmRhdGFfdHVuZSA9IGZhbHNlLA0KPiA+ICAg
ICAgICAgLmJ1c3lfY2hlY2sgPSB0cnVlLA0KPiA+ICAgICAgICAgLnN0b3BfY2xrX2ZpeCA9IHRy
dWUsDQo+ID4gLSAgICAgICAuc3RvcF9kbHlfc2VsID0gMSwNCj4gPiAtICAgICAgIC5wb3BfZW5f
Y250ID0gMiwNCj4gPiArICAgICAgIC5zdG9wX2RseV9zZWwgPSAzLA0KPiA+ICsgICAgICAgLnBv
cF9lbl9jbnQgPSA4LA0KPiA+ICAgICAgICAgLmVuaGFuY2VfcnggPSB0cnVlLA0KPiA+ICAgICAg
ICAgLnN1cHBvcnRfNjRnID0gdHJ1ZSwNCj4gPiAtICAgICAgIC5zdXBwb3J0X25ld190eCA9IHRy
dWUsDQo+ID4gLSAgICAgICAuc3VwcG9ydF9uZXdfcnggPSB0cnVlLA0KPiA+ICsgICAgICAgLnN1
cHBvcnRfbmV3X3R4ID0gZmFsc2UsDQo+ID4gKyAgICAgICAuc3VwcG9ydF9uZXdfcnggPSBmYWxz
ZSwNCj4gPiAgICAgICAgIC5zdXBwb3J0X3NwbV9yZXNfcmVsZWFzZSA9IHRydWUsDQo+ID4gIH07
DQo+ID4gDQo+ID4gLS0NCj4gPiAyLjQ1LjINCj4gPiANCg==
