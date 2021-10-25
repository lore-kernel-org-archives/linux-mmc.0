Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BECC433EF
	for <linux-mmc@archiver.kernel.org>; Mon, 25 Oct 2021 05:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1E3160EE9
	for <linux-mmc@archiver.kernel.org>; Mon, 25 Oct 2021 05:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbhJYFtA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 25 Oct 2021 01:49:00 -0400
Received: from mga02.intel.com ([134.134.136.20]:28714 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229499AbhJYFs7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 25 Oct 2021 01:48:59 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10147"; a="216739468"
X-IronPort-AV: E=Sophos;i="5.87,179,1631602800"; 
   d="scan'208";a="216739468"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2021 22:46:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,179,1631602800"; 
   d="scan'208";a="496630841"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga008.jf.intel.com with ESMTP; 24 Oct 2021 22:46:37 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Sun, 24 Oct 2021 22:46:37 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Sun, 24 Oct 2021 22:46:36 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Sun, 24 Oct 2021 22:46:36 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Sun, 24 Oct 2021 22:46:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZoFTYuLKE0FxJRcVCrRWUiR6XiHJjjtayZH4vjmbaG5/I+5QVbRgjDEyrKWiDbVESx8JAwIUI7aAqKbAHUhk/Ht8xDyLCpaK+j76jCcSzazGuhAxqGGp1JtCh448lXCsPvEDXO1UXZAm8oeX5YbzOc15dmjilxuN2BonNo1DWEwImzCxocS6b9pa6vHt32prQk7XXZFV7XF/Cm+8g6WKXALHzyXvv0B3L+MqPV8dzBw8Y8fnzhBQIailTCfXbDhBJfST4Yqs+1QqTDkZa/L8GeGAB2lcakLiZAB/SJf4qpM5oPQcl6oWrc+XJnbO+QQ3/LLU8m6jcIh9c0vgZptfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MULtSLIwCDphDvdMB7ttMPIF9iI/E+zP/dBCk2SWKPo=;
 b=SCNiV31zq6k2rQS4oHc9p9gwycuQecgCQ1Hv3DNClTZ0v/yhPwY2gPGl7bwWP1oADq8BeydQZVUeI8Vg9v+fgS0h4dVGe2VBlExgJ2de+d90x6sXisjJoAYopSxkXNHRiNHJUWe2lYHd1AqJKOwVme03CpJhLSOT8FI0p2PYHnZCLeo1bIboObgfBNICAL4gquPuY0FCYgRk/vRS1SrfHt0d2MHreAtZUnqJVlKQhvd0QuLTM40Mim18VQpUUxD+jiDNfPxQBL/gxmQGnGLhpZlUBnYR82FVflcYf6Vv/UYtuISvaqAtxNBJuP0c0Mw0uqFequ+AgXl5BGZAwd9FlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MULtSLIwCDphDvdMB7ttMPIF9iI/E+zP/dBCk2SWKPo=;
 b=OFeoEcWG8R0BvOiU3IMrgqSp2sEodQNZ1YqJDrr2vwXCK5bbAopIlRjUocjC8ZspZq6z7ovYoGtM4jY1rFx4+vfV+vq344g/s+JZLdYBCbFxL99+Cu0as9qxfnw1dtpoaKxR6LEB5UndnRZ34eAytSLS6yHlxOgF8FMnnhbYBpo=
Received: from DM6PR11MB3065.namprd11.prod.outlook.com (2603:10b6:5:72::15) by
 DM6PR11MB2811.namprd11.prod.outlook.com (2603:10b6:5:c8::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.20; Mon, 25 Oct 2021 05:46:29 +0000
Received: from DM6PR11MB3065.namprd11.prod.outlook.com
 ([fe80::ace2:ed94:516:31a7]) by DM6PR11MB3065.namprd11.prod.outlook.com
 ([fe80::ace2:ed94:516:31a7%4]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 05:46:29 +0000
From:   "A, Rashmi" <rashmi.a@intel.com>
To:     Vinod Koul <vkoul@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kishon <kishon@ti.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        Mark Gross <mgross@linux.intel.com>,
        "kris.pan@linux.intel.com" <kris.pan@linux.intel.com>,
        "Zhou, Furong" <furong.zhou@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "Vaidya, Mahesh R" <mahesh.r.vaidya@intel.com>,
        "Srikandan, Nandhini" <nandhini.srikandan@intel.com>
Subject: RE: [PATCH v2 0/4] Add support of eMMC PHY for Intel Thunder Bay
Thread-Topic: [PATCH v2 0/4] Add support of eMMC PHY for Intel Thunder Bay
Thread-Index: AQHXnQMuYeQydCD7LECFRtxjQUnwfKuje/GAgB8UJTCAAd8wgIAfGSXA
Date:   Mon, 25 Oct 2021 05:46:28 +0000
Message-ID: <DM6PR11MB30651D5F6C252EA70BAA43CE8C839@DM6PR11MB3065.namprd11.prod.outlook.com>
References: <20210829182443.30802-1-rashmi.a@intel.com>
 <CAPDyKFq2VQ=khYnmfsQGPPcpRnxyATVSpwKSZ4MTbKn64rthVA@mail.gmail.com>
 <DM6PR11MB306560AE06F83FC56B9F89988CAE9@DM6PR11MB3065.namprd11.prod.outlook.com>
 <YVwqVRkwAYnoJR6x@matsya>
In-Reply-To: <YVwqVRkwAYnoJR6x@matsya>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.6.200.16
dlp-product: dlpe-windows
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 07985191-a36d-440f-aa10-08d9977acac0
x-ms-traffictypediagnostic: DM6PR11MB2811:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM6PR11MB281151F58AA02706884E1E9D8C839@DM6PR11MB2811.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ngE7l13Z6xS7M3pvArBEMxPLLmbE8B/F3b4+Bk0XrPN/aWLHWyOwxpO+vI6y5QGFCoh3SStSrWAEwwIuCN76+T+V9IUAm4CMZOchaCWPwuAafX17KnTv8GqyRd5BUXPYNWAbnpYN/Ifklqm+Hv8YK8eGS4Y5NkAnp5JQkUb8BVKiK7LBtjO+En8eXHppILpk+MRjF1TC3DpIwbRrstkIPS6Ajp6wPmKg33NukaeT1IEAiozO5foB2tGqwdNN3pOuZD91a/9qiQ8/IrWDMzHm2Pvv0B3DSrdgdm2wDZ/yH3tcQ5+0F6zoiepnHOjC/iUV8M8PI8Ysp8lP1JE49BoIPOY+lDQy4DoBaJAp3skZ+dkmFbXiTYUj9tRf/NkB7c9Y2tQm7cgYxybp19yYCtTC++ex43LHO+qU1L9wlslc8HNGerfZNqkNKs9MENM7Ak2AGJBMF6azaTkiOv79RF8qLqyvAoH7qSyLyujaG/zRPPBx0D1KpIh+0jbV9Q3/8Cq86BgSe5+Zu677n4/4BVLzxxqTLnT+g6KuS8u0NZRZhtTNdVt2qKm/hqBDmBD+js4oJxP1l9P+Rj1ntmPBax18doEbrROWl7yVmXYSaGlKSnqCFO4zBVCuXY6pOfZT82miDiSvFZA+zKqAijZY8hR4bZI5v14vD4zmvmPbuw7q6kYJWwsB9Wa5YxbdqiKMU8BCZrJYzvwrumHMZ7aCsBFMQA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3065.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(54906003)(110136005)(86362001)(6506007)(55236004)(71200400001)(8936002)(38100700002)(53546011)(316002)(83380400001)(122000001)(82960400001)(7416002)(5660300002)(508600001)(186003)(8676002)(52536014)(9686003)(55016002)(38070700005)(4326008)(7696005)(2906002)(66476007)(66556008)(66446008)(76116006)(64756008)(66946007)(33656002)(4744005)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?p7VUuDHVAQM27czUm2NwxLhg0E2gmUkskKhXy2Mgw8zegsX0FjndsAgqPLaY?=
 =?us-ascii?Q?AQ6QP8vMaot02P4/pb3uIdwmb2wtOzd7PtMly3uNqCymx/hGkm0rNtKPct/Y?=
 =?us-ascii?Q?HVH8VsSQkun0uZZ+awhve2hV4/mdWuhPHTyTc4NyyAMAm3UFoo2olQtREUqk?=
 =?us-ascii?Q?lAxiOVrXb/wtSNTRzzgW5mOHOeyM8pSQ7wWmdou7rcf4j+L8sVOlmFbA38+z?=
 =?us-ascii?Q?1G7h9uiKSE7j+RiOFW1N7grhBU5wk/eyaLNG6gjO+jUBC1cVGu/cgP8P0/jy?=
 =?us-ascii?Q?BNZTZOncKY17OJlfrHsw37RgK/y5P5J/kFp/jrfpnmJkkSRUyXGMN3RcwJuG?=
 =?us-ascii?Q?j1Wa9GtEBF7Tc4homKxtN15dRFLr5oJHTNl8qKK5D69FZBJhSm3nlSoUkPB+?=
 =?us-ascii?Q?2TEUe/EmD3kpjtA1yrFWBt5fLJZ3d7a4H/PTwsBQZ1istXHRTzYRkW3UhQuL?=
 =?us-ascii?Q?nsLvnuPomzsrMBY56IKmKV7oYTJfEaoJ6vGeVPXmMGkFbpe4QPiNiQxQO7ny?=
 =?us-ascii?Q?prcFXk0pLpeOG6JLiLoyfmvyRn8D+gNqCXy6nAzDR8ou5JfWnjJSjYvRmzcC?=
 =?us-ascii?Q?e5ANkIkh2Z/+M+Idk8zFHOAjxGHvgkHW75nmEKGFi+Mn0Aif+F8/k83VMtcR?=
 =?us-ascii?Q?TV0THo6Bvhlxosa6k6W/q6JMixJ0YwqHVweXbJpY76QCUyIHDad3CSZRHxBi?=
 =?us-ascii?Q?efrWE3x7CGXL7gUQKljLHCv/0ZpkbYPsH3b/A8vnS9QWqMaom3Vm+s1lDgnn?=
 =?us-ascii?Q?gwiNOBsvqiVH4IZ2p+Wx/TLb6hDXqk0Sym2gJr86h67L148yZxPEzj/8wvCI?=
 =?us-ascii?Q?4bCMvJmKSVxl2aA6tO6a770xtOejMVcm5lm0uCQ1Fl8vknPl51MvakAQf/AP?=
 =?us-ascii?Q?hMMES3ZtM/k4grJCReI9CYX4oYTEhc76JHAcCyviRXz5YnEivpB34J3yErbG?=
 =?us-ascii?Q?0CcgOwe5XL2guHdZZLFu734MpmkPb9HuH0IptkhuTt5FQPI7eHYK9iiVymY3?=
 =?us-ascii?Q?kedbW9GgIaG61rlwgdM31KY+xfaqmQhMBW02LaiVSaK9Rsw8ZEO2XSKllXkH?=
 =?us-ascii?Q?MwiVzVE7rR1LIyw2DPAHih0S7TkVecpxV8ppM5ALW4+pgWyLNfiCI7FebaSo?=
 =?us-ascii?Q?axlESiquCAzVfFF1DjiA+qAgDfda0VqlXDMPZj3VXrefGDXm8RmCKzxJ4ciy?=
 =?us-ascii?Q?FheIRPvmLHenzbIvZbQxmenfjKcLzdJ+tYjk71eQ/Ig4e+8/u7j8OGCOUkjX?=
 =?us-ascii?Q?aipYvF5EQXym+eJ0js55gSy3JbBdRH+7zXOexitBi5GRADKxNlMbcEa1WmQj?=
 =?us-ascii?Q?VEe/83cazl2PPH/jq7rXOI4qGMuEssWQu+zXe4C8YdthbWMnsMW/H9K3J0us?=
 =?us-ascii?Q?9jHXUDQtLjHecV1qxgE2TagOdFGcoHzssMkb+ea79AhOOUERZK/HQp0wrBCV?=
 =?us-ascii?Q?rz6laPfiVtr7Uj49XaUIHS9JHssDIhu6a2n8rNhayRwAGr1bdaYRWFSMpA4m?=
 =?us-ascii?Q?Q0erT1ikCxie4/PqDt1P7lKl2UqF1kFIUnTG31K9RV9QIlDDx0EwN6BkM2Wm?=
 =?us-ascii?Q?TF3D7m79iNHoqydHvkxKvogL+u7Bz2WB19m6mPFC28JESO8zG7stloCwwYdv?=
 =?us-ascii?Q?rg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3065.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07985191-a36d-440f-aa10-08d9977acac0
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2021 05:46:28.6707
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tGvtxnNYsKlvXiVMNQEHaohjOPYMO3BodxJVA2iAkuc7lI7tf/QpdSiDJmBY/x4rs6lnKO1LiRD5zDXWboNFvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2811
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



> -----Original Message-----
> From: Vinod Koul <vkoul@kernel.org>
> Sent: Tuesday, October 5, 2021 4:05 PM
> To: A, Rashmi <rashmi.a@intel.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>; Michal Simek
> <michal.simek@xilinx.com>; linux-mmc <linux-mmc@vger.kernel.org>; Linux
> ARM <linux-arm-kernel@lists.infradead.org>; Linux Kernel Mailing List <li=
nux-
> kernel@vger.kernel.org>; Kishon <kishon@ti.com>; Andy Shevchenko
> <andriy.shevchenko@linux.intel.com>; linux-phy@lists.infradead.org; Mark
> Gross <mgross@linux.intel.com>; kris.pan@linux.intel.com; Zhou, Furong
> <furong.zhou@intel.com>; Sangannavar, Mallikarjunappa
> <mallikarjunappa.sangannavar@intel.com>; Hunter, Adrian
> <adrian.hunter@intel.com>; Vaidya, Mahesh R
> <mahesh.r.vaidya@intel.com>; Srikandan, Nandhini
> <nandhini.srikandan@intel.com>
> Subject: Re: [PATCH v2 0/4] Add support of eMMC PHY for Intel Thunder Bay
>=20
> On 04-10-21, 06:04, A, Rashmi wrote:
>=20
> > Applied patch1 and patch2 for next, thus leaving the phy changes in
> > patch3 and patch 4 for Kishon/Vinod to pick up.
> >
> > Thanks and kind regards
> > Uffe
> >
> >
> > Thanks Uffe,
> > Hi Kishon/Vinod,
> > 	Please let me know if you have any comments
>=20
> Need ack from Rob on binding patch
>=20
> --
> ~Vinod

Hi Rob Herring,
	Please help to review the eMMC dt-binding patches

-Rashmi
