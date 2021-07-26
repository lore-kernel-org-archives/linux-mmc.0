Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FDBC432BE
	for <linux-mmc@archiver.kernel.org>; Mon, 26 Jul 2021 16:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61A8960F57
	for <linux-mmc@archiver.kernel.org>; Mon, 26 Jul 2021 16:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239668AbhGZP5A (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 26 Jul 2021 11:57:00 -0400
Received: from mail-eopbgr60083.outbound.protection.outlook.com ([40.107.6.83]:61927
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239408AbhGZP4z (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 26 Jul 2021 11:56:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d8VxbZjgFl+WQ5n1UsoaZ7kQgkTUukmd1yojI7jut2TX7lcdICc5GoYcwAfm8uvVt1pKUvr8Pn7b+jFim1xbK63A80AyXDfaUNHMR//9KZNpa6lf2Ty9kqx6vIWEjrqapG/sz8oC/MLsZ4P6lwNVNc3MPWqNKrL8WfNk6elccMA8NTdqlk1uZ8vYdpYfE88WXqpqSrfWoEK0CMxLz8MFXLUntbEAeshvTO7n1p/PElDCkWdsoSZy7inEhbmb9TJxfblLPM9O6ltLt40GUaX/9upkyuMolTB/3GfuP8rxLce2eVXgcctgjF4UFMJND5V0i7bzE0CvqhIvIgzy6RT09A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kgmntm8Eu+a5W3B7CrDNtm5586nY7WtX5nHjm/P8/HU=;
 b=lkI33JBecFFkmSZZ3l+cbNWBg+967GcGpIpSeaSRTpghNVv0+GjwCbsBuJa7FYV+xW8Truqrs2WGraVUvo74Rtq/eEHOlrkZRUl/FC6BY2jj3GbTJwhJGtjEoZRnUqYxeOIVykgbEsRuifGp7TD829+DEW2Q3hYMTYfLx8M7BSIvl0JjVZ+s22UGS1iLddtQjFxWsJFamnCerlPnUJkSNRTHFeAf0dkGBooAuuqJh/GkjchpYcUdSOu21kQkZai9aTq7iJglAvQ/830d0oMwzXP7VZzB1RXkOC6EWNlnsNXhvsUxeLwxeVrdu4MOC9XrEHcPE/j+qUg/MsonRhXtvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kgmntm8Eu+a5W3B7CrDNtm5586nY7WtX5nHjm/P8/HU=;
 b=Jf2ygHbCMQqYjyYt3bZnIwrSnhqFomkoru4pmdGswWAkoYr8X8E+W3DW1cn8hi+K1DcEOvuCImID4qlZ2rqZFyyAQZbdmflNyztWrxgZNFqZ8E2YLBEJLxfpcmRvyQfcK1Uf0ZTqgQoGSHshTWJZXGWYfVBfTyVt55YRi7z54tU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB7PR03MB3962.eurprd03.prod.outlook.com (2603:10a6:5:30::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29; Mon, 26 Jul
 2021 16:37:22 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1%7]) with mapi id 15.20.4352.031; Mon, 26 Jul 2021
 16:37:22 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH 2/2] mmc: sdio: Print contents of unknown CIS tuples
Date:   Mon, 26 Jul 2021 12:36:53 -0400
Message-Id: <20210726163654.1110969-2-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210726163654.1110969-1-sean.anderson@seco.com>
References: <20210726163654.1110969-1-sean.anderson@seco.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR14CA0023.namprd14.prod.outlook.com
 (2603:10b6:208:23e::28) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from plantagenet.inhand.com (50.195.82.171) by MN2PR14CA0023.namprd14.prod.outlook.com (2603:10b6:208:23e::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26 via Frontend Transport; Mon, 26 Jul 2021 16:37:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46df3b33-6fd5-43cc-398f-08d95053a4b2
X-MS-TrafficTypeDiagnostic: DB7PR03MB3962:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR03MB3962EBFC52FE4627A4B87CCF96E89@DB7PR03MB3962.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:655;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eNw6J5PjtGFzzHGWUoL6gp4OAv79Yxzix32mSupP5QFUmBoh3hsb+2Nznv37EJLxfo54EHYaseGL+SalC7WwOngB++gJ1ZnKkGcmwPZf1LjuLU0yQ8ImxTBrDhbcHlFA/wP9jcEONTFa1K0nh0h15rwdPuz2HP41DFofHXZFORlalmNmLy4taPRp1slCJ5IWynNUVIw6mFRRN/FevGqfBImqiVcEKFJ8+fHrhMZFo0zr4Jy+7Efn1qSZeSlmGRUyGTgSkfwFeWIKYoOYWWWVY+B6muete4Wl/mshM34m7cQCkTlxTj4NpXITBY+6mUoJaudN8Uw2ER7Py7efCzRxlOmWLi+HHmDmzdVoLvHuxBeHBRwpEVol0ipc2hcruHkeOUM33cVqLtuWfK5+WKTsJtZAgLuH/SugWpQEbWi2ijUFrYAbB3yl9RLGpel+l5b9TlUqo9NVFy2adkzs4KUQoWHDP0z8TKKDzDIrXbDxh1+oUH1o1aWvIvMWF+bT1/tQyce7stqrxn0mftAeEY3w7vTX8YGvZn8823Cu/ClrknNu6MKqIr7KbRWTbS+fCM1PZSpaEoqUXAxY28m3/PZ4kLQeuCPBpQLeookbFzqpVFjyG09D5+LpoM9Of6OKkvYxh2vL3A3L5U3tE1RevzkZeXbQhQmdCvbVOKpiDavUNusVERzGc/BBnb1xle/keb6rtuc5vFHWn4IcUJj6RcamyQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(54906003)(38350700002)(316002)(508600001)(186003)(6512007)(86362001)(36756003)(66946007)(107886003)(66476007)(8676002)(38100700002)(6916009)(8936002)(52116002)(4326008)(6666004)(66556008)(26005)(83380400001)(44832011)(2906002)(5660300002)(956004)(1076003)(6486002)(6506007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFVvYnRpS0libE5CeU9KdldpUmNCQnVzQ2RnbXVoc3hsMTYvN1lvbDF2Mmx0?=
 =?utf-8?B?aHRJR0tNZzNldng4ZnZMYXFSc25GTHFpSTNmMmNpNXBnWXVKeTlJUzV3VDJS?=
 =?utf-8?B?V1ArVmluUHFKRzZXTzNyU3JEYVdZSDZLK2l5cjQxL3lFZVV1cElTS1ByN05X?=
 =?utf-8?B?cmJsa3MyZnRha0FkSGFiTnRsVC9xY0liZUtNOHMxVGVQeFhWOGVmZ1FOZ1Y2?=
 =?utf-8?B?UFJwdGlUZU1sME8rKzNvY2FHTFdIZkJxV3ZpRkY1dEVHSTRhUTFQMVFZSW9h?=
 =?utf-8?B?Z3dxUzZvS2lzRS8vbXNUanVwRGVqNmFTdy9NZWE1Y0J4N0I1Vmk2UFV2enl1?=
 =?utf-8?B?Z0xiYjByVFozNWkwSnRhSDJSU1FoRGpoU0tlRjNwVXFHd0p1SmVxdURGQjBo?=
 =?utf-8?B?NnVWR204T29YNkk0ODBaRXhueVJ1UGl1MzIwUlk0all0SFkvWE5oZHRhSkIy?=
 =?utf-8?B?WmNZd2Q4MlAxaGZwY01oWnp2V2FZQlNpdzRJUkhFcUFrRG95aWcwTnQrdHhD?=
 =?utf-8?B?ZXdoNElIY1FGK2JmdDliUHVNcUxNN2o3a1BmalRWbzQrVHFDUmo5Wk5PZkRB?=
 =?utf-8?B?SExYMklKc29teXNZUFBaaHZxM3JDa1J5ZjR3Zng5TmV5N0VvbDI1ei8rRmhT?=
 =?utf-8?B?NmdTbUdLWVNqa3hQcmlESEJDTjUvOWtkK0Jiemx0REZycnhSY2l0ZjhkV1FU?=
 =?utf-8?B?TExBSi94bmt4TEpKS3UwU1NiZ3A4bkw4Rld1eis4SDFjZ0FNRVRqT0M4WlVX?=
 =?utf-8?B?ekR2dlpXeVhvN3lrWHlyaFo5QXNSaXVxOXA2RWw3YVc5Q3QvRVdOU2VEOWdm?=
 =?utf-8?B?ZXQxNnRZYlVqcFVvVS9pVk5rcjdJN2VWMVM4Y04raGlaaWQveStGc2NNRnhT?=
 =?utf-8?B?ZUwvTm9USjZjUFRGVFFiUUYvVTQ1Zlo4T1oyM3lCbStnK2xYOXJ3eWV3NUpq?=
 =?utf-8?B?emNWaGVhWmdCbk1ZMTZvSWFZUjBLeExrYWw4aUhrOGpjZkptUFRIRW1oMm85?=
 =?utf-8?B?TnRvaGFUaDFpcHgwUmJGSklmbkZ4alhEcnNaVGhZTEpkZjc1UzZMMlRzZUhj?=
 =?utf-8?B?NzF6N0hlUEdSRGJkT29HUUNHY2c0WHlaVjRJamd5SkhjOXNENWNFaElaU2Vl?=
 =?utf-8?B?R2xheU9handoa3V0YjFvanJ5VHJrelY5YkRzcURjSjhjS1BCOWhTeTVrMnM4?=
 =?utf-8?B?eHh2MCtkemJveUhBOE02cGxWa2RIZXpXdkZpWC9La0FYRlNUckpKQVZ1eUw4?=
 =?utf-8?B?UUN1ZzFBYjNyYzZFWlhBdm1jUXJpT2xxQ3FtSnY4RFRkZGtjTHJOMURRRTQ1?=
 =?utf-8?B?SDR1VDRqeEl6SEt1d241VkV1QkM2YW1NWGlkUW9uLzNVVDBCRkFkRGU5OWlB?=
 =?utf-8?B?cC9LRGxlQVhiRFkycFZqSHRnVUlkZnhKeStRN3R0M0lzUmpYWXA4TEtHZC9M?=
 =?utf-8?B?ZEtWejhjQjJGNG9lK2dwSFZJaE1PZkU2aEVDMXRRdzR3bGEzcGNyaWprNCs1?=
 =?utf-8?B?SkNPM3dSOHBKaGtWbUlQMGJ4dHdGcGZRUjZWOXZiandiYmIydXI0U0ZERmZP?=
 =?utf-8?B?YWEzdW93MDFkc243b1h3S2RXL05JTTd2enNMa0VieXBBVmlEWm5pQjA2bzBi?=
 =?utf-8?B?QjJTM2J3MDBpSWQ0MW1pSFJiODRRcTVZbzQwZ0JnQzZGNVJMRzcyWnlKay9i?=
 =?utf-8?B?NFE1SVpXVGpwZkd3NjZ4T3N5Z1VEblZiTlozcFRScEVsdmtRUlhnSzUzbmdy?=
 =?utf-8?Q?cIH8AkWVEcy7aeBcoPtbFjKf4Y5vPFknmzVrqHN?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46df3b33-6fd5-43cc-398f-08d95053a4b2
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2021 16:37:22.7106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J3b4srHLCqKjAKvQI9Wp6iH6KAES9E8007BRHFYp7hLIORt5eMOeNflcSs1leqvTIGGHMspxyHeDXw1mLCzIAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR03MB3962
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Print out the contents of the offending tuples when we do print them.
This can make it easier to debug, since these tuples are not exposed to
userspace anywhere else. We are limited to 64 bytes, so keep printing
out the full length in case the tuple is truncated.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

 drivers/mmc/core/sdio_cis.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/sdio_cis.c b/drivers/mmc/core/sdio_cis.c
index 7518b27bcef2..a705ba6eff5b 100644
--- a/drivers/mmc/core/sdio_cis.c
+++ b/drivers/mmc/core/sdio_cis.c
@@ -334,7 +334,7 @@ static int sdio_read_cis(struct mmc_card *card, struct sdio_func *func)
 				if (time_after(jiffies, timeout))
 					break;
 
-#define FMT(type) "%s: queuing " type " CIS tuple 0x%02x (%u bytes)\n"
+#define FMT(type) "%s: queuing " type " CIS tuple 0x%02x [%*ph] (%u bytes)\n"
 				/*
 				 * Tuples in this range are reserved for
 				 * vendors, so don't warn about them
@@ -342,11 +342,13 @@ static int sdio_read_cis(struct mmc_card *card, struct sdio_func *func)
 				if (tpl_code >= 0x80 && tpl_code <= 0x8f)
 					pr_debug_ratelimited(FMT("vendor"),
 						mmc_hostname(card->host),
-						tpl_code, tpl_link);
+						tpl_code, tpl_link, this->data,
+						tpl_link);
 				else
 					pr_warn_ratelimited(FMT("unknown"),
 						mmc_hostname(card->host),
-						tpl_code, tpl_link);
+						tpl_code, tpl_link, this->data,
+						tpl_link);
 			}
 
 			/* keep on analyzing tuples */
-- 
2.25.1

