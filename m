Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DA636B
	for <linux-mmc@vger.kernel.org>; Mon, 14 Oct 2024 06:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728888940; cv=fail; b=JNbEjjqnwDB4R+Mp9bXHfDnexb48lmGbuWRFwv5FR/7xak3wPHchg0VkCgpWpG8Vok+LkPilFpFTn8GkDV8BBkgwrZkZ07HfpaGEG8QwK0coRAivRjC4QZYN/75nwqOBGT77+gNAqVV8YhHimhZUNGzwU9qCAnb84KcHdT9K15Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728888940; c=relaxed/simple;
	bh=RYZkK+DXukq4DUEL4n0l+4F5rAbvk01WcTm3ChnhY34=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IImwF4X7s1olkpREu3qB6LYlvo2Ky5kwfuWTF9O7X5i9WcvFEAmeEJRXZB0ImdVbGsnCl4J6U2dzQqzYQdq2yxV5lQh/+miaScR9ReanGO4lCMOaFwGQ6krDEIIXsnLF90scZ3ApYuUMVCT8se/4dbRyBnEfG6L4ZedOmjfaYFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=BYBFZXBf; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=xyJnyk0Y; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BYBFZXBf";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="xyJnyk0Y"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1728888937; x=1760424937;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RYZkK+DXukq4DUEL4n0l+4F5rAbvk01WcTm3ChnhY34=;
  b=BYBFZXBfuCnJKCdblJiKDwecXWcHxV/wk4R0i6LMxzRCspIQpRa9jXs6
   C1mALnGUDv6UFZ4AYBbM0odnx6Xr6MhPVHjPDYqL1tf51Drq78kmcz1im
   Irj2FtB/COkiYFfs7ZtjB26/c9xbsGMW8QiIjcvHWr2vr8gon+wGHEOvB
   tKZZzae3wglZ6qYsoWYwOZ1rr0+8u/7Lo91XV6/BpJkMk5/NnY+MzBxbN
   yAL6uYQSm6L+rmF+UBrzm/351sDQVl7ZVuOJzd5qDJxgyoNwHs/xqhbG2
   AteeG6SqbUNPVxjzhDKyB9IBvDh2bbGxqzov0sxzUOlvYSSdq8muGSqfn
   g==;
X-CSE-ConnectionGUID: qXwneTn6RhGTZCmJpuKVlQ==
X-CSE-MsgGUID: R8eEM5MUSz6lyqleyp3Ckg==
X-IronPort-AV: E=Sophos;i="6.11,202,1725292800"; 
   d="scan'208";a="29324568"
Received: from mail-centralusazlp17010005.outbound.protection.outlook.com (HELO DM1PR04CU001.outbound.protection.outlook.com) ([40.93.13.5])
  by ob1.hgst.iphmx.com with ESMTP; 14 Oct 2024 14:55:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xvL2LkR0Xml5/skxu5D0/8TKM0ctfTm8AtEfAuUg6tNCRCrrfRJpSaWTBn6g+9HoHnP/0li71clkdQADDcfJi6IcfKxsbMrVdE+RbobWC8JlOoEqBdVLW6sK4ONjdyE1wMVnXJkWHG9oXGJ5tvz2cL1HUYAUE7/epYGU15SvhEDZuOYtolIdDHgWSQ1YJaAnacgML617fyiFBxi/JYFNq+ElcUwN36k6VkOTKdDAoBdoHIbUT/j+t7IAtawjy3yMdMMfKAEnnwIzfC8c/vS9GacZKKIgy0ylJoYp4jVwKyGQiLFjJrvkzJqpoByk/54Po3dFGbDA63Tu+HR0fJCH2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IPnU1dgrdtUbw1XwGzdITjlO6bGPT4CK87O0wg5OF5o=;
 b=SpvEKFohx9mjKGuPyMF8n/7ItWEwEZGaJwkk27PMMEqX8eHYEgxv5IuFNiXUgVTn06c65uKmcbB/CwBnOcm530cA389uNGRpHZbjiBiXuPkveqPfjzoTimYnJRLri4WaS5JsIWoWQUq50ckH/O5BPNdTct95OUsU6prT9UV3XcMSiYempAZRJ2ZaW1om1k0ayl5iEGNDqblf0tOibSO2q8tx8zHXf9MqSgYYgATqa7uQY57uDoNLukV+w7YdqNdW810kRVnFNfRT9eOEOs9mBbtWSYeCTYWhJpvMKx+DMZ1HItj+DdVXUkM4OZz0BYe/gX1Iw5swL/ZfS0G3m3VBKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPnU1dgrdtUbw1XwGzdITjlO6bGPT4CK87O0wg5OF5o=;
 b=xyJnyk0Y7X3Slmt/DQiRSHYgLvuFO6LhMLaRd2Ef6vJ6g/mxA6glxQnsFi5+1CYor9LB3a3KPsSmD33ib8bKP++ToKzWhSEZuhYTQ7JA77Ay10ixcshTrvowm0Yw2nE0mXPTmeCsYuowD+g54fbOG6EsshUzo0RQIdDTjRyBh9c=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BN0PR04MB7997.namprd04.prod.outlook.com (2603:10b6:408:158::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 06:55:29 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%7]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 06:55:28 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Bean Huo <beanhuo@iokpp.de>, "ulf.hansson@linaro.org"
	<ulf.hansson@linaro.org>, "vfazio@xes-inc.com" <vfazio@xes-inc.com>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC: Bean Huo <beanhuo@micron.com>
Subject: RE: [RESENT PATCH v3 1/5] mmc-utils: Refactor common FFU code into
 functions to support additional FFU modes
Thread-Topic: [RESENT PATCH v3 1/5] mmc-utils: Refactor common FFU code into
 functions to support additional FFU modes
Thread-Index: AQHbHbRBJspi0tk2HU6EyKxd/I/477KFvmUw
Date: Mon, 14 Oct 2024 06:55:28 +0000
Message-ID:
 <DM6PR04MB657548AECCE954C3FCE9DEBDFC442@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20241013210925.123632-1-beanhuo@iokpp.de>
 <20241013210925.123632-2-beanhuo@iokpp.de>
In-Reply-To: <20241013210925.123632-2-beanhuo@iokpp.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|BN0PR04MB7997:EE_
x-ms-office365-filtering-correlation-id: fa2ad43f-32f8-44a1-6c24-08dcec1d3051
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Xoi8sWQDjkZQqrX1jFNveeY0ZOTP7doA46Mci4QMa+xOLW/FEow2S7YKv6vQ?=
 =?us-ascii?Q?rIcVii4khknlcZeKxf9KrtzaZxMbNlGk3IizaKfdd8wM900J23jcVxjizGGZ?=
 =?us-ascii?Q?GqdmnVhdona+wZwYII/jQZhhVO3tS6Y6xhmTYWOyiBu5uo/s48XcocFXKnsy?=
 =?us-ascii?Q?gFs5A8yjEfiXUAvsH0njJ4QYbyCeJQRc/qYfu7jaOdWaUp6n7yCJGwfSRD7i?=
 =?us-ascii?Q?106sR7QNVC9+7C27ccYCKeP0l3l4sqm1xORuNPwxBajevYGtjRS9EuiTGj7T?=
 =?us-ascii?Q?lFyZLNks2JcWWZ2szovstoi1ogmUIRbp7V0EqpjrJB+IQK3pGfKHw0+VIlQT?=
 =?us-ascii?Q?IOPg4rpjbLgJE1Omaif5whfEFyT7N1B/r4L5UwUpoTAGmZFadyqHs+6owEDi?=
 =?us-ascii?Q?WHxmarnizSg8xtPxVurZOG4Ug4GYdmGhxqhXaYRBrFluRhrOPxFh7riKWmAZ?=
 =?us-ascii?Q?US57bcq0FGyJuB+Fln9ywZcm2+bEOr57/zNJRzVSj1tROrCatRdMRIccooip?=
 =?us-ascii?Q?IPnLfFxNkNalcvLnWVHTh44LcEfbSOCrx6h9EDlnHHaamOTbVdViyUEbqxiC?=
 =?us-ascii?Q?q8GtX+r2BbxckeTqGz/+Chee+E8YljXavT+MbQzRTP3bjU4hUybfWRJsR5Fg?=
 =?us-ascii?Q?Ru5DQTTXqgawNtyea+ZRR9r30a/SDmPsru41PMxXZh4BjavM2PpoGEQ1YGnr?=
 =?us-ascii?Q?S8hNyrSqKoGnUNG7yHKZLOabgcQm1ojKfx10A1/LlZi8W/lEXNrukPnf14hD?=
 =?us-ascii?Q?/FgxdzcSHO7GRZdbkh8irh8uv6EFD8bvsYMcZvUTNB/896Nx44yEun19piFB?=
 =?us-ascii?Q?EUZmjZ3mEtKTo/4Ey24GrucANEzyPTXkc6GRP/++2ez6t/lcVmgaGYtRcC/v?=
 =?us-ascii?Q?omPfTHRAYTgpovBf54LB3iNOsAHrs6/pJ2eYKXVsSdL5TtoRaxuxrU0GeIHf?=
 =?us-ascii?Q?f7q9PDK9oKf/gAT8IwgR7c4Z3sBWkgl+8KTeP1RVBBMVFrQ+2/b9yYeU+LTG?=
 =?us-ascii?Q?J8A2TunNfLBncISs0XY2jY0w+rJkJ+MUiVOfa/jptq5hDEbsB3CPtfbsuUXE?=
 =?us-ascii?Q?MSbxsSjp29Fh8e1ljP1mZkfyTkQqdxH7hHfsM6Fz0RPKnmdI6zu3HKPFKzA0?=
 =?us-ascii?Q?7+uWVGpXwqlZYYx2Kgz1IgJ4JGVof8fJ367lzKsugO24PXF2s9XitUPjM2OR?=
 =?us-ascii?Q?j6w5QuqNkrABiEEMuJRypmz+r391/rpRBABQJKxHDbzpNJ6qu2cRqVcI6p+H?=
 =?us-ascii?Q?wT2VMS2rd8r5ODFy5RyRavTFqR+kw9WKALQZAAzd+9MbSK8vjrLw5izWfnRm?=
 =?us-ascii?Q?SNDPkHYtKgj2Go3VhogvHTN1MQEZp0JuR6ua6wmcm2DUVw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/8ycHlEabSpmySS6KDscsoVFc0Y5qwBpykVz9b7Kc+fwzCJbytiKQNblm9Cs?=
 =?us-ascii?Q?R4LqR5NQRnErKaWUzYZMA+fvffyqCV4gxM/VX1rbxrU8xZzr2tC1iz67uJ46?=
 =?us-ascii?Q?9LD/hKkLE+na5j9i+kng9np8o0hwnn7P/WcYJqRnACZR0tqnIVuGIwhiHJOg?=
 =?us-ascii?Q?FHTVV2FayIwtyuwhdp6WYggwlDUX7ezyByset67ZVkB0bIaF0LzUSsUmxVMX?=
 =?us-ascii?Q?GFRbDHOxoKwIwnhTn7pbvl8vmw60ROiJPYR8dX+e4UGG6pA7O/Itsg4AdiQP?=
 =?us-ascii?Q?enNcT9TIIDMwK+HMfu/Pk5aIi3Uvu/XlHK88sW35G4iAnSHMZPNbt+DZv6rZ?=
 =?us-ascii?Q?xdpIoC8kqvABxM95x0wBHSmO+/T9oWg3iKVXSWc46nejx6EwhVpGD1RGjPhZ?=
 =?us-ascii?Q?J0jsAx0JSD72CaIcaEe9htf0cm9fsIG9qB7R8jNgW93w91jFPedEFT+vjblv?=
 =?us-ascii?Q?cjbV66TPEN+lXCoZaYwafO+8JJ9yUvbKNa+vMW6dseTTnvtu8sAU3vr06cyU?=
 =?us-ascii?Q?oSzElUBnXzjoHPdutlhRTFHqXn9LaH70XlfrNRTV5r7fSzEZ2QnnD0+AZ8eO?=
 =?us-ascii?Q?sjxtisFWklqkhFMxdTXzH5WkY4mUJdpvfisdvAKbhmTyHeAfKTOpTbclbB2H?=
 =?us-ascii?Q?8QnUdi+3avz+GCcI72qtU+V5AGioTC3b52Bqe2RJtXYVjs0hy18oADhGwO0n?=
 =?us-ascii?Q?K+IVZK+Hd0kIb+CW2rMRkZ+rmUXxEK08HM2GWSYCeb/M5vtdV20+XyiGWc9L?=
 =?us-ascii?Q?cNlVKp5zDBD05EwBblitT9yXjeI0c8daGPjXZJ+vOxUVuV6zMlVyLXYcCds3?=
 =?us-ascii?Q?Lom7YiHFf9XYZhrAeYuXf+Qc136f4q6Z5dUT8Vq0S3aqmMA/ZdjoGuhdGPTO?=
 =?us-ascii?Q?NNKPlXREg6+0XsFnMp0b2WNVMgh8jlArruvsIKgfByvgsjOgxlPsGyNNw4Zn?=
 =?us-ascii?Q?hTScLKuvknBPSRjo3DnoHUGyAOTI2I0m20wV6xawpltitYhsSFlOyz8zWYYS?=
 =?us-ascii?Q?fScW10Yx8lZo+1hoTHMkJUZoeFTSESJ3xF43mtddM980fi9CJwTM5v5jqhIz?=
 =?us-ascii?Q?prR7n1MNu13YH+HGZuZwvuwJN1MkBIQH4YkYgfKndJTFEaZahgvEZvISDQ0Q?=
 =?us-ascii?Q?midd4YBHAXd1yhCsqNaI9BCMgCj16vcXC1Sz9kq2gIY2UW2KQeAzUARHOjS/?=
 =?us-ascii?Q?MysvJJCEcMr+/jmpA7NAcr47o8EY/ed15gjLOcKu2CnEv1Dw/Iph1xAH7r9t?=
 =?us-ascii?Q?7auu8JjXmmWXknqMyOv7t74BQxpHhMycAlp+eOpNaYcax3HrqUfH8umdcXv7?=
 =?us-ascii?Q?31mjmVUKwRXak6op1nsgMjPgWDqzDXoe15PXmh+dePqYkeimv8EfRInBJmhn?=
 =?us-ascii?Q?czmDsndC7gjr7IH9mEYhdPl8TbpxTeHvEBsan1S78x2FTt4Hs44mu+2E6nkK?=
 =?us-ascii?Q?TXwuGxQnwuRRpF0dqbb5Jo/W5i18r23NN0/PxR9R7gZipxRCLkdU7sgOT7AA?=
 =?us-ascii?Q?O7lWE98mFB8WFeTKjEVtCbutZjjJjyLYl3I7VJK7O+QpFjzQG+X+zNzDpM6D?=
 =?us-ascii?Q?tnbcX0RiKLdvzKn2yd4v8V9DuAs/gAFHA3wBmZt3?=
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
	xkhFCCx4yXmCJ9WcxF05q8JRgnqpiSLxEheSeBJ/g6BtDatNato5wH2WTykyUiveCEmysrKafXdw880yT9oCWA73qeJaoDfgCvtIWH0gZFb8vZqY94zFsFYW1NJ9qxIqRkIupkwlGHB+WROby1ZdtTOkwye3i1Gym/ht+bsWHOd611eLr5roi4tyKdpPDyOPqvEC0yleupPDGl9lmDj0N1MyVS58S+dEoDEFMHibF5pT7FNlS+ZT8LqKRiMOuTHEYe5IsvybXA1neDjIW2jz8G4IR7xWOduxlVFxakDeubOs9A1Tp9Hs2IxlqxY9T8uBWW/lO8LKYEAs00JcWs/Zlav6ep+cA9XQU426zj/fiMxf3sKzsubo/ze+KF6rsQbsIX426+OP9NVVBPstO/3m6yrLDzEA5Mi4vYk4E1UA7J0RBrGvhDePakRtw8GyH2L4DEXxyxpN95DjteJE46TaSaCXdQrGg0TmTn8IdpwBDx5DdIqJM2K4sjs85bv8EROK8YkbNeNWnDwV81Vlj/RNLHRYZw3HQUCbw8U0kC95VT2uNT33JTNqDNQGw6DUJpEntnggRHAnjZSDdKPI19fmt0D9Dr4fj5iPEilNEyysqEu1xfaY9lC0y13UOKHIyNJF
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa2ad43f-32f8-44a1-6c24-08dcec1d3051
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2024 06:55:28.8597
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4fw4/5FnHt29h0CCV2bWCCK/kr7PoyWISFmSS8I+KYF7UdBDifMjYhDJQW8SsuqLuduGmA1Fcdyb1cg65k1Y+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB7997

>  mmc_cmds.c | 287 +++++++++++++++++++++++++++++++----------------------
>  1 file changed, 171 insertions(+), 116 deletions(-)
>=20
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index 3b1bcf4..72921a7 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -29,6 +29,7 @@
>  #include <stdint.h>
>  #include <assert.h>
>  #include <linux/fs.h> /* for BLKGETSIZE */
> +#include <stdbool.h>
>=20
>  #include "mmc.h"
>  #include "mmc_cmds.h"
> @@ -2810,15 +2811,13 @@ out:
>         return ret;
>  }
>=20
> -static void set_ffu_single_cmd(struct mmc_ioc_multi_cmd *multi_cmd,
> -                              __u8 *ext_csd, unsigned int bytes, __u8 *b=
uf,
> -                              off_t offset)
> +static void set_ffu_download_cmd(struct mmc_ioc_multi_cmd *multi_cmd,
> __u8 *ext_csd,
> +                               unsigned int bytes, __u8 *buf, off_t
> +offset)
>  {
>         __u32 arg =3D per_byte_htole32(&ext_csd[EXT_CSD_FFU_ARG_0]);
>=20
>         /* send block count */
> -       set_single_cmd(&multi_cmd->cmds[1], MMC_SET_BLOCK_COUNT, 0, 0,
> -                      bytes / 512);
> +       set_single_cmd(&multi_cmd->cmds[1], MMC_SET_BLOCK_COUNT, 0, 0,
> + bytes / 512);
>         multi_cmd->cmds[1].flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R1 |
> MMC_CMD_AC;
>=20
>         /*
> @@ -2826,23 +2825,141 @@ static void set_ffu_single_cmd(struct
> mmc_ioc_multi_cmd *multi_cmd,
>          * long as the product is fw_size, but some hosts don't handle la=
rger
>          * blksz well.
>          */
> -       set_single_cmd(&multi_cmd->cmds[2], MMC_WRITE_MULTIPLE_BLOCK,
> 1,
> -                      bytes / 512, arg);
> +       set_single_cmd(&multi_cmd->cmds[2], MMC_WRITE_MULTIPLE_BLOCK,
> 1,
> + bytes / 512, arg);
>         mmc_ioc_cmd_set_data(multi_cmd->cmds[2], buf + offset);  }
It is not recommended to mix functional & formatting changes.

>=20
> +static int get_ffu_sectors_programmed(int *dev_fd, __u8 *ext_csd) {
> +       int ret;
> +
> +       ret =3D read_extcsd(*dev_fd, ext_csd);
> +       if (ret) {
> +               fprintf(stderr, "Could not read EXT_CSD\n");
> +               return ret;
> +       }
> +
> +       ret =3D per_byte_htole32((__u8
> + *)&ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_0]);
> +
> +       return ret;
> +}
ret is not really needed.
It is not common for the return value to indicate both error and expected f=
unctionality.

> +
> +static bool ffu_is_supported(__u8 *ext_csd, char *device) {
> +       if (ext_csd =3D=3D NULL) {
> +               fprintf(stderr, "ext_cst is NULL\n");
                                               ^^^^
s/cst/csd/g

> +               return false;
> +       }
> +
> +       if (ext_csd[EXT_CSD_REV] < EXT_CSD_REV_V5_0) {
> +               fprintf(stderr, "The FFU feature is only available on dev=
ices >=3D "
> +                       "MMC 5.0, not supported in %s\n", device);
> +               return false;
> +       }
> +
> +       if (!(ext_csd[EXT_CSD_SUPPORTED_MODES] & EXT_CSD_FFU)) {
> +               fprintf(stderr, "FFU is not supported in %s\n", device);
> +               return false;
> +       }
> +
> +       if (ext_csd[EXT_CSD_FW_CONFIG] & EXT_CSD_UPDATE_DISABLE) {
> +               fprintf(stderr, "Firmware update was disabled in %s\n", d=
evice);
> +               return false;
> +       }
> +
> +       return true;
> +}
> +
> +static int do_ffu_download(int *dev_fd, __u8 *ext_csd, __u8 *fw_buf, off=
_t
> fw_size,
> +                                                       unsigned int
> +chunk_size) {
Why dev_fd can't be just an integer?

> +       int ret;
> +       __u8 num_of_cmds =3D 4;
> +       off_t bytes_left, off;
> +       unsigned int bytes_per_loop, sect_done, retry =3D 3;
> +       struct mmc_ioc_multi_cmd *multi_cmd =3D NULL;
> +
> +       if (!dev_fd || !fw_buf || !ext_csd) {
> +               fprintf(stderr, "unexpected NULL pointer\n");
> +               return -EINVAL;
> +       }
> +       /* allocate maximum required */
> +       multi_cmd =3D calloc(1, sizeof(struct mmc_ioc_multi_cmd) +
> num_of_cmds * sizeof(struct mmc_ioc_cmd));
> +       if (!multi_cmd) {
> +               perror("failed to allocate memory");
> +               return -ENOMEM;
> +       }
I was expecting that do_ffu_download will be called with struct mmc_ioc_mul=
ti_cmd *multi_cmd argument as well.
That each ffu<x> mode fills it according to its own logic.
This you won't be needing that ffu_mode additional parameter.

> +
> +       /* prepare multi_cmd for FFU based on cmd to be used */
> +       /* put device into ffu mode */
> +       fill_switch_cmd(&multi_cmd->cmds[0], EXT_CSD_MODE_CONFIG,
> + EXT_CSD_FFU_MODE);
> +
> +       /* return device into normal mode */
> +       fill_switch_cmd(&multi_cmd->cmds[3], EXT_CSD_MODE_CONFIG,
> + EXT_CSD_NORMAL_MODE);
> +
> +do_retry:
> +       bytes_left =3D fw_size;
> +       off =3D 0;
> +       multi_cmd->num_of_cmds =3D num_of_cmds;
> +
> +       while (bytes_left) {
> +               bytes_per_loop =3D bytes_left < chunk_size ? bytes_left :
> + chunk_size;
> +
> +               /* prepare multi_cmd for FFU based on cmd to be used */
> +               set_ffu_download_cmd(multi_cmd, ext_csd, bytes_per_loop,
> + fw_buf, off);
> +
> +               /* send ioctl with multi-cmd, download firmware bundle */
> +               ret =3D ioctl(*dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
> +
> +               if (ret) {
> +                       perror("Multi-cmd ioctl");
> +                       /*
> +                        * In case multi-cmd ioctl failed before exiting =
from
> +                        * ffu mode
> +                        */
> +                       ioctl(*dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[3]);
> +                       goto out;
> +               }
> +
> +               sect_done =3D get_ffu_sectors_programmed(dev_fd, ext_csd)=
;
> +               if (sect_done <=3D 0) {
> +                       /* By spec, host should re-start download from th=
e first sector
> if sect_done is 0 */
> +                       ioctl(*dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[3]);
> +                       if (retry > 0) {
> +                               retry--;
> +                               fprintf(stderr, "Programming failed. Retr=
ying... (%d)\n",
> retry);
> +                               goto do_retry;
> +                       }
> +                       fprintf(stderr, "Programming failed! Aborting...\=
n");
> +                       ret =3D sect_done;
> +                       goto out;
> +               } else {
> +                       fprintf(stderr, "Programmed %d/%jd bytes\r", sect=
_done * 512,
> (intmax_t)fw_size);
> +               }
> +
> +               bytes_left -=3D bytes_per_loop;
> +               off +=3D bytes_per_loop;
> +       }
> +
> +       ret =3D get_ffu_sectors_programmed(dev_fd, ext_csd);
> +out:
> +       free(multi_cmd);
> +       return ret;
> +
> +}
> +
>  int do_ffu(int nargs, char **argv)
>  {
> +       off_t fw_size;
> +       char *device;
> +       int sect_done =3D 0;
>         int dev_fd, img_fd;
> -       int retry =3D 3, ret =3D -EINVAL;
> +       int ret =3D -EINVAL;
>         unsigned int sect_size;
>         __u8 ext_csd[512];
> -       __u8 *buf =3D NULL;
> -       off_t fw_size, bytes_left, off;
> -       char *device;
> +       __u8 *fw_buf =3D NULL;
>         struct mmc_ioc_multi_cmd *multi_cmd =3D NULL;
>         unsigned int default_chunk =3D MMC_IOC_MAX_BYTES;
> -       __u32 sect_done =3D 0;
It is not recommended to mix functional & formatting changes.

>=20
>         assert (nargs =3D=3D 3 || nargs =3D=3D 4);
>=20
> @@ -2852,6 +2969,7 @@ int do_ffu(int nargs, char **argv)
>                 perror("device open failed");
>                 exit(1);
>         }
> +
>         img_fd =3D open(argv[1], O_RDONLY);
>         if (img_fd < 0) {
>                 perror("image open failed"); @@ -2859,28 +2977,22 @@ int
> do_ffu(int nargs, char **argv)
>                 exit(1);
>         }
>=20
> +       if (nargs =3D=3D 4) {
> +               default_chunk =3D strtol(argv[3], NULL, 10);
> +               if (default_chunk > MMC_IOC_MAX_BYTES || default_chunk %
> 512) {
> +                       fprintf(stderr, "Invalid chunk size");
> +                       goto out;
> +               }
> +       }
> +
Can the argument parsing part be common to all modes as well?

>         ret =3D read_extcsd(dev_fd, ext_csd);
>         if (ret) {
>                 fprintf(stderr, "Could not read EXT_CSD from %s\n", devic=
e);
>                 goto out;
>         }
can this part also be part of ffu_is_supported()?

>=20
> -       if (ext_csd[EXT_CSD_REV] < EXT_CSD_REV_V5_0) {
> -               fprintf(stderr,
> -                       "The FFU feature is only available on devices >=
=3D "
> -                       "MMC 5.0, not supported in %s\n", device);
> -               goto out;
> -       }
> -
> -       if (!(ext_csd[EXT_CSD_SUPPORTED_MODES] & EXT_CSD_FFU)) {
> -               fprintf(stderr, "FFU is not supported in %s\n", device);
> -               goto out;
> -       }
> -
> -       if (ext_csd[EXT_CSD_FW_CONFIG] & EXT_CSD_UPDATE_DISABLE) {
> -               fprintf(stderr, "Firmware update was disabled in %s\n", d=
evice);
> +       if (ffu_is_supported(ext_csd, device) !=3D true)
If (!ffu_is_supported(ext_csd, device))

>                 goto out;
> -       }
>=20
>         fw_size =3D lseek(img_fd, 0, SEEK_END);
>         if (fw_size =3D=3D 0) {
> @@ -2888,15 +3000,6 @@ int do_ffu(int nargs, char **argv)
>                 goto out;
>         }
>=20
> -       /* allocate maximum required */
> -       buf =3D malloc(fw_size);
> -       multi_cmd =3D calloc(1, sizeof(struct mmc_ioc_multi_cmd) +
> -                               4 * sizeof(struct mmc_ioc_cmd));
> -       if (!buf || !multi_cmd) {
> -               perror("failed to allocate memory");
> -               goto out;
> -       }
> -
>         /* ensure fw is multiple of native sector size */
>         sect_size =3D (ext_csd[EXT_CSD_DATA_SECTOR_SIZE] =3D=3D 0) ? 512 =
: 4096;
>         if (fw_size % sect_size) {
> @@ -2904,61 +3007,32 @@ int do_ffu(int nargs, char **argv)
>                 goto out;
>         }
>=20
> -       if (nargs =3D=3D 4) {
> -               default_chunk =3D strtol(argv[3], NULL, 10);
> -               if (default_chunk > MMC_IOC_MAX_BYTES || default_chunk % =
512)
> {
> -                       fprintf(stderr, "Invalid chunk size");
> -                       goto out;
> -               }
> +       /* allocate maximum required */
> +       fw_buf =3D malloc(fw_size);
> +       if (!fw_buf) {
> +               perror("failed to allocate memory");
> +               goto out;
>         }
>=20
> -       /* prepare multi_cmd for FFU based on cmd to be used */
> -
> -       multi_cmd->num_of_cmds =3D 4;
> -
> -       /* put device into ffu mode */
> -       fill_switch_cmd(&multi_cmd->cmds[0], EXT_CSD_MODE_CONFIG,
> -                       EXT_CSD_FFU_MODE);
> -
> -       /* return device into normal mode */
> -       fill_switch_cmd(&multi_cmd->cmds[3], EXT_CSD_MODE_CONFIG,
> -                       EXT_CSD_NORMAL_MODE);
> -
>         /* read firmware */
>         lseek(img_fd, 0, SEEK_SET);
> -       if (read(img_fd, buf, fw_size) !=3D fw_size) {
> +       if (read(img_fd, fw_buf, fw_size) !=3D fw_size) {
>                 perror("Could not read the firmware file: ");
>                 ret =3D -ENOSPC;
>                 goto out;
>         }
>=20
> -do_retry:
> -       bytes_left =3D fw_size;
> -       off =3D 0;
> -       while (bytes_left) {
> -               unsigned int chunk_size =3D bytes_left < default_chunk ?
> -                                         bytes_left : default_chunk;
> -
> -               /* prepare multi_cmd for FFU based on cmd to be used */
> -               set_ffu_single_cmd(multi_cmd, ext_csd, chunk_size, buf, o=
ff);
> -
> -               /* send ioctl with multi-cmd */
> -               ret =3D ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
> +       sect_done =3D do_ffu_download((int *)&dev_fd, ext_csd, fw_buf,
> + fw_size, default_chunk);
>=20
> -               if (ret) {
> -                       perror("Multi-cmd ioctl");
> -                       /*
> -                        * In case multi-cmd ioctl failed before exiting =
from
> -                        * ffu mode
> -                        */
> -                       ioctl(dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[3]);
> -                       goto out;
> -               }
> -
> -               bytes_left -=3D chunk_size;
> -               off +=3D chunk_size;
> +       /* Check programmed sectors */
> +       if (sect_done > 0 && (sect_done * 512) =3D=3D fw_size) {
> +               fprintf(stderr, "Programmed %jd/%jd bytes\n", (intmax_t)f=
w_size,
> (intmax_t)fw_size);
> +               fprintf(stderr, "Programming finished with status %d \n",=
 ret);
> +       } else {
> +               fprintf(stderr, "Firmware bundle download failed. Operati=
on status
> %d\n", sect_done);
> +               ret =3D -EIO;
> +               goto out;
>         }
> -
>         /*
>          * By spec - check if mode operation codes are supported in ffu f=
eatures,
>          * if not then skip checking number of sectors programmed after i=
nstall
> @@ -2969,48 +3043,29 @@ do_retry:
>                 goto out;
>         }
>=20
> -       ret =3D read_extcsd(dev_fd, ext_csd);
> -       if (ret) {
> -               fprintf(stderr, "Could not read EXT_CSD from %s\n", devic=
e);
> -               goto out;
> -       }
> -
> -       /* Test if we need to restart the download */
> -       sect_done =3D
> per_byte_htole32(&ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_0]);
> -       /* By spec, host should re-start download from the first sector i=
f
> sect_done is 0 */
> -       if (sect_done =3D=3D 0) {
> -               if (retry--) {
> -                       fprintf(stderr, "Programming failed. Retrying... =
(%d)\n", retry);
> -                       goto do_retry;
> -               }
> -               fprintf(stderr, "Programming failed! Aborting...\n");
> -               goto out;
> -       }
> -
> -       if ((sect_done * sect_size) =3D=3D fw_size) {
> -               fprintf(stderr, "Programmed %jd/%jd bytes\n", (intmax_t)f=
w_size,
> (intmax_t)fw_size);
> -               fprintf(stderr, "Programming finished with status %d \n",=
 ret);
> -       }
> -       else {
> -               fprintf(stderr, "FW size and number of sectors written mi=
smatch.
> Status return %d\n", ret);
> +       fprintf(stderr, "Installing firmware on %s...\n", device);
> +       multi_cmd =3D calloc(1, sizeof(struct mmc_ioc_multi_cmd) + 2 *
> sizeof(struct mmc_ioc_cmd));
> +       if (!multi_cmd) {
> +               perror("failed to allocate memory");
> +               ret =3D -ENOMEM;
>                 goto out;
>         }
>=20
> -       fprintf(stderr, "Installing firmware on %s...\n", device);
>         /* Re-enter ffu mode and install the firmware */
>         multi_cmd->num_of_cmds =3D 2;
> -
> -       /* set ext_csd to install mode */
> -       fill_switch_cmd(&multi_cmd->cmds[1],
> EXT_CSD_MODE_OPERATION_CODES,
> -                       EXT_CSD_FFU_INSTALL);
> +       /* put device into ffu mode */
> +       fill_switch_cmd(&multi_cmd->cmds[0], EXT_CSD_MODE_CONFIG,
> EXT_CSD_FFU_MODE);
> +       /* Re-enter ffu mode and set ext_csd to install mode */
> +       fill_switch_cmd(&multi_cmd->cmds[1],
> + EXT_CSD_MODE_OPERATION_CODES, EXT_CSD_FFU_INSTALL);
>=20
>         /* send ioctl with multi-cmd */
>         ret =3D ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
Can wrapping up be common to all modes as well?

Thanks,
Avri

>=20
>         if (ret) {
>                 perror("Multi-cmd ioctl failed setting install mode");
> +               fill_switch_cmd(&multi_cmd->cmds[1],
> + EXT_CSD_MODE_CONFIG, EXT_CSD_NORMAL_MODE);
>                 /* In case multi-cmd ioctl failed before exiting from ffu=
 mode */
> -               ioctl(dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[3]);
> +               ioctl(dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[1]);
>                 goto out;
>         }
>=20
> @@ -3022,16 +3077,16 @@ do_retry:
>=20
>         /* return status */
>         ret =3D ext_csd[EXT_CSD_FFU_STATUS];
> -       if (ret) {
> +       if (ret)
>                 fprintf(stderr, "%s: error %d during FFU install:\n", dev=
ice, ret);
> -               goto out;
> -       } else {
> +       else
>                 fprintf(stderr, "FFU finished successfully\n");
> -       }
>=20
>  out:
> -       free(buf);
> -       free(multi_cmd);
> +       if (fw_buf)
> +               free(fw_buf);
> +       if (multi_cmd)
> +               free(multi_cmd);
>         close(img_fd);
>         close(dev_fd);
>         return ret;
> --
> 2.34.1

