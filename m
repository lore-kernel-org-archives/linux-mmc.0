Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB740C433B4
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Apr 2021 13:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B30D61460
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Apr 2021 13:34:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236428AbhDVNen convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 22 Apr 2021 09:34:43 -0400
Received: from de-smtp-delivery-1.mimecast.com ([62.140.7.241]:45147 "EHLO
        de-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S236426AbhDVNem (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Apr 2021 09:34:42 -0400
Received: from GBR01-LO2-obe.outbound.protection.outlook.com
 (mail-lo2gbr01lp2058.outbound.protection.outlook.com [104.47.21.58]) (Using
 TLS) by relay.mimecast.com with ESMTP id de-mta-4-EQrGWWPOPj-ObeQanSyV-Q-1;
 Thu, 22 Apr 2021 15:18:07 +0200
X-MC-Unique: EQrGWWPOPj-ObeQanSyV-Q-1
Received: from CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:89::10)
 by CWLP265MB2227.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:65::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.20; Thu, 22 Apr
 2021 13:18:06 +0000
Received: from CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
 ([fe80::a91f:361d:5554:3958]) by CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
 ([fe80::a91f:361d:5554:3958%5]) with mapi id 15.20.4042.024; Thu, 22 Apr 2021
 13:18:06 +0000
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
CC:     "pali@kernel.org" <pali@kernel.org>,
        "huyue2@yulong.com" <huyue2@yulong.com>,
        "tiantao6@hisilicon.com" <tiantao6@hisilicon.com>
Subject: [PATCH] mmc: enable UHS voltage switch for SDSC if supported
Thread-Topic: [PATCH] mmc: enable UHS voltage switch for SDSC if supported
Thread-Index: AQHXN3kp02z8n6vh+UmW3TCHxA6qwg==
Date:   Thu, 22 Apr 2021 13:18:06 +0000
Message-ID: <CWXP265MB2680766F673A99D2F296B878C4469@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [185.80.168.10]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 48f29805-56d5-48a4-37e9-08d905911116
x-ms-traffictypediagnostic: CWLP265MB2227:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CWLP265MB222783FD5F922708675D84DBC4469@CWLP265MB2227.GBRP265.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: /rHwmNMum3/Kb2ygps0elmbvuIa5+eFFrJPzuE5XI8n7Py+yoP6e5qr+MHflOhQ0LDY6nOwXN9AVLsBNZFNnMBkfSd+wajix3guO8g9uGB/5+Evik7lLQ5YukuFza1D2ulabODPeo76VbdlU/SLLpzeUPiNPCJgX2FrFixeKvXPwpX+/dGS/9/fiCmbl4lGtf27ao/zKLSLa7NnRgTKHXCfquC3kK/Fip7UUvLZXR7Npv1KeKyvHbX373lcodbvrGHqgRPoPHE8JlknfYPydoSZ/OVtaLt9NOadU6iY55csPEy9DvQEVEw9CjEqFHimdYRH3T+F7z6YNDnLZqdajhdjDfWy9vAseidvbOGd9//BkcQRWWk+afZMN1gOOvgqPPXKLu3Cwe3hW7atbLtuSqi73KD7cv8uGTMaR9QlC7FDvHjbEj/LsLmyprhxHK1OWVqcPWHDxK2EG7zcQbQczRA4laY8kAZrEsolcfiytXDgH1ZzKBL00JPKHlM2MtDpPJgjg8DM3OEQGhrNSiyIT4v5rATKxuIpd0VMhNlDH3ZdATYdIQWaYhS4k7/NA6TSkNJU3hF5I+wfMTYwlqiILjQEVev1ZPHzhQTtsiAHRWUA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(39830400003)(396003)(376002)(346002)(136003)(316002)(71200400001)(478600001)(64756008)(5660300002)(76116006)(9686003)(52536014)(122000001)(54906003)(66476007)(83380400001)(186003)(66556008)(33656002)(66946007)(7696005)(66446008)(91956017)(4326008)(8676002)(55016002)(26005)(86362001)(8936002)(38100700002)(6506007)(2906002)(110136005);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata: Q4+eKk3xRBTZQI7rV0MSM4ybS6x40B0BAS5rFFkqXLSN+V1DNOq1pezyvt9dBvfgcUXMETpv7UzwG6PJ6Fq938/H/NOuY0ZAIH1BqLZCnQZzp1m2+TThwESGtbJV87C9jjeAfKfsgZ3Jlczs4OBRWvlSUFc25+snzh9dwervVJk5jHHWzgkEbDFjDO/0KQUB5lx3y4Yl/yVysK/9ClkdUifvnAe/QSY8qvsQA9uC/v8CPlIys48uAnFpOolSEx25B0rcl46XBPa6+4qY84nn38IAxB0a8gNRvFH2kfK3MPGAp+XirfMgyGHWOMTbJ/zFJdYO/M5fhigzJ8SzHpysuRvhbebtPtyIVzf7QsX0C4h90N1SvWDl2aNbsm7OR7qWx9NLqm2aw44nwZmelE0rzS+7PA39gsTiQ6RquKIiwQRVbcX3In13/vV8wJqlOJSs/EOIpH4hIgKENJ9IOqNJyTbuSzeAv2tYFAjC1QDrhrQlj+QVwlKDoT66rvq2LNs8Z0cPDGPyFK65wwbVKfCBE3Sv62MJFfx45qtHDaZcUpFrey9KDgm+NW4uUhBGQCu2NDAVEL226oeyLC0WERaS/OoVgLq4adk1zzVUXSJ9fwHWUFFC/lr/Oj9aACbVnL9iI3XZvUd6BlE+l+IaXrCDVjQsUtXXtBpXztnSa42teaMEZNYii7hv6tz52yN2TSmF5LKFAgsK6L/5Haz5ECIS5wfCCSIiS7imgCcfUmCvC+Q=
MIME-Version: 1.0
X-OriginatorOrg: hyperstone.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 48f29805-56d5-48a4-37e9-08d905911116
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2021 13:18:06.4153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 86f203eb-e878-4188-b297-34c118c18b11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qLvYbNX7k2pwerQkKxkmn/g+52iI+355Pym5oCkYIy4fTiuYo2kuX2g5CD0AiTQF3PBYjgdc5zycArb9YnOzrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB2227
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CDE5A68 smtp.mailfrom=cloehle@hyperstone.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: hyperstone.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Ignore the reported capacity if the card otherwise reports UHS support.

Currently SDSC cards reporting UHS support except for the CCS do not run
through the voltage switch.
While strictly speaking a SDSC card cannot support UHS in compliance
with the standard, there is no good reason to throttle them that way.
Especially for pSLCs in practice such cards benefit greatly by this patch,
as they can be new and UHS supporting, but must not lie about their CCS.
The behaviour of linux-mmc for SDSC is deviating from the standard anyway
in such a case, as the card is treated as UHS card not supporting the
voltage switch in general.
Such a card will come up as
mmc0: new ultra high speed SDR25 SD card at address 0001.
Thus the subsystem will support CMD23 and others to the card.
But if we deviate from the standard anyway, then we might as well
not throttle SDSC to 25MB/s.

Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
---
 drivers/mmc/core/sd.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 6fa51a6ed058..281ca2da8e0b 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -841,11 +841,10 @@ int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid, u32 *rocr)
 		return err;
 
 	/*
-	 * In case CCS and S18A in the response is set, start Signal Voltage
-	 * Switch procedure. SPI mode doesn't support CMD11.
+	 * In case S18A in the response is set, start Signal Voltage Switch
+	 * procedure. SPI mode doesn't support CMD11.
 	 */
-	if (!mmc_host_is_spi(host) && rocr &&
-	   ((*rocr & 0x41000000) == 0x41000000)) {
+	if (!mmc_host_is_spi(host) && rocr && (*rocr & 0x01000000)) {
 		err = mmc_set_uhs_voltage(host, pocr);
 		if (err == -EAGAIN) {
 			retries--;
-- 
2.31.1

Hyperstone GmbH | Line-Eid-Strasse 3 | 78467 Konstanz
Managing Directors: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

