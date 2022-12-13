Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A39DFC4332F
	for <linux-mmc@archiver.kernel.org>; Tue, 13 Dec 2022 07:33:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234668AbiLMHdm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 13 Dec 2022 02:33:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234671AbiLMHdm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Dec 2022 02:33:42 -0500
Received: from mail-m11880.qiye.163.com (mail-m11880.qiye.163.com [115.236.118.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DF311A1E;
        Mon, 12 Dec 2022 23:33:38 -0800 (PST)
Received: from [172.16.12.69] (unknown [58.22.7.114])
        by mail-m11880.qiye.163.com (Hmail) with ESMTPA id E0491201C6;
        Tue, 13 Dec 2022 15:33:34 +0800 (CST)
Message-ID: <cd4639e4-b0e4-3141-5b9f-1a7bd14cb799@rock-chips.com>
Date:   Tue, 13 Dec 2022 15:33:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Cc:     shawn.lin@rock-chips.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v1 2/3] mmc: starfive: Add sdio/emmc driver support
Content-Language: en-GB
To:     William Qiu <william.qiu@starfivetech.com>
References: <20221207131731.1291517-1-william.qiu@starfivetech.com>
 <20221207131731.1291517-3-william.qiu@starfivetech.com>
 <faea4932-add6-fc51-836d-b113e8c9a194@rock-chips.com>
 <26e9c3eb-aaeb-8cbd-dda0-20f28331dbeb@starfivetech.com>
From:   Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <26e9c3eb-aaeb-8cbd-dda0-20f28331dbeb@starfivetech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFJSktLSjdXWS1ZQUlXWQ8JGhUIEh9ZQVkaTR0eVh5DGUlMTR4aTUxIGVUTARMWGhIXJB
        QOD1lXWRgSC1lBWU5DVUlJVUxVSkpPWVdZFhoPEhUdFFlBWU9LSFVKSktISkxVSktLVUtZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MEk6EQw*DD0jOE0rIzoZQjAt
        NTkKCzJVSlVKTUxLQkpNQ0pOTU9CVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
        C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUlDSkM3Bg++
X-HM-Tid: 0a850a67395a2eb6kusne0491201c6
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi

On 2022/12/13 15:21, William Qiu wrote:
> 
> 
> On 2022/12/13 10:24, Shawn Lin wrote:
>> Hi
>
>> use ".common_caps = MMC_CAP_CMD23" instead.
>>
> 
> Hi Shawn,
> 
> Thank you for taking time to review.
> The .common_caps is not defined in dw_mci_drv_data.
> And .num_caps is also used in dw_mci-rockchip.c.
> 

That means your patch is based on old upstream kernel which hasn't
been updated for at least one year.:)

> Best regards,
> William Qiu
>>> +    .set_ios = dw_mci_starfive_set_ios,
>>> +    .parse_dt = dw_mci_starfive_parse_dt,
>>> +    .execute_tuning = dw_mci_starfive_execute_tuning,
>>> +};
>>> +
>>> +static const struct of_device_id dw_mci_starfive_match[] = {
>>
