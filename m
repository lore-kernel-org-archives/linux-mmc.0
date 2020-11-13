Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EDADC2D0E4
	for <linux-mmc@archiver.kernel.org>; Fri, 13 Nov 2020 00:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13B3D22227
	for <linux-mmc@archiver.kernel.org>; Fri, 13 Nov 2020 00:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="NSuNcP7i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbgKMAP5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 12 Nov 2020 19:15:57 -0500
Received: from mga17.intel.com ([192.55.52.151]:6296 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725929AbgKMAP5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 12 Nov 2020 19:15:57 -0500
IronPort-SDR: w0Kgdr6q0IBIQ56Z38KV0PmRiDGJ4Efd3o0zFMxaRrvnOH6mryHCoolD+Z72F52Lnwnvbi+ExV
 rRMvRdm8LfmQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9803"; a="150253899"
X-IronPort-AV: E=Sophos;i="5.77,473,1596524400"; 
   d="scan'208";a="150253899"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2020 16:15:56 -0800
IronPort-SDR: z6tP3cVLEPxR3P8+JGjUdgzornhADxmcU0H2+qkos2C5iZsNmZZ61yu5EQksq2GkGBuRVxCEFH
 WvZffnkOGucw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,473,1596524400"; 
   d="scan'208";a="532372494"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga005.fm.intel.com with ESMTP; 12 Nov 2020 16:15:55 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 12 Nov 2020 16:15:55 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 12 Nov 2020 16:15:55 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 12 Nov 2020 16:15:55 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Thu, 12 Nov 2020 16:15:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iry7EIFexKhDRrFKukX/InvQFgYAAixzok+qkuM16tDhywBTsW+uFR6J4QYTQgVxGY160GxXbNUKjSV948qYa8l9VlK13AjqhlRmYkwN/i4sUwlhoHr516x/n470NkE/ni2zecgMCmGPQe0Z+MfmsZ9l4czPdSI7EJTY3HGCQ/kBDSgpkEY5qHdoKa8VtLr9Av0lRcAUGBT70iYV+BC4m1X+fuvoTzMypU2uG3cWYCZ873CTLGv2JNLH2l22hFqYF8lcGvxjh8TJMQW8HNi8c4IoUPpHlQJNzHayGT1E0GJoZr/Wx4wlKSeqg+ICdZI2+SGivHx+gHBUeRppVF5qpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bKUD+pEXB1gI63iXFdv2jW2BQM7UX2fbbPNf6R+zSJM=;
 b=M6cQzkWiC65ubqULrsxNhjVfY5NnJpsW6i9PryU53yviGHElU3ujy7lDiqD948D+tfwh7UUhQR9wgwuWPpnvd1RIaL+0zeOdgqoWMgwGV8ixQkFfkrdkFLq3EnjLsdbCazT06XbzicSiQ4KZd+s9qNSLeEUatlqSEsRG8+nGXv3PdJnmx4iJLRw1KpEpWFg0gB+vw9yIIWRkBuGhguoKrJf6qXWWS/1BIs6JoSYaMXjKBhWOniDjtxTOhuH+ye7OdxLKQlxWRhy3oTy0071wRr67Y0FFS3iZ0peuzYibi+A83JWzx1Ukehhn0jTzRmk/2wmnfY5qmkRlQD28qhK4cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bKUD+pEXB1gI63iXFdv2jW2BQM7UX2fbbPNf6R+zSJM=;
 b=NSuNcP7ivc/O1WX1Gy8js6CvH61imCy7ALgs6Z4uqy/pkoeKzp77mIYfUEV9xoTd3K/jcPvER9HOXVP+L/P6Pfog0r8d1tWDRyPYGjo8kLwmXsoqawF87L+YRk+GWskqnm/0VQjukNdTs5Pk+SBU3SqE1M1ZGoAcXWX3pRmV8pU=
Received: from DM6PR11MB2876.namprd11.prod.outlook.com (2603:10b6:5:c1::16) by
 DM6PR11MB2937.namprd11.prod.outlook.com (2603:10b6:5:62::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.21; Fri, 13 Nov 2020 00:15:50 +0000
Received: from DM6PR11MB2876.namprd11.prod.outlook.com
 ([fe80::c85a:d98e:fbf3:9f8c]) by DM6PR11MB2876.namprd11.prod.outlook.com
 ([fe80::c85a:d98e:fbf3:9f8c%5]) with mapi id 15.20.3541.025; Fri, 13 Nov 2020
 00:15:50 +0000
From:   "Zulkifli, Muhammad Husaini" <muhammad.husaini.zulkifli@intel.com>
To:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
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
Thread-Index: AQHWs/K3a7OdWbCL/0u2ZlSWuFDlTKnEkdJQgACp7ACAAACHwA==
Date:   Fri, 13 Nov 2020 00:15:50 +0000
Message-ID: <DM6PR11MB28762806866F82885FF428CFB8E60@DM6PR11MB2876.namprd11.prod.outlook.com>
References: <20201106120933.7190-1-muhammad.husaini.zulkifli@intel.com>
 <DM6PR11MB28761F437576935AFC60328FB8E70@DM6PR11MB2876.namprd11.prod.outlook.com>
 <DM6PR11MB28767CEEAD0FA1E20614B797B8E60@DM6PR11MB2876.namprd11.prod.outlook.com>
In-Reply-To: <DM6PR11MB28767CEEAD0FA1E20614B797B8E60@DM6PR11MB2876.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.201]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e7a28cc-cb5d-4399-dd6b-08d8876946e2
x-ms-traffictypediagnostic: DM6PR11MB2937:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB2937AD9C2659494AF47C377EB8E60@DM6PR11MB2937.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hWe2J73wjk2TA9NxxofHjIA0NzJL/ZxmHTshuEPJR7VzaBqhGt0bcec67qXkewzbuWWIUnqDHj9DiqyAujl11f8UcJ8FcQZGaTt+TzEyFxRB+EV6J50JWkhGZgQdB3aBmEMQDmZ7mAgvnshkDPN3aNenZBTfnFbOzGEOAI4svKYItg4np9zsjJZ9boIDiKmcoeKvTucwjS4Ql31AjpaTnffECMWa86DHtS2N0BmD4nAlX1J3h5jnWGwazKawRP7HuAm+2BLkZnLwY2HKNq1aw3NcpJSYXEM8AnBDthCYbyHcxZlX9qdmuH/KXD7jeY9sTagqcgcolr82LXQbQJjkMyaKgdgxPbVL5MQ+9O8y4IYDDn+EZ9a8KwGaC+b9A4Sh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2876.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(39860400002)(376002)(346002)(4326008)(8676002)(66946007)(2940100002)(86362001)(478600001)(9686003)(6506007)(83380400001)(2906002)(76116006)(8936002)(55016002)(66446008)(316002)(5660300002)(64756008)(66556008)(33656002)(26005)(7696005)(186003)(110136005)(71200400001)(52536014)(66476007)(54906003)(142923001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: vPOrG2FBKTLL2TDdoWLoO1vabIUDE7Ijd1B1n3K1M6RERksCAXJWf7qUNp1NTLg1LhEJ9pfspQZ8TZcutsspYPqScGJtBkPwCBAvbKOPXcmzAdE6R/FhuwCrT5UZdlUKl5df06Uy/ZwKpaJLf0+3uPBQ9JxICj94VvWriqSMLf1pKvHJ5SvpfkzGwYfMjqPfyflo/XpkHV5i4yulAi88x4dikfFGHrQtiz35UPbXNtNIorYTluKKoT9q8UC1iefdx/FN8opUaczH6aoXNtrwPU35pC/o876qqCN1zyqoLJWgJmSEf4NeX3IJKHRjM3G4sFAPKkN6chaCCYexkmU/XnM3k49KtY1uLLEJXORZ6q+dQ34v9xbBb8d0APzEvt0H4bQq7SwXba+j9+5VwYC70IwCtnQ1We3jY/x/n6x6/UnXCGOMFu5CyaWtv43U49yAa28B5FRMo0+Gx9GoKZZvhrSM0Ha7RAi01RAbRtf7qhNl31qUX7OXAlaPp9H3vVh7ebBUnVQAsT1h3AHb2PhTaulYlj1IuFwcSXLrsl1ikmokd+tS5rb5FfiPCJuNtnybKlQG+vvBpqCU61T6ZfXZPHxrz1CWU/6AKoSqIqhnOKbR+BIGhVxQL01WHVf1hVTMFN+jkAft8BfyzhFiwadE+w5MmPZ2KcneD+/vAEIocsWWkww1oKysxmUYxo1G6tFnp//KCnPewK4cPjoDyhttmjtXb9/Oa0JdCy3ro19DAnzVr4BDchMdqgfs7He+UtlYjwN06FMxB2+qb92uQ2elu/mR99AHyUxc8jEE3Lzy7c90n/2jAia0faIGmejuxjWP1jDGSZ+2jOr+oEE5jNbfYYXAdPISDQ1i7jqqAW3Epu+IVRFL2ZB4s6FyJmNXFeEqXb1LJ7RkTy0nz4opKWM3sQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2876.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e7a28cc-cb5d-4399-dd6b-08d8876946e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2020 00:15:50.3194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SbzSfbnnTq34fNASPUYU2WW7WovuSHZCjZ6lmvtTkavZmbb8nnkJvK9i1TZrJKHX8ELl3VMheH27BDKpBnM3kU4NlHBNGPdYQiIZ+Yx1ifLjVNSY3h3DKzX9w3VYKvP2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2937
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



>-----Original Message-----
>From: Zulkifli, Muhammad Husaini
>Sent: Friday, November 13, 2020 8:14 AM
>To: 'linux-mmc@vger.kernel.org' <linux-mmc@vger.kernel.org>; 'linux-arm-
>kernel@lists.infradead.org' <linux-arm-kernel@lists.infradead.org>; 'linux=
-
>kernel@vger.kernel.org' <linux-kernel@vger.kernel.org>; 'Ulf Hansson
><ulf.hansson@linaro.org>' <Ulf Hansson <ulf.hansson@linaro.org>>
>Cc: Hunter, Adrian <adrian.hunter@intel.com>; Raja Subramanian, Lakshmi
>Bai <lakshmi.bai.raja.subramanian@intel.com>; Wan Mohamad, Wan Ahmad
>Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>;
>'david.e.box@linux.intel.com' <david.e.box@linux.intel.com>
>Subject: RE: [PATCH v1 0/1] mmc: sdhci-of-arasan: Specify .clk_ops for Kee=
m
>Bay SOC
>
>++ Ulf
>
>>-----Original Message-----
>>From: Zulkifli, Muhammad Husaini
>>Sent: Thursday, November 12, 2020 10:15 PM
>>To: linux-mmc@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
>>linux- kernel@vger.kernel.org
>>Cc: Hunter, Adrian <adrian.hunter@intel.com>; Raja Subramanian, Lakshmi
>>Bai <lakshmi.bai.raja.subramanian@intel.com>; Wan Mohamad, Wan
>Ahmad
>>Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>;
>>david.e.box@linux.intel.com
>>Subject: RE: [PATCH v1 0/1] mmc: sdhci-of-arasan: Specify .clk_ops for
>>Keem Bay SOC
>>
>>Hi,
>>
>>I would appreciate hearing your opinion/review  on this patch.
>>
>>Thanks
>>
>>>-----Original Message-----
>>>From: Zulkifli, Muhammad Husaini <muhammad.husaini.zulkifli@intel.com>
>>>Sent: Friday, November 6, 2020 8:10 PM
>>>To: linux-mmc@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
>>>linux- kernel@vger.kernel.org
>>>Cc: Hunter, Adrian <adrian.hunter@intel.com>; Raja Subramanian,
>>>Lakshmi Bai <lakshmi.bai.raja.subramanian@intel.com>; Wan Mohamad,
>Wan
>>Ahmad
>>>Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>; Zulkifli, Muhammad
>>>Husaini <muhammad.husaini.zulkifli@intel.com>;
>>>david.e.box@linux.intel.com
>>>Subject: [PATCH v1 0/1] mmc: sdhci-of-arasan: Specify .clk_ops for
>>>Keem Bay SOC
>>>
>>>From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
>>>
>>>Hi.
>>>
>>>This patch declares the .clk_ops for Keem Bay SOC due to the
>>>introduction of new clock operations handling.
>>>
>>>This was tested with Keem Bay evaluation module board.
>>>
>>>Kindly help to review it.
>>>
>>>Thank you.
>>>
>>>Muhammad Husaini Zulkifli (1):
>>>  mmc: sdhci-of-arasan: Specify .clk_ops for Keem Bay SOC
>>>
>>> drivers/mmc/host/sdhci-of-arasan.c | 3 +++
>>> 1 file changed, 3 insertions(+)
>>>
>>>--
>>>2.17.1

