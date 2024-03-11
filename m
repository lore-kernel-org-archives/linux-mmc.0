Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF804778B
	for <linux-mmc@vger.kernel.org>; Mon, 11 Mar 2024 14:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710168908; cv=fail; b=sn2RfWw9VKbWr16yOEOUY6iWFSSiMe411o2ZVFzDYXCF7nhzIwjJ8ZoWgxVh+w93xu6gQwdIW+PZdR26l6r7ocL8lRdUYHRinx1DgjLiESfxdHUTBq5Vj2kAe7owvs8EiTI7G7mn6fNjQCe16p9rXif6pjGsa/PdskGho1knoTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710168908; c=relaxed/simple;
	bh=H3VdSP3qBeo5uG/Xr5e8T01jPb0Uve/gbpLavoljQWE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aRJi88z9pm3CMEEEKomosGXAlwntS+oOtFm+rWHN4hJlDDRQwmNUT5UF6pf7QTpUDaQsOFcsoa5k9qQCOM7r44FHKlpgh4+IRdyyhjofLCt4l3YsIEp42FIm+SSsEMy0V3G8MTUPp+XtAL3grP5NzP+YQGCTihwQPG5VpU+VmFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=UZQGNct+; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=tZ0yKaLu; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UZQGNct+";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="tZ0yKaLu"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1710168905; x=1741704905;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=H3VdSP3qBeo5uG/Xr5e8T01jPb0Uve/gbpLavoljQWE=;
  b=UZQGNct+dY8jwqNCvMiq378gH6jDtJPUI9joZKrFlzmKcq73h0LVzduD
   0I137C3A7sluuT1Lx1MYdf9kZuPzzvLQRbS0p8Ba3STjbq+hEJsSNnJUL
   rqipqgcYfp6WuHJtAtXD8NakNgxtDl+SkJM0CEVdWxfL36lclYc66Ka3X
   MoSCN7PE8afsRJ60miJ95u5r8S3Nb/RLdbSgDHe1nnm7ouBMqiX5yCcnn
   Vpm/0wExaNrb7p6IUtAAqG/XbXYx/qkN3Dli4yJDWcJljD3eYj96B6x/o
   h5capuF90H5vPGuDQMou36voabUCi6HI4atzy6Orj9mfYHDWOHkeSOr5h
   Q==;
X-CSE-ConnectionGUID: fwyLxd98SXiyjXdVZUvkOw==
X-CSE-MsgGUID: 37jts4epRQO+HGfznj6Slg==
X-IronPort-AV: E=Sophos;i="6.07,117,1708358400"; 
   d="scan'208";a="10831281"
Received: from mail-mw2nam10lp2101.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.101])
  by ob1.hgst.iphmx.com with ESMTP; 11 Mar 2024 22:55:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DSl0VR1s/4I6Rb4pMGXeDl/GeZ+um3Kma/kxYjFSr+mJ6tu0GdZW0Rm04MdevAcXOe1N1hL6/IgtKiBSrg2IU+AYS75iuJIyS+BYB95AY6BYzvz4X5LZ7pZzn3vhWaNnysBa7tW+p8qQPebufjdi8FFWbWvzE+Wq1GC2K7AmFu747J4IaOcLkqcLXczTOf99GPaNhMMLAmNc6Z/0MRk9IbDNEgLQ73VUlQAvbLwkckwLmGM3E8VNU6PzoFa764CsSGM2W3LGMHh/UxvFc85sn+6D+WLzGJf3g1w0lkdrudxiGIrjl3Fat7123x0vdG18lbTuiXv5KiOcxUj6wZSK2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iRmKsw+eBZsV8jWiEW95574JhxHNrWQ8pldeBarIUEg=;
 b=OzVYCE5r9rBnnBWVT/vFVyYMqIFbZOktjj0+0u5SnflYqST9gdHUXo1ZrB5QYxGZpj/hCyh+AyTcZRuMSVWdxaAJ7sQD502193+1ZFQlj1pDzcab3Xn5wzGtPp/bGkUCsufJ34khuf5x5LNCxAXrp/QygMbARNp14/gvOI7pA9CnaR+D6o505JPS1zxhDfTPBvFb/o/g+MDo417cyND1Q1/fQqUbAQbysk/kKi5LOt+UbDYG4tOrvbZ1STeIuwsQSaPWlAnBPSBDfSu5BT8pkMO57InNnvdRZtDqeYpm9y69txfftQwAKUBaTEpx6k/6kJk95E3LIs1K8xvhKe5H3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iRmKsw+eBZsV8jWiEW95574JhxHNrWQ8pldeBarIUEg=;
 b=tZ0yKaLuWpb9xiwpBk/2JOAR30sHzilmNFucYCF6rW+3yE4jtOzZBxtJ/6cWRN3HYzPd9ZzEaFgkVA7kmthD03gx3drnH/b3hpSFVoUmjGav+efH0XIjxELae1qB+7FodKN0I8GH64Rn4qwQ8zopI6DzKb2I1GHzEo+680vCKew=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 SN7PR04MB8500.namprd04.prod.outlook.com (2603:10b6:806:357::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Mon, 11 Mar
 2024 14:55:01 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5395:f1:f080:8605]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5395:f1:f080:8605%3]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 14:55:01 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Mikko Rapeli <mikko.rapeli@linaro.org>, Ulf Hansson
	<ulf.hansson@linaro.org>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter
	<adrian.hunter@intel.com>, Daniil Lunev <dlunev@google.com>, Asutosh Das
	<quic_asutoshd@quicinc.com>
Subject: RE: [PATCH v4] mmc: core: Use mrq.sbc in close-ended ffu
Thread-Topic: [PATCH v4] mmc: core: Use mrq.sbc in close-ended ffu
Thread-Index: AQHaIqYJKMqPT88MNEGwL4Aqch6aJrCSrMQAgKCGvICAAAmnIA==
Date: Mon, 11 Mar 2024 14:55:01 +0000
Message-ID:
 <DM6PR04MB65751092AB94DDC87FE9505EFC242@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20231129092535.3278-1-avri.altman@wdc.com>
 <CAPDyKFqsyp=isawJKH0Q7Qqxqtkx=gmPZru9NnK-ndV20VRmFA@mail.gmail.com>
 <Ze8OXcCA_BCN2MVE@nuoska>
In-Reply-To: <Ze8OXcCA_BCN2MVE@nuoska>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|SN7PR04MB8500:EE_
x-ms-office365-filtering-correlation-id: 90828be5-6352-4454-235d-08dc41db3aa4
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Fi/EtgX3ONGK/Y+0EsWQmPHEpYxR+Zp1kJKHGBdEGvGoQoRm8GgnRVa+LUG5LHfgne6Jw1kSQaMewCxwwWPp4SVwl5gaGoB7QieKmc/X2wno5U72UY/LYM2pC/ZH3XzuoAcl+mzcU+ihormDejtUwGtSZnHqonmFov/WWr12mv0+2OIXIaCu7YfIM+2F3lsFl97KJOpRgV6E6eo9EjlZwWGmJX7ZbONBGgc8Rn4ej60ifsDhC/KKQXqO/egaT8TQo00PN47xx/tmPQLprZMwiGMFASbFlIijPiK9G/PqNGrNtmbhElYgAd98+vuosvXY2ImKy1NJ0DqBDQ52RCdiuF1y6G3ITlDILySxXfK7rYIVlbIaLL3QARhJrxSd/SBWRfmlccUK7+I6t8CKNm0sIILp+GnLgew4NOmH0O8+Iz9SA08t+SFx94hSxm1uf2tB3nOUeM/PifGKWmJr6263iZ9LZ0iY/hWXJsfqnllqUb/2LrT3U3yBO/8DORS2CoqDJZp7GFYvz0WJun1Z4nNP9vnPiOLsTLCVzZKuGdvXIkL5j6YsV+9W8vzdeltd1zCwQLr2T8qua5lRw0nYb3U2D34UxTsABlDkaUDcytgUiRg1mdD3J8XnzkSm2EEIcyigci5JViXxYOxOK/1PW2H6bftl86pFSBi52Xz0DljZBDY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Lz8OIfpvKA4AX/X+13XTrFHGvappba1Kf1N+TzR82ExPCLiDtHJwVSRiaiB6?=
 =?us-ascii?Q?lnthVohZrgBhmucI0FxpGdtxMI65Di+8lL6lq5rP0/58l3kVlXZLIk//Ag2B?=
 =?us-ascii?Q?94sZfDxXxxRCnHqsyRo67ZPtx1X3LNwNDW9Lg6nvDzT///MJHM00dMgCdeTk?=
 =?us-ascii?Q?cSBmHYgzpaAgdL4UzZf17vBOrT75pQ/pFpg2xL/oozf9UameqgG1b2nB4DGQ?=
 =?us-ascii?Q?7mZCgWIT3vS/r40Gf9HKtrGs+JhaVPwXAtF8n45lUQ0n7WgRUx4Mg9tRNyO0?=
 =?us-ascii?Q?pfBKvBCb797UuaQrV+WvW9dcy4PKrjYn56k32SO9VL1OSAdOaoWsO/H5huI5?=
 =?us-ascii?Q?/jHwVnT7EbzxVkI/xdmZdV1kFNosliOpK4yFkzVB5buZmxwVrtzyIOhB6gIX?=
 =?us-ascii?Q?z309LCq5/BP5tPlkFyX/EEtGL4Lh1WNYsjZKmHN6Uer3k9BMVD0xA4v3Mtaj?=
 =?us-ascii?Q?r16gnVNA/B4Juq++6jxAOK67AF59+Zo7aLL4XoyTigEkySg10tgqxn6sWG96?=
 =?us-ascii?Q?TO6ky3a2ayQR//xOKuZKeUDJ2g67tG4+zAu7lcSb7fcJS6ertSUovRi8PK48?=
 =?us-ascii?Q?pFkC+8+AZrvPPVC9JDOz0PMSlfUZ3OeN+We3MZwrqa/uhxFosIeAlqMO1z63?=
 =?us-ascii?Q?gNtg+851hGlfwudDzLs6e13nWc1I7a6nEsOIPzF0SlsR5srhY2qw80bnJ41F?=
 =?us-ascii?Q?5QSr5FD9MaVwEchB80k6Gx97XrUmsg75HZytZKPpddz6540rFJVv8aRPd1/6?=
 =?us-ascii?Q?zfP6CPtxMJfqJXqxBBgI3wEkMfObErvqmgoOnweObv98kNMdd4dIGOgws60d?=
 =?us-ascii?Q?egtN1LKXlZWVbuKMnWRWjWQZHBkOW8eZhGdCv18TpO09rIMOe4pV+Uhnfrcc?=
 =?us-ascii?Q?20Z5cOufESE1dhXkloIc9KDXU48y6Bb7TvZzeYm+7jllm7bCZnSpiIbr5q9L?=
 =?us-ascii?Q?JK1fKLySEG5YokrfODxxGhXBhpQbhSmJtkF0r54TuStlryNHHKaYpoqqHt5n?=
 =?us-ascii?Q?4KUg4eIZFUJdHiFbJ2og49RyeCKGv7JaCt5pMz13985mSw+GHMIlP75kp5Ao?=
 =?us-ascii?Q?j6pG5H68wDR7KfcbGzD8rSkBrumeicYp9IQLyTjA4LOuw4ezrI1Jj+SNsVNF?=
 =?us-ascii?Q?2eF7aJRMMKsXYBfbx5XGdUcCmkTZ+gQYzPB5xI97SmZmKiUQQR9aScAoqQU+?=
 =?us-ascii?Q?V7QR2iv9MGQi5hUZIGKNbMbeI7VZ8X6HBRvyFX9lCybWFFhQNOGCvqABvRbb?=
 =?us-ascii?Q?NFgMHMqL4P8AaU1v/7BRdfN7pm7+J+lYa1jzc3WU/TzNx9KYG9afMxoAzFs/?=
 =?us-ascii?Q?WgxnPceubvfe1lJ3iqUYm5coJ32bsn77lRDL0HxCxoLcQ1qY6zkyxXMhKuev?=
 =?us-ascii?Q?zjqFkESO2Vfv8qDthwlejIPowmi+8Pxdrw4bEVjDCRAbrbi+yRYERucrQTiK?=
 =?us-ascii?Q?tXnTJ4Bi33grkxuLCknQ/K/L4t55fGfYQGRXA078u2q+3Nqpdu5ez7o3zaGQ?=
 =?us-ascii?Q?Krn5sr/u96o88Ce5+zGhS9OT94wg+eXgE9DqS4joOhHC5raHxTp1JfiYoIg8?=
 =?us-ascii?Q?7hYlVR6xTg6e4Iig7On/SMd/2UKKnBDXXmJf3Y6G?=
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
	28KXGCKifglJ+3xNeDQ2qk3+8Up+Wl2OhpCdJdupM/dKSTAEbVYYK7e6NnPdYxkt7E6Sx/mIoqUtaFvucJH83bPIL1E322AbEXtzwwrtowNoVDRJke6B+F4oEWOmJytSKmZTpKR3UdPdPy2vedLxAtGXGh1d4lhNZhd6lBS4gq6jdlyErOvTGqN7Q2NvFS21ra8HVY5x+GZY4e3GfhoIBaH2xe+y5Hit5OYE4aHsMgesm/BDAdELr/MPTJSo+zb9JMlUKC+1lmRInw/Kv6qCxdDbSeMYPtbr5cN4mlVHLrWCheQ6QB/Rp0BqQWXa3raWUrdhFHAnaNvKhNEpNddTbw6D8OYWfHHa5iaDxu/F/hRd8PZjRBoIxEv8H9va0TrfTn6v/4axUaPvyfxLzA6z1YJJ2s3I7hg7RlUR45ibMU52WS6aRhw6IjrCekZY48FdSn+zre4igjZZfD0eZ85/gDBk8/Gui0Sp+FuZGrgtYzYX1M5cVvOb7TRKc+isvD1O85OlJuDlBgvfBhd6y4qeSbz6SHa5mrLmStiW+JkF5F7jNZfyvx6E4M5fV8kqg93rNZ4XzQajBiOyXymTXlsLSdsEtd+nwi+APHGlFTKnThK9xE6jVwJNJhI8P5tPSRy2
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90828be5-6352-4454-235d-08dc41db3aa4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2024 14:55:01.6954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nv6zaVtvgvICrL8aHf1r58tFicnh2kQuiHIdxRcoWlADJ3gXl3PfHazK83eyVr8tbHwniKUJ4DnUJ0MtVNI/Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR04MB8500

> On Thu, Nov 30, 2023 at 11:36:10AM +0100, Ulf Hansson wrote:
> > On Wed, 29 Nov 2023 at 10:25, Avri Altman <avri.altman@wdc.com> wrote:
> > >
> > > Field Firmware Update (ffu) may use close-ended or open ended sequenc=
e.
> > > Each such sequence is comprised of a write commands enclosed between
> > > 2 switch commands - to and from ffu mode. So for the close-ended
> > > case, it will be: cmd6->cmd23-cmd25-cmd6.
> > >
> > > Some host controllers however, get confused when multi-block rw is
> > > sent without sbc, and may generate auto-cmd12 which breaks the ffu
> sequence.
> > > I encountered  this issue while testing fwupd
> > > (github.com/fwupd/fwupd) on HP Chromebook x2, a qualcomm based QC-
> 7c, code name - strongbad.
> > >
> > > Instead of a quirk, or hooking the request function of the msm ops,
> > > it would be better to fix the ioctl handling and make it use mrq.sbc
> > > instead of issuing SET_BLOCK_COUNT separately.
> > >
> > > Signed-off-by: Avri Altman <avri.altman@wdc.com>
> >
> > Applied for next (to get it tested a bit more) and by adding a stable
> > tag, thanks!
>=20
> This change is causing RPMB breakage in 6.6.13 and also 6.6.20. rockpi4b =
and
> synquacer arm64 boards with u-boot, optee 4.1.0 and firmware TPM (fTPM) f=
ail
> to access RPMB via kernel and tee-supplicant 4.1.0.
>=20
> More details in https://bugzilla.kernel.org/show_bug.cgi?id=3D218587
>=20
> I've tried to identify what exactly is going wrong but failed so far. Rev=
erting this
> changes is the only working solution so far. This also triggered a kernel=
 crash on
> error path https://bugzilla.kernel.org/show_bug.cgi?id=3D218542 which is =
now
> fixed/queued.
>=20
> If you have any hints how to debug this further or patches to try, I'd be=
 happy to
> try those out.
I don't know nothing about tpm nor the ftpm.
The above patch is scanning command sequences sent via MMC_IOC_MULTI_CMD,
looking for pairs of CMD23->CMD25 or CMD23->CMD18,
drops the CMD23 and build one instead in __mmc_blk_ioctl_cmd as the mrq.sbc=
.
AFAIK user-space utils, e.g. mmc-utils count on the mmc driver to provide S=
BC when accessing rpmb,
so their multi-ioctl sequences does not include CMD23, hence does not affec=
ted by this code.

Looking in the strace included, I tried to find where MMC_IOC_MULTI_CMD is =
sent.
There are 8 such ioctl calls.
I guess the tee supplicant sources are unavailable,
But it looks like 2 simultaneous threads are trying to access the rpmb part=
ition - which is forbidden.
Opening /dev/mmcblk0rpmb from user space is exclusive, so I am not sure how=
 even this is possible.

I can try and help you debug this - you can contact me offline.

Thanks,
Avri

>=20
> Cheers,
>=20
> -Mikko
>=20
> > Kind regards
> > Uffe
> >
> >
> > > ---
> > >
> > > Changelog:
> > > v3--v4:
> > >         check sbc.error as well
> > > v2--v3:
> > >         Adopt Adrian's proposal
> > > v1--v2:
> > >         remove redundant reference of reliable write
> > > ---
> > >  drivers/mmc/core/block.c | 46
> > > +++++++++++++++++++++++++++++++++++++---
> > >  1 file changed, 43 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> > > index f9a5cffa64b1..892e74e611a0 100644
> > > --- a/drivers/mmc/core/block.c
> > > +++ b/drivers/mmc/core/block.c
> > > @@ -400,6 +400,10 @@ struct mmc_blk_ioc_data {
> > >         struct mmc_ioc_cmd ic;
> > >         unsigned char *buf;
> > >         u64 buf_bytes;
> > > +       unsigned int flags;
> > > +#define MMC_BLK_IOC_DROP       BIT(0)  /* drop this mrq */
> > > +#define MMC_BLK_IOC_SBC        BIT(1)  /* use mrq.sbc */
> > > +
> > >         struct mmc_rpmb_data *rpmb;
> > >  };
> > >
> > > @@ -465,7 +469,7 @@ static int mmc_blk_ioctl_copy_to_user(struct
> > > mmc_ioc_cmd __user *ic_ptr,  }
> > >
> > >  static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct
> mmc_blk_data *md,
> > > -                              struct mmc_blk_ioc_data *idata)
> > > +                              struct mmc_blk_ioc_data **idatas, int
> > > + i)
> > >  {
> > >         struct mmc_command cmd =3D {}, sbc =3D {};
> > >         struct mmc_data data =3D {};
> > > @@ -475,10 +479,18 @@ static int __mmc_blk_ioctl_cmd(struct
> mmc_card *card, struct mmc_blk_data *md,
> > >         unsigned int busy_timeout_ms;
> > >         int err;
> > >         unsigned int target_part;
> > > +       struct mmc_blk_ioc_data *idata =3D idatas[i];
> > > +       struct mmc_blk_ioc_data *prev_idata =3D NULL;
> > >
> > >         if (!card || !md || !idata)
> > >                 return -EINVAL;
> > >
> > > +       if (idata->flags & MMC_BLK_IOC_DROP)
> > > +               return 0;
> > > +
> > > +       if (idata->flags & MMC_BLK_IOC_SBC)
> > > +               prev_idata =3D idatas[i - 1];
> > > +
> > >         /*
> > >          * The RPMB accesses comes in from the character device, so w=
e
> > >          * need to target these explicitly. Else we just target the
> > > @@ -532,7 +544,7 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card
> *card, struct mmc_blk_data *md,
> > >                         return err;
> > >         }
> > >
> > > -       if (idata->rpmb) {
> > > +       if (idata->rpmb || prev_idata) {
> > >                 sbc.opcode =3D MMC_SET_BLOCK_COUNT;
> > >                 /*
> > >                  * We don't do any blockcount validation because the
> > > max size @@ -540,6 +552,8 @@ static int __mmc_blk_ioctl_cmd(struct
> mmc_card *card, struct mmc_blk_data *md,
> > >                  * 'Reliable Write' bit here.
> > >                  */
> > >                 sbc.arg =3D data.blocks | (idata->ic.write_flag &
> > > BIT(31));
> > > +               if (prev_idata)
> > > +                       sbc.arg =3D prev_idata->ic.arg;
> > >                 sbc.flags =3D MMC_RSP_R1 | MMC_CMD_AC;
> > >                 mrq.sbc =3D &sbc;
> > >         }
> > > @@ -557,6 +571,15 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card
> *card, struct mmc_blk_data *md,
> > >         mmc_wait_for_req(card->host, &mrq);
> > >         memcpy(&idata->ic.response, cmd.resp, sizeof(cmd.resp));
> > >
> > > +       if (prev_idata) {
> > > +               memcpy(&prev_idata->ic.response, sbc.resp, sizeof(sbc=
.resp));
> > > +               if (sbc.error) {
> > > +                       dev_err(mmc_dev(card->host), "%s: sbc error %=
d\n",
> > > +                                                       __func__, sbc=
.error);
> > > +                       return sbc.error;
> > > +               }
> > > +       }
> > > +
> > >         if (cmd.error) {
> > >                 dev_err(mmc_dev(card->host), "%s: cmd error %d\n",
> > >                                                 __func__,
> > > cmd.error); @@ -1032,6 +1055,20 @@ static inline void
> mmc_blk_reset_success(struct mmc_blk_data *md, int type)
> > >         md->reset_done &=3D ~type;
> > >  }
> > >
> > > +static void mmc_blk_check_sbc(struct mmc_queue_req *mq_rq) {
> > > +       struct mmc_blk_ioc_data **idata =3D mq_rq->drv_op_data;
> > > +       int i;
> > > +
> > > +       for (i =3D 1; i < mq_rq->ioc_count; i++) {
> > > +               if (idata[i - 1]->ic.opcode =3D=3D MMC_SET_BLOCK_COUN=
T &&
> > > +                   mmc_op_multi(idata[i]->ic.opcode)) {
> > > +                       idata[i - 1]->flags |=3D MMC_BLK_IOC_DROP;
> > > +                       idata[i]->flags |=3D MMC_BLK_IOC_SBC;
> > > +               }
> > > +       }
> > > +}
> > > +
> > >  /*
> > >   * The non-block commands come back from the block layer after it qu=
eued
> it and
> > >   * processed it with all other requests and then they get issued in
> > > this @@ -1059,11 +1096,14 @@ static void mmc_blk_issue_drv_op(struct
> mmc_queue *mq, struct request *req)
> > >                         if (ret)
> > >                                 break;
> > >                 }
> > > +
> > > +               mmc_blk_check_sbc(mq_rq);
> > > +
> > >                 fallthrough;
> > >         case MMC_DRV_OP_IOCTL_RPMB:
> > >                 idata =3D mq_rq->drv_op_data;
> > >                 for (i =3D 0, ret =3D 0; i < mq_rq->ioc_count; i++) {
> > > -                       ret =3D __mmc_blk_ioctl_cmd(card, md, idata[i=
]);
> > > +                       ret =3D __mmc_blk_ioctl_cmd(card, md, idata,
> > > + i);
> > >                         if (ret)
> > >                                 break;
> > >                 }
> > > --
> > > 2.42.0
> > >
