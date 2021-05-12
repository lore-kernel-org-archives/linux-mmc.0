Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A676C2D0D5
	for <linux-mmc@archiver.kernel.org>; Wed, 12 May 2021 16:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 107D9613AF
	for <linux-mmc@archiver.kernel.org>; Wed, 12 May 2021 16:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234996AbhELQcL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 12 May 2021 12:32:11 -0400
Received: from de-smtp-delivery-105.mimecast.com ([194.104.109.105]:50193 "EHLO
        de-smtp-delivery-105.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238399AbhELQEi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 12 May 2021 12:04:38 -0400
Received: from GBR01-LO2-obe.outbound.protection.outlook.com
 (mail-lo2gbr01lp2057.outbound.protection.outlook.com [104.47.21.57]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-29-XiQMOm0QMweQiFtXCrNAKg-1; Wed, 12 May 2021 18:03:25 +0200
X-MC-Unique: XiQMOm0QMweQiFtXCrNAKg-1
Received: from CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:89::10)
 by CWXP265MB4075.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:132::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Wed, 12 May
 2021 16:03:24 +0000
Received: from CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
 ([fe80::a91f:361d:5554:3958]) by CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
 ([fe80::a91f:361d:5554:3958%5]) with mapi id 15.20.4129.025; Wed, 12 May 2021
 16:03:24 +0000
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
CC:     "pali@kernel.org" <pali@kernel.org>,
        "huyue2@yulong.com" <huyue2@yulong.com>,
        "tiantao6@hisilicon.com" <tiantao6@hisilicon.com>
Subject: [PATCH v2] mmc: enable UHS voltage switch for SDSC if supported
Thread-Topic: [PATCH v2] mmc: enable UHS voltage switch for SDSC if supported
Thread-Index: AQHXR0hWieWyusUSG0mi/K66XPZUDA==
Date:   Wed, 12 May 2021 16:03:24 +0000
Message-ID: <CWXP265MB26803AE79E0AD5ED083BF2A6C4529@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
References: <CWXP265MB2680766F673A99D2F296B878C4469@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
In-Reply-To: <CWXP265MB2680766F673A99D2F296B878C4469@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [185.80.168.10]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c9263031-3140-4dc3-781b-08d9155f78cd
x-ms-traffictypediagnostic: CWXP265MB4075:
x-microsoft-antispam-prvs: <CWXP265MB4075461377B0B65C411D7176C4529@CWXP265MB4075.GBRP265.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: P0WJ5CWOz7od9yomwzhA0JQehWDTfPqAirNHvL0o+XiZUX5Yu3PcL06M10OvtZaGbQ45BiMsPXOJsRtpY4+Hxck9xAV3l/KVZnB4mQI4OMj9zr5Ilvl1TkSj1UpNfPJgMuOvJAXIzJv3IQN7ROMzeH2YL1IECXgR4joYrOE3YzTwRrmfYcnZHTEoTlLxX9hcYZQ57YYNykpe8ZrpJI/l3lDSVCa5CO9eLo9SmcaPAdJ8WJrahGYQYlf3aWupEeyIcX0Ff54UVJy0m3+a/r24fYz++0XXTMs5iFZtgB4aA7ZPjF91hTICWhAyIrb4NUXXw9UqD/TQawHFFl0Cxz16bGHDGfKLNhigLtWSbqGpeaKoe6R3vWT+VE848yWcFDgBHroAhSMenm3JNQZPVA5AuauP/q2FxS3EZQXfQpszB4TDnImuZS6xECpdhvoNCecwXmbYbdUvFHn1vsoz/4+OF0YNr5JopxElBfkWVWVNdBA4jsORoXkLZgAcCuEjLyg61COllpMhPttRmjGnp8ThnLukfIWBJcwwsXS/M+4QgAIu5hFwYOy4c1OtgLNoAOBV62VnNhk+swbvF4d1FoSxwfwCXMdyKiNhIm4jSpfnQH0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(396003)(39830400003)(346002)(376002)(366004)(136003)(7696005)(186003)(110136005)(38100700002)(478600001)(4326008)(66446008)(64756008)(66476007)(66556008)(26005)(66946007)(52536014)(91956017)(8676002)(8936002)(5660300002)(122000001)(6506007)(71200400001)(76116006)(2906002)(86362001)(54906003)(33656002)(316002)(55016002)(9686003)(83380400001);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?oMbiKQ2KRmRtD5+xHMhg9O+IkONhcG93pBE453z+ZanzwqH2lyKDbRjXYY?=
 =?iso-8859-1?Q?2C8v3ymeTyUpDUc1wR3UEjbkCotWUKFWRdWs22do2wb8EkfLOi8WM1OOHp?=
 =?iso-8859-1?Q?gmejWd1ralw9LvOoibZ7Dh69AtsKJwTuGaIDdacaGv8Pi5PfghpVIulnSp?=
 =?iso-8859-1?Q?EYDo9vaSNvKAmKUv5al+G/Nvpef7nY9zAKB7XnMZV6G5HvyDb9Vi18GPCn?=
 =?iso-8859-1?Q?BYjPvAJ8ufODLUzkr/6PTasBc9dzDA8QwqTIDR2/Qkpepdxvi6Afa3w0CT?=
 =?iso-8859-1?Q?EjakWsyD2giTufmtD5qABeSkzP+uVsz4W9sOqkDmL6mAYRJoanevfhSZ37?=
 =?iso-8859-1?Q?Of2pX7Xi4LVKT1WMECevUVI768mFvfTW5ptWu5KCbGJXD0ztcXgNDw3DH+?=
 =?iso-8859-1?Q?765SknnLgA10vrHfyx0JldpibAhx3jwl5TDqlBbRsEdRDX7Q/FkdUS2SUd?=
 =?iso-8859-1?Q?aoZUdVTWlUfTpCcrHKvHQ228hmF7YEqj1epZuxl5jJ6Sajun4K+IrsEkSx?=
 =?iso-8859-1?Q?5E5WByI8dgHnOxelKsnEHLjA3mPynv2n5bYpJW/MDjRtwf0adg9HV30jgZ?=
 =?iso-8859-1?Q?62MlSilp0/I2BGc3Bcy0mG+4QAUT5ymOVZlR9oaz/cxlDivvSP3jCR2/CX?=
 =?iso-8859-1?Q?u0iHja9Rnl+SRTKwIBcILqJMva4cgNTYqMyF5BDHbuwBKj8LoQieA8mHq5?=
 =?iso-8859-1?Q?tPZMhvHOG3fSKyY+no12p311iyYr3sdiuJQLHNK6Sm/gcDeSchiMBEscf7?=
 =?iso-8859-1?Q?6v2W8Wzx02UN+k4i5tAn/3H0Jj4n6wZlatgFADHbBeQNcv8bv9QvA1Os/P?=
 =?iso-8859-1?Q?dCjcsz71NMTsoASSeDyFGWo5lLlopwknNwGS2a0qb5qdz/z/yNOnYU1VnW?=
 =?iso-8859-1?Q?sqix5uJTCQOUdDl9hXk2yztKdIPaIVEvp7MKKwT2LonkEtJwUmUcJNmNEz?=
 =?iso-8859-1?Q?zCOvBb3kZYLGDjgB9GoZ3iZe+q1Mu3ApxACIIXXHB5G12C5qEfH1b1KdC5?=
 =?iso-8859-1?Q?BmutdSvT85vTcT+Bdp4HljHw4XHotEgXm61LI5AEgeqVfm3tHNgO20FAV+?=
 =?iso-8859-1?Q?fX3vCHt4WkO+88+M2BVEYl8kZDuKPH7ALBCnb9g48x1L4GX/6hiXjpJVYV?=
 =?iso-8859-1?Q?2EknAKRL4txwS28ywHRMTamY403/qQ+H+OikQC9GWKVbyYahqmFzu9vbMG?=
 =?iso-8859-1?Q?L7taZIKWbOVlb85SirNrg43OAbtCBn4ca3YoepASKvIAZTo1Ca0fPFyBDA?=
 =?iso-8859-1?Q?zHcuzUDNE6pjf82FKL6d7xOXc/omC7jmyD/uEZKl+cY7le4je3aM3lMfqc?=
 =?iso-8859-1?Q?7FmGgsBALJLMjXYtL0rJz0ojcuYhj2ypMXi5wgiU5F29aZM=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: hyperstone.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c9263031-3140-4dc3-781b-08d9155f78cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2021 16:03:24.1278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 86f203eb-e878-4188-b297-34c118c18b11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O2gGMULAipk1j6BKzg++NwwkFU3pq9wE40+I14btPfltHDnuh+Y8702sXDl8xLJM9r1NEeaQtU1/yCfWRd7tnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB4075
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: hyperstone.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Ignore the reported capacity if the card otherwise reports UHS support.

Let SDSC cards reporting UHS support (except for the CCS) attempt the
voltage switch.
Up until now such cards would be initialized as UHS,
supporting UHS features SDSC cards are otherwise barred from,
but skip the voltage switch.
While strictly speaking a SDSC card cannot support UHS in compliance
with the standard, there is no good reason to throttle them that way.
Especially for pSLCs in practice such cards benefit greatly,
as they can be new and UHS supporting, but must not lie about their CCS.

Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
---
 drivers/mmc/core/sd.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 2c48d6504101..62d02f1dc924 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -847,11 +847,17 @@ int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid, u32 *rocr)
 		return err;
 
 	/*
-	 * In case CCS and S18A in the response is set, start Signal Voltage
+	 * In case S18A in the response is set, start Signal Voltage
 	 * Switch procedure. SPI mode doesn't support CMD11.
+	 * Strictly speaking, S18A is not valid if CCS is not set (= not SDSC),
+	 * so one would have to OCR for 0x41000000.
+	 * We choose to ignore this as SDSC cards that report UHS voltage
+	 * support should not be throttled artificially by the standard this
+	 * way.
+	 * SDSC cards that 'accidentally' reporting UHS support by setting the
+	 * reserved bits don't seem to be an issue in practice.
 	 */
-	if (!mmc_host_is_spi(host) && rocr &&
-	   ((*rocr & 0x41000000) == 0x41000000)) {
+	if (!mmc_host_is_spi(host) && rocr && (*rocr & 0x01000000)) {
 		err = mmc_set_uhs_voltage(host, pocr);
 		if (err == -EAGAIN) {
 			retries--;
@@ -1109,7 +1115,14 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 		}
 	}
 
-	/* Initialization sequence for UHS-I cards */
+	/* Initialization sequence for UHS-I cards
+	 * Strictly speaking, S18A in the OCR is only valid if CCS is set, too.
+	 * So SDSC cards should be excluded. We choose to deviate from the
+	 * standard here to allow SDSC cards to utilize UHS if they report
+	 * supporting it.
+	 * Fortunately, SDSC cards reporting S18A and the related bus speed
+	 * modes on accident, by setting reserved bits, don't seem to exist.
+	 */
 	if (rocr & SD_ROCR_S18A && mmc_host_uhs(host)) {
 		err = mmc_sd_init_uhs_card(card);
 		if (err)
-- 
2.31.1

Hyperstone GmbH | Line-Eid-Strasse 3 | 78467 Konstanz
Managing Directors: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

