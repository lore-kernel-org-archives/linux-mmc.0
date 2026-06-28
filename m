Received: from esa.hc6817-7.iphmx.com (esa.hc6817-7.iphmx.com [216.71.154.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778531A5B8A
	for <linux-mmc@vger.kernel.org>; Sun, 28 Jun 2026 07:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782630686; cv=fail; b=CwzyhAm9Mt39Cv85D8pIoRD7oqpU+uXXqvrFayjjm8XDJRliqAvdijrot2FUa/88vSxoF7KrvvJVsBXyt36qqtMu5WUIfDn+2Ib7wVoEze7aSSxb0axfp0Erk93r3Mp8lnl6ax286RfsFODqL50DOJOJw4C8bG5tgNio2BDZMxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782630686; c=relaxed/simple;
	bh=L7tX76cLAf+AsJ+nMTMOHru7wGeoCUHvqTGMW8GWei4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RxMXILqSVlX+cmFqULLX8NMPoXb/ew3f4FLAKRrPcM5FAQJDVQSOvy3l+V1a8Kl7V4dTnhnTtMHUsm2O1dN1FK1277f0jxkA7cuKvnBQQghbmvhYHMeARmVF6WHjNmzIHvVma/GF6j5lcJ2L1YnWP8BOMdqht/GYL2P7H6Vz/q0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com; spf=pass smtp.mailfrom=sandisk.com; dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b=Xr+TRlmb; arc=fail smtp.client-ip=216.71.154.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sandisk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandisk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandisk.com header.i=@sandisk.com header.b="Xr+TRlmb"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1782630687; x=1814166687;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=L7tX76cLAf+AsJ+nMTMOHru7wGeoCUHvqTGMW8GWei4=;
  b=Xr+TRlmbwWdqLYU6c1KdVU13kuAWo8yV3iPs2N/0BDV5MgiaLhQIWQCV
   99IAVCRuNmc/Dmy3Slf1uZvvauoqr1gigU8zBnkfNDfdstgG6gbAQsye0
   09YnCNKD2Dx+4gsP3g9q0v3EVKOTK5YNYnJXr9gKdypMRzXDI4YB40EY1
   IfjStlaLfTTXxIe5g8UgcZlKetbX6Za6jQXS3TgFVvb1qutgSPj8+BRFh
   +UaJBLn1T8Ra5d5aboF7M59v8g48SOwvwIYRB91t3G+3ayQNB+6J3kE5C
   KERal/qDeyrlARu2HphFNdJ5cURcMn/i6JUDS/jAwUC7UsYTdbtXo0VkF
   A==;
X-CSE-ConnectionGUID: vy9PObTETYaiYKFfmp+p5A==
X-CSE-MsgGUID: 4kN26VUmRuiJZO0Kpn6UeA==
X-IronPort-RemoteIP: 40.107.208.5
X-IronPort-MID: 25507205
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
Received: from mail-westus3azon11011005.outbound.protection.outlook.com (HELO PH0PR06CU001.outbound.protection.outlook.com) ([40.107.208.5])
  by ob1.hc6817-7.iphmx.com with ESMTP; 28 Jun 2026 00:10:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qNSsjfQNf456YIthwHOvTr3U6+ECbM7Yr9EC4LDjr//RRGvzhTsPxl44Tb+7b3gVxhIr1IXVQ9CptwrAG46rDiV66lyWh0BVSguCz9SH/IjIuI+CHWn29TTyphKEf1JWuL27VngTjlqGS47US3hvSbDx9YBbZwOleirUvmBJ9UXkegQxQUp9PLg+OOGWY6OtoUDANGMX9VgVTF03rUZnHyvDtt8WtszvKdN/a96MDW/me2HTOc6kJ5Oi0X8V4Vq2FcLTG9GaSkNCfSjFccN/iG83PoK+ifwZdNH/6umE03CJcsaaCEL4AX52P1aRtKUMHi3bdjVuolmw9ZkHQsI4Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c1ia/gqiSLwhic2ivum2Z2MSkHN2VgL9l12DG9H2wBs=;
 b=Vwefur14Vdh0xTuk0t/dXspmSimFwKMJrwei1p9Q7U2uZl1sMefdVL6wkvyFUDsbaesixrxPpToOQOdotBm3DPLNKFDeVc4VmDbg1BNhL8y0IU+DADro5AkWP0Q/q4xE1sXtt58zDLLL01koJfg/6TnuqpvMXVp7hxhhm4DScVG0iRRcSKgkHrbpl3GhhrhSuu1t1oDMKRNpFfjMVAMa9fwhAPXnNlCkH6eMmzHzrbwC0snuG6S4eEwc2qBnur4Heaqt88B5DpbLi1mosZm0mpx6W72H8Ik9z9R4x6uLXIyXMeW2abaOdf5l7PS57FvX4Yabp+kY+JhBaBy9pbWINA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from DS1PR16MB6753.namprd16.prod.outlook.com (2603:10b6:8:1ec::5) by
 BN7PPF5B8B861D0.namprd16.prod.outlook.com (2603:10b6:40f:fc02::710) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Sun, 28 Jun
 2026 07:10:15 +0000
Received: from DS1PR16MB6753.namprd16.prod.outlook.com
 ([fe80::72d7:97b5:4539:a90]) by DS1PR16MB6753.namprd16.prod.outlook.com
 ([fe80::72d7:97b5:4539:a90%6]) with mapi id 15.21.0159.018; Sun, 28 Jun 2026
 07:10:15 +0000
From: Avri Altman <Avri.Altman@sandisk.com>
To: Torstein Eide <torsteine+linux@gmail.com>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
Subject: RE: [PATCH v4 0/3] mmc-utils: improve lsmmc usability
Thread-Topic: [PATCH v4 0/3] mmc-utils: improve lsmmc usability
Thread-Index: AQHdBAoXs4nFEmTPC0ebFDI35ogll7ZTkUYQ
Date: Sun, 28 Jun 2026 07:10:14 +0000
Message-ID:
 <DS1PR16MB6753D5454EC6A775EB341FA3E5E92@DS1PR16MB6753.namprd16.prod.outlook.com>
References: <20260624184824.2215718-1-torsteine+linux@gmail.com>
In-Reply-To: <20260624184824.2215718-1-torsteine+linux@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS1PR16MB6753:EE_|BN7PPF5B8B861D0:EE_
x-ms-office365-filtering-correlation-id: 1309e9c6-ac1d-426a-2757-08ded4e44d74
x-ms-exchange-atpmessageproperties: SA
sndkipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|38070700021|55112099003|3023799007|22082099003|18002099003|56012099006|11063799006;
x-microsoft-antispam-message-info:
 GyWA6v2V7PaBwcmBmhVb//zQN/cldLl/f3jTRIxzdL1l9YI2SwSiQ9bQiEJjvApaEfckiraWLIsEPX+G+jU4FnLxJjveg7y3YIAEEdqWAl6mOyyHVYRmM/Wk9L8MY/UGNhR9n6goxUI9VVWImRHEq5da99CjIuwLQ4+2tJNQGFu057IMs04/f4oOzXjSNHJvpTSvusnRf5WOy7fP6IHWzbqWmQWgP0cSmUfi+hBRufNMuxq1oLEVyjY7PAa0zeF4CBazvQRwB9kI8RaDVKFcE59uEmvChb8cjI48aiogWMvyXLJB26/Y656gdXvJRbLN2foNC23DK61ch0cSgteQDGO3FykXGCABHopRaDbT89X/7afJVPW5dx/mqIS4tMnxwngkm+F54o6AWB+BRfQTVVA/1RPjxdlqLCBEx+0NS6MGUPCi5jqTJmGIWiUf4kQ8TrnqVvvjZ7Lw1Mfmfc8IWzkM9TywZ9fqjLWYwjxj6SGQEk0kytgcvYt3KRhyLDM5K+ZLxW29VNFxmpyxipuBuZeJEIL3aNN300FzT0bdJ3kaMuacBlDzFGz+/U6zcTU8k+kPe2z6Ph+pm7zs5evg7erCfbrT876xHZSbEhiha+wJlKt2ISnnsDx3gEFChhrTmKDpPkgk1O2kmFSzFYm6EnCLhzQ04AyMJg78xLizEp9wGLXgxZ1QA7jJdwFHdDzYmT6ZEpNEriy2QmXIdgCYyuzq/IKf3oq+R/VtiK5J9+I=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS1PR16MB6753.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(55112099003)(3023799007)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Wl1B0mq761NDfem0b/HdUvRIlRibrvSy3mctYXO86ejWADAx+kZTKE0l1STj?=
 =?us-ascii?Q?iSESTz92Uf0cPKUPTkMpMNOYQf2Tf+IQS+PBYfHjCSFq21q6CTXyYgFkoiAU?=
 =?us-ascii?Q?p7iRd++r72x7YJ+8keKoNuOzAFECp7T1+CJH6ksKgeM+UWZzE6/XeN+frazl?=
 =?us-ascii?Q?NpTxyQqDAhVS+k9QGLW3lX+hBZFmqOAiXAXatOysVS2moT9fTNE7ZYkCEJrN?=
 =?us-ascii?Q?JmWjATUUkH/eMtk/lJ68omXVC7/lUH11HWSG3JKWl7PKE7HnOhlXGiTzTfYs?=
 =?us-ascii?Q?foz5uuSfUuJWNa1eSBJ/iFyO5ZUcj4O1gv9jWWttIgQ4sHeByXoJQ5rnMOjO?=
 =?us-ascii?Q?HSm2l8uM5C5p3OFAO9BIL5xakWEMamBDb70jpecVV3PHw4EFi7rtLLrkVrdN?=
 =?us-ascii?Q?f9kNRon/+8skTEVLkooO9kbw+tCYGWGetwpRVZaY0RJnlHqxmMXbAHdyaq++?=
 =?us-ascii?Q?JYJ6JrrYyr653BZXTRCWJ5n9bow64d9u2cvAqDM8anI1ZxJtnI+AAtdtrgQM?=
 =?us-ascii?Q?3dNL4VUqCP2lZAHe5w0jac9EG6GPmcoJFcOPj4cmpIqV8asPrV+IANAAeJA+?=
 =?us-ascii?Q?/m/leKiIDLAI3xX+ixpQD8bERNs39eJS8KeP319TGAqUYEO6oVbaJe/6LFXY?=
 =?us-ascii?Q?AjM3TbSRzwuzAvy95KlLIawpw5+1txG2ZWxUARR556Sb/oBa4eE/2OjoIhhP?=
 =?us-ascii?Q?Z446oR8cWlnrdgN15YSLrXnv5aDi+pU+cUzj9qfWImt7MYGHR7Jw15n6akLK?=
 =?us-ascii?Q?qmNxsEIfWbYFVIxDTTZ2g1kNwi0KZkdD38F5YqqruHb6adb0bLnVb/GiHxW+?=
 =?us-ascii?Q?OgyBaE6ey0zJTenREQl3SYOYUP0VERG6dy76W4t1S4uJbLavykcy4/zMa7nr?=
 =?us-ascii?Q?UbkGGjZGh5jveiuv0tVJdmjWZCtSmA7hwKry8Y73lVnlJnptwVQ/B2E4AFr/?=
 =?us-ascii?Q?FUH6T+NMSylQK5guFUixl/C/aI18k4hHs4UErcQsYUvWEyjG+vhWEdqwYXqI?=
 =?us-ascii?Q?BfsN1CIqcrNGMJrIIcVKrnCQ67vhr5OW/ZSo2+Jzx0phjQe/CyFjpGqqb7K0?=
 =?us-ascii?Q?7rh8kx2us65xUUjoI0WWktZff78wwe/aBByV0dWkDGfS/4O78kj03cEl/keo?=
 =?us-ascii?Q?3EeW2rsGmdXsxeadeZZSVLh+XPLi/4WifCQKnev+E8mDyex1uS7e4bMQqLo/?=
 =?us-ascii?Q?2YCHL3un8ssqucQn/QMzYqv/T8TJ2PLfajg3Aj+nGiyvA3IWgjsKOpcv390y?=
 =?us-ascii?Q?A1dtN7heZDs9n+Agdu405xWkYhLpHpkGGiRLuffeXpxJ8ILR4LdB6wEK9ghJ?=
 =?us-ascii?Q?Uzg9GFLxJWSt4GXrwqPT5M2UBUveZ7HoPUH72ZUC22urO3Mz7xIqIEC1XCRr?=
 =?us-ascii?Q?ah8B5wmY3bVQ2dWERnUWcrrXMnzdKQhczwwyBJLSnWE5uOZkKXkhCjbmMJG3?=
 =?us-ascii?Q?y+u4aQRgSYHtgPCrkhYe1NuV/ZDuOalprdl53hGqkhfKSXo9BctAGQ2ThgOG?=
 =?us-ascii?Q?D9LVsUiCgHjW4ae0er7NKOee+ZowLcp5pimn7r/5WoJIir87eAeCt71XDEIS?=
 =?us-ascii?Q?9qUGKj/lO+/vsAUGWVdYJTu9IdONuAzBMvSgiy1VihPB15E+LyPSSnj3qdYX?=
 =?us-ascii?Q?RvOF6rPHyj6ylxwst8zh1QrJ6l+A/kgOKc/HnJ8mI7ahssSM44IULhynC38y?=
 =?us-ascii?Q?QggckaRfhlXMYQFqLVQ2b/kbebDRW/IIXYLsJWpTTUzfm/l2wU/aphwf2qHO?=
 =?us-ascii?Q?LS25i/Sqpw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	pa06K6vlUJpZbyeF8xQl4zEkYrnegojz93DH1ItzrCwfvuvJtu/bd7yX6lAjsoevOW44gOkdTR+cC9gjXPfg0lv190tJz9fRo4gkiJYBH03zoLc854pS3f9SR6MRK9Jx+mptPiFbYpEaEpXDpyyJrpGfZWbuPVk6DWXY4c6P9AmUW4soQkf4HO1T7s9P7G/5ZKj4HwsocVYc+25efgs0ca3EQQIn09jWM3jxjx2DNJRKOROAFegKNAF0dvNnY6Ip/KF9tbrJ/xJydg8wsvbmTrmRzgavSK7SX42eq6Y37SWoL/XD6g0eHP5gSuiiNAUSKTDVqFZ3dQSDTNylUghqzg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Z/w40XgHjIdFKq+KYC2l2+Kce9XPAAv83csPeNbNqvenvfa5kTzoLvTcWCb0UccMOGNxPuPbQEDeSlbIqNeH/88QblFckiTAeksdsw9pVIGlvN7AjrIXTfirc0wjKMrC9POcU3CAM/jEqDSK4U9sX9Csp5QpQS7iMp8FbcXu4xfmpf/NC98MfbxTKgWE1ZxJPWBaBFr0zQnog2z3BooFzH2nhp+lGCaK6wRhojGLGW4LZO/0DD467IgHdDSQIrsX7Ld4IWGo3V1NdWhWhMy+rzEZ77baJMHREaEbrWDq10WEJMuv0iqo8x4/QC7PezUKcjV9FrctCZrtBaVxElT6XUPQYAAoYzwzZH9GVc/ra3IAj8q+PxbS525MrnOO8KxDdKwXz1b4x3Qi0lDgUlYuxjbD1l7Qni+7mIsGtGa7vhLSAd2uRd1Y3EGGe9+5hdHEr1nd3u6V6NPBUkOuVDzz0uBV1c6HUfawvF8lr+U8bNmjS1UnPiGQovHnGBuKl2OH+6N4DzrMzCtS9tw8sU1oobZJxEQJO8vbF/udsXMEsT4dWI9dpWIn+fiD2uR2J4qbrEJAttS2iCKVorHWESg4ACph90HnKO0IqpXCKgD5wZFz6ADlrQ6aHIy1KfkFw1t8s2EPwCWDDu54m7e3yH3sqg==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS1PR16MB6753.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1309e9c6-ac1d-426a-2757-08ded4e44d74
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2026 07:10:14.9812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XIO/PW1Um7l7xzEVH/qf9AZm4nkrFvgbn5Ln3bbsNG2tm8Np1kIglgNNMxl7xmfPmEDBib+1rWAvdEi3l5DUmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF5B8B861D0

> This series improves lsmmc in three areas: external manufacturer ID files=
 and
> accepting /dev and /sys/block paths for register reads, an mmc list comma=
nd, and
> bash completion for mmc-utils.

One structural request: please split the bash completion out of this series=
.
It is independent of the lsmmc work.
Submitting it separately will make both easier to review and merge.

Thanks,
Avri

>=20
> Changes since v3 (review by Avri Altman):
> - Patch 1 didn't compile on its own: the mmc list implementation
>   (find_block_devname, print_list_entry, do_list, month_name) had
>   accidentally been committed in this patch instead of the "Add mmc
>   list command" patch. Moved all of it out, and squashed in the
>   former patch 2 ("Accept /dev and /sys/block paths for register
>   reads") since the two don't have independent value split apart from
>   the list command.
> - Patch 2 (Add mmc list command): now contains the full mmc list
>   implementation that previously leaked into patch 1.
> - Patch 3 (Add bash completion): subcommand completion is now driven
>   by parsing 'mmc help' output instead of maintaining a parallel
>   hardcoded verb list, so it stays in sync as commands are added or
>   removed.
>=20
> Torstein Eide (3):
>   mmc-utils: lsmmc: Use external .ids files and accept /dev, /sys/block
>     paths
>   mmc-utils: lsmmc: Add mmc list command
>   mmc-utils: Add bash completion
>=20
>  Makefile           |  11 +-
>  completion/mmc     |  52 ++++
>  docs/HOWTO.rst     |  77 +++++-
>  lsmmc.c            | 621 ++++++++++++++++++++++++++-------------------
>  mmc.c              |   6 +-
>  mmc_cmds.h         |   1 +
>  multimediacard.ids |  16 ++
>  sdcard.ids         |  23 ++
>  8 files changed, 533 insertions(+), 274 deletions(-)  create mode 100644
> completion/mmc  create mode 100644 multimediacard.ids  create mode 100644
> sdcard.ids
>=20
> --
> 2.53.0
>=20

