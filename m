Return-Path: <SRS0=fQuC=DO=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029FFC4363C
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Oct 2020 08:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A8BE2080A
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Oct 2020 08:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="E1EXQUxl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgJGId4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 7 Oct 2020 04:33:56 -0400
Received: from mail-co1nam11on2077.outbound.protection.outlook.com ([40.107.220.77]:13280
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726041AbgJGIdz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 7 Oct 2020 04:33:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ga5wbdM3jQsPjz5PYHPAXsu8gt8PUPC6Xjb9VyDfhLEVzbfp7uVE8rKKzMa4nP9RIZiQaDA3r5ME47EAeWVGZgRRmZ47lakTCm+ZiUKq7ng/TYpJi7DH37VF05larIgso35GZPfdWIkfsRpoYYTis8tpONA1PIEPJZrgS6ZPWvZFE7hO3H0MJk4kDcYpcvDbGixyYpkq3ghoUulBq5eLJtFDVKPSvlapDur/zcm30qVnH+fRQfvgBIzow+R1RRNYVhxPAX51TFHLBzIfuboeqIF75U8gVzQ6RVAw0aC3foreKccg+7alMJkBF9RxpPXib4mgyxZgoKtNrhXiaAgBMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C47O1H93J0O6Se06B170nEPFOX+30HAtgMpdwd3Wkug=;
 b=PN0V4vVex2w9+wYM26M0IdkQHTyVbKwtff2EDWkLNS5Xf9uO0oldWLC3vjMuOokJUpEK9CTh0lqhGbeq3BQ9uNc38HMxd1Y+Ojlr4Q2+FdTiybFMWYMfqTWNaj9gO1m03iwmsb4zW4VioM9ajZjifZh5Que6XAP68yBNSxAPKAzheuhCgHOFSh7yhYZDZazzBS/YS0f1Rkt1horS41zqeC5z5JpXRioNd3z6AphVUgxDumyE6Hg3QdB8KE2GEQZyLQRvctfv2+MlN+o667AQsnRE7tZJCB+HNdr666cgGsPWsr9oZv4y2Lj9SZ4KbHj3m3jiQgb30cqYNL428rmugQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=arndb.de smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C47O1H93J0O6Se06B170nEPFOX+30HAtgMpdwd3Wkug=;
 b=E1EXQUxlYQhAi7WdLpu2cZztQ7upf4qt3p96edJf+Y9UskbmAafUjh04LJQg6qL1oSLXIMlvrKMtdPnzb5tW+GJ1PpwGmiz6v+yUyLWfLOuIOFgWGdHYSAIhIia0PIkhBNK3bJqZhbLQodZelWOkY7ysEVEGMeXduRu9OdxhWbM=
Received: from CY4PR03CA0022.namprd03.prod.outlook.com (2603:10b6:903:33::32)
 by BL0PR02MB4577.namprd02.prod.outlook.com (2603:10b6:208:4d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Wed, 7 Oct
 2020 08:33:51 +0000
Received: from CY1NAM02FT039.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:33:cafe::99) by CY4PR03CA0022.outlook.office365.com
 (2603:10b6:903:33::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21 via Frontend
 Transport; Wed, 7 Oct 2020 08:33:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT039.mail.protection.outlook.com (10.152.75.140) with Microsoft SMTP
 Server id 15.20.3433.39 via Frontend Transport; Wed, 7 Oct 2020 08:33:50
 +0000
Received: from [149.199.38.66] (port=33218 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1kQ4ss-0006hH-Pn; Wed, 07 Oct 2020 01:33:14 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1kQ4tS-0003Tb-H3; Wed, 07 Oct 2020 01:33:50 -0700
Received: from [172.30.17.110]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1kQ4tL-0003RP-33; Wed, 07 Oct 2020 01:33:43 -0700
Subject: Re: [PATCH v3 1/2] mmc: sdhci-of-arasan: Enable UHS-1 support for
 Keem Bay SOC
To:     muhammad.husaini.zulkifli@intel.com, adrian.hunter@intel.com,
        michal.simek@xilinx.com, sudeep.holla@arm.com,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     lakshmi.bai.raja.subramanian@intel.com,
        wan.ahmad.zainie.wan.mohamad@intel.com, arnd@arndb.de
References: <20201006155549.3595-1-muhammad.husaini.zulkifli@intel.com>
 <20201006155549.3595-2-muhammad.husaini.zulkifli@intel.com>
From:   Michal Simek <michal.simek@xilinx.com>
Autocrypt: addr=michals@xilinx.com; keydata=
 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
 0Z1MQlmNcq2bhOMzTxuXX2NDzUZs4aqEyZQ=
Message-ID: <49c9fe27-ee82-f490-482b-365101d3b6cf@xilinx.com>
Date:   Wed, 7 Oct 2020 10:33:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201006155549.3595-2-muhammad.husaini.zulkifli@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 986f5824-64b5-4d19-1d10-08d86a9bb7ba
X-MS-TrafficTypeDiagnostic: BL0PR02MB4577:
X-Microsoft-Antispam-PRVS: <BL0PR02MB4577288D8B796ED03528FACBC60A0@BL0PR02MB4577.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1qqg+IKeLrz+N7Bls7bK2IKQF/bdhpWzC0NV/qZx9IgRjY9/vRsdYAl1gQwcm5mXO02xUGqVjxAPQFUKoNb+S48JzoU7ZoQg67zJ8WxakoYuRgnRPjWfrEjkcT4sDlKQOVG4V4Q9olGGLPliVabzsuYfLcT3dP39C+bADCIVc4H8y0FiGLeJhr48FO3s/UgHkKnsLELE7wys47xkjj03v/qYuQ5YKce9HcXyAe0vVBw2rDQ7jHigoDdwVgpskolmJDpi9p2nZKWutroCSrD5QWFGKjnsavahE77HH77Pmx2jkunneAUM8zLANgJA9/npwk8OxWO42Wr6EyYpd8xzhIudm0ATOFbWY27TGMlvmFkLuRMX7lUkB4fbL9ZZXwH6GUNnHeqpLeluDQfvDVChMeE0nyb+o0eaRZlE/BNSPx8=
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(376002)(136003)(346002)(39850400004)(396003)(46966005)(186003)(26005)(336012)(70586007)(70206006)(83380400001)(82310400003)(8676002)(2616005)(426003)(8936002)(31696002)(356005)(316002)(81166007)(5660300002)(82740400003)(478600001)(9786002)(36756003)(47076004)(6666004)(7416002)(44832011)(2906002)(4326008)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2020 08:33:50.7698
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 986f5824-64b5-4d19-1d10-08d86a9bb7ba
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT039.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4577
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



On 06. 10. 20 17:55, muhammad.husaini.zulkifli@intel.com wrote:
> From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
> 
> Voltage switching sequence is needed to support UHS-1 interface.
> There are 2 places to control the voltage.
> 1) By setting the AON register using firmware driver calling
> system-level platform management layer (SMC) to set the register.
> 2) By controlling the GPIO expander value to drive either 1.8V or 3.3V
> for power mux input.
> 
> Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 127 +++++++++++++++++++++++++++++
>  1 file changed, 127 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index f186fbd016b1..e681e6f860ba 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -16,6 +16,7 @@
>   */
>  
>  #include <linux/clk-provider.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/module.h>
>  #include <linux/of_device.h>
> @@ -23,6 +24,7 @@
>  #include <linux/regmap.h>
>  #include <linux/of.h>
>  #include <linux/firmware/xlnx-zynqmp.h>
> +#include <linux/firmware/intel/keembay_firmware.h>
>  
>  #include "cqhci.h"
>  #include "sdhci-pltfm.h"
> @@ -150,6 +152,7 @@ struct sdhci_arasan_data {
>  	struct regmap	*soc_ctl_base;
>  	const struct sdhci_arasan_soc_ctl_map *soc_ctl_map;
>  	unsigned int	quirks;
> +	struct gpio_desc *uhs_gpio;
>  
>  /* Controller does not have CD wired and will not function normally without */
>  #define SDHCI_ARASAN_QUIRK_FORCE_CDTEST	BIT(0)
> @@ -361,6 +364,113 @@ static int sdhci_arasan_voltage_switch(struct mmc_host *mmc,
>  	return -EINVAL;
>  }
>  
> +static int sdhci_arasan_keembay_voltage_switch(struct mmc_host *mmc,
> +				       struct mmc_ios *ios)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
> +	u16 ctrl_2;
> +	u16 clk;

nit: put it to one line.

> +	int ret;
> +
> +	switch (ios->signal_voltage) {
> +	case MMC_SIGNAL_VOLTAGE_180:
> +		clk  = sdhci_readw(host, SDHCI_CLOCK_CONTROL);

nit: double space

> +		clk &= ~SDHCI_CLOCK_CARD_EN;
> +		sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +
> +		clk  = sdhci_readw(host, SDHCI_CLOCK_CONTROL);

nit: double space again.

> +		if (clk & SDHCI_CLOCK_CARD_EN)
> +			return -EAGAIN;
> +
> +		sdhci_writeb(host, SDHCI_POWER_ON | SDHCI_POWER_180,
> +				   SDHCI_POWER_CONTROL);
> +
> +		/*
> +		 * Set VDDIO_B voltage to Low for 1.8V
> +		 * which is controlling by GPIO Expander.
> +		 */
> +		gpiod_set_value_cansleep(sdhci_arasan->uhs_gpio, 0);
> +
> +		/*
> +		 * This is like final gatekeeper. Need to ensure changed voltage
> +		 * is settled before and after turn on this bit.
> +		 */
> +		usleep_range(1000, 1100);
> +
> +		ret = keembay_sd_voltage_selection(KEEMBAY_SET_1V8_VOLT);
> +		if (ret)
> +			return ret;
> +
> +		usleep_range(1000, 1100);
> +
> +		ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +		ctrl_2 |= SDHCI_CTRL_VDD_180;
> +		sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
> +
> +		/* Sleep for 5ms to stabilize 1.8V regulator */
> +		usleep_range(5000, 5500);
> +
> +		/* 1.8V regulator output should be stable within 5 ms */
> +		ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +		if (!(ctrl_2 & SDHCI_CTRL_VDD_180))
> +			return -EAGAIN;
> +
> +		clk  = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +		clk |= SDHCI_CLOCK_CARD_EN;
> +		sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +		break;
> +	case MMC_SIGNAL_VOLTAGE_330:
> +		/*
> +		 * Set VDDIO_B voltage to High for 3.3V
> +		 * which is controlling by GPIO Expander.
> +		 */
> +		gpiod_set_value_cansleep(sdhci_arasan->uhs_gpio, 1);
> +
> +		/*
> +		 * This is like final gatekeeper. Need to ensure changed voltage
> +		 * is settled before and after turn on this bit.
> +		 */
> +		usleep_range(1000, 1100);
> +
> +		ret = keembay_sd_voltage_selection(KEEMBAY_SET_3V3_VOLT);
> +		if (ret)
> +			return ret;
> +
> +		usleep_range(1000, 1100);
> +
> +		/* Set 1.8V Signal Enable in the Host Control2 register to 0 */
> +		ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +		ctrl_2 &= ~SDHCI_CTRL_VDD_180;
> +		sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
> +
> +		/* Sleep for 5ms to stabilize 3.3V regulator */
> +		usleep_range(5000, 5500);
> +
> +		/* 3.3V regulator output should be stable within 5 ms */
> +		ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +		if (ctrl_2 & SDHCI_CTRL_VDD_180)
> +			return -EAGAIN;
> +
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int sdhci_arasan_keembay_select_drive_strength(struct mmc_card *card,
> +					unsigned int max_dtr, int host_drv,
> +					int card_drv, int *drv_type)
> +{
> +	if (card->host->ios.signal_voltage == MMC_SIGNAL_VOLTAGE_180)
> +		*drv_type = MMC_SET_DRIVER_TYPE_C;
> +
> +	return 0;
> +}
> +
>  static const struct sdhci_ops sdhci_arasan_ops = {
>  	.set_clock = sdhci_arasan_set_clock,
>  	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
> @@ -1521,6 +1631,7 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>  	struct sdhci_pltfm_host *pltfm_host;
>  	struct sdhci_arasan_data *sdhci_arasan;
>  	struct device_node *np = pdev->dev.of_node;
> +	struct device *dev = &pdev->dev;

nit: I got this but as I see 3 lines below maybe would be better to use
it everywhere but it can be done in separate patch.

>  	const struct sdhci_arasan_of_data *data;
>  
>  	match = of_match_node(sdhci_arasan_of_match, pdev->dev.of_node);
> @@ -1600,6 +1711,22 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>  		host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
>  	}
>  
> +	if (of_device_is_compatible(np, "intel,keembay-sdhci-5.1-sd")) {
> +		struct gpio_desc *uhs;
> +
> +		uhs = devm_gpiod_get_optional(dev, "uhs", GPIOD_OUT_HIGH);

I can't see change in dt binding to record uhs gpio.


Better
sdhci_arasan->uhs_gpio = devm_gpiod_get_optional(dev, "uhs",
GPIOD_OUT_HIGH);

then you can avoid uhs variable.

> +		if (IS_ERR(uhs))
> +			return dev_err_probe(dev, PTR_ERR(uhs), "can't get uhs gpio\n");
> +
> +		sdhci_arasan->uhs_gpio = uhs;
> +
> +		host->mmc_host_ops.start_signal_voltage_switch =
> +			sdhci_arasan_keembay_voltage_switch;
> +
> +		host->mmc_host_ops.select_drive_strength =
> +			sdhci_arasan_keembay_select_drive_strength;
> +	}
> +
>  	sdhci_arasan_update_baseclkfreq(host);
>  
>  	ret = sdhci_arasan_register_sdclk(sdhci_arasan, clk_xin, &pdev->dev);
> 

Thanks,
Michal
