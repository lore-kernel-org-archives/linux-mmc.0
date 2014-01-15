From: zhangfei <zhangfei.gao@linaro.org>
Subject: Re: [PATCH 1/2] clk: hisilicon: add hi3620_mmc_clks
Date: Wed, 15 Jan 2014 09:40:25 +0800
Message-ID: <52D5E709.7040105@linaro.org>
References: <1389604469-8064-1-git-send-email-zhangfei.gao@linaro.org> <1389604469-8064-2-git-send-email-zhangfei.gao@linaro.org> <20140114201740.4167.52076@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:34887 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751897AbaAOBko (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Jan 2014 20:40:44 -0500
Received: by mail-pd0-f178.google.com with SMTP id y13so421360pdi.37
        for <linux-mmc@vger.kernel.org>; Tue, 14 Jan 2014 17:40:44 -0800 (PST)
In-Reply-To: <20140114201740.4167.52076@quantum>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>, Chris Ball <cjb@laptop.org>, Arnd Bergmann <arnd@arndb.de>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, brooke.wangzhigang@huawei.com
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org, devicetree@vger.kernel.org

Dear Mike

On 01/15/2014 04:17 AM, Mike Turquette wrote:
> Quoting Zhangfei Gao (2014-01-13 01:14:28)
>> Suggest by Arnd: abstract mmc tuning as clock behavior,
>> also because different soc have different tuning method and registers.
>> hi3620_mmc_clks is added to handle mmc clock specifically on hi3620.
>>
>> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
>> Acked-by: Arnd Bergmann <arnd@arndb.de>
>> Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
>
> Patch looks good to me with one exception. I do not have
> Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt in the
> clk-next branch. Is there a stable branch I can pull in as a dependency?

Mach-hisi just have been uploaeded.
Have tried next-20140114, the patch can be applied successfully.
While v3.13-rc8 still can not.

Is this fine?

Thanks
