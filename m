Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E309C433ED
	for <linux-mmc@archiver.kernel.org>; Wed,  5 May 2021 13:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C748A610F7
	for <linux-mmc@archiver.kernel.org>; Wed,  5 May 2021 13:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbhEENO7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 5 May 2021 09:14:59 -0400
Received: from de-smtp-delivery-105.mimecast.com ([194.104.109.105]:25053 "EHLO
        de-smtp-delivery-105.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231769AbhEENO6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 5 May 2021 09:14:58 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com
 (mail-cwlgbr01lp2054.outbound.protection.outlook.com [104.47.20.54]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-16-5x0DRsBjNEetHI0xb1Ekkg-1; Wed, 05 May 2021 15:12:31 +0200
X-MC-Unique: 5x0DRsBjNEetHI0xb1Ekkg-1
Received: from CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:89::10)
 by CWXP265MB2309.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:78::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.41; Wed, 5 May
 2021 13:12:30 +0000
Received: from CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
 ([fe80::a91f:361d:5554:3958]) by CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
 ([fe80::a91f:361d:5554:3958%5]) with mapi id 15.20.4108.025; Wed, 5 May 2021
 13:12:30 +0000
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "zliua@micron.com" <zliua@micron.com>
Subject: [PATCH] mmc: block: ioctl: No busywaiting of non-TRAN CMDs
Thread-Topic: [PATCH] mmc: block: ioctl: No busywaiting of non-TRAN CMDs
Thread-Index: AQHXQa/VaowbfC/8SUWt8lUpDQ+oaw==
Date:   Wed, 5 May 2021 13:12:30 +0000
Message-ID: <CWXP265MB2680DC98B32CD4B49AA8A224C4599@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [185.80.168.10]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3e305a4-8f3a-4416-e8f1-08d90fc7702d
x-ms-traffictypediagnostic: CWXP265MB2309:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CWXP265MB23091BA1A49BE8A546E2F827C4599@CWXP265MB2309.GBRP265.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:4303
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: xxYAFvQNC7tyJ/qrBCRUR/kb1SDrSA+D6e6nJ51Npcf8u8IqWOSsPi8A6IkciS0MvjTi4idJVNqljrtdZm5771iEV80ez2upixCK12wCF7oSO4/Lpq8a7WWyYtG6/BR+AnD5lJRVp7HcHw/OKDvITvBI+rMoi/zL2h/6vFsKpgsF5YB6RhWRlPfaU/ZKpcR70lt6oyASPh1H2QbZJFU4J36b9K5YsT0fcsTNH7wqUaJ1PPAtGHhXfYIrQXgC8UhFtR4twSh2WfTYAkvx0arCy67ZFEwdRsElRrI87yAkB4d0E9JQ4w1OjYiUtlPjc0dwWZQWe1kpkQZ93bTc7SAa468knN6gVSqqpy7q3u+QkWT3Zm5N9uQfqnlTTk+g9ztflUPa0oOovKjQVGFiTeOxVndQmuwiXdGEsi6XxbGVvWI9j3HZCBAfvGLdUWS6X/cPTndj8w1CIj2kCJtCII6rVUUSqFOaKihBK5Dbt0087q3lQKvhX9Kss5/aQHw3WRQz5hF8SdTCuWqbSs0tIYH3jsW48D1OBAtsjIsXbtqA2Ahm5z/POnZ7uj8IQRYJ4Biy830shTfhwA61Mz94Fxad8+XSdoy8jkWrHDRMfTI7Y6I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(136003)(376002)(39830400003)(366004)(396003)(38100700002)(66476007)(64756008)(76116006)(8936002)(71200400001)(66446008)(2906002)(186003)(83380400001)(66946007)(6506007)(91956017)(26005)(478600001)(8676002)(4326008)(7696005)(54906003)(33656002)(86362001)(122000001)(5660300002)(110136005)(316002)(55016002)(9686003)(66556008)(52536014);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?n47ho6qMpjdwXArIqAZ5A9kIuh9lT+FHqNgMPrQBgLLQeS0Lp1QLa+9aLL?=
 =?iso-8859-1?Q?POXTPFep935/FQrDGJgsBnRc8n6+3jQgr1MkK5A4WoLxFytUFdHjBHrK9H?=
 =?iso-8859-1?Q?SPnKPEUeGWWB6th2D+iuELcGYxtDJ9xSNUAjUBcHWEzvEh06Ii9MD1dTwl?=
 =?iso-8859-1?Q?+CmGm+k2+FZMaxsyrcCB1aZOH4Hi4H9ExWa5k6j123uFpi6A6TgkY6Tbax?=
 =?iso-8859-1?Q?JHtuX7TNtUQidaTjjLVsBAliVGfYuhQ1FpuP3jx9SCKxo51GWOZ48T8Fro?=
 =?iso-8859-1?Q?H0AcmtUHHtbkWWqzmKTShN8n+/iOVKr6Z2pebBz9UYEO8VT4xAHshKZC0x?=
 =?iso-8859-1?Q?mhES/n8UIKzjD1aj9rsOwZLSKE4gRkY/JJye08kUF7rUPpTXg5oQPQsVuJ?=
 =?iso-8859-1?Q?ulUSCkjqKZicFPlMhi99I/KkPeOo/LMY8HPdf0FreCj9zlFyQLN7cU4vyU?=
 =?iso-8859-1?Q?unHKIZxyYlAnXl7y7M1fqeCZLjW/U9SddzhmBO8SPy7vcdxIcOjMMv1cac?=
 =?iso-8859-1?Q?Z+RWfHd0mFFi2DN191HDyoamrVsLkWMvBIOxMksxbB1i0Shwe3+Xv3CHYu?=
 =?iso-8859-1?Q?dofLVTXI6hxZ0egDL+QmKXmzaVCKVY/PC9mvLzxdztDSParJXYovEIz0+U?=
 =?iso-8859-1?Q?BUbnSlSAs1YUm4ZNgoxdlJzi9DLNePXGEegtZ3CZWRaM5LRbd3djiJg6ty?=
 =?iso-8859-1?Q?/+FfTubrShQHjr/akaYLJA93Ukqi6O56/KLhpoRqE19In4UDX1n7aVoPV/?=
 =?iso-8859-1?Q?MGCKIwUUX/t/RZS89A6G+xQlD8TRp8ZPMW5DO8am75AMs+1p7Ub8q8tSpS?=
 =?iso-8859-1?Q?5p9gBEceT+5RBOmJNTWoqHf8sYhCIVhHCc+1G4xCxNknnVfdGMSL7YkYw2?=
 =?iso-8859-1?Q?h8TAWJK7Ti6JVh/9+58aJClhW3nyzFjVZLrCL7b9vDfWbpZkDo+Kpl4WNT?=
 =?iso-8859-1?Q?+lM5fEoSeScBDvFBCvNifjEVhuT4vVsjMEuG84CrEXVF726sJYKCS9nISe?=
 =?iso-8859-1?Q?NveJvzcJ1GS5sUPNKw5tcNQmPv8MB1fizwLF39afZbvWWfNDefZiq7GWsM?=
 =?iso-8859-1?Q?eVVe+PhW19AZbvojwJu7g25rgBa8GdFxwYxynJsWTZ1hMe5uRaOyfF/UMW?=
 =?iso-8859-1?Q?MeVZi1E5w0bJTkNcpMlRPN9DTX5SAbMVANrDLx3RAwHfcPN4oEC5geWpo6?=
 =?iso-8859-1?Q?Wie0PLR6Rw6DwFVpt6DYpcP9ZXF7Bks+9gOkybk0nhKJGV03xXXjjGsh1y?=
 =?iso-8859-1?Q?+TWLitKFZi1xdPdegiFXgUnlzqlBESMqYuTzKpcb4tWnKj/qVc7NtyFY7N?=
 =?iso-8859-1?Q?zmSmaSQjR6TyQFsLLZLdmr6QInH6SR4oK3QZi8Mm0crHPE4=3D?=
MIME-Version: 1.0
X-OriginatorOrg: hyperstone.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f3e305a4-8f3a-4416-e8f1-08d90fc7702d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2021 13:12:30.3446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 86f203eb-e878-4188-b297-34c118c18b11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K3XCgngGRH6v2OqmBQRn8LGtRWIIE0a5RplK1osLQoKyIP+LKiq9T/bVMj7PfUCKyN1OHnOcDMFzzDOO0rB1UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB2309
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
 drivers/mmc/core/block.c | 3 ++-
 drivers/mmc/core/block.h | 5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 689eb9afeeed..9baf95639688 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -593,7 +593,8 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 
 	memcpy(&(idata->ic.response), cmd.resp, sizeof(cmd.resp));
 
-	if (idata->rpmb || (cmd.flags & MMC_RSP_R1B) == MMC_RSP_R1B) {
+	if ((idata->rpmb || (cmd.flags & MMC_RSP_R1B) == MMC_RSP_R1B)
+			&& TRAN_TRANSITION_CMD(cmd.opcode)) {
 		/*
 		 * Ensure RPMB/R1B command has completed by polling CMD13
 		 * "Send Status".
diff --git a/drivers/mmc/core/block.h b/drivers/mmc/core/block.h
index 31153f656f41..51b806384ab0 100644
--- a/drivers/mmc/core/block.h
+++ b/drivers/mmc/core/block.h
@@ -17,4 +17,9 @@ struct work_struct;
 
 void mmc_blk_mq_complete_work(struct work_struct *work);
 
+#define TRAN_TRANSITION_CMD(cmd) !(cmd == MMC_SEND_STATUS \
+				       || cmd == MMC_SEND_CID \
+				       || cmd == MMC_ALL_SEND_CID \
+				       || cmd == MMC_SEND_CSD)
+
 #endif
-- 
2.31.1

Hyperstone GmbH | Line-Eid-Strasse 3 | 78467 Konstanz
Managing Directors: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

