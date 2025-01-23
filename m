Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF0715AF6;
	Thu, 23 Jan 2025 09:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737622969; cv=fail; b=tkZ9Pv26PzELGU9KW/bUmyg+A+UMOYk+vb2PsXEfq4oKU1F5Vy019yDwY2AMCfYU63lbjnJJh4eioug19h01o0FlpzGCRSkOEgfAO7ZRBfCm8XvCc/dXPIyF0UBkOY6MhxCngCkTF3krm+k6R69OhDWDoJC341EuuCcoGZEOO7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737622969; c=relaxed/simple;
	bh=4IjUC2rKrFuBEjK62yCzQBesBgNtG0Bwn+1aVACxweY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Gb0yZCw8GLLUWizatvZtL9SrXUxZfE1+3hRpmXEJvdB+c3wrUM+R0xOgIT7wWblBnovcj8n5eWDvXQPmy5NIGJTntRShDikXlEUXDqLcFNW2xIPSopN8kX1+zy0BpA0vLoStShxXAowFIcE9pCus1+inm7+jcjzb5nqXA7V/Lxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=X7gJKwlz; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=m2Yyfn4a; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="X7gJKwlz";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="m2Yyfn4a"
X-UUID: cb26d532d96811ef99858b75a2457dd9-20250123
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=4IjUC2rKrFuBEjK62yCzQBesBgNtG0Bwn+1aVACxweY=;
	b=X7gJKwlzS1dFDPNKAloZ4+kMQnOrQp8ENPFnmFvB5amkkL98Zdt3w1wzQQflH4QQCbPeI6b0BXPgZ5poPCnGLZyzMA23bwsOi7Mr8aix36yisGROezfsKn8bVCwwglH0c3lEudqbEiLWs5BTraKdR97JcQr7SxlayX6UGZyyd6s=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:5a66fcc9-107d-4a9f-b050-2c4da8f381d2,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:802aaffe-c190-4cfe-938d-595d7f10e0dc,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: cb26d532d96811ef99858b75a2457dd9-20250123
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <andy-ld.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 148436697; Thu, 23 Jan 2025 17:02:37 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 23 Jan 2025 17:02:36 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Thu, 23 Jan 2025 17:02:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xeTU8O1ZUXm5X6lWL8B+kBxljeJIwpYiPZ0JjLgMEvfwHy3j6SZZ6vBKU4q8nnrgU/io1hhueVVzmy/9vbRlrBCgzAjpg9cQJA5RriP1q3zSW3K5QN2etB28Knw3nZ/pRIel/qUooDghQzqzEBrmAhlF/F0emcQOD7rYCWFCDRhHMRM0mgDdt1CjsOUg+RIbCZrBVtKyu0bvjbx+ruX2rnXMLxe3fGCb01RJjWL4cmp0qQ50VEAinFZZkZpMj+TE19BPVECEfDdaEHqhrUSsS63/h3ngh9i1xSwYu6095eY3MB6TIycgHHUeRCVZmdUeAzfIVzSIsf5OP87cI9OzCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4IjUC2rKrFuBEjK62yCzQBesBgNtG0Bwn+1aVACxweY=;
 b=xehxYw8agmNk1YuFEojtxRfTewR1f0JzOna2kMSEqZimK8Buaqpd62Pm1LacwtT51AVimzz+uBxER9Icdx/G9wvxNy3+ktwMoMLRDVpSYI2WGwi9luZaRFWvQ/8Tw8ZFEttYHTFGqjzUzbi56uSkMC/gU2he1J6ExuDEYOXiR6MKKlmDGKEs64XwHgeTKAeFobhbWV6j0XijStyZk8tqNbPrLtg1srnrvIGQSLERJ/m4OxFz4diqmt4iI8Ingt8RCAeX6MoAu/r+qSnoZtHyXF6HdF82VZo8mMpMs9M5T7kNsyBqiy6cAO6hhUaM04rjDUzkWDTgmRuVXkxIP/c81w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4IjUC2rKrFuBEjK62yCzQBesBgNtG0Bwn+1aVACxweY=;
 b=m2Yyfn4aHd2jsiBLbwl+hSKljGEbXaQdUN+LxfE6zfbELw5eZCQz4zc5j/Y1Ykc4BiNvAIPynedGgfYyhgKhzqZjRaMCPCnkadfSeqjTx9pVZIhFVfRKzSVuA05+T1HtT9QAyQlFxbe6AAZL0nVXybvtRrz3ldqdO8p4zPKETPU=
Received: from SEZPR03MB7998.apcprd03.prod.outlook.com (2603:1096:101:17b::11)
 by TYZPR03MB7364.apcprd03.prod.outlook.com (2603:1096:400:420::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Thu, 23 Jan
 2025 09:02:34 +0000
Received: from SEZPR03MB7998.apcprd03.prod.outlook.com
 ([fe80::a616:ebcb:517:8b1]) by SEZPR03MB7998.apcprd03.prod.outlook.com
 ([fe80::a616:ebcb:517:8b1%5]) with mapi id 15.20.8356.020; Thu, 23 Jan 2025
 09:02:34 +0000
From: =?utf-8?B?QW5keS1sZCBMdSAo5Y2i5LicKQ==?= <Andy-ld.Lu@mediatek.com>
To: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
	=?utf-8?B?V2VuYmluIE1laSAo5qKF5paH5b2sKQ==?= <Wenbin.Mei@mediatek.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH] mmc: mtk-sd: optimize register settings for hs400(es)
 mode
Thread-Topic: [PATCH] mmc: mtk-sd: optimize register settings for hs400(es)
 mode
Thread-Index: AQHbbWqzeIgwO/AZoU+5b8m4ZIJUtLMkCxCAgAAFKgA=
Date: Thu, 23 Jan 2025 09:02:34 +0000
Message-ID: <8375b00527c8b2a3b6a1206498f9ba671588f5de.camel@mediatek.com>
References: <20250123074442.1617-1-andy-ld.lu@mediatek.com>
	 <f7f414fc-1794-4e73-9b63-68df933a3244@collabora.com>
In-Reply-To: <f7f414fc-1794-4e73-9b63-68df933a3244@collabora.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7998:EE_|TYZPR03MB7364:EE_
x-ms-office365-filtering-correlation-id: 2c52f2e2-4f01-4586-33ca-08dd3b8cacff
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NU1uUkRUbVFCcW5haXZkWHRFYmJvVFhIK09ocTR3S2pYclhEc3J5b2NCM1Vl?=
 =?utf-8?B?V1RDV0VSTDBpN1RhQUo4THlETy9VNVFmRmQ1U1M5SndhMEFFTEY3cnBQMXhN?=
 =?utf-8?B?TFlaNEdSWTFncjlLRGpLR2Rnd2RZcC9wand5VEdFTnN3MG5TZnJHeDAvK3hB?=
 =?utf-8?B?M3Y1ZmE5YTZvUzErYVAwdFlpTXJleXpXZmJrM0VsSnhDeExOVU82My9NQkN6?=
 =?utf-8?B?MGNPZmxjZmxTL3kvZjVnWXNwejA1WDAzbGtvdTN4MDBUVURlSFB6OUh0M0Qw?=
 =?utf-8?B?ZGN5M3JxMHMxbTcyNi8yQlpCcW5Rc3drUDZxQnUxdDRpQkhwWnJrd21lVlpu?=
 =?utf-8?B?T3BubFBRcG5yck5MM2luYWx4aUorNHlrNS9VSXFvb056eUpJRmJVSWNZOExu?=
 =?utf-8?B?WnBqcUFLSHJadmNqaTJYZ2pDVmtBczhxRmFCLzNoMlgzeTNnYlIvaGdwd3BR?=
 =?utf-8?B?WFUxV0NhbUJaM3o3VzZNblh1TjdkN2Vob0o5MGxpQmtJV2Uyb3N5RERtdll0?=
 =?utf-8?B?djVsM3dlT0F3YzVLaFBxWkswb2Y5THRGdHVpaHpiWGkxeE1qS0hkWEVrV01G?=
 =?utf-8?B?dFpNMFNuK1VFUlVDZXV4eFV2WjlnYmhNZ3RlaVQ4Y0NGb2VnOWZ3OEEyQ2gr?=
 =?utf-8?B?VjdaZ3dPTmJ3RjhoemRWWUZsWW1HZjY2UUZ4ZFdoM0lmNTB2aC84L3NwN3dz?=
 =?utf-8?B?OXJRZ2dPemFTamVIOEV3RTNGeU5pRVg1OENMMW82Q0ttSXZCNXJlVG1tNmVn?=
 =?utf-8?B?NXBzREI2cmMyMlVDd21vcWcxUEFNZ1dNRGhRemdnNitaM1ZnNTVwODNKUjJY?=
 =?utf-8?B?TTZ4U3ZFc3RZYVYvelBvM0ZnNVVUMVhpU1poUS9KcGI3aGY1akphak5jOUpu?=
 =?utf-8?B?bXNkbzBGa0N6RU4yRThDZDJ6ZzBzZXp4ZDdQYVpGZVowY3NEVzQ5cVFocnI2?=
 =?utf-8?B?c09ER21CcGJZSXU3RkhETWR2ZjVaWThxVXc2RkFVVUtBczVIUGpGL2dXRUNK?=
 =?utf-8?B?OVdnbTYwNmMyTnZESWc5Q1dJWUY1M1lKeWV5NiszTzQ0VTVXVnFkOGRpZ1RY?=
 =?utf-8?B?d29mT1htUmpOUWwzbXJDWEJUSDJ1V3o3NlFCcDF4YnZCSXZUS0JLdG4zUDdl?=
 =?utf-8?B?aFpxd0hISFNWRVZCbk5aenh2NTdoZ25LSHpKZk5ZbFNzL0JJUTJXSzhFT3hp?=
 =?utf-8?B?WW92RGlFVlhxTkFGRExja2dlN0thdXR5TFZpZjJINW9HMEJKSFBPT0VXZjVj?=
 =?utf-8?B?ZE9BWlRKQ3FFbXVydkRNQ001MXprRFI4N2NKbm56QkdHd1Rhd3liWjZRVEsr?=
 =?utf-8?B?VDh2WTFTajFPOU5yb2xaM0lkdi9pem96OFRNNUdMY3MrTlZmbWUzMm5jejBh?=
 =?utf-8?B?c0IwaXVBMXFiY2RQMkdOT1pYSnQ4aEh3WjJpTVJheitaSHAyWXRmUVcwZFRK?=
 =?utf-8?B?VTJuNW0xa3VqWVdiRktqNEJOalI2a3ZhSXBNb1hXRjR0M0pwb0hZbG1sbmFB?=
 =?utf-8?B?L2hJNUlzVUYzWElOcFJ6c1dKbTJ2L3RlR2pOalhLWVI5cS9NRzA4dWxmblMw?=
 =?utf-8?B?NmwwZTBBZGZrS1hma09KSFpRZksvaWg0Q3ZvMnd5UDNYMGIxWTg4ODNPNWg1?=
 =?utf-8?B?VXB4eDlTVS9JQTk3dFpONHFpMU8zMTBvMjRLZGNVWGJoOWoyRnF5bEV3aTIv?=
 =?utf-8?B?ejVPZTdZYXJEZ3huamtGUkhKNXdDcWtRaGRGbXdmblhWa0lpVTRiQ0ROYnVw?=
 =?utf-8?B?ZTRwWFpmOGdkaTU3Nnd2WVg5S0RnQ1RXbXZnWmt0eW1td0VsNmxoaExGc2Nm?=
 =?utf-8?B?WlAvQ1RiREU5MytIOUJ3aFQrUzBjWFdidElKc3hXRHVtdGxhdEdpT0FvS1E0?=
 =?utf-8?B?SmMxYlFISHBHS1BjYXdHYXAwcVRmb2lOWDYzem1CVllEd0gvMUdtZlk5elJF?=
 =?utf-8?Q?E2lDeceF7yQc1R/5FnJ+eA0x8QrH/v0x?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB7998.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZC9EbXJEZHNuV3RqWnR0cEtXU3RDd1RnNGJsYk1UZVFsTFE4b2prVXhyS2Ro?=
 =?utf-8?B?NnpIdldob2RWVzBnREU2VFJaTHI1L1k4ZGdzWTQ5S3h1bzlRbGtyOVg0Q2pM?=
 =?utf-8?B?RnFacDJUM29nSjROMmpwaVpXVEVNa3RmMnhQN2k5Y0pobUxNUkF2cXJmSEI3?=
 =?utf-8?B?VlNVK25BTzV0UXFLVTlTb3llQi9LdnlUQm9ZRDBXTjdnbEU5NUpUd0JrNy9S?=
 =?utf-8?B?TjVMamhqSndnbjczdzBWOEFWN2wwSTlZWVZ4MFlNN3VQNnhrQWdSdXZ3UjJx?=
 =?utf-8?B?M0V5dHNyMlMyNTkvRjZZTEN5bURCZEV3WENDdDg3eG9yZGZzbnlRNk1xblF2?=
 =?utf-8?B?a1JicUVkd01KTFl4b28xaXNsU3FycGlscHRGby9zTHQ3MitaY0hWN2RTdzhO?=
 =?utf-8?B?RDQyeElZT21uVDFHODErM05tKzR2MHkvTUNHR2I0U3JCSllydm5UNytPK0o5?=
 =?utf-8?B?WHFqUlpwZFNMbnVBajVWYnpnb05YUGJkZmVmQXVlVXIzbjcvenZpakZmZDNJ?=
 =?utf-8?B?b01Gd3pncVFKeGJhdGx0VjNIc05oQnp2VjREb3h3UEhYeGk2VVp0WmRWSlM5?=
 =?utf-8?B?VGJQSk8wSEdyT2VLUm9Tb3RlbW8xV2xPSVZkYmJseXNCUTloSGJZS2VlbEFs?=
 =?utf-8?B?c2FPeTdkQWk2S1hYMFo5WTAwazFsdTRQeWhEUllSN0N2ZWpEU01iZUpQaUIz?=
 =?utf-8?B?WllZMEQ2YmtYbWVYOVpXV05OcE45cUFQL3U5dkFaSVAwcko2cEhXdFNrVmNw?=
 =?utf-8?B?QTY3MnJrak5QTlBrc2txNHVSSHdtVWlwcnF6MDV1czF0SFlrMzQyM2Z1Qndz?=
 =?utf-8?B?bldMQTlqNEtMRDRQZXBZT3JNZHhKWEVaYllaekVQcWo0d3d3c1c3NDZnNGtQ?=
 =?utf-8?B?OEs0b2JpMUVLdjU4V1dPOUEwcEZTUUJZbmFkL3JBSTRPOFMvT3dqbTJ2aHpD?=
 =?utf-8?B?bHdwbktSdWxKNE96UHlQMU1xN2dkT1c0UEpBdzQxMXE1OXQvNzlmc0krN3JU?=
 =?utf-8?B?TDZGUEdCd280ak9NNzJrNDNRSzg5QTFuTm16YTdVdDdGekJIVnNlcG9DYXlU?=
 =?utf-8?B?VnB0NUF6NHdlNzd1TFpacTN2emhxdXlUclN2aFhmZ2V3cERVeHI5ZGJVRDdq?=
 =?utf-8?B?ZWUvM2oyT2xxZVhEOFhQK1VrcUNLdEIzak5yWUc1Ui9UZnBBbE9yZGozSW45?=
 =?utf-8?B?czg4VjA3R3pTcXhhaGJqYmpyWGd0bkhjdlFYZVlEbHBxUzR3T3djUnZqZTdU?=
 =?utf-8?B?NkZNZ0xTR0txWFpQVHFPL29QcVUzTVN5eEdjU2lYMm5rRUZrazM4a1FtU1da?=
 =?utf-8?B?blJNeDB1STI2aGxZdmxDQnNWb2IyMWVLeXdVM256a1NLZ3dRV053R2VSSlB3?=
 =?utf-8?B?Q1ZpQUxlU2QwWUZXYVNZQ3dlUUJ1RU9UNXlpbmprQ3JJMWxVL3lWWjN6ZzFC?=
 =?utf-8?B?RFFDNEFYL3FhQTNoRlRNQzAxMnIyai9VQnQ0MjBsZ2dWVkt6bDBNUkdodm44?=
 =?utf-8?B?b0Z0YWNlcVUrUk9LM29uaHNsbTdqaThvaTRGeTd5UXVOYmNqQmtQbVNpMmdF?=
 =?utf-8?B?WC9mSzI3eUFEV1FzQ0hJSzRoOEp3MVgyZi90eDNMUDUxWDRnUVlYd29qSUNT?=
 =?utf-8?B?YmhZbDh0ZHV4bnpoVXlnOVppWUpybmVxRk9TOExSdW80Y0VjR1ppeUY3U09Z?=
 =?utf-8?B?T3d4eUh5czFSa1N2SlV3cHNaT2hJbDI3bTVZNUEycFVnUkcyY3ZjRThFMHM2?=
 =?utf-8?B?aVNtL3ZkK3E1bXNmUlFPcThxWmlMdEVGU3dNdWNGaHFZN3ZzUFczdUdudmhY?=
 =?utf-8?B?K0N6dnByZ3QvOXZVMy80UDlXUjlZLzZiOG5FeE1EaStRN21La280eGVHYUFO?=
 =?utf-8?B?b0c5SkhVOHJiUDhRZE9SRkVWM3lhOHZlallSVStXZ2xhdWhzTDdDNFZ2a1Vl?=
 =?utf-8?B?U3lLWnQ0T09sZEswUXZvWTVVdkNqRW9VYzRSM1VBMi85VC8rR0tuVDBaQkd4?=
 =?utf-8?B?dk03T044bU8xS3RrRDFMK1gvc3BUNmVhQ3RwVEcwYW1QSlp5WjhzYS9LYnAy?=
 =?utf-8?B?ZDVTVWhMNEdRaFhhVG9Od0szSDNhOURIRlRURTRlU2w5aEF1YjkraXdHdm5X?=
 =?utf-8?B?SGVlcG9hZ1NjSzZiZ2tHRjFOeTJSM3pBOXZ4MWxSVzVLaml4NUlTa2FqNU8x?=
 =?utf-8?B?YVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <74EE6ED08ACF1D4A9B2F7693BC13EE98@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7998.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c52f2e2-4f01-4586-33ca-08dd3b8cacff
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2025 09:02:34.0305
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jLBldZAoAps2u+ebdg3X2FRlGn5qTNTWIuE1go5BRpwiC+Gt3z7U4YqiL4VbmdUijsGaoJCWh0DgKkYmfhH2kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7364

T24gVGh1LCAyMDI1LTAxLTIzIGF0IDA5OjQ0ICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBJbCAyMy8wMS8yNSAwODo0NCwgQW5keS1sZCBM
dSBoYSBzY3JpdHRvOg0KPiA+IEZvciBoczQwMChlcykgbW9kZSwgdGhlICdoczQwMC1kcy1kZWxh
eScgaXMgdHlwaWNhbGx5IGNvbmZpZ3VyZWQgaW4NCj4gPiB0aGUNCj4gPiBkdHMuIEhvd2V2ZXIs
IHNvbWUgcHJvamVjdHMgbWF5IG9ubHkgZGVmaW5lICdtZWRpYXRlayxoczQwMC1kcy0NCj4gPiBk
bHkzJywNCj4gPiB3aGljaCBjYW4gbGVhZCB0byBpbml0aWFsaXphdGlvbiBmYWlsdXJlcyBpbiBo
czQwMGVzIG1vZGUuIENNRDEzDQo+ID4gcmVwb3J0ZWQNCj4gPiByZXNwb25zZSBjcmMgZXJyb3Ig
aW4gdGhlIG1tY19zd2l0Y2hfc3RhdHVzKCkganVzdCBhZnRlciBzd2l0Y2hpbmcNCj4gPiB0bw0K
PiA+IGhzNDAwZXMgbW9kZS4NCj4gPiANCj4gPiBbICAgIDEuOTE0MDM4XVsgICBUODJdIG1tYzA6
IG1tY19zZWxlY3RfaHM0MDBlcyBmYWlsZWQsIGVycm9yIC04NA0KPiA+IFsgICAgMS45MTQ5NTRd
WyAgIFQ4Ml0gbW1jMDogZXJyb3IgLTg0IHdoaWxzdCBpbml0aWFsaXNpbmcgTU1DIGNhcmQNCj4g
PiANCj4gPiBDdXJyZW50bHksIHRoZSBoczQwMF9kc19kbHkzIHZhbHVlIGlzIHNldCB3aXRoaW4g
dGhlIHR1bmluZw0KPiA+IGZ1bmN0aW9uLiBUaGlzDQo+ID4gbWVhbnMgdGhhdCB0aGUgUEFEX0RT
X0RMWTMgZmllbGQgaXMgbm90IGNvbmZpZ3VyZWQgYmVmb3JlIHR1bmluZw0KPiA+IHByb2Nlc3Ms
DQo+ID4gd2hpY2ggaXMgdGhlIHJlYXNvbiBmb3IgdGhlIGFib3ZlLW1lbnRpb25lZCBDTUQxMyBy
ZXNwb25zZSBjcmMNCj4gPiBlcnJvci4NCj4gPiANCj4gPiBNb3ZlIHRoZSBQQURfRFNfRExZMyBm
aWVsZCBjb25maWd1cmF0aW9uIGludG8NCj4gPiBtc2RjX3ByZXBhcmVfaHM0MDBfdHVuaW5nKCks
DQo+ID4gYW5kIGFkZCBhIHZhbHVlIGNoZWNrIG9mIGhzNDAwX2RzX2RlbGF5IHRvIHByZXZlbnQg
b3ZlcndyaXRpbmcgYnkNCj4gPiB6ZXJvIHdoZW4NCj4gPiB0aGUgJ2hzNDAwLWRzLWRlbGF5JyBp
cyBub3Qgc2V0IGluIHRoZSBkdHMuIEluIGFkZGl0aW9uLCBzaW5jZQ0KPiA+IGhzNDAwKGVzKQ0K
PiA+IG9ubHkgdHVuZSB0aGUgUEFEX0RTX0RMWTEsIHRoZSBQQURfRFNfRExZMl9TRUwgYml0IHNo
b3VsZCBiZQ0KPiA+IGNsZWFyZWQgdG8NCj4gPiBieXBhc3MgaXQuDQo+IA0KPiBUaGUgY29tbWl0
IHRpdGxlIGlzIGEgYml0IG1pc2xlYWRpbmc6IHlvdSdyZSBub3QgIm9wdGltaXppbmciIHRoZQ0K
PiBzZXR0aW5ncywNCj4gYnV0IGFjdHVhbGx5ICJmaXhpbmciIGEgYnVnIGhlcmUhDQo+IA0KPiBQ
bGVhc2UgZml4IHRoZSBjb21taXQgdGl0bGUuDQo+IA0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6
IEFuZHktbGQgTHUgPGFuZHktbGQubHVAbWVkaWF0ZWsuY29tPg0KPiANCj4gVGhpcyBjb21taXQg
bmVlZHMgYSBGaXhlcyB0YWcsIHBsZWFzZSBhZGQgdGhlIHJlbGV2YW50IG9uZSBhbmQNCj4gcmVz
ZW5kLg0KPiANClRoYW5rcyBmb3IgeW91ciByZXZpZXcsIEkgd2lsbCB1cGRhdGUgaW4gbmV4dCBj
aGFuZ2UuDQoNCj4gDQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL21tYy9ob3N0L210ay1zZC5jIHwg
MzcgKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLQ0KPiA+IC0tLQ0KPiA+ICAgMSBm
aWxlIGNoYW5nZWQsIDIzIGluc2VydGlvbnMoKyksIDE0IGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L210ay1zZC5jIGIvZHJpdmVycy9tbWMvaG9z
dC9tdGstc2QuYw0KPiA+IGluZGV4IDRiNmU5MTM3MjUyNi4uNGUzZTMxZGRmODRiIDEwMDY0NA0K
PiA+IC0tLSBhL2RyaXZlcnMvbW1jL2hvc3QvbXRrLXNkLmMNCj4gPiArKysgYi9kcml2ZXJzL21t
Yy9ob3N0L210ay1zZC5jDQo+ID4gQEAgLTI3Myw2ICsyNzMsNyBAQA0KPiA+ICAgI2RlZmluZSBN
U0RDX1BBRF9UVU5FX0NNRDJfU0VMICAgICAgICBCSVQoMjEpICAgLyogUlcgKi8NCj4gPiANCj4g
PiAgICNkZWZpbmUgUEFEX0RTX1RVTkVfRExZX1NFTCAgICAgICBCSVQoMCkgICAgICAvKiBSVyAq
Lw0KPiA+ICsjZGVmaW5lIFBBRF9EU19UVU5FX0RMWTJfU0VMICAgICAgQklUKDEpICAgICAgIC8q
IFJXICovDQo+ID4gICAjZGVmaW5lIFBBRF9EU19UVU5FX0RMWTEgICAgICBHRU5NQVNLKDYsIDIp
ICAgLyogUlcgKi8NCj4gPiAgICNkZWZpbmUgUEFEX0RTX1RVTkVfRExZMiAgICAgIEdFTk1BU0so
MTEsIDcpICAvKiBSVyAqLw0KPiA+ICAgI2RlZmluZSBQQURfRFNfVFVORV9ETFkzICAgICAgR0VO
TUFTSygxNiwgMTIpIC8qIFJXICovDQo+ID4gQEAgLTMxNyw5ICszMTgsMTAgQEANCj4gPiAgICNk
ZWZpbmUgUEFEX0NNRF9UWF9ETFkgICAgICAgICAgR0VOTUFTSygxNiwgMTIpICAgICAvKiBSVyAq
Lw0KPiA+IA0KPiA+ICAgLyogRU1NQzUwX1BBRF9EU19UVU5FIG1hc2sgKi8NCj4gPiAtI2RlZmlu
ZSBQQURfRFNfRExZX1NFTCAgICAgICAgICAgICAgIEJJVCgxNikgLyogUlcgKi8NCj4gPiAtI2Rl
ZmluZSBQQURfRFNfRExZMSAgICAgICAgICBHRU5NQVNLKDE0LCAxMCkgLyogUlcgKi8NCj4gPiAt
I2RlZmluZSBQQURfRFNfRExZMyAgICAgICAgICBHRU5NQVNLKDQsIDApICAgLyogUlcgKi8NCj4g
PiArI2RlZmluZSBQQURfRFNfRExZX1NFTCAgICAgICAgICBCSVQoMTYpIC8qIFJXICovDQo+ID4g
KyNkZWZpbmUgUEFEX0RTX0RMWTJfU0VMICAgICAgICAgQklUKDE1KSAvKiBSVyAqLw0KPiA+ICsj
ZGVmaW5lIFBBRF9EU19ETFkxICAgICAgICAgICAgIEdFTk1BU0soMTQsIDEwKSAvKiBSVyAqLw0K
PiA+ICsjZGVmaW5lIFBBRF9EU19ETFkzICAgICAgICAgICAgIEdFTk1BU0soNCwgMCkgICAvKiBS
VyAqLw0KPiANCj4gV2h5IGFyZSB5b3UgY2hhbmdpbmcgdGFidWxhdGlvbnMgd2l0aCBzcGFjZXM/
DQo+IFBsZWFzZSB1c2UgdGFicy4NCj4gDQo+IENoZWVycywNCj4gQW5nZWxvDQo+IA0KQmVjYXVz
ZSB0aGUgbmV3IGFkZGVkIGxpbmUgc2VlbXMgYSBsaXR0bGUgbWlzYWxpZ25lZCBpbiB0aGUgcGF0
Y2ggZmlsZSwNCkkgaGF2ZSB1c2VkIHNwYWNlcyBpbnN0ZWFkLiBIb3dldmVyLCBJIHdpbGwgY2hh
bmdlIGJhY2sgdG8gdGFicyBpbiBuZXh0DQpjaGFuZ2UuDQoNCkJlc3QgcmVnYXJkcw0KQW5keS1s
ZCBMdSANCg==
