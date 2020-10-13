Return-Path: <SRS0=f1/V=DU=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5800C433E7
	for <linux-mmc@archiver.kernel.org>; Tue, 13 Oct 2020 11:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 804C120659
	for <linux-mmc@archiver.kernel.org>; Tue, 13 Oct 2020 11:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="XlYZyCMR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730667AbgJMLJF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 13 Oct 2020 07:09:05 -0400
Received: from mail-dm6nam11on2071.outbound.protection.outlook.com ([40.107.223.71]:52320
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730454AbgJMLJF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 13 Oct 2020 07:09:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CFv/uCSZXYMfRkxQCLQPrH9R3ic534BC+cRz859oML5FRp3AavImmKLPFgwUUf9sUzSwbgQ9UusjAvSAdq5u5ps3MIONiySJRC2GM0jFXcj9D9qMuepi0/eB3erBUy2l+g6EICt7mmq7w2ftzDJhj7dqQc0T02cix0ym6L/ySMQQ7rn2j0Ru+HuccIdX13VemTOGSapm00kITDIsIEWExRtrvJh1mBxj3HuYdBsuKWJX+nXiEJcyWTjx1Khl/HFzrwo6Yy2A/lVK4GTdWBMBkbDArRzZnnreMHHIe3xXOF5tXH8n9ePIC/agIwXW/qE+UsTCX83mJzHRT2IonBZ/tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rknFU0zIBb7Y8VQoBVnMwc0LuMAsbhqBgKIE1uTzxx4=;
 b=EK0eEa4r16Abe1nfibwaTXuxChey44rGpVFG7SdVjHvwSC/wge0+UXdUSiByKjfbtU1adxZ9TbqBlGOo5WGSGAt7bFuR/zKkPaP6ASbtI8tArHgXPqz15GH57ISinwdrvUc/0xKEtAHpvSPvnqao9B0a5DRJ7pjKtWiTBxB7+GBO8qTF1Wd8nbp4W77GCYwnJ757x8xvT4LXgttiljQj/gBIgiYK4Hapzyzhw9FH+65UzVOBgkrNZwkVRDVMk9VbvFsUoMHRUmq3soV5Q1nl07HMgBoLF7Ek/0/KuTjxqTCK7wQp/2doxa/VGuI6Q0YFt7aeNCB8W4lWX7FC+76qAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rknFU0zIBb7Y8VQoBVnMwc0LuMAsbhqBgKIE1uTzxx4=;
 b=XlYZyCMRZOM1nQJ/6HYZOXIkxd4v2YV82nUhikKKOs9CSuVZs3I9dfwro9kCqHV1+XzUDwS0iHvQEStXxUAD0SMr3dH3mwgLtTaHgIcvcrIMSfT+m0pa1fxtZs0aD97Ag+zKvpxR1xfJ2g64+NDLolawHCwLF+lw1RaS8LSIDg4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=synaptics.com;
Received: from DM6PR03MB4555.namprd03.prod.outlook.com (2603:10b6:5:102::17)
 by DM5PR03MB2906.namprd03.prod.outlook.com (2603:10b6:3:11c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23; Tue, 13 Oct
 2020 11:09:03 +0000
Received: from DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38]) by DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38%7]) with mapi id 15.20.3477.020; Tue, 13 Oct 2020
 11:09:03 +0000
Date:   Tue, 13 Oct 2020 19:08:50 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     linux-mmc@vger.kernel.org
Subject: eMMC performance regression caused by 427b6514d0953bf
Message-ID: <20201013190851.715df9ad@xhacker.debian>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [192.147.44.15]
X-ClientProxiedBy: BY5PR04CA0022.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::32) To DM6PR03MB4555.namprd03.prod.outlook.com
 (2603:10b6:5:102::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.15) by BY5PR04CA0022.namprd04.prod.outlook.com (2603:10b6:a03:1d0::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20 via Frontend Transport; Tue, 13 Oct 2020 11:09:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab0ac925-0529-4351-3564-08d86f686475
X-MS-TrafficTypeDiagnostic: DM5PR03MB2906:
X-Microsoft-Antispam-PRVS: <DM5PR03MB2906F988A05D093FACF7E1A3ED040@DM5PR03MB2906.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qoW4Qdo9P9vtD3vS60dt9fbkHXhdRgnE8ZHw7dHbm8g7D5LUTtjUEJrbLPQqJF+MxwPuU9ZVmY/6ZAMr/vjrqE8O2CYJsxjGNNJAsK1MBCDrtSVjxTbW8OJa68T9wNs0jmmNn4/peYq8QxoR2HgJTAJie/fnRU9lrf/P9VZtc6b+IKadIAc8mqFtkw+HcGiEcRWdB1U6p9Zij/ZZSNS3x4DdVatRxI3TwXceXd7+H/QWtvdePxpjVkBjWSjJnNZMKY9qJSsxvGawJ/ViEUSHgThrIkORNr+IiZoRO21PpWM+u/l3dwZAHCeswBgv3ZEq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4555.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(136003)(39860400002)(396003)(346002)(26005)(186003)(16526019)(55016002)(6666004)(8676002)(956004)(6916009)(9686003)(86362001)(8936002)(2906002)(5660300002)(1076003)(478600001)(66946007)(316002)(52116002)(7696005)(6506007)(66556008)(66476007)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 5Lq74lCMtxuQdUVS2xHyp8x3PLGzsJp3dFbMjkeg/RsGKieltjgeTMSRDbGDsuU48DtIYgjbNJd8tSNKoyIIxugwIr66+oVSNPuygI/pwF3TG3EMghQzS7yZ4+j2CyRpw76Gh9oiHvVqyf+dzU9EJxHDerPoP9lCAFXYVVhGWYPdx0HmGj3Z/lyIAYENyFbPlvE9UOfP/ct6yg9h3ZCNcLNY8Kk622mgmy656MHe4BycI1rP8t+3hhLBSXsxZq/LVkg5okFnS4jVAP3JZi/wB0TbbclUF5T2kBD2EuQfThFhMJz65w5t7OVvdusbOdnQEs9JzQbbAAtewL8RYT7iIQsCHa4ZgT4R+QYhE+4Xbq/FHh96nE/apWLzCaWHPn9LmEevFClrf1bYRtIbxwHGKmyjCCA6ExFdEIM0+J6luxIVEw8BKWIRXbqvSkb0UkC8qrewIKDDRNOWfkjygJ8QCe7RHt5oblInywrC+fuxwqXOVurs25I5pvRzT+s38s5LqF8yx1vstBQwOt3R3tRkv00Xr+j3uBmwOAX6WK084BJ0i8EfkV8MRQTl8XTt0HdUhTanfBH0lUDJOCYABPlsGPpf4XOCuI3/rSnGreGiwPPUaSZXwvM9FjR9npr1Pch17a5HNatZJ6aO+2ZUiABFpg==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab0ac925-0529-4351-3564-08d86f686475
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB4555.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2020 11:09:03.0767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mROnRb51FXcqJa/tJ+UTk6U7byFjhh9P0MS2MWVBj4al50rmwh9iDPgOh09BY7cnuF48dYjbP/5v8qH1D2syFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB2906
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

I found an emmc performance regression with below simple benchmark cmd:

dd if=3D/dev/mmcblk0 of=3D/dev/null bs=3D8192 count=3D100000

This regression has been bisected to commit
427b6514d0953bf (=E2=80=9Cmmc: sdhci: Add Auto CMD Auto Select support=E2=
=80=9D)

If I revert this commit, the performance is good now.

I=E2=80=99m not sure whether this is common issue or not.

Thanks
