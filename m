Return-Path: <SRS0=fQuC=DO=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24954C4363C
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Oct 2020 03:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C03A9208C3
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Oct 2020 03:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="nK3hOGaA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgJGDmB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 6 Oct 2020 23:42:01 -0400
Received: from mga01.intel.com ([192.55.52.88]:55509 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbgJGDmB (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 6 Oct 2020 23:42:01 -0400
IronPort-SDR: aGMiU5KjFLHqJqFMTns9lrsQbLSA0OKSw3IVkxmO9Yw+/tV2Sbu/2PmO0TvQXObswyXnVUcSKG
 45ZaFKaF2K+g==
X-IronPort-AV: E=McAfee;i="6000,8403,9766"; a="182274765"
X-IronPort-AV: E=Sophos;i="5.77,345,1596524400"; 
   d="scan'208";a="182274765"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 20:42:00 -0700
IronPort-SDR: JCLrwwVCKi2thxa9WGdC6XnLK6Bw3lDtJPdn7JimKm6G0OuJV3nEW07WzoyfrpFumuXYldEDp/
 meuHyU2Ps82g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,345,1596524400"; 
   d="scan'208";a="342662593"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga004.fm.intel.com with ESMTP; 06 Oct 2020 20:42:00 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 6 Oct 2020 20:42:00 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 6 Oct 2020 20:42:00 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 6 Oct 2020 20:41:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wm1SLsphU8k1YT5NXGJesjMkpaCnnOo6v7M7zSJLreCi7g64vFMXPjSRfuqeLNsOwIMuRjatT5qePESoS6aeootB3fSqUYjAgtTnphURMz5sDGE1HacMcEPifMPevBCQPz8DVY/8unsw77VIzxVZdyB9dA7oz8MJ8QVKyTfJIfXwIcRm/YeWNuNp9Jw471qiBlMm3u79p9DgUSRmbuGNW0eOraCIbLrO+bZ0rdhENBWHJAjvwDktg1DkSe7BgxTwHxnh6OiSvEw/tAy2hR520s9QJwSrNZrRaxd5DvtQlvlflR2+b92D0YscbfgIFxujcY5ScnipjjHyibqBwvDWzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nfLSSnELY0lhNtS9knkI5qHDSEPjPG/vVcDHdAfHtvg=;
 b=fMLPi5SOqpwxgCUvQZ3IQBLjfzTUnoOYLdXKpaJPYEHLr2NFKGDMEncE4mDm5aaMsSzEMB3xoFHxkAW1CG6ApHXR3tHLMvgHbSTr4ZvPQs2VhkjJ2kdm8a6XnTb+oZXnk0hrvZDLCooJJHQE6gKzue8Z2HkaU+61zXfKkuCDSNy7/Wd/R0Gshl0UL0knQKXjLftDLEUgOvxJrgqspzRxnSoYCxVCcgqGoOGoNnlHuYs3fUE7SX5YIWv7/Vh7IaCsvcICmIiw+AqAWIA40nfnw22c7iAzjtJ6aa6yPK83cm5La+7sApnQcv+1QTj/Ki/YoZVPp/blnGnSvTG5dVHFTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nfLSSnELY0lhNtS9knkI5qHDSEPjPG/vVcDHdAfHtvg=;
 b=nK3hOGaAbiTbSTmkQeFgDBFUa0fFm6l/ew2fypR4dN0OlkmtVEPlCIAVSW79XwxVbAeANfLcfCH9FbPKVErWN6XCzg7MQ5U1zQavQViPF5BlluLFnZ0P8+S25Yhp+bTp6pOPauiRWazGUlEVPMCdiVURAzRviFZYoZ2hzH+QWtA=
Received: from DM6PR11MB2876.namprd11.prod.outlook.com (2603:10b6:5:c1::16) by
 DM6PR11MB2939.namprd11.prod.outlook.com (2603:10b6:5:70::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.36; Wed, 7 Oct 2020 03:41:57 +0000
Received: from DM6PR11MB2876.namprd11.prod.outlook.com
 ([fe80::c85a:d98e:fbf3:9f8c]) by DM6PR11MB2876.namprd11.prod.outlook.com
 ([fe80::c85a:d98e:fbf3:9f8c%5]) with mapi id 15.20.3433.045; Wed, 7 Oct 2020
 03:41:57 +0000
From:   "Zulkifli, Muhammad Husaini" <muhammad.husaini.zulkifli@intel.com>
To:     "Hunter, Adrian" <adrian.hunter@intel.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>
Subject: RE: [PATCH v3 2/2] firmware: Keem Bay: Add support for Arm Trusted
 Firmware Service call
Thread-Topic: [PATCH v3 2/2] firmware: Keem Bay: Add support for Arm Trusted
 Firmware Service call
Thread-Index: AQHWm/mmQ68E6v02PEeQu9XSxqgGOqmLfq5Q
Date:   Wed, 7 Oct 2020 03:41:57 +0000
Message-ID: <DM6PR11MB28767574129C0FA35B5BAA2BB80A0@DM6PR11MB2876.namprd11.prod.outlook.com>
References: <20201006155549.3595-1-muhammad.husaini.zulkifli@intel.com>
 <20201006155549.3595-3-muhammad.husaini.zulkifli@intel.com>
In-Reply-To: <20201006155549.3595-3-muhammad.husaini.zulkifli@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.203]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b64983c5-91b0-4531-5f69-08d86a72f141
x-ms-traffictypediagnostic: DM6PR11MB2939:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB2939DB85D94D89C7A8BA32A3B80A0@DM6PR11MB2939.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dEvYvc5SytXJP3qeijDatx69GGUhbFEmriBiUKn8p1HJQjMSVaUdmUaLgGG718JVDpPa/s2zk2GrAZutHbvYBhHS6DmPOGrkqnD81TnMqDPNLelpMfqytGN93JfXU5kS1ttkviTqHlBozVc2tJOC9CtJK8n/DMaHvKafTduju+30TPaM9XAymp+vtVvpAsI0jT50iHrJoA1v2F7+F+5vomQaslji7o/kg0B5IMfGqmo/ZB40rKf3GvoSBTdVrZM0I9jcdJTFFqr2MHEKG4ECDCvZG2IhiAz/o5asyOYsRBHLQ4kUbJe4HDl7zinmus1TikIDXnOIt+okERIpY7LJEA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2876.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(39860400002)(366004)(346002)(396003)(26005)(86362001)(8676002)(55016002)(9686003)(64756008)(66446008)(5660300002)(66476007)(66556008)(186003)(76116006)(66946007)(52536014)(2906002)(316002)(54906003)(110136005)(83380400001)(4326008)(71200400001)(7696005)(6506007)(8936002)(33656002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: PzF0aoo0k51brOnAuTAPgOt5FlabC+NEXFeCP1R/FP8OTL3X7Co8HMzb8e20htUsZWBeinFUxeuOHUsZ8XyEIZbakSYBRe0c25/RZSCs0vIrR3Ca731R3Ycb8uQ+dAkfOqDz4NQ7UVQC7IYXFnQsOCPUK6oRaqlOKrykKxgqNM4EDqSUPuO9Rep74CbQ6xKy2tvVU5V27iaE4G1XQtbCHNx9a18WEZH6vNJeZ8Kd3Kjfoxm0SiiR/yvTDXnT+AF6c4Ff6aKUBdaG50u37goquqia/Wu39SQIKEj0bXs07qcT8FtCe24GfIQkhudJHblq0SWQXwjzPVqidTTrqKKb1Z2SA7XjfFqJTFXyCwEsWjj1nvNckUN79n9oQTquln5SWmJ4vmEFcQ+PuuzZfCttMpegajXSKP4lvIP3547uJqxrt6N1s2kjRatsllxhr1G19WEvEVemDJi1WEjWm8azwqPFUzTqYlqK14GTj84rA2auHJSQ+krPy0n6i4wtAHZwzbifFDplJsSef9hjfHWY4A8m22F9pnVhLS33/+5uW2xX6tcE+AfOjNqs5TF41BY7RKt064FXilObU28zaU9FAM0wPdLuuDWvPH1W1gRMteDskngFHKDJnfMI2N7prSEprCQueRFGs+VFnF6vSkPnbg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2876.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b64983c5-91b0-4531-5f69-08d86a72f141
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2020 03:41:57.8325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bVoikYOAo17LNY+bl1KBWCoz2Y5+zIY2INcZzRr+MgE2aocHs5kMGT+PUvsKJSjU52xctIf8lYNwPUUW/TkeAD9J1hAmsC3M3bptOYS5qDr1lQYm4oX2UiSi8ywxq6Vu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2939
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Sudeep and Michal,

I would like to receive some feedback on this patch before send out another=
 version to fix the autobot compiler warning.

Really appreciated it.
Thanks

>-----Original Message-----
>From: Zulkifli, Muhammad Husaini <muhammad.husaini.zulkifli@intel.com>
>Sent: Tuesday, October 6, 2020 11:56 PM
>To: Hunter, Adrian <adrian.hunter@intel.com>; michal.simek@xilinx.com;
>sudeep.holla@arm.com; ulf.hansson@linaro.org; linux-mmc@vger.kernel.org;
>linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
>Cc: Raja Subramanian, Lakshmi Bai <lakshmi.bai.raja.subramanian@intel.com>=
;
>Wan Mohamad, Wan Ahmad Zainie
><wan.ahmad.zainie.wan.mohamad@intel.com>; Zulkifli, Muhammad Husaini
><muhammad.husaini.zulkifli@intel.com>; arnd@arndb.de
>Subject: [PATCH v3 2/2] firmware: Keem Bay: Add support for Arm Trusted
>Firmware Service call
>
>From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
>
>Add header file to handle API function for device driver to communicate wi=
th
>Arm Trusted Firmware.
>
>Signed-off-by: Muhammad Husaini Zulkifli
><muhammad.husaini.zulkifli@intel.com>
>---
> .../linux/firmware/intel/keembay_firmware.h   | 46 +++++++++++++++++++
> 1 file changed, 46 insertions(+)
> create mode 100644 include/linux/firmware/intel/keembay_firmware.h
>
>diff --git a/include/linux/firmware/intel/keembay_firmware.h
>b/include/linux/firmware/intel/keembay_firmware.h
>new file mode 100644
>index 000000000000..9adb8c87b788
>--- /dev/null
>+++ b/include/linux/firmware/intel/keembay_firmware.h
>@@ -0,0 +1,46 @@
>+/* SPDX-License-Identifier: GPL-2.0 */
>+/*
>+ *  Intel Keembay SOC Firmware API Layer
>+ *
>+ *  Copyright (C) 2020-2021, Intel Corporation
>+ *
>+ *  Muhammad Husaini Zulkifli <Muhammad.Husaini.Zulkifli@intel.com>
>+ */
>+
>+#ifndef __FIRMWARE_KEEMBAY_SMC_H__
>+#define __FIRMWARE_KEEMBAY_SMC_H__
>+
>+#include <linux/arm-smccc.h>
>+
>+/**
>+ * This file defines API function that can be called by device driver
>+in order to
>+ * communicate with Arm Trusted Firmware.
>+ */
>+
>+/* Setting for Keem Bay IO Pad Line Voltage Selection */
>+#define KEEMBAY_SET_SD_VOLTAGE_FUNC_ID	0x8200ff26
>+#define KEEMBAY_SET_1V8_VOLT		0x01
>+#define KEEMBAY_SET_3V3_VOLT		0x00
>+
>+#if IS_ENABLED(CONFIG_HAVE_ARM_SMCCC_DISCOVERY)
>+static int do_fw_invoke(u64 func_id, u64 arg0, u64 arg1) {
>+	struct arm_smccc_res res;
>+
>+	arm_smccc_1_1_invoke(func_id, arg0, arg1, &res);
>+
>+	return res.a0;
>+}
>+
>+int keembay_sd_voltage_selection(int volt) {
>+	return do_fw_invoke(KEEMBAY_SET_SD_VOLTAGE_FUNC_ID, volt, 0); }
>#else
>+static inline int keembay_sd_voltage_selection(int volt) {
>+	return -ENODEV;
>+}
>+#endif
>+
>+#endif /* __FIRMWARE_KEEMBAY_SMC_H__ */
>--
>2.17.1

