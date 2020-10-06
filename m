Return-Path: <SRS0=uM1y=DN=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E9EC4363A
	for <linux-mmc@archiver.kernel.org>; Tue,  6 Oct 2020 02:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C723A20870
	for <linux-mmc@archiver.kernel.org>; Tue,  6 Oct 2020 02:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="Dc++q8aG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbgJFChU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 5 Oct 2020 22:37:20 -0400
Received: from mga17.intel.com ([192.55.52.151]:13977 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725909AbgJFChT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 5 Oct 2020 22:37:19 -0400
IronPort-SDR: qBBBYC0Lt6WWn/gVCd9bzVRkNQfsegVzgSJCZSMtGWB5xEj68a2ZlsWEHfbUtfMK9DxUCtgia/
 HMVJHJ8Zwu6A==
X-IronPort-AV: E=McAfee;i="6000,8403,9765"; a="144228490"
X-IronPort-AV: E=Sophos;i="5.77,341,1596524400"; 
   d="scan'208";a="144228490"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2020 19:37:16 -0700
IronPort-SDR: MpXM1MZf4oqqaeeBLZWNVUP74ywSGtveurnv9Nni0Doi61AjIzIk0SHkEsXrposybMLXe4Z6Lw
 tvUmDOWEsfaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,341,1596524400"; 
   d="scan'208";a="517688478"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga005.fm.intel.com with ESMTP; 05 Oct 2020 19:32:29 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 5 Oct 2020 18:22:34 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 5 Oct 2020 18:22:34 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 5 Oct 2020 18:22:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HMekWhXDjtPxgUQtwOiznHSXbuuQp/R5r3VHRtwWoCtQVn/FgsannMkBVQ+9e1Cua/f/1ofRhKf3xuqAi0GdMM5/UUHLDqrAe2G9FcFLHJ+cBfVt1L3+GsCxDX2xKCzJY8cVSntneFeKqH8AFkGiA/N8VRIZccs82OSCxvT2wbQKoRSDX89WJjOxS8EDmHlsKOjy4EQhxV3kTAstAIb6+1CGsr4J0DtraHI7AtAJVX2LnkbcnPcOjpY77eA5QXFo8H+g+QO+Ea23dvz2KbYtvazhgMNcgZiOhsatPqCWT69nRiQL0ad066l4PoxR+fVsRXdoFJn20gsNKKFGUuTPQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iSAs58AQjt/g8IoEOgIwcNzJ8ouBObUZjDgJbbabNP8=;
 b=cTTJocjscHxidrTVjI7Ii6AL9RSwIqcT3IrZiTLjTJ3qAs1LGy7ZArWWABjhbWKrOLNUA6/gllNZhaMAyYFNJUwq1gls/6i5UNJt2+YmRwqmToNiP+RDu4B8aKqa4cujWyWNj97NpFXxvdDEf7jB2yoEUTg06Q2efKoArD2o9EiZfK2CY7RsRsAkJOoGwbUFWFxSq9I70TEpbJDEwunhWftiIXK4j+5ePA/VHG2xxMuDOjRs4ghGFxpKck1PJCQ4S6ip/n83F/jftQmR1fKrljalmRxp+WcZLsWvZ6TNldWHQ5i3sIopnRwhZyh5JqO9VrvTGxr6LPevKShY2OE27Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iSAs58AQjt/g8IoEOgIwcNzJ8ouBObUZjDgJbbabNP8=;
 b=Dc++q8aGFXXG+zStPpOVH7HBn7Kj5hmOPubnkKYPANCtAHni211+kPBRrV+0fkvPcCYaaLej/WJ+GaL+AFv6eYR2xNF2gjkdQgPOczdkaKe+EfaGMetaYvohLU/TaB+JfBcYKlqoPLixo5kVr/jnpEi5LknFeYh6rsslLPL+xBE=
Received: from BYAPR11MB3015.namprd11.prod.outlook.com (2603:10b6:a03:86::14)
 by SJ0PR11MB4957.namprd11.prod.outlook.com (2603:10b6:a03:2df::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34; Tue, 6 Oct
 2020 01:22:31 +0000
Received: from BYAPR11MB3015.namprd11.prod.outlook.com
 ([fe80::e1af:b9b8:7e60:e77c]) by BYAPR11MB3015.namprd11.prod.outlook.com
 ([fe80::e1af:b9b8:7e60:e77c%4]) with mapi id 15.20.3433.043; Tue, 6 Oct 2020
 01:22:31 +0000
From:   "Zulkifli, Muhammad Husaini" <muhammad.husaini.zulkifli@intel.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     Michal Simek <michal.simek@xilinx.com>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>
Subject: RE: [PATCH v2 2/3] firmware: Keem Bay: Add support for Arm Trusted
 Firmware Service call
Thread-Topic: [PATCH v2 2/3] firmware: Keem Bay: Add support for Arm Trusted
 Firmware Service call
Thread-Index: AQHWl/61fFIKn6YDxkK/M5PRzKZE1amC4PoAgAEZhQCAACt8AIAAMNyAgAAQH4CABEzPQIAAA8WAgACDndCAADs7AIAAVytQ
Date:   Tue, 6 Oct 2020 01:22:31 +0000
Message-ID: <BYAPR11MB301505B60397A083050E962EB80D0@BYAPR11MB3015.namprd11.prod.outlook.com>
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
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.220]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ba99bb91-c9b3-409d-be3e-08d869964be3
x-ms-traffictypediagnostic: SJ0PR11MB4957:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR11MB49573C416157B21F0A26A5E0B80D0@SJ0PR11MB4957.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OYHnvKChLPmWojpRzcxtYNGkz05kPX6DYRUpw+xSu5802pGfpHuO9CyGO/HO7FMTOyOXIZ72bIYpTmNhAV2tZrM3jGbdhz3ojxyDYqyPWaY42S15numYyCPW2YJv4yXgPpouL7WWQZqsqZzCFzGuV4ViK6GyA8Nen+bIAetaaH3OHMkgG5GB/JmSUHjLfY8fo187dp2FD3TUks4juhNjy0Pfj34lFbPoP2KI64KZHdpJ0HSY9+R6i+tnt/UG874lKwdrfM6lpYxTnJVgA5xK2lkvVgH+Z7r9c+DSaeAfzo8uTqxqihgHSRMo07KNST//aj4Vu0o+F1O6FqtAVs1POw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3015.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(136003)(39860400002)(346002)(396003)(7696005)(9686003)(478600001)(107886003)(8676002)(83380400001)(8936002)(26005)(76116006)(52536014)(316002)(2906002)(54906003)(33656002)(4326008)(55016002)(5660300002)(71200400001)(66446008)(6916009)(64756008)(86362001)(6506007)(66476007)(186003)(66946007)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: t6X6fWTHvly/7YaKw5F44cSk0rid7Dq92eA5xNthbqdJjVJ4+g8HmiNNNlNGDiZ6fJ6XWE/lqDtLueCzSXdv/T5KUCnHpgOG4OnKYE4Q7g8UsOwVA2BpZkUtly+xYaTfwmrExSjF+NkpsUmEQe+XIqpy2XqeTq/l0vl9YjLH81efJq8tdIOP+rvNQGEUtEjPG+zDzMHRyg5MEsMWPYRkE9NnfVyns94M/cGuYl/eHy0jT5GEefYHrH/5wQp0Z/NojB3qp3V2/Qi/+qT22CM5r5SwXnZkPXAXENHredWrlyx9qn4B5QwHTSXb5TYoq/ECJ+OZ6fAsfIUxaNI07v6iPaZShme3YRwCzuXaB4QMIkBgYRsBL5IadI4HhEJH5xtDz/cKLBkA/W3VNVb1jCTL+j2Lsxt58khcGfl2bT2dcYYsyBPooYObHvDJd7y3n4SjmumXbVhR52O7MZjnQhfVmMI+/BB+lQmJsnjGPNGCdqopoS8D2c9qOKu4IGXngtS18HrcbFZ68yaB/5mdvCRt1LPQ9ftfY6SdUIa4da53KQx6FFmxES6TtoUDV09ZnOkTFSa8iQoOdK8dYc+s/ltesXTIHWnpjKAlTpWxjD0+PZj6Cab1ejuwMMqjRY4K86iPwfCOIgW0Cvf2/a3TTk6+sA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3015.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba99bb91-c9b3-409d-be3e-08d869964be3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2020 01:22:31.0783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8dm9pruFfmAIjPLR55DmqmCY5yrdx9eGcdb+0ytOOXr8w9GT1XidxTC/fuJ1pZWmr2lUWpDwZLhDHS52Sm50BJmeekT2AE8XTJGQxRNbt9Aqj++Z+TYWjWC4eclgWKpB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4957
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

HI Sudeep and Michal,

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
Yeah I believe it can work. I will create one header file in include/linux/=
firmware/intel/Keembay_firmware.h=20
To handle this func and arasan controller can call this func.
Are you guys ok with this?

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
>
>--
>Regards,
>Sudeep
