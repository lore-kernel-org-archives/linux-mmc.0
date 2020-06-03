Return-Path: <SRS0=STY7=7Q=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A31CFC433DF
	for <linux-mmc@archiver.kernel.org>; Wed,  3 Jun 2020 06:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78452206C3
	for <linux-mmc@archiver.kernel.org>; Wed,  3 Jun 2020 06:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="IX0rm7J/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725853AbgFCGTM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 3 Jun 2020 02:19:12 -0400
Received: from mga06.intel.com ([134.134.136.31]:1573 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbgFCGTL (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 3 Jun 2020 02:19:11 -0400
IronPort-SDR: amsuX3dKVNJAWvilRDTPpU0inYEDunVUqupUtzx50wwOjShpMliMhD79P/52F8EU1/MFs3ZKkm
 d4moHfHXKeuw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2020 23:17:09 -0700
IronPort-SDR: 7Mmy0ikp8WYMA2lASEXO0iys51nRiDwtaCUrovb6o4xjXKxq9Sj2PMeLMjOxUHFgcUH0FGBX5w
 NfrDincB0YEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,467,1583222400"; 
   d="scan'208";a="304261695"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by fmsmga002.fm.intel.com with ESMTP; 02 Jun 2020 23:17:09 -0700
Received: from fmsmsx125.amr.corp.intel.com (10.18.125.40) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 2 Jun 2020 23:17:09 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 FMSMSX125.amr.corp.intel.com (10.18.125.40) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 2 Jun 2020 23:17:09 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (104.47.44.51) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 2 Jun 2020 23:17:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lNDttb3A1q5AJh0h7xzbpSp5qK5PMCFxEbbX4P+/MrdcO5HtO+DafM4XjmRrWSkLOFOVzUGJ78ZFSNMuRltGztWZRHj0DriJwVIAqF9mKFinZ7rAsR3kYNIclwS/ObdovwpQXzIsMBolw58S99xI1BmKIZ9X9Dd4XuW0hJilVsSe7+7gqIlW9U+KZdrAM4jKUal6YEQNzav65b9FqnobnsgeWeIMN9mxGwwrxR7j6siRmgtXiX3Tqp6ZnQ5nQxlza56zTtjtP55jLEZvXuWRZ0k42wh8/p8sN8MbpWkKmsczMIUz0BsTpnGpsko4jwNE2Qxe6a4uSK5A38Qj+k7fbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NBExA+PxxCVyo0KdOyu2Yv7XGh+oU1QZZmVp3juOFvk=;
 b=a15mNjOmBeQnlEQo2a7Vye2vQlDGLqKf+ZOBCf3F8pYgQWHxZqKux9GdgTCKnexyOtcY0+2dBOK44YHzW9Nqeh3JBztApGna6RkyciTyp2y3X4Wmz4fB9WP+RRtb0UqJyeQcWSona1jUqPrKqxjCGZVUlHa5IGlEpW0gToB1IT68Wn6iAn2b8tsAgh7H1brsJ0p51npUnUoceDROJenQhGExg/W78CpKPhfwcSGRmgmkx2I5hADFcEsuDzxXMj5GUFW5GWAQLf04JC240XBxFZ/pqHFrAzEQr3L5RCN9SN+ZPjngteeaarfC06jawCqyrGgK6/eQm51OQ19gGWu2zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NBExA+PxxCVyo0KdOyu2Yv7XGh+oU1QZZmVp3juOFvk=;
 b=IX0rm7J/nTuvvmG6bHO/9GYqBVaEsQ5Q8nVsJY5Kj2i+i03/ej/22sVgP5r/ANl7BUAtSdTvgzaria0jkUklliQDCq9rYj7gohQVjCoJtcuVH47C7LXzCP63l0x01LhT/98iUHxw35l+v8JuLQ2HmPecir8FVuzjzf+9k3EIS/I=
Received: from CY4PR11MB1528.namprd11.prod.outlook.com (2603:10b6:910:d::12)
 by CY4PR11MB2005.namprd11.prod.outlook.com (2603:10b6:903:2e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Wed, 3 Jun
 2020 06:17:07 +0000
Received: from CY4PR11MB1528.namprd11.prod.outlook.com
 ([fe80::80a:cad3:9a37:28dd]) by CY4PR11MB1528.namprd11.prod.outlook.com
 ([fe80::80a:cad3:9a37:28dd%11]) with mapi id 15.20.3045.022; Wed, 3 Jun 2020
 06:17:07 +0000
From:   "Stankiewicz, Piotr" <piotr.stankiewicz@intel.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     "Hunter, Adrian" <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 11/15] mmc: sdhci: use PCI_IRQ_MSI_TYPES where appropriate
Thread-Topic: [PATCH 11/15] mmc: sdhci: use PCI_IRQ_MSI_TYPES where
 appropriate
Thread-Index: AQHWOL8ztKe4OfhKXES74y+/yc2IzKjGXZ6AgAALefA=
Date:   Wed, 3 Jun 2020 06:16:54 +0000
Deferred-Delivery: Wed, 3 Jun 2020 06:16:32 +0000
Message-ID: <CY4PR11MB1528C2D1081484E306997A6CF9880@CY4PR11MB1528.namprd11.prod.outlook.com>
References: <20200602092059.32146-1-piotr.stankiewicz@intel.com>
 <20200603052639.GB15520@infradead.org>
In-Reply-To: <20200603052639.GB15520@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMzhlNmMwODYtOGQwYi00YjIzLTg2NTgtZmY3ZTcxNTMxZWVmIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiaHZIS2Jza3c0blZuRURJNUp3RTdLVDlkQUpUM0ZlaEpnTzNtMFlpN1psT1ZJUFRDMStRTWdRQnZHck9SUm9FYSJ9
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.191.221.121]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dc469889-8996-4da4-f17c-08d80785be1d
x-ms-traffictypediagnostic: CY4PR11MB2005:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR11MB2005CD6502F473651F696240F9880@CY4PR11MB2005.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 04238CD941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9UpiPP+qVfI7nswr1ivYuewinPb94HUakd56hSWfwvWMwBjoSYTspWsd+sCZhEeFVKm/M2W3M9GqZmGCkJpFyvDdmAstMq0FjHpG6R6spHBeZ4iUdDVk6jJGBSRY4hdhKkeWopCzlJF8xe8PloBshRCWOLgoVgpelV1lbx/FR7e3T/x9JLZsk1/AV1uxKY2HrsER4xXYCY5SACkETijZB+z2RQUBd4QI66VYU4PKx5Aes/Lp923iXeAAVp9bw8yt716lq+6k1DaD82ApPduWJ62FqkiBE6PXydMWyqflsAn3MnJcyeyO23MS806I6uB/O37ISrI+BKkTbeOPxh+HAA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1528.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(346002)(39860400002)(396003)(376002)(366004)(186003)(2906002)(54906003)(83380400001)(9686003)(26005)(478600001)(55016002)(71200400001)(66446008)(8676002)(8936002)(7696005)(6916009)(316002)(53546011)(6506007)(66946007)(76116006)(66556008)(86362001)(66476007)(52536014)(64756008)(5660300002)(33656002)(4326008)(6666004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: LNQWFH611kHHv38vTztoZF5EMQXgKLeGiAglBUw0RPtjYTkXgrg43fj/iubfamTU3vZAfjkUxfkoBFq+7lNMAgtfn5jFSw2yR7fkMP2CpjulEVLnGQeysHmdPNdx55v4p9MzQ3nQP/cvcM3N5njmsdkyfEeO1vW1aryjwzS20mMnVINJmC7T80ltnAF0vbrkwK/R90HFrNaB77cTfHuKuw2yNNWZF2Ha4Z0vv0yebblA1XYd7UY/d9FRjY6K+g31Xb25zpYoQG4XyIL72iwfqtNrpAdH/5hrLGJUC9jjfGX6oANwZBKuVwy5w61w2Ndu/Rky78aJg2WtDrWtQsIIyJtmml46oEuv1b+YsZ77Z3rgYmyGd8iSSfhxSkrEkZNOwC76a5tCRV3wigsBALJv1raUCf0ZGr0Hap/59Km53xZJH0TTb4d3jpGzq5M+Nh0XVzRCzZNtbZo24tyJ5hnQW5b1wArzyX/Y7kZ8xMTtxN8xazfRnNGyJFY4j5omcuMY
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: dc469889-8996-4da4-f17c-08d80785be1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2020 06:17:07.2844
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OZw6D7P0/DwnLPMzYMvfYh0J17r/KpqIAt684he8llMREDMP5WEk9VCuTtiyMK8UuO+fhuCO0mr5HVvB4xPU+e/GvMed0PpKrvhldOQmTok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB2005
X-OriginatorOrg: intel.com
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

> -----Original Message-----
> From: Christoph Hellwig <hch@infradead.org>
> Sent: Wednesday, June 3, 2020 7:27 AM
> To: Stankiewicz, Piotr <piotr.stankiewicz@intel.com>
> Cc: Hunter, Adrian <adrian.hunter@intel.com>; Ulf Hansson
> <ulf.hansson@linaro.org>; linux-mmc@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH 11/15] mmc: sdhci: use PCI_IRQ_MSI_TYPES where
> appropriate
>=20
> On Tue, Jun 02, 2020 at 11:20:59AM +0200, Piotr Stankiewicz wrote:
> > Seeing as there is shorthand available to use when asking for any type
> > of interrupt, or any type of message signalled interrupt, leverage it.
> >
> > Signed-off-by: Piotr Stankiewicz <piotr.stankiewicz@intel.com>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
>=20
> So this crap now shows up piecemail on various lists?  Indepent of that i=
t seems
> like a bad idea to start with, bombing people with patches that apparentl=
y
> depend on something you did first but they are not Cced on is just an ama=
zingly
> bad idea.  Don't do that ever.

I've sent the cover letter for the series to everyone question, to avoid sp=
amming
people with irrelevant patches, but so that they can find the rest if neces=
sary.
What would be a preferable thing to do?=20
