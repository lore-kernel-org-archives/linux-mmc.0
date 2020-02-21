Return-Path: <SRS0=+wZv=4J=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41AD7C35646
	for <linux-mmc@archiver.kernel.org>; Fri, 21 Feb 2020 10:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08849222C4
	for <linux-mmc@archiver.kernel.org>; Fri, 21 Feb 2020 10:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=silabs.onmicrosoft.com header.i=@silabs.onmicrosoft.com header.b="MXIwQKRt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbgBUKox (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 21 Feb 2020 05:44:53 -0500
Received: from mail-co1nam11on2066.outbound.protection.outlook.com ([40.107.220.66]:6255
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726325AbgBUKox (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 21 Feb 2020 05:44:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CN+BDGfLFMX9DVCCMIChGMkYdFBtxdJBOGIBf0JAcH95D3SX945cUL/j7tTVUDlYIMmj/SMN1tkBJIY9vPfxth2juoKOBtV+UUK5pVSEk0bXomfx17j7GU6H/fCpQv+ve1dhVRr84b5Y/CGUcGlLc3hz3vRlsxITNN6Z9lWXQbTweeS/htmhbnF90wSjWQBVZs7uFgs8MhE8bBxJAWTXYV5MyAtlPtoDdR8Xt2wYahKMhKMY3laD84GXNfT8tbkytI+c3MWm40sohI/Oe8TqpyDoDy547qC+cSO3Q8OVMzFeBmCyzJlqPaBMLsME/3752aVekt7ai47d1YQigJIpuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0yKMONHiuBf2VsFkqxQTxYQqMZfGxNuIOvHK8P9lq+Q=;
 b=LcdyYEI23mOfjkni658aYNwRs9RCXY5NzobDudZayA37Ftrs5BNss6F+UbrNuOLXyRflUdAXTUWTUOycUYnMTUjT5ZsJofRYz9mWMCkKxTBp8hzzWyKB6qIbD/jHV3V2XTxM/GMk69dVz1Q3IdstV4YaVVjmZhmQnqfoxJGt62gc5J1V4VU4Pb4XV/VnVN9DVPClWGHcvCSQ/OiLng2i2iurejNpJhXKm32tnZj5sY5eidyIRu8OJV/upqzV2YNEVRQroZwSMvTsuH+yfiihSvT4HtiK5E3TP2GXEu8KOV8LvlYn37VHuf38lMnFfcFpNYGbrh4/aiXBbPlGfxXK7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0yKMONHiuBf2VsFkqxQTxYQqMZfGxNuIOvHK8P9lq+Q=;
 b=MXIwQKRtzbFDXl3nPhXMM4Lcs0uWKdBZFCmsW4FnArMotOqSgb9u0lhpDP2w/KCfgiiccAlzy3ADYQ9mSSv6b5XQ37xEzDpyFzgGjEgCgo1bh3vCg/q47Uy4St79c/ThWFHf9FKJVn1sgatuXNgUotH7ux8szpKQJ350hvxz2VE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jerome.Pouiller@silabs.com; 
Received: from MN2PR11MB4063.namprd11.prod.outlook.com (2603:10b6:208:13f::22)
 by MN2PR11MB4270.namprd11.prod.outlook.com (2603:10b6:208:18c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.25; Fri, 21 Feb
 2020 10:44:49 +0000
Received: from MN2PR11MB4063.namprd11.prod.outlook.com
 ([fe80::ade4:5702:1c8b:a2b3]) by MN2PR11MB4063.namprd11.prod.outlook.com
 ([fe80::ade4:5702:1c8b:a2b3%7]) with mapi id 15.20.2729.033; Fri, 21 Feb 2020
 10:44:48 +0000
From:   Jerome Pouiller <Jerome.Pouiller@silabs.com>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>
Subject: [PATCH] mmc: core: Fix indentation
Date:   Fri, 21 Feb 2020 11:43:41 +0100
Message-Id: <20200221104341.583028-1-Jerome.Pouiller@silabs.com>
X-Mailer: git-send-email 2.25.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-ClientProxiedBy: PR0P264CA0041.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1::29) To MN2PR11MB4063.namprd11.prod.outlook.com
 (2603:10b6:208:13f::22)
MIME-Version: 1.0
Received: from pc-42.silabs.com (37.71.187.125) by PR0P264CA0041.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend Transport; Fri, 21 Feb 2020 10:44:47 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [37.71.187.125]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a3ceceb-db80-4fb3-f400-08d7b6bb12b1
X-MS-TrafficTypeDiagnostic: MN2PR11MB4270:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR11MB427049C92D28EA398C65698993120@MN2PR11MB4270.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-Forefront-PRVS: 0320B28BE1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(136003)(366004)(39860400002)(346002)(396003)(189003)(199004)(6666004)(52116002)(66476007)(478600001)(66556008)(316002)(4326008)(66946007)(2616005)(2906002)(7696005)(956004)(107886003)(4744005)(6916009)(5660300002)(16526019)(26005)(36756003)(1076003)(186003)(81156014)(86362001)(8676002)(81166006)(6486002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4270;H:MN2PR11MB4063.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: silabs.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nXcT6t3R5zoXFzL3+zcvs2j8UQQJ0dqzqo9g1yKFWon7H2zH9n2UWyBw2bHnBCvASwuzLkhNAqeZeJaxKf8/fXklBnspdpbDOza+CxNoOLICYqZ3OpxElNiimUB8INNI6e6cz654sM0XjmBH7EhkO0SXa8LsdEGe6Xr92m+g5fk4BUyg/7yhLE67UgQyz68JiAgty6TmbOAQa8Vv7icfpH9rbXQU/Kdmew9kgc5hG8IiMUapnl54uazMMoau5EsCnibviehfSabEw33i3BQCeW5mGlFUhqwB/9m/r2nmo8xcvRsOGT4iQBxrx2TlCd6LSS8WJCG0XiSVs/opf1UZBiZ+Ubp+6fz1xXXI0h1MD2nDlVzLYYvpOde8qlNktHS9SvZw8QZLgtgAgTunw8xhovXhRfAH8GberkVcBUEsyKFp+U9iPWfQi4CJ2snKYk78
X-MS-Exchange-AntiSpam-MessageData: d2/b6EoSrF/kLaPhqH19ZtUMgXG5dQPeJmRuc/P7/7SDcTrbXTGuPKgRPMH2U7ix31FmpYfr/IaKzTpZp+3jBUhdwChfMaoeHER99TphHoXcEAuEV6OMyFhnQZOt3/xrifJquSjdzqb8K2fwxho9mw==
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a3ceceb-db80-4fb3-f400-08d7b6bb12b1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2020 10:44:48.9323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HpHTaIlW64tTPvySDdrgJHIRU03Oc7y1NGOFdNyb5gVyXkby3V3iqy/X+HY8y+8kv1HUTqatySRkWfKUuFizXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4270
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

RnJvbTogSsOpcsO0bWUgUG91aWxsZXIgPGplcm9tZS5wb3VpbGxlckBzaWxhYnMuY29tPgoKc2Rp
b19zaW5nbGVfaXJxX3NldCgpIHdhcyBpbmRlbnRlZCB3aXRoIGEgbWl4IG9mIHRhYnMgYW5kIHNw
YWNlcy4KClNpZ25lZC1vZmYtYnk6IErDqXLDtG1lIFBvdWlsbGVyIDxqZXJvbWUucG91aWxsZXJA
c2lsYWJzLmNvbT4KLS0tCiBkcml2ZXJzL21tYy9jb3JlL3NkaW9faXJxLmMgfCAxMiArKysrKyst
LS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvY29yZS9zZGlvX2lycS5jIGIvZHJpdmVycy9tbWMvY29y
ZS9zZGlvX2lycS5jCmluZGV4IDkwMDg3MTA3M2JkNy4uZmFlMjVmYzY1Yjk1IDEwMDY0NAotLS0g
YS9kcml2ZXJzL21tYy9jb3JlL3NkaW9faXJxLmMKKysrIGIvZHJpdmVycy9tbWMvY29yZS9zZGlv
X2lycS5jCkBAIC0yNzgsMTIgKzI3OCwxMiBAQCBzdGF0aWMgdm9pZCBzZGlvX3NpbmdsZV9pcnFf
c2V0KHN0cnVjdCBtbWNfY2FyZCAqY2FyZCkKIAlpZiAoKGNhcmQtPmhvc3QtPmNhcHMgJiBNTUNf
Q0FQX1NESU9fSVJRKSAmJgogCSAgICBjYXJkLT5ob3N0LT5zZGlvX2lycXMgPT0gMSkKIAkJZm9y
IChpID0gMDsgaSA8IGNhcmQtPnNkaW9fZnVuY3M7IGkrKykgewotCQkgICAgICAgZnVuYyA9IGNh
cmQtPnNkaW9fZnVuY1tpXTsKLQkJICAgICAgIGlmIChmdW5jICYmIGZ1bmMtPmlycV9oYW5kbGVy
KSB7Ci0JCQkgICAgICAgY2FyZC0+c2Rpb19zaW5nbGVfaXJxID0gZnVuYzsKLQkJCSAgICAgICBi
cmVhazsKLQkJICAgICAgIH0KLQkgICAgICAgfQorCQkJZnVuYyA9IGNhcmQtPnNkaW9fZnVuY1tp
XTsKKwkJCWlmIChmdW5jICYmIGZ1bmMtPmlycV9oYW5kbGVyKSB7CisJCQkJY2FyZC0+c2Rpb19z
aW5nbGVfaXJxID0gZnVuYzsKKwkJCQlicmVhazsKKwkJCX0KKwkJfQogfQogCiAvKioKLS0gCjIu
MjUuMAoK
