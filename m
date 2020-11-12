Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A8FC56201
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Nov 2020 14:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A22D6216FD
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Nov 2020 14:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="MN36WTm8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgKLOPa (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 12 Nov 2020 09:15:30 -0500
Received: from mga17.intel.com ([192.55.52.151]:14341 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727789AbgKLOP3 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 12 Nov 2020 09:15:29 -0500
IronPort-SDR: Rx28Eve7ZMCNB3YzWwTVwnGkw7PZkyA8QZwB9m4zwZO4vdidgsn1d7oabV+2HTryZJM1UxabA0
 kIpue2dqmneQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9802"; a="150163148"
X-IronPort-AV: E=Sophos;i="5.77,472,1596524400"; 
   d="scan'208";a="150163148"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2020 06:15:25 -0800
IronPort-SDR: s8rxsRXK1cFn2oZjjvVmsxFBiNYEMV20zFCcSdeFED5g63tPAcy+qKR2qf6xO7ketWpSXkv+6v
 NaD+VuUB8jDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,472,1596524400"; 
   d="scan'208";a="366346571"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Nov 2020 06:15:25 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 12 Nov 2020 06:15:24 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 12 Nov 2020 06:15:24 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 12 Nov 2020 06:15:24 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Thu, 12 Nov 2020 06:15:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NHdVldrwd9lanYwsmEPxdAPbtf5SWthZgCqGNxvc4m1uSn2HQw+LP9B9F2Wgd4Ynoz4pRolnZEanlVCZl5gjfAqBZt5uTIG9qxGBljTg2kbgyFZWTOp+4mhRW2tFZtHZ/uUeXGdxeDpjpO//FAl4TU/IJD7ZGE3N2M/1I2gMVU8plseqoldyQ3avj4SuPeRIqFohAeWAav7bsvmEPhxRjXU9yhp8p9cF90eTjO1F1tGx1rwbH1xamztvHMoaRgl5Bc/hnQPJhUbnEJ9tpBCWf82Sn2gc4tTPHOJkG344NP5bhYBMmZflkBn6WxGzIZmtfKvNIdV5oGXDUb+bvrOpiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r3OsQCsVDybpD5l4DjLHi+alvCUOqxjYhXU89NheJnk=;
 b=ITGdUECfCb0w9xau3fq9Gn0o07y7bRLj6mvDERnOaBHwtlzW31AzgLeZ8aHd8GYk3uu3i9bG0KaRjGX/VUC7kmNgc9fwHbvE2n9gY27iBSBwCDaOMYF+peG7ZBo8S3zE2pteIJs5Afnff3iNLl8rf944QxY0wNS/wmmEskj1fiwIgx05deQwEhf3ew9DSCLbU+69LDKVTYsL/zKpx2qpNSZVBu0Iby511hNq7p6iekFDEgMGexP+Uv4ccFy7BmjFNIWJvCf8kUuhEVuz5j+aZcaBlXd1UuvpwfwMwDxWWyqkxVC2nN/lNAP8gC+62fHw216ygOKcNWhN1rRACavyWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r3OsQCsVDybpD5l4DjLHi+alvCUOqxjYhXU89NheJnk=;
 b=MN36WTm8M9EBxcUab5zVA2ET6GS+cDIziNJ1XcUlqcHrvkpvjkcSKWGJVKaBn7bsyBpoI6So03SHFZHorquh1D4FpMHnj9Z99khXI9TY2ggsrwKaAQj1PuA9aXxOWDitH6RlrKghGx7gtff1jq/jD+b4D2nxG8ylmQ/YIFUYN7c=
Received: from DM6PR11MB2876.namprd11.prod.outlook.com (2603:10b6:5:c1::16) by
 DM6PR11MB2683.namprd11.prod.outlook.com (2603:10b6:5:c6::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.21; Thu, 12 Nov 2020 14:15:21 +0000
Received: from DM6PR11MB2876.namprd11.prod.outlook.com
 ([fe80::c85a:d98e:fbf3:9f8c]) by DM6PR11MB2876.namprd11.prod.outlook.com
 ([fe80::c85a:d98e:fbf3:9f8c%5]) with mapi id 15.20.3541.025; Thu, 12 Nov 2020
 14:15:21 +0000
From:   "Zulkifli, Muhammad Husaini" <muhammad.husaini.zulkifli@intel.com>
To:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Hunter, Adrian" <adrian.hunter@intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>,
        "david.e.box@linux.intel.com" <david.e.box@linux.intel.com>
Subject: RE: [PATCH v1 0/1] mmc: sdhci-of-arasan: Specify .clk_ops for Keem
 Bay SOC
Thread-Topic: [PATCH v1 0/1] mmc: sdhci-of-arasan: Specify .clk_ops for Keem
 Bay SOC
Thread-Index: AQHWs/K3a7OdWbCL/0u2ZlSWuFDlTKnEkdJQ
Date:   Thu, 12 Nov 2020 14:15:21 +0000
Message-ID: <DM6PR11MB28761F437576935AFC60328FB8E70@DM6PR11MB2876.namprd11.prod.outlook.com>
References: <20201106120933.7190-1-muhammad.husaini.zulkifli@intel.com>
In-Reply-To: <20201106120933.7190-1-muhammad.husaini.zulkifli@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [42.189.188.113]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0192bc22-0410-4660-fa36-08d8871563fe
x-ms-traffictypediagnostic: DM6PR11MB2683:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB26838AFE73D4293F176B75BAB8E70@DM6PR11MB2683.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vl0fNVyMzaIU+sQiveuSGmmCZADddlXH9/zdC8nTYOQUus0zeZ3aBhMrwk0RUKMlp5q/fmgHcwD7S0eypO4HYDriAkh8ltZ3kzI/43QRq6ujXwM2g9SiFk937RgtbjbNZO9XhKFepWpNJmtC+5htIRICF8CPZODAYp30rEbIw7admJZzlIEchrap4bQK3BVzlzx4CTxh6PrFoDYcOHH85gZMni5XEVXeYccN+9jyEU+mqEZyOJ6Hsi3e9YkUCLo12ZLW21Ga5O7SWgvUOulpudAnDMVMzc3KikKuQW041E1vwXxtPiwis0EEj0U+5/Ka8CSxQya5ROxwXjDSDYrR3PIVCMnaBrKhHlbDaFd5grrP/JrL4IQ0BAe94iPwUztK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2876.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(39860400002)(376002)(396003)(346002)(110136005)(55016002)(2906002)(7696005)(76116006)(66556008)(316002)(5660300002)(4326008)(66446008)(4744005)(186003)(6506007)(83380400001)(8676002)(86362001)(9686003)(64756008)(66946007)(478600001)(52536014)(71200400001)(54906003)(8936002)(26005)(33656002)(66476007)(142923001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: HxQYtPUM5frlWkxyiEUmz5KWiMRQpDVtlI1oJeOTKYJeR61ZJsbvDT4DCIdraR2ED4F9I+Xi9JBwCame383fKUk30ADitsI8vhHbgzQUAITS9xM4eRjIE8Mo0vcdwB5mWiOUPx8/V/1VDhewwAe+EnWgnKXWBbas4WsRs9c8ci9apFnyfjKts+x3Ui29cD+/GjE2IN2qClmX+Gsk0d4GhHHowqWqlitKI6/YU7cu5jtifDSzvbAsvwSqn56Mxqt3d1ARdU2xjX5h2mVG4ZCZicnIyhvtMaHx1VgdB5j2D1a81h6qEtkyBZ3EinT+cmvvWTtrvks10oO11g6kt4aYRsgtSmpwjNB/6p/HwqbIZs/8HgWTEd/LbomMApa8cCzVsMdUj3O8S+KAOwYpKUI4UsiacR43U+7p1FokHzfBLyYSjpNOG/Ws0sgLStgLtbSAlX56SfW5NPjxoyu9JwHt8nEwPR/8PKGduZbFutmTWtGd5+WS2dOcY26zxJ65Ns6uUcT/6LCPsK1GHY0h73utJtzT2lZufUlBBRNJtTWV9fkn0tafE4Q7QkiJFMOBNstZ+zwy/wVnWV3fcFcmXOlodextcYExMNH9bLsl1qXbSjQ3myKL8mIdKlTELRfspYo/crWYbNfVGpG+k+zyp90MVl9CI2jlu+BzNKW5U8aoQG+H0nylFr2C/AEMOiPk+Pzc7jZEUGU0eZFZG6+yjQTu5or5CwxW9vEhEXNiOWMWyFDklCl2OALwWpcRvP1ZAzDXDFHbGVbdPUTtrD8KtEVTXWddPQkc5G0H0n13IHngSDr66IKrGVykI0eV6ILCTDh4AB7cb98nyQCv+H2DIrSpj/j4m81za703F4LDsAJp5DbZ1frLnI5Vr3oEe/t5dZwHQusbK3hv/Llp8swmyXoiqg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2876.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0192bc22-0410-4660-fa36-08d8871563fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2020 14:15:21.3693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DjHRQyCzKjlx+rOBbtIJS8biJ7vqhD7eQPHgLeAvJLs1BEv7DdrNrpFT/IACe6I3SnpMDYUAWQ6icaYD+hVglTkv6gi3L/GzyCwA3C+rf0h2b2b7ZZWZSiu44p0GtV+u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2683
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

I would appreciate hearing your opinion/review  on this patch.

Thanks=20

>-----Original Message-----
>From: Zulkifli, Muhammad Husaini <muhammad.husaini.zulkifli@intel.com>
>Sent: Friday, November 6, 2020 8:10 PM
>To: linux-mmc@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux=
-
>kernel@vger.kernel.org
>Cc: Hunter, Adrian <adrian.hunter@intel.com>; Raja Subramanian, Lakshmi
>Bai <lakshmi.bai.raja.subramanian@intel.com>; Wan Mohamad, Wan Ahmad
>Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>; Zulkifli, Muhammad
>Husaini <muhammad.husaini.zulkifli@intel.com>;
>david.e.box@linux.intel.com
>Subject: [PATCH v1 0/1] mmc: sdhci-of-arasan: Specify .clk_ops for Keem Ba=
y
>SOC
>
>From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
>
>Hi.
>
>This patch declares the .clk_ops for Keem Bay SOC due to the introduction =
of
>new clock operations handling.
>
>This was tested with Keem Bay evaluation module board.
>
>Kindly help to review it.
>
>Thank you.
>
>Muhammad Husaini Zulkifli (1):
>  mmc: sdhci-of-arasan: Specify .clk_ops for Keem Bay SOC
>
> drivers/mmc/host/sdhci-of-arasan.c | 3 +++
> 1 file changed, 3 insertions(+)
>
>--
>2.17.1

