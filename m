Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A97C11F64
	for <linux-mmc@archiver.kernel.org>; Thu,  1 Jul 2021 09:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9AA66148E
	for <linux-mmc@archiver.kernel.org>; Thu,  1 Jul 2021 09:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235608AbhGAJqL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 1 Jul 2021 05:46:11 -0400
Received: from de-smtp-delivery-105.mimecast.com ([194.104.109.105]:59797 "EHLO
        de-smtp-delivery-105.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235300AbhGAJqK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Jul 2021 05:46:10 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com
 (mail-cwlgbr01lp2050.outbound.protection.outlook.com [104.47.20.50]) (Using
 TLS) by relay.mimecast.com with ESMTP id de-mta-1-KpPutM33N26UooncmP2YlA-1;
 Thu, 01 Jul 2021 11:43:38 +0200
X-MC-Unique: KpPutM33N26UooncmP2YlA-1
Received: from CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:89::10)
 by CWXP265MB3367.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:de::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.23; Thu, 1 Jul
 2021 09:43:37 +0000
Received: from CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
 ([fe80::259d:65ac:ae6d:409d]) by CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
 ([fe80::259d:65ac:ae6d:409d%9]) with mapi id 15.20.4287.023; Thu, 1 Jul 2021
 09:43:37 +0000
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Avri Altman <Avri.Altman@wdc.com>,
        =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
Subject: [PATCH] mmc: block: Differentiate busy and non-TRAN state
Thread-Topic: [PATCH] mmc: block: Differentiate busy and non-TRAN state
Thread-Index: AQHXbl0Q77+Qfc7HWE6ez2HIF5qrJQ==
Date:   Thu, 1 Jul 2021 09:43:37 +0000
Message-ID: <CWXP265MB268049D9AB181062DA7F6DDBC4009@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [185.80.168.10]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b652e1e8-8ac7-408a-65c7-08d93c74b3bf
x-ms-traffictypediagnostic: CWXP265MB3367:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CWXP265MB336709CF8105C31503F178BCC4009@CWXP265MB3367.GBRP265.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: dadDceZTy3qwy/Cqip1lqo8lQeYA2V+BtiLx1caSHsoE64/8p4yJ7VSoo9A42xu6HdJHKVS5aIeup6cJuBSd34vPgaK+ARs+t+sBBwoGIQ5aTAVqqvj6/tK7/HxbfGrYjTWPSZ84sgvogQMgNHlXgqSfhgd+l4Z5mejaNdh+yoSNwJi66SbyOYMZA0ie4lqTjCeQrqTTje1Ep1uzoHMeMwa0M7BsDIBSci2pYoDGSBz9IHYgvs4nIQabLeGRJ0tdPi1UwWa1nAP0wDgE+3qrvRJW8p+DXuObgmSNh3yBPX50FmNjYZCwj/JQwBU8XhwamaxxHg9DzbhTxP6p8lckjOB090PrH498cZUPxBzomZqPIc3s4inlJZm6wu98p9mjzlMDcUcKg7G6DNiGXph1w8PPCdORzU87EyZQvHZ+p33jpD4SKCigDAiQSODwYjzsEdbw45R2LI8gWzr3SUiMqbvVPqXfamz/8nKU1Jvju37iwxqcroJxNJ4HpS5+wUw2zUBcntnA62ezZ/wZFYN8aL4oLCvvxqBGjTWIBv3VwOyLAR4kjIsL9/652rlfNdPlDjIKz+7wpKstSobxD2yVBqNvH1AfhZxYlrL5KUVwSphpR6Br3BYcliG0MN4kk5K0Ojb1bsEHb3W2f7cqW0dSVg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(39840400004)(396003)(136003)(376002)(346002)(55016002)(91956017)(7696005)(186003)(6506007)(71200400001)(64756008)(66476007)(26005)(33656002)(9686003)(66946007)(76116006)(8676002)(66556008)(66446008)(8936002)(122000001)(478600001)(83380400001)(38100700002)(5660300002)(110136005)(52536014)(316002)(2906002)(86362001);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?1iaBSqWQyWygf6LubL7TEA6uZhFqYEioSjC66MoeFVAV5bXglIXdw9ugIj?=
 =?iso-8859-1?Q?egZXY8TSyuwpUOBdDwaWcyo8LoE/SQ40+RbWwGxIX8E8zNzEozpg7Ji/mG?=
 =?iso-8859-1?Q?CPf4cgm+TpbzlWCprnE7+gKYkqztnLWJk5+72ZxAcs91athHJW2vOBdqSG?=
 =?iso-8859-1?Q?cZJbqGa9WjvYbnHLE8cwxd+IhC+7ABmN5TZ9aG6Uxia7J1RcEx1rtWwew5?=
 =?iso-8859-1?Q?9H7xw3PwFXqFEDgdHb6nMjn2mWeeCQ6YPOJeOW7rybOJjP8qi5ZTvZVtRh?=
 =?iso-8859-1?Q?mdX28wvbOuYxHyQEWAxOlP+gLX8/PI5I1lS6fr4tj79iIr3fZPQ3MZN2Ry?=
 =?iso-8859-1?Q?L5SjRV6fblnbY2zDro4SseKiM0dLb41+tbDt5lKaP+HciRh8TwEuXoJOeW?=
 =?iso-8859-1?Q?n1e3nti8c5xfmWcP0kygPmZwbxxA1kbX9xdDPrShPIWRJnUXvwxjS3unoO?=
 =?iso-8859-1?Q?1DIrk9oSMHgUJqjC3U9DsOx3SqbtR/OZjAG/Qby8PZWj+aBSO4szvBXKQf?=
 =?iso-8859-1?Q?k69mwK+SYXddISl0xQl149fFAvYCJKUQ5OfOCD6BCEJ2mrHxGWkIDlalMC?=
 =?iso-8859-1?Q?dMkqQosMcFSi4BjJzOwuoauwgq9NJvlDakPmm4+NA5TzGHJGSyfy+JMx1e?=
 =?iso-8859-1?Q?nkwLmGUKJsDebcVtKUsqOyGVc1vwykXg2DZsHoGw4tvSwA1SWk1aK51JRK?=
 =?iso-8859-1?Q?YPJPFGjg7RjoJREc+vB9s8zfbuqsSnC48iI88IMOSrJ9zW4hsgaBgQaode?=
 =?iso-8859-1?Q?02BcHYhlL3Eay08TUNYG+dODwrqjyOjZgaO08FGgtJuLLNie5a5Y9mU/Z1?=
 =?iso-8859-1?Q?xCgU2mK/b9btOSyXQi3I0ggzHH+jozjwHBtxJYRsK+Ob4G3BC7uRanP0P2?=
 =?iso-8859-1?Q?eQkm/3gpPkO1zgMCYm8y1u+3EvOsM3R0BorkTb7VRlOD61n0rqJozf0cNP?=
 =?iso-8859-1?Q?HkAQLAXPJhYDDU0QSnUD18hE5ld+dObXXPBfD7zUSJAWDB6+OF/s6HwYXP?=
 =?iso-8859-1?Q?GtOheD8mQbEXWvoLTpVXtberFhUG2cIODnmK80mfLOZkPZdkIB0G53wnsB?=
 =?iso-8859-1?Q?3hEnGMhSixBU3Lf/mOSCdLM16xooRX48X/ig6Ubs6Z9mqIjr7K3w7Lwe8f?=
 =?iso-8859-1?Q?rSKwSIGambDuacInRJCWbT1oLCdhhIKOtjBxnJCPGarynA4ci8hWJnU6a8?=
 =?iso-8859-1?Q?jZ9pcznvrTSEUqXAmka/ORxaa7myAR1lQZFxZVputDFAgmSLifhRfyUwcm?=
 =?iso-8859-1?Q?6WgxdaLekgXZjLiinqxg7f10PJsFMO1rcsN0H9ZbFTExLBfgHZsBwLvMu1?=
 =?iso-8859-1?Q?p04vTbB/MIRSP8MeF3lS38USKstw8wQ8FF9a1MlIf/8bKyY=3D?=
MIME-Version: 1.0
X-OriginatorOrg: hyperstone.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b652e1e8-8ac7-408a-65c7-08d93c74b3bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2021 09:43:37.8775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 86f203eb-e878-4188-b297-34c118c18b11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2sAdZOkXtzBw1XWzDaUhBNtilPe2SRsJhJx+6Os+TUJXo0YCMNUtM/NApQfRDaNcgWN5O9kqTQogVXJoL6QUXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB3367
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: hyperstone.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Prevent race condition with ioctl commands

A card not signaling busy does not mean it is
ready to accept new regular commands.
Instead for a command to be done it should not only
no longer busy but also return back to TRAN state,
at least for commands that eventually transition back
to TRAN. Otherwise the next ioctl command may be rejected
as the card is still in PROG state after the previous command.

Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
---
 drivers/mmc/core/block.c | 72 ++++++++++++++++++++++++++++++++++++----
 include/linux/mmc/mmc.h  | 13 +++++---
 2 files changed, 74 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 88f4c215caa6..ddb395afe6e0 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -411,7 +411,27 @@ static int mmc_blk_ioctl_copy_to_user(struct mmc_ioc_cmd __user *ic_ptr,
 	return 0;
 }
 
-static int card_busy_detect(struct mmc_card *card, unsigned int timeout_ms,
+static int is_return_to_tran_cmd(struct mmc_command *cmd)
+{
+	/*
+	 * Cards will never return to TRAN after completing
+	 * identification commands or MMC_SEND_STATUS if they are not selected.
+	 */
+	return !(cmd->opcode == MMC_GO_IDLE_STATE
+			|| cmd->opcode == MMC_SEND_OP_COND
+			|| cmd->opcode == MMC_ALL_SEND_CID
+			|| cmd->opcode == MMC_SET_RELATIVE_ADDR
+			|| cmd->opcode == MMC_SET_DSR
+			|| cmd->opcode == MMC_SLEEP_AWAKE
+			|| cmd->opcode == MMC_SELECT_CARD
+			|| cmd->opcode == MMC_SEND_CSD
+			|| cmd->opcode == MMC_SEND_CID
+			|| cmd->opcode == MMC_SEND_STATUS
+			|| cmd->opcode == MMC_GO_INACTIVE_STATE
+			|| cmd->opcode == MMC_APP_CMD);
+}
+
+static int card_poll_until_tran(struct mmc_card *card, unsigned int timeout_ms,
 			    u32 *resp_errs)
 {
 	unsigned long timeout = jiffies + msecs_to_jiffies(timeout_ms);
@@ -433,8 +453,7 @@ static int card_busy_detect(struct mmc_card *card, unsigned int timeout_ms,
 			*resp_errs |= status;
 
 		/*
-		 * Timeout if the device never becomes ready for data and never
-		 * leaves the program state.
+		 * Timeout if the device never returns to TRAN state.
 		 */
 		if (done) {
 			dev_err(mmc_dev(card->host),
@@ -442,6 +461,41 @@ static int card_busy_detect(struct mmc_card *card, unsigned int timeout_ms,
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
@@ -602,6 +656,10 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 		err = card_busy_detect(card, MMC_BLK_TIMEOUT_MS, NULL);
 	}
 
+	if (is_return_to_tran_cmd(&cmd))
+		err = card_poll_until_tran(card, MMC_BLK_TIMEOUT_MS, NULL);
+
 	return err;
 }
 
@@ -1630,7 +1688,7 @@ static int mmc_blk_fix_state(struct mmc_card *card, struct request *req)
 
 	mmc_blk_send_stop(card, timeout);
 
-	err = card_busy_detect(card, timeout, NULL);
+	err = card_poll_until_tran(card, timeout, NULL);
 
 	mmc_retune_release(card->host);
 
@@ -1662,7 +1720,7 @@ static void mmc_blk_read_single(struct mmc_queue *mq, struct request *req)
 			goto error_exit;
 
 		if (!mmc_host_is_spi(host) &&
-		    !mmc_ready_for_data(status)) {
+		    !mmc_tran_and_ready_for_data(status)) {
 			err = mmc_blk_fix_state(card, req);
 			if (err)
 				goto error_exit;
@@ -1784,7 +1842,7 @@ static void mmc_blk_mq_rw_recovery(struct mmc_queue *mq, struct request *req)
 
 	/* Try to get back to "tran" state */
 	if (!mmc_host_is_spi(mq->card->host) &&
-	    (err || !mmc_ready_for_data(status)))
+	    (err || !mmc_tran_and_ready_for_data(status)))
 		err = mmc_blk_fix_state(mq->card, req);
 
 	/*
@@ -1854,7 +1912,7 @@ static int mmc_blk_card_busy(struct mmc_card *card, struct request *req)
 	if (mmc_host_is_spi(card->host) || rq_data_dir(req) == READ)
 		return 0;
 
-	err = card_busy_detect(card, MMC_BLK_TIMEOUT_MS, &status);
+	err = card_poll_until_tran(card, MMC_BLK_TIMEOUT_MS, &status);
 
 	/*
 	 * Do not assume data transferred correctly if there are any error bits
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index d9a65c6a8816..cf1a4a330e02 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -163,10 +167,11 @@ static inline bool mmc_op_multi(u32 opcode)
 
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

