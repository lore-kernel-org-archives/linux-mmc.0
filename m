Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46195C07E96
	for <linux-mmc@archiver.kernel.org>; Tue,  6 Jul 2021 08:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23AE56198D
	for <linux-mmc@archiver.kernel.org>; Tue,  6 Jul 2021 08:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbhGFIWt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 6 Jul 2021 04:22:49 -0400
Received: from de-smtp-delivery-105.mimecast.com ([194.104.109.105]:56372 "EHLO
        de-smtp-delivery-105.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230470AbhGFIWt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Jul 2021 04:22:49 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com
 (mail-cwlgbr01lp2058.outbound.protection.outlook.com [104.47.20.58]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-39-xMCdmj5BMPmIUJWXql-VMQ-1; Tue, 06 Jul 2021 10:20:08 +0200
X-MC-Unique: xMCdmj5BMPmIUJWXql-VMQ-1
Received: from CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:89::10)
 by CWLP265MB1937.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:63::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23; Tue, 6 Jul
 2021 08:20:07 +0000
Received: from CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
 ([fe80::259d:65ac:ae6d:409d]) by CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
 ([fe80::259d:65ac:ae6d:409d%9]) with mapi id 15.20.4287.033; Tue, 6 Jul 2021
 08:20:07 +0000
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Avri Altman <Avri.Altman@wdc.com>
CC:     Christoph Hellwig <hch@infradead.org>
Subject: [PATCH] mmc: block: Differentiate busy and non-TRAN state
Thread-Topic: [PATCH] mmc: block: Differentiate busy and non-TRAN state
Thread-Index: AQHXbl0Q77+Qfc7HWE6ez2HIF5qrJas1omGl
Date:   Tue, 6 Jul 2021 08:20:07 +0000
Message-ID: <CWXP265MB26807AC3C130772D789D0AABC41B9@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
References: <CWXP265MB268049D9AB181062DA7F6DDBC4009@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
In-Reply-To: <CWXP265MB268049D9AB181062DA7F6DDBC4009@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [185.80.168.10]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9436d28d-1f32-444d-67ac-08d94056dd54
x-ms-traffictypediagnostic: CWLP265MB1937:
x-microsoft-antispam-prvs: <CWLP265MB193766C636BA83F11C5077B8C41B9@CWLP265MB1937.GBRP265.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: G/UtGisPOLl2MpSvC7xreHZc//Sk3aGp/MmoAa39eC9ZKMlb3hqt6BLAqjbrKWVSkXHNnen4qrBShF7gzos/NI8fpsri2hbT3t76+Tal5qE2cyA58Wl0q6qKNUM7xDTaUxxkTJp76dIecVA6r4ZlM1ypxscRl0+jm+Yz/RIzBBo9oLVOYor0RICxuEL2++UXcU/5X6+To7UrPMTVgbV/J39JXsAxOCkqP+HWUVPDdXbliG5PpwFDmPKtoi5glatBFOo3LzyaK2PGeIJ6YwAO05q/amjFXhp9dqH8CstF1HJ0sy0TS9xTW2U4WDehLvI2b+J+I/mL/97t8wasbEtfUVCOoKtL/NQggEEVic/GBoJMUFBqkkM611PkR31Ll2/LsOrpmWiJhy4JMSjAIcglYmwwNXpCjkQQnx8WkwYT8rG+odZGfoJXPNGPdfHegWV/KMdCfdC/j+oT5bpoHGbG86TeTA5UeS9A+s7fR3pYORTHFfZXxZkKYk63hClkAK33wWVPQzxPE5jyQys36NU6mhapIusHI5uLcfBq/WbisOyeJgYp06lj3ce4DBWwP9YT41ChjD8Zwx8Vqd94KfFyBsZVDEGmcJo7UjVqLsZnXGvF+rFBSFqHljGadBDB812betH78f/utsrIoeY+DKdOLw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(396003)(39830400003)(136003)(346002)(376002)(366004)(478600001)(64756008)(55016002)(66946007)(38100700002)(71200400001)(122000001)(316002)(52536014)(9686003)(26005)(66556008)(8676002)(186003)(7696005)(2906002)(66476007)(66446008)(76116006)(8936002)(5660300002)(110136005)(4326008)(86362001)(6506007)(91956017)(33656002)(83380400001);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 4y7svXhaXtXSkbF4cjI05U41Rm0WTuOWaJNpiUnOcXzunkDVXXhEbGH4guVbPCivvOquLo7iHLm8sx0yO7YNhHMIM4FkII9+ccIDxLGVRoe6eCD9L2Op8q3gV59B9b5CYS/9tNWKOfe9HyinuMCjS6uu4EBo8f+3qrwpK2J5FIrxe/jh3O96fjnFv9VN9BhfGM1cl9p6jELYMNSFZfS8wCDxAZnSBr/9gGEdryhMmkDS4jdScrsJTwiwBVK+DTHtlHE5LKb1b/hj0Ezm4ft5dFnAkE0CQfQMYaiaJQrhX4qnJ6syBJU5H4oHtN+N0J3F3uevJn3ex6+VI9mXiXGNWEbK7f4TfxMj3zp4oE2uEUgvwfwiMA84pl+zfTbUGWotMA09rzW470jSK9Zo7OxmzNTomr2GRg8PqDEHDdggKRXvdRSIPKE0FWpX4gUcnScjehyp9iLPPjvm/dDhXPN869Oy+bEGfGgOHR+ke0VF8TEvZavkDUPSR92uX5z8q2cCL9pQeBWEoXUtBc9UqFudm+vPpAMOXWqRn6LWJ12KKClFM3DDJjUUpuyhKu7l00L2umwF79dAT2mmwoFlaw0RJ+/44F8T2pEnNzEwFNDTXk6dBiY3Boioq8R8pJdQErzFZQe77Zg3bdHXSUv8HI86LqJt4XiZFYUZDXtyCAQqV0tUXcOwiZkWuM5/CKu8iKnE4AgJGaJKOotesizQtfaeH6h6+KN9ZN+jTj7M59oeiQI=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: hyperstone.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9436d28d-1f32-444d-67ac-08d94056dd54
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2021 08:20:07.3899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 86f203eb-e878-4188-b297-34c118c18b11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IUfOx+PUYeACsrbOQFi+neRcdi6Y1PMClckk0r0YDoymOZT7Ggw5OhAkrP3Y4di6gPjlyIsg7HEPUTul934czg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB1937
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

Prevent race condition with ioctl commands

Wait for both, a card no longer signalling busy
and it being returned back to TRAN state.
A card not signaling busy does not mean it is
ready to accept new regular commands.
Instead for a command to be done it should not only
no longer signal busy but also return back to TRAN state,
at least for commands that eventually transition back
to TRAN. Otherwise the next ioctl command may be rejected
as the card is still in PROG state after the previous command.

Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
---
 drivers/mmc/core/block.c | 84 +++++++++++++++++++++++++++++++++++-----
 include/linux/mmc/mmc.h  |  9 +++--
 2 files changed, 80 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 88f4c215caa6..dda10ccee37f 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -411,7 +411,32 @@ static int mmc_blk_ioctl_copy_to_user(struct mmc_ioc_cmd __user *ic_ptr,
 	return 0;
 }
 
-static int card_busy_detect(struct mmc_card *card, unsigned int timeout_ms,
+static int is_return_to_tran_cmd(struct mmc_command *cmd)
+{
+	/*
+	 * Cards will never return to TRAN after completing
+	 * identification commands or MMC_SEND_STATUS if they are not selected.
+	 */
+	switch (cmd->opcode) {
+	case MMC_GO_IDLE_STATE:
+	case MMC_SEND_OP_COND:
+	case MMC_ALL_SEND_CID:
+	case MMC_SET_RELATIVE_ADDR:
+	case MMC_SET_DSR:
+	case MMC_SLEEP_AWAKE:
+	case MMC_SELECT_CARD:
+	case MMC_SEND_CSD:
+	case MMC_SEND_CID:
+	case MMC_SEND_STATUS:
+	case MMC_GO_INACTIVE_STATE:
+	case MMC_APP_CMD:
+		return false;
+	default:
+		return true;
+	}
+}
+
+static int card_poll_until_tran(struct mmc_card *card, unsigned int timeout_ms,
 			    u32 *resp_errs)
 {
 	unsigned long timeout = jiffies + msecs_to_jiffies(timeout_ms);
@@ -433,8 +458,7 @@ static int card_busy_detect(struct mmc_card *card, unsigned int timeout_ms,
 			*resp_errs |= status;
 
 		/*
-		 * Timeout if the device never becomes ready for data and never
-		 * leaves the program state.
+		 * Timeout if the device never returns to TRAN state.
 		 */
 		if (done) {
 			dev_err(mmc_dev(card->host),
@@ -442,6 +466,41 @@ static int card_busy_detect(struct mmc_card *card, unsigned int timeout_ms,
 				 __func__, status);
 			return -ETIMEDOUT;
 		}
+	} while (R1_CURRENT_STATE(status) != R1_STATE_TRAN);
+
+	return err;
+}
+
+static int card_busy_detect(struct mmc_card *card, unsigned int timeout_ms,
+			    u32 *resp_errs)
+{
+	unsigned long timeout = jiffies + msecs_to_jiffies(timeout_ms);
+	int err = 0;
+	u32 status;
+
+	do {
+		bool done = time_after(jiffies, timeout);
+
+		err = __mmc_send_status(card, &status, 5);
+		if (err) {
+			dev_err(mmc_dev(card->host),
+				"error %d requesting status\n", err);
+			return err;
+		}
+
+		/* Accumulate any response error bits seen */
+		if (resp_errs)
+			*resp_errs |= status;
+
+		/*
+		 * Timeout if the device never becomes ready for data.
+		 */
+		if (done) {
+			dev_err(mmc_dev(card->host),
+				"Card remained busy! %s status: %#x\n",
+				 __func__, status);
+			return -ETIMEDOUT;
+		}
 	} while (!mmc_ready_for_data(status));
 
 	return err;
@@ -596,12 +655,19 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 
 	if (idata->rpmb || (cmd.flags & MMC_RSP_R1B) == MMC_RSP_R1B) {
 		/*
-		 * Ensure RPMB/R1B command has completed by polling CMD13
-		 * "Send Status".
+		 * Ensure card is no longer signalling busy by polling CMD13.
 		 */
 		err = card_busy_detect(card, MMC_BLK_TIMEOUT_MS, NULL);
 	}
 
+	if (is_return_to_tran_cmd(&cmd)) {
+		/*
+		 * Ensure card has returned back to TRAN state (e.g. from PROG)
+		 * and is ready to accept a new command.
+		 */
+		err = card_poll_until_tran(card, MMC_BLK_TIMEOUT_MS, NULL);
+	}
+
 	return err;
 }
 
@@ -1630,7 +1696,7 @@ static int mmc_blk_fix_state(struct mmc_card *card, struct request *req)
 
 	mmc_blk_send_stop(card, timeout);
 
-	err = card_busy_detect(card, timeout, NULL);
+	err = card_poll_until_tran(card, timeout, NULL);
 
 	mmc_retune_release(card->host);
 
@@ -1662,7 +1728,7 @@ static void mmc_blk_read_single(struct mmc_queue *mq, struct request *req)
 			goto error_exit;
 
 		if (!mmc_host_is_spi(host) &&
-		    !mmc_ready_for_data(status)) {
+		    !mmc_tran_and_ready_for_data(status)) {
 			err = mmc_blk_fix_state(card, req);
 			if (err)
 				goto error_exit;
@@ -1784,7 +1850,7 @@ static void mmc_blk_mq_rw_recovery(struct mmc_queue *mq, struct request *req)
 
 	/* Try to get back to "tran" state */
 	if (!mmc_host_is_spi(mq->card->host) &&
-	    (err || !mmc_ready_for_data(status)))
+	    (err || !mmc_tran_and_ready_for_data(status)))
 		err = mmc_blk_fix_state(mq->card, req);
 
 	/*
@@ -1854,7 +1920,7 @@ static int mmc_blk_card_busy(struct mmc_card *card, struct request *req)
 	if (mmc_host_is_spi(card->host) || rq_data_dir(req) == READ)
 		return 0;
 
-	err = card_busy_detect(card, MMC_BLK_TIMEOUT_MS, &status);
+	err = card_poll_until_tran(card, MMC_BLK_TIMEOUT_MS, &status);
 
 	/*
 	 * Do not assume data transferred correctly if there are any error bits
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index d9a65c6a8816..9ae27504cbc9 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -163,10 +163,11 @@ static inline bool mmc_op_multi(u32 opcode)
 
 static inline bool mmc_ready_for_data(u32 status)
 {
-	/*
-	 * Some cards mishandle the status bits, so make sure to check both the
-	 * busy indication and the card state.
-	 */
+	return status & R1_READY_FOR_DATA;
+}
+
+static inline bool mmc_tran_and_ready_for_data(u32 status)
+{
 	return status & R1_READY_FOR_DATA &&
 	       R1_CURRENT_STATE(status) == R1_STATE_TRAN;
 }
-- 
2.32.0

Hyperstone GmbH | Line-Eid-Strasse 3 | 78467 Konstanz
Managing Directors: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

