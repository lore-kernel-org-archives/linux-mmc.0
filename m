Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C66C433E0
	for <linux-mmc@archiver.kernel.org>; Tue, 29 Dec 2020 08:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5FF2207B8
	for <linux-mmc@archiver.kernel.org>; Tue, 29 Dec 2020 08:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725866AbgL2IrC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 29 Dec 2020 03:47:02 -0500
Received: from mail-bn8nam12on2078.outbound.protection.outlook.com ([40.107.237.78]:12224
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725964AbgL2IrB (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 29 Dec 2020 03:47:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LEXPPrcFXALFp474mLA5r0pjpPbIjQKfv6VAbuOzU6H9F4oU3SabUbuCDIHomraFIK0G/DWNTpLKymVqIlT5+wpA/nZh7fm+BpgSHNyCq/qa+RulYs4FFG/Z391tDwKbvRFqslu32+e0FaCgnLkkuAmuQiPOMMJ9nHTksWDgTQuNlfJDrrVtLtXKakx0eLPNPkskCbNLOqtPe32jAdkkWScC2IJGm+sFYJC2n+hpyBNYZY0/u8D51gdXe4nqibHyOCmKRifEF9WdUAlJJGc/rdwHfAxCcWMmemKz1ntWQnLnjcX+IbPPCBNzq6mvTTAvoAwCrpGSUUhnqvgV0Q/7PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QscC6W/8f7utfoQwqB80oQshRO4b2hmqg8S7jDp+sOM=;
 b=K4GBb4Is3/1zV1N6u9hbhu+2bBarM/ZdKTDqaEnMfN3f/gwV03tZPXp2PF5GhsLa5mCp4/SNn+vX7UW2Al5T3YPhF+lunWlXHPEdQJW137GslG6LQgJc9j6pS8d6q0IyewfPBy9GeQ4xO0JI+QB8XEqHd5QRdgTqLzgpRW0upOJ70oSLjyIBtrbcU1A8HpGkhFeLVZiAY013pe4jRWka49hceBzX9ValIEaRfwfsLLs27Cgfxq+G7HJ4x3Xfa3+5wO1a/FC/kl95YyrGfx637oHehFks4n4BCtDL7X74w9PDec6Bvu1bAw9T9dPdoGdGtHQzOECDtlf91wBGh8Keeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QscC6W/8f7utfoQwqB80oQshRO4b2hmqg8S7jDp+sOM=;
 b=DYGC0dNDuUHA4kmts+BzhTNSJKqqEcoUaD0WWl6TL9L5boSAzwcSdSclQ1ChWYcr2siRVvDJ6otQeQiUvPOJrv1tpk2jWyIwzGeTBCuvF5wdMjDdl1v63YYeF2Fp0Hzh20KjF4iEHh+nal5XHx67Wj33Jnc3sdrdujWRv+hjAS4=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=synaptics.com;
Received: from BN8PR03MB4724.namprd03.prod.outlook.com (2603:10b6:408:96::21)
 by BN8PR03MB4819.namprd03.prod.outlook.com (2603:10b6:408:97::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27; Tue, 29 Dec
 2020 08:46:11 +0000
Received: from BN8PR03MB4724.namprd03.prod.outlook.com
 ([fe80::e192:4c65:5936:1fb4]) by BN8PR03MB4724.namprd03.prod.outlook.com
 ([fe80::e192:4c65:5936:1fb4%5]) with mapi id 15.20.3700.031; Tue, 29 Dec 2020
 08:46:10 +0000
Date:   Tue, 29 Dec 2020 16:46:02 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyat@google.com>
Subject: [RFC] how to support ADMA3 and emmc CQ and inline encryption at the
 same time
Message-ID: <20201229164602.2dd49d28@xhacker.debian>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: SJ0PR13CA0235.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::30) To BN8PR03MB4724.namprd03.prod.outlook.com
 (2603:10b6:408:96::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by SJ0PR13CA0235.namprd13.prod.outlook.com (2603:10b6:a03:2c1::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.12 via Frontend Transport; Tue, 29 Dec 2020 08:46:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd29683b-84ad-4970-e1a7-08d8abd63131
X-MS-TrafficTypeDiagnostic: BN8PR03MB4819:
X-Microsoft-Antispam-PRVS: <BN8PR03MB4819420ABF0D5DFCB65B95B6EDD80@BN8PR03MB4819.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KvdgVc+K/rX8Tlf6IiZIolrKZIRw2A4L9MMqG/oGEwikWu8OtWwEkimAjMr3hbtMQiVWTGuk87Z8Clmh1wAtSwkKBTCy94iI9HwW3AYCHOJcI5EgBoEVkHf41XGegVwKuFzNyTzQycHiB9unqDqyKZevBTyB3RPG5Vt+y/d/uXvdD1/qgLH+luu50h2oOHM1m++s/5mc3Y+hgO7Ixv0p+6XVL9IhTbsXx1ttIebNHdqPo85WZKon+alm0T/4i/J7GABMWVtiV0T7Davf0KxTPjCIywmMHZSIr+o9rJylixCq1TZALfZEiP1fulKtvHfi2zAq6DnpUd+uI1h4oI2B9EGzDsZXB7CLwO73cHtNIf0I3Oirv9vLGjTfuPEz70uuRwgJU6D8JyeIHTQxKS+t029Evnpi1aZRRJoB3rY1SFiZY9PUt9Xw1hCrT9vdmALVOD3YsS+Y0Ib+jubrf1Xgwg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR03MB4724.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(366004)(136003)(396003)(9686003)(66946007)(6666004)(7696005)(316002)(52116002)(1076003)(26005)(8936002)(8676002)(6506007)(110136005)(83380400001)(5660300002)(2906002)(16526019)(186003)(66476007)(966005)(66556008)(956004)(4744005)(478600001)(55016002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?y5yaHgJgnu+GG5TQILc1aZWoaxh0rS3zH0TDVVr4zJCpSWUfR9L+oWzgS3vm?=
 =?us-ascii?Q?GU9E1g8iepXeCXWHnIv2vOCF8NMR/0Ju4T+zySW0USG7SC2BMUf8a/cGoP8u?=
 =?us-ascii?Q?NU4GX70vomTqlzjYBulxJs4rrsmUqXUux5VBzNhPep+F98ammwqM6CcgHBZy?=
 =?us-ascii?Q?2rDPfsO2nLWkSwixlkaOFmNbfU/SzoNsuO+XBlyire9qQGHkSjRqJVNklNih?=
 =?us-ascii?Q?/hz7iw8/npC6YwG4/49ktjJHVHFeRDrFgL+Olis26gN50sPAYlJn5g2gjEUo?=
 =?us-ascii?Q?Gbh38aP+yCFanWSbDDJiUKdfh1A3veQFc5SVcbSFFhT/B3HYy0F6139vq0nh?=
 =?us-ascii?Q?K7DS3KCg/9K/42vFjQa9H7Xz8NI/+160XVqWh3r0qo0wIRiVCkXHgQS81En+?=
 =?us-ascii?Q?ea5ao0bzus/Oy8XsqEgtu9goNqXfTeqXklXTEPupAvxYwLIiiXITpqMl6aAr?=
 =?us-ascii?Q?Or/S5PgNM6kJml1+hBX+jvB+JcUGofvMI37hOL/rnwh/l3ss3GLAHlIsyTdQ?=
 =?us-ascii?Q?FaWOC2rEMgMOPr2DYMcI8PPYFlo6pBwUyMNRjw8DaDgxN6QJe390UxPVD16h?=
 =?us-ascii?Q?EEgw4ZjyHh4RAQu+AfapAfSQ9EZoN7U/rXghtAP2+3MFCm/thHWWaycc+fOY?=
 =?us-ascii?Q?3U9LfKrPHV9llGOGGrcfOqRhnEiEVXPjxQh3Z6zHzYxY0pyIPIXTQ0NzIXuT?=
 =?us-ascii?Q?cfHB6CQ+evLHXXLsLWmJh+Ss6iFJeUMcaWMAAOLbbQCg7pvM03SSsmGsBut8?=
 =?us-ascii?Q?oKiOy/BEqI0wqrV22EI4yDUAV6ggcpyFHofOTYt4h71GhzO2HMQvA9HfVmWn?=
 =?us-ascii?Q?EGWLBhgMuYth5Gvva1QCK/HR45aqBsyuDRtGWBMeQI18uaswsBN2ab03vSvA?=
 =?us-ascii?Q?cP5By67JarUctrVeGSeQfJCc1z9nI5RTq4oYjRabMl4QR3iz+YReWZIcT2Pn?=
 =?us-ascii?Q?0CNw1ahYmzSJ/TmSC+L0uuBrB+/UJfICFWd22LCHiXQkaHkVtX4iqG3queLN?=
 =?us-ascii?Q?QumV?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-AuthSource: BN8PR03MB4724.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2020 08:46:10.9109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-Network-Message-Id: dd29683b-84ad-4970-e1a7-08d8abd63131
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oKafEA6xRHCIy3MLPGZ6s4ii3Y7JGYNMIf6eVn9OYk/2HQGH4gOKhlvR8aq5CKMfud0sicQ/b84LvnCTnrWRyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB4819
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

Two patch series:

*emmc inline encryption
Recently Eric sent out emmc inline encryption patches, per my understanding
the emmc inline encryption based on CQ interface:cqhci.

*ADMA3 support
Baolin send out ADMA3 support patches: https://lkml.org/lkml/2020/4/26/125
which makes use of the ADMA3 transfer in mmc software queue.

Per my understanding, ADMA3 is focusing on the host side while the emmc CQ
focuses on emmc card side, they don't conflict with each other. But current
mmc_blk_cqe_issue_rw_rq() goes through either hsq or cqe code path but not both.

So how can ADMA3 and CQE be used at the same time?

Thanks in advance

