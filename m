Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD11C47082
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Jun 2021 06:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CAE3611BD
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Jun 2021 06:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbhFHGam convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 8 Jun 2021 02:30:42 -0400
Received: from de-smtp-delivery-105.mimecast.com ([194.104.111.105]:50371 "EHLO
        de-smtp-delivery-105.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229507AbhFHGal (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Jun 2021 02:30:41 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com
 (mail-cwlgbr01lp2050.outbound.protection.outlook.com [104.47.20.50]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-18-m2hKCdjnOfipgPV8JQgFYg-1; Tue, 08 Jun 2021 08:28:46 +0200
X-MC-Unique: m2hKCdjnOfipgPV8JQgFYg-1
Received: from CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:89::10)
 by CWXP265MB2856.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:c6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Tue, 8 Jun
 2021 06:28:46 +0000
Received: from CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
 ([fe80::e508:b3cb:f065:656f]) by CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
 ([fe80::e508:b3cb:f065:656f%4]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 06:28:46 +0000
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     Shawn Lin <shawn.lin@rock-chips.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH] mmc: block: Use .card_busy() to detect busy state in
 card_busy_detect
Thread-Topic: [PATCH] mmc: block: Use .card_busy() to detect busy state in
 card_busy_detect
Thread-Index: AQHXW34/muF5H+lRqEqNA/AV0O+EyKsJptlp
Date:   Tue, 8 Jun 2021 06:28:45 +0000
Message-ID: <CWXP265MB2680A140D951939931D1729BC4379@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
References: <1623057495-63363-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1623057495-63363-1-git-send-email-shawn.lin@rock-chips.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [185.80.168.10]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dbec789d-f2e0-4bb3-b045-08d92a46ab5f
x-ms-traffictypediagnostic: CWXP265MB2856:
x-microsoft-antispam-prvs: <CWXP265MB2856E678ADA4D569AF7D897CC4379@CWXP265MB2856.GBRP265.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:2958
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: uO8dbaR5mlh87vIJ4GfWTuJfYkGDf2EMJ+3M6oNriYDVrQRpPYXNH9ckeXNsGCGXOPau2in2z+2c75lySD/V4QmINRHeskFGdiTsLI98KcRxLFTCqok938576aNW8y6o1/XZrS5JQNnhjzZBMERK5ajtcvAGXU1Yvu4tzD9QdxWpJJH0yHiC2Ka3Hjg9Pv14I117MSY7d44nQvwzN/LH2Zh+IIilXnuNU74foTWADvRxmpUAQXYNCV8R1XbXxLZ1ur0OJ+XEeO6Gm0VQlPr4vKtQuREkrVi6CDpdPP2E6E26RxVJdN6m71gKka0jybonhnpC6HdqYt5rggUo59pnWN7/RI+YzfmAqwplzjjPLdg46RyCYpPzm7aINvBSZETc2EzXlYRvQQU0+U4fuXZCVxdd54NKQw8kHRGxj4TAWtZHPzzB+JKyYGEzRREEMLFidao5ibNH4XrSKSIbPSOh+ooubXUS3tF6Cu+NPehepZb6AlDNZcwlcJ74Zm82kMPNQYTKlM2odWT6JhHfqtofOq7U9grNM3ZgMT2g70e+aiZWrA6mddbswKCYywiEom/NmAX/812TpSBhObL9njEb8aAt/LJwueUpbEri+nAVK2q7fd5b6e1Xnu8LgVrfxaCIvRMg7LpPNLr/jQ2GSiaQhg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(39830400003)(136003)(376002)(396003)(346002)(33656002)(71200400001)(55016002)(83380400001)(478600001)(7696005)(110136005)(9686003)(38100700002)(6506007)(91956017)(122000001)(4326008)(76116006)(186003)(86362001)(52536014)(66446008)(64756008)(66476007)(66946007)(66556008)(5660300002)(8936002)(8676002)(53546011)(2906002)(26005)(316002)(142923001);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?rzf4I9FGyTeRvGN84s7iPJM+ajWe2ODJ3bM6hzVE5/fNIL03ZUI18yhiu7?=
 =?iso-8859-1?Q?v+GYX8Lr7k+9dEPdwbeEufWEtvzq105bb9JHg5i1u2+A1wRkpmr7zUrMG0?=
 =?iso-8859-1?Q?xP8KiRFBh1JF52O/uj5KyOdqxe4yNBCxzVLU6jO3SuztKPS8UmazlKcbjA?=
 =?iso-8859-1?Q?GmZ+5BFNO3P4YVRlxdNS+UYNWS/z3uE2vVnN71edjvbe/KikH4xBeixS+y?=
 =?iso-8859-1?Q?bUpV4GRPU7ghT97gSnfriEss7MKWcR2ibiC1Mf+Dn3Ff+wY1O1bcQTXnt3?=
 =?iso-8859-1?Q?1E6qQCuDednv+eldTbr3W65Ewhc5VmFB8KeGCOjE5VLzVJkJxXOaKuNyhC?=
 =?iso-8859-1?Q?mYJrXHxE6TmP2Yzkpug3yviib8i4k9KrkeADQkT9KqUIsMUBFklgIW7WAj?=
 =?iso-8859-1?Q?F7juaqt/VA+TMVGZmuJCc+Z1OF73+38kk1x1281waRLvBufaPTbAQMSmAj?=
 =?iso-8859-1?Q?w7OzPyajbOyaHpnmKz95U0DwkqOtNgwr1mZ3BqsdfEcACqxe6z/0FL2wV1?=
 =?iso-8859-1?Q?+w5LLdUaRV6D2JzPpt53g0PuGaHGMjyFY7QCD48bt08XxjyZJqLLkxrvpi?=
 =?iso-8859-1?Q?nGsC9pCQTH9XpioZMyNoqY9kmI0CJ9hS98jakL14BHLkg/e57cmoabCZ0X?=
 =?iso-8859-1?Q?wA3XZCC+F/D+x1KzpkzC4a0+evExLhczJRYwdYb1H1/I7dCnAzKa3yzl/O?=
 =?iso-8859-1?Q?pWEQdu9aqW/o/H3Ffddm5IEo8jkFZppoLJlY2M36tqkv5QX69i/jgYT7LW?=
 =?iso-8859-1?Q?+tJnchcE1MfzxfS9/sdPTyM+Z72JTr5nBwAxVsiayNijvbDaIOzcba01RA?=
 =?iso-8859-1?Q?QzW/2NNh35kS7P9Gl1VphC+vORWgIlAoWJtc9729Uo93FoqxwxTWDTwMiD?=
 =?iso-8859-1?Q?0Jsb7zBZC+dwGmdWe85mjaexm7APU4Ncop9Pgszqg98Q2ZTD+UV6RSsnoQ?=
 =?iso-8859-1?Q?Mx6hCK2mh8i7WwaKueIrhuqcD3qspQY2lgXlugeJw5a1T1JJX8YFdETSkO?=
 =?iso-8859-1?Q?o0ex0nwsuWxAlvM2/s0QZ8q27YdWZBO6PoGI5yC03I3VPRrjqh2NojjDix?=
 =?iso-8859-1?Q?kLFiEP/XHw+cUvew8bk7Jku5ZaT3sBrroVE6F6hsdoMyRE93u7qu9zEzi2?=
 =?iso-8859-1?Q?D0UU4WG9MwRM3G4mAYbP7S+gzQcl5Rey6E7rIBoYHBeS0Vx6wplunyDpy3?=
 =?iso-8859-1?Q?kEVlnJD1uBUyviv28un1EIZbicS+02HNmIHEjjfAod/LAlVZ51481vWzjU?=
 =?iso-8859-1?Q?RzxsefJE0S9Lq1M5rGtijibaMS/9yvn34leqD0sOxuU7unjyglDbYCuG1p?=
 =?iso-8859-1?Q?jNZ0ZTdjtcCnMjEOhxNZp46uRmZ3wk2sRePfmWj91/o1QMM=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: hyperstone.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: dbec789d-f2e0-4bb3-b045-08d92a46ab5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2021 06:28:45.8070
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 86f203eb-e878-4188-b297-34c118c18b11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xc/4ztePkDfrUi+V3VN1pzb7bQ5ArAmjq28jfN4nGeluhmJiOMz1mB7XcWLC6EvTjtxuTEbQU0xwvNfyrfFhVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB2856
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

Hey Shawn,
You're assuming a card not signalling busy indicates TRAN state, and set the state manually,
but a card might not be pulling DAT lines in PROG state.
I will send a patch later that reworks card_busy_detect, as there are some issues
with some command sequences in practice. I'd ask to wait with the patch until then.

Regards,
Christian


From: Shawn Lin <shawn.lin@rock-chips.com>
Sent: Monday, June 7, 2021 11:18 AM
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org <linux-mmc@vger.kernel.org>; Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] mmc: block: Use .card_busy() to detect busy state in card_busy_detect 
 
No need to send CMD13 if host driver supports .card_busy().

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/core/block.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 88f4c215..23623a9 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -417,10 +417,17 @@ static int card_busy_detect(struct mmc_card *card, unsigned int timeout_ms,
         unsigned long timeout = jiffies + msecs_to_jiffies(timeout_ms);
         int err = 0;
         u32 status;
+       bool busy;
 
         do {
                 bool done = time_after(jiffies, timeout);
 
+               if (card->host->ops->card_busy) {
+                       busy = card->host->ops->card_busy(card->host);
+                       status = busy ? 0 : R1_READY_FOR_DATA | R1_STATE_TRAN << 9;
+                       goto cb;
+               }
+
                 err = __mmc_send_status(card, &status, 5);
                 if (err) {
                         dev_err(mmc_dev(card->host),
@@ -442,6 +449,7 @@ static int card_busy_detect(struct mmc_card *card, unsigned int timeout_ms,
                                  __func__, status);
                         return -ETIMEDOUT;
                 }
+cb:
         } while (!mmc_ready_for_data(status));
 
         return err;
-- 
2.7.4



Hyperstone GmbH | Line-Eid-Strasse 3 | 78467 Konstanz
Managing Directors: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

