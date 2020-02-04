Return-Path: <SRS0=92ZL=3Y=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 859F4C2D0B1
	for <linux-mmc@archiver.kernel.org>; Tue,  4 Feb 2020 12:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EDEB2087E
	for <linux-mmc@archiver.kernel.org>; Tue,  4 Feb 2020 12:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Njvn9X2T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbgBDMcX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 4 Feb 2020 07:32:23 -0500
Received: from mail-dm6nam11on2071.outbound.protection.outlook.com ([40.107.223.71]:36161
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727119AbgBDMcX (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 4 Feb 2020 07:32:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bl1lPnJp6q+Z0uheCuVj4KHIxU6G5FcXncPlfGo2JWOGWa/KxVqbbikvL1ct7nyMbPeZnx5w9srBuhyOfH/+wlEEWyR+yBlhPRvVpecwCkljg37Yx3HZaEQfHHz5i/KnhNKYq+iDct/OrMajyvE15r1mIOYnjOot7+VFQEzRLUd6f/g56s/bf4fZzlD4zDNMPWEcNkwPK3GB/iNkuwev5j4trzEDeUME82HSSMF0Qm0zeiizc5ArPlM4vpZm0QlF2AvPAC9HreVSEEwO8Em1bk5eUX8mWw5MlWBtt0vH+HWX2PAlUaTLtAy83Wn68HQXCX+naBL8/e89Mvnv0ZLCNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uq7qUjiZAP+3yo+UE4aGzmYa/lilal1ogWwn8TJfQ4Q=;
 b=HKP2EUIPnhGCaSUIybXivJm3CmvqejG1LofVnY4yTYzb40o/mhPhv7pX7HaaFkN5+CneJPnFLQmva9jlGpmd4KXBSgnE5wi24kA/rrdX5Z0/rlgKK3mE8sW4wnlyYLN+joQ4hLvQTkANGDp839TDbEsXcgN7RZqnYvaTpowvWeciEwi+H715YlGtiZk/xASbp3V/3p9KYeN06wX6TfhElnLRtjDJlwrRs4RTSpT9f42XA9Xn/CkBNTCzTL+8fSBmrrah1Np6I97mLQsIFizE+cUsyOuKW+f//DrYkv5aSmeklPv/K7H/9D2neieJXW72dICTdm70s7IhjXvgOi/mUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uq7qUjiZAP+3yo+UE4aGzmYa/lilal1ogWwn8TJfQ4Q=;
 b=Njvn9X2T+s8wwYpMNyIDKcglkexAKtHLruqA4vJ7ek9qq9Uo4Imnxq/CsA5DoSaW7scjhOtGUKjVuTDPAVvQg2dsr6tm+R+COfuYaOO2AxZgltfH8dWD3LW1HahIEsNCidS2K1BWYqtLnk7xdNoMmTHzhM49liRKMaOhRTV7rqM=
Received: from BN7PR02CA0035.namprd02.prod.outlook.com (2603:10b6:408:20::48)
 by BYAPR02MB4280.namprd02.prod.outlook.com (2603:10b6:a03:5a::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.32; Tue, 4 Feb
 2020 12:31:40 +0000
Received: from BL2NAM02FT023.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::202) by BN7PR02CA0035.outlook.office365.com
 (2603:10b6:408:20::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.29 via Frontend
 Transport; Tue, 4 Feb 2020 12:31:40 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT023.mail.protection.outlook.com (10.152.77.72) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2686.25
 via Frontend Transport; Tue, 4 Feb 2020 12:31:39 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1iyxMg-0001sl-QH; Tue, 04 Feb 2020 04:31:38 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1iyxMb-0002fh-M8; Tue, 04 Feb 2020 04:31:33 -0800
Received: from [172.30.17.107]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1iyxMW-0002eU-6U; Tue, 04 Feb 2020 04:31:28 -0800
Subject: Re: [PATCH 4/4] sdhci: arasan: Remove quirk for broken base clock
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>, jolly.shah@xilinx.com,
        rajan.vaja@xilinx.com, nava.manne@xilinx.com,
        tejas.patel@xilinx.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
References: <1579602095-30060-1-git-send-email-manish.narani@xilinx.com>
 <1579602095-30060-5-git-send-email-manish.narani@xilinx.com>
 <99fd3904-37fa-f070-f7ac-e1dcb5bf43de@intel.com>
 <0d7e7a44-91dc-baef-5dcf-4ff683e98581@xilinx.com>
 <CAPDyKFosDoABbHaoEtyay-uMKpq6QXsoby631gK-1f6iAS0mgg@mail.gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <d07db149-07a0-fef8-7cd5-27a219f30550@xilinx.com>
Date:   Tue, 4 Feb 2020 13:31:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFosDoABbHaoEtyay-uMKpq6QXsoby631gK-1f6iAS0mgg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(39860400002)(396003)(376002)(199004)(189003)(110136005)(54906003)(5660300002)(316002)(70586007)(31696002)(53546011)(36756003)(70206006)(26005)(186003)(81156014)(6636002)(8676002)(81166006)(31686004)(9786002)(8936002)(426003)(2906002)(2616005)(336012)(44832011)(4326008)(478600001)(356004)(6666004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4280;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6500944-a407-4dc2-f2c6-08d7a96e2f20
X-MS-TrafficTypeDiagnostic: BYAPR02MB4280:
X-Microsoft-Antispam-PRVS: <BYAPR02MB42801B81F78F911566AF1A8FC6030@BYAPR02MB4280.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 03030B9493
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /QlK9r4YPVWtoPBvH2og6Y1u0s5HTLC9uZxAFiVEKyIiZV252jYpDLW7Ju2E3VCWc/viTCLaWeH4xPTFb74qGpwz1XGN8jDZ7Iby/om7MlxrYbMstNhLOFWKeW6ASLv2kfRce0VxU3MXHL0C4xUpY8dOirR9vs4hF98X3dCYZ2Mx6gi05STTXODlFTOJAzO8pmw8/n4JFkf2D+KaCDDMZ/tPBxOsO0nvXdi46ZxYdUjtz/2Imgh3NhRsJrMEqNRzOBKrpJJf8ODb2m1C/D4cccTvMEtjoyswWKPWK/TNkcSKw2FHDx6R262hoAoJTpzCcX2+YR472LNnkJ5QBZVBTLy6CrP07Rh8fTOA6V5xdmtXH8r5jiEJCeH27aAqmnm7yD901a7VpHaldD/Ir6AIC2T324f50M0lls9rjn/U336as50aG/PTVMQ1eUIZAwXK
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2020 12:31:39.6628
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6500944-a407-4dc2-f2c6-08d7a96e2f20
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4280
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 04. 02. 20 13:29, Ulf Hansson wrote:
> On Tue, 4 Feb 2020 at 12:42, Michal Simek <michal.simek@xilinx.com> wrote:
>>
>> On 03. 02. 20 12:31, Adrian Hunter wrote:
>>> On 21/01/20 12:21 pm, Manish Narani wrote:
>>>> This patch removes quirk which indicates a broken base clock. This was
>>>> making the kernel report wrong base clock of ~187MHz instead of 200MHz
>>>> even as the measurement on the hardware was showing 200MHz.
>>>>
>>>> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
>>>> State: pending
>>>
>>> Huh?
>>
>> It shouldn't be here. It is internal patch labeling.
>> Manish: Please send v2 with all lines you got and remove this above.
> 
> No need for a resend, I can fix this before applying, which will be
> when rc1 is out.
> 
>>
>>>
>>> Otherwise:
>>>
>>> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>>
>> These patches requires firmware changes. Feel free to take it directly
>> via your tree. If you want me to take it via arm-soc tree please let me
>> know.
> 
> Thanks, I pick them up via my mmc tree then.

ok. Please let me know if there is any conflict. It should be simple add.

Thanks,
Michal

