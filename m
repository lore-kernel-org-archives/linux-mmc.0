Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B0D23741
	for <linux-mmc@vger.kernel.org>; Tue, 14 Nov 2023 11:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QGlUAHks";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="O+mPeB4t"
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1151D4B
	for <linux-mmc@vger.kernel.org>; Tue, 14 Nov 2023 03:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1699961282; x=1731497282;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=u+SuT3ZVmO4wgOf1uYPC5houUjPuouDwVNBUQgA8HHU=;
  b=QGlUAHks+959u84flYXnwMVUWInud4yQSXY/urI6SlBn8RkI/y7U9Ba2
   KaDJGKK3oAIIhuyuwSjPaQZLSts2Au3EZNOWclz5ePV+64kUOgyjuC4ix
   1Tq1A13+jYStCk0thHEU75E1NwtcIM4JuPcqc4bBbC6a8q14TwrXIaRS5
   PYDKWxOT2kgT2Ty786PfwseuhTClOJuCMx7wppoKLl1LYmMZXzdJUX1mQ
   RJBx6nZhnmhpb85IhzX5aM9c4FzLmzVvRhMGHAbxI5mxLcCjmdlGe04V0
   ZHeDAZkey7Lqq5pP8/pKMAbN8S8JvaPjdnlxM3dIjwlPDZ0Krh4wf849U
   A==;
X-CSE-ConnectionGUID: Y2zG1+oQTEqdRY6VIh+UAQ==
X-CSE-MsgGUID: S4f7uJWLT0+v0/sG0BmRGw==
X-IronPort-AV: E=Sophos;i="6.03,301,1694707200"; 
   d="scan'208";a="2192495"
Received: from mail-bn7nam10lp2101.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.101])
  by ob1.hgst.iphmx.com with ESMTP; 14 Nov 2023 19:28:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AhjGBeXX5WALxrl42cvMCSjycCQcxjrvh0bNr+Dt7SS+M+GPz1MEuo4VAsKxKRR5UJ/5dz3GL39qOD/pWmM5R92N5tcRX8lmicpi4aSIvbFzE0YGaRu+NHHpMtVYaGLTK0CfFEL4jE5toLR/3oC1yIUZPrtZTn1/Ny9Qz50TX9mdVebB1BcpD13Tbny8Xv5+70oT6WVDEZa0v9MlQpJt84cuswenF97SQPukuLVuKuaCYOeJxWQQcLN1Znx5Q5APhqyp5meZmNjezFCOGhDt5OYmZv/bM3ezXzIqqEfaySl0Ur79FJSyJc68XPHwjZ4sAh/8e88M+ikf2UDG2cOZOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQwjh9xc+jatA1MrTL41k8qc4Kt3eZTuEfTdtSU/QHM=;
 b=YWWI1+ZMeL/7CtjSBR152DFTPlXHVjNzYcxsypjZhFQdlkoMtgpnaw6Fk3ZW5IzahnT0YXTXfpAVrtvCrW36BfSyY1w1A66TWTde6PPRZgtufxjAJvlZ35ypHKjDChv7zAOLvzkBWKMywWK502bz19299r8kDvUZqxQkEgVnQ60V3xIWHI0UE+34506354O8ktuPS9oZcFsrTgbxmaq4HJpZpPNMm58/eswa/2GZGRBC0s0ZA18wQKX0tLclq8q6U6zqIEiNNhwATukSzPuwQpFQQvDwucAvqUCsvw6ik4/0qZIY9qVyuM7RU6yy+eXPzvc1jUHK3Hv/D6y2Kv4rxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQwjh9xc+jatA1MrTL41k8qc4Kt3eZTuEfTdtSU/QHM=;
 b=O+mPeB4tyWyUmgSgRvP5SF85Z6rG8/62HFu3rwrxWu+cNZ9fZN5j/gBm2dJu/Fr3bevJkqjMb+lr21AIJ8E6z6Rl3JhJAMDW+J36y9lMOUZEYKRGyHVwPHr+lATRw/nd2K4sUg/r6SJA0zZxlpayqrB6uuSDZCeOl/zUgM2+3u8=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 CH2PR04MB6572.namprd04.prod.outlook.com (2603:10b6:610:65::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.31; Tue, 14 Nov 2023 11:27:57 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::2975:deb1:a373:b88]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::2975:deb1:a373:b88%3]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 11:27:57 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Avri Altman <Avri.Altman@wdc.com>, Ulf Hansson <ulf.hansson@linaro.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC: Dominique Martinet <asmadeus@codewreck.org>
Subject: RE: [PATCH] mmc: core: Remove obsolete quirk for Sandisk cards
Thread-Topic: [PATCH] mmc: core: Remove obsolete quirk for Sandisk cards
Thread-Index: AQHaD9MMXQ+umPr9mkSJJUoaNY2GW7B5u1uQ
Date: Tue, 14 Nov 2023 11:27:56 +0000
Message-ID:
 <DM6PR04MB657548AE5354A08B125F973EFCB2A@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20231105102944.1974512-1-avri.altman@wdc.com>
In-Reply-To: <20231105102944.1974512-1-avri.altman@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|CH2PR04MB6572:EE_
x-ms-office365-filtering-correlation-id: c5ad1cdc-3e21-4325-d492-08dbe504c034
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 v8sJ6vsOLr+IiYybXT1A9iPz5tYxUWtX2zxyRzA7Rl5qVK4oMmunRbCyOCk5HgyakpNAd0jjyRLd06X+h6fpNuOAEwGnXpoFr5eaybjBEX1FpqnCy17tmwBR/B3dyUs7zpSIyPjIlZu81eFjMH+v+ky2Qy01gKNfOn7jnQ6VhXrjyMyresS9JSCRFLqueEVH3LLjMaY7pc9sw4zw6kvGp0G0T4W9AceE7VotDj+51AJf70Rl/2QlR1yVR9ZZxIoD2TPb06Gx/dcD7usKAULrMfiTWx+AAzdWGh02F22b8NpO5CKbrco3yY68lSLgCFraHyZ5ESsLUurzDqlEibQnKwfNzQI3K/PkIcQxEGRFN6l2EKmk6Ldm63kQEsOpipjT1IK+uLxWkL5OE6O6V/NDWRtDxjmYtf+9jsw42xnzPApid8jZekGzcyAaxUR7WEXVtRce8RaY2WrSnTGngcJgeMnwGgOvie5e+Iyz6jAafNsBGKDUzEo7vib3J/Fo4tm/U5PLzMWdb9aXZkJRiKejviC8TU6MiAJYWdM6ATTDhxDULtVWGxp+/duSRx2s9p7W7RyOMOs5jaJ8aXADgN6aq49nsqe86A2lKJPlCp1XzszOQdIxKaF+GW00fOiQS8j+
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(39860400002)(396003)(366004)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(83380400001)(26005)(122000001)(82960400001)(38100700002)(86362001)(33656002)(38070700009)(2906002)(41300700001)(55016003)(71200400001)(4326008)(8676002)(8936002)(478600001)(53546011)(6506007)(7696005)(52536014)(66476007)(64756008)(66946007)(76116006)(66446008)(66556008)(110136005)(316002)(5660300002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gAd2N2Y470722s8E4QjDGGSCyJo6+PGXpe05M7dJy64pGRqtLJQq1/9RU7XL?=
 =?us-ascii?Q?6MM3q4oSRwZOOmbNOUe9aWzCQRpspgVTCA1I9pdPMMGBf7MhS2KHfdQpunRM?=
 =?us-ascii?Q?eV9OZfAerNS+PFQvFOaPeie4W7w9RweTv0lWwKIHN3/NROFowt0Hz+X1oUbg?=
 =?us-ascii?Q?D4hKBBQ1lFQ64D856Xhvn/J8I4g9zFMGUDK//4mOpHeTp1+Ioft5KtVTNRxx?=
 =?us-ascii?Q?UBsZAd7CsqlmpU5lGxbiuSZKw2quAD5wvLZZIbxmjmZVbiyVbzYBfwlEyPgj?=
 =?us-ascii?Q?Aru+60j7mcycgUXYPk9ru5dLMJ/hf3hsSan/GLX06pYBzukvxEjKIV3TwxDg?=
 =?us-ascii?Q?RV6txABjtZyZBXckhmpPF6gmKdNwK1chHfg0HiT+Ne9LyslfAiF1FB5GJ0is?=
 =?us-ascii?Q?yOo0he5D3yS4NdBG9uXtYsn7cokVnfHgU+xPGk1Yn9hQmlt5Ud8O+4auc/sB?=
 =?us-ascii?Q?11/3D7v1tXfUZFI1b1nooGdt5Y6btd+R8JanciwNZtmWPpAn200RVG+NPKzg?=
 =?us-ascii?Q?06y23suAsfCLGmLlYFhEMbmMCA0SixEZAzEcVAjGK8k/L7+vANI1Vkc2DBHZ?=
 =?us-ascii?Q?QFN6AL5E/v0xl0NVyFNcCKdXtbTohRsaiDfC3TFSWIa/wM9fTwev6DJ19KM+?=
 =?us-ascii?Q?4wxeuhW9NSIOvXFBEGe1jGBqiVpo+W2gzytEkaMcBPjqRIYH1Tck2Frz63Qz?=
 =?us-ascii?Q?TUzsltsw35wG9GKO+JJBJlU1RIcTpHdem1E+w10bY9X3+4QDLBJnx3x67Fb9?=
 =?us-ascii?Q?fjKoFCpCWEVZzNHQ1e7Xqo0C+kCqbLImfVCTwILgrqh1UORx00yXBDxB2ycA?=
 =?us-ascii?Q?8Qre+15WgX3GJMEPkEIsMFMXEuqZEIW4NZXBlIc8HoHtOVvr/+3BuobwyGFJ?=
 =?us-ascii?Q?4I7U7DLNlTrOZP9nhaJaEIx8KUgu04Enq0XbT3h+KZQ0Et9n8FywSdqV64QT?=
 =?us-ascii?Q?C5oBhULg4f7lgAo5vtIy3VYQe0P8k476ZLPA0+v7+ZvzBaAUbP8BcsjmTIt3?=
 =?us-ascii?Q?1Kd8TCXgexigSDc2v6UpKQG3w2A4wMyPLa11MjZ6m+ctWg5YOKbx7o6N4zlW?=
 =?us-ascii?Q?r5M1rDckRHlUAA0ztPDb8N0DjQSqrZ4QRgCv3VidyRcVvJCSye6hO5UP3GfG?=
 =?us-ascii?Q?taybsWeW3ec43Dlz1VcHH8Xw90aWrnJJsQsUrkDfK/5xcyhqEmFQ4uatRyOC?=
 =?us-ascii?Q?fUq9bWvlTVpR8TWj225OcDcoX8luJ0Z2O+HnUUPiXKGUIOvSnHevCQQsOXHW?=
 =?us-ascii?Q?pZuAOX4NneYIU1FrZ/xlSEy9pbNlqh08fodCPSvN9i2gDkRsl2Vv0q/AjcfN?=
 =?us-ascii?Q?qwkilBA9iz3k1xGOgk1I9ubtcefNuw/J45rbuoDmu1Ag/GnV6a1zVihdQnya?=
 =?us-ascii?Q?PGMAowLACXlyVa8NcU3FeKmNCRC80DD/1XELCjdjquqqParf/R6GINi2iynp?=
 =?us-ascii?Q?k1Ttt7zmkbKNYLO4S6RsRtSnva+HZUy0q0TSwL0ORl2zIUMQkJZ/denQDKc5?=
 =?us-ascii?Q?Z4rGlpLVIg3rRMRrc+YZ9UfSiW5i7F8N1688AhrtNiUOYaEarp46q4VG78av?=
 =?us-ascii?Q?XSlpVsWKfVp5790uLk2BUY+Y5zvj2L0QKKjTNax5?=
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
	6xnvEKEFZxDc+m4ub/MKK//hKmCRcbUzukFVhMFqBGdd8lWBR0Kc5qf0D52ouVcifOF3BWLQ3mHxi861JVQtuGNc+XpoHSwHO9Slq3RmCdSOgKdv1JBfgFH680fLCldE62twqv2225/k41KKoReg4cVSFVriIGvtBtB3ky8UvEY8AZHwQs2Svk397zQy0GVTC+6Njb6FM3+OtHUrGtfL/25FIDVFlUTkw1fJh4TRPIQWCRaVc+riTqxSfaQc2eCWOVrGTLUMYtZFaBMSZqP+M+1OZHsX+U5qZgrxIPVhG6X75dU3ZzFCS/uDVVqnNNI2P1FA3VGS6NPyQHFV1YKlPLSrseAlGt3odMlHLDp+nACSD1b3Ne5sF4JusF3ybQhOKl2TPq4SiMiZs/YbuQ6w/Bl+j6U9JpSc2BTEI/zqDQAX0TaDnk7yLGoDjHLkSjMjobnGxCK88f2m4RpjTWj5Xm6z6WplbAIf8AaWeSDNAw/HejQxZ+3WUX1AyUQG7aDn6e+/4U4NTvD2NSK4qxn3dOFDVu3VYXh9q0qlj4cil8MyTeJzBZcKeb8tnFzECoZbdCzsM76BIAMBv5R77dTVkibAWKuHWvN5bIOJezpiey5l3XPG1mK8xM6NljBNIZbSgJcaJun81bM7S48Awv1X6XUfyUlgETVdjdn63XqyeMV4vB9+eIbymxOLMLOSbm9luwrr6Zzre9PYazTh65E18TeCIJPjlLPoMzSHSDMtQ/vXUBi2TLG0uGlQ3AsyRHuZhDw/5QE6diDMDfB8ImEiFwQos7PTeekTvLcaNRv9EKRQqzNW5i8x6R0KEeqiFoYd75pVxWgI9e/U4ePaELxQoOwu1j90r6Eoi5/7pMJ/N+A=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5ad1cdc-3e21-4325-d492-08dbe504c034
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2023 11:27:56.9999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kH76Cu1W0ADiyNS3HjKtL/1wTTkZvUu4r5FrdKVJgHvkvK4Vk/cQYKqTlqhxTW2Ag3gyLS1ITpyH6NE0lUpPXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6572

Gentle ping.

Thanks,
Avri

> -----Original Message-----
> From: Avri Altman <avri.altman@wdc.com>
> Sent: Sunday, November 5, 2023 12:30 PM
> To: Ulf Hansson <ulf.hansson@linaro.org>; linux-mmc@vger.kernel.org
> Cc: Dominique Martinet <asmadeus@codewreck.org>; Avri Altman
> <Avri.Altman@wdc.com>
> Subject: [PATCH] mmc: core: Remove obsolete quirk for Sandisk cards
>=20
> This quirk applies to an old set of Sandisk cards that are no longer bein=
g sold
> for many years now, and it is vanishingly unlikely that will ever meet a =
V6.7
> kernel.
>=20
> I came across those old cards when I tried to decide what to do with Sand=
isk
> cards that their quirk is designated by OEM id. For many years we read
> wrong oemid, reading 16 bits instead of 8. Fixing it however, turned out =
to be
> impractical, and it's better that each eMMC vendor will handle its own
> devices.
>=20
> Signed-off-by: Avri Altman <avri.altman@wdc.com>
> ---
>  drivers/mmc/core/block.c  | 32 +-------------------------------
> drivers/mmc/core/quirks.h | 12 ------------  include/linux/mmc/card.h  | =
 1 -
>  3 files changed, 1 insertion(+), 44 deletions(-)
>=20
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c index
> 152dfe593c43..6aa68ac1129e 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -1122,17 +1122,7 @@ static void mmc_blk_issue_erase_rq(struct
> mmc_queue *mq, struct request *req,
>  	nr =3D blk_rq_sectors(req);
>=20
>  	do {
> -		err =3D 0;
> -		if (card->quirks & MMC_QUIRK_INAND_CMD38) {
> -			err =3D mmc_switch(card,
> EXT_CSD_CMD_SET_NORMAL,
> -					 INAND_CMD38_ARG_EXT_CSD,
> -					 erase_arg =3D=3D MMC_TRIM_ARG ?
> -					 INAND_CMD38_ARG_TRIM :
> -					 INAND_CMD38_ARG_ERASE,
> -					 card->ext_csd.generic_cmd6_time);
> -		}
> -		if (!err)
> -			err =3D mmc_erase(card, from, nr, erase_arg);
> +		err =3D mmc_erase(card, from, nr, erase_arg);
>  	} while (err =3D=3D -EIO && !mmc_blk_reset(md, card->host, type));
>  	if (err)
>  		status =3D BLK_STS_IOERR;
> @@ -1182,17 +1172,6 @@ static void mmc_blk_issue_secdiscard_rq(struct
> mmc_queue *mq,
>  		arg =3D MMC_SECURE_ERASE_ARG;
>=20
>  retry:
> -	if (card->quirks & MMC_QUIRK_INAND_CMD38) {
> -		err =3D mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> -				 INAND_CMD38_ARG_EXT_CSD,
> -				 arg =3D=3D MMC_SECURE_TRIM1_ARG ?
> -				 INAND_CMD38_ARG_SECTRIM1 :
> -				 INAND_CMD38_ARG_SECERASE,
> -				 card->ext_csd.generic_cmd6_time);
> -		if (err)
> -			goto out_retry;
> -	}
> -
>  	err =3D mmc_erase(card, from, nr, arg);
>  	if (err =3D=3D -EIO)
>  		goto out_retry;
> @@ -1202,15 +1181,6 @@ static void mmc_blk_issue_secdiscard_rq(struct
> mmc_queue *mq,
>  	}
>=20
>  	if (arg =3D=3D MMC_SECURE_TRIM1_ARG) {
> -		if (card->quirks & MMC_QUIRK_INAND_CMD38) {
> -			err =3D mmc_switch(card,
> EXT_CSD_CMD_SET_NORMAL,
> -					 INAND_CMD38_ARG_EXT_CSD,
> -					 INAND_CMD38_ARG_SECTRIM2,
> -					 card->ext_csd.generic_cmd6_time);
> -			if (err)
> -				goto out_retry;
> -		}
> -
>  		err =3D mmc_erase(card, from, nr,
> MMC_SECURE_TRIM2_ARG);
>  		if (err =3D=3D -EIO)
>  			goto out_retry;
> diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h index
> cca71867bc4a..028f55f07ba3 100644
> --- a/drivers/mmc/core/quirks.h
> +++ b/drivers/mmc/core/quirks.h
> @@ -22,18 +22,6 @@ static const struct mmc_fixup __maybe_unused
> mmc_blk_fixups[] =3D {  #define INAND_CMD38_ARG_SECERASE 0x80  #define
> INAND_CMD38_ARG_SECTRIM1 0x81  #define
> INAND_CMD38_ARG_SECTRIM2 0x88
> -	/* CMD38 argument is passed through EXT_CSD[113] */
> -	MMC_FIXUP("SEM02G", CID_MANFID_SANDISK, 0x100, add_quirk,
> -		  MMC_QUIRK_INAND_CMD38),
> -	MMC_FIXUP("SEM04G", CID_MANFID_SANDISK, 0x100, add_quirk,
> -		  MMC_QUIRK_INAND_CMD38),
> -	MMC_FIXUP("SEM08G", CID_MANFID_SANDISK, 0x100, add_quirk,
> -		  MMC_QUIRK_INAND_CMD38),
> -	MMC_FIXUP("SEM16G", CID_MANFID_SANDISK, 0x100, add_quirk,
> -		  MMC_QUIRK_INAND_CMD38),
> -	MMC_FIXUP("SEM32G", CID_MANFID_SANDISK, 0x100, add_quirk,
> -		  MMC_QUIRK_INAND_CMD38),
> -
>  	/*
>  	 * Some MMC cards experience performance degradation with
> CMD23
>  	 * instead of CMD12-bounded multiblock transfers. For now we'll diff
> --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h index
> 7b12eebc5586..edb27f3c6489 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -284,7 +284,6 @@ struct mmc_card {
>  						/* (missing CIA registers) */
>  #define MMC_QUIRK_NONSTD_FUNC_IF (1<<4)		/* SDIO card
> has nonstd function interfaces */
>  #define MMC_QUIRK_DISABLE_CD	(1<<5)		/* disconnect
> CD/DAT[3] resistor */
> -#define MMC_QUIRK_INAND_CMD38	(1<<6)		/* iNAND devices
> have broken CMD38 */
>  #define MMC_QUIRK_BLK_NO_CMD23	(1<<7)		/* Avoid
> CMD23 for regular multiblock */
>  #define MMC_QUIRK_BROKEN_BYTE_MODE_512 (1<<8)	/* Avoid
> sending 512 bytes in */
>  						/* byte mode */
> --
> 2.42.0

