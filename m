Return-Path: <SRS0=fQuC=DO=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C22AC4363D
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Oct 2020 13:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6DE1206DD
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Oct 2020 13:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="u/01y1+r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbgJGN3x (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 7 Oct 2020 09:29:53 -0400
Received: from mga05.intel.com ([192.55.52.43]:30623 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728462AbgJGN3w (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 7 Oct 2020 09:29:52 -0400
IronPort-SDR: xmOEgUiOM57YlhSRAIgpEApUss2CHmgLM6KXP2pr1HomC1OSduFRnOWxDSt6bWt+CHzi0txkb8
 pQszOWjoALtA==
X-IronPort-AV: E=McAfee;i="6000,8403,9766"; a="249649376"
X-IronPort-AV: E=Sophos;i="5.77,347,1596524400"; 
   d="scan'208";a="249649376"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2020 06:29:52 -0700
IronPort-SDR: K6v2mluqIWCQTAmgbqvO5mbTkVh95cNxKZnaou0mTCSwfLfT6RsYRni3LsmtNZTm4nCb/guCoc
 Kg/Z/ol+BZPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,347,1596524400"; 
   d="scan'208";a="342873131"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 07 Oct 2020 06:29:51 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 7 Oct 2020 06:29:51 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 7 Oct 2020 06:29:51 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 7 Oct 2020 06:29:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L6bdV6OhlSXhcHqkTrSNScXNFZWwBLGX+mAgP1wOqVLl4y6RKzoRrFMZDzAVpMeoDDETQ1Bnt7sZ3bHRbTk15j3EmESPPnukmZBNWsn6JM78hEj6hiP0c9RE5SCBe4ANcXuQuFTBVtSOj/BOjhdwAKxvHshp/b9R2998LvH4sB0Qgc07sKmL3fgmiCPmSKtnGmUB/QAxuR3Ggn/Iz6t6nfzGMChpT14qVvtgQ5dgr5G3sqQ3VZcn1s/1ZvFhOyLhpnAeDoE0hALASXxlI7oJD7KD8HhYrdHIO3ACmAkJdyv7T/yq4mDTSTQTx8bepFvqlKVXeL8rCfJhmox3JbNHew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4yP1ZYFMD3tEaaFW8hXL62tqxhyGKlIBfjI8550+1X4=;
 b=ElW8njLBtwdlWCptsbNIobMDM7fN9xPEZtVZ3DZ3MtN7NOfpHWAcrJlw24d3dwy1bMykJlV44CAcYH9e5kjdeV9aR+cZkvZ/hgcnFY90NVaHrqeLEtDLjnqlMWbHMRkyHflF6lbftlCf/FidCWCF/z5oXPz/S8nKTUrR78tK6THF9FrU3KjpHjW+5rmtzDlifIfuTJkZt4UmXxcu7Z1G18NjOhP/pL3vv+8LXGCGte8g8pUkfMu5lFXXksB0miVCHpGpDSoxw+wL3lvpXe6jL0WXEnuC5M1pznciQA71qB3Va6AaBoOrCWFvLc+cUrIKtN+Ata9nEm3UAU+X7C4H7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4yP1ZYFMD3tEaaFW8hXL62tqxhyGKlIBfjI8550+1X4=;
 b=u/01y1+r3hpPXJxHo16fch9T11nU9BeMPHaNDYPitWA/NXn7Kw5z2GIajXbfwm43kRfhSoyFDM8g4u7PgdXb21BQ7VNXKaBlrrds2c/pykn06l54cjhDPhu7vMxOVqI7DdFkkIAWrKFPiP/xQj2MwT1K9WWY8ewRwGu2dhlvX2s=
Received: from DM6PR11MB2876.namprd11.prod.outlook.com (2603:10b6:5:c1::16) by
 DM6PR11MB4754.namprd11.prod.outlook.com (2603:10b6:5:2ad::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.22; Wed, 7 Oct 2020 13:29:47 +0000
Received: from DM6PR11MB2876.namprd11.prod.outlook.com
 ([fe80::c85a:d98e:fbf3:9f8c]) by DM6PR11MB2876.namprd11.prod.outlook.com
 ([fe80::c85a:d98e:fbf3:9f8c%5]) with mapi id 15.20.3433.045; Wed, 7 Oct 2020
 13:29:47 +0000
From:   "Zulkifli, Muhammad Husaini" <muhammad.husaini.zulkifli@intel.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Michal Simek <michal.simek@xilinx.com>
CC:     "Hunter, Adrian" <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>
Subject: RE: [PATCH v3 2/2] firmware: Keem Bay: Add support for Arm Trusted
 Firmware Service call
Thread-Topic: [PATCH v3 2/2] firmware: Keem Bay: Add support for Arm Trusted
 Firmware Service call
Thread-Index: AQHWm/mmQ68E6v02PEeQu9XSxqgGOqmLzXGAgAAe0ACAADdMUA==
Date:   Wed, 7 Oct 2020 13:29:46 +0000
Message-ID: <DM6PR11MB287606C90928ECC7570487AEB80A0@DM6PR11MB2876.namprd11.prod.outlook.com>
References: <20201006155549.3595-1-muhammad.husaini.zulkifli@intel.com>
 <20201006155549.3595-3-muhammad.husaini.zulkifli@intel.com>
 <4677c614-ac00-fb69-d22c-54f9015249f4@xilinx.com>
 <20201007101038.ec7ymdhiaf7rhyrm@bogus>
In-Reply-To: <20201007101038.ec7ymdhiaf7rhyrm@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [42.189.177.181]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 40320a6e-3a11-4949-76e1-08d86ac50f56
x-ms-traffictypediagnostic: DM6PR11MB4754:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB47541729AA3E5F22A57D1A83B80A0@DM6PR11MB4754.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hB/w/6rRcknm9X3ixWyW96F2t6yLopWdOpUyJ2lKwFCBJJVwCYvSi/ddQNXUJNkwmcl3oKOO7cqc4KELkED5RorPZq8PFb9aaDf0n4GuRDaUOl6HyeI61w6v9eNstq1Xga06ljh+y3OAh4jWfKJTXjTfkRTUjNq1IIAhFOCROAVgDSaPDjiqyg8UeSq4FSI2e38YS+uPovlT4iqlT9lKZaJpSCk2FiOMdSMuYewJy7htqUSqUJP4LEScgpCbMU2T3nNxp/l4T5u3nm9ikhsLYysFansK9pU76sbKoiN38BhvWIc0jD8ll2GuN1/ezjKkCwFJYHodehmpmTaZ8djxoQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2876.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(346002)(39860400002)(376002)(366004)(8676002)(71200400001)(54906003)(316002)(478600001)(9686003)(76116006)(66946007)(66476007)(5660300002)(52536014)(4326008)(110136005)(64756008)(66446008)(66556008)(26005)(186003)(83380400001)(33656002)(7696005)(86362001)(8936002)(6506007)(2906002)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 5BKPh2avS/Hd7kCCIrJv1Y59xBBYpYTdlcrO6JVZRUHvPg5qqvIMNHkUn5raMbrQGM7R2bKiUPQX53ivxvrNLC7/Yoi2h7XR/Xsf5G8TIIAJpNW8eCwaP1SsRA1lzNi7aj7ggvL8gpf3lEkjUb72UI2t2ib1soVHelup+vvLcUqvjyHcOEv/xv+qqHDzsJbMGIZlUg51wW90EyF1JZbeYbAa+aSWj8jp+uF3kNDI6MN1lwT6b5HXsvPYfSpgUERWRWnSQmGf5hRsxISAB+pCp4mLZKWggKUOeG8n5lRAIHXRKSRHmzdAQQguF+vQhLXu71mPjENzQzbVq53+E6zMwnZtxHx7+UJ0OHQ+Z1UK/NkJPil11M4lI+CKdmIwJheE5y0Dj1GuS0V+RK7B15V7a28So3e2gxgVuhlFRC1o3zCPQ2KY80uOyamszboyJAQKiZg4yfe6JkTQZggvrnZ6ol0chn3CT4gqlFWky420ISquO3yz6ckPUSotZZiuHnPTHzhqvHAhfDkYXQ9pRsqtwuqajvV66wvfPyV93dcM+C31w2GbrA6jtMpBN/n68Th1Iqd6vPj4daZdajUYxOkRR2URcbAQw9XurikuicSBKdlcKTDsuorCHrwvwUaPdaWbF4/MC4+9r5LFFrYTthEHEw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2876.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40320a6e-3a11-4949-76e1-08d86ac50f56
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2020 13:29:47.0262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: khc+tve9TtnpIuL8vXPgHhMtY0dAw/AHMB/OULLg9GEnmNvhUKeK3q2F/VtzxzCS76rd8pazWlBNdQcKiHjegB7VsGf2L1C4ktfo5jrna0cwrruVZ5gedLNlkoztGIye
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4754
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Sudeep,

Thanks for the feedback. I replied inline

>-----Original Message-----
>From: Sudeep Holla <sudeep.holla@arm.com>
>Sent: Wednesday, October 7, 2020 6:11 PM
>To: Michal Simek <michal.simek@xilinx.com>
>Cc: Zulkifli, Muhammad Husaini <muhammad.husaini.zulkifli@intel.com>;
>Hunter, Adrian <adrian.hunter@intel.com>; Sudeep Holla
><sudeep.holla@arm.com>; ulf.hansson@linaro.org; linux-
>mmc@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
>kernel@vger.kernel.org; Raja Subramanian, Lakshmi Bai
><lakshmi.bai.raja.subramanian@intel.com>; Wan Mohamad, Wan Ahmad
>Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>; arnd@arndb.de
>Subject: Re: [PATCH v3 2/2] firmware: Keem Bay: Add support for Arm Truste=
d
>Firmware Service call
>
>On Wed, Oct 07, 2020 at 10:20:21AM +0200, Michal Simek wrote:
>> Hi,
>>
>> 1. Keem Bay: in subject is wrong. Tools are working with it and you
>> should just use keembay: instead.
>>
>> 2. This should come first before actual change to keep the tree bisectab=
le.
>>
>> On 06. 10. 20 17:55, muhammad.husaini.zulkifli@intel.com wrote:
>> > From: Muhammad Husaini Zulkifli
>> > <muhammad.husaini.zulkifli@intel.com>
>> >
>> > Add header file to handle API function for device driver to
>> > communicate with Arm Trusted Firmware.
>> >
>> > Signed-off-by: Muhammad Husaini Zulkifli
>> > <muhammad.husaini.zulkifli@intel.com>
>> > ---
>> >  .../linux/firmware/intel/keembay_firmware.h   | 46 ++++++++++++++++++=
+
>> >  1 file changed, 46 insertions(+)
>> >  create mode 100644 include/linux/firmware/intel/keembay_firmware.h
>> >
>> > diff --git a/include/linux/firmware/intel/keembay_firmware.h
>> > b/include/linux/firmware/intel/keembay_firmware.h
>> > new file mode 100644
>> > index 000000000000..9adb8c87b788
>> > --- /dev/null
>> > +++ b/include/linux/firmware/intel/keembay_firmware.h
>> > @@ -0,0 +1,46 @@
>> > +/* SPDX-License-Identifier: GPL-2.0 */
>> > +/*
>> > + *  Intel Keembay SOC Firmware API Layer
>> > + *
>> > + *  Copyright (C) 2020-2021, Intel Corporation
>> > + *
>> > + *  Muhammad Husaini Zulkifli <Muhammad.Husaini.Zulkifli@intel.com>
>> > + */
>> > +
>> > +#ifndef __FIRMWARE_KEEMBAY_SMC_H__
>> > +#define __FIRMWARE_KEEMBAY_SMC_H__
>> > +
>> > +#include <linux/arm-smccc.h>
>> > +
>> > +/**
>>
>> This is not a kernel doc comment. Just use /*
>>
>> > + * This file defines API function that can be called by device
>> > + driver in order to
>> > + * communicate with Arm Trusted Firmware.
>> > + */
>> > +
>> > +/* Setting for Keem Bay IO Pad Line Voltage Selection */
>> > +#define KEEMBAY_SET_SD_VOLTAGE_FUNC_ID	0x8200ff26
>>
>> Sudeep: Don't we have any macros for composing these IDs?
>> nit: IMHO composing these IDs from macros would make more sense to me.
>>
>
>Yes we do. Refer include/linux/arm-smccc.h I expect something like below,
>which also indicated you are using wrong OWNER space. You can't be 0 which=
 is
>reserved for CPU ARCH. You need to be SIP(0x2)
>
>#define ARM_SMCCC_SIP_KEEMBAY_SET_SD_VOLTAGE          \
>        ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,       \
>                           ARM_SMCCC_SMC_32,          \
>                           ARM_SMCCC_OWNER_SIP,       \
>                           0xFF26)
>
>
>--

Testing with below func and definition. It is working .
#define ARM_SMCCC_SIP_KEEMBAY_SET_SD_VOLTAGE          \
        ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,       \
                           ARM_SMCCC_SMC_32,          \
                           ARM_SMCCC_OWNER_SIP,       \
                           0xFF26)

int keembay_sd_voltage_selection(int volt)
{
	struct arm_smccc_res res;
=09
	arm_smccc_1_1_invoke(ARM_SMCCC_SIP_KEEMBAY_SET_SD_VOLTAGE, volt, &res);
	if ((int)res.a0 < 0)
		return -EINVAL;

	return 0;
}
>Regards,
>Sudeep
