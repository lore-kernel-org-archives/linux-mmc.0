Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48FF4C63777
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Nov 2020 13:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D07742469D
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Nov 2020 13:49:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="anQPbFtS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgKRNtj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 18 Nov 2020 08:49:39 -0500
Received: from mail-mw2nam12on2074.outbound.protection.outlook.com ([40.107.244.74]:32672
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726209AbgKRNtj (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 18 Nov 2020 08:49:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dTnej9t9yjq3ovuv/uV6qs5BfPyPi1amNKAC1IR7zJC2juQxM5vPVbZg7b10uGHqooCd+/aqblXlW/azyklpvhDdyW4MSK+APUtDPVdFeUndu7T7HUYmfdqftElAM7wMQDe/WsTtvaEYG5ATHa7UoYw7Kcwc6lOdBdBxShBaCiopp8ZfEEb+/C1+9kyNHZZLbJE/XADYn/NlTHDwlnwpR9EHZmNUDD1UAiBH1M/JElwBbiQvEdjU6UCZboXD5r399m/fUOY405TQU09hiCSPO9xpeekZWx8qNFPznxuuRuNZKpXCgCNEJj/yL4RryDrGF6alNrlGycskNB1jtVFXIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cuvQ9YW+jnvhAwwcPteXArsbPDDDo3q4tGw1VUYTf8M=;
 b=fxGLBMG7VEc7BD0+1/fZ8E3pPs0A3gSctLKoRmUFCmOjJuZ/y5CIIBcV8MFe2lZppFiCQoxCWC1EYDhhOvZQ6nYIWunWjiU1DaWy1D1sShoQuQRcRYFKX1X5YJZdQzQxuCpygcERGylZKAhdTB4865F+XdEcWxLlhopVatwG+Hs0JH3zsnvo/a2aqyEJv64YJkX66IlSbd4jhQpVHa8q+UMhAPhuvZfr7efRU09VUCrcr/p3YwCtP6NeikTmej0ye+9W9wFwOsipIeSRxQA/weDVJ7JJMewpnMkYDayECkSwlWM+F/6Wxrm2gTQkiqSJlRWWupmNiiAkLpEJQkHiXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cuvQ9YW+jnvhAwwcPteXArsbPDDDo3q4tGw1VUYTf8M=;
 b=anQPbFtSrehXlxErDkx8vx9UD2JBktFtrXVRomEqF5KFlgS9hqcW0+6sfzHmvJaKyRPslsb8Upo0CCnPpyrskWlWDYcCyjGI1bdFAL9s6ePDU4EPWK556Q9Z77H49WquTXnwP2Khqv+rkCqzTcQ9yUfaEWd401dSBT+ll8i4eQE=
Received: from DM6PR12CA0004.namprd12.prod.outlook.com (2603:10b6:5:1c0::17)
 by MWHPR0201MB3433.namprd02.prod.outlook.com (2603:10b6:301:7c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25; Wed, 18 Nov
 2020 13:49:35 +0000
Received: from CY1NAM02FT008.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::f6) by DM6PR12CA0004.outlook.office365.com
 (2603:10b6:5:1c0::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend
 Transport; Wed, 18 Nov 2020 13:49:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT008.mail.protection.outlook.com (10.152.75.59) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3564.22 via Frontend Transport; Wed, 18 Nov 2020 13:49:34 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Wed, 18 Nov 2020 05:49:04 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Wed, 18 Nov 2020 05:49:04 -0800
Envelope-to: git@xilinx.com,
 michal.simek@xilinx.com,
 linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 ulf.hansson@linaro.org,
 adrian.hunter@intel.com
Received: from [172.30.17.110] (port=46740)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1kfNpX-0001Zm-Kc; Wed, 18 Nov 2020 05:49:03 -0800
To:     Manish Narani <manish.narani@xilinx.com>,
        <michal.simek@xilinx.com>, <adrian.hunter@intel.com>,
        <ulf.hansson@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@xilinx.com>
References: <1605680495-37483-1-git-send-email-manish.narani@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH] mmc: sdhci-of-arasan: Add pinctrl support to the driver
Message-ID: <f3a6f0e5-6bca-d85f-9330-bf73151ee956@xilinx.com>
Date:   Wed, 18 Nov 2020 14:49:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <1605680495-37483-1-git-send-email-manish.narani@xilinx.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e701800e-6924-4aef-3b5f-08d88bc8c8a5
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3433:
X-Microsoft-Antispam-PRVS: <MWHPR0201MB34331BC966B0A33AF6557893C6E10@MWHPR0201MB3433.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A8ul6LPLDDNFFmiD9zV19r4WrybE+Z9Kc4gX8rX/GVT1NdACnC318pgJA4gPMLgq0RBXcXSv5Ln1fnXrCmRwjEHrqBu3PvHQplkDAdpwMmILQAVkOq/MzewV8SY/g2tQY1JFFgxQcjQvguMRg1n8+hvRqZnH1twPtaI3aCeDCBHKsekuieFy5PO0/TG+LmsCk5tuABNjcAZiYxl2qwJ0+kWAqh0eaq4hI2m1JIfJHYRgW8dhVgk5YwE4/LwuMiwJ9aCQE2U6OpoP6Z3+lYnZ3ATqvPAlGDKlIv4aMkcQ6NDplLll957PGd9l+sb9dxuctMVrrO9eQX8bhCpICNPteFjqpmbvKVrWgb9O97G4BLs0IzktUDA2Af8FyqHg4HHKOuSzJK0gzrymjomWW7mZ2Z1uDLYeQVSp4qU5DlYmdr2x09FVg6GISdV62m4feFMZRX5C3jausPxO3tHt5ody4g==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39860400002)(136003)(396003)(346002)(376002)(46966005)(83380400001)(54906003)(82740400003)(2906002)(9786002)(2616005)(478600001)(82310400003)(8936002)(7636003)(31686004)(31696002)(336012)(26005)(356005)(47076004)(44832011)(8676002)(426003)(316002)(70206006)(110136005)(70586007)(4326008)(186003)(36756003)(5660300002)(36906005)(107886003)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2020 13:49:34.8287
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e701800e-6924-4aef-3b5f-08d88bc8c8a5
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT008.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3433
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



On 18. 11. 20 7:21, Manish Narani wrote:
> Driver should be able to handle optional pinctrl setting.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 829ccef87426..f788cc9d5914 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -23,6 +23,7 @@
>  #include <linux/regmap.h>
>  #include <linux/of.h>
>  #include <linux/firmware/xlnx-zynqmp.h>
> +#include <linux/pinctrl/consumer.h>
>  
>  #include "cqhci.h"
>  #include "sdhci-pltfm.h"
> @@ -135,6 +136,8 @@ struct sdhci_arasan_clk_data {
>   * @clk_ops:		Struct for the Arasan Controller Clock Operations.
>   * @soc_ctl_base:	Pointer to regmap for syscon for soc_ctl registers.
>   * @soc_ctl_map:	Map to get offsets into soc_ctl registers.
> + * @pinctrl:		Per-device pin control state holder.
> + * @pins_default:	Pinctrl state for a device.
>   * @quirks:		Arasan deviations from spec.
>   */
>  struct sdhci_arasan_data {
> @@ -149,6 +152,8 @@ struct sdhci_arasan_data {
>  
>  	struct regmap	*soc_ctl_base;
>  	const struct sdhci_arasan_soc_ctl_map *soc_ctl_map;
> +	struct pinctrl	*pinctrl;
> +	struct pinctrl_state *pins_default;
>  	unsigned int	quirks;
>  
>  /* Controller does not have CD wired and will not function normally without */
> @@ -1619,6 +1624,25 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>  		goto unreg_clk;
>  	}
>  
> +	sdhci_arasan->pinctrl = devm_pinctrl_get(&pdev->dev);
> +	if (!IS_ERR(sdhci_arasan->pinctrl)) {
> +		sdhci_arasan->pins_default =
> +			pinctrl_lookup_state(sdhci_arasan->pinctrl,
> +					     PINCTRL_STATE_DEFAULT);
> +		if (IS_ERR(sdhci_arasan->pins_default)) {
> +			dev_err(&pdev->dev, "Missing default pinctrl config\n");
> +			ret = PTR_ERR(sdhci_arasan->pins_default);
> +			goto unreg_clk;
> +		}
> +
> +		ret = pinctrl_select_state(sdhci_arasan->pinctrl,
> +					   sdhci_arasan->pins_default);
> +		if (ret) {
> +			dev_err(&pdev->dev, "could not select default state\n");
> +			goto unreg_clk;
> +		}
> +	}
> +
>  	sdhci_arasan->phy = ERR_PTR(-ENODEV);
>  	if (of_device_is_compatible(pdev->dev.of_node,
>  				    "arasan,sdhci-5.1")) {
> 

Ulf: Is there any need to describe in binding doc? I mean all txt based
binding have it described. But not quite sure if there is a need to
describe it in yaml if only default option is supported.
And when this is optional it should be fine also for others SOC.

For patch itself.

Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal

