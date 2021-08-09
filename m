Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43338C4338F
	for <linux-mmc@archiver.kernel.org>; Mon,  9 Aug 2021 11:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23AC160C41
	for <linux-mmc@archiver.kernel.org>; Mon,  9 Aug 2021 11:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234924AbhHILRX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 9 Aug 2021 07:17:23 -0400
Received: from mga04.intel.com ([192.55.52.120]:54309 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234657AbhHILRW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 9 Aug 2021 07:17:22 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10070"; a="212810599"
X-IronPort-AV: E=Sophos;i="5.84,307,1620716400"; 
   d="scan'208";a="212810599"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2021 04:17:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,307,1620716400"; 
   d="scan'208";a="483300071"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga008.fm.intel.com with ESMTP; 09 Aug 2021 04:16:59 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Mon, 9 Aug 2021 04:16:59 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Mon, 9 Aug 2021 04:16:59 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Mon, 9 Aug 2021 04:16:59 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.44) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Mon, 9 Aug 2021 04:16:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lth8lsNM90fgwwGpUkV/0NhA75ovavRc70f6EFj0z8d1CuOFO+BMZ1L+mqQ38QHKtVzNI5C2+dPQd4f6ClTcr1hJD6HO/EEcui6DIC5FQ56y2GdJDUCApkq1CYcNQUNvsyGFeZMMr9rNsjwk95KZKxHTxkZn7jMVP9bA/f0OJiWb/8VR5HN5MEWS2i7MBrEFNuB82ORyRmBjfE1nYJ4LBx9rQh6J8OqkfECKV84reuljCtP1w3+kXOTrVDWwe5xuKxMJFvixRG9/MbZZmHExKtR/H+DKSCvHw6AblhmfGDIsFXCaiGHmHP8zv5DA3k/hirmIc6crzvzioS14TYMBgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NRGr7AFjHLiinwOWFHB88l4h4jXLyVqL17Pfxf7m4j4=;
 b=AnBITT7UWTlzwJDRUBcIzUWfDUI7ft1HVjPwxv1sUgIH0nxY66BWbrEDWB6GvucRUQVUHf9buFVE9a7g4imGkK9Z9czZjaL7wQS+hQvAAtrOnovwFTkeg/XlxYgoxp5F08Nz9xGC7Kr+4Do1qzrCFMQ7j1ygWrC9Tiju09M5Y1fe5eldPFWCRJVPJi3UIu0LUEpWUB2tGl8LS3ic6+Acu2Gq0B9MZcLc2TF6tQXyRUDgEUKBf8EHZGtdudt8qZ2VyzdIoX57dOe5B1LxzwPOSubJVqFHQwowGBh4jzRs7WjdR1gYy6C71mNT2MkeXBTF24iZYIRqtFqOcZDMAT/Z2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NRGr7AFjHLiinwOWFHB88l4h4jXLyVqL17Pfxf7m4j4=;
 b=ntMiJvv/DxlvAdl+JzN8xXeXrqd5Uj+EsnuYKTtBFwfRQJcbMfHWNO99egnhe80Y4lxGlBzDp7jxnhG9kUwZMHYNRnjcdF+lI4ypa7MJt8djX41lgwfX+JvV9PypEf+mWJIZRPQZIKz0BgfOvxIMH/uOLb98v8dWH1B+cgSTD+s=
Received: from MWHPR11MB1789.namprd11.prod.outlook.com (2603:10b6:300:108::13)
 by MWHPR11MB1631.namprd11.prod.outlook.com (2603:10b6:301:10::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15; Mon, 9 Aug
 2021 11:16:56 +0000
Received: from MWHPR11MB1789.namprd11.prod.outlook.com
 ([fe80::b81c:ee06:fc82:5fc3]) by MWHPR11MB1789.namprd11.prod.outlook.com
 ([fe80::b81c:ee06:fc82:5fc3%7]) with mapi id 15.20.4394.023; Mon, 9 Aug 2021
 11:16:56 +0000
From:   "A, Rashmi" <rashmi.a@intel.com>
To:     Vinod Koul <vkoul@kernel.org>
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
        "Srikandan, Nandhini" <nandhini.srikandan@intel.com>,
        "Demakkanavar, Kenchappa" <kenchappa.demakkanavar@intel.com>
Subject: RE: [PATCH 2/3] mmc: sdhci-of-arasan: Add intel Thunder Bay SOC
 support to the arasan eMMC driver
Thread-Topic: [PATCH 2/3] mmc: sdhci-of-arasan: Add intel Thunder Bay SOC
 support to the arasan eMMC driver
Thread-Index: AQHXhQzRAwmHks3vwkaXAOpN1lCV0KtmfYEAgAQx92CAADsqAIAAJ6Hw
Date:   Mon, 9 Aug 2021 11:16:56 +0000
Message-ID: <MWHPR11MB1789D2B707B39CB42322C73A8CF69@MWHPR11MB1789.namprd11.prod.outlook.com>
References: <20210730063309.8194-1-rashmi.a@intel.com>
 <20210730063309.8194-3-rashmi.a@intel.com>
 <CAPDyKFqZ-H3+OnYyyY7y611YrRAAMFq+W65DMfM4wSNvY_fzjA@mail.gmail.com>
 <MWHPR11MB17891909766F5295AF34B0578CF69@MWHPR11MB1789.namprd11.prod.outlook.com>
 <YRDqQvKQ71/824Lu@matsya>
In-Reply-To: <YRDqQvKQ71/824Lu@matsya>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e8505bd-c0ce-45fa-b8ad-08d95b2732b6
x-ms-traffictypediagnostic: MWHPR11MB1631:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1631826B5985A88A6F0E23C38CF69@MWHPR11MB1631.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1/uEAThH2MqtQRYNl2V/decQRnc6oh7c6ht2L8B/S+xiyXgqH1xhqScpwcnwFdop3zCrUteZHxqyGIYbKhJFm60A0EHoPq6/697lnXQTnwgzViHXl5F4/YsRBNWVT8E9uI/lnf/ZRB+J0j6zZJwyF96tT3XisQHtGfMw3sutQLAI9330PeYVeOMWFgMXWaqD2RaMoCzPrYF+Pgqu4nTMf2EGhSYV/b1HSYxyzwBl9cWFu2CwJE2I+vqp0A2KeECLm/0kvSkk7RtoeSU8/w2erFv+f9GrbKEH52Q2xwdXcEDmw+MaFA/8PoRheD0D3SyFejUTjQ6AMEIUbEog7jAlioaMUmkrv/FjXkX1UQr/q5FWj8jz9frpf+7Qpq9TQC1sCupmGLs8PaJtcklzAg8cFSIGaEWZk8rJK591qgaCnmgEX5KYbta8a8eBYzPcjRf2r+Jqid1Ww/z2yfT3kDmLuPrTVVh8NcG52I9I3ig7zLyU2T9H97ZMbSs0jF0/x6NH4eIeqY8MtC6lVohYeGyOvryNDrmgRwTfCIxu+SOzsKlqSL5F+85gR19VE6WBzprRspozKDan2VR25nKSpgAOOlFw6gNPr8f9skAb/+ddd9iWZY0s4Fte7Q4FF31kWTMT8dxj3C4axzzT2VSqryRhQ6DHX3gSJzfY6hFlHPeaCjlj4/q/erGnKm1jN9UZZyjqSyjgjLcIBrsHktfmCOU/Dw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1789.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(39860400002)(366004)(346002)(396003)(8936002)(54906003)(2906002)(33656002)(52536014)(76116006)(66446008)(64756008)(66556008)(66946007)(66476007)(186003)(8676002)(83380400001)(53546011)(6506007)(26005)(6916009)(5660300002)(38070700005)(38100700002)(316002)(122000001)(71200400001)(86362001)(9686003)(478600001)(7416002)(7696005)(4326008)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HhQciIVvnxZvqhdgEfvQHhBRxxDlGr0IFCO0mwgffpJivPEkFw3iqCcOyRss?=
 =?us-ascii?Q?7ST/8fzGUTet28cM7nJvJBwojMoT6J7Z+NMt3oxwXs09+MjLilBXlKKtztbZ?=
 =?us-ascii?Q?GjkM3BS8pApzF2zGSVRxFTnCujQ9sjmVLurrzHxaVp9q4u1PvpWoonWIuA6E?=
 =?us-ascii?Q?W5MhDN1zsQ/QTwQX1Da998zEwgS9ToFCVAGtsSJzX0HBi/tSHVDk9nSnINxr?=
 =?us-ascii?Q?hzuZwWIdKNSMiZhdMVngtV6XzAzXhU6XIMJ/68S8RNSe3unmSmDGUvWiD+4r?=
 =?us-ascii?Q?1iSlkWKR9nl1QeTjuhp0kcKC4hE1vn0KLIO7fSfXPDwFD6wu7qo5CxR23cr1?=
 =?us-ascii?Q?HoQ44owb+0jtYZb/eb5W8tYz3moIG3pnb3jww+LJifGRZhLSIjM0OAtzF88z?=
 =?us-ascii?Q?v86uXDvySHMWCf3KNOg8PqXlWyueh3OZ3K/x9alIpo/Z8Iawkth7AceJJHo2?=
 =?us-ascii?Q?jBnwqRfWyQLUZ0XCLWMgSG3f8yGhc21vkfXZpzSXgCyZPWJv0gjwbIzkAqVv?=
 =?us-ascii?Q?XXHldTrcMaoFewgO5Lq+RgQ4e6V0Abnc5kPF0aTMA6zbh6r7ISULwl38gEVr?=
 =?us-ascii?Q?nI3evABTQYOFgz4JJ8++xt1f6lCPqhXRC4FpKKc9j/cOYi6E/PBCXcDaQSHO?=
 =?us-ascii?Q?NPenSSfa6GSJFKL4aAQxM73PyN3OQOyjSs/hSsLvY9NYXS1vbcYan0xaNAwb?=
 =?us-ascii?Q?uT6d33KyDXYLSG5sRBoua6NGdrH/sI7nkSjDtjE9Sv7TSPpRH4BuksHA1Az9?=
 =?us-ascii?Q?5r6fgK2NSBDpLTf/qTlZGEPLJq/6EduqKpIqQegKPTioMIwE5qO2NPdzx2HY?=
 =?us-ascii?Q?2ma1W/MuGC9LPX1chBBVblWREVcD1/CR3S6+V4UpdmUdI2gVw2xc9cL/TcbQ?=
 =?us-ascii?Q?kiuTCzFyNqLKKnpkHjkhqhGA0/6JryOsvK/5ujP4nED+eQOuaBOn1VS0B4RZ?=
 =?us-ascii?Q?w6XJGvPZG0jZ8J+m1VW02lNIXRhCL5nO0H6HHcazYDLldrx5Qtisl5e8WWUo?=
 =?us-ascii?Q?8C5EO9D7tXAhPjxDgbymPRnyGPJ0A4hBSXtrT4CAqHvEeW7dgXwxUeTrhIry?=
 =?us-ascii?Q?SsRDb0Ijb226M5OVqUrdaBaOp3doXTL+RRQXzkYMqXBAoqmQX8u4kIsPhr95?=
 =?us-ascii?Q?bHHKiGWDXnKR6ml3mJxV99Jb1tzJ4jS+a5zNHUZ2ifTAFey0a2F2v19t0/m+?=
 =?us-ascii?Q?rruLAc9/vN8PBks4saDaH0wgdNOfzrJk87oAq5vtsH/upbIkJmaeFgksVFNV?=
 =?us-ascii?Q?4lAKaShmcxV2wCPYP74b1nx9QXXTOwXBcpDICx0R4pipGOR6mYjhMt4VM66i?=
 =?us-ascii?Q?uDsI6T1C2Fp5+Dc46gKfHjxO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1789.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e8505bd-c0ce-45fa-b8ad-08d95b2732b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2021 11:16:56.1354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wbo8/7KJd6IriLref8AF8M/CPBHr9xSS96eqAbaA/MC+QIhrPMiC+RKY99FpAhLFeXJQS8mTGp2iWXaSrbcV9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1631
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



> -----Original Message-----
> From: Vinod Koul <vkoul@kernel.org>
> Sent: Monday, August 9, 2021 2:12 PM
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
> <nandhini.srikandan@intel.com>; Demakkanavar, Kenchappa
> <kenchappa.demakkanavar@intel.com>
> Subject: Re: [PATCH 2/3] mmc: sdhci-of-arasan: Add intel Thunder Bay SOC
> support to the arasan eMMC driver
>=20
> On 09-08-21, 05:16, A, Rashmi wrote:
>=20
> > >
> > > Rashmi, is it safe to apply this separately from the phy driver/dt ch=
anges?
> > > Then I can queue this via my mmc tree, if you like.
> > No, the phy driver/dt changes must go together with "mmc: sdhci-of-
> arasan: Add intel Thunder Bay SOC support to the arasan eMMC driver"
> patch.
>=20
> Why is that?
>=20
> What could happen, emmc driver will complain about phy not found and bail
> right?
This is right, but ideally both mmc:phy and mmc: sdhci-of-arasan driver cod=
e changes should go together
>=20
> --
> ~Vinod
