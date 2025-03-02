Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD69A1B87EB
	for <linux-mmc@vger.kernel.org>; Sun,  2 Mar 2025 07:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740900540; cv=fail; b=c+iuOss1pvCf9lj2XjxKVPBKPa25TCV+2DlXqcrxG7jSTHi1ypk05Zjup4nUwPt0tiGEfjccf+/LiDNEMXyCHflEswpyE9KpI7am/bNDJIwZtktrxnqAzINYd6AGfxDhm5mVJeQdrXwSQMUFlZckd9q3xJfWCFeH1u34mCC8G3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740900540; c=relaxed/simple;
	bh=MLb1IjfOTnRBE7Y5mu03n5FeLgXW2vXTUyvMvub+8jA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AQnUEC5Veo7v9s3+0bhpdSXNeKVMASwVcSloqQUmlBupcL0Yk/EW0aHm2EyoFKuhvWKirK6g8RIMWFbjmQViqsnfk5rrNOk+8OJTYwin1yLbIfTtA9L1PH2hWJ4V0t+TGkQcpx7s1HDuvtUDq2WzDuvbRkxK5lV4Iylk+dMDa2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=LQ0ND/jC; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="LQ0ND/jC"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkim.sandisk.com; t=1740900539; x=1772436539;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MLb1IjfOTnRBE7Y5mu03n5FeLgXW2vXTUyvMvub+8jA=;
  b=LQ0ND/jC4MmttHO5y9x9itv6s8t6EhbS9UEMUTtdeFiVmXLU1Ju2hE/N
   5s4WpPG+EmJYVNJtvfibJiTJ/j6ol4G6img5TBWSPn9jnbCGwWOOuodWf
   x4HnZcmz3jWx30bGPwOGQSzydiWTnucKU+lmKpXEYDso1pJQpors4Wuq6
   uwd8EWQH9JTbGuB+9umIeJWTpIZp37WPiJDmBMIWt4mxCk35Q05Y/ok3q
   pIKWpBCCIXqpcqLddDjSuX0kIveiXTZu1s1cXNK859RijA72BGX8XqtkE
   uM6l1x3fCnx06qe9bGDmQ6Xz/rGiTDXaC9NrfuIGTgL8+JohGuu3zFjD0
   A==;
X-CSE-ConnectionGUID: 9xDos2PjQp+5+5n0sLCtwg==
X-CSE-MsgGUID: mbZtBL7vTrqSZnak9zSz8w==
X-IronPort-AV: E=Sophos;i="6.13,327,1732550400"; 
   d="scan'208";a="39820469"
Received: from mail-bn7nam10lp2045.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.45])
  by ob1.hgst.iphmx.com with ESMTP; 02 Mar 2025 15:28:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nqbBN60SCBbEvl0pk0zKR/dFXUTYmwtrrhwHYatfIL4NfG/eabGaKuwOyGmEd4lmJjskry/VjxJ03XnZXTGwituZ3BONyizXa7YModIKhcPai1wKNwsQvh/GYarw3jZ8AYqXeRccXB/VWzyQSz/Bjwj8FD3WS+WeGJmGywYk5x1Mx7bRVFLEyXmGQ8dS3KOEHJwWlOXk3ve9O6S5+VqZj8O8BeDL0qZ7wmZ0VSxR2sBZRpDQkpmsnXszV82BYFMWw0pkFE/DrsyiOjs2XqmIPmbyUNNoJWWQ36YcpNwxgamL4+xkjh6gsMXokneZD3QmXL/sBP8OiDN/lqriEwSPiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vnZKHmyRSmLwuB7D9AR1eqQ0Ujp7hZF+UxsTrrpjL1s=;
 b=dcCBIZuA06e8qH+9mpXTVdQggcgSZ9QHkP7iP0ysgWotyWIdhGNgYGPIYdF8pCCJbtJpHKQ2yKEbqlvlhWCTGemH6dVX/FsPROP99jL5z54Ff5SZrg/qzlv9JYhxadIXncEiBbzbQ5FJvlsplxnw+YToshHA2T/YJxH1P6w+DlgPfRgN1Fk6Z8BtnxKB1MmHa3udxW3fwVPJ8l8H2hYssVmSui511HtjVhhiK6rtqwFeiD550IdtSbOxwZ4TdCFjwcaJA4oilXx/Mo3qDWEe7AKFTxJSgQveD6LULx2t5vQ3rYJ8eP80mCtYwJ9OX+rzC+fSc1+l2x4oYJOajtZaCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from PH7PR16MB6196.namprd16.prod.outlook.com (2603:10b6:510:312::5)
 by SJ5PPF07863BA94.namprd16.prod.outlook.com (2603:10b6:a0f:fc02::ac6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Sun, 2 Mar
 2025 07:28:48 +0000
Received: from PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::58f:b34c:373c:5c8d]) by PH7PR16MB6196.namprd16.prod.outlook.com
 ([fe80::58f:b34c:373c:5c8d%4]) with mapi id 15.20.8489.025; Sun, 2 Mar 2025
 07:28:48 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Avri Altman <avri.altman@wdc.com>, Ulf Hansson <ulf.hansson@linaro.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC: Christian Loehle <christian.loehle@arm.com>
Subject: RE: [PATCH v2] mmc-utils: Documentation: Add missing entry for
 "writeprotect user get" command
Thread-Topic: [PATCH v2] mmc-utils: Documentation: Add missing entry for
 "writeprotect user get" command
Thread-Index: AQHbe4cKULnSYV+TRkKxwc1mF0eJd7Nfkivg
Date: Sun, 2 Mar 2025 07:28:48 +0000
Message-ID:
 <PH7PR16MB6196EBA0EDC021E8AC7A24E1E5CE2@PH7PR16MB6196.namprd16.prod.outlook.com>
References: <20250210063947.3298-1-avri.altman@wdc.com>
In-Reply-To: <20250210063947.3298-1-avri.altman@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR16MB6196:EE_|SJ5PPF07863BA94:EE_
x-ms-office365-filtering-correlation-id: ecfce1c3-964c-4cae-cc1d-08dd595bdf95
wdcipoutbound: EOP-TRUE
wdcip_bypass_spam_filter_specific_domain_inbound: TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?LwI/ResmlYBu2/aCHLGDQYCh1sMR3DT7B2wLhehvkmvF/NOsk61sDo5K+tIG?=
 =?us-ascii?Q?X5bqyu9JOG9sJrN2Vx1NxvJ3P/DHZGWwcAUIKeQQST19gJ5RGs/ZNXLwrkay?=
 =?us-ascii?Q?YbTBPRiXCvncS/4QMgqp+q1f40S4UQk5IBaf3bAmJ8aScgav1+AMxQc8hIHX?=
 =?us-ascii?Q?qPE01nDW4XGs9PJ8cagaOUtOWaGf3RYynnZMiqqKlw97sDEDPc7nn1nRpVEa?=
 =?us-ascii?Q?vnQbppnOP1YsjncadeZ2BARihGwllLbArARq3Mz04ZG5uuQZkPJl2EIEu7Z5?=
 =?us-ascii?Q?OENqllKVpZ6ebEK8ovOptP/lR4iRNnkO44bNe8IRcgDLmhK2c53GTbQk+bKH?=
 =?us-ascii?Q?JHJ8KETBJrsIl1XO8CRxYc6sSfZnee1siLWdD0ShDx8vZCjkHX7j8nZ986JS?=
 =?us-ascii?Q?HAUNmwC79FmLUQXMy/iPSnfxBPb2IUkrNEbPTHeMO/REGqVak4eZWusl3wiP?=
 =?us-ascii?Q?irAJVGQfwFxhVmhqlalfVcoMnQRdkQFEZ9uADX5pKitVVep+boWfIqF8bBkd?=
 =?us-ascii?Q?Xxbso8ejxLjRlyTF9gSXMoVIvTF2q5s9DZ+H7Jgql5pU7oRI/nOipmqzle9R?=
 =?us-ascii?Q?oO1B/f/Wj8Cj1p5zddiokI3WxO6VCekDTVsd6b5UA9GdYIGYcpaZ8FrjCuLq?=
 =?us-ascii?Q?0X2k9X3U6hAYpZXgX1kUIzS2wpfnkBEe4IL0b8BnpPkpL7g2YC3TTxPRYxtX?=
 =?us-ascii?Q?l2BSZwt9TA6yC47Dym6dyoX69ewUfc0LIwFNLnJHowBmZApxR5Ua/O5da/f4?=
 =?us-ascii?Q?B/qsyAVYuldqFLdSF2tsKWEri4Kf1CIeN4cK1AfgyMpM0HgpbC8oT/w1FVcN?=
 =?us-ascii?Q?CQLWrSnNAR31YCMTJiAOVnGuWbIcT64N24WNngkB7VChhCa3yM1lYlfi+Hgl?=
 =?us-ascii?Q?0zCuinuyBoE06oZHVMYzpLxxN78jczRP3tDqCAC9cIg46lE7xPbRAaqra3FU?=
 =?us-ascii?Q?wmlHLFHkAY1K5drUFT7352f+Ut2XviXb+TXToZncW8Pb0aIOEVtcm7dyeIbA?=
 =?us-ascii?Q?0bzfcPpyZJ+Vh3/V82cc/el7ePKla8BM0hKLwQvyoJ2Dsk0WiZlYloNqAiiY?=
 =?us-ascii?Q?T0DXp4sAsRvVH0DSjxyH/V+RXazaRPnwmx9EQ7Vg86jMwmbYEgOh0XdloGIt?=
 =?us-ascii?Q?SrqNX04vSO0F0UmMvXddlBKnWhS8j75xIhB2ddQfCcOa7lIOjuNSsXoBUG6t?=
 =?us-ascii?Q?xtgx2AQoC3vlG+iI98kRbNvD+9EoSfPn0KENwu2kcwoei6QbqvgF+PnJrNCE?=
 =?us-ascii?Q?1JJYSvX/Sy464+BDNA+s8xU2rsKaLkxn+OGillA8rqIef/CIJC547jtI9pN8?=
 =?us-ascii?Q?IOJ8bs1ppVLNdYbvOJIbFDUXO8zAbflO2HqZ5VKvao5d8TOEpHY6RIJ4ozw0?=
 =?us-ascii?Q?8q5LlxBZLJxOLck3zlnA1MXs090wedSpXftsob9fi/KIrkH1bCjQ7yNPNwm6?=
 =?us-ascii?Q?FBDd4zZuvMpA1OC+0buwQIUtD2hiWdgx?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR16MB6196.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?nNUZPxQ9L3F/T8LS6ssADIkfmcRa+2k0vQ1yV37Xtkmal7h/UePCKi3ISjn1?=
 =?us-ascii?Q?cf+KeAftcvzdq4LDgQRZ9fIUBjOcySbmAYy3ECwPv8DNz+MZGWNNm5MSQUp2?=
 =?us-ascii?Q?fuj+kFuJ/SjGIdzn38OwV+7bMi/iqzVWPqw5BxaP4MBeJkPYEJ2BH7Uj0C1u?=
 =?us-ascii?Q?TMvbVLkYXmdMuLt4pZQRpFGkflC/qSadC0aUuuaJEcSwCKUelktg8j197xIT?=
 =?us-ascii?Q?P7JEJUwmjrbU17+7PeoYuK/l9FV36t0K7crF9QBi7Cs+xmnRSZoOPLoV2N9R?=
 =?us-ascii?Q?iS1FF2e+JjCAm+zyB83QnP/AHW7XRmGQ4xvje1UOVBZGYnWkVrKLXgGIZWQb?=
 =?us-ascii?Q?NrIcVWe0qiJ/2HbN+3mM5gE74wYu0/UkgqUMUVuLITs4l05RpgHWzwatPQJL?=
 =?us-ascii?Q?hmr2PTmRHpFnX3liaewz9FGrsIocj6eMFPsE7Jw23g9YuvZDjtNVFeDVhBMe?=
 =?us-ascii?Q?8uSqiA3YTlBYmgh17RNwr0MScjI8mxjz5WRyKalaHfVde6xC3ioG9ilX2hdD?=
 =?us-ascii?Q?ddMktZBVRTPAzxqmfNjidbRwRZ0/kYMHwiqFuUlxf467e5SG++wg+8juGkps?=
 =?us-ascii?Q?AppInHKsQDdhQdwKxt1LSqP//lXUf8FcQEjXz89gEmFVDbdioAARRNOAeuQr?=
 =?us-ascii?Q?nXoYMBHgVJIzLdqlsSglWtrnC/rsp/o1iDAXUyJ5yv3qvwH1oHgMH6fVOvPW?=
 =?us-ascii?Q?cRLoi4WwPFhEZQHoGfV+kjLhZiqTTdeEsjuOrPdcHIWaG9ns0kNCiajZ+ZqW?=
 =?us-ascii?Q?rKm1BVPd4GuG6owh43EQsxE6daooIHOY4k+KriuTtTO7kx5kqxruEL/1hdHW?=
 =?us-ascii?Q?ZukYSkVZJvt450CpOMLGMzGhR79bUhdrxy1zAv8H34eyepreS6JzuFcrAFNg?=
 =?us-ascii?Q?MdITL0i097RrGbp+FKGi1gQSqzFZiUa5c3fEQlIRT0AgUMd5QDR0HGvNT6c0?=
 =?us-ascii?Q?ZeKayUFQrNTU7lDwuOIEmAK9yDBVavblvB6vwVAZvga2flIkQXdi6LobUk5B?=
 =?us-ascii?Q?KHfsd0QaoDzQKbjxytchC1bDUW9G7PugMR6IGc9CJgaT6JDbjBMtCIyvohq/?=
 =?us-ascii?Q?cqdUPKrPMY5QUxd3d0KSBmtvmKec+O3kDlVfzYC3dJWSOaoC44lJ3+xaPqqd?=
 =?us-ascii?Q?1pBkM6tjDwpxYBaeISAvggNZ6KS9vguVlla9AlZWDS9xgjF123hDf8+HKHmT?=
 =?us-ascii?Q?/LZqIYWx+b9V3P4rzl41pF3HJAokdgQJIP64t3W7/Jvm1zRcvMKqu7KlaOxu?=
 =?us-ascii?Q?dUmpbYXROxCqV5bNfAxNSIphRXzEoTdMvHEHH2q009BExEa2AtFs7C8FZRos?=
 =?us-ascii?Q?NoXgoWtdScebQl6tGufeHwR4sa21M7UKi/6uapgGR80beuFbrS4+ftrzKr7i?=
 =?us-ascii?Q?hBgCpk5g0IkeN75CHIxfiM5wCocbhlJTjkeugkVrcmd7Q0XEfK+3lH8Zu654?=
 =?us-ascii?Q?B2kIFnQhCOzZXZf3uUtMIF9GWF6F1Nn5nMU0hI9NrUTl+kLbDSGIPMGyubMJ?=
 =?us-ascii?Q?6zHA05xFnhhK3D0YAyPRkone+8QAW+JwZpb2xxtkg/3Su0WyND88LHTf8j83?=
 =?us-ascii?Q?pQWX/Nh9rEaPZQ2sVGIgc8bfmFxYh5wvwGCx1alNVs8p9Pm3OSwSpc3Gyvp/?=
 =?us-ascii?Q?Hb+n5IxZ8QegsLke7N+Sp1a9sXQc5hZVs9UO0Q1BTn80?=
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
	9kRrruov+g0kutUtjaf26QQdBbkGvkXv6crvBus4tylm2/kLvU47xpcIicW6yJRyOn1rHtJ4gctRyTu4vR/4O+B590OLRPty0D3NnaGDrkyXMhqcABOu+NrNwSkexmUPA6ZJLjzJ67DiB+B1eIzmLebfTge/ucw0MyKJVHjdx1//Njh2h9qTmXLonCwBHwihPS5yXOsJ3yEmRLar7a7dI7QoPI/beNEpwB70a0FKxaVoOAPuhA2VUC4w3yT9hkGr2YVm5uBB83wxSwrd3UfLm8FqJ55ccKzIK/cmd8Tg/kMDJMklH5ydYBjtCbFftoLM+TWO7/FZDqXaqusfO5zMBh6BPfpcNf/52PZyf3Iwl8yEqY3kz3+Q1TlybU0/g+cYiw1+BtFzK/Di+bHhwVyAHmOPIJqYbBkJbTKiHODCVrEkdsex8LVJStQLldXLxJ+uyovwdlN8C/0Z1uBMWs/eZ6+Pphp2fKsdfckVgIgg+GAAWrc3KoCBEPhn3UGrGz0ltwoKMYjgewaL6hC0RaL3BLb9vJPByK/jvLvVrPb77yJV5zn5c4+41Bmpjm9+wM5GtHk7bzOUynCXQD0k+HW1nMMnB5Pkl0q6NzKPP4q9pbwKwFpeIuxZzb5ARg9ui5SS
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR16MB6196.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecfce1c3-964c-4cae-cc1d-08dd595bdf95
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2025 07:28:48.4111
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jZQ0ISkdX5R+DTyj7FVvfkTEo1CVzQtYRxqYF4sIkketBhWhrzZBKXG84S/CeHL0/+mSUL9fBJt8+o1jcARbtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF07863BA94

Ping.

Thanks,
Avri

> This commit adds missing documentation for the "writeprotect user get"
> command to both the man page (mmc.1) and the documentation page
> (docs/HOWTO.rst).
>=20
> The "writeprotect user get" command prints the user areas write protect
> configuration for the specified device.
>=20
> Signed-off-by: Avri Altman <avri.altman@wdc.com>
>=20
> ---
> Changes in v2:
>  - Fix a typo (Christian)
> ---
>  docs/HOWTO.rst | 3 +++
>  mmc.1          | 3 +++
>  2 files changed, 6 insertions(+)
>=20
> diff --git a/docs/HOWTO.rst b/docs/HOWTO.rst
> index 095a9bd..3902fa4 100644
> --- a/docs/HOWTO.rst
> +++ b/docs/HOWTO.rst
> @@ -28,6 +28,9 @@ Running mmc-utils
>          If <number> is passed (0 or 1), only protect that particular eMM=
C boot
> partition, otherwise protect both. It will be write-protected until the n=
ext
> boot.
>          -p  Protect partition permanently instead. NOTE! -p is a one-tim=
e
> programmable (unreversible) change.
>=20
> +    ``writeprotect user get <device>``
> +        Print the user areas write protect configuration for <device>.
> +
>      ``writeprotect user set <type> <start block> <blocks> <device>``
>          Set user area write protection.
>=20
> diff --git a/mmc.1 b/mmc.1
> index 543742c..2f7209c 100644
> --- a/mmc.1
> +++ b/mmc.1
> @@ -27,6 +27,9 @@ If \fInumber\fR is passed (0 or 1), only protect that
> specified eMMC boot partit
>  .br
>  It will be write-protected until the next boot.
>  .TP
> +.BI writeprotect " " user " " get " " \fIdevice\fR
> +Print the user areas write protect configuration for <device>.
> +.TP
>  .BI writeprotect " " user " " set " " \fItype\fR " " \fIstart\-block\fR =
" "
> \fIblocks\fR " " \fIdevice\fR
>  Set the write protect configuration for the specified region of the user=
 area for
> the device.
>  .br
> --
> 2.25.1

