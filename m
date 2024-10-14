Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA794C7E
	for <linux-mmc@vger.kernel.org>; Mon, 14 Oct 2024 05:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728883482; cv=fail; b=Z678MzhKP3xGBixJYUbAoX/dRgucS/mpbtPcBPxHnJ1RIuu86Eh5s6i3RTplWvbBGNwOkL1JsCZYWQmt/AI0MTU2eXxet+0DbZVuXK95XuF1RC8jGZvhG8PtK9fmnVbyO2u7FhWNhlyhBHd/HkFhBZQREhtbUm055I5asLTnaHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728883482; c=relaxed/simple;
	bh=y1+D9Y/rJLVVhb0mBRlvJj/ECdCMoSfWpBklz6IkvKY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aN4N0xD+1Fn5Lbuck8ko7Jhpw2npGdZfDdZjwHzHOAHBdiXwbJtEMi3M+3PzCnbqUTw/hC/kBRQmVwLqaG9a55KbQioGQv/gUa+J1Gm6F4I33OrfJ5vB1P4DHWsIHTK/4SOKkMCP3cwT+P4HUJ/I8BNaLo1B7fYtUGwdDWqiFUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=GvdhFy3J; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=GbMZu6An; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GvdhFy3J";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="GbMZu6An"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1728883480; x=1760419480;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=y1+D9Y/rJLVVhb0mBRlvJj/ECdCMoSfWpBklz6IkvKY=;
  b=GvdhFy3JYcX9dpSNln5FaUV42wt2pylPm0G4xjS0FgkKHShjznheQHgh
   PekyMiCTr0PnXGd5ViMB/8S9XSTx0eBpWHZ1A7X/c5gtHKAYEAnwqLqAs
   4x2+qH0MPG/R+gTBEMcMnq2m6Q36E27KUf14LKhwqkZIbDoHAvVqxvfqN
   S9mqKb8Ic/OzNTscKvvuFfDJ4gOAvBnyiNMeSzvf7aXzcdSc7WORxUOJo
   6iA8uXv1+G2WMSMfDfy+yEqeG1LAqUw1WsvuCJviPoMXooNVvPISUHBAT
   L/MxMhFlLEbJIHi3tiqO5mTOYd/glXduWcqvrerRa3x/Bwc8sdogyEIKW
   Q==;
X-CSE-ConnectionGUID: s+6vjmFmT0+/zDzNVhfwBQ==
X-CSE-MsgGUID: ZbAqSueRRxyHeqdYwcVwug==
X-IronPort-AV: E=Sophos;i="6.11,202,1725292800"; 
   d="scan'208";a="29972554"
Received: from mail-mw2nam12lp2045.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.45])
  by ob1.hgst.iphmx.com with ESMTP; 14 Oct 2024 13:24:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CCrJfk6QP7vYvquIw44+5ysCw6+uccAVs0sVoF3YTaqb50J3VuVYBqv+puHBdRf7v507cd7MAgE3E16zVJ2TTIRKiDGfP/j7Um2XL58Dt77Eml0MBI9pDSkEgu2i1SF3YJoIk+kW/8/Hd6DLtUPQaXGWNJ+uAIJB92qK/5ms+8pfMuOSOPpOxTWWD+qTxceTd3lWnZzN6WiOuIcJ2M5nO7+g+Oeh+mmhyEks8mU//QWhoQK2bxQIY+UJDaWqpp0RZHe1/D7SHVI37rr8TAbgb7IXHRc5H6bKMik2ehxRGU81RQhJe3p3hqReopENYSnsyhs9Ou4UT+BxpIJ25+PyXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJi3/gxzxGMzY0jY7DCgzNZ38ZpcMPGUYqZ7uhRRWEA=;
 b=ErqGgpO3gjvJoGNA01VrVAn+KUR6ZCmf3YiTpOj1Hpz24kv4QuqB119NFx4G31YBrjuSb43z6DCaeS/vbh4tQAvQ9NL9BPsuzE8CWc+QcT5S7RQu8T6HZJa9zNutx+77jcWJa1tjIfAINLuRFe7pDaxM4raKxJfHXlOeSpKsuZaHFfMINyba9ucKAdzrtfBEfDWqUnnD9SckKB+/p82peZLe4ta8hRF+kyIfJQOfQXgCosALLTTy84y/KYMOEpccgVzzksAldsRevl2Q5fih3csER9IVzjj9iHH4o5xxiqnSDbSHRn32gRm0M7njRMoZmvpenxw2+gJE8csZNTXEyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJi3/gxzxGMzY0jY7DCgzNZ38ZpcMPGUYqZ7uhRRWEA=;
 b=GbMZu6AnJ9VRTc/TnusstdnNACFychJ0RT72CFsXqI7nWXmZU0P1T0K3U+UPSSuou9cBSWvOy5DAcqXXkXTrHTTvEyGKkYbKuPZ7DrAqYIUhO78IQJc1yKR2YnF5rPzrnBFJ9gpG+GAuB7+XZdKJTh1ZLjzC84Q2tNl8BU45ap8=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 CH3PR04MB8904.namprd04.prod.outlook.com (2603:10b6:610:179::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 14 Oct
 2024 05:24:32 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%7]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 05:24:31 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Bean Huo <beanhuo@iokpp.de>, "ulf.hansson@linaro.org"
	<ulf.hansson@linaro.org>, "vfazio@xes-inc.com" <vfazio@xes-inc.com>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: [RESENT PATCH v3 0/5] Add multiple FFU modes in mmc-utils based
 on eMMC specification 6.6.18 for flexible firmware updates
Thread-Topic: [RESENT PATCH v3 0/5] Add multiple FFU modes in mmc-utils based
 on eMMC specification 6.6.18 for flexible firmware updates
Thread-Index: AQHbHbRDWWjjP/7RBEiAAYjbM871J7KFtq3A
Date: Mon, 14 Oct 2024 05:24:31 +0000
Message-ID:
 <DM6PR04MB65750B41AEF1127139108403FC442@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20241013210925.123632-1-beanhuo@iokpp.de>
In-Reply-To: <20241013210925.123632-1-beanhuo@iokpp.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|CH3PR04MB8904:EE_
x-ms-office365-filtering-correlation-id: 4d932818-6051-44b4-821e-08dcec107b6e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?vL34z6y8YFRIogmbdV3bhLQUUBDzIT0O/4KtTvt68ViW7cbCc4/esnoPDaO+?=
 =?us-ascii?Q?tiAe0JE5niQ0BI8dDn7bCvuxP+z1DS7jPsuZ+IGId/UcAizYs5kuEIAGfjjT?=
 =?us-ascii?Q?589gE4tEaNqpxpzGbwspX3v5bhARjVhhI9ufg0t0BvgcCs7sq3j49YH1YiXc?=
 =?us-ascii?Q?z6+4Q/BUqEiOE0s7+6Pj5x+St31lGsNDGBQ++ZHIZbuwa23++fh4Xg30Fd7m?=
 =?us-ascii?Q?OopxKdd+v36uQmOhWy0jsoQwWu6SP4xnfLy6hR4VqzRjiVnSIo9qS88e/XXz?=
 =?us-ascii?Q?SWicjtu4fJjnVCF0R3Dsd5GXRUfJk3v7k83AJaBKNnCyqp6FcBD5ieUj1+Sw?=
 =?us-ascii?Q?HyvsMxl3DcyYxM3OCAGCDvFoYCjfTLqw/6ereF4knnZXNlq1I90rLr8j91Ju?=
 =?us-ascii?Q?7cYbaTLxeTh8apE5e0Z33JN7Yv4bHZihep/Ej/Y8+TgKtibxShQNPZxfxr6Q?=
 =?us-ascii?Q?gEE/uOARB6O3FNwY/nFnjp1yoEvoIpysjRvIzI5OHQ1DQF8n+JPn1Q4LGJye?=
 =?us-ascii?Q?TgFu1glIOOtTF8SKac2wDVMZVIM57Gbkwu0qRSjfWFkjGfSJMJ3rqvQ8Crdp?=
 =?us-ascii?Q?qvYYNhzdS2TtJEnr2M/46pADbNOiK1fBAAm+k6JMJ8iAanrlOKE+vS/PfbA+?=
 =?us-ascii?Q?ZbPXU4MZNObqg4bsf6XSqmd2/gvfjcczChYRqWRZqEFPhZouT6S0Hg76gEvX?=
 =?us-ascii?Q?bnEfAlh+b5w+oB5/IfOmPhwnvcZHWKEzFoG1Woe5BhRJFxRaV155kYX/BrTw?=
 =?us-ascii?Q?PlF5JzFQbbsSsUprrScU2R/n2OmZgQgieHBCBGj5NED285dqARY8Q42Nx/pL?=
 =?us-ascii?Q?6k6ljJzJ0gV1vbR/7Nx9UO8cowCUBThvKBn7K0vVz1cyevT+QB4bEnTrrx8T?=
 =?us-ascii?Q?XDDNxaafaaSrrogI1P3dilXXVUaF8tb5Gu4sfE1/x/TeT5sM68fb9aYS8ZjK?=
 =?us-ascii?Q?Ht+nUsiUJ1zZLhDE9KkgcHkL9Zl6h4yyCUqWX+Fid0XWSywa2tzTKwIYJ0Qt?=
 =?us-ascii?Q?h2fwXTZhGEyhJSFDUSWSdbSsbCNScmTa7/htCiTKmeW+AWH/EEMfbS/RGGk/?=
 =?us-ascii?Q?3imOCxHOeaJG+y5QWqVN7VDx0wAOjQkNnzEan5rEYXjgXgfMiaeXl8Ee288F?=
 =?us-ascii?Q?U+f9WNWSvZqsGJpM6EsP0PQqxcOqBbcusiDQrWqRw7Ra/FDkc8fzxtsaN0xq?=
 =?us-ascii?Q?ljAAqhODscY/Kriglxr75GDZIypRH7w5lQFjOcnvYqUdzIwNrbS94VDjuX65?=
 =?us-ascii?Q?DSSVeEYLlHm3NIlxsofWgK2CZWps6Ez/ERtRfKrsBsrLtUbzxVE8d7+jCLEf?=
 =?us-ascii?Q?lKB5qaux9/o67kGbUzZvk9Cfdxq3WHttRtkM2mwc2G8hrQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?QzsN9fy8YCn0xB+Cj38tGTjlUxQtww4D38L0oOArzxPIcatZ9NQr4e7QHlwz?=
 =?us-ascii?Q?RagI9jhkkxiepnrkkorsQisimWpLkrvjIG+778i/jcfqf3a/nNU3+hCovMHN?=
 =?us-ascii?Q?sBij1FgkFsfNa7XB7Y6xIFecIJ4n9vSLJ63dlDvacb/JRzCqmybRVLLcall5?=
 =?us-ascii?Q?BYT0YWGG85HpX023VgA+SSwzy6HOyXd84DD4jGxUCRka/7eqszwBDJ4igcep?=
 =?us-ascii?Q?RjWM0Kxzhm3sLjyjHP0im9U7G7HmQJw94oCv+gHLoEgASLtUlgs6zYcJeENn?=
 =?us-ascii?Q?ewtj8+rviY6KeGhkp6lW9M0p+17+HBnYjYUvfkU9ncUvgSYYRd+HAg2LFJXw?=
 =?us-ascii?Q?JImsmpqQHFFoNuH6e+Twfmoa//gcStBt1ZnA+l4tJf5L9BXYIs5y7rNKbhtL?=
 =?us-ascii?Q?47ezy//t4MPC1ZFQfMnuYj92y2FWB/gSijIYSRT6ArKKlpMUKXRjcHWCjZ1D?=
 =?us-ascii?Q?nSl7QR6eokOuwxCdySzKhlnTRp3nz2xVasHUrGIPp7ZS4n0sX6CH89/dfwmZ?=
 =?us-ascii?Q?eRjXQkofaq5cU6Dsqw9bRNNFcJlszxfq+nbuUB6WoKyzYgnHEr77GMzoigAB?=
 =?us-ascii?Q?prtQBcWIHbhoikkwsFLSe6hGyyNv+PbBtIaJVpGr6k6tkKQIQ9ghsiax9XaZ?=
 =?us-ascii?Q?PxNsJzwJmNj1f4PA4i6GcuPIeeudvWW5JDyCHP94Td88j+K63j/rBtegPaUi?=
 =?us-ascii?Q?nFqNMNt4V2IJ7882Jl/YopAE3DsJOs09Vrg5lf997Is1HUzV9+F5kPTVK/c9?=
 =?us-ascii?Q?M/o4c4bJXarTTt5rIzjOkiQ3wPz7HKeHTZf6pf2RikcQIzXqUYKUr2z78Eu7?=
 =?us-ascii?Q?FkA/6+axKY/O28nKa5YRNFEPF3JvV6eqrxJ+SnZ453YL6/Bb5R7n9825YPOU?=
 =?us-ascii?Q?flFKgy4qm1AkK25MpYGv8obju2F0Dw8Q2i4m68bB1Ri4VXuA3DrSKLWRNote?=
 =?us-ascii?Q?szgrjeAXzeyhfSWzg8A7MRhb9q+ZINRciUVSjseh5VK0h+RQpuvyZDkdCNul?=
 =?us-ascii?Q?Tk5tsdmtXgBcQNJKKdGBZptCQBlqHO0X55prlG9sGqRwPNVHiFmuiyMYwKdg?=
 =?us-ascii?Q?ndx0GWFOCiKTWU+5JNsIChcEQRaG2wzcWIbKnH1rC93PIxz2QUsfZfahbSxG?=
 =?us-ascii?Q?SXkzhaXzSDkk9g4XP/w8k0JCh0YtNWbWE1sTxq2pJLTf1Fh6YRBVciW8Ncej?=
 =?us-ascii?Q?R7tx3pLdzVG+qgo04Um+2wlbV3g4uCXATWE8jrDD3JcZc23qL6z884bWnwL4?=
 =?us-ascii?Q?3FSRmSlGuVjob4UUPBNeoIDtEuDNP1+lIDE29A7iq0s2zb6fAkhyNonMHSVe?=
 =?us-ascii?Q?zZ5HkDuVPh8S6j7i7ALSmhqXRsIiLb8ncYkMFu2FFI2THDCY1TyZQ4CekseL?=
 =?us-ascii?Q?msju+qOTo3Mmv7P7pX2JB+qddDScWPxdmshr+VZ+HLQQWWGOMjkxHEEpHSm1?=
 =?us-ascii?Q?QBUVuP/Wdx49gDakHSyQenU6/yc0N235e/L6MaB4AfECjIT1t76/347PNP9s?=
 =?us-ascii?Q?yXpBsa9QtwtqALPcWGUjQPOUVPecR1B03ZQQ3DHbPHoRGProU3GXnPQp6ma3?=
 =?us-ascii?Q?E76+k6hTSpwVcFMIujzS5pjzLu/HiHqqbTyF6nFc?=
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
	hZTGMa4P/zCNzZ/ENayB805iwRaf3HyHQuHawGPMdmqEqXJXC/I5IhXM1bFwP5U2fI9HiRAg+caHAYjhkFFPz9pD0qk/Nk1J86NKSZ10SfLxn1h3VZrUKo4OQBhcRunya1QgnTZwQNKPlE4BIN6mloGntdKjDdUjCDh3WNy6FZN+d/95EMEdXo6eK9OcOpqoyyd7QofUz9T/RWu9eSaA037xHQ6aPXhS0SKIgvLn9fp7w+tXcwiGrC+8JMsiJlJdmroq4haFeP8Qjc5N2ePEli+cwwzqZsBp7gI2m/qnPa8c6FsKCFzhflh6eLG55zaldPBZJ9HyMCMGhvcQt77IGlFnT/Zy/A2iTMLaqA5B8AIlZZsa6GhPE8pXHYrzLiWNku/w8tzneJaWnq7V6/b/uAQk0T8OR9dlOkY+sBzTHqMfdX49fs4mElrGohIQLqVFi+Ubi5UVfOoxHRIdyTrfyP7W/qaSOP8z+AiTvyixn9/8Iac7+VQ8uQynwY8z+/WKfAAwqhQ5m3/UuvRmDaIdZ18wY8ncRSa7pKK4j1dbyuZXlrXP+sWJOkm2FVVHEoqIq4pQ91VU87aCkNPuOJJuvt5/1ixVuXZ5Y/cujEm32YGTT6WmnrAxTMNH/60o5NVL
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d932818-6051-44b4-821e-08dcec107b6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2024 05:24:31.4080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9QeWheJPZPisC8ihVNKVR90lHnHK18XYNrh4c3fggny+TWCwQWheVYJEcwkix2rp5s/mxOChx2GypbO+7NXnSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR04MB8904

>=20
> Changelog:
>=20
>  v1 -- v2:
>         1. Added memset() to clean command structure
>  v2 -- V3:
>         1. Refactor patch, and remove ffu dedicated file mmc_ffu.c:w
                                                                           =
                                          ^^^
A vim save leftover - only if another spin is needed.

Thanks,
Avri

>=20
> Bean Huo (5):
>   mmc-utils: Refactor common FFU code into functions to support
>     additional FFU modes
>   mmc-utils: Add FFU mode 2
>   mmc-utils: Add new FFU mode using CMD25+CMD12 for  Open-ended write
>     download FW
>   mmc-utils: Added FFU mode 4 that uses CMD6 and CMD24 for single-block
>     firmware download
>   mmc-utils: add FFU mode 5 for firmware download using repeated CMD24
>     command to download FW bundle
>=20
>  mmc.1      |  12 ++
>  mmc.c      |  20 +++
>  mmc.h      |   1 +
>  mmc_cmds.c | 389 ++++++++++++++++++++++++++++++++++++-----------------
>  mmc_cmds.h |   4 +
>  5 files changed, 302 insertions(+), 124 deletions(-)
>=20
> --
> 2.34.1
>=20

