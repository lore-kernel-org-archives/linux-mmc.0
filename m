Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3949DC433B4
	for <linux-mmc@archiver.kernel.org>; Fri,  7 May 2021 10:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 051A16143F
	for <linux-mmc@archiver.kernel.org>; Fri,  7 May 2021 10:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbhEGKfk convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 7 May 2021 06:35:40 -0400
Received: from de-smtp-delivery-105.mimecast.com ([194.104.111.105]:21589 "EHLO
        de-smtp-delivery-105.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234025AbhEGKfj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 7 May 2021 06:35:39 -0400
X-Greylist: delayed 163329 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 May 2021 06:35:38 EDT
Received: from GBR01-CWL-obe.outbound.protection.outlook.com
 (mail-cwlgbr01lp2050.outbound.protection.outlook.com [104.47.20.50]) (Using
 TLS) by relay.mimecast.com with ESMTP id de-mta-2-H4yoEehHO2qEoq8kqoV5Sg-1;
 Fri, 07 May 2021 12:34:34 +0200
X-MC-Unique: H4yoEehHO2qEoq8kqoV5Sg-1
Received: from CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:89::10)
 by CWXP265MB2023.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:87::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Fri, 7 May
 2021 10:34:33 +0000
Received: from CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
 ([fe80::a91f:361d:5554:3958]) by CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
 ([fe80::a91f:361d:5554:3958%5]) with mapi id 15.20.4108.027; Fri, 7 May 2021
 10:34:33 +0000
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     Avri Altman <Avri.Altman@wdc.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "zliua@micron.com" <zliua@micron.com>
Subject: [PATCH v2] mmc: block: ioctl: No busywaiting of non-TRAN CMDs
Thread-Topic: [PATCH v2] mmc: block: ioctl: No busywaiting of non-TRAN CMDs
Thread-Index: AQHXQyyR8BdSxkDtf0eUDDANXygamQ==
Date:   Fri, 7 May 2021 10:34:33 +0000
Message-ID: <CWXP265MB2680A8DD0FFA6FECBFDFB027C4579@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
References: <CWXP265MB2680DC98B32CD4B49AA8A224C4599@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>,<DM6PR04MB657570DB58E7ABBE2C3B0449FC589@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB657570DB58E7ABBE2C3B0449FC589@DM6PR04MB6575.namprd04.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [185.80.168.10]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7c35fc60-a2be-4eb9-4ae5-08d91143b47e
x-ms-traffictypediagnostic: CWXP265MB2023:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CWXP265MB2023B2ADBC12E84EDE7B06C2C4579@CWXP265MB2023.GBRP265.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:3968
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: bcRk+beRpWZ8b03Diocr8d9L03lQFvJnybq5wpdafqmUYj2/LeTFqXZwMp9ScWHpuM3snJkfuwxAVIs943n/KI7TMx8CylhApU9r95v8I4sa6g4NUPADxwlEQh7qypGsE1mhZxNt5HPc8n3R7m13bBVNlZpMB4u9pFxHGEp7QCCcA6Xxd2BCrzMCHaZxp8/3oYhAgiJloKcsF0BjXKGpLVrD5Hr2oxV16ARNKm/EfhsUjJx4Hb+gvLgefPCv+jJ9Ea1PGI/+twrniLed6rG/V2M2aYTUtueR7FKPXVNccvHxxfANfHwNhmFJF50czLRym7mm1Fyw3s1AaN0Cj7uw3lLXfijs90IquvBlbCpGIQcO8doZr+hM4AIWwdFbPXZRg9SrZiqoUuJfZ3SeHxgTArsydsBnIpkC4W2aTO+KidQr+uoMQt0mNOMZbXAVEORBTYrdl3ICAw4s5oMaY15EBVHgjfHIIHsDvtgkg0laoMAMCbDtX8JpwxNeWD/dPwcUL6eJngIFl9XLyMK7TDGq817WpCBZtrHt3y2bSXbaHQGgW8s87CXEgdNv9KHFUFx4UI1n1YYD0L2YNaVuAMQTWGpsRDNpANxTT5WyOKA0KVQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(396003)(376002)(346002)(366004)(136003)(39830400003)(4326008)(33656002)(5660300002)(38100700002)(8936002)(122000001)(316002)(86362001)(8676002)(71200400001)(110136005)(54906003)(2906002)(66556008)(76116006)(91956017)(66446008)(6506007)(9686003)(186003)(66946007)(66476007)(26005)(7696005)(55016002)(478600001)(83380400001)(64756008)(52536014);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?9bhfBi66zGn8O8ep3YFtf4WpgXAIgAK7UEZL491XGIbMrPdYB1OD2R08TM?=
 =?iso-8859-1?Q?cVEiq2hNJSiOopC7CWjEW53xgaUIA5J4vQRBiGJutnOF7LeEfKECdJg727?=
 =?iso-8859-1?Q?/HpAUvT+WbKAP3O/LsapFFWfAhcA3OOd0Sf/HIyuz/nefzkMpM92n7ungg?=
 =?iso-8859-1?Q?r6rXa6YckH/3xyajncdgHE2qpX8NZkrRHK91uTuMxy6yg0YWh6AHamKmeO?=
 =?iso-8859-1?Q?XtpZKlxt8HiHc2ZwC+TDJirNLidYIHmNydWXuhtWhQg0cSDJSRj5zidc0i?=
 =?iso-8859-1?Q?mReuoRKBQ0bL7aKg18+EbdWfHu+1ktHLmxgA8k8OpNzYsFAp7iEcBCTGve?=
 =?iso-8859-1?Q?K9KdpI7mP4J6WgfNSOUWO0QUG3ECgBaXuBX++pPBLMflIKTvNiKKjB4EiI?=
 =?iso-8859-1?Q?oj/mGWhb97X+wi8SjV9ua3ASeiB6PDlAr1zqSWt6MBKBwpr+AjD/7eR2Nu?=
 =?iso-8859-1?Q?EdHgp/FhNEpnT2PIlzqKvU0J/ZHDPIwr8nsAhSJ5EC22K0ETJ6tXaCFTxR?=
 =?iso-8859-1?Q?UIjQ6ZymEo5v7s7pG+hDUZ7aQdeOPKHTOyiqRSpPbj2+kabjTf4JJ3Ka3M?=
 =?iso-8859-1?Q?x6lRur646WavYrH8YRBxL5l7wpbXqmrxoMcMqZIaMBvNGk24i0oQ/ydOxx?=
 =?iso-8859-1?Q?c6K/n3TS8t0T8PA+NaT9EaJ9lBae8GZGMR+iMoBFXlSKjcyNz7rzIxMWuo?=
 =?iso-8859-1?Q?Isy6aPKDPiphl1xCVVu5NtSGBEW8IUzVGoOb4pJ1CUFLWOEcbU3U/eyVum?=
 =?iso-8859-1?Q?q2LgSlgYVoZaqPgqCVLLQfnqbkpXqGXsbCuouu1iDUe5bsFk1R30JW5LJ1?=
 =?iso-8859-1?Q?cg/UNBmmGN7gZ1IiplN52ezJ9D4WwGACDRZIRqKkyIf8R5f75FmDOqeadO?=
 =?iso-8859-1?Q?i0rEJbKQpmcMvTTAKbBTV9F7wP64LeafZy46y0vC9l2R8lZFMv2lR/Semb?=
 =?iso-8859-1?Q?qkQv5OJga2UFgyJm2DLjgXJYAytaW6b9zjTy55OuTVPf0JiouXdBfqwHMs?=
 =?iso-8859-1?Q?wK2w3sTuGRwjEv8N2WIzRUvETZKoP8MNE3dJQIfQ3fvJjwYUqqisFbZAe0?=
 =?iso-8859-1?Q?GxDwUczN36j5FTQvAMfv3B4IC0uXgx2iGYeKhYMEQ30nbe3SbmvNH2g5kQ?=
 =?iso-8859-1?Q?gh5d/MYM3Fnmlyl/QDvvvPFSjBXBUGW8D+kNJQsfKV5ng5DFZ1M/d3JhRs?=
 =?iso-8859-1?Q?m2lP+4cmpcW+9X9evdb2FLiAMtQOrmoV+WuseVwx6i8TtOuda4Typzj8n6?=
 =?iso-8859-1?Q?Cl48xoHklvgrJxJlXX5ZGglfStAg40/S+dAXDYZzQ8U8fEbT/P5rdKZkQQ?=
 =?iso-8859-1?Q?4dCBdZ1aszseRh4IfN6TK34oAFgWLSrCf/zU7oSmVSWskOo=3D?=
MIME-Version: 1.0
X-OriginatorOrg: hyperstone.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c35fc60-a2be-4eb9-4ae5-08d91143b47e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2021 10:34:33.7037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 86f203eb-e878-4188-b297-34c118c18b11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0lMvsNVOkTeAxmV2FKD8zlNfoSnCuLVUdcytuwugkraKZvZnDpXx9EYF/6InDAKVHHXEwhtc53asDyZ7FmDswg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB2023
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

Prevent busywaiting for TRAN state indication
after issuing a command that will not transition
to TRAN state.

Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
---
 drivers/mmc/core/block.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 689eb9afeeed..48be2ca5e3d1 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -446,6 +446,20 @@ static int card_busy_detect(struct mmc_card *card, unsigned int timeout_ms,
 	return err;
 }
 
+static inline bool is_tran_transition_cmd(struct mmc_command *cmd,
+					  struct mmc_card *card)
+{
+	/* Cards will not be in TRAN after completing identification commands
+	 * or MMC_SEND_STATUS if they are not selected.
+	 */
+	return !(cmd->opcode == MMC_SEND_CID
+			|| cmd->opcode == MMC_ALL_SEND_CID
+			|| cmd->opcode == MMC_SEND_CSD
+			|| (cmd->opcode == MMC_SEND_STATUS &&
+			 MMC_EXTRACT_INDEX_FROM_ARG(cmd->arg) != card->rca));
+
+}
+
 static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 			       struct mmc_blk_ioc_data *idata)
 {
@@ -593,7 +607,8 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 
 	memcpy(&(idata->ic.response), cmd.resp, sizeof(cmd.resp));
 
-	if (idata->rpmb || (cmd.flags & MMC_RSP_R1B) == MMC_RSP_R1B) {
+	if ((idata->rpmb || (cmd.flags & MMC_RSP_R1B))
+			&& is_tran_transition_cmd(&cmd, card)) {
 		/*
 		 * Ensure RPMB/R1B command has completed by polling CMD13
 		 * "Send Status".
-- 
2.31.1

Hyperstone GmbH | Line-Eid-Strasse 3 | 78467 Konstanz
Managing Directors: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

