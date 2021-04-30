Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F67C433B4
	for <linux-mmc@archiver.kernel.org>; Fri, 30 Apr 2021 10:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7D68613D9
	for <linux-mmc@archiver.kernel.org>; Fri, 30 Apr 2021 10:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbhD3Kp4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 30 Apr 2021 06:45:56 -0400
Received: from de-smtp-delivery-1.mimecast.com ([62.140.7.241]:40201 "EHLO
        de-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229849AbhD3Kpz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Apr 2021 06:45:55 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com
 (mail-cwlgbr01lp2053.outbound.protection.outlook.com [104.47.20.53]) (Using
 TLS) by relay.mimecast.com with ESMTP id de-mta-6-Fbehm8RlMRmkeoOgjm058Q-1;
 Fri, 30 Apr 2021 12:45:04 +0200
X-MC-Unique: Fbehm8RlMRmkeoOgjm058Q-1
Received: from CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:89::10)
 by CWXP265MB4008.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:126::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Fri, 30 Apr
 2021 10:45:02 +0000
Received: from CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
 ([fe80::a91f:361d:5554:3958]) by CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
 ([fe80::a91f:361d:5554:3958%5]) with mapi id 15.20.4065.027; Fri, 30 Apr 2021
 10:45:02 +0000
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
CC:     "pali@kernel.org" <pali@kernel.org>,
        "huyue2@yulong.com" <huyue2@yulong.com>,
        "tiantao6@hisilicon.com" <tiantao6@hisilicon.com>
Subject: Re: [PATCH] mmc: enable UHS voltage switch for SDSC if supported
Thread-Topic: [PATCH] mmc: enable UHS voltage switch for SDSC if supported
Thread-Index: AQHXN3kp02z8n6vh+UmW3TCHxA6qwqrM7HJ8
Date:   Fri, 30 Apr 2021 10:45:02 +0000
Message-ID: <CWXP265MB2680E13C9509570773ABD792C45E9@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
References: <CWXP265MB2680766F673A99D2F296B878C4469@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
In-Reply-To: <CWXP265MB2680766F673A99D2F296B878C4469@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [185.80.168.10]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5e42933d-171c-4a8e-3be2-08d90bc50293
x-ms-traffictypediagnostic: CWXP265MB4008:
x-microsoft-antispam-prvs: <CWXP265MB400826F3FF040DD4D01BBBF6C45E9@CWXP265MB4008.GBRP265.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: N/wVmkxVh3JuA3Bk6+BFGRj/kVRuO5fE1LtabCiH1P00q5hKw184dgVjsXsAxAErV9M+d5aZM7FSKduTiGQuZFkCAF1ErOHwRwE9tNbroqHhUiBuV1yq4R/+ZbBFJnkFHmvO0WV32pZF5pyKm8BTcu9HlXH5Hk28C6lrTMCqB7HyuRwm4nxRRdGFour2NvAWqXqBjeoyApoqvx3kIBQt3e40BDyzmt5AAdpmjupRb38gejikHu/vd847aOlN6yic4rsQaFxqmIDrY+tlCsgtmrRngNpR68JofMsx5UTgeoS+6LM+pWwsbV6uqxNvMZHD6a83yhlitzZUhskR2NS0bF5S6DCP7hVWHL7bNYE5OFAv5Qf3Pzh3L0vSHTs6KE9NETF9at+jCwnaO76L5Hc+hlefkD6DpQD4KOrqTTZpi1lOZfQSp6ZnlV8TOQlXqqPu+3nn7n8kNCgIS3s8CNcZiQxyEb4lwTHf8NAx3aAOHBh1J6Mo93FYHp0+kahrP4wHj6jLh9qMZa9wK4eYcEtDO+bWsmKviwDyUA9x3+GlY52QtsytrMWB69Ps+QiPLZwxnNCIxy/3w5YxZ94bdkadpfj/8fwO8g8mcgcjFwF+xX4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(39830400003)(346002)(136003)(396003)(366004)(376002)(7696005)(122000001)(66556008)(9686003)(66446008)(8936002)(71200400001)(64756008)(38100700002)(110136005)(52536014)(55016002)(316002)(66476007)(5660300002)(91956017)(4326008)(54906003)(76116006)(26005)(66946007)(6506007)(33656002)(478600001)(83380400001)(86362001)(53546011)(186003)(8676002)(2906002);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?yOTuETUOzMb1oyHekb8DKCbq97XZMsew2lku6CKunKzVyA9ZCz5wIhAX76?=
 =?iso-8859-1?Q?SrGyczuHKXn8fo+AVZ4nUPG3mt+vo6a7MXcTudXHmDq9WIgxdYX6S8L23/?=
 =?iso-8859-1?Q?W8uyfft9nhy4KGwlUxgcnV+At5UBRzZlO3ye5KyN4B0RyRlo+w54h36nbY?=
 =?iso-8859-1?Q?U1epG6yitwwTjFNCg1O8jk4Nb+PNCBdixZ4oTHzZDL3yHDfiT73Vm+fkCM?=
 =?iso-8859-1?Q?T1zuT8qex8N8AgXRDMGuJ/cz7baIvzjetib++Z0wii6be7wCprYN4QVjlR?=
 =?iso-8859-1?Q?9Wjzdg9sCvnZbuBs4yiTCCbYGhe57ltVIYLX6gCZ/g/cZge9skufBPi84+?=
 =?iso-8859-1?Q?SQMPsrA6HU7Hu1ikwdE/u6CTBrS8nncwBMrbekIVfOWZDPcfrI4NM14/zx?=
 =?iso-8859-1?Q?OSp6OdnpuuXnmNnrgBsrok3f7HW27prnbSY/v80JupLs5lCTdWq0QtjG9b?=
 =?iso-8859-1?Q?gx/7vGdmOE6pEKHuoFU2fxh36qe5swV4P0E7sPmD/Ztu6WNKvxozzlAwYu?=
 =?iso-8859-1?Q?8ogC0qeWXAzlDO8Wmrt8T3K6aKxyuWPXLdKrCOnP4j2Zkv1b0k5ZxIQs7X?=
 =?iso-8859-1?Q?40VpyImxDX5lIIcc1q/NtLmU13HjcFFfhpf5lieYQsmfisYYNU0mFFmUXI?=
 =?iso-8859-1?Q?2xrSLLE8ZBCREUAh9cf3cNvPiKZ4ROGRUqbVnc21WWMV3fB+63tbBODA8q?=
 =?iso-8859-1?Q?ak2BI84DC2ilNtxjvadkbFBKKlLAut1RxWIteRlE4t29yUD//avmi2/w+N?=
 =?iso-8859-1?Q?OcTdNsEi0SVmkKLT+1BWRgklgut3Kcf+H2pOV14QJxYMJk3E3NqzjI6zGb?=
 =?iso-8859-1?Q?Y68IEN8d+3Futoo3aWTTEdPh2Wa5xTmIQFMG4nuSsJ8pwyw8EyRLQcb3yK?=
 =?iso-8859-1?Q?o5zNGE+SAJW26cHh+sjBP5rK/CgpA5O9JimrdSBSYqIC+KdFuzC8a1v1eO?=
 =?iso-8859-1?Q?/d4ZF60+gA35U/drhBDNnfUWlFDFmwbpYpUmGC6mvpJbiLhro2PQiHJ7t/?=
 =?iso-8859-1?Q?flqNocOa5CcxPjHyTx0i659ollyxOV0ny8ZrPrN5RjFw/G+PSeixPEOkkQ?=
 =?iso-8859-1?Q?7knmIapw3F4XFphaoA3g4BDL0nz1u/6QkO7EBgU2wdIdqy4LD4I3RT7m8w?=
 =?iso-8859-1?Q?B6It+qaB+vxdEbycWaYMyouzX5DffKFl8kdcxS49Ne5RB9Em060EKfCQpj?=
 =?iso-8859-1?Q?XgBjBN5UIfKc6RyUXFkrzWs38SoNpMrH4dda8b4XNTSLAD6OV4IYuNxqP4?=
 =?iso-8859-1?Q?t70oO/WhugY4P9qVsckmhJEwTb/ikGquWHiw8tKooYYBHSDVxxu4O/vN/4?=
 =?iso-8859-1?Q?E0eokmPYWv3a74bBXng4Dt3hJXX1T7ttxgMnhP161/ERZoU=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: hyperstone.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e42933d-171c-4a8e-3be2-08d90bc50293
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2021 10:45:02.8157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 86f203eb-e878-4188-b297-34c118c18b11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 58Q5ehqJPvhSbUhQcLaiRYlyEtKxY/y8i7FSktB7BUVBaz6zAKonV/H9J6QsJs2of0NQ6zdT5KNX95ENnDOy9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB4008
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: hyperstone.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

So are there any other concerns, comments or opinions about this?


From: Christian Löhle <CLoehle@hyperstone.com>
Sent: Thursday, April 22, 2021 3:18 PM
To: linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; linux-mmc@vger.kernel.org <linux-mmc@vger.kernel.org>; Christian Löhle <CLoehle@hyperstone.com>; ulf.hansson@linaro.org <ulf.hansson@linaro.org>
Cc: pali@kernel.org <pali@kernel.org>; huyue2@yulong.com <huyue2@yulong.com>; tiantao6@hisilicon.com <tiantao6@hisilicon.com>
Subject: [PATCH] mmc: enable UHS voltage switch for SDSC if supported 
 
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
-        * In case CCS and S18A in the response is set, start Signal Voltage
-        * Switch procedure. SPI mode doesn't support CMD11.
+        * In case S18A in the response is set, start Signal Voltage Switch
+        * procedure. SPI mode doesn't support CMD11.
          */
-       if (!mmc_host_is_spi(host) && rocr &&
-          ((*rocr & 0x41000000) == 0x41000000)) {
+       if (!mmc_host_is_spi(host) && rocr && (*rocr & 0x01000000)) {
                 err = mmc_set_uhs_voltage(host, pocr);
                 if (err == -EAGAIN) {
                         retries--;
-- 
2.31.1
Hyperstone GmbH | Line-Eid-Strasse 3 | 78467 Konstanz
Managing Directors: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

