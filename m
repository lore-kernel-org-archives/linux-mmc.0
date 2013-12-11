From: zhangfei <zhangfei.gao@linaro.org>
Subject: Re: [PATCH 2/3] mmc: dw_mmc: add dw_mmc-k3 for k3 platform
Date: Wed, 11 Dec 2013 23:36:42 +0800
Message-ID: <52A8868A.3000105@linaro.org>
References: <1386770541-15056-1-git-send-email-zhangfei.gao@linaro.org> <1386770541-15056-3-git-send-email-zhangfei.gao@linaro.org> <201312111549.14017.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f41.google.com ([209.85.160.41]:65499 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751262Ab3LKPg6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Dec 2013 10:36:58 -0500
Received: by mail-pb0-f41.google.com with SMTP id jt11so10224607pbb.28
        for <linux-mmc@vger.kernel.org>; Wed, 11 Dec 2013 07:36:57 -0800 (PST)
In-Reply-To: <201312111549.14017.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Chris Ball <cjb@laptop.org>, Mike Turquette <mturquette@linaro.org>, Rob Herring <robherring2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Kumar Gala <galak@codeaurora.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org, devicetree@vger.kernel.org



On 12/11/2013 10:49 PM, Arnd Bergmann wrote:
> On Wednesday 11 December 2013, Zhangfei Gao wrote:

>> +Required Properties:
>> +
>> +* compatible: should be one of the following.
>> +  - "hisilicon,hi4511-dw-mshc": for controllers with hi4511 specific extentions.
>> +* clk-table-num: should be number of clks in clk-table required by each mmc timing
>> +* clk-table: should clock list required by each mmc timing
>
> I have not seen "clk-table" and "clk-table-num" before. Are these standard
> properties? What are the units that are used here, what does the index mean?
>

"clk-table" and "clk-table-num" are private properties.
Instead simply on/off, the ip need different ciu clock for each timing mode.
Take emmc as example,
clk-table-num = <8>;
clk-table =
<13000000 50000000 0 0 13000000 50000000 0 100000000>;
MMC_TIMING_LEGACY mode, 25M should be set with parent clock 180M,
MMC_TIMING_MMC_HS mode, 50M is required with parent clock 360M

"clk-table" list all clocks to be set in all supported timing one by one.
"clk-table-num" is the table number, since not find function getting 
table number.
For example, next version will support MMC_TIMING_MMC_HS200 mode, the 
clk-table-num = <9> with 9 clocks in the "clk-table"

Thanks


