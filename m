Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0157DEB64D9
	for <linux-mmc@archiver.kernel.org>; Thu,  6 Jul 2023 07:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233352AbjGFHn5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 6 Jul 2023 03:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbjGFHn4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 6 Jul 2023 03:43:56 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2531C1BC9
        for <linux-mmc@vger.kernel.org>; Thu,  6 Jul 2023 00:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1688629435; x=1720165435;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=id4n759zUMae45Gx3k6WJ5owSNctAD71dOVoQYoIgo8=;
  b=fpfkDi0AEqP4xOvyWqV4gZn/LR/BclKPbWCyQqp5mS9Yy0paCKTRSDr2
   nl4Ydn9RP0ePgU9p63lmS71xyNzjOEUDI6K/+11tCjO5mFb+wDRZ3wc/8
   eerRh95ENmIsvMgqAvrafjxFK4cEqrEA1mhdj4gCuRp1a8MOwdCh8qEjs
   THopAUf09TV00y92cSXx369slShzz3/JkqXB4PZCj3MaHnnBOQHdSmrwL
   eEkKXs6psjz9z3pecTUtpF70Z1ZVvdFqeROSnqrX/FRAHco/zPmx/6Eq/
   zyPS1EGWg7AFPmEVr19QEP4+TvWL8Z/usJof3h8/lqXlFhNx4+zzlAxnd
   A==;
X-IronPort-AV: E=Sophos;i="6.01,185,1684771200"; 
   d="scan'208";a="342393453"
Received: from mail-mw2nam10lp2108.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.108])
  by ob1.hgst.iphmx.com with ESMTP; 06 Jul 2023 15:43:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EL5BUez6HY0Z19tf0pOszejIXBmWxnfBJ+6FykrI2ucIHFUhCmeMgUAISkXPMeHvb35PW25U3UXUlx9csdmY66VFoqe5pUkUvcyGZph3RSFYq9Kce+RCj9hesUPcnTYoQ1VMtrm+A69bppxCHe4n7lxmo578V3Umpk12lM1ObJOrLizg6YYhPYZE2bchSurKQGjB+uSV/1oF/L4e6AmH73a7JWT4Io3IIkH6GEr5CgGsM+ftY1u/rKkf7QHZa7jfz9rtHbF0N2xGoLNQvmZknRqBOerOrJKCjYtZx1ohPyC5NEPYkGmAxnygG/dygVf8TpqdRkEEbHi8cX8VC6Ncbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0PT/X0EVdMg9XC6/g+B3kEANUeNPG1CMZFEvfhbbOsU=;
 b=M0ZU87gQW1OsW007x2ODfJN2t2WCo0Lz3jY/exjf5xZu1fqf/qJ2GVXOWWankL34Gubr5dAswC0Ej2ctvOcRRWPl2VnB9kVI0xJCrnIl754wGfd80sSLrGvP0iQjwynV8SPvUTeQDiidTXG/zFxvEdwo7DfIjydKc37jAEJ17IN5WaJEuR8h2EziSU+lb1wKZ5BfyRTF6djnsoLYCAMrOd5U9VhJWPcJWiWMMEdVFomz5KKWm6VB6xYoD8hTrqde+2zM6YVqi0u0iJ05om3nTM4dBCZBmXSEOMC5SPo1NyPhDpKLQBoX3lOPPn+d8sfggBZl4fdoXzZY3ffgDl0+EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0PT/X0EVdMg9XC6/g+B3kEANUeNPG1CMZFEvfhbbOsU=;
 b=T72Dg7yaU+/RDQodBhRMZpl3+n1DbLMWhCEFY7TgNanttOo6zG0r6hpEJK0HAqkdUdlENpSbJws8PA+rDZdmenC2N30LWVWH+AWKgq0SAphAW0FolDh09MK8VIQ5wVhNe1VNxZ2JA7SInqZ0TDHPAaaB4lYaZhSA+hFDvYwEHkM=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 MW4PR04MB7380.namprd04.prod.outlook.com (2603:10b6:303:71::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.17; Thu, 6 Jul 2023 07:43:52 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::456e:ea7e:b4c:f106]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::456e:ea7e:b4c:f106%6]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 07:43:52 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Avri Altman <Avri.Altman@wdc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     "Bean Huo (beanhuo)" <beanhuo@micron.com>,
        Luca Porzio <lporzio@micron.com>,
        =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>,
        "Lund, Austin" <Austin.Lund@garmin.com>
Subject: RE: [PATCH 0/6] mmc-utils: ffu: ffu of large images
Thread-Topic: [PATCH 0/6] mmc-utils: ffu: ffu of large images
Thread-Index: AQHZp1EtSMOyXxsk6E6YLTBS69Nlba+sbEmw
Date:   Thu, 6 Jul 2023 07:43:51 +0000
Message-ID: <DM6PR04MB6575DD2CA332B275512EA281FC2CA@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20230625103814.105-1-avri.altman@wdc.com>
In-Reply-To: <20230625103814.105-1-avri.altman@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|MW4PR04MB7380:EE_
x-ms-office365-filtering-correlation-id: eddaab50-6a71-4e9d-5cd5-08db7df4be3d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n8OU6bASEoBsPrg0x9t6NQ/K5K+qPeEFgJ0kxOyapqxNzs/CbO5yzHfPTCJl6wgQxoMxnHpawBwSt2JYHYA3bgEE5Dh4u6FRuek3wDzPIS3dCaJHepaJ8Q4uF1VQiXxFcmnJrKllYIxLnIMwtXw/cY57apjAXVUyrCwMU1JjxHplJpO81AFFkaO9MuqcqpoiUc73N7t6PXfOe+EtiIfsoAzH8E7Hz8pJK4cJt4ih0I5M4qWQ/RaVx8U64rqBjqlVUE8e1d5LwvFVmpiZSbpnt59I2gpnzy6ao6rCgBHpc9eCIU9FLwF6lwrpuxOeFTPSlaF5+sthhJ39olWoqCJDlZpaJ6Ce+NNc9khacuMzCDVnYkoh9dT72p5JWBcECRlwjQKeraQ3VBt2HcvcUd8j4eyZgqyV0VltXlCR+mFCLTcTAtptHIxBg4G+y+DhDJShr5YFds64wyA8qrlDjAApuqbyywxrJryPBV3hRwh/s6UpdheOs0XlAstbgBJ7tbcP5A2lyY78+UyzxUVj/xgj4g/yJoN3R9SHUb1ItuofOMepq9WH36zLV06UwlQ9KiejGUjECGj2MQZFJbwEVl6LdqbvJ3vwonrhTWcyayBT4rhp8eaZuTH2Kx5w2nscv18O
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(451199021)(7696005)(71200400001)(478600001)(110136005)(54906003)(76116006)(83380400001)(33656002)(86362001)(38070700005)(55016003)(66946007)(2906002)(53546011)(9686003)(26005)(6506007)(186003)(38100700002)(122000001)(66446008)(64756008)(82960400001)(4326008)(316002)(66476007)(66556008)(41300700001)(5660300002)(8936002)(8676002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?AJSY2SZx/zrBWqm14FqiacKDGzVjuuLa/Vkdr95WejFLXYT07zvKWs1MUK?=
 =?iso-8859-1?Q?XHVMu7SPoiJuN4KPwvH3drqSppMbw1+wbbiuXLvh3e01JJzZBZ5dWDSQ7d?=
 =?iso-8859-1?Q?EtRQ1gYuZ77KWrvm5iPcQzxqxFq7VTbnBqLHc/og42JYeILNsPQ5/6ko6P?=
 =?iso-8859-1?Q?nWhki5VsxbFp97k3TcsDTbZpWmT/VoCL4kcD2DgUeyOcKigKRZJrqPgAhj?=
 =?iso-8859-1?Q?4vlbSIJBps1xWjpmTlpgqZR79bh2XhGInUAGGRx2C0k2Tzhx+8Q9qz05O7?=
 =?iso-8859-1?Q?22VmmfqHHncC0ROe7dT4gUNTXCCDDQekRw630+TeY23x4Z/qxG8lo5HU6E?=
 =?iso-8859-1?Q?BMglgOx244PLnFmhlrekn3/9vJR0AM2316r20ovqaiH+TrvlvIRQqlC+wY?=
 =?iso-8859-1?Q?yPwZbjdl9NSLQPKJ8YrrlRJ2R79eXrkgSFhvBsTEPZXzzbhZxqjnxIDAzW?=
 =?iso-8859-1?Q?FlpxeHJQgHCaHuBUFf8PH43QGfEdzkooHNQwqnR00FTdSCfwp2TQy4BKAO?=
 =?iso-8859-1?Q?gCFdwEoiCkGuXbn5fAGEcv7qGog8kAgQADeYGAeefHXzs3FK5GpebtkcSX?=
 =?iso-8859-1?Q?1QjKEU4pPCabzoe1Qglc0CO3ALcufcNsiHw3Ev/WAQDP7l70Ym0zKvvDhn?=
 =?iso-8859-1?Q?1dDJfM8qA+mqfgDXIwOLCoiJCXJnIoVrZQ4dmQh42JNHp5HH10kuJqLLRD?=
 =?iso-8859-1?Q?QfFcgFVKwnlw2WgGsnI1i/ywcEWKbHcNj+K3m8jNd929YohMk/YwbAugMn?=
 =?iso-8859-1?Q?f/AqEeTBlOeoBen5u0xS8A9khPyDHFBsg/uQ7S6YV/gW0bBbXNGqx68j9q?=
 =?iso-8859-1?Q?yQmExNX1sf+xdVC/kfe4/1dvBigrgAQtMyvhXFjB2WnScgDo+Zw8wD/JEI?=
 =?iso-8859-1?Q?s2o8pidBYXs9KYSdher+GJVsZTEuEHFAGzGltLe7ohVtRlsj83LxSHYEH7?=
 =?iso-8859-1?Q?Yb5zODc17SliqUqmbbguxdYIEZBbVlpXCm97nOxcbPOPkv3hG0Wv58A2zS?=
 =?iso-8859-1?Q?LuVIjOjPQPrfMZVarn8fvZA0vA57hO20k+t8h4WaZYiKsagGntQcUzXeJl?=
 =?iso-8859-1?Q?xVZfezSvIuB+luxttYLIZ4OFb3jHS4itBVXt81Di0CxQh768sid1Xl+DIe?=
 =?iso-8859-1?Q?yfeDIokDEG4eg57HCQWgbrnhpSU5xtWqnBfDyP6pUQRRKfaKi2MUEIn+rI?=
 =?iso-8859-1?Q?GfBP5XguF16v2MitMOBdF58x9F0Lev4FHfPzetU4KQsBM1bOFJhp62WO6Z?=
 =?iso-8859-1?Q?/J64dQ+baIvtjNYUyoI0Z1Sme2rSSngjXWlW8gc2DYl9IvqdYlLApxK/Q4?=
 =?iso-8859-1?Q?6qTUFw5LT8h8Bpt0O+duooZFrKsm5k9jZ6naeutqeRpyLmU0pJov0i+0po?=
 =?iso-8859-1?Q?PSHSA+fHqbMq113ewE3BwQDFSUCkPAnu9V0qVdErm0PuK39OYaNsFvX13+?=
 =?iso-8859-1?Q?vlrguO6W1v2rWHE2axm6ML+MPIVBGSgjkdo4Wrbchs4fMs0sTnsUYKohPZ?=
 =?iso-8859-1?Q?hRIZUT3lqsl2hlTrOy6Oy4sWo9LrIG5BGGiKuwMA/WVyxdRbS5iyndxq8D?=
 =?iso-8859-1?Q?m1IzRIUr4UWUM/Qi9GnsGlTmJb0lAtuWRq7JbPskXszWFGvWkRsjcu8CyY?=
 =?iso-8859-1?Q?7Wu9dFB++IKuSC6sovb1O7B6KVaFoE+HrE?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Cu96vyqzqd9mpao/vRmIC3kDIpCqtk8Lvk85qigO8OahOIat7QwTYcUua9QVfI03J/UIXLel23wwh0t1e1+BCK9BEDySlnFkayHcJoy3FPomYkVGJBVP8p5lY4lHoHmFVNQ+UQpYxlJ7inzbhtLWe/Bk5WHxg5wbgTHCRZOVFs5DTs1sBGhLGK7dUURCzLzcfDFCoSFrU0FliSATUgd6wX7otBuBFwBVaNLm8+fLMEne+oDRQasswwFTa8ZyHGj+qILnHKtvACRSBNE2diLLYD8jU9yGhLI04KCCeCZMmV16UJ8+0xnVE2GXBpBkl5aWB/3Slfs0PwC5F+qUAt95HjE1oRFL2JnUgpyWabOpH7tt0BEj08ep6yTK2z0+ou3Co6ZjSKEqHYyUJD9WVU6SAztajurcgwEHP4FaG/ovR/6eGer+5Z5KSm/0niONy1mdRGEGF3UghsFk5CH8laJeObOSUwyopewypFElzRz6koe5ubX0hgUMOVbixYKDmJzSSspJxqlVZ5K8iEZuiP2vnjw3P9DcuMjZD1g3V7OGLbYWt1qRVR9Nnm00aEFHr3MK48EHlAS5WVKXmj2Og5/f8tw7O1wF2ugsvKZxdBMTuAqZxDTVFHpKFg4MsDmbeJrGNlUYj/Wr5Ey3Dr3H7jmAamG9iHN7SaaDsnr387CEYQd7nl3jN+LQWVMKQHoo2qMG2MC+AfsvpzX2AKrHDw4XUO7HHJQPk0eltQVKPJP0bb/esrhs1DgLzBwuaXTgkP3kpClRcUYT3aj5jy04UD89LRiaywdbUO0PB66845ZC21xUTSkCNByEwdSTJ0LSK7oXUo7IVcLfq6Kvvq3t5adTeduFxvytEOvx0R322RYfhoOb2L5N4OIYHSmjwaNMa5BqiwabUyhAGxpgneuATaSQyw==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eddaab50-6a71-4e9d-5cd5-08db7df4be3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 07:43:52.0114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ShPfaCLYw26ca5aPKvcd+Ji+dv61MyspJSukMf8rq2F6XNP0cAX9+0blY719s/6wJdIEpU0LlG71Y7xw92IGAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7380
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,
Would appreciate your comments.

Thanks,
Avri

> -----Original Message-----
> From: Avri Altman <avri.altman@wdc.com>
> Sent: Sunday, June 25, 2023 1:38 PM
> To: Ulf Hansson <ulf.hansson@linaro.org>; linux-mmc@vger.kernel.org
> Cc: Avri Altman <Avri.Altman@wdc.com>
> Subject: [PATCH 0/6] mmc-utils: ffu: ffu of large images
>=20
> ffu is done using a single multi-ioctl to carry the entire firmware image=
. This is
> limiting the fw image size to be at most 512KB, as the mmc driver restric=
ts
> each single ioc data to be at most MMC_IOC_MAX_BYTES.
>=20
> The spec however, allows the fw image to be written using multiple write
> commands. So if the fw image is larger than 512KB, split it into a series=
 of
> smaller chunks.
>=20
> Avri Altman (6):
>   mmc-utils: Add fill_switch_cmd handler
>   mmc-utils: Add arg argument to set_single_cmd
>   mmc-utils: ffu: Simplify ext_csd bytes parsing
>   mmc-utils: ffu: Add ffu multi-command set handler
>   mmc-utils: ffu: Allow ffu of large images
>   mmc-utils: ffu: Add optional chunk-size argument
>=20
>  mmc.c      |   6 +-
>  mmc_cmds.c | 161 +++++++++++++++++++++++++++--------------------------
>  2 files changed, 86 insertions(+), 81 deletions(-)
>=20
> --
> 2.40.1

