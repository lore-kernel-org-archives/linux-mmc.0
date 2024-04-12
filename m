Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CB44D9F4
	for <linux-mmc@vger.kernel.org>; Fri, 12 Apr 2024 08:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712910018; cv=fail; b=OvvDJJ7FmwAbZnEPapiCHiOsF0/fvxto3SmvcMnO8ned0hWBDiNm9SSfHKQciVencDAme1HTjvSlhuvCfQnW4+QsuVgcs1AzoN42gmzvBTIw941nTGDsC5tPkaxs75l5se7UXuHXEUB19l8zdssRGGX6cizHVY8g8C4MZO7+5FQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712910018; c=relaxed/simple;
	bh=H3FhQNRI6hXuw0bn5LNN/h+Uokkft3eBKck0HXvrC7s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KHGTVk5FO0/Dpa0lj9MR7DrOEHqR8O1HdFGcCWGoA/sMvPQ5Rh6GEf+jf7QqhGCsY3dLjnZNcTk9+2rmbzoiq23moNGuqtTGytHQ0lJLXOnTskIkKqRAifYdHLQZRZjDelE8Kw7YATfYxXBvGl6fYxJx+l0KVWljUpkE0ALYnBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=UmPlzFhz; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=TMvRHZDY; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UmPlzFhz";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="TMvRHZDY"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1712910016; x=1744446016;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=H3FhQNRI6hXuw0bn5LNN/h+Uokkft3eBKck0HXvrC7s=;
  b=UmPlzFhzoHpkyWkYTWXYfepqGU0EC4mQSqm5hm9I+lG3Ap0PA+3JgYKM
   XEGMM8dDxGz+oZVnnKItcXzQ96k2Uf/vNkBuPzkk0UpZm8N/K/IRy7gHD
   x89OXUcLJdsRsDqWTvMqhwTYJd0CtAHmVAP2dFhncI8ITJoM/1Yc9Ztnh
   roy2W0NCb1eAkGwvG9/cPtDbHuvXwGVy5BbjtMnuR9OGDQJ/SSVmaevQB
   aIb+j5wvYjWj7BdAp4UXHpyLJVpDqULG+5h/XTatCoiH0QyEtSuMM79q9
   xxMa1sExByyqnWf/CLF0A3bq7zsLYfML+jwaKk8BaMGGE+kMM1tIrh2Wa
   g==;
X-CSE-ConnectionGUID: yDbm4UjwSpCN6zY5oFlntg==
X-CSE-MsgGUID: JjGWdAVgRnum85tPaZ0LyA==
X-IronPort-AV: E=Sophos;i="6.07,195,1708358400"; 
   d="scan'208";a="13841264"
Received: from mail-bn7nam10lp2101.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.101])
  by ob1.hgst.iphmx.com with ESMTP; 12 Apr 2024 16:20:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DSIT9OzEKAeIarzCxta+IwzSFFg4Px7uhs/KPxyZgVz/RHZzz9zAE9fv4Aq6Y25euOZxaKWdUbc0ZYOnzOYOqnot2VpxhQPBL/ChYGMoKdomywmcfe5BLHt4aymTLYmZd7SJVwSyknMMw4VewjE6R00+2+2TuXi5AXtgYW2Y9Nl6FKzyei05PKQVl6hyx4saltVxmOmyPEe/3yZ6ThVdy33/z5VRnJ1v8RJSfJxhaqUA9Gu/S+wwu38sJJfIfS50eLemV0KcCiwzeUEBUMk9Cndx0xinM2uTisxZ+pXti7TdXU/ENdJYcOrWLc9xksG9serps0SF/0Infcl5VcUoCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H3FhQNRI6hXuw0bn5LNN/h+Uokkft3eBKck0HXvrC7s=;
 b=fGmNNXWV9jl1Xg8TzJnzLOzSgOtFOL8W0q+0H6kF+qQBcuZLQe5AUxIUacv1wfUqfdM5GHK1dluTs2fw1zgEr4ib2EtOGEV461cf7N2QuSI0yY+BpWvek3Mn+bRfnkE2Kt/KO6/acuktP4o1wwJk1u0PCwjIZnNjr12fspVMIXhvg14tRAviRJ3S9aXgH3PDse61EsHWJdAA4mAFits0lEOwgd1x/zeFYkRmcERGXh/Dk5Q+YHTTraCkA3GenyMf/4wN3K8fOzmgs4xxnOtFmq030gBsfzQPi+XrywFfpES8Im9G5ZdLNKl/nCL0tdqngDzg7RHQOndnURaDx+V/Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H3FhQNRI6hXuw0bn5LNN/h+Uokkft3eBKck0HXvrC7s=;
 b=TMvRHZDYAUoUm46ZbuxK82ALcl4viGTnOLKUYAaAWcNHhJw3LGcRzW0x8RaPf5tqZOv5MjOIblH6YdvL1Eu7DgqoVlQpyVwf8a5WAGc/rvJ26zWNXmwMShnJ+ZOoVDi5Ckv0UdaxhuzuwM+9qRHytwWQobsralqYqD+guKZKy4o=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 PH7PR04MB8578.namprd04.prod.outlook.com (2603:10b6:510:2b6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 08:20:07 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5395:f1:f080:8605]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5395:f1:f080:8605%3]) with mapi id 15.20.7409.053; Fri, 12 Apr 2024
 08:20:07 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Zhan Liu <zliua@micron.com>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
CC: Ulf Hansson <ulf.hansson@linaro.org>
Subject: RE: [PATCH v1] mmc-utils: FFU Status check for device without FW
 install support
Thread-Topic: [PATCH v1] mmc-utils: FFU Status check for device without FW
 install support
Thread-Index: AdqMPChLurctsNLjQ3mNsAK+jpFOcQAc4CDQ
Date: Fri, 12 Apr 2024 08:20:07 +0000
Message-ID:
 <DM6PR04MB6575435F8A8BD143A1F6B1C2FC042@DM6PR04MB6575.namprd04.prod.outlook.com>
References:
 <BY5PR08MB6264AE3F237D7E11B9AEFBA4CA052@BY5PR08MB6264.namprd08.prod.outlook.com>
In-Reply-To:
 <BY5PR08MB6264AE3F237D7E11B9AEFBA4CA052@BY5PR08MB6264.namprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_ActionId=5f2b6dbf-ee1b-474f-87a1-17098f4fcb12;MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_ContentBits=0;MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_Enabled=true;MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_Method=Standard;MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_Name=Confidential;MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_SetDate=2024-04-11T18:13:43Z;MSIP_Label_37874100-6000-43b6-a204-2d77792600b9_SiteId=f38a5ecd-2813-4862-b11b-ac1d563c806f;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|PH7PR04MB8578:EE_
x-ms-office365-filtering-correlation-id: c5f643b3-5899-4d69-b5f1-08dc5ac95d14
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 mlaWk9Sb8WBUDFEYgrHqq0o636l6hwGCOyNBnCscty4I/dfBamugVFolEbCXtEz1R60ghS9NItKNY6wtjU1wVs0H3TmIuApGnumSvQcURk/PlOj8xeQRY9v36uIyH7OsepJA8mocs+uyK+EkncK+eKysIRh/U/fgo6CMWC2LUbmtkcylnsFNKMNkDerMFLAqFALMdA709emLIPhNyVphxNG+hnrdi5hlWYGqXnfgHoF+LoXgzywB8hMdgkzd8iL5WDb6P7JabPEvnGLTWTlICglH1Nyzma/FVrYOatJzyoxaO+r19XpLYknQWqESWXacGol8qEywwAg6cgrxKj+9kZ4rtC8OnrHgCUJpRdUP6kIpiPq3V8FGSpnqt0G9KSTsaAOktrQcqFtLK8RehlHWzw4VCi9D+4dZ1m2jq6uCl1SACEvTRoiJxPpF+bENygSSyl9PJ5FkITiPJCj4YUf2xKXNimCoqLKDfxjwHfKedruWgNTu0hvcaPBZi3fGZZQ0+mnEWcEF2IcGPafBP133BR6V/jZsQyFLAfCpLKko26YhVPNAAv7rRtrGCRkci7SLEGGtS1d+OVDMoRKa6vWiGZdWTck/GFOw2oFdSscDyCLffsVA6Q4fxg87fSi/ZB+02LhzJHJCrbeocYq/+EYUa5w4H/za6+0CQ9GAoJaTYAl2dp211uTK1ad1IqBAktU+pmWpuvVNIwsuRJBy1vR+MCMsI91X8OR8k13CUHc/0p0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?C9OOnxs9cH++VDD7k3QUS0J62ZoV2kbqlfdh63YeHCFQly/ZjwqRIxBNlw?=
 =?iso-8859-1?Q?Q4KF8OphCZkXcdEY7Dn5/YfPfSCTVSuAEFXx6yW/VQDGs/YvN5eovvbyB1?=
 =?iso-8859-1?Q?MBpqjkY7rcRxU0XMe89IXZTp6d0EKzEp+gm4QBrNQlpqy4sY2U3FbaxPQc?=
 =?iso-8859-1?Q?MchtrKKNi3U0kKRMtgty7f+KAqi8+E+Jg0UpI2ljuqlRTm/acKdkOsqyHl?=
 =?iso-8859-1?Q?h+YWAyFcXsErYcS++4TE73NLJhBwKaEmk33wQ5gp4Pi9hzoEbRz7uSHnN9?=
 =?iso-8859-1?Q?TQXSLEiahmq0tPXD2Vmh0v1Adg3C2ujbjyudiOOPHQOmSuEi1Tea+cpsZL?=
 =?iso-8859-1?Q?Egvgx403bqZ5xCX98g8HcrB7TgADL4drMvVX03OizVxkMNWNjkvR4uTNa+?=
 =?iso-8859-1?Q?X9bkxxD3rOLbYQ1QQvYj+XyUK85mXXQ2O4cgxY0kje01f3G8Jl2goBMeLF?=
 =?iso-8859-1?Q?o67itwofO4swQKYltEM2ECq0zkNL2arTt/Ylh3mchXUeuVvC2gNczKylO8?=
 =?iso-8859-1?Q?kjU33SrBzPhDX5utquKFgZLNfdcsTfT7o6lWdSxeEPPQCoj6vryNUEb8pJ?=
 =?iso-8859-1?Q?BLHkWLJu075qO76xGNouDzK4raHeL7KoM7teMrN6gGY/fy+IcJsCw7vvP6?=
 =?iso-8859-1?Q?iGDtOAajg3jU1JjwzBuzmUUALhvVA59JKiNbQqzBE+gEXaUsjXWL4mhZwl?=
 =?iso-8859-1?Q?TnU8Rj/K739Vd/SHcLBw4NGxfYixFRNtxQhFxxn0VEcRVseZpadYDdCaZz?=
 =?iso-8859-1?Q?zufvr8Nd6gcgST6VQOd5+TltvSDqtBBPDEWtCcBpB+0q06QcMiDfJp71bz?=
 =?iso-8859-1?Q?s2oFUA18h+5cE2/UZcSF0JLCqmAWujr68+yXwiViTE72vQgyNAoA+wULv/?=
 =?iso-8859-1?Q?1G+bLm9L+yfj5UqbgHxyGtJOQ3ybJLIw1XZP/98mfo/qAbqM+TUnhjFJLA?=
 =?iso-8859-1?Q?HUYTs7TliL2lG7SJyA8fVI7zR2cUQbbH1e+UXPIv/TtTGV1cKh96vBgyp3?=
 =?iso-8859-1?Q?yo/gUUkZZwbGNue5vzFD0njXZe2M+ja/fHhYvYlRJapSGQD8i06I4XuZve?=
 =?iso-8859-1?Q?Jx+ExgbRkKZ5ytHt3FBiPcQcXQDBM/JiAczEAb4HkW4CgN5mwZcZZ+5qBw?=
 =?iso-8859-1?Q?8T1WnVLdc6MGXRzVVEgckdn/79w+E2q1Y+LEiCBJLWmUdjixBQpsIFJEqB?=
 =?iso-8859-1?Q?hLw/h1J4RK7DWY0C3SVp+8VhRurNdxA0VwtRZ3fAj8HzbWhx9gE+kLMH3K?=
 =?iso-8859-1?Q?mNb+rSv/MIIdYLqtS+B4eaAlq8Eo4AAyzfgltjGoyR0s7K7BvcCdznh/Lm?=
 =?iso-8859-1?Q?aK/HqE+c85V/VY5cSx9lz/+RrwuwSwCNc1gJOQSCKqsqTqGtzdbCO+rGmH?=
 =?iso-8859-1?Q?vQIrrVBpAdgQYh2zDoAdA2fB5tbQUNglOMxqlc2S6nAI2JJ+2eYk8dmKhG?=
 =?iso-8859-1?Q?x64kvdndJoBVI5FnSa2TGH8QiWW71vcKNAnPObCKLYiqrzupC0dol8gbDW?=
 =?iso-8859-1?Q?RvY0/cXZCGUMu+Qm8lVpu1XaH2auvmPH8r/uAcjiHiwjFLGmcBYkgB/yoO?=
 =?iso-8859-1?Q?ZpyrEQB36EkuSUh8D8h9CMpIKjgbLE/JGgu2CxuK3TgqfI24sTHOMvaaGh?=
 =?iso-8859-1?Q?kkvRsbd3xlr4VXd5GMFwR9arHDhPWDz78d?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vc3UnJJKv2UJUzxkfbNjb4VV75QINKghi+/owS3aGoqpUyp10WomSGzLmVKimUEp3AouBEQL1n6jbW6vJJq/xBKr6w3rrydNG5WdLz3yoMrEfcCQQujhYtTTdJwx671fqvuPd9Tv92ycoOsMbsytUnw2zNLZANLdi7XDIMCQnb02P9hk17Uvx96R0K7kQQ/PFnCli5I1DvY3KgmBLP31/8FByv5qSovsasR8sBsPS/4CPkAVWcy3Q9vQn7HZ68KU3L8XkoSbPSQFMmqMb3aZjK29rXe73+RCFVNpM9yFWusH+Fyk2gL9gI32Sj0+k+Yy+aSWcf50/OW65pKAwNl1/8PsU6Dtmydz/CgqGQ/UsspmbNzHMV6+661DkgAWMAQVwgEwiuP2iwBRHxwk7lOMIsejD4FT+bMzh471fW0/Imv+RDcBWh0QEUjmn6w7XWoBuuZYislk5i6C0mQiNl87JnHFTPxmvbuWw/x0c4AEVWJpkcW5iO73T3pw7W7jhW2KgVkisAGeKG+eLkS3Ct1REQQet6wpcz9fTSJ6aMORPFDeNGcU6ZRjXLquQq0fLYLgJfrU7QA4f9qoR790aZY4gjaFrfMP1Rqpe/s9zr9WYMrOS4LA/cyDC/g6EPJCctYl
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5f643b3-5899-4d69-b5f1-08dc5ac95d14
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2024 08:20:07.5882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EGkqnxrYkLLSgLqnM+tk2a3cWS1pVX1tnHmqLRXTnuLvBN4+nqTGk1QF/5t1RI4bkiLuZLUNEtUg2pi7DOzjpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8578

Hi,
Thank you for your patch.
Please use a text-only mail format.
Some more guidelines are here - https://www.kernel.org/doc/html/v6.8/proces=
s/submitting-patches.html

> Micron Confidential
Please remove.

>[PATCH v1] mmc-utils: FFU Status check for device without FW install suppo=
rt
Maybe just: mmc-utils: Always report FFU Status

>
>From: Zhan Liu mailto:zliua@micron.com
>
>Problem and my changes=20
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0ffu:also check ffu status for F=
W install not support device to catch the possible error of FW download err=
or (FFU_STATUS[0x26] =3D 0x12), which is not captured by current mmc-utils.=
 current mmc-utils simple ask user to reboot, which give the user false imp=
ression that the FW >update is successful. they will only found it is not a=
fter they check the FW version with extcsd read command and have not idea w=
hat is wrong since at this time the FFU_STATUS has been reset to 0x00. With=
 this patch, user will know that FW download is failed.=20
>when check the devce don't support FW install, read extcsd and check the F=
FU_STATUS value. If it is 0x00, ask user to reboot. If not, print the error=
 message and exit.
I agree.
Even if the device doesn't support MODE_OPERATION_CODES,
There is no reason to omit its ffu-status report.

<snip>
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!ext_csd[EXT_CSD_FFU_FEATURES]) {
>-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 fprintf(stderr, "Please reboot to complete firmware installation on =
%s\n", device);
>-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 ret =3D 0;
>-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 goto out;
We report the status later - anyway, let's us it.
How about, instead of being so verbose about the possible statuses,
Just add a "report-status" label and goto it instead of out?

<snip>

>Micron Confidential
Please remove

Thanks,
Avri
