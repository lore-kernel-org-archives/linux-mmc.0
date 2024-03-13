Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6152F33F7
	for <linux-mmc@vger.kernel.org>; Wed, 13 Mar 2024 12:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710334267; cv=fail; b=ebJSRlrGQTJZbk87Rn2bUXuhwDKACg37/zZbr3W5hRD7RzNEz4PYp7ZUpC3pV0odYuBLxkJ9n8NIuQ0DMTSgSIuSXpWouTITEk8VBwUYQKsdkvaTVz5PJ8BBDSLcaoZyUPKM0Ha+xx1pdAG1bHshwbUT1GH0oaEkIacYzkQJuUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710334267; c=relaxed/simple;
	bh=L3MMGU+VuSPOLZ38Hiv9dSUw3Bwu+coQT2lNAmQq3Ow=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HrQ1bvSgoRyMxrSQk/4NcdJ4D33nLQPMJ+TJGeN9LUN8wyn7P58/A1Wp08C+5a2qKaAH9zbK8Xh/xA1V0ckTuaATaDm81Y1xLD1zHsSGR75Z90HhHA0N5JjQLNXW48VoxvkEIG9c7yjrmdAyKCj/pwwfDe3Q4iUvQn1wa5k+tT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=jMEwNzNA; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=COwOCtmw; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jMEwNzNA";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="COwOCtmw"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1710334264; x=1741870264;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=L3MMGU+VuSPOLZ38Hiv9dSUw3Bwu+coQT2lNAmQq3Ow=;
  b=jMEwNzNAJTEgNVCj+3D9ovCnpakX7ybduG5rlsP/VLklwAa9/vhYYs+4
   00dEPqTfpqBHmTf3kV5Z7lEYif/7LbuyWtnnCzhPIQA1RSzC2S0USZHOM
   Df7fs1fEMihr8xXmzDR589Nk5FK4U51WY0F+EBjS/CLcWJJEV9GF1TtO/
   lzTOTesI68mK4etwXpq06sK/orH+PuJS6cbpAg+qRAVEZsOtb3USRtd35
   I8ZOy+i5ESAc2bB4NlEAZ0IZIki/S2V3k69RkbOt7QZVRVTE06sas+Gl8
   BtoRj4YS7aK26Cg1pgljwtkLvhvM670V4DjaDJXiF8qx5jl85EH0Xe4HK
   Q==;
X-CSE-ConnectionGUID: 6BN/zmZRSDSMwlNUPFLL7g==
X-CSE-MsgGUID: aoxOlv01QneweLxv+w4K0A==
X-IronPort-AV: E=Sophos;i="6.07,122,1708358400"; 
   d="scan'208";a="11007599"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 13 Mar 2024 20:50:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TX8ZmHdq+x6lYasLrwbrVU4QbYc+q3JWL5Tqq5bRE+fyC+eI8K7QGGi8z5Za7Et9A1jxCJz3mxMumk6rP4uT47drLQofMmlAGNLTJPTvfTLZWNVgT3srpKfZB34wAwxYYehu/S+BZb/tG128a2u8DleYzAWn+PE9E/HIfE1tW+z02GKWsCrIpjNvB41Ke7VGIgilvabmwVc3jOCNVOuXhOqeG6LChROCHCPLq+PhkcscPW5haBOUxq56wlF0jDEdaZxbZZwJmCzGMXIwKFUfBjHCzPLda0X8rDV6Apj9dovcXkfLtvTjPx0ETxyT1h1HCtx3n1uhAok6lSvZMAauBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ir5XVirlL2w+FN0z1biqjOgVIOj24vsX3vp2u1GmRh0=;
 b=BszQQPY731nSZR2lHtPBb7GlkVNId0BThL352ulS+LGWOtzbABJmsSJpLqhwGG7x0p2QIzH5++FBXVIL1KoGKrikTcIFkxEEIxZsdyEeuMvgPXx0zaHOOPlOAaorsjuzHFH+Dmsss6SEJcNfwn0cIGWTBKYkkmNDIsVnJER5uteZFt8w14jGjpfkuq6JDuoIEyv/32Ggmw6z9+qL8atTVJ1WZGyAw0TKTa6zPP0/I6hAlT9qA42cDOG3nl87RB1eG61Qu9n2jzslx7OhX8IDFinwH5f/mGC+skTZwGKUUJJXsoW+c+gPcu+iyTfDSZutbF9wtu2ejC8zyfFvvPcA8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ir5XVirlL2w+FN0z1biqjOgVIOj24vsX3vp2u1GmRh0=;
 b=COwOCtmwdVZCaD8rzMMvENa7STv1Bx+brmVLuldL1clUwTFyk0qejyzZ9Z1RBWtklj8078DuchFJGXiPjntRULcnIaGe4Q65+hbHgjkqHjV/rKCF5C3+yjIwvO1IkuqaD0iXPziWlezr/cewKiGnFMJh6r+mtnfHIG1wEZ8InpQ=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BL0PR04MB6482.namprd04.prod.outlook.com (2603:10b6:208:1cf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Wed, 13 Mar
 2024 12:50:54 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5395:f1:f080:8605]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5395:f1:f080:8605%3]) with mapi id 15.20.7362.035; Wed, 13 Mar 2024
 12:50:54 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Mikko Rapeli <mikko.rapeli@linaro.org>, Jens Wiklander
	<jens.wiklander@linaro.org>, Tomas Klas <tomas.klas@cuesystem.com>
CC: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Daniil
 Lunev <dlunev@google.com>, Asutosh Das <quic_asutoshd@quicinc.com>
Subject: RE: [PATCH v4] mmc: core: Use mrq.sbc in close-ended ffu
Thread-Topic: [PATCH v4] mmc: core: Use mrq.sbc in close-ended ffu
Thread-Index:
 AQHaIqYJKMqPT88MNEGwL4Aqch6aJrCSrMQAgKCGvICAAAmnIIAACXAAgAADQACAAAX9AIAANoOwgADbOwCAAdFfAIAAD6rg
Date: Wed, 13 Mar 2024 12:50:54 +0000
Message-ID:
 <DM6PR04MB65752BDA26BA746F9A6B5063FC2A2@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20231129092535.3278-1-avri.altman@wdc.com>
 <CAPDyKFqsyp=isawJKH0Q7Qqxqtkx=gmPZru9NnK-ndV20VRmFA@mail.gmail.com>
 <Ze8OXcCA_BCN2MVE@nuoska>
 <DM6PR04MB65751092AB94DDC87FE9505EFC242@DM6PR04MB6575.namprd04.prod.outlook.com>
 <Ze8eYFW4yZKcWxdo@nuoska>
 <CAHUa44Eptk+Mvf+vWReCACq6DLCSry0wT2U4aewq==4Q2Z1HCA@mail.gmail.com>
 <Ze8mICZ_22mV4jGQ@nuoska>
 <DM6PR04MB657544B8D60209776E674156FC242@DM6PR04MB6575.namprd04.prod.outlook.com>
 <CAHUa44E9qgFrdORQ4zdnHdqb1Dpo8ODk1ioquXNe8tJA86fWrA@mail.gmail.com>
 <ZfGSJBuBdzkoooYs@nuoska>
In-Reply-To: <ZfGSJBuBdzkoooYs@nuoska>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|BL0PR04MB6482:EE_
x-ms-office365-filtering-correlation-id: d605e323-d300-45b8-3702-08dc435c3899
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 QtCu4GPhn9IaFjdo98Wx38m3Wx65phuKSgUxON40iTNtGfA1mMGWXMclFeM5CxpqaeXCwMVjWB3YK8aXgthwt1oRhOCOW3w5O+lehZQXBuLdti0RISzb8cnAleaVoQh+to7TM8X1KmUIi02iHld8UFSMLsrTqswX9TIl4vsFVzWLG0vRna2JuCKQzYP4a/q+h3PDxbH2NHm4w87rl5Hz126Xgcbx5FlDtCDRlffh3575LrWVh+ykcV56fmEsTbTD7i5X5/MeC7gQC/WLnDsnvqgM+ObSZtIVB4FUpfFG60cgcX4d37g0KufrCIAuOJyX6OL38mQhVLo7WOv6fwjnlt9k/vOgzM9g5h05pN/8GuT1amQAqz4JE7+KNABV5fTS5jQdI5sc7wa/P4KOb/H2f3AnlRhjlIXKZWODE0X7LkbrpuCJw1tmMnAzRp5FBLrQt4akrjGvbj2l8hDvo44HOSCOUZjqkb4fALfbg8tRLRarTwrceachpLfQGJjYM5d1Snu6KNXJJgylqp36aI6oiEsRbcvPUFpSeRsxmBsyvAEKbEAhy4grn8TAiNGhNv138WOCg1BLdSV2uGuHhnhonqFHiffODzc9HnhHckre0T0Nb8Ae7y/aUj5302Z7PqM/q4fZhmi0VnLMfApjaDeOAAkkoGA3S3c1sBuIZqtZX9I=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?KB2+48U4tT1lXCDY948pD+0rBYaqzoC9bxbhTCzxvqvD/slb7xIGB5CS9l7+?=
 =?us-ascii?Q?+OtdEXNM9GbD6D557QEt5roeiDlpfWVo+YTwm4wXnmvyY9E6acWbdJNvbFpt?=
 =?us-ascii?Q?KQuUXvczmkT3CafxagJ4667HpfmZVt3GaW5brMPiMJsk1wjITwOqFL3S66yy?=
 =?us-ascii?Q?NpIgNkpgcibkUJeTL0jEkDL3ST1+8q1rD0WF3SNPjdQ9QEYQ1BZ9Dl8yqBRw?=
 =?us-ascii?Q?8qUosg8fm5q2fS+D4T6bWgoA71QsDWhMo+rnjbHQ06NknHEIxRvJYBKlydYx?=
 =?us-ascii?Q?UA1IWqVhytCXk8/nwS6nOlqjuMcCmGNQ4XjUDWmOeSRk72S9F56ucZpxovbt?=
 =?us-ascii?Q?ewv1cuesb207GwI3/7PPTxQDlAPQz7r80DEKxOvPibKZorf/kmAmYihWVvIm?=
 =?us-ascii?Q?kpMItStqTS3l/gHDZQZBqDrtyjSHcASfZhiCOK7UeLV44Ko+xSwojyN+1fXA?=
 =?us-ascii?Q?4E9VXXShXu5uU3YcXYdyUJLag94r31dAlZmxuA1X7n8zIi/h0qpS/cq9hQjO?=
 =?us-ascii?Q?hyT253rjO+jXjZsfmuyXpZN+L1GqN7a6GHGmlmsbFXwJL2HVKlYwyn4LAMlc?=
 =?us-ascii?Q?RQDYLyJcCgAoq2jX+s8n8Xea0QbymLoq30FgRb5Pgj6X8OalYPuxYsf1Li+D?=
 =?us-ascii?Q?LVGxQ29wbymOhsj/TCZAYeWdCP7wxhayyBQOzMFNKq68RYG6tcU5XieuZgMA?=
 =?us-ascii?Q?0/iRabzGygULaT4n0htNkATMuFBHn95HjjaNZ8NfwMTHyixsyCwo0WXFxCJO?=
 =?us-ascii?Q?jdp5KhRbtBZcSDIPO9GRqCs9cR9NA6oXqnWtuKIhG4pY86uWOuk+ElLIfHhW?=
 =?us-ascii?Q?gyUPKCRdCHVKNfyLWd322La8GWii8n1e/dNHW80RbChFCTzzm6aA4EZH8oQa?=
 =?us-ascii?Q?Hla5wTcNJnM504ta47y0lL60zAGfQPrciqXXBGpIGg5slPilSWOaqlp7lOYc?=
 =?us-ascii?Q?CUNcb5YANsXodgK09weNoyXx4R3Y4LD5EPsQnV8PBX3mpvyvx3nfI+2BKfxJ?=
 =?us-ascii?Q?i5WwBQAVgGMLaUZ8Fl09o8UrQnmIpKVVKHBa6U/D7JpnIcyJ4ApEJKDS9xiM?=
 =?us-ascii?Q?z46AL+vwBFUNjSdRFw5yDZ+gUDCdxlsLcPmvTWjpwcGHmMU0znEvUHAn6RWB?=
 =?us-ascii?Q?U36adgx9YdIkLaOaqoX1ooOx4T9FsFtC0MznbNnOaCVDqsUavgEZd6GsBeII?=
 =?us-ascii?Q?gKlGMQzmYVpMbqLZ39hRDOj73DzKxa3PBaSunzsPMlHzyqgXFkWix+7kOTEw?=
 =?us-ascii?Q?SX+tKUymQIdPZor3GHxoC0uK4SxzO1G9QpnVq3B7j4mmvPryBAg+4lO6yKK1?=
 =?us-ascii?Q?xqvKtNuF/l8bdNbMez2neodxn9fXeNZLTcqXagBZbI4c9fR/Ejq0lbYXuKqW?=
 =?us-ascii?Q?g1O5Yz01v4LLuidTYjoqKih3AeOFyyunmallcwq5arIExeTHRi06/eSL/tE/?=
 =?us-ascii?Q?zw56j8Xdo2K6NVpGgNSIjxdTxGn6M4dO/PcU6wuiSyxXRE7ocLqwosyc+ub/?=
 =?us-ascii?Q?pHXs52DsDAv96FDDIif7yvuVuP4/YeBshOfSkKSQWS+Xy37Fvy9ddP+CQDqp?=
 =?us-ascii?Q?T9wYbrHrkQSW1WfyP3COKTASvU+C8h6p/P9zR0w3?=
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
	eYm194ix7VbHsIWwUSr3q9X23RgwDIO0tE8SOPP5NM2jmUluDVZCGrV86l3R2RFiVCSNxrm+s6CwktATsneZhSQL54WO5JQ+z4fq07G1aOgHB9MBXwgVYAVeh71gqBvCeCvjnk3uNWRDLIYgPI5uIPAG/6WCGQQCLg2SHGbdX6cUgN7PzgKaL35gFPRVbvcciuW6B5uT2z+7458ByUpLpM/YGiBiWDZCBE5MgZnNsfc9yLE4OSzzR9+BhNeOJ2hZCmIXpBZbhpFn4qF+ASTWzCCvKn/zYPLOZfO8rblKldiMoHfFSlILocsv5VXvXTHGF6fJYd6wJz6pdXND+RVyISfhpNiRGZqOhwI26vFo9oS314Lz7RT4FO6xaa/7Vm8Z9hDGVyF2XxQjAV8FWREsfjeQd1RWBI1QFOYfwos80/jH1KuxWQTAu0SGq224NXzErY/rZOhZIGYOy77doYjnOHxF6QoMaceYjGVfr5Wv/ismW7ecIolWSEDq7XrihVIpTc2uH52kaKbab3JZC29BF8mFx3rItamosWqdp5eXBj3nA8P91zDxkjzAO/FU/E3AJxZF674gkye9oC7LCj0Q2U7pmGPbx3cX5Aq4WxU1JWKRDOdRPmm073E7AfXoD2+R
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d605e323-d300-45b8-3702-08dc435c3899
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2024 12:50:54.5166
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sWEwjnLN1vQqJGlMZIvV0jA7L8MIgnbWiplhSXzHYttZ3GWsfNNvo/NmnqtzDR5X9DgPZplL72bI2G1DZo+RFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB6482

+ Tomas
=20
>=20
> Hi,
>=20
> With help from Jens we turned tee-opplicant in userspace to single thread=
ed
> with:
>=20
> --- a/tee-supplicant/src/tee_supplicant.c
> +++ b/tee-supplicant/src/tee_supplicant.c
> @@ -588,6 +588,8 @@ static bool spawn_thread(struct thread_arg *arg)
>         int e =3D 0;
>         pthread_t tid;
>=20
> +       return true;
> +
>         memset(&tid, 0, sizeof(tid));
>=20
>         DMSG("Spawning a new thread");
>=20
>=20
> but RPMB access still fails, so issue is not in userspace concurrency.
> I added debug prints to this commit and the failures seem to come from th=
is
> first check idata->flags & MMC_BLK_IOC_DROP, second hunk in this patch:
>=20
> @@ -475,10 +479,18 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card
> *card, struct mmc_blk_data *md,
>         unsigned int busy_timeout_ms;
>         int err;
>         unsigned int target_part;
> +       struct mmc_blk_ioc_data *idata =3D idatas[i];
> +       struct mmc_blk_ioc_data *prev_idata =3D NULL;
>=20
>         if (!card || !md || !idata)
>                 return -EINVAL;
>=20
> +       if (idata->flags & MMC_BLK_IOC_DROP)
> +               return 0;
> +
> +       if (idata->flags & MMC_BLK_IOC_SBC)
> +               prev_idata =3D idatas[i - 1];
> +
>         /*
>          * The RPMB accesses comes in from the character device, so we
>          * need to target these explicitly. Else we just target the
>=20
>=20
> Debug prints:
>=20
> @@ -485,11 +485,19 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card
> *card, struct mmc_blk_data *md,
>         if (!card || !md || !idata)
>                 return -EINVAL;
>=20
> -       if (idata->flags & MMC_BLK_IOC_DROP)
> +       pr_err("%s: DEBUG0:\n", __func__ );
> +
> +       if (idata->flags & MMC_BLK_IOC_DROP) {
> +               pr_err("%s: DEBUG1: idata->flags & MMC_BLK_IOC_DROP: flag=
s =3D
> 0x%x, returning 0\n",
> +                                                       __func__,
> + idata->flags );
>                 return 0;
> +       }
>=20
> -       if (idata->flags & MMC_BLK_IOC_SBC)
> +       if (idata->flags & MMC_BLK_IOC_SBC && i > 0) {
> +               pr_err("%s: DEBUG2: idata->flags & MMC_BLK_IOC_SBC && i >=
 0,
> flags =3D 0x%x\n",
> +                                                       __func__,
> + idata->flags);
>                 prev_idata =3D idatas[i - 1];
> +       }
>=20
>         /*
>          * The RPMB accesses comes in from the character device, so we
>=20
> And the logs show that "idata->flags & MMC_BLK_IOC_DROP" is always true
> for the RPMB ioctls.
>=20
> https://ledge.validation.linaro.org/scheduler/job/83101
>=20
> [   33.505035] __mmc_blk_ioctl_cmd: DEBUG0:
> [   33.505426] __mmc_blk_ioctl_cmd: DEBUG1: idata->flags &
> MMC_BLK_IOC_DROP: flags =3D 0x5f797469, returning 0
The flags contains garbage - needs to be initialized to zero.
Tomas already noticed that and is about to send a fix.

Thanks,
Avri




> [   33.506283] __mmc_blk_ioctl_cmd: DEBUG0:
> [   33.506639] __mmc_blk_ioctl_cmd: DEBUG2: idata->flags &
> MMC_BLK_IOC_SBC && i > 0, flags =3D 0x702e796e
> [   33.507447] __mmc_blk_ioctl_cmd: DEBUG2.1: RPMB
> [   33.511746] __mmc_blk_ioctl_cmd: DEBUG3: copying to prev_idata
> [   43.564084] mmc0: Card stuck being busy! __mmc_poll_for_busy
>=20
> https://ledge.validation.linaro.org/scheduler/job/83102
>=20
> [  143.124673] __mmc_blk_ioctl_cmd: DEBUG2: idata->flags &
> MMC_BLK_IOC_SBC && i > 0, flags =3D 0x485fb78a [  143.133854]
> __mmc_blk_ioctl_cmd: DEBUG2.1: RPMB [  143.138886]
> __mmc_blk_ioctl_cmd: DEBUG3: copying to prev_idata ...
> [  153.166684] mmc0: Card stuck being busy! __mmc_poll_for_busy
>=20
> This commit added uint flags to mmc_blk_ioc_data struct but it is only
> initialized for MMC_DRV_OP_IOCTL code path and for
> MMC_DRV_OP_IOCTL_RPMB it is uninialized and happens to be matching "&
> MMC_BLK_IOC_DROP" in all cases at runtime thus breaking RPMB ioctls.
>=20
> Fix will be to initialize mmc_blk_ioc_data->flags in all cases. Would thi=
s be fine
> as a catch all initialization for mmc_blk_ioc_data?
>=20
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -413,7 +413,7 @@ static struct mmc_blk_ioc_data
> *mmc_blk_ioctl_copy_from_user(
>         struct mmc_blk_ioc_data *idata;
>         int err;
>=20
> -       idata =3D kmalloc(sizeof(*idata), GFP_KERNEL);
> +       idata =3D kzalloc(sizeof(*idata), GFP_KERNEL);
>         if (!idata) {
>                 err =3D -ENOMEM;
>                 goto out;
>=20
> I think this is a sensible and future proof way to go.
>=20
> Then, the second flags check for MMC_BLK_IOC_SBC is accessing array using
> index i - 1, but is not checking if i =3D=3D 0 which results in data[-1] =
access.
> I think this should be fixed with something like:
>=20
> -       if (idata->flags & MMC_BLK_IOC_SBC)
> +       if (idata->flags & MMC_BLK_IOC_SBC && i > 0) {
>=20
> Would you be fine with this?
>=20
> With both of these changes in place (and debug logging) test runs on rock=
pi4b
> and synquacer
> arm64 boards are now ok and firmware TPM devices with RPMB storage works
> again and optee fTPM TA does not panic, though there is at least on TPM
> eventlog read test failing later on (a different kernel or firmware bug, =
perhaps).
>=20
> https://ledge.validation.linaro.org/scheduler/job/83094
>=20
> + tee-supplicant -d --rpmb-cid 7001004d33323530385212b201dea300 sleep 10
> + modprobe tpm_ftpm_tee
> ...
> + tpm2_createprimary -Q --hierarchy=3Do --key-context=3Dprim.ctx
> ...
> + tpm2_loadexternal --key-algorithm=3Drsa --hierarchy=3Do
> + --public=3Dsigning_key_public.pem --key-context=3Dsigning_key.ctx
> + --name=3Dsigning_key.name tpm2_startauthsession --session=3Dsession.ctx
> + tpm2_policyauthorize --session=3Dsession.ctx --policy=3Dauthorized.poli=
cy
> + --name=3Dsigning_key.name tpm2_flushcontext session.ctx cat
> + /tmp/rand_key tpm2_create --hash-algorithm=3Dsha256
> + --public=3Dauth_pcr_seal_key.pub --private=3Dauth_pcr_seal_key.priv
> + --sealing-input=3D- --parent-context=3Dprim.ctx --policy=3Dauthorized.p=
olicy
> ...
> + tpm2_load -Q --parent-context=3Dprim.ctx --public=3Dauth_pcr_seal_key.p=
ub
> + --private=3Dauth_pcr_seal_key.priv --name=3Dseal.name
> + --key-context=3Dseal.ctx tpm2_evictcontrol -Q -C o -c 0x8100000a
> ...
> + cryptsetup -q --type luks2 --cipher aes-xts-plain --hash sha256
> + --use-random --uuid=3D6091b3a4-ce08-3020-93a6-f755a22ef03b luksFormat
> /dev/sda2 --key-file /tmp/rand_key --label otaroot echo 'Creating encrypt=
ed
> filesystem ...'
> Creating encrypted filesystem ...
> + cryptsetup luksOpen --key-file /tmp/rand_key /dev/sda2 rootfs
> ...
>=20
> https://ledge.validation.linaro.org/scheduler/job/83096
>=20
> + modprobe tpm_ftpm_tee
> ...
> + rngd
> ...
> + tpm2_dictionarylockout -c
> + tpm2-abrmd --allow-root
> ...
> + tpm2_seal_password /tmp/rand_key
> + local passfilename=3D/tmp/rand_key
> ...
> + tpm2_createprimary -Q --hierarchy=3Do --key-context=3Dprim.ctx
> ...
> + tpm2_loadexternal --key-algorithm=3Drsa --hierarchy=3Do
> + --public=3Dsigning_key_public.pem --key-context=3Dsigning_key.ctx
> + --name=3Dsigning_key.name tpm2_startauthsession --session=3Dsession.ctx
> + tpm2_policyauthorize --session=3Dsession.ctx --policy=3Dauthorized.poli=
cy
> + --name=3Dsigning_key.name tpm2_flushcontext session.ctx
> ...
> + tpm2_create --hash-algorithm=3Dsha256 --public=3Dauth_pcr_seal_key.pub
> + --private=3Dauth_pcr_seal_key.priv --sealing-input=3D-
> + --parent-context=3Dprim.ctx --policy=3Dauthorized.policy
> ...
> + tpm2_load -Q --parent-context=3Dprim.ctx --public=3Dauth_pcr_seal_key.p=
ub
> + --private=3Dauth_pcr_seal_key.priv --name=3Dseal.name
> + --key-context=3Dseal.ctx tpm2_evictcontrol -Q -C o -c 0x8100000a
> + tpm2_evictcontrol --hierarchy=3Do --object-context=3Dseal.ctx 0x8100000=
a
> ...
> + cryptsetup -q --type luks2 --cipher aes-xts-plain --hash sha256
> + --use-random --uuid=3D6091b3a4-ce08-3020-93a6-f755a22ef03b luksFormat
> + /dev/mmcblk1p7 --key-file /tmp/rand_key --label otaroot
> ...
> Creating encrypted filesystem ...
> + cryptsetup luksOpen --key-file /tmp/rand_key /dev/mmcblk1p7 rootfs
> ...
> + mount /dev/mapper/rootfs /rootfs -o rw,noatime,iversion
> [  171.018740] EXT4-fs (dm-0): mounted filesystem 89ae0ee0-b27c-4a66-ac0c=
-
> 098c7ccd7a3c r/w with ordered data mode. Quota mode: disabled.
> ...
>=20
> Cheers,
>=20
> -Mikko
