Return-Path: <SRS0=92ZL=3Y=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB35BC2D0B1
	for <linux-mmc@archiver.kernel.org>; Tue,  4 Feb 2020 11:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9503320730
	for <linux-mmc@archiver.kernel.org>; Tue,  4 Feb 2020 11:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="fhc0RWJh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgBDLkl (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 4 Feb 2020 06:40:41 -0500
Received: from mail-eopbgr700060.outbound.protection.outlook.com ([40.107.70.60]:33760
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727084AbgBDLkk (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 4 Feb 2020 06:40:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R5xAvYc30++mnkbpG/ukrbirgY9IZw8VONBllqCtHij4Dkk4u4KcMxJkZwuyJfsIA093xR4MHSVkqJeMkYVuMop5gPzjbyDluPomrxGZo3NVE/7kQafruKcsg610SB2wZAumUKrrxJArujIJEc0Pdp5OYDW3Ecs5L9QtCIq8cpSMkRfRuVdC/B9kh8iiobd0BUJ9+YHPx3pNLRICMjvtWxRIjsxOBIm75PWihebRJyey7i3Z/lT/7r2OTr5WVpOlt1O9hAYdp6lKHqem/fb2/Vn7KtH6A20LGTwi69K05RYuQWPwckVr76WcRCI+b3QaeJasTHWejsE4b4uFNiA37A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AK/vSU+WE0j7S6A7Al3TcdpubkIZo6c2nNqgD2WNKqw=;
 b=OU0ZjCOTQSKMOTCTDo5lZ8M6T4bAyQdgjpsDg1LsLuksnp82zFEzxZb1hSdsyPVr2IViqCCpGDWr3PfMa+7scoH/KfrTAdnJhUjg8yAU8VMrDvsnXLte+/7EEZo52TByCr1AVRe9oK4KBwSOeIb+vOTpG/1QfAVr7rgc0/nZoV1qK2NX/irlRjd2w7Fdp0K0NDiedKdlUVpRdUEAF7UZ+uxCOvI8p2Hj3N+63PuS7inPvELdnmN/PShwOBnJy3Or4uWzGaho7JwVk1vIXf3oVt7Eb7i0pKd/VWoKC6obr9oTzTFnd68rXyFp+6K69oSOlMHLKDe4tbxGI1XtW0udzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AK/vSU+WE0j7S6A7Al3TcdpubkIZo6c2nNqgD2WNKqw=;
 b=fhc0RWJhSeNIAo5yG4CwOVZZDVrn5uNh9/ejMKHDgG+QHkLSxkhKRNyQvfY5r0PQM6zO8iiF5E1rg+Ypaw5FMSFv81rUnqJKO02+qpyEkh+F6o9JVqK/LFSGPRmVAytrU0Sbvu/s+erd9IcOEmea7Vytq4vsV2yWviCE0PzMTJE=
Received: from SN4PR0201CA0064.namprd02.prod.outlook.com
 (2603:10b6:803:20::26) by DM5PR02MB3161.namprd02.prod.outlook.com
 (2603:10b6:4:61::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.33; Tue, 4 Feb
 2020 11:39:58 +0000
Received: from BL2NAM02FT016.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::202) by SN4PR0201CA0064.outlook.office365.com
 (2603:10b6:803:20::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.34 via Frontend
 Transport; Tue, 4 Feb 2020 11:39:58 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT016.mail.protection.outlook.com (10.152.77.171) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2686.25
 via Frontend Transport; Tue, 4 Feb 2020 11:39:57 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1iywYf-0000Ts-3r; Tue, 04 Feb 2020 03:39:57 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1iywYa-0007E1-03; Tue, 04 Feb 2020 03:39:52 -0800
Received: from [172.30.17.107]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1iywYV-0007DI-Q8; Tue, 04 Feb 2020 03:39:48 -0800
Subject: Re: [PATCH 2/4] firmware: xilinx: Add DLL reset support
To:     Manish Narani <manish.narani@xilinx.com>, michal.simek@xilinx.com,
        adrian.hunter@intel.com, ulf.hansson@linaro.org,
        jolly.shah@xilinx.com, rajan.vaja@xilinx.com,
        nava.manne@xilinx.com, tejas.patel@xilinx.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
References: <1579602095-30060-1-git-send-email-manish.narani@xilinx.com>
 <1579602095-30060-3-git-send-email-manish.narani@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <63fa8a5a-d87f-8fdd-3e6d-d95a14f562f2@xilinx.com>
Date:   Tue, 4 Feb 2020 12:39:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1579602095-30060-3-git-send-email-manish.narani@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(136003)(376002)(39860400002)(199004)(189003)(478600001)(70586007)(316002)(70206006)(4326008)(2906002)(6666004)(356004)(426003)(2616005)(26005)(186003)(336012)(44832011)(36756003)(31696002)(6636002)(81166006)(8676002)(81156014)(8936002)(31686004)(9786002)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR02MB3161;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4560c51b-5938-488c-0804-08d7a966f635
X-MS-TrafficTypeDiagnostic: DM5PR02MB3161:
X-Microsoft-Antispam-PRVS: <DM5PR02MB3161B4E3BC49F3E386E5CBE6C6030@DM5PR02MB3161.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-Forefront-PRVS: 03030B9493
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rAQ1TPViFhqLc4J7kpOg+WyqAf74XQPHWcy6VJF/tNB16UzyNy72hTTqkksrcv1rBwt4BRQIS7ABfgZYIzfQloFr+WlZNtiHaIiKm2hNv75bTw2dJ38kSHt1zgAj5TJ9fc2BfuhDQEVO0WcYbYrDBjWmt1imRdwOLnzfpN+ZEUh3+Npi7XJjv3TRbviqmJgPWc9EPMuoVUuaeK0Jp+YZQ/0N78m47pQRaBCv/sIr8aXEpKDqCYX9IGpJQCXMBDnlYePwU1UDq4PJna6gSSq3PkaNBoGvp/7TVEAaVZ+2LDiFKWpbDDwXrwR/7dZSzZB9Vs76KIPj/jKAo6HH/wJtFwYIEdcLuF2VKEhvtj1J9R1TOiQPRSThYnzV7f0DEQES49L0lyFnbNLUJZkfHqeDTK8wLNAvXhbxdFmpvW1BbrjdIpmB0MPX0qvQQ6FlKlSu
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2020 11:39:57.6862
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4560c51b-5938-488c-0804-08d7a966f635
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB3161
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 21. 01. 20 11:21, Manish Narani wrote:
> SD DLL resets are required for some of the operations on ZynqMP platform.
> Add DLL reset support in ZynqMP firmware driver for SD DLL reset.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  drivers/firmware/xilinx/zynqmp.c     | 1 +
>  include/linux/firmware/xlnx-zynqmp.h | 9 ++++++++-
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> index 89eb198cee5e..165ec0f1e10a 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -469,6 +469,7 @@ static int zynqmp_pm_clock_getparent(u32 clock_id, u32 *parent_id)
>  static inline int zynqmp_is_valid_ioctl(u32 ioctl_id)
>  {
>  	switch (ioctl_id) {
> +	case IOCTL_SD_DLL_RESET:
>  	case IOCTL_SET_SD_TAPDELAY:
>  	case IOCTL_SET_PLL_FRAC_MODE:
>  	case IOCTL_GET_PLL_FRAC_MODE:
> diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
> index e41ad9e37136..01a6d972b8a8 100644
> --- a/include/linux/firmware/xlnx-zynqmp.h
> +++ b/include/linux/firmware/xlnx-zynqmp.h
> @@ -92,7 +92,8 @@ enum pm_ret_status {
>  };
>  
>  enum pm_ioctl_id {
> -	IOCTL_SET_SD_TAPDELAY = 7,
> +	IOCTL_SD_DLL_RESET = 6,
> +	IOCTL_SET_SD_TAPDELAY,
>  	IOCTL_SET_PLL_FRAC_MODE,
>  	IOCTL_GET_PLL_FRAC_MODE,
>  	IOCTL_SET_PLL_FRAC_DATA,
> @@ -262,6 +263,12 @@ enum tap_delay_type {
>  	PM_TAPDELAY_OUTPUT,
>  };
>  
> +enum dll_reset_type {
> +	PM_DLL_RESET_ASSERT,
> +	PM_DLL_RESET_RELEASE,
> +	PM_DLL_RESET_PULSE,
> +};
> +
>  /**
>   * struct zynqmp_pm_query_data - PM query data
>   * @qid:	query ID
> 

Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
