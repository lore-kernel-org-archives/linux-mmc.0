Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984D213B7A9
	for <linux-mmc@vger.kernel.org>; Thu,  6 Jun 2024 08:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717663185; cv=fail; b=ELBL5beW3VDQ0rEEKfryFzoe4RMtP0gp59Kjpzm/OzMG/JTmBPOhJZw6F4kSRkfcC51Lt/29NUinvxn8m8gsH+G/Z0CDCYKSzoiQJZ0Nt3stoJliRqGKhV9GXJkL9enA5lXnW0nagJDCG6A/yNtVpHDOLbyZelehtMDI9f8ZIH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717663185; c=relaxed/simple;
	bh=9pkjGHa1R2AEmjl6nMd+P2bKdfV0bUXyW70PzHbqWUA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=joJqu+1ExjF7YS9AXMQF6HrgzYjP0/evmTDxGe6rK87JkHRmlwScUi3/+bj8jW49/uxM6h5MEHmh6zNaqNtE/y3gIS8+/znkdbE8KP5Mdg55tiGMQggb0hoPNvddF6jlDsopv+wd++Wi99+5PNMK4l0a/QivPoVnwvJCK/hWMIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=LmSt6jmO; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=I1QsHxjU; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LmSt6jmO";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="I1QsHxjU"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1717663183; x=1749199183;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9pkjGHa1R2AEmjl6nMd+P2bKdfV0bUXyW70PzHbqWUA=;
  b=LmSt6jmOlA4TpDC1RgcyTCnJ66/9/XOzFH8obtRSLp69chsd+LBnKn2l
   TfYfNTfUXVpx+OH3k6jnOYoYejsN+MJu5oyvpcPMW7R/N/YCZKrwPKrrk
   V6y5Ixi999x7cJcCgVKsD6zNhwCpvJFjVcps0UQUKmFiZxPtGMH8NxKdd
   s082FBM2+C2u2WPgA40TjjegHNnW3v0A2CD1evMs6Q+NhRtyGr4i0waDp
   bBNbrBCb+q5vNUkNFNmhcED+/fJN7pc/CakU776f2+GjCBYTMLAvR/xLN
   ld5mWt+wXjdKT50EWmpGVOdKzqt9q740xNFkxyBg/4KwodnTLWwlGwqgo
   Q==;
X-CSE-ConnectionGUID: 3zJBBIqtS5+6otknMRsTYw==
X-CSE-MsgGUID: xIXOFF/zTsSqd4vBkSSHMg==
X-IronPort-AV: E=Sophos;i="6.08,218,1712592000"; 
   d="scan'208";a="18423585"
Received: from mail-dm6nam10lp2101.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.101])
  by ob1.hgst.iphmx.com with ESMTP; 06 Jun 2024 16:39:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FvjW2+oSUzKluvjxugIqxociO7TadIJd/hzhzJ0w3zFwMYvDuTBlCuz/g3V9aZRx56AyAwEe193ngkAwvoUHHLEdTvufXw7tjcwmvg5G7gROMSfystpkOdNdxzzLw1DYbHVSnq1iWQSqInlL8qHaYXAXAVeRl+6TdKQ2dj2hFH6jGdk5Zabw5YzuU+wx5ercVWL/X82HeIf0myn76dRnt9XW6B4yfqU5oClhm2E3Z6lMK5kN4XEGTCMllIp7rkzvXHnhFJlJISYr9Q4Z1QdmK9vHDbBpaj/IawnA2pTG7KPWL8LLmf6UTw7d/G/6AReEQysOW08U/lXy3tgt/EsfNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q7r/6byFKponhBIslgh5C5dgB95WmiYYxuFDZOwoosk=;
 b=FqRfOvpv1MpI6KD5dH/3qPQ/xxiIdwYi7KZ+ZaqiHjzg/aeoWt/vY4+/wLaPT3ox1I51CfOXLKhZICdgaExSect3W6GTQz86cF7GGYrvS/KTPXW8b5tjZqcSgl1qhjOfoZW5cWh+++p1PV+fKe6MrglgmUEp/QDKuEMrcFohb2eljXigPkTKfRnrtZ+XO1fMFI4v/LL1d1xHWBfWyARToCtKzV/wAMEeUot9KkC0Vnov2tuLoa3qCjINUYLplkYGSqakaBZQXGEAxbBBeyUfJRJpibzn6yufMP+nYBmNuKxHKtT0r+3LTf8BIK7h/kVgamHSGD2xP5swKdv0fWTqyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7r/6byFKponhBIslgh5C5dgB95WmiYYxuFDZOwoosk=;
 b=I1QsHxjU3oAqrGLKwXxlWDYQMm42so0gBR3E8LcEU0j5tvFNdyyP7WkCwv38mvOLXSkG6lnCcRcpa01evFPFUICHSZbzw8Iw5ubdDA1vouVutFs0kUz/59UwEbspgS4+elw2EVvUsG70tOj8zyiE8ZP3Y6RjYIYWWSyGQRmCzoQ=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 MW4PR04MB7411.namprd04.prod.outlook.com (2603:10b6:303:64::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.33; Thu, 6 Jun 2024 08:39:32 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%6]) with mapi id 15.20.7633.033; Thu, 6 Jun 2024
 08:39:32 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Daniel Kucera <linux-mmc@danman.eu>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Subject: RE: [PATCH v3] mmc: core: allow detection of locked cards
Thread-Topic: [PATCH v3] mmc: core: allow detection of locked cards
Thread-Index:
 AQHarRQjZ8lG3T2hpEC0yWy4Na5oXbGzfzGAgACAU9CAAHmbgIAAA71ggAX9CACAAAWXIA==
Date: Thu, 6 Jun 2024 08:39:32 +0000
Message-ID:
 <DM6PR04MB657501C1FA8CFA831A43CC79FCFA2@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240523132016.599343-1-linux-mmc@danman.eu>
 <8e03fa17dd41180f53fede6897ab1bf8@danman.eu>
 <DM6PR04MB65758D11355C0A516B10704DFCFE2@DM6PR04MB6575.namprd04.prod.outlook.com>
 <4716f78bbe71f4d8262b16a546393758@danman.eu>
 <DM6PR04MB6575B624ABC7190E84D73D4EFCFE2@DM6PR04MB6575.namprd04.prod.outlook.com>
 <f6b219a15cdbdb96b302d8923d7768e6@danman.eu>
In-Reply-To: <f6b219a15cdbdb96b302d8923d7768e6@danman.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|MW4PR04MB7411:EE_
x-ms-office365-filtering-correlation-id: f795e10f-91eb-42ad-283c-08dc86043051
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?7TwrdYwhUaOhljzH8IQbx2D5SALHEq0p51tk0XmJ9gZUZTb0LtW/sxlB3yji?=
 =?us-ascii?Q?wxf0BFt9kHfPBrQbc5GyBEPlO0e+2Hyp8EfN36IzXsYsnYesiTOsx8QTkI2k?=
 =?us-ascii?Q?DgYub0AV5KLxwkO548yzV5O0ECN1PKI47Un2UJlKUXAx8qg4XzbsoV9eho1X?=
 =?us-ascii?Q?NgR+JZUeoNJOh4JrBklXdbS0Bnqrmf6K2LGaydMxAhVWU+VhIlLRT5vMf9iZ?=
 =?us-ascii?Q?zm6X7l5W6g7G6pmTNHVguUpeC8Fx/7Sp+cbVTJMoJLVBigh9WueYcX91rBcf?=
 =?us-ascii?Q?NSHXRs2ZMtaHC1WRwP8oCyoA+6rTFJKE+DFjVCx6tIJ8WCbNTdaEYNPfNhjC?=
 =?us-ascii?Q?3+o7Qson5j/tv6/ZcIO8kM8wo18Q5xkLxR68Z91hQ+yhazwLA1hW4WcPgjkw?=
 =?us-ascii?Q?Gk0jRkO3Zmy+tOsYLtaZKTwtH9puzAmlXwMe6EGSc059GPf7acXR1QP54+9v?=
 =?us-ascii?Q?ecg0TVvUddBt5TE6c98kXZ+gSaEEbvWN2BBdBUMFUJ7gGBidQhw0ZkSoSzO5?=
 =?us-ascii?Q?+iS59JvHe0j7KrakluzZE70nCwHAkTFtLAlALhnzVnQO9+ntbLvbLnu6ONeh?=
 =?us-ascii?Q?N7/gS8TwwKc7xMpC9Zq5kWqJ+7ofqgYAfi5y6p+4PC7JRYPgFgfEdw+T7kAu?=
 =?us-ascii?Q?9SaCmu3yxYrhiENvtO4HwnQa/AKg6rhtMTOwwEycomxyx3jWbWumw0yVg7hw?=
 =?us-ascii?Q?h/RlzxpO7Cv3OsXKv2uI+0AcEaaPulpOv0p4R5+tkaToMnOfMcgE8zVctNKZ?=
 =?us-ascii?Q?se6oj0n3I/qBlRIoTu/IVuSLuxwimYkWot+qP1GpMCQSa7mEG83FrOY5xdnC?=
 =?us-ascii?Q?nwwQAaKa8h8iN5YXAosoe8IjnvRusvEvHCn+Ig+oC5uUpilKhOIdqgT24ujm?=
 =?us-ascii?Q?ruq6U3wDyV3sHi5g1aZm+8gPr/LHEPgJ4/LVxtiqWnJO7MtpfQIMsKzwhFmW?=
 =?us-ascii?Q?q5BXUBQ9ceZNi4SdnUY3q/WfIB/NL6WvRvxH2W7eFQ1E8NCKolzRb0fFgX2V?=
 =?us-ascii?Q?1Xfu8k8WIeSWpj9ssJa+OQ4cjB6Kb5yHEVX/kxrTswsnHtLg4AhIVaLbdFru?=
 =?us-ascii?Q?41gef9P9o6AD4N/Fh/4x51zNQHmKh8Tp/o3ZsJzmR92+XRvpAwSapP26R5WE?=
 =?us-ascii?Q?7gS7muidUTaa/GDWuAPyKJvUj1yyXNibOAe7XTnJ77hN78Jm9VaV9CJbEaZ/?=
 =?us-ascii?Q?sSELRyu6Gjjsf5Ap0XV0ZEg3JBpGV/t9vSOMAhh0rxxX8Sk9UDEhTrxjOoKP?=
 =?us-ascii?Q?M4vqtZCUKwlRESbnCj96zQSoSzjLujEQmdp56CKxlivd5x1KUKakbkUOpr7z?=
 =?us-ascii?Q?QgfqIXCCGnWFH+Gwn7gt6aUhH+fu5dVT2fzIQ1DJgRCMkK9fuXodFWFDTZTc?=
 =?us-ascii?Q?ALfCa+k=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?noyt767bAP01uHC7Ocf6ZQCSmbpkEH7rq8ckNHQDq8n8xIu/r9qZ8g+4S3No?=
 =?us-ascii?Q?C0fmy+tkhzr/QxLw+3cpncKRKsIlrL8/EMsTPhgcxwc2YGtOQ5Bwz3Bd2ugF?=
 =?us-ascii?Q?ocA8RHB6JRpqFKuEmhJEsO1mRHAnC5QDxZa0+UuNCiqk9nbCIClyxu1Gnc6g?=
 =?us-ascii?Q?sVOb26ive2owH6MJEBxQsY6rgqrphmBpkzYyEJYg/jMZPFl8SkpsWywfHWuK?=
 =?us-ascii?Q?0qgRS1bbeawkIqU6ncJZpt+rzCXn4uxsPc8BMy7rYyswP2KcyVOofVucENal?=
 =?us-ascii?Q?lrUQgMUbibzfA8zWXK+C+b8nm5ClRlWi8/fJCBs58apd8H1NWsRR6HncFQ9p?=
 =?us-ascii?Q?BaCpEHGwbiyatz+QwmODTnqVhr2oHzuazk4pHufo4Bv3YDJ8jHS2PyDv7nPd?=
 =?us-ascii?Q?tZ430v7LHeHj98DFH5lc7UPvKjRk+MiyqnTEDmfpTu4HpUEHBd1Hzdx2LrJM?=
 =?us-ascii?Q?OQJxeSIpc6iWgUXohClurxBuZdnrdvzAlfbFU7xYkosNG2yLICnRM1Jdt6Lj?=
 =?us-ascii?Q?FqCr7HzVsozZshjAhUYi+xlCI1NCqYmmDjG9IMNHU7UFgOxqfiiEdso5KmeB?=
 =?us-ascii?Q?5wYUsvzIL2WScCGqDA0SMz9DiuJ/50cNEMr1zf5ADkLEz4rQqhZ7J4yxaEpx?=
 =?us-ascii?Q?JezOhlwq9/lbD/3EWB4EVGHR1UE1lfZVL2CUUTmdb2+sVeoSOf0zP2563Rfb?=
 =?us-ascii?Q?rYwCbBWZIDi2tybrEwZaTaX72XreYiEAeKMVCZFt5KFR6CtLjKhvAAq4ahlc?=
 =?us-ascii?Q?xbpnH/qWz0OP5zd6lf6GA4R+ZjE4Cx9norkxcdL8M031OkKiB2pvdN0Refxf?=
 =?us-ascii?Q?+cX+wH5gU8qLNBqdbyr+pUMNe8NUYKk2NM0ih1prqBsBBqGCNw34UbukNQZX?=
 =?us-ascii?Q?Z9RiQ8U5JVrIIG5qFc9wPayNEDU0jSb2NqQz2aXxzTyjzI86Am6Jzqr7LZqL?=
 =?us-ascii?Q?5rVXeaWBHqG73ce1k0UkYZDaShZaad1lYkzdUa0bTfDaMfGBUq9MuE4I4nR0?=
 =?us-ascii?Q?bSinLVwyWFI+VTO8eKQC4vGgtIjOOxxMO+4w7UcCQwWTr5kf77C6X8Nh7GoE?=
 =?us-ascii?Q?LFY8iTmSRR1nUtXuALnWkR2n/v1lqXsvKSEmrJQQH1W9hyYYn84HT3MLPVwd?=
 =?us-ascii?Q?0Zyrx18yKFkcbB0doPrl0iOQj20wb/6D6+Khp+OcrBn/jNQ23e8bG5lIJzHV?=
 =?us-ascii?Q?7YbLmCCe0tWMdWhaW4WQhenWpWIz1GgJyV373tXkuwBpWWoZxZsc3ltv1C8U?=
 =?us-ascii?Q?9UlP7DwN6BHU1v0jl0eyWMdPswUXIyooRIWuKfCb6wk8fC11ru87vLNXUVbV?=
 =?us-ascii?Q?Rn2PUhemGD/kaMSae8xyltbpk9pirbiyzrzHk2JwRE/rEl/4cXUrfT9bTZhl?=
 =?us-ascii?Q?nfaK0h7aQwumvLxLSFSlnbQoXRq1bNmaU+X1CYtZ5jJq08PgCPi03+askBJ9?=
 =?us-ascii?Q?7YemJScV+oSfhcCvvDXUNb1c2xEBx+Zxnk3Uz6GQVgCA4HUpbR8e8SYsDy7j?=
 =?us-ascii?Q?scKgahunV5+/DDwxQolnKCU6yJzhbJ7Xoyw6uAYaKIO3uARPi+r9NTRCwQTq?=
 =?us-ascii?Q?wJechQwoLMti4vAT2HgTienMflKtpkb3XZaAo7aN?=
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
	HxfkGY9JLluuReOHuOllvxK4qA4g/VGS4ROqzPU4vlxL9OCX9wN+/R9j+kyS3tqwF+60ro2pAv41it7HtOyWmsfOqEssvNNukx9iOb82QGG4wOebaMGnHq9silHOvcFgBgxY2uUfFf9Fin8jZUJjwbjqz2Y86n3in/bYAyxL0X9kzSBDjKsVJfhLMizkAdbBItaAPeVONdu4klQmEAykczsL2T92FXaoYQOsIFF/b2vjxB+Ii+iGtbHUPpUbfC5/4cwRYTRjpxjnQKqFXyk/HZQ2VBmhMDU6R9qFbyHq3c9PCa8HuuikbsgIKgd+bERobcidu62E6ZosbhltZYMVXQma+NVp7IyQOolUx1n/se9HL/rDpZKLVP1jDt8Bklobmhly571mqmKsp46wN2Jl/g+STD6kXVKZAlC7qTDRNfkgYtbnqHCIGxoz4jii5g10qYIxmKA9ohJL0KbfEcqGMDamcR7TYBDwXWexQDn+fnHPnqVdj/jdu6uElpfah+VeLiNalDlLYFfygEVan0xRgn3SZK7o8pwSPG/iH3M6FysoYSGFFgICpUYRB8Wt58DtFlFLwAZzIQMB/COfojBnnkAxL/r7Xmpz+baSP0BtpmtB5vhPYqjATwFyB0Mo9B/w
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f795e10f-91eb-42ad-283c-08dc86043051
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2024 08:39:32.8236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s0OoRaU+HJsmXu/Zmut5Se75/bvUfjFVuM3sRN2UFSeAlF/f8WWc1mgWwBGdcLzEMQZ/I2OxX//yN7CExGbj8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7411

=20
> Hi Avri,
>=20
> On 2024-06-02 14:59, Avri Altman wrote:
> >> Hello Avri,
> >>
> >> On 2024-06-02 07:26, Avri Altman wrote:
> >> >> On 2024-05-23 15:20, linux-mmc@danman.eu wrote:
> >> >> > From: Daniel Kucera <linux-mmc@danman.eu>
> >> >> >
> >> >> > Locked card will not reply to SEND_SCR or SD_STATUS commands so
> >> >> > it was failing to initialize previously. When skipped, the card
> >> >> > will get initialized and CMD42 can be sent using ioctl to unlock
> >> >> > the card or remove password protection.
> >> >> > Until unlocked, all read/write calls will timeout.
> >> >> >
> >> >> > Signed-off-by: Daniel Kucera <linux-mmc@danman.eu>
> >> >> > ---
> >> >> >  drivers/mmc/core/sd.c | 13 ++++++++++++-
> >> >> >  1 file changed, 12 insertions(+), 1 deletion(-)
> >> >> >
> >> >> > diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c index
> >> >> > 1c8148cdd..ae821df7d 100644
> >> >> > --- a/drivers/mmc/core/sd.c
> >> >> > +++ b/drivers/mmc/core/sd.c
> >> >> > @@ -928,8 +928,19 @@ int mmc_sd_setup_card(struct mmc_host
> >> >> > *host, struct mmc_card *card,
> >> >> >       bool reinit)
> >> >> >  {
> >> >> >       int err;
> >> >> > +     u32 card_status;
> >> >> >
> >> >> > -     if (!reinit) {
> >> >> > +     err =3D mmc_send_status(card, &card_status);
> >> >> > +     if (err){
> >> >> > +             pr_err("%s: unable to get card status\n", mmc_hostn=
ame(host));
> >> >> > +             return err;
> >> >> > +     }
> >> >> > +
> >> >> > +     if (card_status & R1_CARD_IS_LOCKED){
> >> >> > +             pr_warn("%s: card is locked\n", mmc_hostname(host))=
;
> >> >> > +     }
> >> >> > +
> >> >> > +     if (!reinit && !(card_status & R1_CARD_IS_LOCKED)) {
> >> >> >               /*
> >> >> >                * Fetch SCR from card.
> >> >> >                */
> >> >>
> >> >> Any feedback please?
> >> > You didn't address my comment from your v1 - Since eMMC & SD shares
> >> > the very same locking feature (non-COP SD that
> >> > is) -
> >> > You should at least explain in your commit log why it isn't an
> >> > issue for eMMC, If indeed it is not.
> >>
> >> I'm sorry, I didn't get what you mean by that. I am touching only the
> >> sd.c code, not the mmc.c (where eMMC is initialized, am I correct?).
> >> How should I address this?
> >> Should I test with eMMC to SD adaptor? I don't have any currently.
> > Theoretically, looking in the eMMC spec, a locked eMMC device
> > shouldn't have any issue returning from power down.
> > The only flow that is affected is that its not allowed to switch to
> > hs200 in a locked state until unlocked - not to say that it is a
> > problem.
> > If you can't verify that via code review,  can you test your mmc-utils
> > code on an eMMC platform?
>=20
> I've just tested with an eMMC to SD adapter in my reader and it is detect=
ed
> correctly:
>=20
> [1463181.072006] mmc1: unexpected status 0x2000900 after switch
> [1463181.074560] mmc1: unexpected status 0x2000900 after switch
> [1463181.077038] mmc1: unexpected status 0x2000900 after switch
> [1463181.079709] mmc1: unexpected status 0x2000900 after switch
> [1463181.081972] mmc1: unexpected status 0x2000900 after switch
> [1463181.083412] mmc1: unexpected status 0x2000900 after switch
> [1463181.084831] mmc1: unexpected status 0x2000900 after switch
> [1463181.084836] mmc1: new high speed MMC card at address 0001
> [1463181.085195] mmcblk1: mmc1:0001 004GA0 2.59 GiB
>=20
> Do I need to do some changes to the patch?
Just add one more line to your commit log saying that no similar attention =
is needed for eMMC because....

Thanks,
Avri

>=20
> >
> > Thanks,
> > Avri
> >>
> >> I am sorry if these are stupid questions, I am a layman.
> >>
> >> >
> >> > Thanks,
> >> > Avri
> >> >
> >> >>
> >> >> D.
> >>
> >> Thank you.
> >> Daniel.
>=20
> Thank you,
> Daniel
