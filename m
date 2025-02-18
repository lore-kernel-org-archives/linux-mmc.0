Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2077.outbound.protection.outlook.com [40.107.22.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B2A28373;
	Tue, 18 Feb 2025 03:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739848176; cv=fail; b=XpCQ8fgfxXJeBogyj4kTSoxiQ33uIaBIQlrUSpKIfBgzlnH8gKu7YvD8SFRSdtafHWJJ/rpK4f30a42Q/tidgxZYwOYur1hyt4FKYhWUGkbKOeqzUyuj9Ag2ArvNT8mo6j34fkvzc41lSO4DDXLhiBP0rvB4UHPNM6uU9uof23c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739848176; c=relaxed/simple;
	bh=D8eCZ85JD+fFIMYfgN+Q+sHgl6SzSFf0GEoXdNTk5LU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oT/RUwukxFTnEVhj+GHyYArj2VIouvauSxKr/xPkXSLF2by6TMs90nRIMOIO2vuBX/eqh2lkH1zCGjLFypY489uEeUOb8IAMlo8umh5QCFN9Lu9oH6ILdpcfyCncS0QfBGm+bpTy9GGKYxbcE9yFEZSVA73rGMYJNMJSQH5OgGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ne/r+ft/; arc=fail smtp.client-ip=40.107.22.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ne/r+ft/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D51lUD24dsVgMTndI4eY3iddJGHOktwBie2FdkYl/PFhyBsKC8i6dufiWx5u0z2R9E5bjK9O8Wo6jrRs5OZcAyj8Zace9hybEvVgK/Ox0/LuP3rQAqlzL9VIeIkMuJ2xu6yLwZk9AGyfwcBZym49b16UaIhWXtJGS6HE102e63MVNAwMs9p6Z4Z06DFnB6PXLROkc/HvYZHInN6LyGsPT+mZMJOhIT4fNnVgshVMs24eCnw1ifHm7nCCTl0sWJ85qex7Bnkzme8RwO2qAd/huTS4xdxKzVkmWISlVefg9RQ7ayDl0wC8WHEumgtkkLUSdjKTu4Ba5HfJ6643EIQeHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZrG5+BNdkA0U31+RHNFfET6BNnf3SWfTtqd0bUh/PdU=;
 b=eyYQQDXg9SLn9d0sC4XehkvKBusBmiMu4t+hiVVVYozxABAknDxZWssbRnaqrt+9+3Eka348HueoP/wQ/23wDlWE6prC5i6SA0hdUpfCJJAhQdwoVApUZCilef78ZqlRxU8F6xcK8t5si6SXJr5eoLwET/x9jI9F9UKk7nXG44BUrOMxRzLGaSBbg5frEwzGawzMCNlicoMi8dc7zHN2Xv7CueBzdoLRTwDonmQHdjRJmyTmecEHlQ6lUpyzLOrQRBCajiX2pgn9+jEROnskFgD7WdDpIs367wVH6EgZaVKk5NtBz7w9AmvPHM+j1bKcRxR1cWC9HXzR1inSlD279g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZrG5+BNdkA0U31+RHNFfET6BNnf3SWfTtqd0bUh/PdU=;
 b=Ne/r+ft/kV7S7ZuvD21piVtHhmkKOKsVkTERQMskpfjsBtoQE+K3iv6if5TsfqK4nfvYonL4HA6fgOFyWuqg4te427tJofdFvMw44mL+ErS/m3qaGa5thWOHMioq/FRGLEqUNyi11b6PrQiL/50nqBVUG+YDTYqC0JN3Y12x19mh4vgJsJOL/PMvPegJiRd/5wmb3yBw3WNkFY7axw/iohtrKxZeib9BgC+hig6Wfs5//O/BD2T9fq8Sq1zHwV8X7ZtNIq73af/7BKD7/4CLpvIXiyPHFUEmI869yNCxRF8/ZhVexQp+1GMJOfUCMuUbdI90vNOTIKhgWCMkGdrUCA==
Received: from PAXPR04MB8574.eurprd04.prod.outlook.com (2603:10a6:102:215::19)
 by PAWPR04MB9886.eurprd04.prod.outlook.com (2603:10a6:102:37f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 03:09:30 +0000
Received: from PAXPR04MB8574.eurprd04.prod.outlook.com
 ([fe80::60b6:6a5c:8db3:cce]) by PAXPR04MB8574.eurprd04.prod.outlook.com
 ([fe80::60b6:6a5c:8db3:cce%7]) with mapi id 15.20.8445.016; Tue, 18 Feb 2025
 03:09:29 +0000
From: Luke Wang <ziniu.wang_1@nxp.com>
To: Lucas Stach <l.stach@pengutronix.de>, "adrian.hunter@intel.com"
	<adrian.hunter@intel.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, dl-S32 <S32@nxp.com>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Bough Chen <haibo.chen@nxp.com>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH] mmc: sdhci-esdhc-imx: improve imx8mq emmc/sd
 read performance
Thread-Topic: [EXT] Re: [PATCH] mmc: sdhci-esdhc-imx: improve imx8mq emmc/sd
 read performance
Thread-Index: AQHbgSvb927wsXLJUU+dye4KFFlE/LNLZAuAgAD7qiA=
Date: Tue, 18 Feb 2025 03:09:29 +0000
Message-ID:
 <PAXPR04MB8574A715E7BEBB67F3B1EEACEDFA2@PAXPR04MB8574.eurprd04.prod.outlook.com>
References: <20250217110623.2383142-1-ziniu.wang_1@nxp.com>
 <ab721b4a96495516f5149e91f3e4764014e39ba6.camel@pengutronix.de>
In-Reply-To: <ab721b4a96495516f5149e91f3e4764014e39ba6.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8574:EE_|PAWPR04MB9886:EE_
x-ms-office365-filtering-correlation-id: f363a06d-5661-4886-9982-08dd4fc9a908
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?UbWMBx3KtLYwQQwQw5IGP4WYlkjUwpWXlEor90l0/rfoRxnoNkcPjZQ3ztez?=
 =?us-ascii?Q?g4pk22sjWBpLxcJs5MfZUd8AW2kn4Wvz1j2g13gd+OD6U0QH02Xx2AUKGXaP?=
 =?us-ascii?Q?lrmhK3WNU1hCoUCtGIXktr8q1iPsI6nbGrAXgEc8DMly4DIu1fF5O/HFTa3/?=
 =?us-ascii?Q?HQ9nCQIHbcc4TvlkerGNCsX2WUXo68p9nz+1Obx0uHrkqWY8vu8yh57f2rg5?=
 =?us-ascii?Q?m/vcFBEvSt6ePP6cZ2BIBEWW/TuYWIARos9cN3Ax5LV2IytSHkmnmVy9ECwj?=
 =?us-ascii?Q?2yR4mKwNaf6KbfuMn8l1JoONUx+xZOoO2DcrGVYu4QES8H4ceznsA+R2r1gj?=
 =?us-ascii?Q?FFR2PDbPOUWwoFev6xSW8o8vQ1M0JzUBy2fYDuX9+qSgSVvOZ/ngwrzsWJo7?=
 =?us-ascii?Q?R/Jo2JxRvgKcJufK1aksHoOTBkvOIliFD2iY+n/TSX+pHJHQZm/x/mmTJUGb?=
 =?us-ascii?Q?94ojN1kcvTIm/QjK0hO3j9giwPIdJTZ7Mcd8xnMYtYhgXIK1z9XydcUTBiEl?=
 =?us-ascii?Q?rBuLGGNiNn5jcyz8lAkDwA5HsNIkSshrxha13mB8DWFzU+OWcrDHU5C73G7b?=
 =?us-ascii?Q?GKRu3WqV7CNuzsdetSOabE0lW1Y9JfYoWLpDd0ilsDY7QsrRdPr0MISvklHl?=
 =?us-ascii?Q?AsMHxwSqN997+HZwGfAa6zyxremj6cRrBGF00el/y3rYmogxf9oW0zZTsFw6?=
 =?us-ascii?Q?5xGdm10C2BkFJJGCX4hu3MC9b2UEB1kh8pFjNgmu6/wv/coB7IJutPi1mVLb?=
 =?us-ascii?Q?lnDBGigwrMhAsdMKBJbkq9vvq5wJ7hqLc8amSxb/zuwl+f2Hw0/zJTSRhVpu?=
 =?us-ascii?Q?Cf38yBbjwj3aaMEiQSdGFf0DY/D717MfdPPfeCWFfIbEqODRrxj8eo80yRmX?=
 =?us-ascii?Q?TJzNP/5BeTtuUn1zJDUBSwwBKiOYhn+YewTX1lq4Yh6oHp+WiWKu8SGNvR4U?=
 =?us-ascii?Q?vbLufqSvWMtqvNRH3ZkSf2bfD995iPDIeosB0zVXMe5K+IYmLfwiR3Fu9R4F?=
 =?us-ascii?Q?cMxesrYkUwbt7KgLFWWTjEg785noTMNnrIz697YEMgGOPlRo3wNfJmyeQ4oo?=
 =?us-ascii?Q?SoWjtdvl8pTgs89HxtYAbFpdXzuTdj3phCh9D8JQnhWJVpmHmcW1V7Ops+tl?=
 =?us-ascii?Q?AgpR9pXjni4LpQx6Fx/FA3DvzW6yvtb+cGQW9nlzqcFkWzxCOHTutMk2aipt?=
 =?us-ascii?Q?oUouidTBEQ8z9Wrb12gyDkITO8QoFCSk3L5tlmTSgMSurBupWmbM8OrpjfNm?=
 =?us-ascii?Q?DMePtyncMcWerP36b3vy3l5iePgMZUNNBfYGt4O0f+L+WpwITfpzlDVgDdPe?=
 =?us-ascii?Q?x4RtpHtOYg8LEnJhopOCXvYNhBCgJDUtlnpdXwcol7lBqQYVpRQIEz3Bm0YP?=
 =?us-ascii?Q?3m/mSa9LjndYXCn41jl12l3xTBe3obYkPe7WKbxj8ZaXRVcI5KdTZ+5tHL7w?=
 =?us-ascii?Q?7QstvuzfAhc5uVr7AIzOfcD462LIYE5W?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8574.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ECy/84fN4vFwHCk0I7JZtQKzojCcNeUXsYMw8EYwQiRvxr7RjQ/80FzmRKsy?=
 =?us-ascii?Q?6RLjvGKv9ItortDBsWQTFCsfcem2z3Y0SbH4MiZGiWhEvbGX6wD/slqmyOjv?=
 =?us-ascii?Q?C10fiR2pgBRLUmASsTGhAzybyMLv4tcPt9ViTXG6qhF+y0z+oGQtKBVsJwfW?=
 =?us-ascii?Q?F+zNuWsY91hodPsvIyFthoM/F5irtZ5k1LH9UdbxJE7EFA59LLBqq7IDlXsp?=
 =?us-ascii?Q?0bsbu2PJfFPzVhgkZ05oxuGxSDBPa3zYdGPFQ7kyNksUvClJr3r7503up6Yn?=
 =?us-ascii?Q?1fInLFO2Z2dIWgDbTyHk4oR7ovKckPql+8YTEOQ2ExUa+VrlG5PrvZsLJZwI?=
 =?us-ascii?Q?YSeVz8GYZutxhqdAVX1Ea7gIlISTR4sfYQOswGosivL7vzmcOOrVGZxPU9cO?=
 =?us-ascii?Q?DmfoZfVq7sxJE7LEeCW5uQUd4dTto5jSrlItvGopTzUXVnpajv5u1ENHUJvN?=
 =?us-ascii?Q?PxYOlvVJrJITP2g88brwc4zips5I5WNUVqNrvLD3oy9kIjl5gv45CWa6fHJF?=
 =?us-ascii?Q?41phjEYqX8c7b2OcyREYUr0uKj7AkM0GwG9zhxhYbj9LItDoxMJ8h8Vey54N?=
 =?us-ascii?Q?8irjgMKJ7449jIHnu+3EXDFbkv4HeAZ4pnwwGnxqUGj4QWsNItNnTnCHSj/a?=
 =?us-ascii?Q?JLZE++5y4GWckq1IPSTeb2J1dZz2g8hB3F7YVWuB8KQfAXBxOnZV/lpaiC8/?=
 =?us-ascii?Q?OQnbgyWotSBFWN833atGTLOrDvrLzRms4nJOqInREZqIS1bQlBRTIcMUWxR7?=
 =?us-ascii?Q?xIFNYv8hYl14VAzXGktewYhKhwRbYReAfHBcYF5meVEV5yNMzAInerwHHuPr?=
 =?us-ascii?Q?p9vEaIRTVKY0rL7E+eUao9JXCAIGWFXXEk+lEgGMJs/3+6OjmMggHDZLU08I?=
 =?us-ascii?Q?5QCmefkARFWPOT7VGHunam2xzA2riOgHIfJEGLUaY1klTqVhvxw1QLcarm1S?=
 =?us-ascii?Q?ohpJ6CjKS1hr75JXUz+1WCfTaYh/8++82l9eSc1VDGU6GfuOFsvtzoeq6Ggj?=
 =?us-ascii?Q?4G8Sd+UWykoYlKbbkI3lcJu6IEogvOVD6cIEWWKcsUYxe4Oc9jwjit42duj8?=
 =?us-ascii?Q?nI9Qo4447FM+yp/Kvq+xZx1OXt0FHIGfdO08vY0e+AJMzaygrzUxud7WJgIm?=
 =?us-ascii?Q?c0pvUYObIhYvezEcDO4/QV/gW2z7IpUs2lOClv4GYtkumROQw7p6akzEfhsG?=
 =?us-ascii?Q?zqawP4i1IPyUKvUKEeQQxOn0p3g5l4vgCZLJ/MBfj3U6WtiGwv0XAhriQecI?=
 =?us-ascii?Q?23yNZGOa4Fb9HUF3dMfDTzwxfrQANj7nG97bNlFYC7SEoozb/1x82rloZ29B?=
 =?us-ascii?Q?yY8kxqNxDdVrMnEvHghRTwmi0PM6YBFwYM1vOKhxbHLxQ5p9CeDkmB7M6MZG?=
 =?us-ascii?Q?40Y138UPTvJBr0fMxkK0lpieLqdn7Qp5ndLAQG58e4vyAoT6sKvEyWO17qQp?=
 =?us-ascii?Q?5HpULKeNx7IQ51hVbSY7GFgTF+BZ6zUKMiFW76LZIFad+fXfSTaF/i3zZ5G/?=
 =?us-ascii?Q?9wv6luMz5FvNDXv+d9kFmohB9dAWWHzv+E5ebyRYoNIe9shE/9EGVTNF3inH?=
 =?us-ascii?Q?3kb4Vypmsxl4NjSCv8DF0hYD3dGhzyzH3WlQNhXc?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8574.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f363a06d-5661-4886-9982-08dd4fc9a908
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2025 03:09:29.9185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8B2wNHapg4q6jA0ua3ONOIz7Kt2eMtgMMZmPkeSiKge+qzVOQMVFAkG2h5wWm+DYVkaGGSeHWBOXuptEkLBzZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9886

Hi Lucas,

You are right.=20
This issue is observed on local kernel. I checked that the local kernel doe=
s use a deeper PSCI idle state (power off).
So, the upstream kernel will not be affected by this.

Thank you,
Luke

> -----Original Message-----
> From: Lucas Stach <l.stach@pengutronix.de>
> Sent: Monday, February 17, 2025 7:58 PM
> To: Luke Wang <ziniu.wang_1@nxp.com>; adrian.hunter@intel.com;
> ulf.hansson@linaro.org
> Cc: imx@lists.linux.dev; dl-S32 <S32@nxp.com>; shawnguo@kernel.org;
> s.hauer@pengutronix.de; linux-mmc@vger.kernel.org; linux-
> kernel@vger.kernel.org; Bough Chen <haibo.chen@nxp.com>;
> kernel@pengutronix.de; festevam@gmail.com; linux-arm-
> kernel@lists.infradead.org
> Subject: [EXT] Re: [PATCH] mmc: sdhci-esdhc-imx: improve imx8mq emmc/sd
> read performance
>=20
> [You don't often get email from l.stach@pengutronix.de. Learn why this is
> important at https://aka.ms/LearnAboutSenderIdentification ]
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> Hi Luke,
>=20
> Am Montag, dem 17.02.2025 um 19:06 +0800 schrieb
> ziniu.wang_1@nxp.com:
> > From: Luke Wang <ziniu.wang_1@nxp.com>
> >
> > Compared with kernel 6.1, imx8mq eMMC/SD read performance drops by
> about
> > 30% with kernel 6.6.
> >
> > The eMMC/SD read thread will be put to sleep until the hardware
> completes
> > data transfer. Normally, the read thread will be woken up immediately
> > when the data transfer is completed. However, due to a known ic bug, if
> > imx8mq is in cpuidle, it will take a long time (about 500us) to exit
> > cpuidle. As a result, the read thread cannot immediately read the next
> > data block, affecting the read performance.
> >
> Is this really a problem with the upstream kernel? i.MX8MQ upstream
> does not use the deeper PSCI idle states, but only uses WFI, so I doubt
> that upstream is affected by this issue.
>=20
> Regards,
> Lucas
>=20
> > Kernel 6.6 uses EEVDF as the new scheduler, which affects cpu schedulin=
g
> > and cpuidle behavior. With kernel 6.6, the cpu which the read thread
> > resides has a greater probability in cpuidle (about 80%), while with
> > kernel 6.1, the probability is only about 20-30%. For other platforms,
> > this does not have a significant impact on read performance because the
> > cpuidle exit time is very short (for example, imx93 is about 60us). But
> > for imx8mq, this results in longer waits for the thread to be woken up
> > while reading eMMC/SD, which drops performance.
> >
> > So for imx8mq, use the ESDHC_FLAG_PMQOS flag to request the cpu
> latency
> > QoS constraint. This can prevent entering cpuidle during data transfer.
> >
> > Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
> > ---
> >  drivers/mmc/host/sdhci-esdhc-imx.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhc=
i-
> esdhc-imx.c
> > index ff78a7c6a04c..b3bf9c171d46 100644
> > --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> > +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> > @@ -337,6 +337,15 @@ static struct esdhc_soc_data usdhc_imx8mm_data
> =3D {
> >       .quirks =3D SDHCI_QUIRK_NO_LED,
> >  };
> >
> > +static struct esdhc_soc_data usdhc_imx8mq_data =3D {
> > +     .flags =3D ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
> > +                     | ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
> > +                     | ESDHC_FLAG_HS400 | ESDHC_FLAG_PMQOS
> > +                     | ESDHC_FLAG_STATE_LOST_IN_LPMODE
> > +                     | ESDHC_FLAG_BROKEN_AUTO_CMD23,
> > +     .quirks =3D SDHCI_QUIRK_NO_LED,
> > +};
> > +
> >  struct pltfm_imx_data {
> >       u32 scratchpad;
> >       struct pinctrl *pinctrl;
> > @@ -381,6 +390,7 @@ static const struct of_device_id imx_esdhc_dt_ids[]
> =3D {
> >       { .compatible =3D "fsl,imx7ulp-usdhc", .data =3D &usdhc_imx7ulp_d=
ata, },
> >       { .compatible =3D "fsl,imx8qxp-usdhc", .data =3D &usdhc_imx8qxp_d=
ata, },
> >       { .compatible =3D "fsl,imx8mm-usdhc", .data =3D &usdhc_imx8mm_dat=
a, },
> > +     { .compatible =3D "fsl,imx8mq-usdhc", .data =3D &usdhc_imx8mq_dat=
a, },
> >       { .compatible =3D "fsl,imxrt1050-usdhc", .data =3D
> &usdhc_imxrt1050_data, },
> >       { .compatible =3D "nxp,s32g2-usdhc", .data =3D &usdhc_s32g2_data,=
 },
> >       { /* sentinel */ }

