From: zhangfei <zhangfei.gao@linaro.org>
Subject: Re: [PATCH 1/2] clk: hisilicon: add hi3620_mmc_clks
Date: Tue, 14 Jan 2014 19:52:27 +0800
Message-ID: <52D524FB.2050903@linaro.org>
References: <1389604469-8064-1-git-send-email-zhangfei.gao@linaro.org> <1389604469-8064-2-git-send-email-zhangfei.gao@linaro.org> <002a01cf1115$19f6bde0$4de439a0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:42487 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751481AbaANLww (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Jan 2014 06:52:52 -0500
Received: by mail-pd0-f180.google.com with SMTP id q10so8667675pdj.25
        for <linux-mmc@vger.kernel.org>; Tue, 14 Jan 2014 03:52:51 -0800 (PST)
In-Reply-To: <002a01cf1115$19f6bde0$4de439a0$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>, 'Chris Ball' <cjb@laptop.org>, 'Arnd Bergmann' <arnd@arndb.de>, 'Mike Turquette' <mturquette@linaro.org>, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Haojian Zhuang' <haojian.zhuang@linaro.org>, brooke.wangzhigang@huawei.com
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org, devicetree@vger.kernel.org



On 01/14/2014 06:40 PM, Seungwon Jeon wrote:
> On Mon, January 13, 2014, Zhangfei Gao wrote:
>> Suggest by Arnd: abstract mmc tuning as clock behavior,
>> also because different soc have different tuning method and registers.
>> hi3620_mmc_clks is added to handle mmc clock specifically on hi3620.
>>
>> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
>> Acked-by: Arnd Bergmann <arnd@arndb.de>
>> Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
> 
> I add my ack.
> Please run 'checkpatch' and remove some warnings.
> 
> Acked-by: Seungwon Jeon <tgih.jun@samsung.com>
> 

Thanks Seungwon.

Have checked before, and ignoring warnings of "line over 80 characters"
seems more neat.

Thanks
