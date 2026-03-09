Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A47C31A576;
	Mon,  9 Mar 2026 07:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773041580; cv=fail; b=XIB38dWpdCmn+yo0INXW9YUcp8+oz6TODTYU+zDkgA7qICREVkBJevNrP9ZLeQPHZVN7FSTCbPWWVJ8plrYJacTWqgTAmT2gZMllSGCcm+xUOan4o+7hlDdfr5zwVTL3s7qKM7NHj2BOwB7e6aq83z0+WG7FNyX85eDYm4P0tNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773041580; c=relaxed/simple;
	bh=of5xjx+tgRCMYk9G7GYcP7kNXFNE6luCGuwW+HI6WyM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MlABY8muWQcggnx3eEWxxOP95L3TBr7fQ4S/9JYsBn5cr58h2NH9Elc+MgPeN/HZcroRXrWVIVBDPg45BxcBeEyoy/P3qRdIYF0/JGve8bk5WzagK6oZ21ygERNQVbXsc/aYbqS0HMYJ88geZqtfnvaYQeaDTzBioundfUbrS3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=sH2+ZiNC; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=tJUWpHWI; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="sH2+ZiNC";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="tJUWpHWI"
X-UUID: 2cfed4a81b8a11f1a02d4725871ece0b-20260309
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=of5xjx+tgRCMYk9G7GYcP7kNXFNE6luCGuwW+HI6WyM=;
	b=sH2+ZiNClFMiQfgtQTdKCd3z1UIBrMYfle9QJE1qq0E962FeYJyRC4r8CPw1/CzFa6k/lceonOX/0ZaS5VYm3fLi6ASCWH4Vl9cXwX+su1KNxl4MlmpT1XmZ6fpZ75FYL5MIwj0UbL4xjRQ88I9dUZuU8CLDO0eWTvQDQmj12AQ=;
X-CID-CACHE: Type:Local,Time:202603091531+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:a3df05d8-c997-4a49-91ff-3a7c664aa586,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:89c9d04,CLOUDID:3510065c-a957-4259-bcca-d3af718d7034,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
	TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BE
	C:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2cfed4a81b8a11f1a02d4725871ece0b-20260309
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <ot_cathy.xu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 475604924; Mon, 09 Mar 2026 15:32:49 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 9 Mar 2026 15:32:48 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 9 Mar 2026 15:32:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kk6AIBtFuqhMnnCNdzlRGYgtkXsb4HMZ5JbmomdAY+h1qsI3gdL+r19js6AXURACtDaIp8h9T5Lzf2vgFExMbFNxpMirVQYUXDWY/v219dP5SQ2bY5h1bT1yzMUeg1QjQpPhQCrcyKgWCCI1+OBjg3xbSTraA7ge7rfwzm+7YQ87OFhBNU+SxGEj88+MGKTwrYk+5ReqE5pzUegzJipDlchjhWbnNcwS0uB5DZsUHLCthnt7nLh5/1AlRVf0Iw5tHtwWJWuasIZgDQqI24kZp9cSpCiio2bedHEt2VQ28YJLNxdMEnbhhcQrwkHBNA61NIdNuvk5g5lQ1yy9mSokcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=of5xjx+tgRCMYk9G7GYcP7kNXFNE6luCGuwW+HI6WyM=;
 b=BHf2EDnqZJbn0u5lSKqsdHN9DFPwXIYKtFK+CZQMtEEBdAPI7zuTjAWfrBTlMq26Uv7nch4lWRqj3wHHR2fy0iOEpc0zeUfbSWHuc64zB3+WhpmgzWEVMZQcCMaSco8A99cH5r+RfYRSACfpQeeKujNpIO8V1idNOyrE8YPgVPeunHQ2f5VxyfBC8Jz5SlZJ0MZalEcEwSPcrgf8mNlrz1DmiKIr4rgGJo9i/HEJefIgnuWiEAiI35voJoDXVhXLKWz/cm+kYBn4tM4cQvjaxFx/fkjpe7kyRz4bs0PdKubDBWiKWMKEXtm6Df3ruy6ZXm1PrWLWbHBTKohp6AoQEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=of5xjx+tgRCMYk9G7GYcP7kNXFNE6luCGuwW+HI6WyM=;
 b=tJUWpHWIY3PAKuGAec7CebnOWzqrTVlypDm3OHv3NiFhZ3BA3OG0/Crtfyq1xfNCcjIKSdVv+IvFpj3njVu7h8fh2LNM9B9VDysi6tJw8dikUOGx/4NY7Ta4VUXB2FrK4bzjzD83mcdVHhcgL3ZwBI+S8G8YsjqGOg5Nt3gOy60=
Received: from KL1PR03MB5683.apcprd03.prod.outlook.com (2603:1096:820:70::6)
 by TYZPR03MB7769.apcprd03.prod.outlook.com (2603:1096:400:425::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Mon, 9 Mar
 2026 07:32:45 +0000
Received: from KL1PR03MB5683.apcprd03.prod.outlook.com
 ([fe80::b014:3bb3:f2b7:f8e4]) by KL1PR03MB5683.apcprd03.prod.outlook.com
 ([fe80::b014:3bb3:f2b7:f8e4%6]) with mapi id 15.20.9678.024; Mon, 9 Mar 2026
 07:32:45 +0000
From: =?utf-8?B?Q2F0aHkgWHUgKOiuuOWNjuWptyk=?= <ot_cathy.xu@mediatek.com>
To: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
	=?utf-8?B?Q2hhb3RpYW4gSmluZyAo5LqV5pyd5aSpKQ==?= <Chaotian.Jing@mediatek.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	=?utf-8?B?QW5keS1sZCBMdSAo5Y2i5LicKQ==?= <Andy-ld.Lu@mediatek.com>,
	=?utf-8?B?V2VuYmluIE1laSAo5qKF5paH5b2sKQ==?= <Wenbin.Mei@mediatek.com>,
	=?utf-8?B?WW9uZyBNYW8gKOavm+WLhyk=?= <yong.mao@mediatek.com>,
	=?utf-8?B?TWVuZ3FpIFpoYW5nICjlvKDmoqbnkKYp?= <Mengqi.Zhang@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] mmc: mtk-sd: disable new_tx/rx and modify related
 settings for mt8189
Thread-Topic: [PATCH] mmc: mtk-sd: disable new_tx/rx and modify related
 settings for mt8189
Thread-Index: AQHclXtHHfZq3s4DFUqyTgcl4hoOQ7Vz/3SAgDIDawA=
Date: Mon, 9 Mar 2026 07:32:45 +0000
Message-ID: <fd2a7dc76462ef63fcf0a0eaa0213179864838da.camel@mediatek.com>
References: <20260204020709.24604-1-ot_cathy.xu@mediatek.com>
	 <33719d8d-af95-49ae-bc5e-247784529d12@collabora.com>
In-Reply-To: <33719d8d-af95-49ae-bc5e-247784529d12@collabora.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5683:EE_|TYZPR03MB7769:EE_
x-ms-office365-filtering-correlation-id: 24953e1c-9989-4ca3-db6e-08de7dae0ea0
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: eha1ly97Zznao+zEOVZ7yIO63zcwiHWFTJCdgt15TX2PdA/Tv3P2ipBYbyyOqs9YTrlmM/rj9nFiDyNDu5RUSKP9YeJ97CrixKykyI6ksGty9bgEXTATv6RKTDE93wvC60a3IKJfaN67z66CUiCT7d8DaIU7hQL41G15PppYc0B5qUUiU8/yvQSImyiRGG62awQjo4WkiVDlzV8MgdmSrFNaKUvLqlZwYfoJHMkysctEIFI+nJdMPnGYIbEIJix6zIOmqiwWeBJPqF2nUnSqtqpvhp0EXC6rczI4U0kBm7eU3DcRd0UpIK4tGTWF1Wk+EEAF0R09I0r+CfEaNjixffVxuDeknkjZzRdvGEmQ1fHCeoNdmBhCNUgjLZUry/EsYMgvZ55XsP2j6Egv+v7CxKBatpu8/gwrdxx7BzQTNFGlWB+VZCR0vErkjxMGFLzSt7tBVhoVsF+OSRKj//ef3Y6c5MSiLlHaTjuoxFA0gj/xF0G9Qr+KGC3eQOHF1TZrJMongElqX4vlpQt+8An+jI0li1+Pz3V2C+L2P3IHd4UBJxuqltH7Cg5jXAknDGAD5XEMRVUVIaADIhPNL/24Kwvgo67E613IUBykgeTE86BCcfKuzg6EWjEsO8RgkyD+m2rxO0kZ4tfsEeUdK+Zhmdesn68c81OIV6WvjzozgV7ZY8P1k1NXGCYU1DDgIgvxM+nbE/5H8RF0TTf9qtgInAqM/v01LjaDGKOCTbPkXn2vaaqNIOPafvH3Sck4+5slB8GTly8HIpv4pa6wKH9yOJxwk3L8U5oTTcmT8KfT734=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5683.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YnFhTHhDVDRmU21Pa1RsUlc1NEM0U1kvNzE2cnIxc1dCc1ByWFBJS2lwdDBQ?=
 =?utf-8?B?ZU92dzRYT01ROFhyVTM4bll0bmc2MVk0K0hBVHVLVzhmR3BONnRzcTVXV3B3?=
 =?utf-8?B?NkFWaGtyenhBOEozZ0ttRXpsclMwdTZOOXJhV1c5S0ZuU1d1dVBqQ2Mrc1U4?=
 =?utf-8?B?TzZLU2Q1VUR5QnlrbmttNTJHaGdVWU9RK2VkdURkajVDVXRRSWFWaENHdnVt?=
 =?utf-8?B?MXFzRmYzSkF3MEYzT2RJaW1JRnhDQkluRHEzVDliTWxUL3ZMZFAzMWlLWUVY?=
 =?utf-8?B?elA0eEN4dHRZekJWcGhrR1ZUS3hmMEw0RTN5L2dDRWdtSldlQjEwK05KYWZ4?=
 =?utf-8?B?cHZSSEtpSHFXR0JsdnE1c2M4MVQ4VjRpcGRzM3hWR1pVR0dJcnp1OUN5UXEv?=
 =?utf-8?B?SGZVZkFsRStUY0F0VHBYbUtZZVNJd3p4emMyMjJuTHRwL1pxbzVOUVhZYkFN?=
 =?utf-8?B?c0UrbmpKYzltcThzcjAyTndwZmw2cUZhMS9RL1NBejdROTBvQ2dRdVVXUFFy?=
 =?utf-8?B?clhkcHVIWTVsQjdObUpBL211SXpiSWQ4WDBVN1k5YkRRcWtuVWE5cXBURzg3?=
 =?utf-8?B?b3psWUthOCtZMG15WG5UZDBTdVhONzJ2NjJNdmtublg2Y2J2SVZnOUdRa0cv?=
 =?utf-8?B?NWdJN1lJVDhibjF6Z0hZb3RsOUdZNmRPeExqUG9MU3JpMEpPUkZndnEyZVBk?=
 =?utf-8?B?VWkxUXRtdDVPbGl0eXE4b3RpL1JvODEyeWN6Sm1VMzR3dUIrZll0NjM0Rmxx?=
 =?utf-8?B?VkdaL1lPWjZCYm1IRm83aU04UHdBbEJKUTBkYnhQOXB0TU4xekhEUWhveWRa?=
 =?utf-8?B?Z251MTN6S0hCR1lma2M3UktkNmc0TnVlR2ROb0NrZGRHZFZCRC9OaS9hQWh1?=
 =?utf-8?B?YUF5bmlKK2VuVyt2RlR5YnUzTFhHZzQ5YkpaREZYL052WTA1VWFMTjBRZXd3?=
 =?utf-8?B?YVZ6bDROcm5BYnhvZmpPMzNVQk0waTlCU21PTFlKL0g4YU5RQzhCVWYwSllC?=
 =?utf-8?B?Z1RMZFRNWCswWURtL3d1L2gyWWx6WEltdEduOEhPUm0wVkFmR2Y2Z2xmT2ll?=
 =?utf-8?B?U1F4M1VJUTkzRkgxVTZWQU9hRkJEblo4KzF2TjNTU2drckpWaHVvbTMzeHBs?=
 =?utf-8?B?OWJBLzlpYXk3RmFrZHh0K2d2aFk4c21TSFRWYkFzVEo3V0k5U3RIOUQvbUNk?=
 =?utf-8?B?RUZiWVB6aVRNWWpKWXJvN3BxN0JIUk4wRDBPNkNMTlg2VWlydUF6K1JXRldF?=
 =?utf-8?B?bHRva1lZZGkyNXJPdlZiek1DbHhKQTVRbzB0d1lXNXdwcWpkd0FNalpYYVZx?=
 =?utf-8?B?SlA1WlJ5S1gzaGd3L005VndJamI4UUlKdGZtSE82Qm4wMTA5UXk0TXpoNDV4?=
 =?utf-8?B?MXlmQlVwSllUaTZqMHVFN1RHdmF0TWpMTk1Ya3RJQ0ZDdTIvVXAxSHIyRE5G?=
 =?utf-8?B?cEpSZXhHKzJUS1luaTNTZUJGTGVPWmNyOVlSODNtWm5BZ0lRQkExT2ZaT1F0?=
 =?utf-8?B?dndDMWYrQXZyOU9sOHlUNVkxbjBjU2NUK3pkOUN3b0dCWjE0RFBCbThlQ3U0?=
 =?utf-8?B?aVZvZWhvVVZqNjFja2tlM0ppb2tmNDhKeWowM1NMVTdTdTI2alJNN2MvalpJ?=
 =?utf-8?B?RllacnZXaGJrZVNUK1ZvMTRWbmlCYlNLVU43R2tFWVF4b2ZGQWlRYlNHTG5W?=
 =?utf-8?B?emUzL0xtSG9GNzlhbDZOUG84cDYyMkJ5cFNLK05rVnNLTXZDZzJtaGs5NlpY?=
 =?utf-8?B?Rmd0WUJ2YzBkYTQ1MGxHajFiLzFUbUV3VzJpRk9ZSmNMUXpob1VDVElLMFox?=
 =?utf-8?B?SFMyMDJjR2JLbzlkMmRhdnhUaFFFa0E4dG9HMVRwbTl6N1lKeUxQQ3owMndI?=
 =?utf-8?B?bGNhVklJQ0dmNjFub2trWTlxVUt0UUxmSzZjQTRweTg0SFlGd1E4Qlo5TTg5?=
 =?utf-8?B?cG1NZ1hNQlk1a0NmTGhZVmFud2hXQ1E5THJmY042Tkc0cjhhSTdXUnFpUCtJ?=
 =?utf-8?B?YXJGREIzMnkwRjBacGhDeUJKUWJpMkwwcS9MQmpYdmRaUDNSTi9WME5yaEpT?=
 =?utf-8?B?eUo3WE44TEhETWcxKzUrQU4zMzFJb3FDdjlmS0M0aHV0TU8wL1FjOTZuS3Ra?=
 =?utf-8?B?cDVZWGxJN3lFQkJkTElHODdtMnhucDJPdWtsSVVGY3c4K2ozc1R2TFNrTjBl?=
 =?utf-8?B?RndNTFRqbEF1YXpkYTVOQUR2NGJveW1yZWNkcWdobmNHSC9rZU03Sjh1K0Y0?=
 =?utf-8?B?VEgzTWRlaUJYYkxZUEY0bng5Q25QWldtTnVHMmxlejJvOFdGb1JkUExScDNk?=
 =?utf-8?B?ZmlwQnI0QkNTd0libG55VFlDS3BBbEllSXlPNWo5UmNyMUVabVpndWVBMGpm?=
 =?utf-8?Q?dotsTDhJtWd/WVxs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C2461E116E1F9B41AB889A0E10E87529@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ldslqGnznfEY5Vl1JE4TjL3E7/KzroNQOtcRHOYTHk4mmaUCEHKSLkWgcLwjCsFe4H1SrHraHBbWYFj67yJyVAP0wE/Rv8BnDZj20qV9eCMSE2i453eNLtfNSjGts7DB9olhxMO8Kn+azYia+KL0cU3WOfCalpN2w0VpjbtolW+fcnF2XnR8N2S65rchnbDWxp6jrYjQjuFkDU1goRXn7a3nVyOfXPnM0wKKoR+IsMeTsd0gcFjuezOt72J70AHzLkL2xv+6VGgblbpDllS/wGDGd5GHHm85NIptIHgdQvHEt/5n1tQ6Qhmt6/zJj25KY3t9J3oz9DYsxFfKma18vg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5683.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24953e1c-9989-4ca3-db6e-08de7dae0ea0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2026 07:32:45.5824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BoZ/E9UiWKFqKkoY5j8UTdF3M9cCKlNbnL8k3Gm/Br4yDbr1px2qNlvGOjH3mu2aGjFs3QkiLOe7iLO6W0vN7o6Ij10+6uGw7s6n+M6d54Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7769

T24gVGh1LCAyMDI2LTAyLTA1IGF0IDEyOjQ3ICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMDQvMDIvMjYgMDM6MDYsIENhdGh5IFh1IGhhIHNjcml0dG86DQo+
ID4gRGlzYWJsZSBuZXdfdHgvcnggYW5kIG1vZGlmeSByZWxhdGVkIHNldHRpbmdzIGhlbHBzIGF2
b2lkIGRhdGENCj4gPiB0cmFuc21pc3Npb24gaW5zdGFiaWxpdHksIGFuZCBiZXR0ZXIgY29tcGF0
aWJpbGl0eSBmb3IgbXQ4MTg5Lg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IENhdGh5IFh1IDxv
dF9jYXRoeS54dUBtZWRpYXRlay5jb20+DQo+IA0KPiBOZWVkcyBhIGZpeGVzIHRhZy4gUGxlYXNl
IGFkZCB0aGUgcmVsZXZhbnQgb25lIGFuZCByZXNlbmQuDQo+IA0KPiBUaGFua3MsDQo+IEFuZ2Vs
bw0KDQogIFRoYW5rIHlvdSBmb3IgeW91ciByZXZpZXcsIEkgd2lsbCBhZGQgaXQgaW4gbmV4dC4N
Cg0KICBUaGFua3MsDQogIENhdGh5DQoNCj4gDQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL21tYy9o
b3N0L210ay1zZC5jIHwgMTAgKysrKystLS0tLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDUgaW5z
ZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9tbWMvaG9zdC9tdGstc2QuYyBiL2RyaXZlcnMvbW1jL2hvc3QvbXRrLXNkLmMNCj4gPiBpbmRl
eCAzMDJhYzg1MjljNGYuLmIyNjgwY2MwNTRiZCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL21t
Yy9ob3N0L210ay1zZC5jDQo+ID4gKysrIGIvZHJpdmVycy9tbWMvaG9zdC9tdGstc2QuYw0KPiA+
IEBAIC02ODIsMTUgKzY4MiwxNSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19tbWNfY29tcGF0
aWJsZQ0KPiA+IG10ODE4OV9jb21wYXQgPSB7DQo+ID4gICAJLm5lZWRzX3RvcF9iYXNlID0gdHJ1
ZSwNCj4gPiAgIAkucGFkX3R1bmVfcmVnID0gTVNEQ19QQURfVFVORTAsDQo+ID4gICAJLmFzeW5j
X2ZpZm8gPSB0cnVlLA0KPiA+IC0JLmRhdGFfdHVuZSA9IHRydWUsDQo+ID4gKwkuZGF0YV90dW5l
ID0gZmFsc2UsDQo+ID4gICAJLmJ1c3lfY2hlY2sgPSB0cnVlLA0KPiA+ICAgCS5zdG9wX2Nsa19m
aXggPSB0cnVlLA0KPiA+IC0JLnN0b3BfZGx5X3NlbCA9IDEsDQo+ID4gLQkucG9wX2VuX2NudCA9
IDIsDQo+ID4gKwkuc3RvcF9kbHlfc2VsID0gMywNCj4gPiArCS5wb3BfZW5fY250ID0gOCwNCj4g
PiAgIAkuZW5oYW5jZV9yeCA9IHRydWUsDQo+ID4gICAJLnN1cHBvcnRfNjRnID0gdHJ1ZSwNCj4g
PiAtCS5zdXBwb3J0X25ld190eCA9IHRydWUsDQo+ID4gLQkuc3VwcG9ydF9uZXdfcnggPSB0cnVl
LA0KPiA+ICsJLnN1cHBvcnRfbmV3X3R4ID0gZmFsc2UsDQo+ID4gKwkuc3VwcG9ydF9uZXdfcngg
PSBmYWxzZSwNCj4gPiAgIAkuc3VwcG9ydF9zcG1fcmVzX3JlbGVhc2UgPSB0cnVlLA0KPiA+ICAg
fTsNCj4gPiAgIA0KPiANCj4gDQo=
