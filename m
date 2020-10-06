Return-Path: <SRS0=uM1y=DN=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31128C4363A
	for <linux-mmc@archiver.kernel.org>; Tue,  6 Oct 2020 01:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2ECF2084C
	for <linux-mmc@archiver.kernel.org>; Tue,  6 Oct 2020 01:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="C/MyJUDU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbgJFBOZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 5 Oct 2020 21:14:25 -0400
Received: from mga02.intel.com ([134.134.136.20]:13990 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbgJFBOY (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 5 Oct 2020 21:14:24 -0400
IronPort-SDR: BSKDBuSKNVHBbkngJZ/Ft7GopyjTQQEOiIfwYYywLsKfoe9nN0Qz7rUE/un3fv68bbGU/3bOUP
 CeY6rns1fPMg==
X-IronPort-AV: E=McAfee;i="6000,8403,9765"; a="151233468"
X-IronPort-AV: E=Sophos;i="5.77,341,1596524400"; 
   d="scan'208";a="151233468"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2020 18:14:22 -0700
IronPort-SDR: jPib0xyUASDOOz/mmfj6IS7fhaJdRnGThk3z1uApZwHBZ8syAUhDmZfbiDj9hSC4zWQBNlDMtT
 yucRcHbENGPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,341,1596524400"; 
   d="scan'208";a="517554051"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP; 05 Oct 2020 18:14:21 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 5 Oct 2020 18:14:21 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 5 Oct 2020 18:14:21 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 5 Oct 2020 18:14:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DQwe7cL6ueQv/Sg6b/h+/GZLNK09rEz+bqDw/EGqpnPV5vM9UEiYIczr0wTxDrlaxRRbEY+Os/TpKRxFOJYt00yuLJmzE4fPiw2lwzvzZ5PVXeoa/XDpa5CXXsHmJOfsyJY9v0d2VAfrRunZ3rfBvQ+wg/vP3OKWaPc/LZ2xA/6tyzW7FtQIrw75GAYceCrGKstZY7F0EGwnRNIwLhIeN2I4tWglkdBZtXTG0iR/XN4E3hTsn1BrT3fKQi04zl8z1+0JNR2q4OGLqToVklC09TOb+z/fnau/xgYh9NqKMD+7fO4cmSiM36tTe3006EYVAoF5OrChB4+zmn7UpVVC1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JOzyAGYe7tIe7i2TTvcjADtek4Y0WrEagN+o2o67X4o=;
 b=ZwZGexfVLw7N0MN2p0Z8hCZMC9GzTMDEKD4Cax82VemsAoq++bDJ8/SgXLImMzS9dG7NnjFJM7+NcI/bK/FzHYD8pDVKawNExy9mnm6VkdyLCftL0XEEMHZR+6I7JpB3V1sKJ7QIkNncW3eZ3CUm3xKJk9R5dmeYqP664UpQdYi3blXxg4DrADKFOvWR0sgxji7IdcA7H0HrYTedpbQE/Y9owHplMGhuUB2vVLbT8ZaD/WvAD5ZExV/oAyf9Nieyhuiq/zYfsHINUsiF5rALnO7yKLVyhZsSe1Ml2+XotvkEm22OkDsWPN0I/GdO5zYE0K6FtKFvdx5uBst3TSPYgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JOzyAGYe7tIe7i2TTvcjADtek4Y0WrEagN+o2o67X4o=;
 b=C/MyJUDU3pIcTTclg72mOi569CiEiUgvG42N/PX3/iSiWBVzWN0B7cNxUN/zbL93joCSbA2N52FfAMEy1sfoe54pGi45HESfGCg4xvZ0Z6MZj8OvMQwVkM6kv9cL4Q61kffxHVNAk9S+fuxkO/r8llmVeb0oS6dtSfiF7WVajCM=
Received: from BYAPR11MB3015.namprd11.prod.outlook.com (2603:10b6:a03:86::14)
 by BYAPR11MB2696.namprd11.prod.outlook.com (2603:10b6:a02:c5::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34; Tue, 6 Oct
 2020 01:14:16 +0000
Received: from BYAPR11MB3015.namprd11.prod.outlook.com
 ([fe80::e1af:b9b8:7e60:e77c]) by BYAPR11MB3015.namprd11.prod.outlook.com
 ([fe80::e1af:b9b8:7e60:e77c%4]) with mapi id 15.20.3433.043; Tue, 6 Oct 2020
 01:14:16 +0000
From:   "Zulkifli, Muhammad Husaini" <muhammad.husaini.zulkifli@intel.com>
To:     Michal Simek <michal.simek@xilinx.com>
CC:     "Hunter, Adrian" <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: RE: [PATCH v2 2/3] firmware: Keem Bay: Add support for Arm Trusted
 Firmware Service call
Thread-Topic: [PATCH v2 2/3] firmware: Keem Bay: Add support for Arm Trusted
 Firmware Service call
Thread-Index: AQHWl/61fFIKn6YDxkK/M5PRzKZE1amC4PoAgAEZhQCAACt8AIAAMNyAgAAQH4CABEzPQIAAA8WAgACDndCAADs7AIAAVOyg
Date:   Tue, 6 Oct 2020 01:14:16 +0000
Message-ID: <BYAPR11MB3015E2B23C0CBC2EBB26C29FB80D0@BYAPR11MB3015.namprd11.prod.outlook.com>
References: <20201001142149.23445-1-muhammad.husaini.zulkifli@intel.com>
 <20201001142149.23445-3-muhammad.husaini.zulkifli@intel.com>
 <20201001153526.GD906@bogus>
 <ce2bcac9-8341-d7c1-0652-309ca4e9413c@xilinx.com>
 <20201002105840.GE906@bogus>
 <1b714566-d6dd-ead1-322e-f92847b923f3@xilinx.com>
 <20201002145115.GA6520@bogus>
 <BYAPR11MB30151480E71BBA232E9B0ADEB80C0@BYAPR11MB3015.namprd11.prod.outlook.com>
 <20201005084441.znou7licvvtomva4@bogus>
 <BYAPR11MB3015F4E8FDF3CB1273A35EFAB80C0@BYAPR11MB3015.namprd11.prod.outlook.com>
 <20201005200744.robd42nkt6ahg52x@bogus>
In-Reply-To: <20201005200744.robd42nkt6ahg52x@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: xilinx.com; dkim=none (message not signed)
 header.d=none;xilinx.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.220]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 436e3bdd-fedb-46eb-b1d6-08d8699524fa
x-ms-traffictypediagnostic: BYAPR11MB2696:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB2696C24A109D13DA8BAC8379B80D0@BYAPR11MB2696.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 99cRhTik6HCaQuRCSIDtgt7+jyTV7S8LFUCK/tjZfXMTjqwgtmi/9ZQZuBmiAhI2gY6fuIfseW+LPlWE166e8OaddHzexeZFNxArJlv6EfytQs/tWw4TK1sMMeI6wgpUALrtehbjsvj4sPj+PnXiZjQKAzg3B5Qg6AtkNeBYeYXbHtoaeCv3uDFEkuXz14fWeRvewOSfMbWH3RhioiMcWv2pjRwFDAxDAGaVRkP04JuU9z1BF1djS9n2CEwfPULt/CRQZ7ifAPXqEIVkEbxCTz6QqifuuHVQppVen7dnhf9eVjyilGSVrjxcN6hxfQWTi31Uk4VrFj8K46ZPySBgmA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3015.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(366004)(396003)(376002)(52536014)(6916009)(86362001)(71200400001)(33656002)(5660300002)(9686003)(55016002)(2906002)(66946007)(54906003)(66556008)(7696005)(64756008)(8676002)(478600001)(4326008)(66446008)(66476007)(76116006)(316002)(26005)(8936002)(186003)(83380400001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: JP9vOpYHAWgvrxVSTlk6yav5J9OgbSwFmY4DWc1jAnU4aSxhXnWEksbw8Ukz/+aQ0/3bnZqUo0AUpp3/XzNbl4OkzheiK7+ienUFEP4/o/t7y9Ne/+okKFKSQ/Fp5q0sBwwHduBUzKlUuDTA8Ad7tpK6wsuJF5W0zEHnOOElv3cJDbBkP733ihAhBUi9OZri44dbFuAIocMMJ4v9dRGSHp7Ufa6n0t1itpapSa0BFDoYAmYT3LRhHWxkTbK1mkQspAMAm3AOktQKQSlvUwWwRszbXtLeWOkiVzIcsKTFXhRRcQO+Qwz9rO1wVMWCIoKikquQOHAoiuHQG+sBfHAaRR/7/AI/AXwNGD4E8Zx2JzyCuGvHtfbyF0jc5mN2AfaSnqMaH+I0rlUjarZMZFt1vkHB2dNieJtkxfXIdYq0AD9HaHlqLuEdSiUu7UNtPomvkfuMcmoef80H37pl+7JI60ZCwWXQuP7MkrofdjpeUjMRfPWWwVa5VVcTZ90OSdlciVqpLgvjgaZ+uQ3U+MciDreBCKqQwqcTDo3iM8P5vC7I18LaWhDlMXLX9ENboVmJI4bG1kPRn8RjZcRHOiyr/bHfVkWj41wrVLZHYEq8/hLSCUJ9bNrdt0gZ2Q88mvbxVPze7cTmMtEUFkhYSUbc8Q==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3015.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 436e3bdd-fedb-46eb-b1d6-08d8699524fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2020 01:14:16.2319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mau7XgCUh5wOB52itddPCJOnXwugUY1CIhDwV3nq3uVyMEoAX+ueN50CxKUPeH+rRuLnjjc2Ti1/uMiPPS0bG8lsggBRm+6ZBYx2F8vztRWUy3saCI3OZXYhnBbUDyLq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2696
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Michal,

>-----Original Message-----
>From: Sudeep Holla <sudeep.holla@arm.com>
>Sent: Tuesday, October 6, 2020 4:08 AM
>To: Zulkifli, Muhammad Husaini <muhammad.husaini.zulkifli@intel.com>
>Cc: Michal Simek <michal.simek@xilinx.com>; Hunter, Adrian
><adrian.hunter@intel.com>; ulf.hansson@linaro.org; linux-
>mmc@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
>kernel@vger.kernel.org; Raja Subramanian, Lakshmi Bai
><lakshmi.bai.raja.subramanian@intel.com>; arnd@arndb.de; Wan Mohamad,
>Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
>Subject: Re: [PATCH v2 2/3] firmware: Keem Bay: Add support for Arm Truste=
d
>Firmware Service call
>
>On Mon, Oct 05, 2020 at 05:04:10PM +0000, Zulkifli, Muhammad Husaini wrote=
:
>
>> To be clarify keembay_sd_voltage_selection function as Michal's
>> prefers is actually using the firmware driver. This function located
>> in firmware driver.
>
>OK, it can be just one function place it in any file you think is more app=
ropriate
>need not be arasan controller driver. Any reasons why this can't work ? Ca=
n even
>be in some header.
>
>int keembay_sd_voltage_selection(int volt) {
>	int res;
>
>	arm_smccc_1_1_invoke(KEEMBAY_SET_SD_VOLTAGE_FUNC_ID, volt,
>&res)
>
>	/* appropriate error check if needed here */
>
>	return res;
>}
>
>> I will call this func during voltage switching from arasan controller.
>> I believe this implementation require DT to specify the compatible
>> name and method use either smc/hvc.
>
>No, use the standard one as detected by arm_smccc_1_1_invoke (It calls
>arm_smccc_get_conduit internally and use SMC/HVC based on that)
>
>>
>> Are you saying that by using simple smcc based function library I
>> should call below func() in arasan controller. For example
>> 1) arm_smccc_get_version(void)
>> 2) arm_smccc_version_init(arm_smccc_get_version(),
>SMCCC_CONDUIT_SMC);
>
>Nope
>
>> 3) arm_smccc_1_1_invoke(KEEMBAY_SET_SD_VOLTAGE_FUNC_ID,
>voltage_value
>> ,  &res);
>
>Just this.
Is it ok not using the centralize firmware drivers?=20
I would just revert back everything as in V1 by directly call the arm_smccc=
_1_1_invoke in arasan controller.
=20
>
>--
>Regards,
>Sudeep
