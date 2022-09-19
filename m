Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D34C54EE9
	for <linux-mmc@archiver.kernel.org>; Mon, 19 Sep 2022 10:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiISKOE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 19 Sep 2022 06:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiISKOC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Sep 2022 06:14:02 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75D11A3A3
        for <linux-mmc@vger.kernel.org>; Mon, 19 Sep 2022 03:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663582441; x=1695118441;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IMfyN8qtuavAK++FHc+a36pekMCkf1wma6b0Fo83qbo=;
  b=Do27UijsHTi/KceFlFR7Arj7M0f1qt36Tn8elqNEe3LBCXOlf00O+g4G
   Y9yYKUWJ46afV6fJQ2u+E2Jatj1Ztg9NIG+7OfcK6+mAAi1f2okFhtyoV
   6+Dc4sjW48NpGj5CiEG+cXQDh9Jwx++65T+U0YmVABtTi7Nz25KOlvOLF
   8nRnqZJmittXXE/KOlbW+dpT6LSNWte/6XlTTVz57X/pX+DNML7yUJ4AY
   rKThNX+ZOMngnB4Bf+XUzCzhIFCbHjupKxxsgFdl0L+VuItLi7PyPvVWU
   tUlVfvoYxJnWzYlnSqNI+uQ1+pek+ZoyXQwP1IU3Wu8NEfzGM6vOCY6JE
   A==;
X-IronPort-AV: E=Sophos;i="5.93,327,1654531200"; 
   d="scan'208";a="216874800"
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
  by ob1.hgst.iphmx.com with ESMTP; 19 Sep 2022 18:14:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cBchqf7pcJVpPHI4TjuKVNAAgXZlbx9o5sc3yIhgXM1SERmusQIpmQ3W1LLSUgbe+6VE/LuV+TRXtqjY+OY25sDB++qMKWuruCTmgSEsrhoupOTA0VmfB9uybg6sGUkxQULCKWYdBJx0tTdMT+WUX+VjJwgCbwqYZsInnHM+Jt2Xp3Ps3nyLYZwVL9a5MZFWpxvVELDVre1Lud1i6xrLvRFEjm1+7YMDo7VBN/Csw6GuyoamMFX49mYDxOwuGrOSpfA6YEOW60fAaWHTPhCeq8NnwJXLo/Lgd8dcTts1YLnY4xedf/5m/D9Q042VeIuPgCPszycYUYJMBFARRglgzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XoNG+vCVBvPaUdpQIN4IROLSqtRGmqUIfirqgefv45I=;
 b=J3WAOti1QgL2jWwuiP2NPW95CoqoexDQI83KDtZtoSoiZBl4HUtIUVoCFmLAFRbWzhmSxwfHKDT+FtinG2YkhIltMRxjs3AlGnSkYK+n7ZWEHRmYaNCRFpgL/3N9Ttzq4m4NYQYubE6mMk+/geeocBk4kxm2Pd7HU3RHFFqRuoJ+ho+z3gEsuC8CCKmn1drU2jxBQ+lMPh3uF+ROBHTQAB15gJbJM5HpIsj03YqDs5oSjA4KDzRAJ5pTfpvjIviBxVdfhYWhIfQvJ1FnxNnoeQ2CpZQCrHTFE2luZgNE44eUhWtF4cKC8usEPWo/GcV4/+L5cSUAeeAvxzGvvCo/Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XoNG+vCVBvPaUdpQIN4IROLSqtRGmqUIfirqgefv45I=;
 b=A7SbhPzVIj4vVrYOtKkdZiIc6+V9WnnXAPOD6T5kFpEdd+ctfroIJkLSL0Lvn77XvxGiSGsIH5Ie1+iBWle/o/RTxHFn+7SHkF8IBYTkoUrsOeZQHqLdbkn73wUTtORy/siUqtaepAwS/Ty1PJ69AIc9wtSD3lkPcae9pizMHuM=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 CO2PR04MB2294.namprd04.prod.outlook.com (2603:10b6:102:e::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.21; Mon, 19 Sep 2022 10:13:59 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::42e:55d7:bde5:5a7]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::42e:55d7:bde5:5a7%3]) with mapi id 15.20.5632.021; Mon, 19 Sep 2022
 10:13:58 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Giulio Benetti <giulio.benetti@benettiengineering.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     Arnd Bergmann <arnd@arndb.de>
Subject: RE: [PATCH v3] mmc-utils: fix warning on uninitialized 'cnt'
Thread-Topic: [PATCH v3] mmc-utils: fix warning on uninitialized 'cnt'
Thread-Index: AQHYy3o4EPRfpkk7oESRwSYqutHdV63mifJg
Date:   Mon, 19 Sep 2022 10:13:58 +0000
Message-ID: <DM6PR04MB657571ACF65611DFCC4B7E16FC4D9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <21dc5b78-c0e9-4664-83f9-1a6cbe76159f@www.fastmail.com>
 <20220918161751.1132590-1-giulio.benetti@benettiengineering.com>
In-Reply-To: <20220918161751.1132590-1-giulio.benetti@benettiengineering.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|CO2PR04MB2294:EE_
x-ms-office365-filtering-correlation-id: 075b300e-8a2c-4047-542e-08da9a27aaf9
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XAyESRxVfUQ3Cyw/VtKYs9fLzNYVDmvc75998L3L1LEgDwLvvRKuSI+v+APs7EHxaFUjXp4tsJCd+XgdnZwYAGrWkJURlKUE3SpFY15dVyzft/D4S9cHzkihAIxUSMi1v2ZE2HToLpvO3oRoF5B9R8K/3+V+HDVe8/l0FdpZN/WXZnJu7Rpy+bhm8Ma/73l2s+VFiI57gZw7868qeHCtK1qvtEfM3T3Y4nZ/c5ej493OYUKtDMaL5DDAfa9JXkJlvdbXixFOBqKQl3RppAGjQxOlJoIKU7ArdQTqAKeRqLvM3ZNrj0VLrtnAR5yTWdI2praFYV84MNvBfqY1iE2B49xuqD9MOW4ptnPGIJzSERrDe9K9UWfzF/52AG8zW0yfuue5mOV5wSa2Jy1hAFCPd6bLxJN5NDLhZsJ46lShvm+gNnlS3FzxvTJzPoDfqmL73eRQHSLRpYDZXqsYymTWOaiB4DB7zQ5IMBMrWUOehanpAVKQ2jnNSlX20gvZt7B6bqF4UGhKpFiIdF8NHrjLB5JizLZUhePUfQlN5y/kGbLVBJjUL5LM7FlGhbr2J3BnKMKKNp2bsLs8p0e3RJ/BVJ/52IgX/63rNL9E/XlhnSj77k2NE9A+ny3wfpRziL/cNf14WfshxIon5D+813ew0K9G83dD4hdOv+ydcx68Hi15Z82PaWXGB/mmm5Ps+RgcqRBtDoKGrXez1OoE5Yxg+w7uVG6Zqnlz4KwC18zMj1Fefq09Hqtr2Tm45PhFb/ZIfQ2IqD5J5vyrSttU92A3/w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(346002)(396003)(366004)(451199015)(9686003)(38100700002)(26005)(122000001)(82960400001)(55016003)(6506007)(64756008)(33656002)(8676002)(76116006)(4326008)(2906002)(38070700005)(66446008)(41300700001)(7696005)(186003)(5660300002)(478600001)(86362001)(8936002)(71200400001)(110136005)(66946007)(66556008)(66476007)(83380400001)(316002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2VrVUTbFrLl6gQN2JE9UxOFaMHgn07CfSjRmKtLPz2C6hykIzily0g+0Gswa?=
 =?us-ascii?Q?dMt4RxCFzXNIXLRl2x/gjVCW91TCiG42Cr3LNJliq6qy6aVaqCS4rG9GS84V?=
 =?us-ascii?Q?WLD92DQdYoSNIdmHEdKtxeM8xMZQ7ZCjcfTPNDRK+gEwaLHEcidkZP+TRAtH?=
 =?us-ascii?Q?V2iMRKiVj8nPXfbPOjC21UxdqsbgtqUJHM4zizNhdLgWEi8jMgDEuAA4IXM/?=
 =?us-ascii?Q?Irr3tJEQYbIGeRBHhuVmpjSguJqN7RI6XBgKYsevQrx4PdNRPGPDvNlkwhtP?=
 =?us-ascii?Q?zzCVoWZ2NGnPktlYkvrhsg/Uhv3SGL2S1i8hjEJb84dObWgdQNrYETzUdiP3?=
 =?us-ascii?Q?PdD9lu+Fuj99fNey+TiZAvSHU6Zwox14PmHMZw55BCUSzhSphYiurLpSgnZZ?=
 =?us-ascii?Q?VlGXhSqTgEjaSNTsbN12ySjXJ5//mkztnuKAS5cIJTrTtWVyB4KC3d5u4bUv?=
 =?us-ascii?Q?Gl3xyaogS8QC419UOtA7MOG/JqwMaiNz3XAvPR0igXaPRE4loNkqmNDlgqF3?=
 =?us-ascii?Q?KY2wYWuKi7ICRZLJAeAwsPz2+AHxvEEscKoV6dNwYMaAzW0Jm3IU8oNYYC8c?=
 =?us-ascii?Q?+vwnHYxzIEUnQRn8AHjMH2mU1zTR2lKD2gkWp5vGipT/EAQDwcLiI7OykuHS?=
 =?us-ascii?Q?7g+vIPxUX9F/KH0ONHC8ObZBh+WH7nWCHULkxlo9Z+g7l3Pqfj0g2zSVFLvv?=
 =?us-ascii?Q?QuEGpFhQlN7rgXqymqiys1A3tjVtBOtz5LVXftEhgYMlvwGs9U6HvDl94Fql?=
 =?us-ascii?Q?BB9capox19drN7MJ7hCTIT8NywpivmD5wYDOR0S7AFYl46nNDP2I7CupSuhC?=
 =?us-ascii?Q?3Z9NM47yWDskBgzbg57NN51lXDYeoDpat5+Xo+d9Ujx0+vmdVnvVc1cXIw74?=
 =?us-ascii?Q?T+CddqBGxsjKktQTTeeB3D6D0d2VKbbakbbZ/8BLXVoEw+7kPw8s6ydzvE8L?=
 =?us-ascii?Q?1565fP75J6UmE4ZLJMWp/ryPAmmTo+KjhHIDhw7M3u2M3R80rITcrvAAAMzp?=
 =?us-ascii?Q?hewH28HDLBalCUfz1ZIXVPpWaM2czQpqITRA9/IUyr82IpYT5gGf7I0D5njP?=
 =?us-ascii?Q?kryTrVlgN3QU++KyyLgyP8qGh8toE/4Uy59WkpH0JBwcL7VhN9KRR4at2Qfs?=
 =?us-ascii?Q?rv/JiyvN5wttdQkK5ggYvU3co2eC+pR3b9hVWFowU/m2qcdUf6gTd7K1vys1?=
 =?us-ascii?Q?9gVyDv43c+6jDSV9SbEvrVhL+xigATcAcU6C9uowvMcMTvDnjJ/mnBhm65Vg?=
 =?us-ascii?Q?DW4mNc/V6USqrkc+PMtc8yy+/VBaC/SiMzHkvJv3k0aa1JduS0WTYvpljJ6o?=
 =?us-ascii?Q?52CXY24IKmS+8oG1aIXY2GKGRj1hkqOUjLm4lxpPKX8k+yOVscCwdBAwLyNl?=
 =?us-ascii?Q?wofFTUQnEmebZFQL+qVqM+GSAcL0sOgK/7F78+oHy0VWHmn8EyvCznS1USdj?=
 =?us-ascii?Q?FIuspte4y2PcCcox+ZHohPe7UzrDM6CooLQ1jjXjS79aiUiJ/BLa9own2zNL?=
 =?us-ascii?Q?ISmGp0uMu5/FOWD3IzqdzaudqD0eTKh7jKkAsGRbj3KJ5Yl8Ycrav24Z0tGs?=
 =?us-ascii?Q?i44rhZw+f3QveTUXrHu0S8f3Wtfno39THGaBZnwr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 075b300e-8a2c-4047-542e-08da9a27aaf9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2022 10:13:58.8746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SPs4Hf3qxH3yhTc3s+aOLM7RJFTY+9DmrsxtcJE0R6hOKYTM3SW7onSZnbVdXjhpF15WiYHfNb2x13MBME4ddg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR04MB2294
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

> When building following warning shows up:
> ```
> In function '__bswap_32',
>     inlined from 'do_rpmb_write_block' at mmc_cmds.c:2293:27:
> /home/autobuild/autobuild/instance-15/output-1/host/aarch64-buildroot-
> linux-gnu/sysroot/usr/include/bits/byteswap.h:52:10: error: 'cnt' may be
> used uninitialized [-Werror=3Dmaybe-uninitialized]
>    52 |   return __builtin_bswap32 (__bsx);
>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~
> mmc_cmds.c: In function 'do_rpmb_write_block':
> mmc_cmds.c:2270:22: note: 'cnt' was declared here
> 2270 |         unsigned int cnt;
>       |                      ^~~
> cc1: all warnings being treated as errors ``` This is due to function
> rpmb_read_counter() that doesn't set its argument 'unsigned int *cnt' in =
all
> return points. So let's set *cnt to 0 in the return point that misses to =
initialize
> it.
>=20
> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>


> ---
> V1->V2:
> * prefix subject with 'mmc-utils:' as pointed by Avri Altman
> V2->V3:
> * add missing commit as pointed by Avri Altman
> * initialize pointer inside rpmb_read_counter() as suggested by Arnd
> Bergmann
> ---
>  mmc_cmds.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index 12b7802..4d203ef 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -2238,8 +2238,10 @@ int rpmb_read_counter(int dev_fd, unsigned int
> *cnt)
>         }
>=20
>         /* Check RPMB response */
> -       if (frame_out.result !=3D 0)
> +       if (frame_out.result !=3D 0) {
> +               *cnt =3D 0;
>                 return be16toh(frame_out.result);
> +       }
>=20
>         *cnt =3D be32toh(frame_out.write_counter);
>=20
> --
> 2.34.1

