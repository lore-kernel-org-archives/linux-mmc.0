Return-Path: <SRS0=+wZv=4J=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F31FC35656
	for <linux-mmc@archiver.kernel.org>; Fri, 21 Feb 2020 16:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD6C224650
	for <linux-mmc@archiver.kernel.org>; Fri, 21 Feb 2020 16:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=silabs.onmicrosoft.com header.i=@silabs.onmicrosoft.com header.b="GM+69Gs8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgBUQcG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 21 Feb 2020 11:32:06 -0500
Received: from mail-dm6nam12on2046.outbound.protection.outlook.com ([40.107.243.46]:6208
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726710AbgBUQcG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 21 Feb 2020 11:32:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bUFUoKX5BXvfrTilKzmHC7UvJ/osY0FNtorEbhAODDIUqfC0L2f5opR1fcQ0Dg/mWlNOUZRK6SgLsxppPMgjsNvP5EzBj1oRcLR/gG49KcHfJu2sMuis8SDYXzlBHyU3sF+veknT3++HER/Et+zD/UkRz9Nh7iOjz/Xfr4XsoyXMSOYyhQIzVUBOEwnkZCU8895hp3CO3457zhWzjktOjug7GOWqd8TCPqbq/OzbawiV36IyUUywkbhJjPoCg2W0g41VvLG08Ir3zVdfaj/HDYjv5qZsHgMAbY3Tl9lJC3qjEdxI9BB9qxMiqniu7jVgKu2wAjrl7yK08na8dg2IcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1d7SU74WxrWjz+LQ+cB0iMwuNx0+QLq05WnJof3gRI=;
 b=TRT3y3kRl22hxovnFUn03+3qrdhCJUVwyoPllOgZRGuMehfa90MI85YPdMvhDMfpW0j/9syXX05U9PFH0m7iAtgd4ONnvVL7U7Gj1i/m1kxqO/MLTqAMMseTfamwKxvgm/6S+SK2/seX+HW+twZiaFNefu2SzMgjG+9mhbAaNI7CtXvk9EDtyB4KlOwUhWHD51gDyc1NYQZp2q5WdzhQaCeAC3UywdmvAfICe3SrQXjo3jq2vDpHrpfQZS4DIkYs8dyD1IhOU1RKuvGhcRpueyJ3lhG7q58sa6jtyhZnifhdO5kGVWZlVDgN8R7NOAtNq5quFb2SovLe/ynFChIviw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1d7SU74WxrWjz+LQ+cB0iMwuNx0+QLq05WnJof3gRI=;
 b=GM+69Gs8zbYLsJvAsp0q6evNV65k0aRimMjIgptn1hyvR4sKN9pzDnFbqRg/vWLEmI5FuWPcccJxiH/+VYVQc5oMA96n/q7Dh+Yf6m9iOloe1dcX7ueQr3YXS1+t76mNCQqjpGEi5XlTWybBvROIXwhT4ffFY/MC2sHNgwfpQ0g=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jerome.Pouiller@silabs.com; 
Received: from MN2PR11MB4063.namprd11.prod.outlook.com (2603:10b6:208:13f::22)
 by MN2PR11MB4351.namprd11.prod.outlook.com (2603:10b6:208:193::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.17; Fri, 21 Feb
 2020 16:32:03 +0000
Received: from MN2PR11MB4063.namprd11.prod.outlook.com
 ([fe80::ade4:5702:1c8b:a2b3]) by MN2PR11MB4063.namprd11.prod.outlook.com
 ([fe80::ade4:5702:1c8b:a2b3%7]) with mapi id 15.20.2729.033; Fri, 21 Feb 2020
 16:32:02 +0000
From:   Jerome Pouiller <Jerome.Pouiller@silabs.com>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>
Subject: [PATCH v2] mmc: core: Fix indentation
Date:   Fri, 21 Feb 2020 17:31:47 +0100
Message-Id: <20200221163147.608677-1-Jerome.Pouiller@silabs.com>
X-Mailer: git-send-email 2.25.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-ClientProxiedBy: PR0P264CA0047.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1::35) To MN2PR11MB4063.namprd11.prod.outlook.com
 (2603:10b6:208:13f::22)
MIME-Version: 1.0
Received: from pc-42.silabs.com (37.71.187.125) by PR0P264CA0047.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend Transport; Fri, 21 Feb 2020 16:32:01 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [37.71.187.125]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f92253c-5bc6-4fbc-4f10-08d7b6eb94a4
X-MS-TrafficTypeDiagnostic: MN2PR11MB4351:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR11MB435127A53537880437C8724693120@MN2PR11MB4351.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-Forefront-PRVS: 0320B28BE1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(366004)(376002)(396003)(346002)(39850400004)(199004)(189003)(66946007)(86362001)(8936002)(4326008)(478600001)(81166006)(1076003)(81156014)(66556008)(16526019)(2906002)(107886003)(66476007)(186003)(26005)(8676002)(6916009)(316002)(956004)(5660300002)(6666004)(36756003)(6486002)(2616005)(52116002)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4351;H:MN2PR11MB4063.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: silabs.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 95MnRCPAlpYxBD6onASDlpIq9/++OsVROe13KPIstYCHORsRVkynsuBeoQ14ntlOiQOxQN3McVsZbmerE2Ks+DHCzVp2+yhyeXQh/oNvhNVz0eI71fYXl7mCLwqKmctCCh8nuramBB9/AkIwbTKU/d/x7EK7v7COkJhBNx5usU3luKTCLDPp2d8ESTWntxmsq/BpCyhfcY0PB16M9ARywMz7gBY5ebmKj9IJpPxd3Vu8F9fc/gUGcpfNL+C/+gI0hReH8hiPnEq3l84m4EPvBR/LA6YjCijqoSFU1nXfp4GeQ5i6tewBvKJ4tp3jr4aMeJokUFYOz/UkD+oRHvLbDYnlwj6RTuBZ65TMZcxSVnZX1GFmp4wonxBtZ7JXp9QIY6GOS/I2GRV4/qs7Z5jfibtf+mTGlKPqQ0CHVjJQxNvfMbrXFP3Bb4FFEtVA5/G1
X-MS-Exchange-AntiSpam-MessageData: 52QnGQHyqBTyJucdbCBxNVObq6tizMoIT6e9VDZ7w9F51+hsvTQ9dJcoSqsl9600/Smbva/xTMAqkw/n9A1TNoWO3quaSztMFUArN/SbGk1xvdHR+lR+9gA+Lazhuf29awVyyM2To94K7oA/ae1/Mg==
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f92253c-5bc6-4fbc-4f10-08d7b6eb94a4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2020 16:32:02.6788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0C1Gn6OZd8wZun2H8VB2stglc7x8QYfX/imb9AXZ8lNTbXqZPbpeZdc4NlB70DWrO/12vSR5ipX+0TPxwoOPxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4351
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

RnJvbTogSsOpcsO0bWUgUG91aWxsZXIgPGplcm9tZS5wb3VpbGxlckBzaWxhYnMuY29tPgoKc2Rp
b19zaW5nbGVfaXJxX3NldCgpIHdhcyBpbmRlbnRlZCB3aXRoIGEgbWl4IG9mIHRhYnMgYW5kIHNw
YWNlcy4KClNpZ25lZC1vZmYtYnk6IErDqXLDtG1lIFBvdWlsbGVyIDxqZXJvbWUucG91aWxsZXJA
c2lsYWJzLmNvbT4KLS0tCnYyOgogIC0gQWxzbyBhZGQgYnJhY2VzIGFyb3VuZiBmb3IgbG9vcCAo
c3VnZ2VzdGVkIGJ5IEpvZSkKCiBkcml2ZXJzL21tYy9jb3JlL3NkaW9faXJxLmMgfCAxNSArKysr
KysrKy0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25z
KC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvY29yZS9zZGlvX2lycS5jIGIvZHJpdmVycy9t
bWMvY29yZS9zZGlvX2lycS5jCmluZGV4IDkwMDg3MTA3M2JkNy4uM2ZmZTRmZjQ5YWE3IDEwMDY0
NAotLS0gYS9kcml2ZXJzL21tYy9jb3JlL3NkaW9faXJxLmMKKysrIGIvZHJpdmVycy9tbWMvY29y
ZS9zZGlvX2lycS5jCkBAIC0yNzYsMTQgKzI3NiwxNSBAQCBzdGF0aWMgdm9pZCBzZGlvX3Npbmds
ZV9pcnFfc2V0KHN0cnVjdCBtbWNfY2FyZCAqY2FyZCkKIAogCWNhcmQtPnNkaW9fc2luZ2xlX2ly
cSA9IE5VTEw7CiAJaWYgKChjYXJkLT5ob3N0LT5jYXBzICYgTU1DX0NBUF9TRElPX0lSUSkgJiYK
LQkgICAgY2FyZC0+aG9zdC0+c2Rpb19pcnFzID09IDEpCisJICAgIGNhcmQtPmhvc3QtPnNkaW9f
aXJxcyA9PSAxKSB7CiAJCWZvciAoaSA9IDA7IGkgPCBjYXJkLT5zZGlvX2Z1bmNzOyBpKyspIHsK
LQkJICAgICAgIGZ1bmMgPSBjYXJkLT5zZGlvX2Z1bmNbaV07Ci0JCSAgICAgICBpZiAoZnVuYyAm
JiBmdW5jLT5pcnFfaGFuZGxlcikgewotCQkJICAgICAgIGNhcmQtPnNkaW9fc2luZ2xlX2lycSA9
IGZ1bmM7Ci0JCQkgICAgICAgYnJlYWs7Ci0JCSAgICAgICB9Ci0JICAgICAgIH0KKwkJCWZ1bmMg
PSBjYXJkLT5zZGlvX2Z1bmNbaV07CisJCQlpZiAoZnVuYyAmJiBmdW5jLT5pcnFfaGFuZGxlcikg
eworCQkJCWNhcmQtPnNkaW9fc2luZ2xlX2lycSA9IGZ1bmM7CisJCQkJYnJlYWs7CisJCQl9CisJ
CX0KKwl9CiB9CiAKIC8qKgotLSAKMi4yNS4xCgo=
