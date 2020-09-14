Return-Path: <SRS0=0j+4=CX=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7190C433E2
	for <linux-mmc@archiver.kernel.org>; Mon, 14 Sep 2020 06:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53AA720770
	for <linux-mmc@archiver.kernel.org>; Mon, 14 Sep 2020 06:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="tJ59hNf7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbgINGqL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 14 Sep 2020 02:46:11 -0400
Received: from mail-bn8nam12on2078.outbound.protection.outlook.com ([40.107.237.78]:6721
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726039AbgINGqK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 14 Sep 2020 02:46:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bxE8oMuJj2aQQC7pnEtXO6VwiuHEmMqBDbAy+uzJCpE/C2WMUc/fmv/TpxB5LSPiS8jiQ1NAZ2BAtYEs9Wu85x9lHd2fCJdnP28p8Q7RAr2z7J62vYL0u8tWmdPiF6lubsE6y6D4Rc5BbK5Z4bmpfnjQtVOQzpDkhCgcrwAq9444CP4HS8gGtfwYnBo3ocEnwCVnyJGn5ELY2UTSmkxFPox6XNmLB4qW1F67X2tk8gtilcL1C8XnUdBG/BVgkG+ZGLtb2EUzKJnXNz8cgODDhZrjhMNUp7nPXUqehiWQmjOED+riadGvJdjCCI9eqW6Rxg8lNLIwyGbymEUn8YVs0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGIvl3Ws9FzACLorPjKMD2McgMixQL9B7satyChgrz0=;
 b=MSaTcsyRoWTRUXNZC0UtukFluHq/EkwRyYqVXWjIRAff/fdVzPNIoZm8vmBfE7JKWiR5E/IsjA9u7WA7Bpc6WgdlUaO7nfOy8f/RcxKihgFFXI0PWeonLDaa/lc2mDLo39RP/U5oEY9AJ/iSrG/jMfixcTIeDIKrpCGL2N7F37KXEnlY5LS3JkB2jDQ/Bv+predvv+Va36YxV6EiJtDdKHbrdB53s+ZU4xgDGE5NgDbphwHxz41i/s53/HAb71gTdLozNLV+c0dxJw1aP7VrPObxznN0yup+6pysf4SA/urMstlb/oxDqzefetKnuIGhpwLGAUGdVDYAgC2UkEv4/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=intel.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGIvl3Ws9FzACLorPjKMD2McgMixQL9B7satyChgrz0=;
 b=tJ59hNf7KbAIEaZWRcdn4PGTBgafKeuFSgibFMSc8iAuYcxD4gYq0EzKsuKPwACGePkvWpIj6e6cCaklB/sIypQ9QAgk+N6xdIYBmNfpOuaR9Fh1yzDnV5DB96RYcI0/XsftaGuhArJ1b1BbYlLwwnVzuiNdKTkSXSGV6g5uyDE=
Received: from SA9PR11CA0004.namprd11.prod.outlook.com (2603:10b6:806:6e::9)
 by BY5PR02MB6387.namprd02.prod.outlook.com (2603:10b6:a03:1b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Mon, 14 Sep
 2020 06:46:05 +0000
Received: from SN1NAM02FT009.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:6e:cafe::84) by SA9PR11CA0004.outlook.office365.com
 (2603:10b6:806:6e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Mon, 14 Sep 2020 06:46:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT009.mail.protection.outlook.com (10.152.73.32) with Microsoft SMTP
 Server id 15.20.3370.16 via Frontend Transport; Mon, 14 Sep 2020 06:46:05
 +0000
Received: from [149.199.38.66] (port=53909 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1kHiFV-0005Mh-58; Sun, 13 Sep 2020 23:46:01 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1kHiFZ-0003FH-4G; Sun, 13 Sep 2020 23:46:05 -0700
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 08E6k3ac028025;
        Sun, 13 Sep 2020 23:46:03 -0700
Received: from [172.30.17.109]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1kHiFX-0003Cu-42; Sun, 13 Sep 2020 23:46:03 -0700
Subject: Re: [PATCH v1 1/1] mmc: sdhci-of-arasan: Enable UHS-1 support for
 Keem Bay SOC
To:     muhammad.husaini.zulkifli@intel.com, adrian.hunter@intel.com,
        michal.simek@xilinx.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Cc:     lakshmi.bai.raja.subramanian@intel.com
References: <20200914051214.13918-1-muhammad.husaini.zulkifli@intel.com>
 <20200914051214.13918-2-muhammad.husaini.zulkifli@intel.com>
From:   Michal Simek <michal.simek@xilinx.com>
Autocrypt: addr=michals@xilinx.com; keydata=
 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
 0Z1MQlmNcq2bhOMzTxuXX2NDzUZs4aqEyZQ=
Message-ID: <21d34b75-5947-e115-7c9a-6d068375bbdd@xilinx.com>
Date:   Mon, 14 Sep 2020 08:46:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200914051214.13918-2-muhammad.husaini.zulkifli@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b7ce3a1-94b1-4ba4-921f-08d85879da95
X-MS-TrafficTypeDiagnostic: BY5PR02MB6387:
X-Microsoft-Antispam-PRVS: <BY5PR02MB6387196D4F1F0775E2240100C6230@BY5PR02MB6387.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hdAeJyvN/J5Dk20hlj1rCVK72dp5Ac89pI/pKPpq5ukTRlndlVEW95zxc1wuRY79OU+TurQOgk4m91Pcvzeul7ZjMX8FZSnNEhrV3PvjRIzGGR/6AuUB4pzl+u2IY9ByzST4Xpj0iwmF7uL1jbN0+Fv6w7fEk3xYx5H2hAyWL/jcdgZTUo8waqfl3TZ4Lha+asby1yHPTJ4Ih73ebIUf4Z9Z/3A4l1Q0w1rCMGfFatRTdehPgNFrlnFPAw8Dt7MtHfT1OoBnMOgMtp+mwRQYeWFqVs7sJAJJSHwobzUrXtNuts28ULM5XBFjnVZ3yaj+y+RLylmTpCziJBpKWVoMTLsV1GkQlNkTgoHj9wckyi12rHsEsr3JpS/PRIVKj4+9mybz8r4Hb/OCRRNtqFalEUOSxNNsgn6WuKp/uctIpRYL0Ezh9F+3tiqZEtdI+SRE/6tox6rcMVsiJ+uQPvXBb4gDnYkWhizp7Kc6EKEGx74=
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(396003)(346002)(376002)(39850400004)(136003)(46966005)(316002)(81166007)(31696002)(44832011)(356005)(82740400003)(70586007)(8936002)(36756003)(2616005)(2906002)(5660300002)(336012)(70206006)(426003)(26005)(47076004)(8676002)(83380400001)(4326008)(186003)(9786002)(6916009)(31686004)(478600001)(82310400003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2020 06:46:05.4342
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b7ce3a1-94b1-4ba4-921f-08d85879da95
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT009.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6387
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi, +Arnd,

On 14. 09. 20 7:12, muhammad.husaini.zulkifli@intel.com wrote:
> From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
> 
> Voltage switching sequence is needed to support UHS-1 interface
> as Keem Bay EVM is using external voltage regulator to switch between
> 1.8V and 3.3V.
> 
> Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 140 +++++++++++++++++++++++++++++
>  1 file changed, 140 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index f186fbd016b1..c133408d0c74 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -16,7 +16,9 @@
>   */
>  
>  #include <linux/clk-provider.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/mfd/syscon.h>
> +#include <linux/arm-smccc.h>
>  #include <linux/module.h>
>  #include <linux/of_device.h>
>  #include <linux/phy/phy.h>
> @@ -41,6 +43,11 @@
>  #define SDHCI_ITAPDLY_ENABLE		0x100
>  #define SDHCI_OTAPDLY_ENABLE		0x40
>  
> +/* Setting for Keem Bay IO Pad 1.8 Voltage Selection */
> +#define KEEMBAY_AON_SIP_FUNC_ID		0x8200ff26
> +#define KEEMBAY_AON_SET_1V8_VOLT	0x01
> +#define KEEMBAY_AON_SET_3V3_VOLT	0x00
> +
>  /* Default settings for ZynqMP Clock Phases */
>  #define ZYNQMP_ICLK_PHASE {0, 63, 63, 0, 63,  0,   0, 183, 54,  0, 0}
>  #define ZYNQMP_OCLK_PHASE {0, 72, 60, 0, 60, 72, 135, 48, 72, 135, 0}
> @@ -150,6 +157,7 @@ struct sdhci_arasan_data {
>  	struct regmap	*soc_ctl_base;
>  	const struct sdhci_arasan_soc_ctl_map *soc_ctl_map;
>  	unsigned int	quirks;
> +	struct gpio_desc *uhs_gpio;
>  
>  /* Controller does not have CD wired and will not function normally without */
>  #define SDHCI_ARASAN_QUIRK_FORCE_CDTEST	BIT(0)
> @@ -361,6 +369,121 @@ static int sdhci_arasan_voltage_switch(struct mmc_host *mmc,
>  	return -EINVAL;
>  }
>  
> +static int sdhci_arasan_keembay_set_voltage(int volt)
> +{
> +#if IS_ENABLED(CONFIG_HAVE_ARM_SMCCC)
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_smc(KEEMBAY_AON_SIP_FUNC_ID, volt, 0, 0, 0, 0, 0, 0, &res);
> +	if (res.a0)
> +		return -EINVAL;
> +	return 0;

I am just curious about calling this smc directly from device driver. I
see that several drivers are doing this but isn't it better to hide
these in firmware driver?
Also the part of FUNC_ID is smc32, sip service call (0x82000000)
function identifier which is likely something what should be used as
macro in shared location that others can use it too.

Another part is that based on description you are talking to external
voltage regulator without using regulator framework at all. Isn't it
better just to create firmware based regulator for this purpose?

Or was there any agreement to put these stuff directly to the driver?

Thanks,
Michal

