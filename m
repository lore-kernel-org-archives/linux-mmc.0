Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AB6142903
	for <linux-mmc@vger.kernel.org>; Sat, 10 Aug 2024 08:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723277506; cv=fail; b=oj8ko2o+FEHQ+3ISqdHlRsbYRk0s8WjcQJ+6kcAPikdR5yPJMhozFQfyNvc1NoJv3OYjc6r0KxTA4AKpXsBpAbfUXVT7ZPTKy7RdRc45QjTHon2j4spviWZ4eQHjVqFxDuhjKpPfcM5mseBt9s8l9KcZiIjt0Fd+Eu6INhrMc1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723277506; c=relaxed/simple;
	bh=RlXzHssSm3fu15PReqO1jkyPoEDSZQqlGrdb+lGDOGo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qQQxRfY1QXOw+IRsmiTcp8A9yVvdiYFzA4J143M4Ix1IUWJCePfLu4+ipRa8ExhMNTXq7468+ySMNsyHrU5Esu2nH2R+r41/ttaCRw8iNJ+cow565uNN2ce1+OsX7Eu5bm4/+jcQ+erP9v1M3F6aFsjKq9wwF61Ra61Q2SCzu+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=EWo/3vlb; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=lr5B4Rgs; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EWo/3vlb";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="lr5B4Rgs"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1723277504; x=1754813504;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=RlXzHssSm3fu15PReqO1jkyPoEDSZQqlGrdb+lGDOGo=;
  b=EWo/3vlbgqjEOa6mYHU97q+2rEyHEgOvpmWXnzo+Aw3kWT/TZx3kSqBY
   YiLkWhKW/8v4CZGioPacGL0O6+L3qElaVGLHu0THGj8TK7GvZLoMvXfi8
   Ac8QcjD42efjZNCbin63yoLo/oFWRps0qdPCiYm8udLLiX7IMibM/uXcV
   Fiiwy4970BVLl2VJwCWZ8BNuBiGft8+kGHpBRyJY2q7qEpCqhGi8lHfsb
   jZTAq6bEyaIVBbCB+NGky59Zow4u1v/qtPdwmatBH+O3uwl2zUgJsRq6Z
   FxicfaUv11zEpwY5TMozptApHDgZTOBJHfaHj5W4VpXl4fgbd5Zpo94x4
   g==;
X-CSE-ConnectionGUID: b4Q4F6CaTuOPc854d15kjw==
X-CSE-MsgGUID: PoqXZco0ROa4KKLFrHq7Xg==
X-IronPort-AV: E=Sophos;i="6.09,278,1716220800"; 
   d="scan'208";a="23365112"
Received: from mail-westusazlp17010003.outbound.protection.outlook.com (HELO BYAPR05CU005.outbound.protection.outlook.com) ([40.93.1.3])
  by ob1.hgst.iphmx.com with ESMTP; 10 Aug 2024 16:11:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i6PKJza1y5V8RFLyZ16o2z0ZtSTPudeP8KLEzP02N0aWT5JEvAYfXK6UrhXLu7UgYXc75aduC1YytgvSRdxfp1KJ9nA4nS2gX+X+FZwlGfrpkLr07t+BAbW8HHKtWQJiV3b3y5CPx79W9vYImKaKY2TwW/ojr9dZchPWNJUk3hjvsFblijG77YtmUEY4MEwQUJB6CswtNWEZM7lszfwYqqRbUYGkb/vvCFFCtqoWx1x40w4Y1Vz6pyV2Ta1Yr90RRb76JP7dVWnBB/mCvOFh3lgysNaq/Dk4cuqhJz39SJRmaO5jrjLndOifKYKGY2+adowImkxAPhVFBy5ZXsYuNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kLs0yN3aZlf/QDXQB33TydBKikxa92cKWcBnTIPaORg=;
 b=d5kcr9blDZ2o1T6dju74j3ae4RJnAE2KaZndR+eSEmoe1j4U5+NK5dx7MpPs/Z4ypYKo+R8bx3ds5qbjdx7kwHxcaVHCjxWDLr2OR7dp8Nfe7X+29tHwxbVC7Jhfxc9RnbubT3gurW/SpQSsLvwAitGpKRerlYEzNm2N7ca34xnMjj3VaG43pnb5nc/W7AX20F3gNRgn1p/1IOkC/aKG+85AcUehST1uWh9zgT+ocWFN3pB+yRx00Bx40djd6JAbezmgdPkz7MU2v4Plac4p+m1w1lTYgMyIo7YsNr+j9X+Nv/AdbSnO4ZLTyI9BkQALZOC7NNOHTAwJelQge2ur5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kLs0yN3aZlf/QDXQB33TydBKikxa92cKWcBnTIPaORg=;
 b=lr5B4Rgsj7+GH0OLyausLZh/ekVRV92D0KrOs1Mmu65GIuiObbgnjkJRPTk2ar20eFt6MIphltaJL9W4iV6o0M+qnZ9GYsa4Nl+aqHLF72IpdpkwNeKi94d2p19fCCQtDqxDhVkuOhTGxoZBk9DA36yeMu2R3XMP+GrKI0uYWNs=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM6PR04MB6283.namprd04.prod.outlook.com (2603:10b6:5:1ee::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.19; Sat, 10 Aug 2024 08:11:32 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%3]) with mapi id 15.20.7849.015; Sat, 10 Aug 2024
 08:11:32 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Ricky WU <ricky_wu@realtek.com>, Ulf Hansson <ulf.hansson@linaro.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH v2 03/10] mmc: sd: Add Extension memory addressing
Thread-Topic: [PATCH v2 03/10] mmc: sd: Add Extension memory addressing
Thread-Index: AQHa6I+6sCNyl2QI8U2Sd+uvVD3NEbIeswAAgAF0vEA=
Date: Sat, 10 Aug 2024 08:11:32 +0000
Message-ID:
 <DM6PR04MB657533DA86FD43B3E838E92EFCBB2@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240807060309.2403023-1-avri.altman@wdc.com>
 <20240807060309.2403023-4-avri.altman@wdc.com>
 <94bfdd1ab7bb4e998097bb4575b2a821@realtek.com>
In-Reply-To: <94bfdd1ab7bb4e998097bb4575b2a821@realtek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|DM6PR04MB6283:EE_
x-ms-office365-filtering-correlation-id: 936c5d6e-c000-41cd-3ed7-08dcb9140b7d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?E7pcZeMSaHaWOJO4gAAXtAKwslyNXRUl+NWHymeHbJUC031sOKkLh1m6Gi5+?=
 =?us-ascii?Q?gNmy6Wu+W1mmzCqjLMlStWWlgyp4VQpIyVViFqQqNIAQAR5aaAT96SwwG+Vy?=
 =?us-ascii?Q?VY7lY8+OFzPrs+UQBfyEpfC648bNLdXO3ICLldfUYddz1Cvn8ks3NhNgsmCe?=
 =?us-ascii?Q?l8Ll5zcwNH4UoU5RDblYECwP1oZvj2XMXsSqSQQ1B7HBV5sonNf8WBdkGZfI?=
 =?us-ascii?Q?RyoKMEk9mIY0hHwEgt7UxK6DojDO5UnrISsZLPWEycap71c42af3oA/My0Vg?=
 =?us-ascii?Q?3zo36lYr1JWRAByVhStmu+56j9w5QdsatXTAX7MCAStNS+lNxgVZ/nM95aUP?=
 =?us-ascii?Q?/xQfrsb41ZQT9GWmsgyJwHh0Ed+5G4/KfhRy9YjfPqVqNAPJ5pSCfSk2zT0q?=
 =?us-ascii?Q?1M3nb+/JV/GLMpZAGlg9xmXuM0+k5tY8oAQYF+aAcJA3IiXK7JBxvSY20iFd?=
 =?us-ascii?Q?Eplws2SlE4f0+1Q2hZqihBKLh4MA0hDyYopr9toqey3R3rofTGVgH9H9nJkk?=
 =?us-ascii?Q?pvDVz2vFQW+ClUSNnw0ovnF047+WleLTtV3kHl29srS7Ys8aRIGfUHM95GIJ?=
 =?us-ascii?Q?nG2EOdLDi1IYaM2jrlasYcu1bFJO0s43y5Ux9hrmxlulR1Y8P1wFShthATB3?=
 =?us-ascii?Q?jF06OZKFx4QBnCSOl73A5MvTtBbeoYfMzQYgHM+MuaZf/oSM5mSmWkyg6s2x?=
 =?us-ascii?Q?qe45JwjCGdW9e2B1WtMsbv1fSvIyQMRrqxWf8Gqw32AI6ZKhklA6IGdhPY6Z?=
 =?us-ascii?Q?yvUvA5ltNkdAmTGnwEXV3AWBwzlN/9tfWgCOHfCjNXR5TEbjHO5zW8igHlWa?=
 =?us-ascii?Q?iFZEcPd7hJ/tPy3gd47G6Wue0KX87Fkop3DYls7+j4Fh/VrGwek0E7+1Qoy/?=
 =?us-ascii?Q?fUimeb72gdqC2W8X6WhzAQ8vyCxYzxBEZRP7KbfaeXBE1LhNDXL4nPuEcAsC?=
 =?us-ascii?Q?LLWbn5rX5vwcNRIqnnUlTNAQRagMNx0OFXFyul0az7jS9Q1lVkcHqbFlDizc?=
 =?us-ascii?Q?XPr0yHSVGTyJO7oJpDZGrw8GY3mRBu5krRlB9HyxSEQjeTj8+L9wsVybcbT7?=
 =?us-ascii?Q?ERNF9pxiO/yDSnbnEKudtuu4uSNamx6wvDeQcO/wVd62VjdTcvPc+nF4pSYV?=
 =?us-ascii?Q?S3yQXzp85Eby6h/cGUEwco+N00YXLk/hof93knP5R6Qgm44pRDMxUrLnm4Ae?=
 =?us-ascii?Q?9TCD0ZYVHtcqGGazrEKE748XDFlbcX588xcwL/8v+rf7H9zmxtZm62+nYF4+?=
 =?us-ascii?Q?XjkK4fZUnBLNQgYWdbCRJaFZg2itXKCazquOPD8dO3iewmv4MBzmDB0fne6h?=
 =?us-ascii?Q?narAa5om46vCYqRM8gc7dUcx4D+s84eM5HLdDAd6SFBmvUwtbO0mE1GH4ELC?=
 =?us-ascii?Q?HDNXl54=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?6SZWy6AEWiX2COv177jxpQFh8MZqP3Ezus8ts/EPg2rH46FF0HrC7WGrQTLu?=
 =?us-ascii?Q?0/y+/JdwYW4MoDPARaJZf4B5nhFhJoLQGAjwJ2oMDsKd2Kh3FtDZ8CktgVSt?=
 =?us-ascii?Q?zXFyQSWnAVWbUJAgCZQwdrGUrc384sPSTj0fkFqrlH7EVt+AG5M3T3w5RPHr?=
 =?us-ascii?Q?KXn4WBvut+zH1nwbillFH9roJgJn46RkOOpFADVqRPCvWdUU4JpERWNRz3vi?=
 =?us-ascii?Q?iAYo9gxSHiMCprJPegIO9PEAvG4JxX6wPim35hz54ekLxMPfEOALbBM22eZC?=
 =?us-ascii?Q?OlldsyHkzsugMLZC6jn8byKxpS6UX6uMjriYg2CQ9hPKPr1OjEOesJtsvwk5?=
 =?us-ascii?Q?2m/XQOru3JV+rd4ZGwJmGjWJjzKxVK5WF9JSmHAKjn9mcCpTpJyvSQbNod0I?=
 =?us-ascii?Q?L4+LTQa3LidJ/CUN6UnfHTwUKkUH4++w57IygnuxKPvuMixPIohK5S/Rwab7?=
 =?us-ascii?Q?5dLcHrIk7SirGflRHp99qyUNqCte9lI3R9X85GqLXsxjWkhnsxwkfELPKnP4?=
 =?us-ascii?Q?6z11oRey/EKik0fEntr2b2FnWLF4r778sDBYcWafuVtKTAs2dA5KEv0LYzjN?=
 =?us-ascii?Q?uwAawBIEyYYBrVyRynN8hWF+qtU5n+s3/KnltERx2iFx3v3PcTqebIKbP83K?=
 =?us-ascii?Q?afjWQ+4WoVori9H1JWZ1UQ06ZnylxnyjP7WQ4DwrPUMSuBTnjAwq3SDHaUy4?=
 =?us-ascii?Q?pdqTh2/McTKFpDuqbxREZRMZzwGEmYopYNdsXRy53LF0T5i9CQTnl11Yvse0?=
 =?us-ascii?Q?mdteXoMeLr4JT7VOHz2Pld6haPL8rtuVWjafcul5Y4quelPSgT9jCVN7hEY5?=
 =?us-ascii?Q?H1CH7POqb+F6oCwczDNSQUXJAr50Ew2Mq+iVFLoRjTHSwglxODA5Zrn48jM5?=
 =?us-ascii?Q?m0j2Nbx+NgnMDieayDNhxQdZSzsHCZimRbPu07krNsguFr1IIGC4KKGrEeHA?=
 =?us-ascii?Q?BXzlbozNR/YWNa/pkJ3TyLmAN9mhS+pyNispq7jjyE+On/LEcJmWpqVqcUvg?=
 =?us-ascii?Q?X2X9f0lVAZnXU/6CNr+CYvIfoUZW0LO6DaAImeOKpnlkehKeSbpYf1gffzFF?=
 =?us-ascii?Q?77yueQp7LXFqHAuRsfnBT5uX+V0mT7SsrVKeUDfO4YHZnZfeVIvkTKJoMvWH?=
 =?us-ascii?Q?QJ3sICNkUV+xRbJIYsuYvJRlaE6tKJeeqiltmOqYXu0styz17BT+offnbPFe?=
 =?us-ascii?Q?DV6augRYQayyVl9YlqXlQ801NL2VKgDj21DV+qrt6Sf5GqimWhwS+F927PXf?=
 =?us-ascii?Q?9g4n7tKLW90yYn3y4JhycIU6TFax33kuuD9YGNLhGuH1yqAGhq4AAI8CP5mg?=
 =?us-ascii?Q?yU5Db6Snc/mlyFJ7UZvjUnEXcCSXBFWnwTgiXvHBKu+LQtJYE4fvg/SUDkJa?=
 =?us-ascii?Q?6BiRlEHgNiYxwMvLaTmafQ42VvClWsf1G986/BQLCv4VeaRxZLuhytvzDS6r?=
 =?us-ascii?Q?vOdmfYjXjy1H+NE4c2ENFpHupNCO7qtosA2m/WKqjEzNpSHniUuIGcp9+/uL?=
 =?us-ascii?Q?CMGyCGM21M66pV73KaxmwIL9y1xtMEtCt8o7Km8Cl82fRMlhVBsN0iNv4L47?=
 =?us-ascii?Q?bA6rtqk3KsDtUt68xxDMw1zZmNutV2pZ5RgOHlW4?=
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
	9hqFl4bQqFOqGIl00jxRJr+KKggSmdUoj1IAG+koXTaRSsb0PSUz1MDQOGHI6ZH6SEKeydSQQYJF7wAJ/tk/ojAJi6vJ+i0JXYWGffTCqrQpxjJad6YaX9WcJIvSc14CQb3C+7Uy0zXbTzoTDtQ0X5keQsC48VPr4XirNdIE0tytUnbHmvqUetr2RwcRKFG1liIt7nUKhVILyTdOVKkPhBQOwIh1VwTkS4r9crLFXBJxKNTwJB5V9RNWG1M9gAeBUfGp9UU7OWiFI4cGRRuVBmMC63VPe6AmRKAwFEm5dJA/NOyM4muGM0AWppxQgLBkgnBI2zjLX8YWenn69RopKT1kJpmPj8TOXBd6HPtq7kUoBZDPwY8nsnlbH0dFQzMPjeFHxft7uD5Poek6TsRbBBLrITokQvhWY8H+t5xMY1q1JxQHal4HVyGEg+L37TMuC6JRYziPfuD7jMGpLkuPPPDerg6hm+aWX163EDWJ0G12ziKRmVVBBDfBDbwrbtiIMuyx9MefwEWt7KVCGGSXQZnWxcDSY67zNPkDw9P/ghGZC/BUjaraG7GOaI8+d55w3TaDlMyMG635S6lacOCy0QgbSOX6Om6ilGpWoG5UPR1zD9+DzN22Lr6qdWlg05bm
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 936c5d6e-c000-41cd-3ed7-08dcb9140b7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2024 08:11:32.2480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E6B+QPzkyBQTCrMmf5Anp5x92ncQxbaYEWiiAH5OylnUeA+BG8oXnlgdFxFNSkcAOXQyWsg4bf+94goJQk7CAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6283

> > SDUC memory addressing spans beyond 2TB and up to 128TB.  Therefore,
> > 38 bits are required to access the entire memory space of all sectors.
> > Those extra 6 bits are to be carried by CMD22 prior of sending
> > read/write/erase commands: CMD17, CMD18, CMD24, CMD25, CMD32, and
> > CMD33.
> >
> > CMD22 will carry the higher order 6 bits, and must precedes any of the
> > above commands even if it targets sector < 2TB.
> >
> > No error related to address or length is indicated in CMD22 but rather
> > in the read/write command itself.
> >
> > Signed-off-by: Avri Altman <avri.altman@wdc.com>
> > ---
> >  drivers/mmc/core/sd_ops.c | 15 +++++++++++++++
> > drivers/mmc/core/sd_ops.h |  1 +
> >  include/linux/mmc/sd.h    |  3 +++
> >  3 files changed, 19 insertions(+)
> >
> > diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
> > index
> > 7f6963dac873..8b69129d7b61 100644
> > --- a/drivers/mmc/core/sd_ops.c
> > +++ b/drivers/mmc/core/sd_ops.c
> > @@ -199,6 +199,21 @@ int mmc_send_app_op_cond(struct mmc_host *host,
> > u32 ocr, u32 *rocr)
> >         return 0;
> >  }
> >
> > +int mmc_send_ext_addr(struct mmc_host *host, sector_t addr) {
> > +       struct mmc_command cmd =3D {
> > +               .opcode =3D SD_ADDR_EXT,
> > +               .arg =3D (u32)((addr >> 32) & 0x3F),
> > +               .flags =3D MMC_RSP_R1 | MMC_CMD_AC,
> > +       };
> > +
> > +       if (!mmc_card_is_sduc(host))
> > +               return 0;
> > +
> I think here can be removed, all mmc_send_ext_addr caller are have if-sta=
tement
> to check the card is SDUC
Theoretically yes.
But since it is exported (kernel test robot warning), we should protect fro=
m loadable modules callers.
Also, IMO it serves as some sort of documentation and improves readability.

Thanks,
Avri
>=20
> > +       return mmc_wait_for_cmd(host, &cmd, 0); }
> > +EXPORT_SYMBOL_GPL(mmc_send_ext_addr);
> > +
> >  static int __mmc_send_if_cond(struct mmc_host *host, u32 ocr, u8 pcie_=
bits,
> >                               u32 *resp)  { diff --git
> > a/drivers/mmc/core/sd_ops.h b/drivers/mmc/core/sd_ops.h index
> > 7667fc223b74..462efd43acfa 100644
> > --- a/drivers/mmc/core/sd_ops.h
> > +++ b/drivers/mmc/core/sd_ops.h
> > @@ -21,6 +21,7 @@ int mmc_send_relative_addr(struct mmc_host *host,
> > unsigned int *rca);  int mmc_app_send_scr(struct mmc_card *card);  int
> > mmc_app_sd_status(struct mmc_card *card, void *ssr);  int
> > mmc_app_cmd(struct mmc_host *host, struct mmc_card *card);
> > +int mmc_send_ext_addr(struct mmc_host *host, sector_t addr);
> >
> >  #endif
> >
> > diff --git a/include/linux/mmc/sd.h b/include/linux/mmc/sd.h index
> > 865cc0ca8543..af5fc70e09a2 100644
> > --- a/include/linux/mmc/sd.h
> > +++ b/include/linux/mmc/sd.h
> > @@ -15,6 +15,9 @@
> >  #define SD_SEND_IF_COND           8   /* bcr  [11:0] See below   R7
> > */
> >  #define SD_SWITCH_VOLTAGE         11  /* ac
> > R1  */
> >
> > +/* Class 2 */
> > +#define SD_ADDR_EXT             22   /* ac   [5:0]
> > R1  */
> > +
> >    /* class 10 */
> >  #define SD_SWITCH                 6   /* adtc [31:0] See below   R1
> > */
> >
> > --
> > 2.25.1

