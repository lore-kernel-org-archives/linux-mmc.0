Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.154.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC712BD0B
	for <linux-mmc@vger.kernel.org>; Fri, 19 Jun 2026 05:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781846162; cv=fail; b=VZO7nGZLGzOxX6x4a7gQmhV/TO1MVhd1AIDTvSjbEaKnC/FqPQdEXcfIiCEBi1W0teAWoYOnDMUxEOq19zIONBZwguwSXpJBL7IQpi1SU8L0a90NEEcV4SehfKqZ8av3urtnukCR5b6WrjLW5zVLYmouowJp5qGmzn8nYxv2Qwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781846162; c=relaxed/simple;
	bh=i9USrqGGB/NNyfCL/TjID5xkYKshsoO5nnvQ+x7dpLA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sUyApbH0OPfMqaT7tVjFjCHDj40bKLmvGH6va4dOmsAMBa8cVL0h5AoepmoI589+/JZYuu527EiEGLyafVfUWpkT2aAs8SZwt/3lMOEZ71HvSfFVR5fUGTP1zDWFfczcW6qquKLOOMDGTGfrGMScYslBzq/P2kd5CGT82anSO24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=rhUt92GB; arc=fail smtp.client-ip=216.71.154.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="rhUt92GB"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1781846161; x=1813382161;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=i9USrqGGB/NNyfCL/TjID5xkYKshsoO5nnvQ+x7dpLA=;
  b=rhUt92GB7HuUfCNZaPDuCXOfa37o7qX1VDbo6MjEIOHHWS5YrHpugwDQ
   U+t0DjrRgHMA/WdD7k8ZQTP/0OTtzgtaUNX0UpPizR+NZ3C4/PDW6KRWR
   eEXVKq+xCNDU9oF86P0lrb6W65DbxqojRSd0s6oJhhezAF/ULoT3H+NCZ
   1qxwURfOc+1NMfbPObd9GMFOwxKTwxlPyxHIBTagBTXduwEGthiOMxbfx
   kN1pusJXXdUeuEOqOCE4bfde7Vx57PUk/OlEG2PZ6l68AnR4Z+d4x1xyc
   zl/eijWqfKBVSEIXMFiAc3yWy3xhk+cpV8oBb5j0iu4s7fcAymXj9T2ah
   g==;
X-CSE-ConnectionGUID: Mh3bteu3TQSp20+Q/lcSKA==
X-CSE-MsgGUID: QUiQ6CeOS5mGB5j2Ez9sJg==
X-IronPort-RemoteIP: 52.101.57.52
X-IronPort-MID: 25031795
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
Received: from mail-eastus2azon11011052.outbound.protection.outlook.com (HELO BN8PR05CU002.outbound.protection.outlook.com) ([52.101.57.52])
  by ob1.hc6817-7.iphmx.com with ESMTP; 18 Jun 2026 22:15:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HxPJTODpPKjZsoJpNqfGd2sz2q7zDdW2Jqx/PC5XZ/LxsHp5a+y28pVBlGt26sUoReafqOYukMQyW2aIzWk9XWgidyLP/P8CN4/02dVeBB2CayohGTkDmpgTuXZOFMv+RqsKfjNQOztBPTds63J9Zmqz0VO+yZ/RZCfyt1pGOf+GwHp+FCiPl00Knkb27M0YZASAhQpwtk1BmLVbyajsvQpMUVrySqCoUnAkaoy2Qc9gxopVqVZxqljXxmuK92PUx6Iq6VyLWInsn7YPR57pupyw3WAbco6TwBGJZT12+/zlWVhTtHMjQwvC3uQReNHF/0fbnrfHBkRW1SCyv4mQ6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oc5SiZ4d46tqhcWWl74TyvP059CL+h0DV03etvJyC3Y=;
 b=UcPEa7DIiwKtRp61DFOuDzCJwr/8R4x9nao0SuD6IzXKJMXMIU0aHy7UZ+l0TH6fZUSFN1gHUGxpzRXLwJckXmM7L/LcY56Ti1C9ip082U6NS/eDwo3UImEPWiHSfBOIMLu9iM3TzxTROnD3JYi0w2esLslHyBMxk9AdVnFPS9ssMUGK8rV2JzSOpWPV+bao6tKSg86yMEsfa2AmtdcN0tRmjh5vVXEF8fvs0xFhNnBJqhSsMCnHm3txsdxVHIVQNm9Lp6kXUt+YPaFdStpcMS4RITt0UewYG3Mezk/nnIQ5xaZc8AJacPgRGp2c4Cs3POTFImLdMm5YR8u+yUV83A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from DS1PR16MB6753.namprd16.prod.outlook.com (2603:10b6:8:1ec::5) by
 DM6PR16MB3878.namprd16.prod.outlook.com (2603:10b6:5:295::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.11; Fri, 19 Jun 2026 05:15:53 +0000
Received: from DS1PR16MB6753.namprd16.prod.outlook.com
 ([fe80::72d7:97b5:4539:a90]) by DS1PR16MB6753.namprd16.prod.outlook.com
 ([fe80::72d7:97b5:4539:a90%6]) with mapi id 15.21.0139.009; Fri, 19 Jun 2026
 05:15:53 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Torstein Eide <torsteine+linux@gmail.com>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
Subject: RE: [PATCH v3 0/4] mmc-utils: improve lsmmc usability
Thread-Topic: [PATCH v3 0/4] mmc-utils: improve lsmmc usability
Thread-Index: AQHc/n4vWQyidlXTfkCrs/qT74aJRbZFV/yA
Date: Fri, 19 Jun 2026 05:15:53 +0000
Message-ID:
 <DS1PR16MB675300676E85659AE0C7E0D8E5E22@DS1PR16MB6753.namprd16.prod.outlook.com>
References: <20260617172411.42805-1-torsteine+linux@gmail.com>
In-Reply-To: <20260617172411.42805-1-torsteine+linux@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS1PR16MB6753:EE_|DM6PR16MB3878:EE_
x-ms-office365-filtering-correlation-id: 042a0aa4-e1a4-408c-4b47-08decdc1d5c6
x-ms-exchange-atpmessageproperties: SA
sndkipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|56012099006|11063799006|22082099003|18002099003|55112099003|38070700021;
x-microsoft-antispam-message-info:
 SKEHvv3ghu+fBFDmfxdyT0Zn6k9RA7Ky49ni6tXtxuvSNO6/Gj1IuC7OtXvXgQqvnhW+Lf/znuXc+qMBBKocQNyDxDuAG8YVt0+LRNxPGi7aqAjUgbs8YPltgVHXf0HtfRMsct/q4nvT99qt9SFw8lucge2HhSnBU/450G9aW0ap3C0pNzau0vEMWwPACFtao30ZDb/8hfKZbIx4touKFxSh3Kh5j4XBuy0X3OfU6NfWbuqXyAzuemF6Vpt7QzJOM5Y7cwHw03zS6q5K9LateYTMheLKlU+5kxvSMdlH1Vv0knzChn4nITYSdfs8VMosveztwBFs3C+BUgdpSS+38knRwkZwqPtlLcHcHco6zf2sDAoqPdiykhGTfhL7K51zacx2g9s+gPFG9z2Oy6tK8jjf+3AWsIBPbV4DTmilD2uj2Uu0mTqabx2cjY13pf0AfltJA4nVgnhR0E+GR8UOG6AYzM87VD0Tntlm/GmylWiwmi48izfLKttfLWbJ1lvA3ZnATgGoaaZcHqAQOmeHEI1zBSHDE/+TftqOeBBxJ2eYs11JOC951VsBIcGfUBZzedPX5NuBe5Cgej1vTYzZ6+nzXXxNiwvHNWKQA2M6avbNDonF6+vsZfCmZ78eKh/TiM631wpuBBc2E5Up5+LHsbYVWnQ5x6T4xMxbAnnwbWzQ1cd4nIvnJ1QDgLhjm9vSzide2JzlnzL7wW6w+Rek6uP5/+U9N4HLKxr7clYYZr4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS1PR16MB6753.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003)(55112099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9fDAoB9rlz2h83/QxGiLMA7W2oHMP42XFtyqMrZAwk3BikPoFCR+/YfAFPjq?=
 =?us-ascii?Q?g6TT9hGZ/oabcbUrf9d9f6gp6vm4uO23vuJopl4KNaTqXb4kwoSypCrBIUov?=
 =?us-ascii?Q?3pwwHv4kSRwNc8fGYJv/JIZCRJahtISFNkqjraKCgl6T9ikA+HCFeGh7lb36?=
 =?us-ascii?Q?+nEGhaE+n23TfdN57Gt9/RgfC99z1zr9pVU13/fOoIfmHKpJUbV8cvMy3MrO?=
 =?us-ascii?Q?/GrGx2j02khr3V0NBqIUasyKpjpC+gaJ1iY/zAJXT6x42zYifmPs0T8EA0IF?=
 =?us-ascii?Q?mjGYcNrAUM9yCRnrNttTBUAlkyMcuY4CXBP4j+TCTG2OUSd1cCFH+0OhIUjY?=
 =?us-ascii?Q?11g+fUr8YovFqpmzB6QjJu1poLbniUNtcvbDqaXJMqpW0D9SnSeDMEDWeSoC?=
 =?us-ascii?Q?trxMvMHReOpGTYmKNfn6p65QCD99HcOAlEMnZCwwtbzqQtjSExf9EfInsKRC?=
 =?us-ascii?Q?hE5O9REVqatYCFm7fxWC2LN4VapSjDVRkPHrBAPkvU7r4bYXFAqtQ4+IdUyR?=
 =?us-ascii?Q?A39irLn2PfGlhAMBqsidZarUvg9pDdGAXCGIipwVNQAmE1O7ZAz73MJqqmZE?=
 =?us-ascii?Q?4RG8CwbrFH5+wXFPah5mslI2y9x21pNxCBfU8mCv76r85dmZcoURuTxWukeZ?=
 =?us-ascii?Q?DizK2Bm8GSKTAs7XGV4t7AUH7MEZ1O7xUn/WNFBEhRmpfNgd3mKP9eLw9YFi?=
 =?us-ascii?Q?15IppSN6RxplYy19ag/JOQdHGB8Hh8HXG5270oxOzea2L8TjX+s0fPZiHXTb?=
 =?us-ascii?Q?whR+C347yy3L/7y8DoAPPM6KJyIrOz7KxQf9i+OtnX45NucmuCdzeiJuU1AG?=
 =?us-ascii?Q?fcGq1kaUJoFxf1tagetQhUTFzsYglgN6z4HmiIZd4onbVP/eax5sSJUk9IPl?=
 =?us-ascii?Q?v4kxjXt4Nw9Rp6cpcojFVSHY5gpvSXZmhgFOlbQFvPsPgp648qWeiUpxU2e8?=
 =?us-ascii?Q?DOPM+hVsyHNJ8Pre+JbRTlE1qe4Tc5WKuVJ7euf4FF+AwuYRGUt1lAWFJEkM?=
 =?us-ascii?Q?mzkXGN0WGwcJGzUrSeFHbd9nx3HjUpRbifQTtLva5NiFkxahKKcAIobo022h?=
 =?us-ascii?Q?wTyompSGJf33+GAF8bSw6wbRdRGxZQrBQnOTiXnvM5pQ/Cz0cAs6vXdcGyJs?=
 =?us-ascii?Q?kiTTgASOKad2yKdSiHwI8/RLNlVd5xhNYhOrBXuJPJe1+Lpf5KsqF9L7zziz?=
 =?us-ascii?Q?r6h7g1UG6QaVJFKLGfpSakvLsMYDtrqi0agGmsMcsAoL0MpQNJQ2Po/Kw04n?=
 =?us-ascii?Q?srTi/K0ky6s+BVvn6DpJ9VN1CrYIVMT84S9PAZUb5P1VEQdsnF6bfIGuN2l+?=
 =?us-ascii?Q?RUrVpK+2QTXfbSmkGfw9Va2ahqhzeRXPfKf9NesHn1fZ9j9VfwYFlKZkwgOh?=
 =?us-ascii?Q?p3/VBT2ncAuZiOl6JIsAbEFC7buOLFU3YHDrKJJTFrBh4MbOQqYkRywgUvi6?=
 =?us-ascii?Q?bloPzyPkQLGz2yVyxCwAVF99yuay8umtsmEbhy4AzqnhQRAlTbJmbNTanNA1?=
 =?us-ascii?Q?nUynkuG0IEfw9NAez1uiqgx+OCaCe6rGwbhIHSxEIIrv0BIdcAHtrvAP8VcS?=
 =?us-ascii?Q?lTP+5cnm8i1PZVumc7UuWk7y5m6Z1GOOiryJdO2DbRbqXErZwLc9rU9DJsYE?=
 =?us-ascii?Q?VMHaR0CW4QUZ5/39geedHWnkCtUYl5B6hQIdQjIYs1p7zNuYiUskC4I4EgzO?=
 =?us-ascii?Q?xiGqZsdwBbo527XZdv3tyEyiQtlenyN4zeqY5vjFlVQp6rnqE3nfoj+AEhiQ?=
 =?us-ascii?Q?50QgyRKdyQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	EYJJknCoZSKaUvpiDw1zWRQP2J6D0+pPFPgm6NmXo6cyBEx/xDCvjPD8fWuAwPOyeOrOKE678IUsEp74iCN5AGFu2zfNl4kiBqksVJPxdYUdgApxMGcIUhwIVaT8PPJyF3InBEPEkDkq3ol6oZzlQgYorXuYUMB7HcPZiwuJXjRTIvsAuCSOSJ9BemKXNd0RGr1pmSchVaLvRGkanrboXQ1p1RP40UEIz5xxpEiOEFFIUsK3ivHJdSP3bv6a0Crq+czLOPhRnp/pGpVqItE1IWcTjmOTsaBUcqnVHJcsGWCTNDKbtcsIJPQhuInkWUAhvTub9N3O5oo/zClvobA5Sw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5tBmvZ86/B03LS4/emJqm2sy+ZAwum/HlbpSC7SrQ6LI9basalXw5+wAF7Z3FEvtggIFsBJsocwLS4hQ70D66Vx8k7yJU9H3sv993nio0fKK3/Fa/QsdbadBH5D8rJXy1KguWeMQgvosYi3cbDdnuUa9wUKt0CoRzCChA1xtgO1RySyTpeyWp5NZEIYrhcBFywpntm3nVWEA7BQNx1eyoZjI7D8/9nlhdlcO3T/wQxe28lqTNlgGHsfGnBLncwxCK+HpoLAiTg7qj2yhs/ZsND3P9sa5SmeWuwryrW0oRjC4ZDH/skkbfhoel1J2Z/cAhRWl/PDkhnUaKns49A1XkkUH/SITM4y92IWGV/YIae0HrGtLbCf7rCnxtv3K4TRCUiOT0sKlUSnYkAtkq513+0aZlcQemv19u0KbuZZRm47t002BZal9J15KYPRoHw3y3j2K7E1cs/x4HOAb3iILflaXiBiCgX+VU6dc0iORGB+vWF0mP3wNL82UBqIrV32erhLjkVru+MDIZnwqspE4IML4PSjdROmNQWllSMwoqjwVHBQBMvPZ/UhdcsPezT6KhaC5aXR0byAPqoLfbO79wHemXqfbcyNC2AUfi10xW7NsEVYpEO1V8Ofvh2gG90K63R/plLAZCrYVMA4XNSRIeA==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS1PR16MB6753.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 042a0aa4-e1a4-408c-4b47-08decdc1d5c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2026 05:15:53.2074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xgeAIh0rSFcZDrCXHjKqFS65Vpt0kYLwpOfUVN+kG07tA4A0IC+CTX69u9yLKWnQJcSUQl+0mJMDEHSg1XPD+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR16MB3878

> This series improves lsmmc in four areas: external manufacturer ID files,
> accepting /dev and /sys/block paths for register reads, an mmc list comma=
nd, and
> bash completion for mmc-utils.
>=20
> Changes since v2:
> - Patch 1 (now also includes the v2 "refactor CID parsing" patch, squashe=
d
>   in since it had no independent value on its own):
>   - get_manufacturer: return strdup("0x%02x", manid) instead of NULL for
>     unknown manufacturer IDs, so callers always get a printable string
> - Patch 2 (Accept /dev and /sys/block paths for register reads):
>   - resolve_dev_path: use snprintf() instead of strncpy()+manual NUL
>     termination to copy basedev
> - Patch 3 (Add mmc list command):
>   - print_list_entry: new helper, split out of do_list() to format one
>     table row per device
>   - do_list: probe both SD and MMC ids files once up front so any
>     "ids file not found" warning is printed before the table, not
>     interleaved with it
>   - do_list: skip sysfs entries whose type is neither "MMC" nor "SD"
>     instead of relying on a missing cid file to filter them out
> - Patch 4: unchanged from v2
>=20
> Torstein Eide (4):
>   mmc-utils: lsmmc: Use external .ids files for manufacturer lookup
Your first patch doesn't compile on its own.
I think you need to move all of the mmc list code into patch 3.

Thanks,
Avri

>   mmc-utils: lsmmc: Accept /dev and /sys/block paths for register reads
>   mmc-utils: lsmmc: Add mmc list command
>   mmc-utils: Add bash completion
>=20
>  Makefile           |  11 +-
>  completion/mmc     |  62 +++++
>  docs/HOWTO.rst     |  77 +++++-
>  lsmmc.c            | 621 ++++++++++++++++++++++++++-------------------
>  mmc.c              |   6 +-
>  mmc_cmds.h         |   1 +
>  multimediacard.ids |  16 ++
>  sdcard.ids         |  23 ++
>  8 files changed, 543 insertions(+), 274 deletions(-)  create mode 100644
> completion/mmc  create mode 100644 multimediacard.ids  create mode 100644
> sdcard.ids
>=20
> --
> 2.53.0
>=20

