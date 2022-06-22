Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5298FC43334
	for <linux-mmc@archiver.kernel.org>; Wed, 22 Jun 2022 17:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiFVRey (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 22 Jun 2022 13:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiFVRex (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Jun 2022 13:34:53 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40ED9326D8
        for <linux-mmc@vger.kernel.org>; Wed, 22 Jun 2022 10:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655919291; x=1687455291;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=veaOyaF1KKTEKSbPAuyGwSm8vC2nkGgHAtOeqV4YVlA=;
  b=ELxTyA56BbKG8DwZWMtroCVLzwkpz5qevGBP6OaXa7WeXSQGpTjbFYVb
   1yTSG9iuwUDVIlm439iAsNn40DGzObjjfEW1uxWtnDpr62Kknh4zFfGPH
   4+ffT+e+Kv2PolCHhMTtv/wuWqfjI5DiUbk2uk923Me2wSFqv3mCNwhWs
   G23Fc9ltSPQKf8qgRf9ffgwZ1R8C7+D1Uw0KeJWgBbwWbpNFZhfK8cvYZ
   SKS0oApX95bP8XGj0eRLtID+S/n0Up19L7tVruuxGCMPhr+f8cdwFE+YP
   2zXfefuM2quAkiptGxITSwPf87PUtNbu8KY0K8xbjLahORRFI4zY5Z8F3
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,212,1650902400"; 
   d="scan'208";a="202538968"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jun 2022 01:34:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eDhRvHt7OwL/7O+eoLm1Mu++fqbcpv+zJxENPAF4hBUMTnzvCWfcF2HqGZXDv+ayMYVRl3ZGBjgmX51rD2pRstIM4+eHr4aLN5cPmHhuKfyn9TewMlb4oINaHw6ukeLcdFHQgvrn7nfZf9ta4u7MJm5VnPFloWOAJq7LifF5KFKhB+KKY9pp3//Odyzw/IFn3Xm9bn7TOc2NuzyfgozV/AuH/qQIFPNTVUd17KTfik0E00ZZs78ppjbpMuKbP4mIElMQeIIxP82chqIoNUjBbhKogxciV0fjAr3tM9IKjmG3oDmlz0TZDn97Ysnb+rlS0sNbIbkaHjB8rmOr27BPOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VrwbWQCNmHxmQWz0bovazmYkvlKmTlpoRQab5kxsx2Y=;
 b=IWlmxYeCDRjNS63tLZSyNjQnAwr7y33sMY6C1ZzNcLHn+N8Vw+JY64TglbCV2Id2KYOQGCUazABI3euXjLD3R+bvtm6Wnskp9/BQ7UB4Sr6ClnJvNswjbCDdc7Rj0bUMDTA5BNM8gJrq8F3ZRh2q5fRw7fNJCp+iojQ2gTzGuQTxaEOPoyjSZ8JIoE/P/1zdxqIzTViIb2VpTI8tPDppF+WQqWuOu/x8xv76rmnU2xJg/GXa2ycRkrjZ7rMk7W98w9ZcT5hGU64X07sikyBhdd7r7gKdfStoQ4BU/QNu3QyFZY0IXru24s4LAjX7k2smG4+aw/o5HDga5kAqbcb7yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VrwbWQCNmHxmQWz0bovazmYkvlKmTlpoRQab5kxsx2Y=;
 b=gAO5h5WQbrL3WOIB13vpUF65I74n993DlTsTEM2UvhN1n2BN3FFuu61bIetIcntOQfD1W44bn51+oYVc0/Amh0zN5hWJKOjx8RjG4YKFX7HSUuMjBB0bC31cA0rQGDCmzqFKP5q86fNe1eDO2MeJU8zEnz2s+38JD8ZcO3CSQPs=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 SJ0PR04MB8307.namprd04.prod.outlook.com (2603:10b6:a03:3f3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Wed, 22 Jun
 2022 17:34:49 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5d26:82d8:6c89:9e31]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5d26:82d8:6c89:9e31%7]) with mapi id 15.20.5373.015; Wed, 22 Jun 2022
 17:34:49 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH] mmc-utils: dont divide CMD23 count by sector size
Thread-Topic: [PATCH] mmc-utils: dont divide CMD23 count by sector size
Thread-Index: AdiGG5pmW471gNuQTayLmad2s/EH8QAQibAA
Date:   Wed, 22 Jun 2022 17:34:49 +0000
Message-ID: <DM6PR04MB6575DB83541369E6B149216EFCB29@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <1b5d40da9b8948dc8e8f1b90ef75baab@hyperstone.com>
In-Reply-To: <1b5d40da9b8948dc8e8f1b90ef75baab@hyperstone.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a7e89d5-c116-43f6-ebda-08da547581fe
x-ms-traffictypediagnostic: SJ0PR04MB8307:EE_
x-microsoft-antispam-prvs: <SJ0PR04MB83079D409860831F046C22DCFCB29@SJ0PR04MB8307.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Nnu5CpkGwHjMIhyv3xXljoHWdwtMj3kDvqQTd+9/QOE39ZrIoGBDAW3fhuje8prpn7Vx2uJAcR/Cs4Ethvrbcmj4xKsMIPCvs8xffT2lSxw2naJp/Z4iUU1C6RFvqv8sxRqqaYKiSDgloy/71Ynz4s8Hb6LAFILiGkIwJmLpRHULJJ+c/fntW/7DkfCNS+4e2RQrRNhOpGUB4pWtR6E3pVC+gt6DWOj6W94UGcW3RDp3W4pCQEZRg9hMsEEm6PegDU34qDh4L7p3r5TV/qFTEe7ILZ7cC3ZN3726/Pw+kbbcCK8AiGun0dqT1zs4SS3PqU3dbVuIXYY6I/vrq5cgEg6J5H1uqwcjIr0d2Gq4QvHbkV318Omhzi9A6x8DXr67AAy2Bb6c39IZHr3I1YlYnG27P+oSlJ2h/hGphEBOx6Y8BOZJydhvNu/Wx9AV6695G8TifdSb+rt/wdsP28LC+hGbItWv7r9SKarh+/QV+G01T5pnMmaAFxx+9LRO9qVQGe4DwP2otFo57fCwkw4IySWn/T1yPYJP0HxPPuPssWfAjl4+kZHd05MiyxwqMJnAmQW1n9Lc72tIedO7stK4hcJfR+VPv1IGhNjH0C1GC06ogIVkPCSxQ9OU3LV1CRbt77IQUGD1jjw1QNx5pxQ2z305hAW1SPpzU7eoW/q1pxEJ0CSMgurkxzwGK3ravkFUtHTENKfWeJvjcSo8U9nYnulEp2Dmva5MPTTBf50HzW9wORoBKKRxaUrL/q8DQZ+2R7N/voqofHDVhTuERejhfKj6phOs0pj+Awqn/Pa9zLQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(366004)(376002)(39860400002)(346002)(2906002)(6506007)(9686003)(82960400001)(38100700002)(41300700001)(33656002)(7696005)(26005)(478600001)(38070700005)(83380400001)(186003)(66446008)(8676002)(122000001)(110136005)(5660300002)(66946007)(316002)(66476007)(64756008)(66556008)(76116006)(52536014)(71200400001)(8936002)(86362001)(55016003)(192303002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?FqNXzIJsm0n2jDXCSNecWYkuXinU7CyGe4S30SCxIcy5xj/SbY/W6AdA9t?=
 =?iso-8859-1?Q?uhFifLTTbgATVWTHn4wtOcuGEuzQV+qJS12dgDveIBPDSvP6Qu+wRKEfBZ?=
 =?iso-8859-1?Q?IcL0WLhT0TGqmOmQcpA7ehRcic24FEWHyl61bzp9N4q5+3/8YdjhgoBYX5?=
 =?iso-8859-1?Q?i1IghoZhShJUOy2ai5pbUjjK6T+B7mmA/LPy1/evGYU4h53cY+0e46BBJ8?=
 =?iso-8859-1?Q?HZEb2gv50QyPob0TMKDzbOihCK/tA3e7dBCEavhYIjDeK892pBJZY+uh1/?=
 =?iso-8859-1?Q?ndbBZHdKUvLffrzf8ChiUgqiJLSRJY0LaThmTwEmMqLmxeb11YZmeHe5TN?=
 =?iso-8859-1?Q?HEYESUo/ds/hMFwmiZzfW44TZFLmBxisxtzAclDGHHH/dEAkmZl1fsdaUh?=
 =?iso-8859-1?Q?WiJaDoo95MAH3qYsMU8sxdgcwYFarRNf061NdkMpMZz9+hPGa8PrqEJd8+?=
 =?iso-8859-1?Q?lghVx6QIaxwgdz6gXjaDe/mrzLI0jQY/Lce8MGxBO5sCb0HeDHEfdsCsoz?=
 =?iso-8859-1?Q?U85Sw9HAk+RRoaFuLQsUSHTLEvau9JwhZQ4ypHh9/MINl2UdWqzFXXMamL?=
 =?iso-8859-1?Q?yCSqkLaHSLcw9Lm5ROJxFvEFx3L0UasHdZpVcsrwT/L2W8aVcbhIsAWzSS?=
 =?iso-8859-1?Q?jUhbNDpV4Fe25Fk57MKWXLCVqT5kCgz2+lLhhz86qplAZLEAslYEvUa5+G?=
 =?iso-8859-1?Q?F3WD4w6kh/OpPdyu+7Uolp3p0k/kmIBlkjKtmciY9OzLQejfob5wKNu0MJ?=
 =?iso-8859-1?Q?g+As+JVBR3vgq9kkNAOQMFh79RqQvLojk/KfaZWQizgs3hym4W+V9wfxXY?=
 =?iso-8859-1?Q?riHkMVvpR/gnszTqaevjbbcLLrGGz2FS4utB9zVlzjHADQvEZQ08UgjCkR?=
 =?iso-8859-1?Q?879sWWdNuQLY63jhIRC+DGvwYXaSKUku/KzGcoEmkTf1rDmDpCyYlkWvQu?=
 =?iso-8859-1?Q?qPG/v8EW6l/o/78FAMWSbBjKDoIasqwlhD7y0NxeTuOroIPlAF9Pc6OvX7?=
 =?iso-8859-1?Q?szXYjcQsnL+ctCwrknU4qHQGDNf3ppaFRhwhmRq160m5+XAH752vkwEj+e?=
 =?iso-8859-1?Q?Gp6bkbzHLmmwarjoAe6abXFFLbBpQ/O1BkzXklm6M506BEiBD1jHiUyB/I?=
 =?iso-8859-1?Q?MhKAz4Ad+uaTaQ/lRI8sv78oNMcc6bITtqXYmsv72cM1DGEKk28uWj132p?=
 =?iso-8859-1?Q?MZIEGlW3f1PHGfkgjabqckExNVqpJNezFsUt+NigXjxy25eJc6FBrxLJsU?=
 =?iso-8859-1?Q?lDcP0OkjsVhM0L6zMX3GizJQiX+WAPyMXvREqCptqYIFBY39M0o6hRI4MO?=
 =?iso-8859-1?Q?11NCC7DMZ2uGx28ztUxGKsK7NW9E0b1Lc3vA6zPrdK3PVU8F8o06Pp8LqY?=
 =?iso-8859-1?Q?qgMSAuLQanSSDbN/C8rWTCgAl/IvDKNb6FtwaTdabeNcFvF1GaW1FB4gTc?=
 =?iso-8859-1?Q?+j4VRO2OROiU0dGLmd4v7Vuuq890XPbYnkpW0iE0grNYJl6BEuIMajzy2q?=
 =?iso-8859-1?Q?skBi+FC5dhZWURvM+T8n7SZsrhM5Ne03ZbUmXMSe5tGu3Nawbh6LCv1GhE?=
 =?iso-8859-1?Q?sydqK4shFSJjGbbSLqmS7SADCmblOskZ9imhaSeCBDLqJtgwUsVca3E6KQ?=
 =?iso-8859-1?Q?jKKqLnXLv55DpAnKe6nb1SzQuZMg4V8cCbkDGOI88crv9+5CXGfg9sf7aR?=
 =?iso-8859-1?Q?jop92yLOL/pz79S7NtpNIMI3viFPLvJzdjBcxime4m4zDJIXtUn0dSJpR1?=
 =?iso-8859-1?Q?JPegz6PCQfNEf/+66b47WgLRWktOnxVzt4gROBKMSqis43Dy9lg5KIwAeC?=
 =?iso-8859-1?Q?I/G27sj/XQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a7e89d5-c116-43f6-ebda-08da547581fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2022 17:34:49.4908
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pjrkFuhcyfzHuxukEiiBVJJ4oZB5w/8E+KFntuRZHIGon7RD1JvwYysGss3udB1YgCgtZapKGPdpG8xS4Y9cwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8307
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

dont
^^^^
Don't


> FFU used to divide the fw_size by native sector size.
> If native sector size is 4K the accesses need to be aligned
> and a multiple of 4K, other than that CMD23 SET_BLOCK_COUNT
> does not change.
I am not sure what are you fixing, aside of violating a spec requirement:
" Downloaded firmware bundle must be DATA_SECTOR_SIZE size aligned (interna=
l padding of the bundle might be required)."
So if the fw fluf is not sector-size aligned, you need to make it so.

Thanks,
Avri
>=20
> The previous handling lead to MMC_SET_BLOCK_COUNT setting
> a too small block count for the FFU fw_size.
> While at it also correct CMD25 blksz and blocks fields
> to reflect the actual transfer.
>=20
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
> ---
>  mmc_cmds.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>=20
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index bb0f022..048a0af 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -2768,7 +2768,6 @@ int do_ffu(int nargs, char **argv)
>         ssize_t chunk_size;
>         char *device;
>         struct mmc_ioc_multi_cmd *multi_cmd =3D NULL;
> -       __u32 blocks =3D 1;
>=20
>         if (nargs !=3D 3) {
>                 fprintf(stderr, "Usage: ffu <image name> </path/to/mmcblk=
X> \n");
> @@ -2826,15 +2825,13 @@ int do_ffu(int nargs, char **argv)
>                 goto out;
>         }
>=20
> +       /* ensure fw is multiple of native sector size */
>         sect_size =3D (ext_csd[EXT_CSD_DATA_SECTOR_SIZE] =3D=3D 0) ? 512 =
: 4096;
>         if (fw_size % sect_size) {
>                 fprintf(stderr, "Firmware data size (%jd) is not aligned!=
\n",
> (intmax_t)fw_size);
>                 goto out;
>         }
>=20
> -       /* calculate required fw blocks for CMD25 */
> -       blocks =3D fw_size / sect_size;
> -
>         /* set CMD ARG */
>         arg =3D ext_csd[EXT_CSD_FFU_ARG_0] |
>                 ext_csd[EXT_CSD_FFU_ARG_1] << 8 |
> @@ -2857,13 +2854,13 @@ int do_ffu(int nargs, char **argv)
>=20
>         /* send block count */
>         multi_cmd->cmds[1].opcode =3D MMC_SET_BLOCK_COUNT;
> -       multi_cmd->cmds[1].arg =3D blocks;
> +       multi_cmd->cmds[1].arg =3D fw_size;
>         multi_cmd->cmds[1].flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R1 |
> MMC_CMD_AC;
>=20
>         /* send image chunk */
>         multi_cmd->cmds[2].opcode =3D MMC_WRITE_MULTIPLE_BLOCK;
> -       multi_cmd->cmds[2].blksz =3D sect_size;
> -       multi_cmd->cmds[2].blocks =3D blocks;
> +       multi_cmd->cmds[2].blksz =3D fw_size;
> +       multi_cmd->cmds[2].blocks =3D 1;
>         multi_cmd->cmds[2].arg =3D arg;
>         multi_cmd->cmds[2].flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R1 |
> MMC_CMD_ADTC;
>         multi_cmd->cmds[2].write_flag =3D 1;
> --
> 2.36.1
> Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
> Managing Director: Dr. Jan Peter Berns.
> Commercial register of local courts: Freiburg HRB381782

