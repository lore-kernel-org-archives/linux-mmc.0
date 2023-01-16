Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481ECC54EBE
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Jan 2023 11:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjAPLKw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Jan 2023 06:10:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjAPLKv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Jan 2023 06:10:51 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F83C15565
        for <linux-mmc@vger.kernel.org>; Mon, 16 Jan 2023 03:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673867450; x=1705403450;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gxCKn1F1vWw7/INNfUQCP5X4Ol/DtFLg2zcflizVkDY=;
  b=bcWpNQkdckKcW1EiIro/ZghIC1VdSOqGlA/LGHi4JWdswtN0GDHbVA9x
   w8vzie2ARPVpfegX4NKhsiDA/9plcnRr4XaGIwvhFXWRkFE1rawiUwvM2
   TDaWgEtndpdkbDkRbK5cOyms6y2Eu8P8jqmBxbxy9gHveRS7chy1lu/iW
   pXkt4lqL9uyYCvoOL/yrhVVRqU+Nvkmgkw0OJNF1icG8G0C8i9UaX8ufU
   RB5YjI3eUTnWj154PpJ2Qcke+SKe9go8R6ECloUbrw3/9QXQXfP6NjNEf
   oglxwjwT/Nh59hqfl/dzR362tgE23GmLTz9a/PstiEjc/uqERxFmTuC9h
   w==;
X-IronPort-AV: E=Sophos;i="5.97,220,1669046400"; 
   d="scan'208";a="332915735"
Received: from mail-co1nam11lp2169.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.169])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jan 2023 19:10:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CxtiRhTnRSp5Zb7POpVFpo3H+H4apyu9N0fgpsqojS/OP5JPVVKZ21nCoPDhakTfwTyJ3jeUqqRw4aSakVT9/ZuG/sgN2t+hYCtv0YVrueRo6cbyqBeXvRzFWGhFw0aAiQepEgIOrfLGjDDnpC871fYTp3g3729DjYsTjnKJ2vtPrRBfDwOSIL1Zv8SnY9N3cILDOOAp9gBn1FU5uMQNQvzzpV1IgCNs8OSjS/xXRsImDPxwDhJObpN1FqS47cN3mD0+npO4AMbeUkjhCYL8iOveP/4tNhby/MJ25YM19Q+OcDoFEx43KEi3DHRox4Mm3Iovx5U3gliI+Dz3d4c3Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CSUREzJDjh1otvjEMThTNuRQWVALUami5lDeWAdjp/k=;
 b=ahv5s7bQU1vNewTk55kKjXfmVKR7cM0LvNnCdveP32dc6pr4KNmecRnqkDOk93sUuyoFj8STFm7c0aK6eZeapVsiRyhgj0JG6AlUzxW9wWMjnwIeiwEBjZN8jH91lHLm+xrIcDc2B0DnLj+kPrz6rf8ECa+VxGw1cG8FLwsGpZ7tMRc6DCZZT7pM44gQKyOyFc8YM1REECjgnisjm5pQWjW3Q9BeaLmcgv0nml/am6X43bVs8O4tbKjZutD33bwO4Ct8BuhlpBGcZu5i7i3qf3gLlfzxZxFPaBbq7uNDCIy7ykWTa/oV3Ke/ouyXvxOD8F9hW5oh6Y3yvInEnQwAtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CSUREzJDjh1otvjEMThTNuRQWVALUami5lDeWAdjp/k=;
 b=wBMQncednC/onnhlng6Zgo7aXW+yKQbmJZEXYXP/qqMJtQ+Abaf00QlpPMBD3gxCkTFvOxdjTQ+K5QyV8Hxxva26ltNmS/ReZ8W9n/9QwAYwWME6dPx0wNPX/4LKpHgWFaGT3HRqbMCTl9EEphtjIlMHfsZjRqb9rdVdKtM621k=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BN7PR04MB4292.namprd04.prod.outlook.com (2603:10b6:406:f9::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.13; Mon, 16 Jan 2023 11:10:46 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ee92:8a0e:803f:4244]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ee92:8a0e:803f:4244%9]) with mapi id 15.20.6002.013; Mon, 16 Jan 2023
 11:10:46 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Subject: RE: [PATCH] mmc-utils: Add basic erase error check
Thread-Topic: [PATCH] mmc-utils: Add basic erase error check
Thread-Index: Adkpl/E2+lfqWaqoRjW6JCz99hAaIgAAp6Gg
Date:   Mon, 16 Jan 2023 11:10:46 +0000
Message-ID: <DM6PR04MB657535FA91E092E57EA87BB7FCC19@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <ca4d29de093e4e29a2222c4d94a9367f@hyperstone.com>
In-Reply-To: <ca4d29de093e4e29a2222c4d94a9367f@hyperstone.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|BN7PR04MB4292:EE_
x-ms-office365-filtering-correlation-id: 34e18ae1-3185-4895-601a-08daf7b25101
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J95dt3FyjS/MwSYsVAnJ58eH1gWk/Ak5H+mUdkXQGOvzSr+wTIHH2BrHGrYEOEnNk0YXmIK1fTivb11eoInZLudwjU9W0hP/goYPAmcqu1WD9JEkykw+j3aOgZEEauJkOWXA/qh+nFhulTh0mXz5vZTW7SV/4//U1jREXXd4cZbjd8bqyaWMmaOHtu+LDTZIoPpB9zNuFqeY0qWrxHRzU8Vmi1k9s+l2jD7WLMYqpCpWClvNE9h9eHWjcqBT3B0o6dT8jt+5XsOBlAmqF0HMETrDPZe92evOAiKF/wbRmaNBuaeNZdXOQLLpOj8MmYSa+efXfIcgMZM0R9cRyuK2coCRVj65a57ZhzQaXIcVGw3CXSl5VQPvZ2rRDtoQW3OT5jjZLDmKCRw49NMmsajjmd3ysLqnyGYtEvvDLKZfcA6MbrbXq9DipAszhBx+NP8UX7MU6gaR8sdjXPvJaOO+pQAby9g3mZVcoWYQ1fB2CGDIK6xpGjxzRvb6o0T6OUDDYFN03vVS8EXNvyH042JEKqzyeUNgQ7HBNDlfp6zPsm18vP1mJwtw7RQUHiUCkalTxxWTbPgvnGlA1/DerhjMjVY03p6gx9I9dOPX6GiCMoRv3fdNCFFJoJRaibVeRvgQOjQA1lS13KVcJObUJJmVEbnOpzFcaqxanBwj7QNS0DbvDvKEQAEKTF9MPd+88AuA875SJ5MSzgnxnyOzqOJQxA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(396003)(366004)(39860400002)(376002)(451199015)(6506007)(2906002)(76116006)(5660300002)(8676002)(52536014)(83380400001)(8936002)(122000001)(64756008)(9686003)(66446008)(4326008)(38100700002)(33656002)(82960400001)(41300700001)(38070700005)(478600001)(7696005)(66556008)(66476007)(186003)(26005)(66946007)(55016003)(86362001)(71200400001)(316002)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?rRYzMPh7cwbbfLhrP18mRRzGXnPlR4p5gK3ZYXmAnmGc+pLAQnrIO8gEZK?=
 =?iso-8859-1?Q?QfrIH/WkP8IF3fq2VQ1M+2a1eoSR040LpPGI9U8VFadpPzQMCKMZ6VXvQB?=
 =?iso-8859-1?Q?BLjyBleJwzryWcSH1825pjBfC/d4vYNPjVMu+aKirPtDzpVglNdkEeE4CX?=
 =?iso-8859-1?Q?4H4CIVX8CK3NgmKmAlpIsKXNJ5x7nmJY6XutIP6CWL23JZ58lJVVNto/Fg?=
 =?iso-8859-1?Q?I0hPe0POKou8xQUPKiy7UGam90y0heG19d7/fyjf3ZjGh529WLB3NfmoD+?=
 =?iso-8859-1?Q?ooMcZfGnO8jLYlTKrRmS9xEBBjEmOJp1zL8bcqvm9IEHeIFqf4pmYdbobV?=
 =?iso-8859-1?Q?m0MyyrX0yMblf5/PgfTlrfj4J7hBk+vuQKLGLVCC9Vfa9Po0PaMRsps7mv?=
 =?iso-8859-1?Q?blZGEN3la8PBJxK+TqI6Wi0a3Okt2eqhPII3K5YI0WKn73zIavg5kvgZJL?=
 =?iso-8859-1?Q?EwgZZA/vYJiuW2Zr1ffM+y8ZH5YkrF+OC9uq3IHofPlFqMi0LS0bi7UpT8?=
 =?iso-8859-1?Q?VQ47c29917sMba0XR9RYrDS8fHQ7mc1wxGmlWPz60eMvlpfOsXlDruTyNz?=
 =?iso-8859-1?Q?fztmMc4V1fERkNOChM06OxdvcUlgBJvLvWhZJ3tKEzLDSRvae+sZEgqNJd?=
 =?iso-8859-1?Q?Mtrj20wYPRq3OnY938nreY5JLm/yflY+HIHBsUSQrV3o3jZygN4w7gzkLU?=
 =?iso-8859-1?Q?aCExno6sRs5uuOpxA3RqY/qHyHFJpWz4HDxVsX9TqmAlqbZ189FXeom7xL?=
 =?iso-8859-1?Q?GbeNorg66K7no9hwcyQQaajy2EITHA8QZSC6i8tlsjWvxqgG3NxdsPBDzq?=
 =?iso-8859-1?Q?VSTc026HKwQ+vDVIhcWupZYJv3VwAMGbQjRU7KLyTKSOsn+lg+RUFrcabR?=
 =?iso-8859-1?Q?V25nAWHN3fm6WBb1/apZeKg1CLSTjWlfQtAKQBy9Zu4jcTg37OcuYkhIp/?=
 =?iso-8859-1?Q?46MxWZLp09jp2P9kZv2G023jCK4PdifTPyeox9t+4cv1V8uP7uSfycd3N2?=
 =?iso-8859-1?Q?sbagI6WB6z9uKhD3VwsZmkUXPmw/dVBXGqfdVAJ9RiTS4RL+yUZajUcifP?=
 =?iso-8859-1?Q?Ubm2In4pfFgVPDPhQ2lb5y8D5UE7Bosm4wzwzs+veEhH5TchnEDZHb/o/5?=
 =?iso-8859-1?Q?xMPOfQwecu+sM5Nci+EhtGlcTr/jkUN1lUYn7sR8dZh2UlbcWmB6ozK0Z1?=
 =?iso-8859-1?Q?ANIEt3fgHWJUNyu0W2VptjM4KqdyLb0aT3OgTFoXDfkVax9R71rwN0E6SZ?=
 =?iso-8859-1?Q?InUb0xeaGQz9qP985QuZPplVmif3vSCXAIqU9OEHl3bB7LyrtE050/kQvh?=
 =?iso-8859-1?Q?nQ+ATMH3aPw+8y49UBJUkNAShQJvDF/nPw3eTQn1ZJEsktLeczQc/5pI5J?=
 =?iso-8859-1?Q?4h0c2LAofxooQwz68q2ARXvJmBQzfTHjjuCVnZWacEYT7KE/jA11g2Z5oH?=
 =?iso-8859-1?Q?ts6/XN1x3+lXIxFFZhyicqB64Bf0v6QB65BhPTpvdUn5lahZEUpkSM+R+R?=
 =?iso-8859-1?Q?QT1amxo/XuRkscNfvMlLwCNBpKbzlBvA0eXaJ5QLk3bZLFDaSgYP9eMjCd?=
 =?iso-8859-1?Q?+0G4T+ZR2prkt2lKnfonu3T7wxkUEg4dgRMc7JlfJv8ygoxO2NgboVogaI?=
 =?iso-8859-1?Q?JcaBd4V5YNiFIqS3apVb4aZmITMNPDu2a3?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +McVgHZiF5Q1ZzwtcjInX6zQIIRO2bXh97uFS9c3gJiMlKkI5kJMV2kaeZPtk419S/mSZtJ0wIP7iIuatt7uWUb7EzrhGLm0yngY5ZtkZdDjdbsA6xbscl1wIdU7+S7w9kd1z7oCFSd6bWEDbiIaiFm8c0JpJ9NeP2ZuP2RzkZ0z7pe9mX+eB03jy3ZQDdgKzz9VA2/tEKVI5hOQI7xghfFHIO/aEDUIVYvPI3IKJw8Y28EJjwj+qRKTcJPb2rYe/lN5r0NRad6cR2SzsYBQnjp093S3XFlSXUn1t/zQcCLzdITwMNScxXQRIR6CotrAnvGuUeSZLV8educigY3ZRXSpbg0fYkIxM8tgeiEPx3lpx3khC6xrH/AoYB6f9wSK7HKbgof8EqXMm/MFHDQzyUHQ0iInUyOvvfMtQDp2kjWi1SEBaWoYZi2/9HYpVcyZ9tgF5NIBQoSsYBs7ZBm8FsXCAYKQEHXN3HJUJLctFXf6zSlw2X53bq1VQhCWW6EFlock4L6Y34ICUdEnSEt6jBPs9am8/fxXHIGsGObsGZ12JEOBuAWYElm24ZK2+JAV05kCJMb/pMgUPoRBxNJHjRtSqOTBFrqWCyjaBIEAnW6lO2Eu0ec+5QgkIh8OfabbnbANcua1saOeVSsrELIb+1Wnkhh/ps4/mTAtFH6Uy3qNnkcgwGqvNCmZ0nOeLwxV2MRTtlCLP4QrkdDbOo9urIqrYnhs66WfCuoVx3yLAnvk76QrS6STo1JIYP/YZ5rQYPt/7XIqCs0RNWjNH3XluR80gcIJ5Higl2AgOj9PN8+SqGD7YJyEOMGPN1a2Ult5t724eqUEhCb5AwbAqyoiQRXdQrl2LKoX7pcUDeiwZc0=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34e18ae1-3185-4895-601a-08daf7b25101
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2023 11:10:46.1318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 06dKM5Ls9+QHcrx/Ga7JgDA8sNjB1gx3UsZGN0Vbz+QU/AuDQo6WbOLh8xUCSlJfJKBtMom8JOx5YLdCc86J2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB4292
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


> Check for erase specific R1 errors so e.g. an OOR erase is not reported a=
s
> successful when it never executed.
>=20
> There could be checks for more error bits but R1_ERASE_SEQ_ERROR on
> CMD38 should catch all that are reported by hardware anyway.
>=20
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
> ---
> -v2: Remove unneeded error bit checking
>  mmc_cmds.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>=20
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index e6d3273..97fdb59 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -54,7 +54,6 @@
>  #define WPTYPE_PWRON 2
>  #define WPTYPE_PERM 3
>=20
> -
>  int read_extcsd(int fd, __u8 *ext_csd)
>  {
>         int ret =3D 0;
> @@ -2668,6 +2667,18 @@ static int erase(int dev_fd, __u32 argin, __u32 st=
art,
> __u32 end)
>         if (ret)
>                 perror("Erase multi-cmd ioctl");
>=20
> +       /* Does not work for SPI cards */
> +       if (multi_cmd->cmds[0].response[0] & R1_ERASE_PARAM) {
> +               fprintf(stderr, "Erase start response: 0x%08x\n",
> +                               multi_cmd->cmds[0].response[0]);
> +               ret =3D -EIO;
> +       }
Your concluding remark in your V1:
" I think ERASE_PARAM should be checked for CMD36, ERASE_SEQ_ERROR for CMD3=
8, I'm fine with removing ERASE_RESET check for the patch, it is caught at =
CMD38 ERASE_SEQ_ERROR anyway.
What do you say?"

But you are testing R1_ERASE_PARAM in CMD35?
Honestly, I don't really know, just want to verify that you changed your mi=
nd.

Thanks,
Avri

> +       if (multi_cmd->cmds[2].response[0] & R1_ERASE_SEQ_ERROR) {
> +               fprintf(stderr, "Erase response: 0x%08x\n",
> +                               multi_cmd->cmds[2].response[0]);
> +               ret =3D -EIO;
> +       }
> +
>         free(multi_cmd);
>         return ret;
>  }
> --
> 2.37.3
>=20
>=20
> Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz Managing Director:
> Dr. Jan Peter Berns.
> Commercial register of local courts: Freiburg HRB381782

