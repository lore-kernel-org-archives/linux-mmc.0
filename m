Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B8DEB64DD
	for <linux-mmc@archiver.kernel.org>; Thu, 13 Jul 2023 07:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234029AbjGMHNa (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 13 Jul 2023 03:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234010AbjGMHNa (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Jul 2023 03:13:30 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFDB1FCD
        for <linux-mmc@vger.kernel.org>; Thu, 13 Jul 2023 00:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1689232384; x=1720768384;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7IAewr722PZAkkP/YOAkU/BPsyCIPytwc9tYceQC4lU=;
  b=KE7bN+6HCvpuZrwlErXaRZcqRBHxvENIC/PJey6V0FPncgVwIA/h/UL5
   Uv8HmqLb3aaymRP38d3uxCJn69PiEh7FDeZfuzajnIdeN/ififOLmMQ1c
   7M3296eY651es5ZHp+W15BuxbVmsWEaLkZYn24NkDrZZKEoiOBUyWa2Uq
   wLtFJRRhIcvZzJzim8h5DJ1QfzS+qrtTvfqDqLNcJU++gQG1c4IDVIwSJ
   fm5/eG8RDfcOI7/UILl3m6RTIWNMpYoURYo16IpswRJvoerGfOmr3K86r
   1WVKZYy4XuOoBorfFiTFrk3bSLyhhrOnM8VYFfRwBkgzphZ3ewC9tv7Vm
   g==;
X-IronPort-AV: E=Sophos;i="6.01,202,1684771200"; 
   d="scan'208";a="242590539"
Received: from mail-bn7nam10lp2102.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.102])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jul 2023 15:12:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hsu/v1Bx9OdrT2kOJ5u50ORM9hXokXH+PfWZ8tzH2ivlynwuBd1i69KgyLakUno5R24ufOrkXq/bYEcPTGeQODpJAKtT17LxO9YiUb7e8PBJyMFrNB4dBVQ7oezaQLuTfp72FOD3J2qX2Mf6H9ULkVLVsTQq9NF64ydISFeLcORMdSTpvnkfCY8rvK6eGG3wiEEZUvWQkOqe+uB7X8wsy4PDhXAVK6BQwktsR0pD6FWCNMI9JlpRpHjUoY8bXgaZvzMGpGWYVk0MFRsmphPLXuG4+y7y7hAVv91Cd0gmKyDjzn+rkJuTIdr2aAp623K+dAzMDGysAOAaJ1hI5HsB6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OiUPKPrWCl2GDOPdv2bAyWTThN+qET97Is8o2KTM5V8=;
 b=WiqZ4Z734POQBbvdhEuTALqUXZ8Dr3L37TsHzrg6FjQ5L2eAiZYJ/aPsRrAjVmebe/RYXMCTIS+nMK1liywv7elayelcFx9LfMZmGNQCZPp/iQf7vAk0CIXDwfbWcdJNrv7eXBkIRX3YYXt6OcrtTtH0TDCX6rFN0WxWy909rdqczPkgk9jsAYy1GPvIyDtUocHEiOn19/xciHUd7TPipVMozP106ybI/C5wiSFlXwHnrOg8VmwlZVftSVEMueqMaL0/naAYhQdZY1DnCDUsn8gG4BBk9oakXcb8fIqKe6TMUDVn7K+0caBku3S2WoHj/OPHQlX4WZIX/ecD9li9KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OiUPKPrWCl2GDOPdv2bAyWTThN+qET97Is8o2KTM5V8=;
 b=JR4qGz2rF5Nw54C+xOg8dTcSR88I7gVMooZEx1gZOqSyNCnJ+3vzs3UYgRHCCKQXQeOPjaal972Uh6EHKz+WmHknz2r3aviJlzGOUQmAjea/ogNk3DLCyk5ObWghiP74VVbYq03mLkDSoBBAgJvGzHFgbWWF5tGWYZGo+6vDbwQ=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 MN2PR04MB6848.namprd04.prod.outlook.com (2603:10b6:208:1e0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Thu, 13 Jul
 2023 07:12:09 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::456e:ea7e:b4c:f106]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::456e:ea7e:b4c:f106%6]) with mapi id 15.20.6565.026; Thu, 13 Jul 2023
 07:12:09 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     "Bean Huo (beanhuo)" <beanhuo@micron.com>,
        Luca Porzio <lporzio@micron.com>,
        =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>,
        "Lund, Austin" <Austin.Lund@garmin.com>
Subject: RE: [PATCH 0/6] mmc-utils: ffu: ffu of large images
Thread-Topic: [PATCH 0/6] mmc-utils: ffu: ffu of large images
Thread-Index: AQHZp1EtSMOyXxsk6E6YLTBS69Nlba+sbEmwgAr3joA=
Date:   Thu, 13 Jul 2023 07:12:09 +0000
Message-ID: <DM6PR04MB657512541358BF3FE167B357FC37A@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20230625103814.105-1-avri.altman@wdc.com>
 <DM6PR04MB6575DD2CA332B275512EA281FC2CA@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB6575DD2CA332B275512EA281FC2CA@DM6PR04MB6575.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|MN2PR04MB6848:EE_
x-ms-office365-filtering-correlation-id: c075fe0b-5fdc-4019-6ebf-08db837078f7
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z6Bq7/hZUqFpjqrrQ5+YsbaSGNo80m9HhnK3xPH9Pcm/wsGAXpLBC/zd4mnD/ejixr0yzlx17XnfW2T73OExRx1QtISM7Z9P2nq131SQtsDSdJ347U7ZPXhZMF6oC4gygCGnDv59QMSzKGFNKLAMItvmtuT/f7AtYBkZcvgQqBqrLndenFgCqZgRX6k9+cLJCxOHmN6/9g6DsuBNr8r7gSE0ed2f0kqP4vfCYXOU7VgawFV8hnWqKXCyMdx1Qlz3BUvV1G5TBoxMSpfsOS/s5rrCKX8JLdlpess/uN9g/zI7tQjIH/cUHxvn7jCw09+N0IcvkC5flFppTLK/S0ZL+XcGWB7G2b6bwUGQyZpMJjjh46YCTJv53xY8pNCpDgXfRhDFzqkhHrpfDsUbRhC0bxaUPh5tO7ZxJegVMTZx/bV7+y6wsicmfeHg3KOoU739JN2OFOeDs259LwP00r/eah9tHaT9v82Nzo5YKdqXw6NHslxZPHmbXE62yNgwtwN9zRAfkCWf+8gI1L3GVruKp/4UKfD5zw8UiRoRze2EopO9hAMMOedLYyQLVn/GHb2DvGOWJSIQw8h8PmZVNOyn1Wc9kY5Oey4rMEPCyf1XGDWanCw9GbRlGXpHCJgoAGlA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(136003)(346002)(396003)(366004)(451199021)(86362001)(52536014)(8676002)(8936002)(5660300002)(33656002)(186003)(2906002)(83380400001)(26005)(53546011)(9686003)(122000001)(82960400001)(6506007)(55016003)(71200400001)(54906003)(110136005)(38100700002)(66946007)(66556008)(66476007)(7696005)(4326008)(66446008)(64756008)(478600001)(76116006)(38070700005)(316002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?fiwFBpRwBvC7BS1YkJ31bb7C5nJwVCWJ4Y5LHts2R6mIllaoTXJ+08q680?=
 =?iso-8859-1?Q?pFREuoSTlJTaGRRYaHKV4wnMb/Yu6mR6VqgQGanMk6v4i5IcfDC+zZeUDu?=
 =?iso-8859-1?Q?5jC6Q5V2pmmi9BUf/fS/NnFqU+6IeBBQRytzHx1fBvIevZ2c8ch8BgLCJw?=
 =?iso-8859-1?Q?8JVc2jrfrzh6k6BENLU39Rl0e4/mWykRHSl1FFEIdjQi7zEHjrbNpX59T1?=
 =?iso-8859-1?Q?GUKD6FqW62Vt8Ajrxz5U4+TTKk/NafNvXGZDxq4bI9jzgA8yVViRGQAuFr?=
 =?iso-8859-1?Q?jD9mJfPWLRr0Eda7By/5BrMLSVUSTWCdE+wQUwQxbQy1qmtRZBP13nGGlx?=
 =?iso-8859-1?Q?qexXOVJreL/7kaXQYfZwsCi1ujp7FV8aYHQt6s/6I7Olz5Oy3A+WBM/X8F?=
 =?iso-8859-1?Q?7TOSIXEYsWvv6jpL5rPWkLnehh4ED0qXM2Pmb/AyY/SOsIyuzBO0mrnyP+?=
 =?iso-8859-1?Q?V+BBuCMG5AfVPoj6NG1ytuyfIfyeP908x9+ZqfpgBKDVgZ+mfWXUmLQfxz?=
 =?iso-8859-1?Q?314IDl4N/ux2B0EIubG0F/01VInzOPH8nOlVoJE7e2qol5wNQkrR7cieq9?=
 =?iso-8859-1?Q?g/X2uaiFs2MtF1IZEFdabBS9Wg3D5o31J1kZojkuwBNhyN0cDDci/wIYlh?=
 =?iso-8859-1?Q?mEsF1VWNS3IDW1WvvcLxiwvtc1ah3GLupYZmcxmPaWCRAzqDzwsfefwfJB?=
 =?iso-8859-1?Q?uP4HOcSxSwCMPIpNk3LF2P2FrJhb/lbzP0KAVJP1z5zGAxHrfvRhI1fesP?=
 =?iso-8859-1?Q?6EDfOnMLTH0JEEvLswhjXC3nN4bfb/dW+8CO/aRj8YxGd2DFLKc6YBs3Vk?=
 =?iso-8859-1?Q?p7BpbUaJnF/qVlsavwZP8Bb1i/RtpYmtuiIgfAeX6iMI3lGi5O9YbIbLmO?=
 =?iso-8859-1?Q?wjSuoNSOdcziwx5Jk4UXycycElE2UYr2kbfO2gJns/g3yiw86LFz1m98i5?=
 =?iso-8859-1?Q?k/gmZ3VuZYLffWHANQNFNhtqfF15rBjhwPrfbSwkqTfOK1X9Dr/90rg10k?=
 =?iso-8859-1?Q?xBSHtFVKk8Y+1FMt8gX+xIPdtwX6uHXWaIiyfvden1IZrdRGJOlVHb4u4f?=
 =?iso-8859-1?Q?dig/OfOuj1UQcMcxc9HtRD+gXmNgjrf9JETxMA7JqFXZEnt6C8zXRZbeyv?=
 =?iso-8859-1?Q?Ad8I5ruELu7RZzlKEPdXnlky556nSEVXqcCHo/eFqWpw3jEmE7ARyOXDmt?=
 =?iso-8859-1?Q?852fOi7SSDA5r5yXMvR7h9/oH5dJ+YjHIhmi0MkwxQYBZAYzRvxW5qv7ql?=
 =?iso-8859-1?Q?4vc1HDL6UvzVQiPOKm25REyxZUSWl0mv7WWBW3YmZyEKIxslWeB/BpGBd8?=
 =?iso-8859-1?Q?N2lUgBdDsAdGKEpyq3Q3ZxqZ9AlCpGxcNDUhnS0AM/BUMtnQe/SCXzmXes?=
 =?iso-8859-1?Q?Vch5Ox7HWbAgmzuCAE494NoHGBD3wZgUPbN/D39ec0ikmU3UE6RkvGe1w6?=
 =?iso-8859-1?Q?5spjQCnJ0NNpbYPgqEmJ4nKDyg0/kUSUIai7yGVvarjTArKujR5e4hL3eV?=
 =?iso-8859-1?Q?K4TUxvM26I5AvFJCm+Jby1yIQINGfHmBdCf+dvB5CN2EwtQH9iMJ2neFOt?=
 =?iso-8859-1?Q?STnAHdw/A1WPTDrvV2OWuGqSxu+MOycCEQi2HCZe3nL9ytyy06AMePttlN?=
 =?iso-8859-1?Q?bGRijXCV+/zU5xgZ3bEQRJqQNulIt67ZIE?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mMyXI+P0aVahNY/hMme57Ow8mSkWL3RQGuvolSaKEXz4F5HgysAUThfU6+/Ih71CZLbO38TIEj0ulsBQCGVTz9WkP5yUezqLxISWnzj2wgBIKQDvkxJQLbp14DwXG9x3x9uhsyMsHOroMX5ta0IqHNCAx4+/TbuwtEoCS5qgLti7f6txtin5OXg93Lo0wWRge2oz5JqFwo6gAUSMirfz4tIaKWEBLbcl64f0fgs3lYCc1VgK8yMr709VNITCOvOYVYsi6Gb0aSOYDfNn5k78OdQMLPRnhCsUkxeVBiYZfiM1ozu1pLR3jT2I02UzxgwxDuVlJPwrki0udDyIDfm22q/6j5fgorW3VpfIF948hBGrxDLnOtSpW6Vkzk2B7wou1d4bw6aRrVX/uYFADYquzlcjOlBupFUeSq4xk8uL6EfYV2SgVjqxKyjFPzac7NKpVQFwurzN8RNcDUm5dn0s0EA+yWreuT/ygyvzXCOeAeAu3Jqn+OCm3eYLlLHtY3N0nwgN7J0qesmykdMoLw6K7O14qdi0VIzAIQAAOIYph3ADqdUNBtjcdAG75gZWwMmZ4rBrQFK8vlWYBP0Foi1/wGw5lY8lJUVnSVpEUsDZsLP0sy4j4grYEZWCqKEC9pyCp8OinjmEaC66ZLi6b4ZqBmEaNDLjlAi7JZRmDyDGd561zI1SUuiCOjz6cGE0tB/0gWEXSpnBJZKHB08Xh90ilMaS6BJUN0i967oI9kF3DMRfK4vVrMfbRYQ7FB3lIx2ShcCKcANugkRk2WL5h7f7I1MT+D8eYvgGV0yicoHP7x8pmumvyfYT3QdAyaMvnW2h8GHCNYGSmgE7mO4skvnIa+Ncz3PBCERzJK4vrQW+U1IR2ui2NbPDiRiQUcuYwtYv7c1wY8RySU+thwLY+APzYA==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c075fe0b-5fdc-4019-6ebf-08db837078f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2023 07:12:09.1739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3Lm1PeHLZ/wlru1fnPoFBmDJntW3HlKIeYzRgiS+Hl467JCH1cIa4sQht4KrTezam6i7aaf63hrgYH75Y5wevA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6848
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

> Hi,
> Would appreciate your comments.
A gentle ping.

Thanks,
Avri

>=20
> Thanks,
> Avri
>=20
> > -----Original Message-----
> > From: Avri Altman <avri.altman@wdc.com>
> > Sent: Sunday, June 25, 2023 1:38 PM
> > To: Ulf Hansson <ulf.hansson@linaro.org>; linux-mmc@vger.kernel.org
> > Cc: Avri Altman <Avri.Altman@wdc.com>
> > Subject: [PATCH 0/6] mmc-utils: ffu: ffu of large images
> >
> > ffu is done using a single multi-ioctl to carry the entire firmware
> > image. This is limiting the fw image size to be at most 512KB, as the
> > mmc driver restricts each single ioc data to be at most
> MMC_IOC_MAX_BYTES.
> >
> > The spec however, allows the fw image to be written using multiple
> > write commands. So if the fw image is larger than 512KB, split it into
> > a series of smaller chunks.
> >
> > Avri Altman (6):
> >   mmc-utils: Add fill_switch_cmd handler
> >   mmc-utils: Add arg argument to set_single_cmd
> >   mmc-utils: ffu: Simplify ext_csd bytes parsing
> >   mmc-utils: ffu: Add ffu multi-command set handler
> >   mmc-utils: ffu: Allow ffu of large images
> >   mmc-utils: ffu: Add optional chunk-size argument
> >
> >  mmc.c      |   6 +-
> >  mmc_cmds.c | 161
> > +++++++++++++++++++++++++++--------------------------
> >  2 files changed, 86 insertions(+), 81 deletions(-)
> >
> > --
> > 2.40.1

