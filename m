From: zhangfei <zhangfei.gao@linaro.org>
Subject: Re: [PATCH 2/3] mmc: dw_mmc: add dw_mmc-k3 for k3 platform
Date: Tue, 14 Jan 2014 17:47:57 +0800
Message-ID: <52D507CD.8040900@linaro.org>
References: <1389278112-7099-1-git-send-email-zhangfei.gao@linaro.org> <1389278112-7099-3-git-send-email-zhangfei.gao@linaro.org> <003601cf0e09$5fb07c90$1f1175b0$%jun@samsung.com> <52CFFFDA.8050108@linaro.org> <001501cf1004$7b1f34b0$715d9e10$%jun@samsung.com> <52D3515B.7040008@linaro.org> <001c01cf1020$e3e1aed0$aba50c70$%jun@samsung.com> <52D3A43B.4030909@linaro.org> <002801cf110c$731fd720$595f8560$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:49287 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751042AbaANJs1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Jan 2014 04:48:27 -0500
Received: by mail-pa0-f54.google.com with SMTP id fa1so1945996pad.27
        for <linux-mmc@vger.kernel.org>; Tue, 14 Jan 2014 01:48:27 -0800 (PST)
In-Reply-To: <002801cf110c$731fd720$595f8560$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>, 'Chris Ball' <cjb@laptop.org>, 'Arnd Bergmann' <arnd@arndb.de>, 'Mike Turquette' <mturquette@linaro.org>, 'Rob Herring' <robherring2@gmail.com>, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Kumar Gala' <galak@codeaurora.org>, 'Haojian Zhuang' <haojian.zhuang@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org, devicetree@vger.kernel.org, 'Zhigang Wang' <brooke.wangzhigang@huawei.com>

Dear Seungwon

On 01/14/2014 05:38 PM, Seungwon Jeon wrote:

>> Looks like you dislike the clk_table very much :)
> Oh, I just want to remove dependency as I mentioned.
> 
>>
>> Double checked with the silicon guy, currently it is said the limitation
>> in HS200 and SDR104 can be replaced by the max_rate, so clk_table can be
>> replaced with ios->clock directly, though they have concern it is not so
>> convinent when removing clk_table in case limitation rate is not equal
>> to max_rate again in future.
> I guess specific clock handling(clk-hi3620.c) can adjust required source clock rate.
> 
It is doable now since the soc has been updated with the limitation,
which can reuse max_rate now.
The patch "mmc: dw_mmc: k3 remove clk_table" has been updated, and have
modified clk-hi3620.c accordingly.

Thanks
