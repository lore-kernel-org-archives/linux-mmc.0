Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 083D1C19F2A
	for <linux-mmc@archiver.kernel.org>; Sun,  7 Aug 2022 07:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbiHGHt5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 7 Aug 2022 03:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiHGHtz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 7 Aug 2022 03:49:55 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44478DF7D
        for <linux-mmc@vger.kernel.org>; Sun,  7 Aug 2022 00:49:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JvxVEOSZU8VlljEmycDGPjBnIAqnznrCnK+pInvgxGGvcK6urwCinc3GJh7mvoZ1FcpUXfCkZ14lTcc5NMqGdB1YnTCm487r6RsJ6Y5v+McvF3vqwGTNBKqK1gOeAmjzt+EsYN6qkc08bGdaldzaFV2n1ymOdEkY+7QYBjDtN8gPYTZIJNJktVnyBm51qH1ENeBUcFoY/aAVfwcyJoQnUItAEjalyaXT2sN8/3SYymRbCuy+yyn6qo4JXbV+uWoPyicx38/VMXWcnTzrNk99qDRBrqawy4wvEiMoCC1ngxUG7sKl1T/OGEyHON8TxdQABWWvUU/BZHFw1kWRo7x1VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UiTwHaUIosp/4SDlVznP2ZwYxC0o1rHb3YxUmx85A9s=;
 b=PkK3syqafyYZIXn8jcBgei8X7aGx/U84UqF/JA+iLxuF4mMwH8FG2xFb8lSRCh5fQTBRKe77PHEC4W4UpJHYIMuJ2PS05Npo8CPnKh8d1eMmyv/ILgteXdYg79dkbZCOtfEOamLQpOTOCCU4Ls5hrei4gmAxSKYP8eOxiKqtNURYnHVbM1nJx7G/MGFEjI+1jdi1xBBKHQMnNigijksMJ9ze1C/Y07pNS0n0tqLTfyPByzNkj6CQfigO0rB+WmzejvmnTrrveU0PiMsQeqXWdX5NR+1OljVbZ76ZbOE5TrHdH0qE6XG7q9cEjprjBPpkIWsXn6pJx+8UuNseM6JwPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.136.252.176) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=stryker.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=stryker.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stryker.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UiTwHaUIosp/4SDlVznP2ZwYxC0o1rHb3YxUmx85A9s=;
 b=Ubxffb27VvVAUllNIbKgGnd7L5Z+zlGIAjH+BB/+L/VBLsMmEMN1SCvqUztx4IeM/DEx1hTD0R+87VXE7SqvBrBszNykbXzH8zJjSr3KDvBL3AblsHubVD8MwlVD++stiAazUM0wjnmghER/NCqbJLxUcJMghrhGFVmvWgXGzM7zX7Mdv9QuraQcd1YGLwdWRxXCRQpyASNi533YCywkk18BIDD1eonKr0eOAUp6BJ476Q2lFM1SNeYi4KbtyBr2YDfS3xIbD2qYOPIpKK3xd0uqE7VXdTJxgcRjoOaD1EjA2IQbi/FEQLX+Blmv9Siaq+ZD9xgZ1anKozNIKa0RoQ==
Received: from DS7PR03CA0030.namprd03.prod.outlook.com (2603:10b6:5:3b8::35)
 by BL0PR01MB4996.prod.exchangelabs.com (2603:10b6:208:62::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.16; Sun, 7 Aug 2022 07:49:52 +0000
Received: from DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b8:cafe::5d) by DS7PR03CA0030.outlook.office365.com
 (2603:10b6:5:3b8::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17 via Frontend
 Transport; Sun, 7 Aug 2022 07:49:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.136.252.176)
 smtp.mailfrom=stryker.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=stryker.com;
Received-SPF: Pass (protection.outlook.com: domain of stryker.com designates
 64.136.252.176 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.136.252.176; helo=kzoex10b.strykercorp.com; pr=C
Received: from kzoex10b.strykercorp.com (64.136.252.176) by
 DM6NAM11FT034.mail.protection.outlook.com (10.13.173.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5504.14 via Frontend Transport; Sun, 7 Aug 2022 07:49:52 +0000
Received: from bldsmtp01.strykercorp.com (10.50.110.114) by
 kzoex10b.strykercorp.com (10.60.0.53) with Microsoft SMTP Server id
 14.3.498.0; Sun, 7 Aug 2022 03:49:52 -0400
Received: from bldwoapp11 ([192.168.131.10]) by bldsmtp01.strykercorp.com with
 Microsoft SMTPSVC(8.5.9600.16384);      Sun, 7 Aug 2022 01:49:50 -0600
MIME-Version: 1.0
From:   <noreply@stryker.com>
To:     <wos@stryker.com>
CC:     <linux-mmc@vger.kernel.org>
Date:   Sun, 7 Aug 2022 15:49:49 +0800
Subject: CRYPTOCURRENCY WILL MAKE YOU A MILLIONAIRE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Message-ID: <BLDSMTP01rXg5wlSe9F00129963@bldsmtp01.strykercorp.com>
X-OriginalArrivalTime: 07 Aug 2022 07:49:50.0169 (UTC) FILETIME=[45B02C90:01D8AA32]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7599dcc-07c4-4dc7-33e2-08da7849698a
X-MS-TrafficTypeDiagnostic: BL0PR01MB4996:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tV38Y1YTERHmOH/3bJVLnfKCeCP05DPyhuAcISmDfpBdVyZSsie5/L81wTLKVM2mxhn8c2NSM4QGvNO3v3YouDPC3A3qO7ebovHBQID8xLTQV9rGf3IsD8QN/V6aEXg/46Rfid3Kt2onBt0bJeXbuHdxQlmcHXsMn3J7D268VV+Sdd617V40uxNiEypwQes60zURR+X02ZAvu07nr+Dy0+RvxFnkO4uFqQchTCRZZBDpLPTfZ9cUt5puxG/8wWugBm6NOctxYErR5+6Kgn/oqWAb0kf3zx013F9wNlPid5I3xC+cufySBXJXhYBQ2gmfRtConNVeZXXVPXLImenoZu3W/g7QOocRvKjFvzmz0iCA24tdf0wlk+HCGZY9d/tRN6f87qBYM9zVaWerEgVYlT8dJT/dRYbl9CXoMN3lQBhbqtWakjdk+ufUo6UZcr3CGKO0o3O+poVMqnraC5rVdmLnZ9BiY0w4t055n9HS+I/3AGVq9gYWqV51s1gRBZwgrbqo9q4Leeg2GbFEBhKQ7/HjjAy+WiTs4AIzFO6xjapi6aertIO4K7jumeQhuixrY7M94ws5+5lQWW58HNz08qLurd2bLhedUzRTwSP0i8QMIHNUhpIvjLp4i26XAjgQ/skyDRvMKY6N37RXIc3lBPWK+RIdp3tW35ZXgaekz/sucS0up+HfK8Zbv7h/THWVAc8+WSL9a72eV72nL5JggvqTniuywEWchT29gQdBj+I3kicjNaG4kcOoLEESsx1QqxacXDIoLd2b3yX+pWABT4Su/r+pomnqsqafexFBL0RtnkEFGdEyiLOjWaLPV+gSIR+SXxMtRCkPnnlPipLIJiiMZ1OAumAtWqTbQnmGeIY=
X-Forefront-Antispam-Report: CIP:64.136.252.176;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:kzoex10b.strykercorp.com;PTR:ip176-252-136-64.static.ctstelecom.net;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(136003)(396003)(39860400002)(40470700004)(36840700001)(46966006)(41300700001)(86362001)(478600001)(2876002)(558084003)(70586007)(36860700001)(2906002)(40460700003)(40480700001)(82310400005)(966005)(82740400003)(356005)(9686003)(6862004)(8936002)(6636002)(81166007)(26005)(316002)(70206006)(336012)(186003)(47076005)(8676002)(4326008)(5660300002)(208233001);DIR:OUT;SFP:1101;
X-OriginatorOrg: stryker.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2022 07:49:52.3238
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7599dcc-07c4-4dc7-33e2-08da7849698a
X-MS-Exchange-CrossTenant-Id: 4e9dbbfb-394a-4583-8810-53f81f819e3b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4e9dbbfb-394a-4583-8810-53f81f819e3b;Ip=[64.136.252.176];Helo=[kzoex10b.strykercorp.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR01MB4996
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

CRYPTOCURRENCY DROP WILL MAKE YOU A MILLIONAIRE https://telegra.ph/Cryptocu=
rrency-makes-people-millionaires-at-15-people-per-hour---Page-597804-08-02

Follow this link to read our Privacy Statement<https://www.stryker.com/cont=
ent/stryker/gb/en/legal/global-policy-statement.html/>
