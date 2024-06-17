Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B0E1BC4F
	for <linux-mmc@vger.kernel.org>; Mon, 17 Jun 2024 05:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718601619; cv=fail; b=qScTKZCGlHQ1AoAj24RnZHrwPLC7ZA99eRaWh8vmSPSRmvlP0gqn3TCRFINlJT3Ze4BRo7O1RHRmU/r0M3Rr8N6UbleFb9tABndihMYfcAp3VjpngOUdRaIK5YX60EPpdipjMiEKiv4rlT7aeLFIZKrVV79udEmCbzn5rySCn+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718601619; c=relaxed/simple;
	bh=DmOKDLb5pZDc5/LqBpzH4ZtrNQzF9HWdVmTJsoTf6OE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CbMpHrCognSZPTZWVZbfOrz6oKyLJ1sPD6tVtjFkFgLQLrRdZWCIlf6txeBMdcdNPUBTh7sKwZFpsGJGaV/mkwN3vqXua2UzVjyJeB6obpasq5SD9EspxcM+3eCvD+MGaKDcprb0Hp1ZnqnbrOA3ITp7LyOj4Cfk86tgF5f/Pek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=dggx5BlJ; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ciBbpceT; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dggx5BlJ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ciBbpceT"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1718601617; x=1750137617;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DmOKDLb5pZDc5/LqBpzH4ZtrNQzF9HWdVmTJsoTf6OE=;
  b=dggx5BlJtgaQzUMrZxhTWUfScTtQxVhpfpTEoUxbpXsr2WawseD8S9r2
   MFVR1HxtS3az8dq5+etmH7ds6eUmh3brUZ0YOwkTQuRw0VGpp/GnuWJSI
   EFGliIljzj4YdLr+l08Om9tSEHE/3QVOu7fW1rNxO/LXo3/d9xG6quAyZ
   Abufgz/w2+P8gn3lB3SEHfh0MYaKt9heQlDxJtHKOJaOK49dttUJbzYSR
   CmZDlCi/Zv/tB7hykdniEunOZ+Wwxaek9/VCe2UTnwZ+aCnbI/83nHucl
   p/apLCtn0OZG7BaG69o/vAUNUa7CWAX3oIJHyaFZXlEmJ/Ye+KKLeECiT
   A==;
X-CSE-ConnectionGUID: Eimmb+EaSvyOe0/CvdUsXQ==
X-CSE-MsgGUID: knFVswJURNG+7oi0EML7Dg==
X-IronPort-AV: E=Sophos;i="6.08,244,1712592000"; 
   d="scan'208";a="18985366"
Received: from mail-bn8nam12lp2174.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.174])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jun 2024 13:20:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=knYHOyQ5RBp53wbLOjGPOzmvnxGQKItuCxvSj7BEpgpE4CXTTApcryu7+f7AC+TwWu0sIK7uAgzXVA+wY1smUK27nDprxzjemrL6s0Ea7MINmk9UEYj5av0e5Mi1IrBDDpAdDSM+oROPOf9NZuGMTyFOzFsCBznlQWW73cr4dfWp0yej6KIJM54O+UhgocHV/12wNQKnDEnsVm4ppPex3oqvt8GwvuzmJeiWMhlv5NNbmTFXqY9nYTqe/jZQ0ujVkQAAsPTDEaAuMQyotLl2tEdHaM8H4dFSKWP6xQIHP8rNDjv6RHdu4sTKaZXwkSzH4+g3e69PQqWiSoucLPLN0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DmOKDLb5pZDc5/LqBpzH4ZtrNQzF9HWdVmTJsoTf6OE=;
 b=mnZUGqhf0hMhiiRC6g81gqFm23Q+vaSuoRX8ojn8AVue7oscLJ4UE8yMg7r0x9eD2aHXOCFRGf29AoOAFrXPMW2Qh/NkwOUOUekOMeI+tTVawxSlTeXRmmuMDUIF6RdM4ASmZarc4CqQ+wuVpZ5NgSSLIatcNdUCukJ28dDZvPOyeerwiNNE/+HeQAP5fWrgV7RaPK45UU/etIdWhRg844J8fTNwuHEmszR/0sb5kqndTBfZIzepfo8jbs30esZ/Js02b2g+1ESalNoGR2HLit71og29md7kwcbDmozJ/tFE+A9e3ECQKkWD1oLyd7+RtdvhgchUMliSKCQ/BsdC4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DmOKDLb5pZDc5/LqBpzH4ZtrNQzF9HWdVmTJsoTf6OE=;
 b=ciBbpceTDaG/+yb/8pOM6bknLlwi052Dd+Np25Yk21W3c4kfV386XHP2FrxsFc3IL3Q43hzCCC/5y87qPhUVFXJ8uJVcsvbq81vOR2kufWL6i23tJUZ9BJEyKHYI5mpcyrhS8ITQybOq7XcOVBjT+7uJlNLujk5DLK8lA3EzBY4=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 SA1PR04MB8271.namprd04.prod.outlook.com (2603:10b6:806:1f2::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.25; Mon, 17 Jun 2024 05:20:07 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%6]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 05:20:07 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Daniel Kucera <linux-mmc@danman.eu>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH v2] mmc-utils: implemented CMD42 locking/unlocking
Thread-Topic: [PATCH v2] mmc-utils: implemented CMD42 locking/unlocking
Thread-Index: AQHas4fsA4nl8i8nIEOrNn71ENxcObG79vmQgA1NftCAAYmTgIAAtapQ
Date: Mon, 17 Jun 2024 05:20:07 +0000
Message-ID:
 <DM6PR04MB6575DB735A2F439ED6DD72AEFCCD2@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240531182517.929498-1-linux-mmc@danman.eu>
 <DM6PR04MB65757FCA620263AF74F120A3FCFB2@DM6PR04MB6575.namprd04.prod.outlook.com>
 <DM6PR04MB6575AA37CBBB9993DE881F26FCC32@DM6PR04MB6575.namprd04.prod.outlook.com>
 <f3f50d420e7ee5bad0c85f8158c391ca@danman.eu>
In-Reply-To: <f3f50d420e7ee5bad0c85f8158c391ca@danman.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|SA1PR04MB8271:EE_
x-ms-office365-filtering-correlation-id: cd963cd0-0b69-4c67-7c29-08dc8e8d2727
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|366013|1800799021|38070700015;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?+4h8Sp5NKfdUK4OxHkJNZ1+xLCVzmk30KtUHD0820ojdrsIgKRX8jaH8AFFB?=
 =?us-ascii?Q?qnltAj2HehXvzSyAlM9W7sMz0/3haUaIQ0sg6cQe60DqCTXmCTlXWNkN8k1E?=
 =?us-ascii?Q?Wu2IaJl5CEcn2QSZfO69YKoQYZeM2OB67zcCUMrPwOzo2vpR+TxhcGYSdNaB?=
 =?us-ascii?Q?2SFaqO91AiDZVTvswG5cJUdphNyURsY4ZdscjzPRFABMpURH7HsSHXdfVqBE?=
 =?us-ascii?Q?MYX1yTwlOG4CENamb2aDsrK5Ldwp1D1VdT6zSSrgNVfuhQD05/2J8ZJKklwQ?=
 =?us-ascii?Q?S5v20N3n20frIWk3xkNAz0sfFueUf4EbGdn4NIJN37AYKzv9pHzfLC8YzKxt?=
 =?us-ascii?Q?oLtIqfbn1gKR5PKmaaFtoFD+LOh9ibd0aCp52K3Ty3ByzVtL5qzURNF5kdQ3?=
 =?us-ascii?Q?O9sze0RA6fitd1Wb0zHkPTBdmG407aDgUskVFcycSD21WdKT4AABImZKGqgZ?=
 =?us-ascii?Q?ECzQqn7huu7O0j8I5tzD7vNuOun3JvtqBJm3SrksyE0HcJeGyCpwF/gRyzXL?=
 =?us-ascii?Q?d7x4YE2dldrUDNCgGLRI8WsqjEv0lvm/PT0nJlZSkia6geCy8tsQ0je/0Qpq?=
 =?us-ascii?Q?pmyn9x8P2Mha2CB8TfatCQnnjfWgSq3Tlkr8nlJ+WryOMMoEY5WuUKC0JDAK?=
 =?us-ascii?Q?/zh89Ap2jpJocjOfAU1PcqJo+e0/A0tZYnVNtGh9ORwRnCKpZM/LyA4vtMzS?=
 =?us-ascii?Q?PxrFuepluQTZt4/VBGIUuc/htKOHcp7DN5Af+ezMlU6wwC+kjDQ6ct+E7HpX?=
 =?us-ascii?Q?O4XFyOfPGJteUZDTTIOnE/si2WzgNQl22nLT+zkWl1bESgaZdijls+fVjqWo?=
 =?us-ascii?Q?7lOaXdROQ0raIq8VCaqSsYi6Ss6nTv7j1p5SUfzWAfnTBfJ3dFjxZQfhPWCr?=
 =?us-ascii?Q?a1VNgWpC58HNt5uO57ejH8fLW2dTdyoFm66F8yOX4CnBmxlYtV8bRPVIe2o6?=
 =?us-ascii?Q?SRyvrFVEZKgo2qASAVUF5woMuExio++09iRATvcD5aktXpsHxd9XfJBVmQXM?=
 =?us-ascii?Q?iRCo/DslaSo6WxKx13VWEbMKqqUUR8BjD+oJjVls1FI7wgE9q/dpMmn/SA6M?=
 =?us-ascii?Q?23gm/yrDYKK4QaFlCAeVjtwrELD5Lv76OQcmvenwavjgsFeIDWxTHWSjeStw?=
 =?us-ascii?Q?95l67lOuQJxsR4aIn7U9nNiMM1z7eg2/ZYxY3BjkOZgu0q01/+MO7K6kY/iu?=
 =?us-ascii?Q?UoA0H6OtiuXt3se1fknaUb9MmO9it2ZDIGXDGEDAXXhDw3cZWPwqMzVq8oTa?=
 =?us-ascii?Q?+Gx502B4Qt22V78KPhMqgU0+EfoJ/5DbV8GLI1WeyMz7wOREjCZVRzP6b/e9?=
 =?us-ascii?Q?2e5hRkLHvGFD875vwRsr2wvM3vpiamLHyrVgmWwKZYWG+XVa2hjbl045e4Su?=
 =?us-ascii?Q?i0Gr8P4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(366013)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ZvBxDxHb2JBuAynYNlPcBo2Z1uob7ijZ0rhRJUlSiKXLQMhoEpeWcrn1UhuJ?=
 =?us-ascii?Q?3bKHtyOkpwvbOd+IctxQZ93mhMagAegW9/VWdYcPVgLaXlChKb/jGJrg8/I0?=
 =?us-ascii?Q?wN80Na7yzNxK/1TnIokXCqHGxBOE4QMbxB4kCxekr57naMemF5/scpDJLEOb?=
 =?us-ascii?Q?KDbyLpmTiZZVl7pgcPPRfUM0xPbXQ5HtcmbZuHCWaTlITczGZ8UxW+iEWR1h?=
 =?us-ascii?Q?HestZhjF85Wn3K0OzfhkGoOn5Q2Eh7SKrhOL9l2GzQj25NZ3aCV8FcpDXwxq?=
 =?us-ascii?Q?IcsSb7bG0gytFDNxEFmHoXyXA+omEfEZd+NiKw+dRPJQmMVmjy27ABg22qbu?=
 =?us-ascii?Q?h1XFIeHyIeKquvDJGHygAtFMuhxc3DRYhYKtIl8YoyNiVVeiltKnfqasAXtZ?=
 =?us-ascii?Q?Mg4kyV7gOP5//vVAFpoFQTgdY1N0t1yjZCfH6O5rOciQ5qjKsImoKLYWM9bF?=
 =?us-ascii?Q?j/350wPlKnG6uQ1FYMBvXLSeXM24mZpV3ehpzste8PQlIsML0iLGW5kjpijH?=
 =?us-ascii?Q?n3mhDfHY90yj+rT/oQpv+6o98af5Ym8uGPU0Xx7TjcmKnMpI6zRA1OBj2Af/?=
 =?us-ascii?Q?Zfbx4Vp+ka+Y3mjT4hvzMFpNdgxAfD7AzSOsvt2K02C/KdY7wz2C8bPi0jeQ?=
 =?us-ascii?Q?UvvLHOlJRklcwvN3vq18bLnnCBrR60BI9GH27dpEld+SvL+92qa7PAVjItDY?=
 =?us-ascii?Q?WeFXUymvNT3ZoIc23dEE8IcI+ULbZxgJnSE4+OZxfbN/PWFX6w2PpKZZQnxB?=
 =?us-ascii?Q?xiOkjDBMADcqmpvyjb5sUI/vlOUCUfs/D1625VVnbFObLFrt/NdPabqrauqA?=
 =?us-ascii?Q?QG6BsjnycO7sajv66wlm8JKUWzWskSmSYuHKMSTMs8EfqByo81q4pV+4ytT2?=
 =?us-ascii?Q?pD5RhEhn4cvjJtVwLBe4o3UAtbwOUlQnWa8m3F1k+l47az+jVVaRaNIB/GHP?=
 =?us-ascii?Q?/IusL1sTJjAC6zgZx53ndQCxANny0JKeO5uaEzJbU5756KbQHqQQr4ZIlz69?=
 =?us-ascii?Q?tTM3CcmuwUMfXHTMcr0IvTPwGK45WLmy+75NLxjwNkoq9Mg+cZ5M5gtpyKQ6?=
 =?us-ascii?Q?C7Y+HG8SxAsvjERVR+C4GmPM3G/9kQ8rbr/YznhxKSjhYMC2J2O812uGBvyl?=
 =?us-ascii?Q?hVmR2dM+VbhVt6OHQs7ntYz44SMzFe3fEi0g7LyqVhtiOJn89VE9USormMJh?=
 =?us-ascii?Q?P6ePHsfgSI/54co8gmc+EaORt1cVtDBkDZxk5DAdePgdQw4Nfyb8PZ9mKxci?=
 =?us-ascii?Q?HrDXjs/cOBwNRgmEsMfvxOwrFfef6wGiiLi5stOJoBMLkWWBleGb85efn3/J?=
 =?us-ascii?Q?ANZ8d/7egCLDRzKHOMViMOkT/yINeYDPgJCx2HkSaMzbqfOPfHuKhCg8lG+n?=
 =?us-ascii?Q?XEo2sGUJ6Il+GIVAmK1RcsnkdZWSRHfBjY0UFhAvAdVtRQ/nhArvvmP2mfPS?=
 =?us-ascii?Q?OxMmEd8r/wQSRSN8Kb6XoxmHmsOpZnayJIsznD7hucgj9j5/peUcLNXSuMJf?=
 =?us-ascii?Q?NSVI5bjoCOaj0xdrnoywxxqyFb6JSpznVXYzimFTOb9ttlxoqP3/WGzbQgY0?=
 =?us-ascii?Q?EYfG0hUM4M9YSq6GBiV/wq8oohBb8Vg1++JNkyGS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	T1j7j3fdHi6Sz4TSshsgJ4HHVq8ZZB6CauWjvIaHxQ4IDTmOCdovpeaM8hTyoRP1WK1M5lUPXtmCy1C8E/M7gvBSRU9jNMIRT8uREeD95OoiRjh6ahirjlRZ5ac9X0vA2oCTWOFnc4R2CxB6q1qdFZjsfcSEql6Zt5MebgO/VtskHecv5z/x/cTo++fVNVZ6N64DSI4p6DFURxhzw1cafS8jIJrQa6h7binv1T6s9Wa+OfafRhscjZy8XA4qD8r8+Y8AYS/gau/avfW8R9mmk81SugCXpzI3KpzAP1rkE0MLHt0m+3hrfTiwQ7JwccFWKdmlIDwKkcda4EAuLJcfLe1eoouAaaiDEP/1RK42512q8HH1hZHTMb6nNpY+Dqwa94l17jYhlimtAQtSO52t9W04GaCl2ujQahU4QmKRqL42gHGYzG36MAxGrfhcXp2fXAaKxRRIfOureoura6DQwM3MIK/u9hs5cVIXoZv+9TjJfI63aWYUulIiGhDAZq7akUQ2a9WbfimV1672MkgMN2Pn0E56AEzYAPz3W7NaVLwsslRVowhWFp4ucfKJ5McH2lpt41ISjvR2RjK7WLeU5TZtb2+5h/s3OamcbAEgrCJNdKTHnC57ryz94TikwKTf
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd963cd0-0b69-4c67-7c29-08dc8e8d2727
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2024 05:20:07.7999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +NaGm3r6Vo0Uluc2Eqck7MxfDljX5ppiFijGOGDaICRxvpkKvFgYjG2c7qbqUHxG4DVsBUx7GhCojoomFvjLDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB8271

> Btw, can you advise how to make the kernel patch merged? Shall I ping som=
eone?
It needs to get people attention, and comments.
Personally, I find it interesting, and even would like to test it.
Will try to get to it sometime soon.

Thanks,
Avri

>=20
> >
> > Thanks,
> > Avri
>=20
> Thanks,
> D.
