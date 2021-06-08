Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9156C47082
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Jun 2021 08:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A112361287
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Jun 2021 08:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbhFHIrg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 8 Jun 2021 04:47:36 -0400
Received: from de-smtp-delivery-105.mimecast.com ([194.104.109.105]:54101 "EHLO
        de-smtp-delivery-105.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231124AbhFHIrd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Jun 2021 04:47:33 -0400
Received: from GBR01-LO2-obe.outbound.protection.outlook.com
 (mail-lo2gbr01lp2051.outbound.protection.outlook.com [104.47.21.51]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-19-h46TomwCMYWiptM9mpuXhA-1; Tue, 08 Jun 2021 10:45:39 +0200
X-MC-Unique: h46TomwCMYWiptM9mpuXhA-1
Received: from CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:89::10)
 by CWXP265MB3351.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:da::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Tue, 8 Jun
 2021 08:45:38 +0000
Received: from CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
 ([fe80::e508:b3cb:f065:656f]) by CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
 ([fe80::e508:b3cb:f065:656f%4]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 08:45:37 +0000
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Avri Altman <Avri.Altman@wdc.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>
Subject: [PATCH] mmc: block: ioctl: Poll for TRAN if possible
Thread-Topic: [PATCH] mmc: block: ioctl: Poll for TRAN if possible
Thread-Index: AQHXXD2WfUw9V7TgJkajnPZV25duWqsJzJsu
Date:   Tue, 8 Jun 2021 08:45:37 +0000
Message-ID: <CWXP265MB2680581A95203C5CF304DDA2C4379@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
References: <CWXP265MB26809A40B098D219C44E70FAC4379@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
In-Reply-To: <CWXP265MB26809A40B098D219C44E70FAC4379@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [185.80.168.10]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 71c77fff-196a-4cce-8bef-08d92a59ca07
x-ms-traffictypediagnostic: CWXP265MB3351:
x-microsoft-antispam-prvs: <CWXP265MB3351281136CF5EB362ECDE4FC4379@CWXP265MB3351.GBRP265.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8273
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: 5crjNfJ6CTotteiX+jAYh79Ei9Uesl2Xf5GLTepV2XLuUTu7Yt3rhpcwynfNVW3fys3/Efq0jMI6j4EyrqnlCt4ErsLQkLNuF7MubGbCQuFjyKIAvuKchdAs6z8J/eBR3pdfaqV2rWujuTFBvlK4REbG1Sic53B8F0VoY4cWMo+x9LGa55waPLpaHURYqVF0J2iYhZNfV4jh30V2ysl2bPjT4BZrfKbZlm5TAH3X17uySMz3TwoeiWkem9M8kZeDGzRmOYemywIUg+0goowrCOFBHS09TP05JKrnuKiRib/pJvGcGeMHZyt0gdl1o+SV8Ge3V6XZ3LNd8ifV/I18Frdcb9FLfMpQbjXEpP69mXNEizLQC2KTWXMOtX+uCFnwdoGpN0cQVQDFJpkZcXjzNlNFiokb2csJbLj2lpbTK6USwIy3lx7iMSaJVTn6ulU1GffGp12fRoCPWwWO5KHzcyffZ7eph2LrVrVHbNSI0Qel9gYtzCJy+8HD+4QGZ0jT+VyIzrUyxAxPit4ud91iI+IkfGHaax7T5qwWgBAzkKE7Z5FBzj6rweOw1CzhEjoNU4L7X8OmAsnkixWwHHMyYymXcyk7Y02DQ0DY8muAjh0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(39830400003)(136003)(376002)(396003)(366004)(346002)(9686003)(55016002)(86362001)(66556008)(122000001)(110136005)(71200400001)(7696005)(2906002)(478600001)(33656002)(2940100002)(186003)(52536014)(66446008)(64756008)(66476007)(83380400001)(76116006)(8936002)(91956017)(66946007)(26005)(8676002)(6506007)(38100700002)(5660300002)(316002);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?PnN9idmsSjcyoIgA1zAF0XdERkXbcew0t0nO8kkpjqc37EbLlgRb2l5XVu?=
 =?iso-8859-1?Q?tlPriujGStSwar11WgEs1w2FsdwcaVfBibQ0HpEmUw0fG1kUcAAvkGnxM0?=
 =?iso-8859-1?Q?Iz8Fhmn1t9BsbaVlmck1Q/X32lcK8IFDvm6UAGN9nlHWE6ihN2w21i/Ibj?=
 =?iso-8859-1?Q?Z2IV5gIxpLUR4QGEAeVKnGF5WnxSUlvC187006Z+jUn3/AWJDUfDKzTT0U?=
 =?iso-8859-1?Q?prvST+T8K1PGyj+x/h1eRe6opbwa90ppVSDVzHELP+mYThXn+bj8I2jMEv?=
 =?iso-8859-1?Q?hZ738qlLMbVIE+VKqTx+Mek1HL9agRmAe6QIEFktTG/TY7TtHunC4WvWil?=
 =?iso-8859-1?Q?cjZMaratAKdYO383Bqx95RmP4LUV62ySklsbdWI1zr/0m2QQX3IWQCyvb3?=
 =?iso-8859-1?Q?zNJ8Wyd0ZmiXE2MVYHz3U4F9KSFnt5vpciSxU0WKR4LHcZU3c0VkKzsotM?=
 =?iso-8859-1?Q?V67UfxPujqqKWyngq2rkcxU/CQYbAA4FAzzbddXIqdaaMhQG0YbSCd/2TE?=
 =?iso-8859-1?Q?p3L09IRj9e+KZwpbGCxys1WyZvjCQ7QXWY06NAOUUbQJXSLRcT7VdY1PSV?=
 =?iso-8859-1?Q?5p2OWj9/2ftAjkTWoYWdxLUur8aC0feLlu+dhDLIJLKESxTOcMxH5W14EK?=
 =?iso-8859-1?Q?zirI69NE8/jfKTK08Emrf6c6NOcyD+Z8PLXwrHYK739Gvqbbt5iQfanQY2?=
 =?iso-8859-1?Q?CDIO4mt+xjbdWYt5g9poIIthXe47/rJDHsBWS3nQl+cEK0UCfuQs8E7a7v?=
 =?iso-8859-1?Q?1oYyIf6QqKYwnbaQq1H2RclwjBscMvl1NzljC1woq/+cPM18bcuEqVP++s?=
 =?iso-8859-1?Q?o0GBS7t6Ri5J+LEnlsLfpYEI1LRTRAcdvNZFUvjAD5Oh45sK9zx6weEcea?=
 =?iso-8859-1?Q?e9SCblrHxP3KCPGi3JPUAVWIdzCbVBKQVwAu3Yrs3L0Fh55r3W3aasOOtp?=
 =?iso-8859-1?Q?od5XON91wFlCO6i4iBRDwSQ4Y1+xL/onabQxrsT9ehB3HOcyDRBs9zNruz?=
 =?iso-8859-1?Q?S8W3YrN2RhM4XrK0PcjJi+XnyzSE/nKwvSi8vn22W+1ksDlchWCoMLxCEi?=
 =?iso-8859-1?Q?MMbp5US8FM+TMNCYbey4noyEJWPvCOIBA4vmZyWVJsdSLV0uXnl4Odrti1?=
 =?iso-8859-1?Q?zT6X/NRw1DMfkbUKJsdMVMokENNrSx4VqNkTgRc526nEPJs4PZtAzHTNqt?=
 =?iso-8859-1?Q?BTFLjPb0RJU7UMMu2Z1Mr4A0F/U/QrpMFIGGhH+5VcwPkQVMLT6no10/Z2?=
 =?iso-8859-1?Q?LinQaXoROZ9F4q1CHFDDpUqjFsyYWj+cFQZWVAyiIBvZDQUHR3xKDjp0qA?=
 =?iso-8859-1?Q?5Q2129xst7PCNezlwFm1ar8jKfzpJ6XfYX5xdVJzVuoMwdc=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: hyperstone.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 71c77fff-196a-4cce-8bef-08d92a59ca07
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2021 08:45:37.8309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 86f203eb-e878-4188-b297-34c118c18b11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IdFVyuA3JXtxipKNz9Bt/m47O/XE3pgmenvA1TBtEH/A1A9XYXH8pH51QTh5eXGxxheWJzQqBq9ehvHjq8slDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB3351
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

Poll for TRAN state if the ioctl command will eventually return to TRAN

The ioctl submitted command should not be considered completed until
the card has returned back to TRAN state. Waiting just for the card
to no longer signal busy is not enough as they might remain in a
non-busy PROG state for a while after the command.
Further commands requiring TRAN will fail then.
It should not be the responsibility of the user to check if their command
has completed until sending the next via ioctl,
instead the check should be made here.
So now, in doubt, wait for TRAN except for the few commands that will
never return to TRAN state.

Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
---
 drivers/mmc/core/block.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 689eb9afeeed..a02187e4fad7 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -410,7 +410,23 @@ static int mmc_blk_ioctl_copy_to_user(struct mmc_ioc_cmd __user *ic_ptr,
         return 0;
 }
 
-static int card_busy_detect(struct mmc_card *card, unsigned int timeout_ms,
+static int is_return_to_tran_cmd(struct mmc_command *cmd)
+{
+       /* Cards will never return to TRAN after completing
+        * identification commands or MMC_SEND_STATUS if they are not selected.
+        */
+       return !(cmd->opcode == MMC_SEND_CID
+                       || cmd->opcode == MMC_ALL_SEND_CID
+                       || cmd->opcode == MMC_SEND_CSD
+                       || cmd->opcode == MMC_SEND_STATUS
+                       || cmd->opcode == MMC_SELECT_CARD
+                       || cmd->opcode == MMC_APP_CMD
+                       || cmd->opcode == MMC_GO_INACTIVE_STATE
+                       || cmd->opcode == MMC_GO_IDLE_STATE);
+
+}
+
+static int card_poll_until_tran(struct mmc_card *card, unsigned int timeout_ms,
                             u32 *resp_errs)
 {
         unsigned long timeout = jiffies + msecs_to_jiffies(timeout_ms);
@@ -593,12 +609,13 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 
         memcpy(&(idata->ic.response), cmd.resp, sizeof(cmd.resp));
 
-       if (idata->rpmb || (cmd.flags & MMC_RSP_R1B) == MMC_RSP_R1B) {
+       if (idata->rpmb || (cmd.flags & MMC_RSP_R1B) == MMC_RSP_R1B
+                       || is_return_to_tran_cmd(&cmd)) {
                 /*
                  * Ensure RPMB/R1B command has completed by polling CMD13
                  * "Send Status".
                  */
-               err = card_busy_detect(card, MMC_BLK_TIMEOUT_MS, NULL);
+               err = card_poll_until_tran(card, MMC_BLK_TIMEOUT_MS, NULL);
         }
 
         return err;
@@ -1621,7 +1638,7 @@ static int mmc_blk_fix_state(struct mmc_card *card, struct request *req)
 
         mmc_blk_send_stop(card, timeout);
 
-       err = card_busy_detect(card, timeout, NULL);
+       err = card_poll_until_tran(card, timeout, NULL);
 
         mmc_retune_release(card->host);
 
@@ -1845,7 +1862,7 @@ static int mmc_blk_card_busy(struct mmc_card *card, struct request *req)
         if (mmc_host_is_spi(card->host) || rq_data_dir(req) == READ)
                 return 0;
 
-       err = card_busy_detect(card, MMC_BLK_TIMEOUT_MS, &status);
+       err = card_poll_until_tran(card, MMC_BLK_TIMEOUT_MS, &status);
 
         /*
          * Do not assume data transferred correctly if there are any error bits
-- 
2.31.1
Hyperstone GmbH | Line-Eid-Strasse 3 | 78467 Konstanz
Managing Directors: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

