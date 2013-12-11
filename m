From: zhangfei <zhangfei.gao@linaro.org>
Subject: Re: [PATCH 3/3] clk: hisilicon: add hi3620_mmc_clks
Date: Wed, 11 Dec 2013 23:40:39 +0800
Message-ID: <52A88777.9030502@linaro.org>
References: <1386770541-15056-1-git-send-email-zhangfei.gao@linaro.org> <1386770541-15056-4-git-send-email-zhangfei.gao@linaro.org> <201312111544.47519.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:40176 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751508Ab3LKPkv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Dec 2013 10:40:51 -0500
Received: by mail-pb0-f46.google.com with SMTP id md12so10131341pbc.19
        for <linux-mmc@vger.kernel.org>; Wed, 11 Dec 2013 07:40:51 -0800 (PST)
In-Reply-To: <201312111544.47519.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Chris Ball <cjb@laptop.org>, Mike Turquette <mturquette@linaro.org>, Rob Herring <robherring2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Kumar Gala <galak@codeaurora.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org, devicetree@vger.kernel.org



On 12/11/2013 10:44 PM, Arnd Bergmann wrote:
> On Wednesday 11 December 2013, Zhangfei Gao wrote:
>> +PCTRL: Peripheral misc control register
>> +
>> +Required Properties:
>> +- compatible: "hisilicon,pctrl"
>> +- reg: Address and size of pctrl.
>> +
>> +Example:
>> +
>> +       /* for Hi3620 */
>> +       pctrl: pctrl@fca09000 {
>> +               compatible = "hisilicon,pctrl";
>> +               reg = <0xfca09000 0x1000>;
>> +       };
>
> It seems you are missing the clock specific parts of the binding:
> You should document the required value of #clock-cells as well as
> the possible values for the clock specifier.
>

It is reuse Documentation/devicetree/bindings/clock/hi3620-clock.txt via 
adding hisilicon,hi3620-mmc-clock"

- compatible: should be one of the following.
   - "hisilicon,hi3620-clock" - controller compatible with Hi3620 SoC.
+  - "hisilicon,hi3620-mmc-clock" - controller specific for Hi3620 mmc.

- reg: physical base address of the controller and length of memory mapped
   region.

- #clock-cells: should be 1.

Thanks

