From: Haojian Zhuang <haojian.zhuang@linaro.org>
Subject: Re: [PATCH 1/2] clk: hisilicon: add hi3620_mmc_clks
Date: Wed, 15 Jan 2014 13:59:40 +0800
Message-ID: <52D623CC.50009@linaro.org>
References: <1389604469-8064-1-git-send-email-zhangfei.gao@linaro.org> <1389604469-8064-2-git-send-email-zhangfei.gao@linaro.org> <20140114201740.4167.52076@quantum> <52D5E709.7040105@linaro.org> <20140115035339.4167.51194@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:55220 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751587AbaAOF7t (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jan 2014 00:59:49 -0500
Received: by mail-pb0-f46.google.com with SMTP id ma3so671998pbc.19
        for <linux-mmc@vger.kernel.org>; Tue, 14 Jan 2014 21:59:49 -0800 (PST)
In-Reply-To: <20140115035339.4167.51194@quantum>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>, zhangfei <zhangfei.gao@linaro.org>, Chris Ball <cjb@laptop.org>, Arnd Bergmann <arnd@arndb.de>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, brooke.wangzhigang@huawei.com
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org, devicetree@vger.kernel.org, Kevin Hilman <khilman@linaro.org>


On 01/15/2014 11:53 AM, Mike Turquette wrote:
> Quoting zhangfei (2014-01-14 17:40:25)
>> Dear Mike
>>
>> On 01/15/2014 04:17 AM, Mike Turquette wrote:
>>> Quoting Zhangfei Gao (2014-01-13 01:14:28)
>>>> Suggest by Arnd: abstract mmc tuning as clock behavior,
>>>> also because different soc have different tuning method and registers.
>>>> hi3620_mmc_clks is added to handle mmc clock specifically on hi3620.
>>>>
>>>> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
>>>> Acked-by: Arnd Bergmann <arnd@arndb.de>
>>>> Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
>>> Patch looks good to me with one exception. I do not have
>>> Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt in the
>>> clk-next branch. Is there a stable branch I can pull in as a dependency?
>> Mach-hisi just have been uploaeded.
>> Have tried next-20140114, the patch can be applied successfully.
>> While v3.13-rc8 still can not.
>>
>> Is this fine?
> Can you give me a link to the branch that introduces
> Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt?
>
> I guess the patch introducing it is going through arm-soc. Is this going
> in for 3.14? If so then perhaps the clk tree and the arm-soc tree can
> share a stable branch that introduces it.
>
> Regards,
> Mike
>
Some patches are merged into arm-soc, and others are in clk tree.
If sharing a stable branch between arm-soc and clk tree, it only means
that we need to revert all commits that are in arm-soc and clk tree.
I think it's too complex.

How about split the patch? The patch on document should enter in arm-soc.

Regards
Haojian
