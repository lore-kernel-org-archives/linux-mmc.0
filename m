Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022087.outbound.protection.outlook.com [52.101.126.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFDE25B0BC
	for <linux-mmc@vger.kernel.org>; Sun,  5 Jul 2026 10:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783249169; cv=fail; b=INsFrD1mgn6sQAGk/E1urIeCplrnn3hF88Z/9JLFiyHWB+T8gFkDGLuA/0+Zwr5WGCrf7HZHxUI5HuD5pCsqKWnErLn+Bl6/v4CpJjwKddK9YIEO3/wghx1ztukbvHepG1+nfmtwttJ9fgu2HdJbIZ+wTwjW0ZQBwFgbEYvcHE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783249169; c=relaxed/simple;
	bh=MzDuLWrK93F1pA89VrrRvcrGuoywR6abohTnoO/sRug=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=uDgVYXeFWJDDY/KXAISlRVCvVaxin8fMecRFrhdCkdcpOf4gzyX5SA8KWMIqjS4Q+agOdB4viPeB0HB3smZ99uoCsyo/72+LojsI7C2HUR5y6Vmc6KkpYya+4UVPxUPHjA3HdX4nskoqkQZLQebtaUSMb4326PPpyRQR4nslfAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com; spf=pass smtp.mailfrom=transsion.com; dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b=DPiEY00+; arc=fail smtp.client-ip=52.101.126.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=transsion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=transsion.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=transsion.com header.i=@transsion.com header.b="DPiEY00+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bhHysUfp/dsxM28jyBRvGnnoDNVG4ATkmkzHbX4K/R95x7DRg257J2BGfxDlRr7cKUtyrF4NNMHUjmxOyS6HPSoT1ZCj2eA6s6wnQJcljemwEaQdtmWTZMzI3EcXtO+lvCimK0riPdEtqFbuJpF7Y8wfBBlq52HEsxIm73sFP+PsOC99t5d/3MbGaRU6WezxuzOYdQJSelgvY1NsvKXqKqKOWvy1xTEpg2+04Pl+gUCfGjGXK/SO4M9l1Tj+VkW+WAu2YMfZFb+4yTUWq24Z1tVouz/C9YR3+SVbuYt0mnXgbfnXfWzW6u4281v3KKF16kcCX28EgAhFHvp2wI2lXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MzDuLWrK93F1pA89VrrRvcrGuoywR6abohTnoO/sRug=;
 b=U0renpNvrx0W77yKmcCnYTHxeK3cT1pOKlHde9QPdhFOOhgbTK3lZmqkOYsP3KtgGGLUiursIiPeVO4vkD9lpkGUuT5M1dQxPioh1ow0fO3rtAD3rH75MEeDCU3qpB4r+LgBXUfUudpCsUNL/rAhNQOrvrNgSua7TMTJguy+k9xJN69pgFgT0JTdeq4fCGhZZxhu6fJZ36/FujOUiDaGaEfSQNLs78DIvhRAyYF15mP6mAE0nBHdZ7PSa/I/9jY1kvMQN0dx/ScB1XzSFbS84gm5rLm6KqsCCGOzVBNS7qo8L8smcA1dgZJrXe6/Ttzrw6hQCBz7MYCL+qAqmG6LxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=transsion.com; dmarc=pass action=none
 header.from=transsion.com; dkim=pass header.d=transsion.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=transsion.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MzDuLWrK93F1pA89VrrRvcrGuoywR6abohTnoO/sRug=;
 b=DPiEY00+reLRR4K+2iBtJU/KURGFbwDQMl+RNZFvQoPEScknhyJOUyvQ38J8ERLyNvxqWloFq1Uly//JJxG7k5FAsP3Za+TEz3V3OjMcbd8DjEDuhfw+51mO3X4BsLKoyBF1G0qJXwSd/8eyXC6E8hr5fNYSqzYb1aIFhqu/rb8=
Received: from SE3PR04MB8921.apcprd04.prod.outlook.com (2603:1096:101:2e8::6)
 by KUXPR04MB9418.apcprd04.prod.outlook.com (2603:1096:d10:9e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Sun, 5 Jul
 2026 10:59:24 +0000
Received: from SE3PR04MB8921.apcprd04.prod.outlook.com
 ([fe80::ebed:1dee:3932:9ba2]) by SE3PR04MB8921.apcprd04.prod.outlook.com
 ([fe80::ebed:1dee:3932:9ba2%3]) with mapi id 15.21.0181.010; Sun, 5 Jul 2026
 10:59:24 +0000
From: Ao Sun <ao.sun@transsion.com>
To: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
CC: "beanhuo@micron.com" <beanhuo@micron.com>, "avri.altman@sandisk.com"
	<avri.altman@sandisk.com>, "jens.wiklander@linaro.org"
	<jens.wiklander@linaro.org>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Hongyan Xia
	<hongyan.xia@transsion.com>, Jiazi Li <jiazi.li@transsion.com>, Ao Sun
	<ao.sun@transsion.com>
Subject: [PATCH] mmc: block: fix RPMB device unregister ordering
Thread-Topic: [PATCH] mmc: block: fix RPMB device unregister ordering
Thread-Index: AQHdDG1XO/m3q5FHI0eWeqkT/BL0AQ==
Date: Sun, 5 Jul 2026 10:59:24 +0000
Message-ID: <20260705105843.168-1-ao.sun@transsion.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=transsion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SE3PR04MB8921:EE_|KUXPR04MB9418:EE_
x-ms-office365-filtering-correlation-id: 10be1b70-cfee-499d-1c56-08deda84799c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|42112799006|366016|376014|38070700021|18002099003|11063799006|5023799004|56012099006|6133799003;
x-microsoft-antispam-message-info:
 BRGqBCSoM7POTmx7wWqmFeMGw3pi0PPMMWOCmcbfrilJ/46L7NtFcIGZ8wE8Ai97YaF//OKjBLQf34dpvxRcx7E1TrasQx/Hp4hpcPMMdGD4dqktXH5jYbBQ8hDgEbf0hCJXego8lDI4vdVd03twSPQsjAU2xCdrNR6bEwWEw6m5keWse9uz9U/jrsGyCVGR+p+aS9eEdkowHKMmmYAAIxbRog6BR39T56eid1Y5XTvUv9TrhYF5QfC80ZyJDzqSqeFcaUm1T1uHO56MUxyeeiGGGD/HWcwinKWPT7WAv04ljYViYlEi3fhgjR9Fw5MM2pP5RXnkZXrPyIfYkVV939DqPP/2X62OhZEzS4iFzpy61K76EmL/awHqfQhrLMK5kR5uW0f2e4WaHxk0LzuLBp0YnWX3hscAk02Vd6wpc60KRua/gudz6hdpNvj+UOMyx8OIsHRJqeUSCr75PKOMjYkEVDOrlBVXD8JRNSrz4mjz+WNh2dmFtJxFpXU+EDLyK1Jl3Nd0keH+ne31ziC+RAgrj3WLqxsiFA4qU2WhPU7y3e9MwlnuHQWjvuvLQ73JH2CGOXIY7RXpHw2P3Sm9VsanPWiRSVibc5FpvxW/gC2POQnf8ipGndfj7cL/MWz3y8A5P44hbfTqfZiW18LtYyHo4eX1A11qcujivGVJM26KkUS4y2b1Y7IPn4HmW+VjEAnwhjyxIgaeqb+OzHMjMTnSpaAOiFGbS+4fuGOlBC0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE3PR04MB8921.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(42112799006)(366016)(376014)(38070700021)(18002099003)(11063799006)(5023799004)(56012099006)(6133799003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UTF1cDJjQytUUmtCc0NGY0JYNGNKVXNzbklGWjNHTVcxYlRUMjJQL0ptbnlZ?=
 =?utf-8?B?bkFBdTBBbWdKV0Zva0twTlk3UzRQRHZvL01Bb0lEYm93RVRIVnhyNXhoUE1M?=
 =?utf-8?B?akN6M3NVdzg0QUhDcFRGUGJIYmpaU2U3aG9tV2hNbm5PZVhnTnNkT0pmYlor?=
 =?utf-8?B?TlBIampLMDJJd3J4b1Y1UnN5TERYQ1NGRkRpdzlBSDA5Q1NsTm1lRW1JYjh6?=
 =?utf-8?B?WS9TdWFaandSaW9tNzVZUEVsbXBaME1IQ3BnOVpjL1lieGliWVkyaVJVaGlo?=
 =?utf-8?B?b21CTldiL1JSaVF0cldRQ3p3MnlSZU9FVmplK0RPZTR1Z2JFcVIrenBEZXVu?=
 =?utf-8?B?Unp6MFdBVHNEVUcvQXBaZkxHVERUVTVuZU92NnRrU2Y3QWhZZkwrQ0ZuRVhP?=
 =?utf-8?B?d1luNnZJenp1OFcyMjdGNi9jVVlmRjB5cGU1M3JhZkUxVGdWb0plb2JxNTYx?=
 =?utf-8?B?SW8yZHF2QUpXTEdReW1VZFZMTXlFUzY0dk5oNUNBcGdlK3dtNHhPZHYyaEZI?=
 =?utf-8?B?VmlXQ3F0WU9JNDZjajVPMExoNnU2VFhUZkFrY0ppbk1PSFYvalZvc1VJb05N?=
 =?utf-8?B?ZFhFeUNBTGQzOVZ4czBIZVc1em5qaUVZTWZaT2J6Q09oZVB1d1ZQenI2ajFu?=
 =?utf-8?B?Tnhac2pqaW1QdFNuZzN3bThmZWprUngvbGN5T1ErQXVVdlhoZ3paVnlJWkVT?=
 =?utf-8?B?aEdDWStBcmpoWmF4V2NobWJNVnAwOW8xd3JMcHhtUkhmd09QZUMxT0orZFQ5?=
 =?utf-8?B?R2VjV2FjVmNJbTZRRTBSQW5QcXV3dllIRGRDVzRiZnlnWFUxZ0huNDFmdlJn?=
 =?utf-8?B?T0NpRXFGOVBXVmN2VGEwNk1QRXNwYzhoWmlhN1RWVmtoV3FpVUcvbU5QSHBT?=
 =?utf-8?B?QjZTS3ZxNnNnNXZmRDVLeGUvSU5reTZkcDNRaWd2d3pjNWhRL2IyZWUwY1Fm?=
 =?utf-8?B?Q3BqTUUwY05Ma082MUhPZEhsTklUQUZYdlBxS3lYNy9WSDBJN0VTWm1QcUp4?=
 =?utf-8?B?cFduSGZUNGRDSWRxMFJ3cEJ4dCtaT1ZBejU5VUtXU0VlbER1UHNGU0s4OW5x?=
 =?utf-8?B?NUd5RnRmTmJnVngwUzkyQ3A0Zjg5UTNSRDArb2NBU1hzN0M1SlJSSmxaa0g4?=
 =?utf-8?B?eGVHbXBWZTB6blY1MXJId1VlTXJFMW4wUWM1eVYrOVdCUzFHZkFVcnlmeWI1?=
 =?utf-8?B?elNhTkNmQ2FIQTh5USt3RnZuQ0pZRlNjRGplNy9tZWd2M2Z6cUdEdnZHS29p?=
 =?utf-8?B?cHg1S2tXSEVFQ0cwdGJQUkEzaGpScHI5bGVjb3lYcitkbFFvbVZybDhjYWFI?=
 =?utf-8?B?OW55cGk4QzhKL2x2ZmtkSWc2V3N2ZUNIN2kzZTRHdjJTdURndU1sekVjbllI?=
 =?utf-8?B?REpMOWQ4R1BaRUFaaC9oYlJNcmlTMC9IamZ4aDZrKzk4Qm83bzJyZERNRUtW?=
 =?utf-8?B?MllKdWw1dnJYeXhhY1pBWlZhRnZvYXlDZTYzQUFGYU54NmxrSUdraVhnVU9l?=
 =?utf-8?B?RG1Ub25xcHdoT3psbTFLaTgyMFdSbi9uN2xpY3crZzJTTGQwTGdnbmZ2S1Fl?=
 =?utf-8?B?Sk8vVDgvejhyN0R5d1RndTVPRlNqSGpMc1M4VlRELzYvZEl4ZjhoZEFuM2Nr?=
 =?utf-8?B?T3BuM0R4OXJ6aEw4aWhsRFlrbTVJYlZzdlNvOGJvb2laZ0oxUFIydGE1NGda?=
 =?utf-8?B?ZUJqNXFpZEgvVklnWjE1RjJoalY2Z1NqZmx5aHhPdDRiL2JWYWtvVitQTnFw?=
 =?utf-8?B?YUd3WHhTNUlYNURTNTBIY2wvR2ZNYUVoY21DbGg2cTFtQ2lHaWYzU2pnTnJ3?=
 =?utf-8?B?ZHplVHdyM1ZObjMwNnFVMkZsbUw5RTVLaHVRQkFPU0t2czhjSXRRZnVYWVNn?=
 =?utf-8?B?RjRMcTFuRUVzNWptdUJ1bWdQbGxKa3BpOW5VeWIvaDBqZnAzU0MzbjJSVk5R?=
 =?utf-8?B?YW5GSVpkaGIyR3dUYXA3OHlNWnBCa2ZKUEk4eEtQNlhsQ3FzRVEvS0lrZ3RT?=
 =?utf-8?B?WkVFQmxzTzFnQ01aZVJzR1lQcThLNzdMTG9SR0JDd09yeUZIUlRSMktZMkJJ?=
 =?utf-8?B?U0Y3dGFNU3l5K2JZSUJRSVUybXRlUlVMWUUra3dldTNQYmxjV2xBRm9xTjF2?=
 =?utf-8?B?dG5BYm9qM3ZaazRPeXBlN05lMUtEek9jVUVIUHZqQ0tJb0FINCtsc1lnakI1?=
 =?utf-8?B?TlJDM0EyL1hHd1pqMVlPOFkweTloVkoxSm05azE5d2tKT0ZRSVRpdTcwK3lL?=
 =?utf-8?B?TVUyOXRQZS8wVHFDWDVBcTU0QkkxenAxK2tTQUlKeXdMd2ZwdU1wRUZxZlRj?=
 =?utf-8?B?ZXowbmREVTBaYUI2STVjLy84TkczZFFFc1NxMURCM3NieHMwL2pvZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: transsion.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SE3PR04MB8921.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10be1b70-cfee-499d-1c56-08deda84799c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2026 10:59:24.3816
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2e8503a6-2d01-4333-8e36-6ab7c8cd7ae2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pikrldL95HpdichfvQ3yDWeCYXzd3NQlBPB0sDzd/cFKGjLm+nos42ruHfrlKJ3+TvFeEUNg4kt76yhAn+0DtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR04MB9418

RnJvbTogQW8gU3VuIDxhby5zdW5AdHJhbnNzaW9uLmNvbT4KClRoZSBjaGlsZCBSUE1CIGRldmlj
ZSBob2xkcyBhIHJlZmVyZW5jZSB0byBpdHMgcGFyZW50LCBzbyB0aGUKcGFyZW50J3MgcmVsZWFz
ZSBjYWxsYmFjayBjYW5ub3QgYmUgaW52b2tlZCBpZiB0aGUgY2hpbGQgZGV2aWNlCmlzIHN0aWxs
IHJlZ2lzdGVyZWQuCgpSZW1vdmUgcnBtYl9kZXZfdW5yZWdpc3RlcigpIGZyb20gdGhlIHBhcmVu
dCByZWxlYXNlIGhhbmRsZXIgYW5kCnVucmVnaXN0ZXIgdGhlIGNoaWxkIFJQTUIgZGV2aWNlIGlu
IHRoZSByZW1vdmUgcGF0aCBiZWZvcmUgdGVhcmluZwpkb3duIHRoZSBwYXJlbnQgZGV2aWNlLgoK
QWxzbyBkZWxldGUgdGhlIGV4dHJhIGJsYW5rIGxpbmUgYmV0d2VlbiBtbWNfYmxrX3JlbW92ZV9y
cG1iX3BhcnQoKQphbmQgey4KClNpZ25lZC1vZmYtYnk6IEppYXppIExpIDxqaWF6aS5saUB0cmFu
c3Npb24uY29tPgpTaWduZWQtb2ZmLWJ5OiBBbyBTdW4gPGFvLnN1bkB0cmFuc3Npb24uY29tPgot
LS0KIGRyaXZlcnMvbW1jL2NvcmUvYmxvY2suYyB8IDMgKy0tCiAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvY29y
ZS9ibG9jay5jIGIvZHJpdmVycy9tbWMvY29yZS9ibG9jay5jCmluZGV4IGMwZmZlMDgxN2ZkNC4u
YWJkNWFlNGVmMmJhIDEwMDY0NAotLS0gYS9kcml2ZXJzL21tYy9jb3JlL2Jsb2NrLmMKKysrIGIv
ZHJpdmVycy9tbWMvY29yZS9ibG9jay5jCkBAIC0yNzc2LDcgKzI3NzYsNiBAQCBzdGF0aWMgdm9p
ZCBtbWNfYmxrX3JwbWJfZGV2aWNlX3JlbGVhc2Uoc3RydWN0IGRldmljZSAqZGV2KQogewogCXN0
cnVjdCBtbWNfcnBtYl9kYXRhICpycG1iID0gZGV2X2dldF9kcnZkYXRhKGRldik7CiAKLQlycG1i
X2Rldl91bnJlZ2lzdGVyKHJwbWItPnJkZXYpOwogCW1tY19ibGtfcHV0KHJwbWItPm1kKTsKIAlp
ZGFfZnJlZSgmbW1jX3JwbWJfaWRhLCBycG1iLT5pZCk7CiAJa2ZyZWUocnBtYik7CkBAIC0yOTkx
LDggKzI5OTAsOCBAQCBzdGF0aWMgaW50IG1tY19ibGtfYWxsb2NfcnBtYl9wYXJ0KHN0cnVjdCBt
bWNfY2FyZCAqY2FyZCwKIH0KIAogc3RhdGljIHZvaWQgbW1jX2Jsa19yZW1vdmVfcnBtYl9wYXJ0
KHN0cnVjdCBtbWNfcnBtYl9kYXRhICpycG1iKQotCiB7CisJcnBtYl9kZXZfdW5yZWdpc3Rlcihy
cG1iLT5yZGV2KTsKIAljZGV2X2RldmljZV9kZWwoJnJwbWItPmNocmRldiwgJnJwbWItPmRldik7
CiAJcHV0X2RldmljZSgmcnBtYi0+ZGV2KTsKIH0KLS0gCjIuMzQuMQoK
