From: zhangfei <zhangfei.gao@linaro.org>
Subject: Re: [RESEND LIST PATCHv7 1/4] clk: socfpga: Add a clk-phase property
 to the "altr,socfpga-gate-clk"
Date: Tue, 17 Dec 2013 22:47:06 +0800
Message-ID: <52B063EA.4000800@linaro.org>
References: <1387213476-22122-1-git-send-email-dinguyen@altera.com> <1387213476-22122-2-git-send-email-dinguyen@altera.com> <52B00167.4010903@linaro.org> <52B0554F.1080509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:38175 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754002Ab3LQOrP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Dec 2013 09:47:15 -0500
Received: by mail-pd0-f169.google.com with SMTP id v10so6891484pde.28
        for <linux-mmc@vger.kernel.org>; Tue, 17 Dec 2013 06:47:15 -0800 (PST)
In-Reply-To: <52B0554F.1080509@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dinh Nguyen <dinh.linux@gmail.com>, dinguyen@altera.com, arnd@arndb.de, cjb@laptop.org, jh80.chung@samsung.com, tgih.jun@samsung.com, heiko@sntech.de, dianders@chromium.org, alim.akhtar@samsung.com, bzhao@marvell.com, mturquette@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org



On 12/17/2013 09:44 PM, Dinh Nguyen wrote:
> Hi Zhangfei,
>
> On 12/17/13 1:46 AM, zhangfei wrote:
>>
>>
>> On 12/17/2013 01:04 AM, dinguyen@altera.com wrote:
>>> From: Dinh Nguyen <dinguyen@altera.com>
>>
>>> +static int socfpga_clk_prepare(struct clk_hw *hwclk)
>>> +{
>>> +    struct socfpga_clk *socfpgaclk = to_socfpga_clk(hwclk);
>>> +    struct regmap *sys_mgr_base_addr;
>>> +    u32 hs_timing;
>>> +
>>> +    if (socfpgaclk->clk_phase[0] || socfpgaclk->clk_phase[1]) {
>>> +        sys_mgr_base_addr =
>>> syscon_regmap_lookup_by_compatible("altr,sys-mgr");
>>> +        if (IS_ERR(sys_mgr_base_addr)) {
>>> +            pr_err("%s: failed to find altr,sys-mgr regmap!\n",
>>> __func__);
>>> +            return -EINVAL;
>>> +        }
>>> +        hs_timing = SYSMGR_SDMMC_CTRL_SET(socfpgaclk->clk_phase[0],
>>> +                        socfpgaclk->clk_phase[1]);
>>> +        regmap_write(sys_mgr_base_addr, SYSMGR_SDMMCGRP_CTRL_OFFSET,
>>> +                        hs_timing);
>>> +    }
>>> +    return 0;
>>> +}
>>
>> So reusing gate-clk here and check the node of "altr,sys-mgr".
>> I think it is good and simple.
>> Also can define new clock combined with node "altr,sys-mgr" with
>> parent of sdmmc_clk.
>>
>> Thanks for the update, it is fine to me.
> Thanks, can I get an Ack from you for this version?
>

Sure, if it is helpful.

Thanks
