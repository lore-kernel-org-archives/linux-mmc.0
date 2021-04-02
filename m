Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70CCBC433B4
	for <linux-mmc@archiver.kernel.org>; Fri,  2 Apr 2021 07:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43CE1610FC
	for <linux-mmc@archiver.kernel.org>; Fri,  2 Apr 2021 07:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234381AbhDBH7R (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 2 Apr 2021 03:59:17 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:15731 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233521AbhDBH7R (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Apr 2021 03:59:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1617350357; x=1648886357;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=NHI9Y3AtGg6kEerF6N8OrFGG1rDiYzZxPROc599GBQY=;
  b=M1f8GiM0RXQ1yanlrKpWalHOQ2LpYZUo5B9EPxUhP0N8RIdGBSJNbUIQ
   FmrlLbVsYfFr1qluLQ96xaL4Ls8FcOnwRvhuk1vypPgDHWp6tWUEkPu2L
   69IAV21Tg6n2cIjNkTmGJVNRbSMVd6rSj/9jYZdzutCUBI+HPAdW/dJMk
   0p1ODRuJ8RBu4ZJ2tljIywbTj6kXF+EVbKg1kT43/I9z6afUszZJPM1Va
   3qR+QzzTqeYX85Fi+mY5isptTeAzO8CvwrRwzbL0CFhsYBL0Rnoqi8Hx2
   tnfmJKevrcEQp+mBkxwIkssZBE+tHp4eBUfieDIIn4UXgY9juzAvrkoq8
   Q==;
IronPort-SDR: NpDGFG+CU3d/N20nYMPHwVrFW4MaWj5CeQQLQeYZYeELTAjVIjNCHa+vJFBWJ8IZo33LHViV5e
 TrRAu+HCaigV/GIltRdgiFDLPa8bzogBe7iZJq8WoU7UfRfhzj5XEESpnw/DTkRnw8mluBQqJO
 3x28yY5duAOcYM26eo9OH0qm9FrzOjMvo/E1r/G4pcC7yKCM7l9uDCsN7F1HfcM5nLO+lNCAT9
 MZXoO6LMIJjtf3oEdLSrFhItVb97aa5vPeRjrAwmyfitgQHEmefHUkbDCun+3U6wxcnzU6zcTz
 j0c=
X-IronPort-AV: E=Sophos;i="5.81,299,1610380800"; 
   d="scan'208";a="164645003"
Received: from mail-bn8nam11lp2172.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.172])
  by ob1.hgst.iphmx.com with ESMTP; 02 Apr 2021 15:59:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PbV5faUV/ATen0RB/H9mGCObYd6hhzafIeRcwNEC7QFkaVr7hp4MSUqvYl9ZmtmSnr1PDrr2/F1mhffnT66MGpRsQiXQUoUD3DYfqW63B2K8nUo20bBt+G+Ggmt6PJa1WpakAqKIf2cowy8Jgo7SNwj8jyhBNLaRL+uZ25zda/lQlXD7jM6+kT4B7H41R2w4c1fOWfXjn2y4SAEVnmPTjGnq/FcyaivblslEVTuEXNr9tn+FDkuZN+e/0quwSNS3frpxn2Ujzymb5/OIPXvIcdpeCvSnSRDufMwiGo20BkyOKfY4FkJI1Vpbgw4bL1qTobIUjhmX17k48/Vo3tG3vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QCHMO2n6lJigfwHjTdAQM/BTIS/rWfMyXR0ulpuoik4=;
 b=GMRRZPiF0rzbJOL6HPPk7Liq9MWvxcsoN3bSXd6VwhIPmRKj8HHEkkuHPXnIH9UkLvmYGfTcPL/vVkuBlrOfTfi+prSxjf37c0YMnwcs0rzXE6evBiHQNj8oAuKuSPsaWa8/5bi5X1ztcHxMUlniLwzbEG0Rui2Rr16if0jVZcXUUr4hSOwOlM04T+PkZnOPqVk+jtJR6P4geuz8PsCY4mSNAAJKHM0bopgPjDFfO891+tjMkmWHj335O5sRxi9rxuhsxpiN05/PENYIJxnJ2uQbLA2gxm08anpC5sAI3b9ph9leWTD8oiYXoG3D3RLZP4tZBsWVWx7IuyMiFGfKOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QCHMO2n6lJigfwHjTdAQM/BTIS/rWfMyXR0ulpuoik4=;
 b=I0gHlwG2xu4VAvTO4NuZrsuwA6DTf5W5SvPmiKu0NbYSX8agVVMCwy4btuDkCWuL+6byIc6RUT+Q+AfGC0fDeWaBuYKTve1RT8YPXxhRLmxv96XZ5FLM7BzTlrfIi4aWXU1eZfXpbiQuwgmhGAjsMzauFAlyScO9l4Ch0nkNxis=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM6PR04MB6511.namprd04.prod.outlook.com (2603:10b6:5:1bf::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.28; Fri, 2 Apr 2021 07:59:03 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ed2d:4ccc:f42b:9966]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ed2d:4ccc:f42b:9966%5]) with mapi id 15.20.3999.028; Fri, 2 Apr 2021
 07:59:03 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     "adrian.hunter@intel.com" <adrian.hunter@intel.com>
CC:     Avri Altman <Avri.Altman@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2] mmc: block: Update ext_csd.cache_ctrl if it was
 written
Thread-Topic: Re: [PATCH 2/2] mmc: block: Update ext_csd.cache_ctrl if it was
 written
Thread-Index: AdcnlcJuAix8gk3jTfmLpiIwwm98+w==
Date:   Fri, 2 Apr 2021 07:59:03 +0000
Message-ID: <DM6PR04MB65758767822B761D9B0A5A2BFC7A9@DM6PR04MB6575.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [77.138.4.172]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 934a20e8-911f-4aae-e5be-08d8f5ad2ecd
x-ms-traffictypediagnostic: DM6PR04MB6511:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB6511842DF3C07CB050064427FC7A9@DM6PR04MB6511.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aCCVF+hGqZwWEDesvLUPfEAO0DWdX1kYzvNBmYOaz31Add7wpwUb35kVU4Shm4CY+PEUz2yeXucL/R8c2sO65DqBEjlctaMv+COu7o29Uq+REwal2wWcK+zhf7drjJ6EF6gHKS3iEjrgR3qat9s7vizZsM7/JtVtnvKqf6vEMRD39YBIoHkIeIqAsif5a2qnAlZf73PtTOs2si9CVdIikexTXYmQMvcadnD1FRmagz9CrIzvAqr46oPsI0gM1DGcET51K4xKKHA223eCrhslzY679l7DpL2wyI1mBlKHg8XjFZ8crEarQNv+UFbWgEFuyz/Db81RlChvWwKXXErgQVcTlceAmZ+BavPqRMnd8MhsuCGPpzct2uqGJBouzT+7ddp1NpCdVM093IQz5XMWYma56YqFGEWZ+SAlPWRUIeiAqa6Q/Snqasiipfm/NfUiKS16HzkiQBTAsHlUZwr7yeEnsAgdGQcdfckRMLXqeCOA8ELkbBVYiCO8h7jWh2QAVV31JXh4t10HRadaSGqGh7UehxMJWOg7EmIkEzjPuVtCOP9hR3kWtg6iBN8ZjhZsSLPurH78Q7VzgKGz+gctKPjxd5tZ9c2AGRH2hK49VLtzF+4R50FohDBOKhpyVL8Q/As05PD1wkZeWR2SQ2suyKLgwKORpKmPgiWBkaudy/Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(6506007)(9686003)(86362001)(55016002)(66946007)(38100700001)(8936002)(15650500001)(8676002)(7696005)(83380400001)(26005)(478600001)(66556008)(316002)(66476007)(4326008)(71200400001)(52536014)(33656002)(186003)(66446008)(6916009)(5660300002)(4744005)(2906002)(64756008)(54906003)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Zrt4VcyHhf61vSbAAcziL+0X9uuwgprxrogcgiuaokrK0oL3Lo8rJtd8DKuc?=
 =?us-ascii?Q?MofjoF9QuCd3w7+4xGXPGPk/7RVu/F+g+RQeBpOz0nPtwqzB7Xqfg1A6/xKy?=
 =?us-ascii?Q?S0ZgonNEPaBO99ebezD73esRWTPvGxgSb/48dwFbJAMXkmiHU72WBqIEUjOY?=
 =?us-ascii?Q?U9dpalvCICxHoYeW6uNgbko7taMfMGs7PkJW7AArJgnoyumtfYee78sJK24K?=
 =?us-ascii?Q?z4hStshD276/li8UMUISVPrspay4gEkbEdcTLAlAOU6Rxhb05m749ei0VD6u?=
 =?us-ascii?Q?/bWR76cMd7NpOGbNKxBtK/aJo3lrXz+juSBSTs4HKt4J0rMBI1CzSTedZAuP?=
 =?us-ascii?Q?6qMkaLlg6FsQJvhnOh1sWlELOAeD9PGu46vdsziGQVTt+GxpxrJFB4uuH11r?=
 =?us-ascii?Q?DCG8dYzGDuFXtFq+gH9LXj08y8fgCq81u1fF0iutGR5uAdjQonHhZcmDu1zC?=
 =?us-ascii?Q?Afmck7agYCY0VLbhy3lNMkb8c+zraYqMcheWSukT8SD0pNN6sWZNB2NOV49C?=
 =?us-ascii?Q?JfG4UXH8+mu3Ss21dGSwt/R7j98TWoq8OVhlFn8ld85FqOpxEefOBT9v0klD?=
 =?us-ascii?Q?/8ZCaQmcLx7uvhVIF1P+wXHytkov0s3l9/eMsnAypdR+y35iPEgzyD+eNNtx?=
 =?us-ascii?Q?4LEwAN6v2Gzvhs/QUHbBEWfdPtE5iM/t8K76U6ZV6jEFTgV/niUAR6EnK8GD?=
 =?us-ascii?Q?bskOM5PxVBogv4PR3976YKCBusxipWuLaaXOlJa1qJdKSUzrHUbOt3t4q02K?=
 =?us-ascii?Q?75M0YTbA3lEgeCnHDA/yDBlNZM2lemUdvlIrhii5JNLvmu4Xw1osUESLSyC7?=
 =?us-ascii?Q?9JJULzGLpzgbrzpo0fBjvtckjhZnAJBOpfFcyqoz610YYPSjIaFWIi8F9uPv?=
 =?us-ascii?Q?lbTaj5JDZBxb/GthZpDJJDikQd0elyBptAATnp36rNTy6+efdxO/FOEvYAy6?=
 =?us-ascii?Q?s//dKEJy7pBW5PTPfrhEDe16Bj+v6e1n9/KR2c39lR1F+ggc2ADcC9qOhEwm?=
 =?us-ascii?Q?XdPSIOXPmy+0f/LZNKAkh5uuz4/Y8EggnYtERoa1b/YUZ1tC4BHP+pMlcUj4?=
 =?us-ascii?Q?194W6XPIdEf5i74R82wCBOVK5Cb7si0ekULeCXevvM8eOkejnrFsjdms7kDu?=
 =?us-ascii?Q?6pULKXRvHXVcNzctaM47GsMDZ3M5eHwM8SWMCAkPAzH2+FRXeBVXbi2/nZ0S?=
 =?us-ascii?Q?9oFpY0UO+ViqOQHclqrTNoSzrduHmhHgWVbCEICVjJQb2As87E+7nwpC5lS/?=
 =?us-ascii?Q?wVbyV4wcdSz/lWT3WFcaDE1yZhA/4azTL8CVHkWgj+8PKxO7dIeIz7kwXZpj?=
 =?us-ascii?Q?mBM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 934a20e8-911f-4aae-e5be-08d8f5ad2ecd
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2021 07:59:03.4984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hHKFGbBxKe+IMzAOSqSgQc1EgcNTBxCBxm3IJHN8P/30QUzQEzHcg25a4suregdMiVW6/cLMS+mkAMbSHvFDQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6511
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

>> @@ -571,6 +571,14 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *car=
d, struct mmc_blk_data *md,
>>  		main_md->part_curr =3D value & EXT_CSD_PART_CONFIG_ACC_MASK;
>>  	}
>> =20
>> +	/* Make sure to update CACHE_CTRL in case it was changed */

> It might be worth noting that the cache will get turned back
> on if the card is re-initialized, for example suspend/resume or
> hw reset in recovery.
Done.

Thanks,
Avri
