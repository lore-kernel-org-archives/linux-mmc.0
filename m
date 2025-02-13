Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BE0211A2B;
	Thu, 13 Feb 2025 10:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739442171; cv=fail; b=gtI9HbvuVLbJ8WzavYmpOOV5iByzgVky5oP5qpLWNg/SpDaBbd+JWgaKHvlv7yRFZBrEMatK+qzeO5jo7FIJhAytoMcbjbRS05NvxP7fdCxDSuCCX24elbUCWa3D8wwfCtvR6Haftr3xRrSqOtgKkS8tOZl9OOrwLgAn+7ovobE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739442171; c=relaxed/simple;
	bh=y7dAu5/WJNY9dGLXbyEi5ru3mjrIwgQv1Z/FXtgKxjw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LCfcMaUGPAzpwxAcOJXmi4v0xGyHNpLD6L3F1Puji7UMS8GpaC4bC/rHvRpvKmht3AVD7nGiJ6OdycJTYCqVdEzhHCATDa6ngTURpQmKHpVpj5iuqzx27SQf0mdwwQsEyaXkwN8vr3ZLgMIblCTVt/Coasm/+nWEbW54RtB3apk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=ZpfIoPqE; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="ZpfIoPqE"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkim.sandisk.com; t=1739442169; x=1770978169;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=y7dAu5/WJNY9dGLXbyEi5ru3mjrIwgQv1Z/FXtgKxjw=;
  b=ZpfIoPqEh5QzhqSOk4N1jGIDQfUVa5/5/9RUkUgZtE88znp0Hmcb2Lj3
   mvzmDVHOFJsodcK1Mnq5ZkS/5dhiuXJ/6BzMXE4sISexlfqWIP3b08MPo
   h7NsqgLsKYMLeehJMXhWTPV5G4spAu3+kmoISuy4UL51v4NXWtgwXLTi1
   voJoO7hdDoy2sZOrS4z+fG7a/7ITjqui8Vn1YpYSnYtWr7NpfkO+3nFV+
   HBPGgiw2no41bJXFjhgbNQJtJgOc9A3mWY7BLRsnzfmFMNImO3LPRVx69
   iQeiTgEuFRiB694UfoUeUfIJpY+hnbrAgrAHh12eFXVm82aYumQqIgrjt
   w==;
X-CSE-ConnectionGUID: pOnJu6fhQqmGtZTXeUovTQ==
X-CSE-MsgGUID: crmYGHIhSBCqefhwUAqp1g==
X-IronPort-AV: E=Sophos;i="6.13,282,1732550400"; 
   d="scan'208";a="39369898"
Received: from mail-dm6nam10lp2041.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.41])
  by ob1.hgst.iphmx.com with ESMTP; 13 Feb 2025 18:22:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X/ASgrV5RiwJjnRU9X9p6riP/Kj7w9ChG7ZKlY0QWUdDM5vmUVY8oxC1H77z0NX0mUCsFy6Clb6Ufj/AOyvMkJ+TY8+u5ifWnD08+G3inNKI126wmFQRq+7KlM5WBX7Y2ReS2vIskL3zxJW4O1RSx4CXXatiSZ8po+SfNxJr4QbRL+IIZUwdZTWnww4dGQADpTQwo2yeLEa9Jp5T521TUssSSaZHSJoZ1qzF0HN5FEdtAV2z1OTxwiaVpGLNOqiisgBII+EiAZlLJuJ1XJr5rUS5D1sRXpt14c1PT85qzmtFdk8LNTvRsHmhFURsGorC3vFrgzIcqJykeutbDBBSag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6tJmUaW4fVMgtlhKfZh04B5vAWG29CE26dprj6wIGkY=;
 b=xvz4AIty+jb/2fjw4GnwxyZ8+iikFSNvDA5RpCHozDDamX5X89B1Es6AqwEsOcmj5xgWCXXj+1Axj6OOqx8KRNDhpeSTKWSN//NO/ljWfmNuQt2Al78iCv3tz3zX1pGvEcDStHWiZpcmeMA0o/FoTQyUI3pgq5lz+Fg/5LVEPLx3HdcGmSHxMIMu8XfhjNR/UK/QPFgQJS/SZdCM9XDzq3AUK1L5NNHISkI/SWntBJA5aDAnpBcQz818jzc7zyhrXRaRdhUUotI0gRxAr9s7BGvw6+fwbpOnh8E3/Iy/RSUFTIlHEJXEjd2UybVufIlljeh+1QdTDzU2zqlHkoktaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from PH7PR16MB6196.namprd16.prod.outlook.com (2603:10b6:510:312::5)
 by MW3PR16MB3836.namprd16.prod.outlook.com (2603:10b6:303:51::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 10:22:45 +0000
Received: from PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::e087:8329:baea:5808]) by PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::e087:8329:baea:5808%7]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 10:22:45 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Erick Shepherd <erick.shepherd@ni.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "adrian.hunter@intel.com"
	<adrian.hunter@intel.com>, "gratian.crisan@emerson.com"
	<gratian.crisan@emerson.com>, Kyle Roeschley <kyle.roeschley@ni.com>, Brad
 Mouring <brad.mouring@ni.com>
Subject: RE: [PATCH] mmc: core: Wait for Vdd to settle on card power off
Thread-Topic: [PATCH] mmc: core: Wait for Vdd to settle on card power off
Thread-Index: AQHbfM53WWL9DFD5FUOks8gYIh34wrNFB48g
Date: Thu, 13 Feb 2025 10:22:44 +0000
Message-ID:
 <PH7PR16MB619690B7FCB6997563631B28E5FF2@PH7PR16MB6196.namprd16.prod.outlook.com>
References: <20250211214611.469260-1-erick.shepherd@ni.com>
In-Reply-To: <20250211214611.469260-1-erick.shepherd@ni.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR16MB6196:EE_|MW3PR16MB3836:EE_
x-ms-office365-filtering-correlation-id: c3b9adef-0072-42cc-c93c-08dd4c185b2f
wdcipoutbound: EOP-TRUE
wdcip_bypass_spam_filter_specific_domain_inbound: TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?aqGTQtbE4ix5H/6nUx0B0s4G3c3zH7c+8XKc0Sn7xkbOKmor1X5/3BYH7oEA?=
 =?us-ascii?Q?rrg/hsTdJ//S3MjscfLLx2ssBymbSJVXVAs8FTKXsdLlwNVdV4x7pdBC1bz1?=
 =?us-ascii?Q?4BXw+rRxZnH+g0iybk/FLWsCZo4IhzQGQToZBKcloWJlgddtVgO3DImI25qS?=
 =?us-ascii?Q?u0MpiZ1zSGYUFV09LmmbhEJAfLAEyWiO2Q4yrB3XtEU6ddvSi1zwkz9WiTPa?=
 =?us-ascii?Q?yvrzk4YZxRl+puJPO5LbO9HDH9Uz2VCeu8MMNvuQXoxWbBjKjLQlciEER+iI?=
 =?us-ascii?Q?91A51We4pMo0ATL2f2JZX1oArpoawt0bE4xNnl/kpLo3N7w7e1Ey3A4lYTHT?=
 =?us-ascii?Q?1E8Za6KDNPW1vkr367NK0wCyAyeixHoWp6Lny5kpTaeIXhjirrKzQDhE96Wi?=
 =?us-ascii?Q?bs86dSU6NHXvfbfre34FSIWz3R/jGun58hXk2tg+j8SMwrqTuOO2wNDj6KON?=
 =?us-ascii?Q?zguO7d5AKbIjYPTOji3rU8I1NgNbc5GUvS8CbmPkPc9Vwzp4Yit4RdXrwsKt?=
 =?us-ascii?Q?rn6CupM9e/Hjv7ljHLKEk5wAKBSbaK9GsgK2lXi4XnTufRBrPua/vPN5neoq?=
 =?us-ascii?Q?xhdWj4dYrBxGeIjI3aaoSorDrn2IE8n0UrpEI9+yjZtDthvZFqskdNpSl7U0?=
 =?us-ascii?Q?EV7uv9yVTp+dWCS0Wtk7d+qnV7XyCcABmnfpzbV7YAypVJ0piMi/FyDm6Ccw?=
 =?us-ascii?Q?FT07jIaAR890zMczMpHsBi2f151PxgGzvFDamIjczcfKi5kfsxs746oXrOgY?=
 =?us-ascii?Q?gV9SIDUFMLuFs8synWsRrRFjDZDkTrXbJr4rCOSid41nQqtMJlQfDgvjzBAM?=
 =?us-ascii?Q?3VnjLhFhRB57I+kA/gqFQxlqiNXT90h+ZvSl/vCXGgE2OCy8OaOqYug92yIP?=
 =?us-ascii?Q?b/Ocn3JBog+vnxm7Ocq8RIkGGNso9NZUxZAGJ+/np8O8Kbh55KHiu6Z2hUaA?=
 =?us-ascii?Q?HYWeaieXE95fs28Wt/afEAz3vBeBMGtcPdCrxKriBV3h1S2ybmma0UtFW6n1?=
 =?us-ascii?Q?QEtus2CoQp99DmvhxqG7WGlZqob/jA+6KDbV6TRTgiLHr0rQ5tUNxVjfzK7K?=
 =?us-ascii?Q?dXp91shdD5l5TVI8a3ZHna56avf31VviWWh6UhfjxVu6SiVyqulnmFyl3rhK?=
 =?us-ascii?Q?USwNuwr519NV9lGUzd2ZE9r0rkERypZVYs06Kz+e8JowxAwAaVoRzzMdTgo/?=
 =?us-ascii?Q?CHRsEu1S34dISqdt9D8uh2x/5nu1rM0JwZrCcXYXAgKPhbRi0V9UiHefdLbG?=
 =?us-ascii?Q?rCqS3HozTlEsS/key/1iPILp1btTevKxgGuImyjrSVPpF7t19mbrOnrnBGFa?=
 =?us-ascii?Q?fEoEE8uqQb1dy7jzwbNTOmIapKmTIBAlrAIZ+9pRHQFMz8fQ8LBM7PlwWVJ4?=
 =?us-ascii?Q?E5P7ZjYGejJS+5UZBjk3KJOZuZpLFxeQZStq/h7cv1KiJVM4u1u7cven6uyM?=
 =?us-ascii?Q?SeVw6UTgTl/LkHbNzCqEDw5XZo5vO86U?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR16MB6196.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?vRYMpY7A9Oc0g6akD9s/2/riccljSCtJOhVK48EH4m97yrffcmf4xndK94F4?=
 =?us-ascii?Q?OibMWFnOe2XT0u9ORGomEeLlDSXbiIvxanMhv3IWTHUPbkW/tRAkMey/hyPw?=
 =?us-ascii?Q?dL4vs9goW28C2p81U77g+Qwx9mo6+dqK17zirlGo/UJSbtaExTYuuBhHARLd?=
 =?us-ascii?Q?0qozhXeQ89AyB7f/8LqxRMBu/VZC5USja+RE//W3rxkcoBJZtLLEx/nh7dcr?=
 =?us-ascii?Q?RsYpxWOtqKk6i+52ZzVjtLTaD9bx0Yb82V5uK5nOc5fJ49Fqg5s2jSEayz+f?=
 =?us-ascii?Q?3gGpJNj/636OWFAzDGhmi67ncUsD3+QRxeAz5A8oaMHBWyTyuD8Ur0ihLrfB?=
 =?us-ascii?Q?fUJcgFiLuLUlZlHuze4G1kMHQBHJdzLuWD9iGd9fWQz83lrjHsVfBMTlK4yD?=
 =?us-ascii?Q?bWI8oyD+rWvi3IQmBAKTEu3tZ/KU2kHDFiDyZoHom2aValcAHu13w3AvYQ+E?=
 =?us-ascii?Q?qz2F2cX9wp3HoaTBc02vAsRR1iYfbcB4HAjXZR+IlTNpVj8zVKAviCy2n5IK?=
 =?us-ascii?Q?yq4CDABBElRfAd6VN6ZZSPdYoKVPZ0aREBsb9+/KwUODWtr5QufgsArLJU/g?=
 =?us-ascii?Q?6CkDcrxZUF0Yxx0TlLzxEOdoObUbaNOvEJH4NzjYWdPPm+MPpqmSd4neEdeq?=
 =?us-ascii?Q?K6PYRnpIwqfoMaNKyISf5TBCexmUmROVyOkRQzrFzgExD8bFcZ167uglb3VQ?=
 =?us-ascii?Q?dRIV9dyCLNFjL3iEojeE+QWBxa/kr9GQboOk5SRuxRCYR88Mu6zxLLPmxjrs?=
 =?us-ascii?Q?HT1OKBTJqOgi4A5RTJvBfXNYUA1M0nWTJXdP9igKBzmcLUNGPxzIRtHvkaPu?=
 =?us-ascii?Q?7MdT7YHqFtHVCHPAseRF+EYM+FAjqIAonzFyfCkwOU+nkM8iaPzwK2g604VU?=
 =?us-ascii?Q?byHVSbvbi1X7FPQVbr6TiXh+8FQ9plmcOk+wtNfMm8ugoOsPl78MOcE4M+EC?=
 =?us-ascii?Q?FVsRAQiPM2cF9VJHtB6po7hgECDebZwB4tGlP+kzX/qQ4ngjGLmA2vDNB5ok?=
 =?us-ascii?Q?yVjywkZ6jUdqPF8y8mBtoxhe4+YcB0ytG7Jx53TzilQPo9nt0OBf+XTy9Tfz?=
 =?us-ascii?Q?TyhV4fq5qaQNDqR3/vchuscBOXkI9ACrgA/lFLKG4BG5mcpjfdrwfdEcTEvI?=
 =?us-ascii?Q?zS4jIfuqU38U1Xawrw2ol5DF7/lgh8HT6auHxVEhut1kd7BnxSpMB2Ilc0WO?=
 =?us-ascii?Q?77hpWmnEf+dSlYKzu/qM5IsqwVIDSzyBUNen7ImoX0BpsvQ/0nXig4Cong/m?=
 =?us-ascii?Q?u3v7LHyMf1ZvD5y3QPkQQP3DFBRVWjwZ/S5B+34nj2O52fJw5ecukGIU9Q2Y?=
 =?us-ascii?Q?Cr/HPP2Q5BrakFD9pnQn4SPYTrpmZkbdqnC9CrQmn1B2mFyFxYOghJyNteEB?=
 =?us-ascii?Q?5t8xC9B868UZTizkg4VJAdu6GTTWO7yVjfTlFDU/b9m/cUHavgEHAGE3EO8S?=
 =?us-ascii?Q?mrrETSbA610z0LAd201SaWoHzM23Rmo83kPO3LfhLpXLzUd7gtSQVydwty7e?=
 =?us-ascii?Q?rCH3xiVB0N+yDqIohDpCNd2muQp1tBV3A8V2HfK0BRahC3EMT5pAW/i1fFAo?=
 =?us-ascii?Q?i/9rq1fPtTu8E7bj+GDoyUSLJCtwa+cGqb6eTByZI+h9kqsHMVsvj2QWmbUt?=
 =?us-ascii?Q?CgiVzh2yWYAtP++XQ33nhvtuLBD8MgB2XkY8GigPJrwb?=
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
	Hu2GDUh8+tpcWD1tHg9271JRl6HF6V4xq79IwQ+Whwy6u+LlKeYhk84V2b72jwQ4k0HnZ3pxRsmB8S6/W4++Oez0wkJF0E4nFSsLYeXxhHzNQi9aqS2gT220QTVt5h1mYWnFde4T8ncdViyZV1rp5YinENQIBa2FCx9m7ttzsbnPOo21woAAi8wJQt6uxno/kDJYx1ld9HUz3kz3Xu67857JB7zpVLpfUBYKeijNqcM3R/GLVpmBqNiaattMGoTu3Q3gV/Ep9qA2zqlGpaAn6/UfTKkmrJ4717qbi0E251UCt6sQpYnx50O0wbSFiyDP9/cY4AwmywgjUaFrBo3XHFFPQon/m0KvFPhZeRPhQ0aHzOwxfeXpHQ8oFeo3Ubf/hgwA6lYWfbtEhXpZeLh7A9bm9ea2U12bkO63dwOgNj7av75qcgMLbfF9sFKLaNANBAuVObJzWtfZy1V7fwojGoygHXiJD1DonWEoS/UW1DyOUyLf0oyS1p9NJLzeFofepwPuuGvUAPPEPldShakmFT+GXeq4AjGDozMprEX5ZNssPl+PlDie/CYWVLBS8NLSWnN7fHi7Q6THZ5M9x8vrxwIHra40wwXyQsgmiXXFolNDVakGsOPeGceUz8IoLHkfHENp9OrLyumXKwVy/ricgw==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR16MB6196.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3b9adef-0072-42cc-c93c-08dd4c185b2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2025 10:22:44.8992
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cwZ5rSnCzn7XbO/mT3VBatbt2vDUEN6fO6D8QCnC9JsCzmmHQKWuPvNdpNH3XiOvpfhiMDagrEj4ij3dd0sR7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR16MB3836

> Subject: [PATCH] mmc: core: Wait for Vdd to settle on card power off
                                              ^^^^
Should be a host patch?

>=20
> The SD spec version 6.0 section 6.4.1.5 requires that Vdd must be lowered=
 to
> less than 0.5V for a minimum of 1 ms when powering off a card. Increase o=
ur
> wait to 15 ms so that voltage has time to drain down to 0.5V.
>=20
> Signed-off-by: Kyle Roeschley <kyle.roeschley@ni.com>
> Signed-off-by: Brad Mouring <brad.mouring@ni.com>
> Signed-off-by: Erick Shepherd <erick.shepherd@ni.com>
Acked-by: Avri Altman <avri.altman@sandisk.com>

> ---
>  drivers/mmc/host/sdhci.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c index
> f4a7733a8ad2..b15a1f107549 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2415,6 +2415,9 @@ void sdhci_set_ios(struct mmc_host *mmc, struct
> mmc_ios *ios)
>  	else
>  		sdhci_set_power(host, ios->power_mode, ios->vdd);
>=20
> +	if (ios->power_mode =3D=3D MMC_POWER_OFF)
> +		mdelay(15);
> +
>  	if (host->ops->platform_send_init_74_clocks)
>  		host->ops->platform_send_init_74_clocks(host, ios-
> >power_mode);
>=20
> --
> 2.43.0
>=20

