Return-Path: <SRS0=92ZL=3Y=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C24C2D0B1
	for <linux-mmc@archiver.kernel.org>; Tue,  4 Feb 2020 11:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D7242084E
	for <linux-mmc@archiver.kernel.org>; Tue,  4 Feb 2020 11:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="QGYGC0zc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbgBDLjb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 4 Feb 2020 06:39:31 -0500
Received: from mail-eopbgr760050.outbound.protection.outlook.com ([40.107.76.50]:61502
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727030AbgBDLja (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 4 Feb 2020 06:39:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZkKfn4ien15Wz9Tm3OziMfM9PNh0aq2PSFBxDNKLWM30A12kVIDBiN430d8bIZksbthKnBDHffIdPlikqh9QNHtv67PLMWaUMoR+pZHzcgDS7Jo4/WOcfUeKnkXUm3NN0BbujibQnE2AH+lAlU3vp1+hG76coycqVq8HTx28JJCrCtNDr5RzjxyHkujP9gAT/CwYIexg/Ont4sMwPHi6PfQfgxql56R2n3oKUykf3m5Jtu9hf2EpcsE4u1PV7MPAzJryWkHJedgTsLV8OUsAZSGH+imBjRbwaHzb/htqeNW0yJYMWZTFQe8LvzVHrg6jgwnVhiPy6hf3axFSQ2GwsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ApEc8KTT75h3H6t1sojOQ3AwbiFStsvVzyLFxF2S0e0=;
 b=WX9nhq3biEFKybC0gG1A2Vgd1lWKhgzv1LT1Dphju8fKdXV1sSakVPCSFKBw1tR+ODD+pYS3HaQYDf2aXkn+YG/VdzWeYxOechfh4MTcXGYvTx3p+O4ih1N+6QyfDgHj2aVUEmK+8+LJcL1llHlWR3TzgWZ54dTCQXjmTCZmJ1uGyXBRVVHyX5ONDN23DS9cliNOBJfTGqLfI+cUG9COY6zABxuv4wT+L6p3CyFUP5vkPe0pJ75mPldHTXJ2w1tT00YO5SMagutrezrvimo20rOmfK9Vd+WOSn85gqODb2sZkh4P+P6fKn7cZ/ZxdJezpNVR5Uivm8eXILo/I6+yQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ApEc8KTT75h3H6t1sojOQ3AwbiFStsvVzyLFxF2S0e0=;
 b=QGYGC0zccGPhObV8VGirDLrnZxP2pABmnwmMz6ajgY2DEpp3rUDPyN3g2fDNpF1PwFwZy+I9rILoqe9o4pIX91QsA7oQjMeh6sQ1eiVBrZxAl3CpsUwVlWrj6ZlWR6qjz8MbZtK3xw54/itNZ2acQqejOpxbTaOgDTVbHQIWAMo=
Received: from CY4PR02CA0027.namprd02.prod.outlook.com (2603:10b6:903:117::13)
 by SN6PR02MB4014.namprd02.prod.outlook.com (2603:10b6:805:31::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.29; Tue, 4 Feb
 2020 11:39:27 +0000
Received: from BL2NAM02FT029.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::209) by CY4PR02CA0027.outlook.office365.com
 (2603:10b6:903:117::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.34 via Frontend
 Transport; Tue, 4 Feb 2020 11:39:27 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT029.mail.protection.outlook.com (10.152.77.100) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2686.25
 via Frontend Transport; Tue, 4 Feb 2020 11:39:27 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1iywYA-0000Tf-OM; Tue, 04 Feb 2020 03:39:26 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1iywY5-0007AP-Ke; Tue, 04 Feb 2020 03:39:21 -0800
Received: from [172.30.17.107]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1iywY0-00078q-S0; Tue, 04 Feb 2020 03:39:17 -0800
Subject: Re: [PATCH 1/4] firmware: xilinx: Add ZynqMP Tap Delay setup ioctl to
 the valid list
To:     Manish Narani <manish.narani@xilinx.com>, michal.simek@xilinx.com,
        adrian.hunter@intel.com, ulf.hansson@linaro.org,
        jolly.shah@xilinx.com, rajan.vaja@xilinx.com,
        nava.manne@xilinx.com, tejas.patel@xilinx.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
References: <1579602095-30060-1-git-send-email-manish.narani@xilinx.com>
 <1579602095-30060-2-git-send-email-manish.narani@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <b1a238bd-aa24-5d1e-6393-fda502de6d1d@xilinx.com>
Date:   Tue, 4 Feb 2020 12:39:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1579602095-30060-2-git-send-email-manish.narani@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(136003)(39860400002)(346002)(189003)(199004)(6636002)(426003)(26005)(70586007)(70206006)(336012)(2616005)(186003)(36756003)(478600001)(5660300002)(44832011)(31686004)(4326008)(2906002)(6666004)(356004)(31696002)(9786002)(316002)(8936002)(4744005)(81166006)(8676002)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4014;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1d69eee-13a3-462d-518f-08d7a966e41a
X-MS-TrafficTypeDiagnostic: SN6PR02MB4014:
X-Microsoft-Antispam-PRVS: <SN6PR02MB40141E102ED0D9D09476355EC6030@SN6PR02MB4014.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 03030B9493
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aaWCEbU8Sb9mxZa1kQisDkMjVAy34eF9crHZfym+xxNxpqNURKiinszMxUILG50k7hcqQ+kQTWC7ncTQCOvRVkyKVVm3FFTcjg6AIT61c49y/cTLuvJdpYsfkPzOp1vc+jn6p2DAU7eLkjH4m6nptNyMU5Adz9PRVmohoJTViW0JP3RTVKxCiSHIry0sDdVA91Ro8Z6F24KF5+g4csGlHpjGPrMDJ+cty0FQdQHDHs8KvfLqWH+TqOECbPAMgKG+JYatb73mvNrylx/gJqnrydYRB/9gGYrWl4yKekuGKTl5r8AyQCuidHU7ttbhTZIS/MQFMSA5T5Uc/drsHmvlu2AuaPOWo4OKyqJ9k4sAOsWxnDAYsU+NZRXM08dSSJkb540TsUPBcuhqbLrXH+0F27qxR1PsbyxjzAbabrLpsacWeoL7dNtxnZ++BxAqjIJ2
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2020 11:39:27.3131
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1d69eee-13a3-462d-518f-08d7a966e41a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4014
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 21. 01. 20 11:21, Manish Narani wrote:
> The Tap Delay setup ioctl was not added to valid list due to which it
> may fail to set Tap Delays for SD. This patch fixes the same.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  drivers/firmware/xilinx/zynqmp.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> index 75bdfaa08380..89eb198cee5e 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -469,6 +469,7 @@ static int zynqmp_pm_clock_getparent(u32 clock_id, u32 *parent_id)
>  static inline int zynqmp_is_valid_ioctl(u32 ioctl_id)
>  {
>  	switch (ioctl_id) {
> +	case IOCTL_SET_SD_TAPDELAY:
>  	case IOCTL_SET_PLL_FRAC_MODE:
>  	case IOCTL_GET_PLL_FRAC_MODE:
>  	case IOCTL_SET_PLL_FRAC_DATA:
> 

Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
