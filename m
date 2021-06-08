Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7CDC47082
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Jun 2021 08:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE9C061246
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Jun 2021 08:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbhFHINJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 8 Jun 2021 04:13:09 -0400
Received: from de-smtp-delivery-105.mimecast.com ([194.104.109.105]:42133 "EHLO
        de-smtp-delivery-105.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229923AbhFHINI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Jun 2021 04:13:08 -0400
Received: from GBR01-LO2-obe.outbound.protection.outlook.com
 (mail-lo2gbr01lp2052.outbound.protection.outlook.com [104.47.21.52]) (Using
 TLS) by relay.mimecast.com with ESMTP id de-mta-1-MQh3Lf9LPWGpJ9vCBmtO1A-1;
 Tue, 08 Jun 2021 10:11:14 +0200
X-MC-Unique: MQh3Lf9LPWGpJ9vCBmtO1A-1
Received: from CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:89::10)
 by CWLP265MB3348.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:e3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Tue, 8 Jun
 2021 08:11:13 +0000
Received: from CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
 ([fe80::e508:b3cb:f065:656f]) by CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
 ([fe80::e508:b3cb:f065:656f%4]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 08:11:13 +0000
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Avri Altman <Avri.Altman@wdc.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>
Subject: PATCH] mmc: block: ioctl: Poll for TRAN if possible
Thread-Topic: PATCH] mmc: block: ioctl: Poll for TRAN if possible
Thread-Index: AQHXXD2WfUw9V7TgJkajnPZV25duWg==
Date:   Tue, 8 Jun 2021 08:11:13 +0000
Message-ID: <CWXP265MB26809A40B098D219C44E70FAC4379@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [185.80.168.10]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1ee9b1e9-ccde-4746-67be-08d92a54fb5e
x-ms-traffictypediagnostic: CWLP265MB3348:
x-microsoft-antispam-prvs: <CWLP265MB3348726BF2E22DFC896DD846C4379@CWLP265MB3348.GBRP265.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8273
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: GIaf8vNDLySkEPw2boKtJBL/SR15DAJlHKLCJonytHPR0UD18qFOF0YDEF/rHpO/8EWIIY46h8GJbD1LuHM9EHrCLJ8iEuAgntyyB/lK73GP9+x8QlEQY99vpOqgcCkXImBszRBoUvUNXHci5M9VQ2B4frmXavrjTHqKuQULM8UZArxjwysMy6YC/60EsJu+iuK74a6wX0dZPiHruwfggT0/Ic656EB7gwwtCOyhsu871zHY06payhBlsCuLpx8ocYoiRMPUOOQqCFUkecDVfdr9D9xa2ovZ5jktJ+2FQ+mL/FeI4l3+jEIvXqZyFSBwKiEt9ijzEXN27EpkcPw5uR+6MUkRSnmGaWEaCzBW0pmWpE/BiVPiL8WI1HP8dft6QFXYfq6bf+BPOeHZ79rhWoZZtTgiSj+stSVdd9iN+AoCO/Qvj2fE1+KdAYbsK61UNg6H29d68Nk7U+ssTfgN7v453cQW2NJ8uBfS9EbJZbKQi0rtHdN3P+JLIs5oCULFjqZfwecVYYTzto+e6MNqH7lPUUFt9M6tSqFGHvP+c4nnXJQWdkLxsgV6rCvf4k36bqKJ7FAZqqoFhOEqc7uwuuluet/8X2vap6EtaG9QIrk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(396003)(366004)(136003)(39830400003)(346002)(7696005)(2906002)(122000001)(83380400001)(8936002)(8676002)(26005)(478600001)(66446008)(64756008)(71200400001)(52536014)(86362001)(316002)(76116006)(110136005)(33656002)(91956017)(6506007)(55016002)(66476007)(9686003)(186003)(66556008)(38100700002)(5660300002)(66946007);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?UPzjPoM7yVkxcMu9MfzAXVWRbT5lC64Y7q/aPf+hxWmykLq1YiuXb/22td?=
 =?iso-8859-1?Q?jtEppHrJAvpDwnuop5lg2N7VX+oFL4dUz/tKvevGNIE4Bt/lGm/Cp8qqkS?=
 =?iso-8859-1?Q?q8RSWxSUbcoLciEAOEmG2uwKebWQxqX4NzfAlRpLAtRaeZlaqLdECJHy89?=
 =?iso-8859-1?Q?DrcJK0qe4ebhPZC6IIWmqAo0jwHLbhpGxneqwzLUlhK+sHwTThM7W9Ji9/?=
 =?iso-8859-1?Q?0ZX6p3w5VJY5hZuNE2aBjhuwVe8mjogqCPpAOQNbNLkfWLnl24OeZhUdcy?=
 =?iso-8859-1?Q?DVk1yWZJST7UT43rQvi9d5qLTNnjL8+oN07qyijF0KorSn2Q391T99fiTS?=
 =?iso-8859-1?Q?9JyzGCm+p30CDwOnK5033X4jXicFDfeHQ2issJcRyEF3fiV6O2zWn6NZk6?=
 =?iso-8859-1?Q?93Tp0mySJkUuBm01FpYBo2e/O5IpuHecLgjkAvKIA0k/xO0x5hSnlm98tQ?=
 =?iso-8859-1?Q?fadgr9qR/gALjTSYeGAxHjs36j4yU0/WGELYDqq1G1m4OecbauLVeYY8mp?=
 =?iso-8859-1?Q?t2kK2w0ByCiVxT19j1eQHKdCjP8BDJBDqKD668XWLIot1WYVvTl32FKUpl?=
 =?iso-8859-1?Q?6cYIGmbF+lgUhTUpiD1VWJww+qhHqjDNZ3fWtOqrDlJH4VjLNiewrde/D1?=
 =?iso-8859-1?Q?Ar4bX6v0ty6yA3zpNlLv7vdJbIx4PV7mK39pNHnEwi0WJ7ixT61sM5kPOh?=
 =?iso-8859-1?Q?rc99YpMpyeBdr7uK8NG5A/WTX7AMugtUPLzUM0C23VFx3YmmwBbTV/P8Zi?=
 =?iso-8859-1?Q?6Pitc94Tadpah8gIGRB9zonm4c8I5lNpYt1olO+Z7FwTmzSRb7e+MuwHrc?=
 =?iso-8859-1?Q?W7MMqnsVl4AVyTdWirD1SFUalwAe3VIUci258JFtmZme66oCHvU/WPpp7Z?=
 =?iso-8859-1?Q?lbxs3BbewvspFBkRgszXo6AyzIJYCUDzwwo++kgJfmPfASxSt6JNVE0Hue?=
 =?iso-8859-1?Q?Qvhq6nc2ZytAIBBUdebMrI4rlG30AEnJa4phO8SX8uChV9g02IrtZt0f+A?=
 =?iso-8859-1?Q?MyZoNDUZ9UYyyOmSduk7QqvpyBz8fgHPbKzvRF7DJHEx50ZQQc+lZXhsFf?=
 =?iso-8859-1?Q?xNjbRUBL6J5TWvXmKSRVoXsWieD1baqQx2TesPt+Fq8lR5ta7HDFS3ZWpr?=
 =?iso-8859-1?Q?BNX69gTL/ggGKFtAnjhkpuqww2BmAFLtpSNyuzA9m70AUubegD21WpqilV?=
 =?iso-8859-1?Q?lZaeybHIe3sYNES81s6VtvTV+gE6qjLugLvIY9JjF1hIe/S6a2EzRcD9Pq?=
 =?iso-8859-1?Q?P3L3FlWLZulYzY5zj5mOq3MHn4RT+p7BW8bypeeAcuv0PUQNhDR2cNbF6f?=
 =?iso-8859-1?Q?hIxyYOKSPGofBRF8YIykC8H0PLVFzcyR5qyjLDOcdX8moYo=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: hyperstone.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ee9b1e9-ccde-4746-67be-08d92a54fb5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2021 08:11:13.1408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 86f203eb-e878-4188-b297-34c118c18b11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PesNPX4iqByc7mB4otIqEeF5oFp6ymggcwiudBo9ORHXNM3GMsF8BHziuL9MoqoIebatxv3hknF8WWGsCbA5Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB3348
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
+	/* Cards will never return to TRAN after completing
+	 * identification commands or MMC_SEND_STATUS if they are not selected.
+	 */
+	return !(cmd->opcode == MMC_SEND_CID
+			|| cmd->opcode == MMC_ALL_SEND_CID
+			|| cmd->opcode == MMC_SEND_CSD
+			|| cmd->opcode == MMC_SEND_STATUS
+			|| cmd->opcode == MMC_SELECT_CARD
+			|| cmd->opcode == MMC_APP_CMD
+			|| cmd->opcode == MMC_GO_INACTIVE_STATE
+			|| cmd->opcode == MMC_GO_IDLE_STATE);
+
+}
+
+static int card_poll_until_tran(struct mmc_card *card, unsigned int timeout_ms,
 			    u32 *resp_errs)
 {
 	unsigned long timeout = jiffies + msecs_to_jiffies(timeout_ms);
@@ -593,12 +609,13 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 
 	memcpy(&(idata->ic.response), cmd.resp, sizeof(cmd.resp));
 
-	if (idata->rpmb || (cmd.flags & MMC_RSP_R1B) == MMC_RSP_R1B) {
+	if (idata->rpmb || (cmd.flags & MMC_RSP_R1B) == MMC_RSP_R1B
+			|| is_return_to_tran_cmd(&cmd)) {
 		/*
 		 * Ensure RPMB/R1B command has completed by polling CMD13
 		 * "Send Status".
 		 */
-		err = card_busy_detect(card, MMC_BLK_TIMEOUT_MS, NULL);
+		err = card_poll_until_tran(card, MMC_BLK_TIMEOUT_MS, NULL);
 	}
 
 	return err;
@@ -1621,7 +1638,7 @@ static int mmc_blk_fix_state(struct mmc_card *card, struct request *req)
 
 	mmc_blk_send_stop(card, timeout);
 
-	err = card_busy_detect(card, timeout, NULL);
+	err = card_poll_until_tran(card, timeout, NULL);
 
 	mmc_retune_release(card->host);
 
@@ -1845,7 +1862,7 @@ static int mmc_blk_card_busy(struct mmc_card *card, struct request *req)
 	if (mmc_host_is_spi(card->host) || rq_data_dir(req) == READ)
 		return 0;
 
-	err = card_busy_detect(card, MMC_BLK_TIMEOUT_MS, &status);
+	err = card_poll_until_tran(card, MMC_BLK_TIMEOUT_MS, &status);
 
 	/*
 	 * Do not assume data transferred correctly if there are any error bits
-- 
2.31.1
Hyperstone GmbH | Line-Eid-Strasse 3 | 78467 Konstanz
Managing Directors: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

