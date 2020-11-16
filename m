Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2595C4742C
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Nov 2020 07:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E3302071E
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Nov 2020 07:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="pYd5jdmB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgKPHHq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Nov 2020 02:07:46 -0500
Received: from mail-dm6nam12on2073.outbound.protection.outlook.com ([40.107.243.73]:52129
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727097AbgKPHHq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 16 Nov 2020 02:07:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jULn6vpZt+miXc3kHHfAdSCwMUlIX1MnqGHLW3DVeOXgRxZOKr7l9DWXUWxEd4od7TurIM6Fm67c9WnE+dHhunVIv4u5YJLOO+0bWMoyQKvygJvFWLOxeeSqGLQrMqUJzdQ4ph/0avjiLqaVdKnuqsTppWKWeL2n8KmTuwHWwenr3IODUhlAMd7V5zXE2kGYFyJ9T954bXt8dgBGVpWoyYKdfTcmHbUbMoNYHlPX/8sPjlyIJPergF9lo+sbCNV0OQx7ImR0bR/BTTIQNtYF5rPvyJLJrbcDlhY937JEOqmL1ksj9qJCHoLL1D3p3zAr6sEwBkj1UJJmUlQO3OyFJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Siui+DEukPxTASmKEPU6Yu55DV7RNg61jZc7JD6rGh4=;
 b=QH76LJmfQIGUMY27PFM/cxslQo8GuCrC1F5gAOTlWQLuRj3XkEKljs93sTgNLUv+oOfzdL+jVzyMR+4PSQXoBbVaM7qxMdfo3s0N7Tq+TKcEeGY2on1C+tWFE+HhfV5W9L3vM0OfYKeZI00JF93MWQ2mzQ5/6akCW/XuJ/3V0ijNBNuVQgysB0DgFd7imvqLZo2dqZU1Vc59q7MnyeR8y3wdRnJ+6qcppLmQ0I5gaSlf72io0YCtES6EYjrQ1AIqw2z8s9YESma44wO3kkiDIqLHgZd2B8VYxJ93gyAosgDiflPoAKqYIXxYfhjcQ0dIlVniY6zDF/xomOBrn66CNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Siui+DEukPxTASmKEPU6Yu55DV7RNg61jZc7JD6rGh4=;
 b=pYd5jdmBW8myZQiEZed2Trc9z09XnRKJbp45R3S8xPRjPBHtsehx2JCrADteVmsBPT654y4nY/tMYg9LhyYvItrBTpxcsIY968fs1ta0J8jxWcpWE9U8p0+rCARz+m+MiqwwSeIL5XwiNql+EUb8Lc70Drw6/RmaWSroHXgawmg=
Received: from BL0PR1501CA0026.namprd15.prod.outlook.com
 (2603:10b6:207:17::39) by BL0PR02MB4819.namprd02.prod.outlook.com
 (2603:10b6:208:5d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Mon, 16 Nov
 2020 07:07:42 +0000
Received: from BL2NAM02FT007.eop-nam02.prod.protection.outlook.com
 (2603:10b6:207:17:cafe::2d) by BL0PR1501CA0026.outlook.office365.com
 (2603:10b6:207:17::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28 via Frontend
 Transport; Mon, 16 Nov 2020 07:07:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT007.mail.protection.outlook.com (10.152.77.46) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3564.22 via Frontend Transport; Mon, 16 Nov 2020 07:07:41 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Sun, 15 Nov 2020 23:07:15 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Sun, 15 Nov 2020 23:07:15 -0800
Envelope-to: git@xilinx.com,
 michal.simek@xilinx.com,
 linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 ulf.hansson@linaro.org,
 adrian.hunter@intel.com
Received: from [172.30.17.110] (port=37044)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1keYba-0005Qq-Uv; Sun, 15 Nov 2020 23:07:15 -0800
Subject: Re: [PATCH 1/2] mmc: sdhci-of-arasan: Use Mask writes for Tap delays
To:     Manish Narani <manish.narani@xilinx.com>,
        <michal.simek@xilinx.com>, <adrian.hunter@intel.com>,
        <ulf.hansson@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@xilinx.com>,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
References: <1605507327-106818-1-git-send-email-manish.narani@xilinx.com>
 <1605507327-106818-2-git-send-email-manish.narani@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <98b6be8f-48db-5e7f-5fd7-825432235e06@xilinx.com>
Date:   Mon, 16 Nov 2020 08:07:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <1605507327-106818-2-git-send-email-manish.narani@xilinx.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da87ca50-0524-4f0b-51d7-08d889fe4f68
X-MS-TrafficTypeDiagnostic: BL0PR02MB4819:
X-Microsoft-Antispam-PRVS: <BL0PR02MB4819F6B18AFE6C625437D01CC6E30@BL0PR02MB4819.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zay36nYYyPfO9lXGWj26c2OJ4M96mC3wWOq4ghNFmbETydc4TGcACwPZFYaCDBQm9j4Mog7DurYuVsG6mbwhrXvbqMqJ4ZUBRVRyxZzzqHH6r4FlR4Lrx7f9zlNcZDLX8ZLCqfP8nz4UtLx/d2uK26Pubww5qbL4K9i/a7fWegm0nvahlBzE//boG1r+yjyacnCfwWAE/xy4AHucrcQoKFNSDPLCrlQrmcLwsP1KPduJrP8fRwYMLbclPkYc0eMqkTrg0a5zimMSYhHgx+xNfSgeh2HleE47qnIc6UQwJ8LEykW0jX3DtW4cXx0JcGAoHJuoltb+kcCEf8avR51liC3c869o9fcQycW5jzsDSzHLl/Jch2VALkEJOYNzk1X4p121+MkiwSkE09Q6Z/qxhos6nN94TScu+xmjxKWtROStqmw+2co0fZslpT4PQjusKXZTti8BYAASmIbMNnKJbg==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(39850400004)(376002)(396003)(346002)(46966005)(31696002)(5660300002)(26005)(70206006)(6666004)(316002)(107886003)(44832011)(478600001)(47076004)(2616005)(36756003)(9786002)(186003)(4326008)(82310400003)(70586007)(82740400003)(426003)(336012)(54906003)(8676002)(356005)(7636003)(31686004)(110136005)(36906005)(2906002)(8936002)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2020 07:07:41.8221
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da87ca50-0524-4f0b-51d7-08d889fe4f68
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT007.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4819
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



On 16. 11. 20 7:15, Manish Narani wrote:
> Mask the ITAP and OTAP delay bits before updating with the new
> tap value for Versal platform.
> 
> Fixes: 1a470721c8f5 ("sdhci: arasan: Add support for Versal Tap Delays")
> Signed-off-by: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 100621e55427..3ec5ecad637c 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -30,7 +30,10 @@
>  #define SDHCI_ARASAN_VENDOR_REGISTER	0x78
>  
>  #define SDHCI_ARASAN_ITAPDLY_REGISTER	0xF0F8
> +#define SDHCI_ARASAN_ITAPDLY_SEL_MASK	0xFF
> +
>  #define SDHCI_ARASAN_OTAPDLY_REGISTER	0xF0FC
> +#define SDHCI_ARASAN_OTAPDLY_SEL_MASK	0x3F
>  
>  #define SDHCI_ARASAN_CQE_BASE_ADDR	0x200
>  #define VENDOR_ENHANCED_STROBE		BIT(0)
> @@ -755,6 +758,7 @@ static int sdhci_versal_sdcardclk_set_phase(struct clk_hw *hw, int degrees)
>  		regval = sdhci_readl(host, SDHCI_ARASAN_OTAPDLY_REGISTER);
>  		regval |= SDHCI_OTAPDLY_ENABLE;
>  		sdhci_writel(host, regval, SDHCI_ARASAN_OTAPDLY_REGISTER);
> +		regval &= ~SDHCI_ARASAN_OTAPDLY_SEL_MASK;
>  		regval |= tap_delay;
>  		sdhci_writel(host, regval, SDHCI_ARASAN_OTAPDLY_REGISTER);
>  	}
> @@ -822,6 +826,7 @@ static int sdhci_versal_sampleclk_set_phase(struct clk_hw *hw, int degrees)
>  		sdhci_writel(host, regval, SDHCI_ARASAN_ITAPDLY_REGISTER);
>  		regval |= SDHCI_ITAPDLY_ENABLE;
>  		sdhci_writel(host, regval, SDHCI_ARASAN_ITAPDLY_REGISTER);
> +		regval &= ~SDHCI_ARASAN_ITAPDLY_SEL_MASK;
>  		regval |= tap_delay;
>  		sdhci_writel(host, regval, SDHCI_ARASAN_ITAPDLY_REGISTER);
>  		regval &= ~SDHCI_ITAPDLY_CHGWIN;
> 

Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
