Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52500C07E95
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Jul 2021 08:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38E596197F
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Jul 2021 08:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbhGGIaX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 7 Jul 2021 04:30:23 -0400
Received: from de-smtp-delivery-105.mimecast.com ([194.104.111.105]:28333 "EHLO
        de-smtp-delivery-105.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230073AbhGGIaW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 7 Jul 2021 04:30:22 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com
 (mail-cwlgbr01lp2052.outbound.protection.outlook.com [104.47.20.52]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-16-Rz8xZl7APh6xepANG2cEYg-1; Wed, 07 Jul 2021 10:27:40 +0200
X-MC-Unique: Rz8xZl7APh6xepANG2cEYg-1
Received: from CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:89::10)
 by CWXP265MB3829.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:102::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Wed, 7 Jul
 2021 08:27:39 +0000
Received: from CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
 ([fe80::259d:65ac:ae6d:409d]) by CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
 ([fe80::259d:65ac:ae6d:409d%9]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 08:27:39 +0000
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     Avri Altman <Avri.Altman@wdc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>
Subject: [PATCHv2] mmc: block: Differentiate busy and PROG state
Thread-Topic: [PATCHv2] mmc: block: Differentiate busy and PROG state
Thread-Index: AQHXcwny68++j12etUaztO/Yg7lHlQ==
Date:   Wed, 7 Jul 2021 08:27:39 +0000
Message-ID: <CWXP265MB2680575489E508DC75D84857C41A9@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
References: <CWXP265MB268049D9AB181062DA7F6DDBC4009@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
 <CWXP265MB26807AC3C130772D789D0AABC41B9@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>,<CAPDyKFq44ZuXXUDQV34NSW-ixB9GAZfDx+dx-Kb8O7=LQ1TSHQ@mail.gmail.com>
 <CWXP265MB26803EFAC659676EC0914F97C41B9@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>,<DM6PR04MB6575B0049B98254E77BA447EFC1A9@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB6575B0049B98254E77BA447EFC1A9@DM6PR04MB6575.namprd04.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8a0de482-636a-41a5-a74f-08d94121152e
x-ms-traffictypediagnostic: CWXP265MB3829:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CWXP265MB3829379AF8335A113F48DFB2C41A9@CWXP265MB3829.GBRP265.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: jaNolaUSE3JurlE9OA1o1ZU8hMVRljrGhZJIoFzh3FQxAURA+n1FWm+Av9+lVoOp0PnJd45ZuIpff7bj+iOhJtuhFlzGvXSmU3wn6u+uWPk1YCAz5r4H2iqHppzxMtrB0oo5whJFuzBUydLncWqCMUBYCn/y1wM4HsnxuQjq46w/ba/EEvvYu2SgWTTszP7WnYj1kX+Hx2+QRB4S5tBKz1xw3fe/CWaMgqHqeoyXdM5zZNOYDQaU18C/8KYqxjtPr8kP3tKtT0Ob2fYU4oOOhHPs4gWbByIoBKheCJgKJAR6z1UkbEvf+453pkKoZ0eTEBF2s7jVhipQTl3QKHRdcawDtQZOLFD6I6d7TJ+CP3MNNHWucW83kBCQI6gVoTZebeUa0PWZ0fGS7z1hykRRHURCLe6P/GbbzygY5irYBvEYDhJbIUMVVmSa/Mc1AyPPYwowbap3BM07RFh1E8wsMBNisG7WuQaxRAhH7/jP09hZ9Fcp48jzBef6nLB4LrLHlMUM8LCD+lbgI5qndXRfUlyYDXInyCcftzM9x48keyUtqK1d0x9+H/FOEn33BaHo9BU/3W48tUpqdQegA+w9hpIu7mYl1YtLK8weIwkQ5cY4MqZuxYCOGJ58bGoNDc0AGbyVn7n0UapV/D8JFWPWag==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(366004)(396003)(376002)(346002)(39840400004)(66476007)(66946007)(6506007)(52536014)(8936002)(76116006)(91956017)(83380400001)(26005)(38100700002)(66446008)(86362001)(66556008)(64756008)(186003)(9686003)(110136005)(122000001)(7696005)(478600001)(316002)(54906003)(4326008)(8676002)(33656002)(5660300002)(71200400001)(2906002)(55016002);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?b5sLmpxi8RPcMiIxptrJCIp1Os1avkgZ87V5DDYHg4m+7DR8L/Zstkw4Ee?=
 =?iso-8859-1?Q?ddAmVMHowSwU8ostViSjcoCbNegU2bBYAyaLgrj/VKiaRxC/ckQ/KCAZAQ?=
 =?iso-8859-1?Q?cBT6bXKl2gtK60ziqIO4dvh5i+vAsqMdKj36lOg9yTByst3itdev2S62se?=
 =?iso-8859-1?Q?wBu/YbCiOUfN2ifSbYNlSEK2aYu8Eg/rDnWbBtzYpuUJbO2m+4XMURZB2z?=
 =?iso-8859-1?Q?jhkhioJdm7G7VEMV3fhnS4YRNbrlyKg2xGmHglhd19QpgiVHNCyy+fcavH?=
 =?iso-8859-1?Q?5eShTO6xFekjw3eGx46mhSPZl0GR+tHTJsG4HAlaOCUg5pjCgdNqumDSy8?=
 =?iso-8859-1?Q?26U40785Xi1d05i1peuZZyQ3FWxShc84eBwNk4vozR0srjmQTOB8kf2utf?=
 =?iso-8859-1?Q?LVvuRaXJ9Lti64PnHAsfme8wcfzUMqGfSCBTAM99JY2Tv6S8qYlAWvHocH?=
 =?iso-8859-1?Q?/ZvHxWQ6OcqBrxKCn3cYQh71RfkDJvoktzdlQXIKmXAYueH8gXH9L1/EUO?=
 =?iso-8859-1?Q?KtwRGkWP8IieL3kIUhkze6jH4fqLA0kf2S97YVKUrV8qToM+Dhjv4aWkaG?=
 =?iso-8859-1?Q?ZKkYmdVvgnnu2np9KqpMX79S9idAiokRvIc2yiOM847GDcBN0wd0rILsSA?=
 =?iso-8859-1?Q?n4av/iEyAMtJL5oi7y5Syj72wTP3wBag2LuKaJHJAz76UN4ni030spdNQQ?=
 =?iso-8859-1?Q?sw4dd2a6oPxtRRuExP257XXoP0iYa1Jn3aIk39odzhbsnxcpuR7prFYchb?=
 =?iso-8859-1?Q?CVtVOA+SH7IhyxpoFbqKaMV0FeqIbRRt914OpX3YViBAKrm0a3Q8CSU7L/?=
 =?iso-8859-1?Q?GRR2fSRrwokwqjhoVFPmV64wc6gvjK/EnpN3Af/5fQ4kPbRqpnDB3UrsN6?=
 =?iso-8859-1?Q?cnOe+FvQ8Hh0FtG2zRYMubJy29rQAnSYTmO4ReVphOFboalXPdWNmoNyJS?=
 =?iso-8859-1?Q?09Fj05wtC/lDFAcaq453UYyNOwfHJyiF+6Fz+df0vvAF2U7GNcRo/xUcnA?=
 =?iso-8859-1?Q?3LIUdtLh06+oRoQ/PJ8tsys2DlfIpuSHB9w7eASPJL2N+pCDjpdaiNTudX?=
 =?iso-8859-1?Q?sOKTarRQCRR2bQb2SIg3vtYzEOGenXy14w7S9tFLc1vse4OipZmgH6dKov?=
 =?iso-8859-1?Q?ENnNO0YbCyJUyJScGV5faTbvUwfDMsQTgwr/MmSHBnZeeZ9YoJ7nKq9ylI?=
 =?iso-8859-1?Q?Hx61oKWHMR8d+y3oqoFwv4xlaFSugZeCE6sgD/FDkAt5vWASnv0s0/1TJN?=
 =?iso-8859-1?Q?cTAtSTb/CRZF9nNbQpPiU8nGZuoqnnAuMJmoIVSHAgegzgKOUhTRgKdybG?=
 =?iso-8859-1?Q?3q09JF5m11fHS2ydqF+0NSgrT9CuFZQFMnqfkvtVuqdMQs4=3D?=
MIME-Version: 1.0
X-OriginatorOrg: hyperstone.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a0de482-636a-41a5-a74f-08d94121152e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2021 08:27:39.1286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 86f203eb-e878-4188-b297-34c118c18b11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gp0X7ecw9uDFEw2onCR0AaPQsTwGMzKRTIh7GX/B70XgpzJRJ6Rn3zQkTo0KXkLQP63xS3puT8w25mA9UBY7QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB3829
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

To fully prevent a race condition where the next
issued command will be rejected as the card is no
longer signalling busy but not yet back in TRAN state.
The card may be in PROG state without signalling busy,
for some of the commands that are only R1, but also
for R1b commands, the card will signal non-busy as soon
as receive buffers are free again, but the card has
not finished handling the command and may therefore be
in PROG.
Since the next command is not known at the time of
completion we must assume that it may be one that can
only be accepted in TRAN state.
Therefore we only consider a PROG command completed
when we have polled for TRAN.

Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
---
 drivers/mmc/core/block.c   | 86 ++++++++++++++++++++++++++++++++++----
 drivers/mmc/core/mmc_ops.c |  2 +-
 include/linux/mmc/mmc.h    | 10 +++--
 include/linux/mmc/sd.h     |  3 ++
 4 files changed, 87 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 88f4c215caa6..cb78690647bf 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -411,7 +411,34 @@ static int mmc_blk_ioctl_copy_to_user(struct mmc_ioc_cmd __user *ic_ptr,
 	return 0;
 }
 
-static int card_busy_detect(struct mmc_card *card, unsigned int timeout_ms,
+static int is_prog_cmd(struct mmc_command *cmd)
+{
+	/*
+	 * Cards will move to programming state (PROG) after these commands.
+	 * So we must not consider the command as completed until the card
+	 * has actually returned back to TRAN state.
+	 */
+	switch (cmd->opcode) {
+	case MMC_STOP_TRANSMISSION:
+	case MMC_WRITE_DAT_UNTIL_STOP:
+	case MMC_WRITE_BLOCK:
+	case MMC_WRITE_MULTIPLE_BLOCK:
+	case MMC_PROGRAM_CID:
+	case MMC_PROGRAM_CSD:
+	case MMC_SET_WRITE_PROT:
+	case MMC_CLR_WRITE_PROT:
+	case MMC_ERASE:
+	case MMC_LOCK_UNLOCK:
+	case MMC_SET_TIME: /* Also covers SD_WRITE_EXTR_SINGLE */
+	case MMC_GEN_CMD:
+	case SD_WRITE_EXTR_MULTI:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static int card_poll_until_tran(struct mmc_card *card, unsigned int timeout_ms,
 			    u32 *resp_errs)
 {
 	unsigned long timeout = jiffies + msecs_to_jiffies(timeout_ms);
@@ -433,8 +460,7 @@ static int card_busy_detect(struct mmc_card *card, unsigned int timeout_ms,
 			*resp_errs |= status;
 
 		/*
-		 * Timeout if the device never becomes ready for data and never
-		 * leaves the program state.
+		 * Timeout if the device never returns to TRAN state.
 		 */
 		if (done) {
 			dev_err(mmc_dev(card->host),
@@ -442,6 +468,41 @@ static int card_busy_detect(struct mmc_card *card, unsigned int timeout_ms,
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
@@ -596,12 +657,19 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 
 	if (idata->rpmb || (cmd.flags & MMC_RSP_R1B) == MMC_RSP_R1B) {
 		/*
-		 * Ensure RPMB/R1B command has completed by polling CMD13
-		 * "Send Status".
+		 * Ensure card is no longer signalling busy by polling CMD13.
 		 */
 		err = card_busy_detect(card, MMC_BLK_TIMEOUT_MS, NULL);
 	}
 
+	if (is_prog_cmd(&cmd)) {
+		/*
+		 * Ensure card has returned back to TRAN state
+		 * and is ready to accept a new command.
+		 */
+		err = card_poll_until_tran(card, MMC_BLK_TIMEOUT_MS, NULL);
+	}
+
 	return err;
 }
 
@@ -1630,7 +1698,7 @@ static int mmc_blk_fix_state(struct mmc_card *card, struct request *req)
 
 	mmc_blk_send_stop(card, timeout);
 
-	err = card_busy_detect(card, timeout, NULL);
+	err = card_poll_until_tran(card, timeout, NULL);
 
 	mmc_retune_release(card->host);
 
@@ -1662,7 +1730,7 @@ static void mmc_blk_read_single(struct mmc_queue *mq, struct request *req)
 			goto error_exit;
 
 		if (!mmc_host_is_spi(host) &&
-		    !mmc_ready_for_data(status)) {
+		    !mmc_tran_and_ready_for_data(status)) {
 			err = mmc_blk_fix_state(card, req);
 			if (err)
 				goto error_exit;
@@ -1784,7 +1852,7 @@ static void mmc_blk_mq_rw_recovery(struct mmc_queue *mq, struct request *req)
 
 	/* Try to get back to "tran" state */
 	if (!mmc_host_is_spi(mq->card->host) &&
-	    (err || !mmc_ready_for_data(status)))
+	    (err || !mmc_tran_and_ready_for_data(status)))
 		err = mmc_blk_fix_state(mq->card, req);
 
 	/*
@@ -1854,7 +1922,7 @@ static int mmc_blk_card_busy(struct mmc_card *card, struct request *req)
 	if (mmc_host_is_spi(card->host) || rq_data_dir(req) == READ)
 		return 0;
 
-	err = card_busy_detect(card, MMC_BLK_TIMEOUT_MS, &status);
+	err = card_poll_until_tran(card, MMC_BLK_TIMEOUT_MS, &status);
 
 	/*
 	 * Do not assume data transferred correctly if there are any error bits
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 973756ed4016..a0be45118a93 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -465,7 +465,7 @@ static int mmc_busy_cb(void *cb_data, bool *busy)
 	if (err)
 		return err;
 
-	*busy = !mmc_ready_for_data(status);
+	*busy = !mmc_tran_and_ready_for_data(status);
 	return 0;
 }
 
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index d9a65c6a8816..72a82aa89b27 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -64,6 +64,7 @@
 #define MMC_WRITE_MULTIPLE_BLOCK 25   /* adtc                    R1  */
 #define MMC_PROGRAM_CID          26   /* adtc                    R1  */
 #define MMC_PROGRAM_CSD          27   /* adtc                    R1  */
+#define MMC_SET_TIME             49   /* adtc                    R1  */
 
   /* class 6 */
 #define MMC_SET_WRITE_PROT       28   /* ac   [31:0] data addr   R1b */
@@ -163,10 +164,11 @@ static inline bool mmc_op_multi(u32 opcode)
 
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
diff --git a/include/linux/mmc/sd.h b/include/linux/mmc/sd.h
index 6727576a8755..9f57da673dfd 100644
--- a/include/linux/mmc/sd.h
+++ b/include/linux/mmc/sd.h
@@ -32,6 +32,9 @@
   /* class 11 */
 #define SD_READ_EXTR_SINGLE      48   /* adtc [31:0]             R1  */
 #define SD_WRITE_EXTR_SINGLE     49   /* adtc [31:0]             R1  */
+#define SD_READ_EXTR_MULTI       58   /* adtc [31:0]             R1  */
+#define SD_WRITE_EXTR_MULTI      59   /* adtc [31:0]             R1  */
+
 
 /* OCR bit definitions */
 #define SD_OCR_S18R		(1 << 24)    /* 1.8V switching request */
-- 
2.32.0
Hyperstone GmbH | Line-Eid-Strasse 3 | 78467 Konstanz
Managing Directors: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

