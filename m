Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9342C2206E
	for <linux-mmc@vger.kernel.org>; Sun,  6 Oct 2024 08:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728202733; cv=fail; b=V9DUyGz+FPWxr6jB+KYIkVfU4gpk6jZ7VoKbGnIBvFmIAK/cs3kF7kg82fWRD4imD5pA7OxgN60zUA1njVRo8g4DJX3xsiqYfFBzg7tzxpMDKpszUUqvxH7ADmRfyaTNRNAixwkJcuOW2n/RIlFqv1a+X6cxP37AWmqYAevp5Ps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728202733; c=relaxed/simple;
	bh=YEOkMP3s80MRefXV4/po76Xr+4lGXoj4qn8eF7XeGnI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pVfm8dVH0TjDbfJIRVXhqB21gbf6OAbru7kKCJwGJkCxmc+i+7hLiZuZCnShMGnwQamxoroPCwPGxFKIFmp8gdtmII3GooaWwgHidRxAXCDuknAXB4+HzTvHMclOYGny6FFTEy/l5XaYU/ZGB3iOIv4QH2pbb82yFpCHbdvOOtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=mkLPBZcJ; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=s/GgVfFM; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mkLPBZcJ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="s/GgVfFM"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1728202730; x=1759738730;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YEOkMP3s80MRefXV4/po76Xr+4lGXoj4qn8eF7XeGnI=;
  b=mkLPBZcJ/1z3yoBq9zENR99KQGMDLIYIW4Of86HfmBCKNK0rECekQH6L
   8F7gxji5SVVPpXoXwKMhZOPVmus1pYe6+zvwpGQdmzQ0P2gAPMjQq2w7V
   WOALQNzZIdKeRIA1XhrBMjLPE5HJWp3I1xDNPKzgJY3LJcP9uEy0w4j8G
   oAxajuz73+QBo4E1nVtSkIM5wXLoiN+isny9BBR5ij5E914LjEm/bC6w1
   IRjjzA6Zwhk+tRtdbrSYQjM7WKgh51NdMu3aOKqxunnJXCo8MVJfwan/Q
   UUD/rPZFtwcBDFodNgSI35AkUDWTK93+9HoKkOxGUBbynt/N78RbmI4ZV
   A==;
X-CSE-ConnectionGUID: 5DEHjqTmTSOPkQbFOw5uIQ==
X-CSE-MsgGUID: Pdg1ew1zQQi5tNz4BL6iQA==
X-IronPort-AV: E=Sophos;i="6.11,182,1725292800"; 
   d="scan'208";a="28341104"
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
  by ob1.hgst.iphmx.com with ESMTP; 06 Oct 2024 16:18:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AIM+8YoyqRSfBaiSjtfdqrMYXm/Gn+YPkjNepjVfAr2BvIw+n3rkvkPuTrQdIUsKj/InX5NXvrvfgJXBFsCmV86JSCq7yMkT8bEqRluRIu0uAjo1nvrzDl5lMMZYu+d5UA054e7t4qjMfChcdRl5y9t1u87LVGSmST99rmrvFU2jXlupc4kbJLMrC6EsFpqhjmqz85tkrpYdVJcFjwPNz+FbkePOV/dosOwHvhODFScRIQGlPKvx/NLTXTjCwRvI7URhTbyFTSyFYWfG2C3hKjqG7ojXemce2AgwSVbv1AMpF9v2plzpIeMdtr8VkDtle67+qcslJe3Pb6PikTkurA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XMOgoKTTZ1i6BwDyI9KUQE2c49jJQyZcvDmMLW7E1d8=;
 b=Q8TWi/91hdGRnHrWaB5/G4670FjwCs5cJ2F1ys0u6buvdOeCuLo63pzEwrT1KMLwo7lHDIN1t2WDS38MHiD8FxKSMgUGtTNOSC73P+eO7SCjDF0z5vxsCpzqtCanSNbXVkHKfiNZunrShKDI7iPz02rJvX3ZiGBHTYWJwab08T/+GsdaBneNTJ9/uDh4uq4/0JbQPhrK51v/NKO8WsI1xUc62Ufp9ujDWFT1Cl7f2xNRRUOXpB21LyF1YiOhaU+faogS8OcrFIxX9+W1jfVlpHymAdjt/dFR+97hbJSQoJKR6SzmCwIqS0Lv3XI0eGNfcxH8hQsM/cg0uP8iceG7Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XMOgoKTTZ1i6BwDyI9KUQE2c49jJQyZcvDmMLW7E1d8=;
 b=s/GgVfFMwUBd/+ExtEe8yWLaA17QF8W1u56Jupp7CuM3n4Eu3uVqbwlHd8Ik92bYVW0WjC1ytj4NK180K11IyJN8HjUPOjXmGUWneQgNHpmuP3shtA1SCI1NdRdeHH7CYoiIV3o5vtYbOQ4VbZw+Xu7NhLd4XHwTibqaWVF9/qQ=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 CH2PR04MB7109.namprd04.prod.outlook.com (2603:10b6:610:9e::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.20; Sun, 6 Oct 2024 08:18:40 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%6]) with mapi id 15.20.8026.019; Sun, 6 Oct 2024
 08:18:40 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Bean Huo <beanhuo@iokpp.de>, "ulf.hansson@linaro.org"
	<ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, "vfazio@xes-inc.com" <vfazio@xes-inc.com>
CC: Bean Huo <beanhuo@micron.com>
Subject: RE: [PATCH v2 1/5] mmc_utils: Extract FFU code to mmc_ffu.c for
 future FFU mode expansion
Thread-Topic: [PATCH v2 1/5] mmc_utils: Extract FFU code to mmc_ffu.c for
 future FFU mode expansion
Thread-Index: AQHbFcOcmfGSUaD5DkSpD0ueVNTOfbJ5WkCQ
Date: Sun, 6 Oct 2024 08:18:39 +0000
Message-ID:
 <DM6PR04MB657535CC8DF7FABF32AE521AFC7C2@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20241003183848.58626-1-beanhuo@iokpp.de>
 <20241003183848.58626-2-beanhuo@iokpp.de>
In-Reply-To: <20241003183848.58626-2-beanhuo@iokpp.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|CH2PR04MB7109:EE_
x-ms-office365-filtering-correlation-id: 7cb0d2a4-abba-404c-d437-08dce5df7c0d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?+BeqIJ6rZVFEs38ifwBdf9cpjMg5mcsknoxY0IdPNOQUYA6PATrLKchPqcHC?=
 =?us-ascii?Q?nuYcUPQhz5MLVR+TKoFEYwUgKW8jp2oVrqhV+mFXqvfwRl3IyFhwTIARWfUo?=
 =?us-ascii?Q?XAfqFCsCPHsv/lbziixEzxjTbz7wTEB25OSjbGnhw/XHalyPbycFtn5jyxd7?=
 =?us-ascii?Q?ke3qwmeSaGfuDPaAl8oNFEo1vNQ/oa6oGTJ7vzTEnQ1Ma9qAvyCN5HbUoWrL?=
 =?us-ascii?Q?V03W6miTxfHa3wxf/z60R+ZbK5TMFr0KDY9U7l9RKRCQlT/pf0zsTOy0rQ2d?=
 =?us-ascii?Q?J+7ngr2ofOQnTD95aYo+CGQMto/K769oxtPOXuO+cLrALdqnvgxzxM/QveL4?=
 =?us-ascii?Q?5snK7ZvyYhsEReXxMoJm3VRNK/s+47ywlnh5IZrtyzfBsKX/Dqw7ssE5ERW+?=
 =?us-ascii?Q?Nvys//6LQyMJZwNxh5UJ5cJpZvqU+hYpEMADhaeHaD0MV83R+csFFLvx9Nzh?=
 =?us-ascii?Q?MpToyvfdo+tpQczRvTt9lmP5lQMvOLpizCmRi5V3J3NX2FvAFfXsF72dA2oH?=
 =?us-ascii?Q?jdDtQtAYY/fopCOjF6PqS936BiwROy4s/x4pZdrzTeslH5LQVfNWtoJQVbMJ?=
 =?us-ascii?Q?sSjVLN+arl1UbSR70JygFA5UMUvw18sSv+CwRGPNLvafGrR4qn4DKC1hlaNM?=
 =?us-ascii?Q?Xwr9lcceGWIC2ToWy1I0XEBTFZMq04lhwtt+tZ9ogNp7HqeybzS8I9hUDYjZ?=
 =?us-ascii?Q?jY+NHIT4/uuHW2TCrzyCUHpyyXNyAS2WnAUA74ntSmy74LmeOS2gGW0Pkjtu?=
 =?us-ascii?Q?7Y7/7Vii6CvwYtUvmaHwOA7nr1Hxm4/Ovj6xRJzXzThV7p8PqepYA1Dhs541?=
 =?us-ascii?Q?XB/4K7lb2fi35qKDgiq7OLUKzOefHfkZHrSFN4a1oH3hXb+t/F5B0Lcr3wMH?=
 =?us-ascii?Q?U5CxU0iuV+m3+ZswBSE5v3MZtSNTDw7rtbafYXrsFCMBuSR4C3YqKKcJxYMa?=
 =?us-ascii?Q?Jwky17i166BGBRMfHHJJtyL/xrUhe1eBAQGOcqac7MgnyXyRrBkLdO63enis?=
 =?us-ascii?Q?gpKTkkXvYAKB6igun0YjmAToEXSgCpc/T7Co9eTXCY5wyzUUbu5wbSH+Rabb?=
 =?us-ascii?Q?USw8GMJuv9Rikn5IsdLNCcdz5A6fY0n6bwiTn8MEoMnjlFgX/QQ/7bgmoOcX?=
 =?us-ascii?Q?TPA4XMCby2i9Xi+Dv5WLX5x8s+eHZs2OvxIZXHt0paVqrTJxKKTvMdnPL9As?=
 =?us-ascii?Q?Y+odxnLapGBZAx/1CKZZnnV7f8EEgW/svn3nnuMt2/S+AKSHyxh6kIhH+u0d?=
 =?us-ascii?Q?RoPKQhgApLWN4LZqjm7C93/Ez7f/xasXTFuCzl1y1D8lnVLzY0Kk+BFjX1SJ?=
 =?us-ascii?Q?dcmTfD6p+eaGu5+b9FXcnID13g5hkFDQB90xdXjEjvnlFw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?hOjbnRM27hFgcnFEsidkxHvKxsnw9BUoPnLBzuj/nSuFH5eW5wax8IK9E+I0?=
 =?us-ascii?Q?LUTykyTBPUu2N8VDSxKjHojvj+n9x19Twt2aGFX0R5VTybsdBx6oxj9mFLTC?=
 =?us-ascii?Q?zJ2Z1bLSWqp5p0F8A3C+/3xStfKuWwSk2AZJ3IBlafb0v8+hwqBoHEbGRYVN?=
 =?us-ascii?Q?e45JOXPD/wQqYOGmepaDOP9FfURmmSauBuv9OZxva8ixDAIlN8bJKt8ZFotI?=
 =?us-ascii?Q?4dZf12+dqYIFcYvGXKKbcYpgCEW6TgRdlSZMkwqStOfvrekGADig4Ix8czGM?=
 =?us-ascii?Q?O3oItgd+kdBMYKIoUXtFJT8IYgTvQc/syZObdtvqy02bj66msdnDo4TyG+nj?=
 =?us-ascii?Q?2kvWTedFo7ygyv4Oxp4/w20S32lCNqhHF3X6+2wght5GsMuMw0gu2P5NKcWI?=
 =?us-ascii?Q?LkHJ+1pkt35CYShgyfGv0KQCAKV6U9wMQ8hODM8BTp9rQAGcod0ReLxCcUo/?=
 =?us-ascii?Q?a2oOl/QFrfPKPVte3qIafO34/Ojs08ApdnkwMeJjiMyrz8fZqgf/9BxFjzFh?=
 =?us-ascii?Q?aQMPkO3jHpAdReMugzP01JlWEr3SwixKa+UIwdrmT7HSbuPvsiWpC0K8zK16?=
 =?us-ascii?Q?21/39uaZPsL2JY1MBQVMFrttvMTINHow+8AfizfasFWgR7ljbdvbbl0uBHDJ?=
 =?us-ascii?Q?MzN8NLaBVPF9KXx4AHEcIC9yVDQMd8Z8zEZ07D+KdIcW3lAbtbyo0HuKF4XW?=
 =?us-ascii?Q?DK9Ddq/hBlvS1/v3RD0dt49pGC+CjBks/h9DIiR8s+iOqG5d7sbbajQZGox2?=
 =?us-ascii?Q?EHHZ3g2rSHc5azdlU4IPya9GO5tBxRaAJlKnN92XrgyFeRK0NAJmImrygPEq?=
 =?us-ascii?Q?Oq10H+Z6gNCP9S+XF9sDLC7/lPX0GMLTQ3r17UMMAHM9IVD08B9d8hLbms2F?=
 =?us-ascii?Q?juVT65prygDWTHoTib/WhtSLY5uVbZa8kIgjX6cOQ+GryihoeE55KkQfyRd8?=
 =?us-ascii?Q?xGCWj4jbVsDoZEWsjCDj/Ll+WKnZO2zA2SHIm/xQinFGawWaQMnwV6L6JDU5?=
 =?us-ascii?Q?ZBwg6sqnpajmRlY/Sdz2jPg79lkkXTf0/NkqIjeX3QdimlCQkKEL00VLmlCl?=
 =?us-ascii?Q?ZY1OU4lcDtacQ/lGsikOhDtIwkD/txwy4ly0UtEu5JYeWSSZvmQ26+JrQySz?=
 =?us-ascii?Q?OBvJJFJhamY+6iUS9Nznt1MhIYD9z9uSU83uUg/fnCJwdZqjxVxzP3LXkpsq?=
 =?us-ascii?Q?LYcsWFviBMpUcszTvhrAlWahCQSfMoqBt1pY5MctZqIaX5t7xnooClgiv5Qx?=
 =?us-ascii?Q?kskPCGUgpggYSnR7uHfdZvkstJfhTO6QLXQgoMlqsPuEkn62nZLs192p2Vme?=
 =?us-ascii?Q?6RIDoiZPFOEDZ2XzlNBOI2A8AVgEpPUw3d5UeUhGj5UaEbRiBZl+C9frQtpQ?=
 =?us-ascii?Q?XMK/tzfNgTnvc9BIi8rB8bahP1DJWiyewxirlj5nXuVnUVyb/eIP4d6BSM14?=
 =?us-ascii?Q?NE/I2V3hDKJ4itYwM0vZUeR4qqa7+KEaU2JAXwANI55+WtsEO20mVoQZ/v0P?=
 =?us-ascii?Q?v0frxCvn5hNxPDgwHfxqBwNKwgVYOPiEWgDNEWFh+RP1euq4/4svFq6rgWwO?=
 =?us-ascii?Q?Vwu9VWy7i6jRjPTQYiNgoGLXmWiM0yCSuHJdgNql?=
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
	ydAWwAK94Ph71fM3B4MQNxTR8rlTzo4jYssTNVlQu+9VUaEiychUYROf16KK0pFlMgx8gd45uLGNYrg+sqMNABAUYe/2CdZb/kED10JEgloiyXkfg7EZH5ztVKsQcXdUBqqheQdXvk8YMg8ABhq7VkpuRo+qwollclP2Smp7bT9qBpmGQXxfcPdkfXC2KB/y0RN2xxzVYFEBoVsfNrVHuuSwv/plWBK4YRBOOKq0Cog5mEYeSJF0AcUw52+E345htpJXy17j9Ypxmtb1AArn5RSv5xj4SfujVS1SuxiRY9gH7xkjPwetJvQ0uB35GsCo/i6qp21/TJqsoeptNJgtkXiY5iB/W5SU5rm2hJoV/8nfm1vwshw3JvZIJ13bn/uaxd//0dVylgTKqTbwe1I9LogXXuhfNCzU5zZZYmuIsAovummg74EJ3BK/hdBhCmAuTMc9cq7CCltiJMPwyttRdwt7eYPnLVanOcQL92u5zhmlI/Em7oSJYcfDqHZYEJpObGvPKLdlOyev9+yRoCciZOWggKWLRgSyS8PW/o2Ur5PwBsCwBcB5XnxlzmSzYbFGRgmzx1m6SjBIhcIGvjOmSO86YUQp0tXOBOx5I8Hy3YyFky1SpsXOUtsLxcwmbAHK
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cb0d2a4-abba-404c-d437-08dce5df7c0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2024 08:18:40.1151
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VOor3q2su6zulb06O+9+RvUgcnAnUVmOXMNCP06RtiOlEFZw6tPEfGTPMgtRy6dkJWwIn9LyiMBv6Ywn5ykGvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB7109

>=20
> From: Bean Huo <beanhuo@micron.com>
>=20
> Refactor FFU functionality by extracting existing FFU code from `mmc_cmds=
.c`
> into a dedicated file, `mmc_ffu.c`. Updated `do_ffu` in `mmc_utils` to re=
flect
> the new structure and interface. This restructuring provides better code
> organization and a clearer separation of concerns, making it easier to
> maintain and extend FFU functionality.
>=20
> Follow-up patches will focus on implementing additional FFU modes and
> enhancements.
>=20
> Signed-off-by: Bean Huo <beanhuo@micron.com>
> ---
>  Makefile   |   1 +
>  mmc.c      |  11 +-
>  mmc_cmds.c | 274 --------------------------------------------
>  mmc_cmds.h |  52 +++++++++
>  mmc_ffu.c  | 324
> +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 384 insertions(+), 278 deletions(-)  create mode 100644
> mmc_ffu.c
>=20
> diff --git a/Makefile b/Makefile
> index 06ae0f7..35aca6c 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -7,6 +7,7 @@ objects =3D \
>         mmc.o \
>         mmc_cmds.o \
>         lsmmc.o \
> +       mmc_ffu.o \
I don't think a new module is even needed.

>         3rdparty/hmac_sha/hmac_sha2.o \
>         3rdparty/hmac_sha/sha2.o
>=20
> diff --git a/mmc.c b/mmc.c
> index 2c5b9b5..52c5a89 100644
> --- a/mmc.c
> +++ b/mmc.c
> @@ -227,11 +227,14 @@ static struct Command commands[] =3D {
>                   "The device path should specify the scr file directory.=
",
>           NULL
>         },
> -       { do_ffu, -2,
> -         "ffu", "<image name> <device> [chunk-bytes]\n"
> +       { do_ffu, -4,
> +         "ffu", "-i <image name> -p <device> [ -c <chunk-bytes>] [-m
> <ffu_mode>]\n"
>                 "Run Field Firmware Update with <image name> on <device>.=
\n"
> -               "[chunk-bytes] is optional and defaults to its max - 512k=
. "
> -               "should be in decimal bytes and sector aligned.\n",
> +               "[-c <chunk-bytes>] is optional and defaults to its max -=
 512k. "
> +               "should be in decimal bytes and sector aligned.\n"
> +               "[-m <ffu_mode>] Optional, provides five firmware bundle
> download command modes:\n"
> +               " -m 1: Default mode, utilizing the CMD6+CMD23+CMD25+CMD6
> command sequence. This \n"
> +               " may exit FFU mode during firmware bundle downloading
> + if FW size exceeds the chunk size. \n",
>           NULL
>         },
Did you consider, instead of adding a new argument <ffu_mode>, to add new c=
ommands?
e.g. ffu2, ffu3, etc...

>         { do_erase, -4,
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index 3b1bcf4..22ab7d9 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -58,41 +58,6 @@
>  #define WPTYPE_PWRON 2
>  #define WPTYPE_PERM 3
>=20
> -static inline __u32 per_byte_htole32(__u8 *arr) -{
> -       return arr[0] | arr[1] << 8 | arr[2] << 16 | arr[3] << 24;
> -}
> -
> -static int read_extcsd(int fd, __u8 *ext_csd) -{
> -       int ret =3D 0;
> -       struct mmc_ioc_cmd idata;
> -       memset(&idata, 0, sizeof(idata));
> -       memset(ext_csd, 0, sizeof(__u8) * 512);
> -       idata.write_flag =3D 0;
> -       idata.opcode =3D MMC_SEND_EXT_CSD;
> -       idata.arg =3D 0;
> -       idata.flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
> -       idata.blksz =3D 512;
> -       idata.blocks =3D 1;
> -       mmc_ioc_cmd_set_data(idata, ext_csd);
> -
> -       ret =3D ioctl(fd, MMC_IOC_CMD, &idata);
> -       if (ret)
> -               perror("ioctl");
> -
> -       return ret;
> -}
> -
> -static void fill_switch_cmd(struct mmc_ioc_cmd *cmd, __u8 index, __u8
> value) -{
> -       cmd->opcode =3D MMC_SWITCH;
> -       cmd->write_flag =3D 1;
> -       cmd->arg =3D (MMC_SWITCH_MODE_WRITE_BYTE << 24) | (index << 16) |
> -                  (value << 8) | EXT_CSD_CMD_SET_NORMAL;
> -       cmd->flags =3D MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
> -}
> -
>  static int
>  write_extcsd_value(int fd, __u8 index, __u8 value, unsigned int timeout_=
ms)
> { @@ -2101,18 +2066,6 @@ struct rpmb_frame {
>         u_int16_t req_resp;
>  };
>=20
> -static inline void set_single_cmd(struct mmc_ioc_cmd *ioc, __u32 opcode,
> -                                 int write_flag, unsigned int blocks,
> -                                 __u32 arg)
> -{
> -       ioc->opcode =3D opcode;
> -       ioc->write_flag =3D write_flag;
> -       ioc->arg =3D arg;
> -       ioc->blksz =3D 512;
> -       ioc->blocks =3D blocks;
> -       ioc->flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
> -}
> -
>  /* Performs RPMB operation.
>   *
>   * @fd: RPMB device on which we should perform ioctl command @@ -
> 2810,233 +2763,6 @@ out:
>         return ret;
>  }
>=20
> -static void set_ffu_single_cmd(struct mmc_ioc_multi_cmd *multi_cmd,
> -                              __u8 *ext_csd, unsigned int bytes, __u8 *b=
uf,
> -                              off_t offset)
> -{
> -       __u32 arg =3D per_byte_htole32(&ext_csd[EXT_CSD_FFU_ARG_0]);
> -
> -       /* send block count */
> -       set_single_cmd(&multi_cmd->cmds[1], MMC_SET_BLOCK_COUNT, 0, 0,
> -                      bytes / 512);
> -       multi_cmd->cmds[1].flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R1 |
> MMC_CMD_AC;
> -
> -       /*
> -        * send image chunk: blksz and blocks essentially do not matter, =
as
> -        * long as the product is fw_size, but some hosts don't handle la=
rger
> -        * blksz well.
> -        */
> -       set_single_cmd(&multi_cmd->cmds[2], MMC_WRITE_MULTIPLE_BLOCK,
> 1,
> -                      bytes / 512, arg);
> -       mmc_ioc_cmd_set_data(multi_cmd->cmds[2], buf + offset);
> -}
> -
> -int do_ffu(int nargs, char **argv)
> -{
> -       int dev_fd, img_fd;
> -       int retry =3D 3, ret =3D -EINVAL;
> -       unsigned int sect_size;
> -       __u8 ext_csd[512];
> -       __u8 *buf =3D NULL;
> -       off_t fw_size, bytes_left, off;
> -       char *device;
> -       struct mmc_ioc_multi_cmd *multi_cmd =3D NULL;
> -       unsigned int default_chunk =3D MMC_IOC_MAX_BYTES;
> -       __u32 sect_done =3D 0;
> -
> -       assert (nargs =3D=3D 3 || nargs =3D=3D 4);
> -
> -       device =3D argv[2];
> -       dev_fd =3D open(device, O_RDWR);
> -       if (dev_fd < 0) {
> -               perror("device open failed");
> -               exit(1);
> -       }
> -       img_fd =3D open(argv[1], O_RDONLY);
> -       if (img_fd < 0) {
> -               perror("image open failed");
> -               close(dev_fd);
> -               exit(1);
> -       }
> -
> -       ret =3D read_extcsd(dev_fd, ext_csd);
> -       if (ret) {
> -               fprintf(stderr, "Could not read EXT_CSD from %s\n", devic=
e);
> -               goto out;
> -       }
> -
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
> -               goto out;
> -       }
> -
> -       fw_size =3D lseek(img_fd, 0, SEEK_END);
> -       if (fw_size =3D=3D 0) {
> -               fprintf(stderr, "Wrong firmware size");
> -               goto out;
> -       }
> -
> -       /* allocate maximum required */
> -       buf =3D malloc(fw_size);
> -       multi_cmd =3D calloc(1, sizeof(struct mmc_ioc_multi_cmd) +
> -                               4 * sizeof(struct mmc_ioc_cmd));
> -       if (!buf || !multi_cmd) {
> -               perror("failed to allocate memory");
> -               goto out;
> -       }
> -
> -       /* ensure fw is multiple of native sector size */
> -       sect_size =3D (ext_csd[EXT_CSD_DATA_SECTOR_SIZE] =3D=3D 0) ? 512 =
: 4096;
> -       if (fw_size % sect_size) {
> -               fprintf(stderr, "Firmware data size (%jd) is not aligned!=
\n",
> (intmax_t)fw_size);
> -               goto out;
> -       }
> -
> -       if (nargs =3D=3D 4) {
> -               default_chunk =3D strtol(argv[3], NULL, 10);
> -               if (default_chunk > MMC_IOC_MAX_BYTES || default_chunk % =
512)
> {
> -                       fprintf(stderr, "Invalid chunk size");
> -                       goto out;
> -               }
> -       }
> -
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
> -       /* read firmware */
> -       lseek(img_fd, 0, SEEK_SET);
> -       if (read(img_fd, buf, fw_size) !=3D fw_size) {
> -               perror("Could not read the firmware file: ");
> -               ret =3D -ENOSPC;
> -               goto out;
> -       }
> -
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
> -
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
> -       }
> -
> -       /*
> -        * By spec - check if mode operation codes are supported in ffu f=
eatures,
> -        * if not then skip checking number of sectors programmed after i=
nstall
> -        */
> -       if (!ext_csd[EXT_CSD_FFU_FEATURES]) {
> -               fprintf(stderr, "Please reboot to complete firmware insta=
llation on
> %s\n", device);
> -               ret =3D 0;
> -               goto out;
> -       }
> -
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
> -               goto out;
> -       }
> -
> -       fprintf(stderr, "Installing firmware on %s...\n", device);
> -       /* Re-enter ffu mode and install the firmware */
> -       multi_cmd->num_of_cmds =3D 2;
> -
> -       /* set ext_csd to install mode */
> -       fill_switch_cmd(&multi_cmd->cmds[1],
> EXT_CSD_MODE_OPERATION_CODES,
> -                       EXT_CSD_FFU_INSTALL);
> -
> -       /* send ioctl with multi-cmd */
> -       ret =3D ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
> -
> -       if (ret) {
> -               perror("Multi-cmd ioctl failed setting install mode");
> -               /* In case multi-cmd ioctl failed before exiting from ffu=
 mode */
> -               ioctl(dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[3]);
> -               goto out;
> -       }
> -
> -       ret =3D read_extcsd(dev_fd, ext_csd);
> -       if (ret) {
> -               fprintf(stderr, "Could not read EXT_CSD from %s\n", devic=
e);
> -               goto out;
> -       }
> -
> -       /* return status */
> -       ret =3D ext_csd[EXT_CSD_FFU_STATUS];
> -       if (ret) {
> -               fprintf(stderr, "%s: error %d during FFU install:\n", dev=
ice, ret);
> -               goto out;
> -       } else {
> -               fprintf(stderr, "FFU finished successfully\n");
> -       }
> -
> -out:
> -       free(buf);
> -       free(multi_cmd);
> -       close(img_fd);
> -       close(dev_fd);
> -       return ret;
> -}
> -
>  int do_general_cmd_read(int nargs, char **argv)  {
>         int dev_fd;
> diff --git a/mmc_cmds.h b/mmc_cmds.h
> index 5f2bef1..40a137d 100644
> --- a/mmc_cmds.h
> +++ b/mmc_cmds.h
> @@ -16,6 +16,57 @@
>   * Modified to add field firmware update support,
>   * those modifications are Copyright (c) 2016 SanDisk Corp.
>   */
> +#include <sys/ioctl.h>
> +#include <sys/stat.h>
> +#include <string.h>
> +#include "mmc.h"
> +
> +static inline __u32 per_byte_htole32(__u8 *arr) {
> +       return arr[0] | arr[1] << 8 | arr[2] << 16 | arr[3] << 24; }
> +
> +
> +static inline int read_extcsd(int fd, __u8 *ext_csd)
AFAIK, while the Linux kernel coding conventions do not explicitly forbid i=
mplementing C code in header files,
they strongly discourage it except in specific cases.
You could just include it in mmc_cmds.h, but again - I don't think a new mo=
dule is even needed.

> +       int ret =3D 0;
> +       struct mmc_ioc_cmd idata;
> +       memset(&idata, 0, sizeof(idata));
> +       memset(ext_csd, 0, sizeof(__u8) * 512);
> +       idata.write_flag =3D 0;
> +       idata.opcode =3D MMC_SEND_EXT_CSD;
> +       idata.arg =3D 0;
> +       idata.flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
> +       idata.blksz =3D 512;
> +       idata.blocks =3D 1;
> +       mmc_ioc_cmd_set_data(idata, ext_csd);
> +
> +       ret =3D ioctl(fd, MMC_IOC_CMD, &idata);
> +       if (ret)
> +               perror("ioctl");
> +
> +       return ret;
> +}
> +
> +static inline void fill_switch_cmd(struct mmc_ioc_cmd *cmd, __u8 index,
> __u8 value)
> +{
> +       cmd->opcode =3D MMC_SWITCH;
> +       cmd->write_flag =3D 1;
> +       cmd->arg =3D (MMC_SWITCH_MODE_WRITE_BYTE << 24) | (index << 16) |
> +                  (value << 8) | EXT_CSD_CMD_SET_NORMAL;
> +       cmd->flags =3D MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
> +}
> +
> +static inline void set_single_cmd(struct mmc_ioc_cmd *ioc, __u32 opcode,
> int write_flag,
> +                                               unsigned int blocks, __u3=
2 arg)
> +{
> +       ioc->opcode =3D opcode;
> +       ioc->write_flag =3D write_flag;
> +       ioc->arg =3D arg;
> +       ioc->blksz =3D 512;
> +       ioc->blocks =3D blocks;
> +       ioc->flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
> +}
>=20
>  /* mmc_cmds.c */
>  int do_read_extcsd(int nargs, char **argv);
> @@ -50,3 +101,4 @@ int do_general_cmd_read(int nargs, char **argv);
>  int do_softreset(int nargs, char **argv);
>  int do_preidle(int nargs, char **argv);
>  int do_alt_boot_op(int nargs, char **argv);
> +int do_ffu(int nargs, char **argv);
> diff --git a/mmc_ffu.c b/mmc_ffu.c
> new file mode 100644
> index 0000000..5f7cb00
> --- /dev/null
> +++ b/mmc_ffu.c
> @@ -0,0 +1,324 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Modified and add more FFU modes.
> + * And changed and updated by: Bean Huo <beanhuo@micron.com>
> + */
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <stdint.h>
> +#include <fcntl.h>
> +#include <sys/ioctl.h>
> +#include <sys/types.h>
> +#include <ctype.h>
> +#include <errno.h>
> +#include <stdbool.h>
> +#include <assert.h>
> +#include <unistd.h>
> +
> +#include "mmc.h"
> +#include "mmc_cmds.h"
> +
> +static int do_ffu_download(int *dev_fd, __u8 *ext_csd, __u8 *fw_buf, off=
_t
> fw_size, unsigned int chunk_size);
> +
> +static void set_ffu_download_cmd(struct mmc_ioc_multi_cmd *multi_cmd,
> __u8 *ext_csd,
> +                               unsigned int bytes, __u8 *buf, off_t offs=
et)
> +{
> +       __u32 arg =3D per_byte_htole32(&ext_csd[EXT_CSD_FFU_ARG_0]);
> +
> +       /* send block count */
> +       set_single_cmd(&multi_cmd->cmds[1], MMC_SET_BLOCK_COUNT, 0, 0,
> bytes / 512);
> +       multi_cmd->cmds[1].flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R1 |
> MMC_CMD_AC;
> +
> +       /*
> +        * send image chunk: blksz and blocks essentially do not matter, =
as
> +        * long as the product is fw_size, but some hosts don't handle la=
rger
> +        * blksz well.
> +        */
> +       set_single_cmd(&multi_cmd->cmds[2], MMC_WRITE_MULTIPLE_BLOCK,
> 1, bytes / 512, arg);
> +       mmc_ioc_cmd_set_data(multi_cmd->cmds[2], buf + offset);
> +}
> +
> +static int get_ffu_sectors_programmed(int *dev_fd, __u8 *ext_csd)
> +{
> +       int ret;
> +
> +       ret =3D read_extcsd(*dev_fd, ext_csd);
> +       if (ret) {
> +               fprintf(stderr, "Could not read EXT_CSD\n");
> +               return ret;
> +       }
> +
> +       ret =3D per_byte_htole32((__u8
> *)&ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_0]);
> +
> +       return ret;
> +}
> +
> +static bool ffu_is_supported(__u8 *ext_csd, char *device)
> +{
> +       if (ext_csd =3D=3D NULL) {
> +               fprintf(stderr, "ext_cst is NULL\n");
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
> +                                                       unsigned int chun=
k_size)
> +{
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
> +
> +       /* prepare multi_cmd for FFU based on cmd to be used */
> +       /* put device into ffu mode */
> +       fill_switch_cmd(&multi_cmd->cmds[0], EXT_CSD_MODE_CONFIG,
> EXT_CSD_FFU_MODE);
> +
> +       /* return device into normal mode */
> +       fill_switch_cmd(&multi_cmd->cmds[3], EXT_CSD_MODE_CONFIG,
> EXT_CSD_NORMAL_MODE);
> +
> +do_retry:
> +       bytes_left =3D fw_size;
> +       off =3D 0;
> +       multi_cmd->num_of_cmds =3D num_of_cmds;
> +
> +       while (bytes_left) {
> +               bytes_per_loop =3D bytes_left < chunk_size ? bytes_left :=
 chunk_size;
> +
> +               /* prepare multi_cmd for FFU based on cmd to be used */
> +               set_ffu_download_cmd(multi_cmd, ext_csd, bytes_per_loop,
> fw_buf, off);
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
> +int do_ffu(int nargs, char **argv)
> +{
> +       int opt;
> +       int dev_fd, img_fd;
> +       int ret =3D -EINVAL;
> +       unsigned int sect_size;
> +       __u8 ext_csd[512];
> +       __u8 *fw_buf =3D NULL;
> +       off_t fw_size;
> +       char *device, *fw_img;
> +       struct mmc_ioc_multi_cmd *multi_cmd =3D NULL;
> +       unsigned int default_chunk =3D MMC_IOC_MAX_BYTES;
> +       int sect_done =3D 0;
> +       __u8 ffu_mode =3D 1;
> +
> +       assert(nargs >=3D 4);
> +
> +       while ((opt =3D getopt(nargs, argv, "i:p:m:c:")) !=3D -1) {
Changing the api for just one command type is problematic.
If we are going to do it,  then it should be done in its own designated ser=
ies,
And in a way that will not break the legacy api.

Also, given the extent of use of this feature - I don't think that the api =
of the current mode (default) should be changed.
Meaning people should still be able to run ./mmc ffu <fluf> <dev> as they a=
lways did.

> +               switch (opt) {
> +               case 'i':
> +                       fw_img =3D optarg;
> +                       break;
> +               case 'p':
> +                       device =3D optarg;
> +                       break;
> +               case 'c':
> +                       default_chunk =3D atoi(optarg);
> +                       if (default_chunk > MMC_IOC_MAX_BYTES || default_=
chunk %
> 512) {
> +                               fprintf(stderr, "Invalid chunk size");
> +                               exit(1);
> +                       }
> +                       break;
> +               case 'm':
> +                       ffu_mode =3D atoi(optarg);
> +                       if (ffu_mode > 1) {
> +                               fprintf(stderr, "Unsupported ffu mode `%d=
'.\n",
> ffu_mode);
> +                               abort();
> +                       }
> +                       break;
> +               default:
> +                       /* Unknown option or missing argument for options=
 */
> +                       if (isprint(optopt))
> +                               fprintf(stderr, "Unknown option `-%c'.\n"=
, optopt);
> +                       else
> +                               fprintf(stderr, "Unknown option character=
 `\\x%x'.\n",
> optopt);
> +                       abort();
> +               }
> +       }
> +       fprintf(stderr, "eMMC Devie: %s, fw %s, FFU mode %d, chunk size:
> %d\n",
> +                                                       device, fw_img, f=
fu_mode, default_chunk);
I think that all this part, from here and up to pretty much do_retry,
Can be packed into a ffu_prepare() handler.
Each do_ffu: do_ffu, do_ffu2, do_ffu3 etc. can call it with its applicable =
arguments.
I think you would end up with much less code this way.

The do_retry part is common to all modes: __do_ffu().

And a 3rd wrapping-up phase, post do_retry.

Thanks,
Avri

> +       dev_fd =3D open(device, O_RDWR);
> +       if (dev_fd < 0) {
> +               perror("device open failed");
> +               exit(1);
> +       }
> +       img_fd =3D open(fw_img, O_RDONLY);
> +       if (img_fd < 0) {
> +               perror("image open failed");
> +               close(dev_fd);
> +               exit(1);
> +       }
> +
> +       ret =3D read_extcsd(dev_fd, ext_csd);
> +       if (ret) {
> +               fprintf(stderr, "Could not read EXT_CSD from %s\n", devic=
e);
> +               goto out;
> +       }
> +       if (ffu_is_supported(ext_csd, device) <=3D 0)
> +               goto out;
> +
> +       fw_size =3D lseek(img_fd, 0, SEEK_END);
> +       if (fw_size =3D=3D 0) {
> +               fprintf(stderr, "Wrong firmware size");
> +               goto out;
> +       }
> +       /* ensure fw is multiple of native sector size */
> +       sect_size =3D (ext_csd[EXT_CSD_DATA_SECTOR_SIZE] =3D=3D 0) ? 512 =
: 4096;
> +       if (fw_size % sect_size) {
> +               fprintf(stderr, "Firmware data size (%jd) is not aligned!=
\n",
> (intmax_t)fw_size);
> +               goto out;
> +       }
> +       /* allocate maximum required */
> +       fw_buf =3D malloc(fw_size);
> +       if (!fw_buf) {
> +               perror("failed to allocate memory");
> +               goto out;
> +       }
> +       /* read firmware */
> +       lseek(img_fd, 0, SEEK_SET);
> +       if (read(img_fd, fw_buf, fw_size) !=3D fw_size) {
> +               perror("Could not read the firmware file: ");
> +               ret =3D -ENOSPC;
> +               goto out;
> +       }
> +
> +       sect_done =3D do_ffu_download((int *)&dev_fd, ext_csd, fw_buf, fw=
_size,
> default_chunk);
> +
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
> +       }
> +       /*
> +        * By spec - check if mode operation codes are supported in ffu
> features,
> +        * if not then skip checking number of sectors programmed after i=
nstall
> +        */
> +       if (!ext_csd[EXT_CSD_FFU_FEATURES]) {
> +               fprintf(stderr, "Please reboot to complete firmware insta=
llation on
> %s\n", device);
> +               ret =3D 0;
> +               goto out;
> +       }
> +
> +       fprintf(stderr, "Installing firmware on %s...\n", device);
> +       multi_cmd =3D calloc(1, sizeof(struct mmc_ioc_multi_cmd) + 2 *
> sizeof(struct mmc_ioc_cmd));
> +       if (!multi_cmd) {
> +               perror("failed to allocate memory");
> +               ret =3D -ENOMEM;
> +               goto out;
> +       }
> +
> +       /* Re-enter ffu mode and install the firmware */
> +       multi_cmd->num_of_cmds =3D 2;
> +       /* put device into ffu mode */
> +       fill_switch_cmd(&multi_cmd->cmds[0], EXT_CSD_MODE_CONFIG,
> EXT_CSD_FFU_MODE);
> +       /* Re-enter ffu mode and set ext_csd to install mode */
> +       fill_switch_cmd(&multi_cmd->cmds[1],
> EXT_CSD_MODE_OPERATION_CODES, EXT_CSD_FFU_INSTALL);
> +
> +       /* send ioctl with multi-cmd */
> +       ret =3D ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
> +
> +       if (ret) {
> +               perror("Multi-cmd ioctl failed setting install mode");
> +               fill_switch_cmd(&multi_cmd->cmds[1], EXT_CSD_MODE_CONFIG,
> EXT_CSD_NORMAL_MODE);
> +               /* In case multi-cmd ioctl failed before exiting from ffu=
 mode */
> +               ioctl(dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[1]);
> +               goto out;
> +       }
> +
> +       ret =3D read_extcsd(dev_fd, ext_csd);
> +       if (ret) {
> +               fprintf(stderr, "Could not read EXT_CSD from %s\n", devic=
e);
> +               goto out;
> +       }
> +
> +       /* return status */
> +       ret =3D ext_csd[EXT_CSD_FFU_STATUS];
> +       if (ret)
> +               fprintf(stderr, "%s: error %d during FFU install:\n", dev=
ice, ret);
> +       else
> +               fprintf(stderr, "FFU finished successfully\n");
> +
> +out:
> +       if (fw_buf)
> +               free(fw_buf);
> +       if (multi_cmd)
> +               free(multi_cmd);
> +       close(img_fd);
> +       close(dev_fd);
> +       return ret;
> +}
> --
> 2.34.1
>=20

