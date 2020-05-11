Return-Path: <SRS0=e9Nt=6Z=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC49C47255
	for <linux-mmc@archiver.kernel.org>; Mon, 11 May 2020 16:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D06372070B
	for <linux-mmc@archiver.kernel.org>; Mon, 11 May 2020 16:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=silabs.onmicrosoft.com header.i=@silabs.onmicrosoft.com header.b="VJxPV6JO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730513AbgEKQTW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 11 May 2020 12:19:22 -0400
Received: from mail-dm6nam10on2080.outbound.protection.outlook.com ([40.107.93.80]:23370
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729956AbgEKQTV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 11 May 2020 12:19:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b6bkQ+s2DxMbC0y50tndu6JP7RDYdgDuptxkZzNOigun1zDOldteNPy+LqsbfsHY621JbtIgzY3Rtip+Xa0oNC9n3uJvSfuPoCclANXHe2dDcMoDvpwDt5HwzMmbU7GK4O7LQsrZLHmCEANaZQhaakfIRM+MbohyebOiWG110R4qWH8X9zZTvLoPvIm/cj8nN5C+TnE2kVfgZwz5R2CydBe6HxCLCyGqp4Z4iDBJXHFztsu/v3nfVUh0Gp81lGQBXvhn0v+wLiWqbOXogSkDx7TcKcTPRpNbtRocBwvE0tQayi885TwSvdLJZBdCnTc3n8rEbrnJz06DzlM3Og07oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aCM1XWKiFVxgWMRdC/84cFoAGCyTx5IZNjgOm+WW7jA=;
 b=aRikk+1g1dlo0cnQbEAad18RXDCFN2o7ZyAPI0k7o7tMCWP6vGFSlpfeMsrKkR9K+fxAdzuylhh3dff21L1787qR/V9kmLoB87oLoZKOZsxdDaRdhT0pT88KafEJAiqKJ1Ytu1MVIJi8nh8+BCU6B7btH/vLO4tv9lhbSF1pNgQJOMWWbMCH0MqbZhhm/qiWSNnq1pjtifz2GHjcYpT2XWGxoHeLHI5ASjMRGr/Nlsa42WWrjF+YLfd9YFYvzsdsPfaNSE4UMgEtrtsGMc5VTBT5XJJmYnStsuGYwSf1UHc93CWVSj8vUMtAOio/wg3FwqoNkIhv26R2/S1dtqE8Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aCM1XWKiFVxgWMRdC/84cFoAGCyTx5IZNjgOm+WW7jA=;
 b=VJxPV6JOE4I7HX5pOF+bDJvG5Xvb/qNyZqrqdVSFZzFnOrSQw0uAPBq3CAxJuEIPft4XGkVUzjVD3BiAhF8NcKSKKKRXS5ihKvO1zzmofve84selEKt6lw1+4XubmATBeBzBg+9EmtV8W3CiwPIvGQ+H4YgmefQKC0xwnBC1t74=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=silabs.com;
Received: from MWHPR11MB1775.namprd11.prod.outlook.com (2603:10b6:300:10e::14)
 by MWHPR11MB1471.namprd11.prod.outlook.com (2603:10b6:301:b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28; Mon, 11 May
 2020 16:19:19 +0000
Received: from MWHPR11MB1775.namprd11.prod.outlook.com
 ([fe80::e055:3e6d:ff4:56da]) by MWHPR11MB1775.namprd11.prod.outlook.com
 ([fe80::e055:3e6d:ff4:56da%5]) with mapi id 15.20.2979.033; Mon, 11 May 2020
 16:19:19 +0000
From:   Jerome Pouiller <Jerome.Pouiller@silabs.com>
To:     linux-mmc@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>
Subject: [PATCH] mmc: fix compilation of user API
Date:   Mon, 11 May 2020 18:19:02 +0200
Message-Id: <20200511161902.191405-1-Jerome.Pouiller@silabs.com>
X-Mailer: git-send-email 2.26.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-ClientProxiedBy: SN1PR12CA0113.namprd12.prod.outlook.com
 (2603:10b6:802:21::48) To MWHPR11MB1775.namprd11.prod.outlook.com
 (2603:10b6:300:10e::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pc-42.silabs.com (82.67.86.106) by SN1PR12CA0113.namprd12.prod.outlook.com (2603:10b6:802:21::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28 via Frontend Transport; Mon, 11 May 2020 16:19:17 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [82.67.86.106]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f2f75c0-99d0-406b-55c4-08d7f5c70ea4
X-MS-TrafficTypeDiagnostic: MWHPR11MB1471:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR11MB14719A861AD7CA2F1109712493A10@MWHPR11MB1471.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-Forefront-PRVS: 04004D94E2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p5PAQFvMz99xg5498+o+0KGdbLQx8fFbDKrE+WBvckdQf9sJm8ogIbOTu0LFfCcOtTYpHG6rY/wrRq/o6sWLeyfyCnzZVENSTQ6BI71yriO/kwb/dZQ7/rfaz5xHMs0XsXG4NcSSDwHQDJ7pVXUQIDzMrAZyDNfaD8e6MCxl16Mjp0Uf92YNmgFQc5Kb0ld2/iTlO+hufepPICxJ1E9VZ8NR52dN9YjBR5Wsrq+QJ7tR/IGmlNpZUp9ZLNZ6vWvh7MbSVIxyaLhY/phASZEbREAHhhTY+5zypNRnR29vRSjWRTjYAIyla7ZFocHjjBYrz33baPZX4wei8yRGCCddGLPQaquetaZ+qX/bQOxvSRsrZo0RX3v11PpGLpK+DH1cTW66BlbwR9ZQccTUpkPsKaBecllQcEeYQhEMuV/SUSROYQnOh0SxiRV0iv9ClBmf1ohPh3d1b/hcOV9ZJ7TbEqPEz0R+Er456qUoCr1C1+hukI31nuY9ARFDgd1vnVPrP5N5gnqqvvXzo/hdsuklNQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1775.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(376002)(136003)(366004)(396003)(39850400004)(33430700001)(2616005)(33440700001)(6916009)(956004)(6666004)(6486002)(7696005)(8676002)(107886003)(36756003)(316002)(54906003)(66476007)(66556008)(66946007)(52116002)(4326008)(26005)(186003)(2906002)(86362001)(4744005)(16526019)(478600001)(8936002)(1076003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: rof4FhJqPaf6UZTaQhGto7SZgigieKaKQ0GRXgZZBVuZRHzjVCnoTWOQPAr9gWnxt36vEUZQ2DKD5m4JIS9yB33mKX+9tk9ywcpuXZAGtjEyEdNWjwAmXiLM20cAM+nr+vtdnXFVPeELirzKkJN8PmrZ0QvuSc4+/BWTXGxILGAhpeBf4nLdBUVw64tUw+F5wnH7RolTnQF3RC13i/q8tjSRkJJbD77up873GGWSKvYadOd3yNfw4vPf26/SkT2jyPXKTn9uXXcBWASqFRfJKIGGthIn0a14CM2iWmYdifd1mF+NGKH5DR6ip4710yRZvJ6j5P3RM/SijuTsKyth/X2aKp63Q9keisi5WDm8pIkrQZxqvH2f8Tnn6T8/D3VN8ueUiAgFDIxQtZfOl6zbT2nvPUq649OpxXaLep/TxguZb1LGCpqekngsGP1fO7cvmTPG1Y1IcRRnWCkYiSdLLpQoMysvwxqCWK4RDGR6UsU=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f2f75c0-99d0-406b-55c4-08d7f5c70ea4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2020 16:19:19.1981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: epfn2ulYi4XwpwTHw2nJry0Vux+hDSZXKLuNSMLuwy/sITLuiwyGvOHyA9747pHTo87mi1Xf/ChNeJ3FnJ+I+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1471
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

RnJvbTogSsOpcsO0bWUgUG91aWxsZXIgPGplcm9tZS5wb3VpbGxlckBzaWxhYnMuY29tPgoKVGhl
IGRlZmluaXRpb25zIG9mIE1NQ19JT0NfQ01EICBhbmQgb2YgTU1DX0lPQ19NVUxUSV9DTUQgcmVs
eSBvbgpNTUNfQkxPQ0tfTUFKT1I6CgogICAgI2RlZmluZSBNTUNfSU9DX0NNRCAgICAgICBfSU9X
UihNTUNfQkxPQ0tfTUFKT1IsIDAsIHN0cnVjdCBtbWNfaW9jX2NtZCkKICAgICNkZWZpbmUgTU1D
X0lPQ19NVUxUSV9DTUQgX0lPV1IoTU1DX0JMT0NLX01BSk9SLCAxLCBzdHJ1Y3QgbW1jX2lvY19t
dWx0aV9jbWQpCgpIb3dldmVyLCBNTUNfQkxPQ0tfTUFKT1IgaXMgZGVmaW5lZCBpbiBsaW51eC9t
YWpvci5oIGFuZApsaW51eC9tbWMvaW9jdGwuaCBkaWQgbm90IGluY2x1ZGUgaXQuCgpTaWduZWQt
b2ZmLWJ5OiBKw6lyw7RtZSBQb3VpbGxlciA8amVyb21lLnBvdWlsbGVyQHNpbGFicy5jb20+Ci0t
LQogaW5jbHVkZS91YXBpL2xpbnV4L21tYy9pb2N0bC5oIHwgMSArCiAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkvbGludXgvbW1jL2lvY3Rs
LmggYi9pbmNsdWRlL3VhcGkvbGludXgvbW1jL2lvY3RsLmgKaW5kZXggMDBjMDgxMjBmM2JhLi4y
N2EzOTg0N2Q1NWMgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvdWFwaS9saW51eC9tbWMvaW9jdGwuaAor
KysgYi9pbmNsdWRlL3VhcGkvbGludXgvbW1jL2lvY3RsLmgKQEAgLTMsNiArMyw3IEBACiAjZGVm
aW5lIExJTlVYX01NQ19JT0NUTF9ICiAKICNpbmNsdWRlIDxsaW51eC90eXBlcy5oPgorI2luY2x1
ZGUgPGxpbnV4L21ham9yLmg+CiAKIHN0cnVjdCBtbWNfaW9jX2NtZCB7CiAJLyoKLS0gCjIuMjYu
MgoK
