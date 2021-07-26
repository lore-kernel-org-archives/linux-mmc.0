Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 227AEC4338F
	for <linux-mmc@archiver.kernel.org>; Mon, 26 Jul 2021 16:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E7E960F11
	for <linux-mmc@archiver.kernel.org>; Mon, 26 Jul 2021 16:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239669AbhGZP5F (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 26 Jul 2021 11:57:05 -0400
Received: from mail-eopbgr60083.outbound.protection.outlook.com ([40.107.6.83]:61927
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239658AbhGZP5B (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 26 Jul 2021 11:57:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I/b4oikYiMrKaXZb/xdQBy6QrHokWlEYy8E9GkmQkxkHNCjEoWlw8zSM3i4NROC4Yf1+FdecNjFFzsR8q+b3domVYvfU/jgeD5lTgBqh9nQGijyKuU+rA7S6vcOwZ8AK9Df2y8lFihlhdtOYMs3T7q5vZPqjhOtkVAzeAZVsy+L/x+S+h07bbIyoq9vs6+o6GwhqrZcfzUZEeqpLXI9hG7WJDcOnZUiEqzbqQcX1Y8O9VYatD064LapnUzIh8TWHCpXG75SEhTygiYV9vWK4DdK4Imw6al+9pgT4ITzuf7R5qHJCnLhKvZFZu6DPlpnuxKI5vDb2dGR86p3HTKuvRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0xuEiK9hUfYnRGYsrKf/pk8lnC0/zbdqdLg0jiHkEo=;
 b=C/K6tuN7X4yCw1wmCzg3N6+r9yEQXA2HetXdZ3+m0oglYrvfY3asNGuKO1tm1rKw2yjdy1dIZzR7SByfCJcJp84G08pPxrlFuwTyvI0DCXWH0kbGz8cf03cjPwIgVPuMujeiNO/fR5MSqp6KHddaYFflj9RWWBSfJcofLPS0mw5wW0xFKl1PhpR/ET786xWJVIggAyPqr3IIyFHWoGT8Cj5o9neTUpXeVqBE9tgtsi0NzdQhsWHSL920izfOkPWoCGn14YRloWpyQviZvYUpyL454M+iEQ7YRPFzm6jkdNy9MtlqU8Nfo+E7y1zSX7NnvSA3Z864M6xnCYI8wVIGqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0xuEiK9hUfYnRGYsrKf/pk8lnC0/zbdqdLg0jiHkEo=;
 b=suAfjub1VrdQMp1BQONh+0QSC8KvVcP9ZoWkjzg7N4Q5D3NUnOou6qZXWiaWwXt7Ovf7bQ/0kwkxN2VDlDM27m2Pks+yck9h84guDSwz+PP2dRXQW5nJLjMPWg7ZCfHc2OSRQe/qxsK528b5dUlp5UQQWf5dGinubfNjDRC6HgY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB7PR03MB3962.eurprd03.prod.outlook.com (2603:10a6:5:30::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29; Mon, 26 Jul
 2021 16:37:21 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1%7]) with mapi id 15.20.4352.031; Mon, 26 Jul 2021
 16:37:21 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH 1/2] mmc: sdio: Don't warn about vendor CIS tuples
Date:   Mon, 26 Jul 2021 12:36:52 -0400
Message-Id: <20210726163654.1110969-1-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR14CA0023.namprd14.prod.outlook.com
 (2603:10b6:208:23e::28) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from plantagenet.inhand.com (50.195.82.171) by MN2PR14CA0023.namprd14.prod.outlook.com (2603:10b6:208:23e::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26 via Frontend Transport; Mon, 26 Jul 2021 16:37:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45f9d9c6-7f01-4a8f-572d-08d95053a3ff
X-MS-TrafficTypeDiagnostic: DB7PR03MB3962:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR03MB39629338FD943D913DBC753B96E89@DB7PR03MB3962.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:295;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gRdofisrmwlkbyhOTYE5w2cqwOHAz39l5XPc/VZJxMS6qhBWYszbYpkQp1oe8GrCBPxmWav2X1JdZwF8i40YEFaLft02695JqiRuUsxBfMkOFnmZUi0Kk4oPg4rU33Il/QcOet/KBC/VhNMkngQI3IvYB2kcZlyeV8OiZ6HC2dCT3m9aKDbatwBIEiK3kaiajYQS8mrip7suWfRVOIEDwntHU+3+WHIuIq9VDVq+IuuwLMvmHzwLm8llclPsCHpUaCEpevODwBbC8ISaYFtqtUOWZZji8Dgyjuc4ekccgZVRWd0lG3dqxg63reaJV8FSD5m1E0C5N2ADbuqewqHdD/HUadSODqKtc9chl+eC6UsYmRMKfl+H6kOBvJahJVHrsmqF+xCujWJgbgg9nWlaslNcEOKpF6R9Ppi0EUqeoYVXM1IFm57jE9kqbd5jWgo/H5uSoHaT44zl+RN82qRSoYk3f3Yi6DgtjUkjfMnbO9/WPSP3xJH05hTd5CLshu0DgmK8sXpSQjSZCSxSEWLLTAR3JmBKmRlENl246iBupgHIBdWGz1wIySfYNTbzmxnDYSvIW8Dm6fHbsd3+drhGubqx8D7ADKwxvlCnDKT+hMMDuyEfnDu1wxyhgw23JWGY/5FXjNVOvBenECnlhRoJh6mkJ+vxlXR3i2bIgCWGfHPy9z/V7C380jda0xIbSvutWEpQU0ulFut1G2n8FmxpDw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(54906003)(38350700002)(316002)(508600001)(186003)(6512007)(86362001)(36756003)(66946007)(107886003)(66476007)(8676002)(38100700002)(6916009)(8936002)(52116002)(4326008)(6666004)(66556008)(26005)(83380400001)(44832011)(2906002)(5660300002)(956004)(1076003)(6486002)(6506007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sFbxkPpCpeGc+5E1ofPD/EogW0iu4ZRDAvwZ9ow4kBiZ6X2LvtfgtRBW5O+c?=
 =?us-ascii?Q?mvlaJU163flJnyaaQZJx9QlEmEEiTb8l9ZOXk+Xs6pWW1tFBkWYMDFSsAKZc?=
 =?us-ascii?Q?xGm5HZuTOTTVNMWYcMztU3KJHlLdc9Hr7rzMb6AbCDFqrNRc2ehDglbFZfg3?=
 =?us-ascii?Q?q0KT9lS8UJ4Xo6k4EAZQhBI6xpeEnQgztE0r1HGe6wyXCrHPGuXvRiBzG/yw?=
 =?us-ascii?Q?71eTyVNYICFyaOvST9/IqZ/Lmm0OyHagWQPZG5NyOjqtzLIO0Lz+FuFbkh96?=
 =?us-ascii?Q?OnL0pU5Zveb7ziHS5r7pJy4KIOgzMgYRKA0SqH41W1bp4IWhKajVegSBJO03?=
 =?us-ascii?Q?KzbU20RAlANOnSfS3jufiXHEQwuwynU6dVHJ/cq1mqP/929KnNrMwgpiNiZD?=
 =?us-ascii?Q?Wz7GIL+fweV75HN5HK/sfuFvFA1oPXubhqIIRgMzlQ8ImrQsk7/cspVaSGP9?=
 =?us-ascii?Q?Y75U60e6IlWHJZTdAMDWd7OcgVv2x2rULm9bSLFJvVN28unhcmTAgL7s64vQ?=
 =?us-ascii?Q?U0MvxrFWhuYs+I/qgqyG9ZX99JYtnhCoX4D/ixii93akjSk+SQF7TPASjvV8?=
 =?us-ascii?Q?ff0u41z8xkf3znghY/Xaczfz/HrokK+6ydDyOPL5w5qX5AlgpaKFlDwz2SN8?=
 =?us-ascii?Q?ud9MXacSVyCQjaGn8/UIbCWRrRybEEc3kTmfC/OL5LF4DyBPKW1TK4nrGFHA?=
 =?us-ascii?Q?g74WEDzzaDXTDZwAfuf+daNNtwgIOD6UVJp/XQqvH3eGZOye5/15z0SAQXVK?=
 =?us-ascii?Q?DEDBi7mXkx2tMVUkQxgx3op9TECTIt6Xw8Ajts7PQInsST9OWrpZAZlQM6tp?=
 =?us-ascii?Q?tUtgUJGmEnP/Z0RCGZnnpeMKF6CydvuGXTZNRJ0cESH8HgIbvvdyz+jdoJOO?=
 =?us-ascii?Q?KV1w5cGNX29cJjstHAK6H1tEUh2Gjno8VfkOHoU9oDd8JOWuECi1pITCUmzv?=
 =?us-ascii?Q?aqDG+TpEiTwCRwa3QiZcbCQfdVvV+G3BOV1YsxdCh71LJfa1gzncJ++CEHjx?=
 =?us-ascii?Q?TOZNz6KnKtYwENfUfqFHS/48PIAjQns4DcNIos1J1wUTNr+TbizGuUX2GnCy?=
 =?us-ascii?Q?tBzJZ8pNPqlUBCWW5p831HA2J1hW+GY9C659aSp+s6MAs1yMqmltRKf6H335?=
 =?us-ascii?Q?H19ZMosa0ZKh/tzrOI99NCYCxibjEBhSSW5JFZ4HDJ1DA6XPEIzllYcrs0Gg?=
 =?us-ascii?Q?l0GZGXjGycBjOxLOIBtE/nhSOr4Unp+nkCX5Ia36sNPHTVAIQfWG3PlPmvqO?=
 =?us-ascii?Q?U9P/Kyjm1QO3HeBjT54PL+mjPSD69siUxkv44U+1R5n5tsSLXHPxLlq73PH8?=
 =?us-ascii?Q?S34Wsv7sdaes47Ue8fBdr5kH?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45f9d9c6-7f01-4a8f-572d-08d95053a3ff
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2021 16:37:21.5332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6z+D/d3lzUf2nVylzNpOk9dvgByXuKYAL08irChYOat2IMfSAenxWYi/XW52/kb4dZWmTWpYnf0aFkbW7PFEFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR03MB3962
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

CIS tuples in the range 0x80-0x8F are reserved for vendors. Some devices
have tuples in this range which get warned about every boot. Since this
is normal behavior, don't print these tuples unless debug is enabled.

Unfortunately, we cannot use a variable for the format string since it
gets pasted by pr_*_ratelimited.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

 drivers/mmc/core/sdio_cis.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/sdio_cis.c b/drivers/mmc/core/sdio_cis.c
index b23773583179..7518b27bcef2 100644
--- a/drivers/mmc/core/sdio_cis.c
+++ b/drivers/mmc/core/sdio_cis.c
@@ -330,13 +330,23 @@ static int sdio_read_cis(struct mmc_card *card, struct sdio_func *func)
 			prev = &this->next;
 
 			if (ret == -ENOENT) {
+
 				if (time_after(jiffies, timeout))
 					break;
-				/* warn about unknown tuples */
-				pr_warn_ratelimited("%s: queuing unknown"
-				       " CIS tuple 0x%02x (%u bytes)\n",
-				       mmc_hostname(card->host),
-				       tpl_code, tpl_link);
+
+#define FMT(type) "%s: queuing " type " CIS tuple 0x%02x (%u bytes)\n"
+				/*
+				 * Tuples in this range are reserved for
+				 * vendors, so don't warn about them
+				 */
+				if (tpl_code >= 0x80 && tpl_code <= 0x8f)
+					pr_debug_ratelimited(FMT("vendor"),
+						mmc_hostname(card->host),
+						tpl_code, tpl_link);
+				else
+					pr_warn_ratelimited(FMT("unknown"),
+						mmc_hostname(card->host),
+						tpl_code, tpl_link);
 			}
 
 			/* keep on analyzing tuples */
-- 
2.25.1

