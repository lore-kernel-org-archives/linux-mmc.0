Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.152.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42581A285
	for <linux-mmc@vger.kernel.org>; Tue, 14 Jul 2026 05:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.152.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784005375; cv=fail; b=dValD2A7ySX1opNkJ9ipGApO6aIbu3dVAGFj3TanQiiRUBzP0PPJS8zHVaL+YQ2aHFoNUtrAlJTRzrHkFfx9ycV0UOxKBRVOxpOJ+4nFJxTmDMUxz+boWOv5oXVBczGlwmcfglS0Em/fG9Bp7zPZEPAXXsnPsuIE0fS2XGjONeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784005375; c=relaxed/simple;
	bh=TueCSMHlD9qfnWI1lgcyBSQlSmAcYvz4XYICq/LxV5A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qWqhLbyoQWw01FdUoREIix9JVT5lqSW0jqsun/gK5IRuNPQ0ehBUzQE5jL9jcsKM4f83RgiML+hnYRsncOwEhaY08TnDoyU8lceHBzZdCdwVVP7yu+fnE74wzlZXV1cOcQGoyV0jcdGn4rUOoa3V5FAwTTu60hxi+OtQnhSo+hU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=wacl8Wp7; arc=fail smtp.client-ip=216.71.152.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="wacl8Wp7"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1784005373; x=1815541373;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TueCSMHlD9qfnWI1lgcyBSQlSmAcYvz4XYICq/LxV5A=;
  b=wacl8Wp7baWGndfNa/TfiCCXnAWWVMeCfODswJmAREkGhPfi1Q4oxi3X
   OnWZOrAA10E6WZkRYKWTiZ1Ip3js9nkHUzMlhoXPaSdvAVhURpIywZsRZ
   YgOc+tx/bYLScXA0zpgm2+oE2nzeMHFG2Oj/4202ZKWQJvcKbcbwQ46OS
   WkmcCLl/AS0ViTkm7J5/0hf07HEfE/8Vre6wi/fN3r3yD4y/8UxuINMSS
   Qn4304rACMsBR0HZq+mDeC1cx2so6qRx78mnwKBqFH42nXaqfdOWjBKJk
   lWbu2GEBe57Jdejz1wYYzN1Hl787yHwtwcOp5t5MwLBkThchfa5Yjb8cz
   g==;
X-CSE-ConnectionGUID: CF+EDrGSQ+O7i1tswnQf1w==
X-CSE-MsgGUID: 3f2V30SjRfOeyUuNctDNjQ==
X-IronPort-RemoteIP: 40.107.209.113
X-IronPort-MID: 26140067
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
Received: from mail-westus3azon11022113.outbound.protection.outlook.com (HELO PH8PR06CU001.outbound.protection.outlook.com) ([40.107.209.113])
  by ob1.hc6817-7.iphmx.com with ESMTP; 13 Jul 2026 22:01:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BnY9lCg3sCEGze8UBr09IBPLmptiIUvgg6mjaWqdB03PTCETuYY6DktIZpCiw3oduZsMDZZCiQh5faZyFav4VVUOe+6hFHYwKj4Iff3/CxsWeWYqQuC3hS4dD3dty8CtbbxOL7U6JRsGynsPpG8t1TPBfOpolxujBUJggrG91KYOOEae04UnIBOBWJRnbwMyTWgnKbE7Dxwxl/+8kg54SeVga9RPCe9UJuHMS0+JSB80tmfmfuiUWuAcA4I7oTC16HDR5OuPUlIfOM7pdnw/ejKWRSSqokkeZWemntAhwmW85qCMGz+8gGgzX6OrYgl8E3MQ2ykbs4ga8TF4IelDzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TueCSMHlD9qfnWI1lgcyBSQlSmAcYvz4XYICq/LxV5A=;
 b=eLZZaECShosa+aDe0peQ5k/aoS58oxuV/z4xyOosZpYwyE2MUE9k0dNDZOJZFtPbRL1sLJIi/LMZfA8pR4l0fcShJEsJkS5nv2JMNWL446o0YTQ24ykqAsZue31sgFlCY5ZbZcF7fqOhji3RRA3aMlG9+ddGxCGQz/k+6sXUgszidYC7cI6pDO4BjYEEtsT59rHIXVLoC1rqarq0NIOlOKhkPVp6ll/OJ/oku9TND7LDaWZUrZCjTB7yZALNi6ctOqpCu3VXdnSYsFs5Bx3RJnNbdws1kxFNmx4wvt1YbGf5iWkNWDdxiz7kloDChaj20tLDoKW4FYNdkTZF+FDkAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from LV8PR16MB6757.namprd16.prod.outlook.com (2603:10b6:408:259::17)
 by BN7PPFBC519E732.namprd16.prod.outlook.com (2603:10b6:40f:fc02::723) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 05:01:41 +0000
Received: from LV8PR16MB6757.namprd16.prod.outlook.com
 ([fe80::957:1faa:81bc:8876]) by LV8PR16MB6757.namprd16.prod.outlook.com
 ([fe80::957:1faa:81bc:8876%4]) with mapi id 15.21.0202.014; Tue, 14 Jul 2026
 05:01:41 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Wei Cheng <wei.cheng.kernel@qq.com>, "ulfh@kernel.org" <ulfh@kernel.org>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH] mmc-utils: lsmmc.c: Add ATP to SD Card Manufacturer ID
 database
Thread-Topic: [PATCH] mmc-utils: lsmmc.c: Add ATP to SD Card Manufacturer ID
 database
Thread-Index: AQHdEtgCsVc1FpDyUUmMXgjllxqdRrZsddHg
Date: Tue, 14 Jul 2026 05:01:40 +0000
Message-ID:
 <LV8PR16MB6757B239DFE2F2CD13D78F69E5F92@LV8PR16MB6757.namprd16.prod.outlook.com>
References: <tencent_D7DC335840B22B81B4E99D8745DC7E46E205@qq.com>
 <tencent_B87ADA0AC8756D910EBF93B2F0D92348280A@qq.com>
In-Reply-To: <tencent_B87ADA0AC8756D910EBF93B2F0D92348280A@qq.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR16MB6757:EE_|BN7PPFBC519E732:EE_
x-ms-office365-filtering-correlation-id: cacdaf09-b562-427c-9dda-08dee164fe30
x-ms-exchange-atpmessageproperties: SA
sndkipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|55112099003|38070700021|18002099003|22082099003|3613699012|4143699003|56012099006|11063799006;
x-microsoft-antispam-message-info:
 SX/f0UmaXamjTXwgT2V7DwAn11c8TSZskL6uN2UYXTZZqoILx/2ipDamYdWkJdEBVd1d4OixckrArPQyc+aZA1YcThRKek0Y3WEXQ0ara0bOFqNZ9THhU8ClI5CKzRHWeE56KAP2HRq0l+k70L+RmmlJEkIaKLLBte80E46YFt8a0ixMJCzOHUWmShaKq7hy63TYNct9xW4cVw1ZxKWilwaV3v664z2pLa2XpTFlqJVnSXwd6IRryFXu2n3JnDPevogyszgBY0FRKgQfNKXNOnmxpQ/LeuM2LpLdyHdpPcPzfZvlBt4eyc+qWPtF9+qrLYNW3jInm3N27MSu10eqWVVIOrUWgYYG0rqifpan1ZyL1f0Y8i6Qk8lfvAuxiIhskRp93jlCs5KHb5dsIJidBcPTDr1LtVQOOQn2W1oK/HafkqIEj/zUoW/LWiee1rVWha7JyzOn10EhOOgxxlQkzQ7vH9QoJ1HFElYWNx5FhGvaPocB3iNoJtzDj5z9GdPkg9sR4kdP60IlmfW4oKMHvZGFCItJv5kdIQlZkcKswJXm/vxUDaZQgu9uKXB7Xy/Sj1+vitp767s9Gn6l9BvKrMX7feran/CEaRZvQmHmshXkLMD1RhfRwp8yq53Y2qCz3/M8b1cbT4ZS2yXKkrYstA+ZfogoJ3gPn0Mp/wCq+BFJ5LyDMjdX/PuPA+ElnZAEBugCUEb4x5dgms5RJgRNycnnvYF6jHCPi96E9L4d5tkHhsmyH2CgOevtynck+QbQ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR16MB6757.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(55112099003)(38070700021)(18002099003)(22082099003)(3613699012)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?F98QIKNHAFe12DgUkxxFNvYvJ8Wf39OAPRXmD74z6A/HWmuxkULdIPC7Z9Sh?=
 =?us-ascii?Q?CjZ21o0UbtajSnTeWBb9xLJvC1nNewt+kSEbQE2BqGOxHY1BsG9uk3Cq90GP?=
 =?us-ascii?Q?uKwt5Z9b8/GOsvQngllOc+4/FsbeeXvIzVlxUtnxu7AbLDxXDgAqgEzqabMU?=
 =?us-ascii?Q?LTvG4EhadwCjQgn1ebE+fstYu/9WF5DWl8MgsAC4j8l2NmoYJ+aio/ZvxZY4?=
 =?us-ascii?Q?rOitIUDX/LbP7u359BTMR7bMKBfhtES98KLkpDEqU0HSoahLhjvXYU4qcys4?=
 =?us-ascii?Q?XnNCCDDKYfh3DNTiaIo683sGTHcTjwMMxLQOrT0HAmC6aP53l/wQ+Sha19II?=
 =?us-ascii?Q?p95BSqMkBtBwfBkCiVVfrdBWxY3HUKjTiJUhydIaWrRQW1p9HDjX/YakPMKS?=
 =?us-ascii?Q?XVpuaW8CowHs3zkwhieX3L2cxJiuyzhv08ln/vKu4OX158G2jS45qlk7xpyM?=
 =?us-ascii?Q?rN+WJ1PSzsLQFm0krlH4gcGiEik3LNSzfTIoVjkedmyLGSdo1DqA7SzxgU9s?=
 =?us-ascii?Q?SrHGPu5EJx01QIR8YvuTtd2VJj+wPQAJ1rOvWYV5mAJbmc3V+sz200UHbNx4?=
 =?us-ascii?Q?Vqey9aik4jPkjivkUa9HN6MmSu+A43D+D3jHbFtAiLD+i/aovj5+C8nVzZQx?=
 =?us-ascii?Q?4Acg8kZnd/LpgxIvLhH3UGcbe1rJunHDlDYOaUnAwIPrIWz0aKwnLRc2QdUS?=
 =?us-ascii?Q?bDkigitgjN0n+H4V1QdmPA/oztWlTXt2vJf/3v49n+ZRjRaF8x6IoYiPJ+vv?=
 =?us-ascii?Q?ZFohyLA9zk2Ffx7IQZ3WV+a0Ll5QA5mUwlCb06Rdb8zvaRL7FyMpshsr6ZvO?=
 =?us-ascii?Q?v9jSNgctNKQBFF6SAeaZ0v23D8EuqvJkFWwJpyShaB8fXuzAGBTCRi6X4w+r?=
 =?us-ascii?Q?P9r/TCuuroz8Z7yOJlcf+o4pmCw89z5Gw6nxh73irJFAjgeaiWN4pzh3KBue?=
 =?us-ascii?Q?FwQXfhUp3bJAyEmDBiLVouHlVZIMF15DEpW2nOkSEPdYjy2O0OiH+15A//yh?=
 =?us-ascii?Q?uyfnhHzmZM545w7F8/3HnRBdRBWAEbiZe3Gb+LGqbvqufs0guKaZTe6W6JYC?=
 =?us-ascii?Q?gaFrOThQ2/sYJm7+Uqb95Lc/iP6BrkmuJ5JxyouI06ZTyFMkFKo/W32DOcHY?=
 =?us-ascii?Q?oWLODimX9lXlqDVOl/jHPFfeO9OGzKpA/IR/8bkcPo6pzl1l6NM0ai+MHEOV?=
 =?us-ascii?Q?DD6Q+PTfpYJL4s2JO4Lq4dQz4V538LWdXJrR2j8oKe2uVTl/K6/xcWiZYQ2j?=
 =?us-ascii?Q?PBjMfyY1z19AWlGMj/PJ5dVSEiO+V1r64Igpr1WXKBmP+NJio4nXSjSD2lg0?=
 =?us-ascii?Q?fYI0jQ2CkI+C5QnSxeJAdNuh50KJ9ffUVIjiyLTdwRdnlvXCvN/qEVNKKWae?=
 =?us-ascii?Q?60EG9McH2F4wf+7jSz2Z58FyByZxM3JpCWe80WiGpxqBFpnQB6x671t+fAZx?=
 =?us-ascii?Q?xVQ08IFm+ajf9DKThWLVgxY2/n6fp0M5zzjoY1oevhp14BKGDMMAH2W3zeTf?=
 =?us-ascii?Q?zhEFp5aUWPyvdLWsjE/pJJmA52ocY5Kq1oeFlcZ4+L5NG3Vgyh1ZM7LqXYnP?=
 =?us-ascii?Q?j0o2xy4KeDU8nQNuAnavraHHuVSMr39XkDntpJbWwqYFHZugSQv5f6bVX2Lt?=
 =?us-ascii?Q?C74lZfAVCqvlDmNhjMv6BAU28f66awxOnX45IQ/PH7cnaFcqL2AS2SZ9q1UU?=
 =?us-ascii?Q?R4OKb2IC39KmLGpHgy3Na9/amiWJvtRRVfhpus5jBFAlRP3qgXfACCBKGXOX?=
 =?us-ascii?Q?WF30gz0fMw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	PmBDY1aqhLrXAKeX+oZSQwMJTNPnmQ4wuAjFeemaTqtpru/dbjpPXMmLU0gMEukShFxb/b5aaeHVa8SSqUeRcQsd5BAZ+dFxOAHQvu+rV3sukIJ2ik/yVAar2FbPHYPkySVsdClZ4FCE4AbAEhCXDE/SbaJqBjbga5CXsPS2bYlQQa+kmu64jMEpu1gB/BWBcxIg0NMhsIB+uo+jOmG/q/EKbIZnK0NpySh/37vel/qt8YSellMZC6Xn/Ayr2gyeK3k0AvV6zGSkSczhNnl283elWi/S5rxaljsYfSVB8LvNgl7dTh5O0HoVq1LbjannYUXN7rD+NAbKyqjMFpqVdg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cMA8jE98E5SX8g0MukbaAThA7b2YagKXG7l79xR3WmYlXR+B3SbrXru+yQyEBXC73N5gNrhrOolzztCX1fK0m9RhAvutv5MWSs1yRBCkxIyuTBvwxsANBgQObH6zozLG6f+8w1dd+o4iNpjTnMRed7QaQm2kx/1ymjDc2SaU1Qv8m+MHgyegcZ+gJdKQZb2ETbN0OCN95pTO6GJ6muPmA1L78olpaPzRNdXtZDAu0Y9skMUY87wjcmc0hPZEyqi6iOHS+vA0C9EpYL6mIMOxlPM9VdUKUQr8nFWhi94sBBGb99psqoEqvSDzGezLFfZojuRlFFm89tOiwf1q3dRL0hac0AuqPq2dsghTmpIGDfSaTr8zNJra0CX9JRLKwcIuXudWFbpsVAiWI9WKtMQTflITBbEwUI6Pc/XpB0vJPuMU4IAtKI2WH+Pv8h0p2YO2ZniOH5VT9WhbXzZA8BzPk0DL1ws2fvENoJTxpEB7WK1nVj7AYvWmbJf9+PUywfJsTlVeSpJWuQok+GsDhJE5QCktEpwfKA9eXslFXy4ksZi0v7UPQDGE2n4JmyjhRyCIxeViHhnlonDaKxsIfPc5O8RILGmRqYPAn2e/YPiNZs2O2m0QiZyvHwCkuajY8RTz1bGv8Paof0/1dRBN/dp6WQ==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR16MB6757.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cacdaf09-b562-427c-9dda-08dee164fe30
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2026 05:01:41.0051
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R0JNWc/EzdDPXTAouK1PbKMBWB9gh0gxMEgcYHzpB+hxPtGu2n2SQ3orq1HQozSsE2irUggWzotJA15DAmGjEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFBC519E732

> On 2026-06-13 23:04, Wei Cheng wrote:
> >The current sd_database does not contain an entry for ATP (Manufacturer =
ID
> 0x09).
> >Add it so that lsmmc can correctly identify ATP SD cards.
> >
> >Verified on ATP AF4GUDI-OEM microSD.
> >
> >Signed-off-by: Wei Cheng <wei.cheng.kernel@qq.com>
>=20
> Hi Maintainers,
>=20
> Friendly ping. Could you please share any feedback or concerns regarding =
this
> patch?
I acked this patch a month ago.

Thanks,
Avri

>=20
> Best regards,
> Wei Cheng

