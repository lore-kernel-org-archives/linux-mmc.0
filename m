From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2] mmc: dw_mmc: fix bug that cause mmc_test failture
Date: Fri, 27 Feb 2015 16:11:10 +0900
Message-ID: <54F0188E.9040609@samsung.com>
References: <1422273849-29773-1-git-send-email-addy.ke@rock-chips.com>
 <1424400925-3867-1-git-send-email-addy.ke@rock-chips.com>
 <54EE11D1.7050608@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <54EE11D1.7050608@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Addy Ke <addy.ke@rock-chips.com>, ulf.hansson@linaro.org, olof@lixom.net, heiko@sntech.de
Cc: huangtao@rock-chips.com, lintao@rock-chips.com, cf@rock-chips.com, linux-rockchip@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Hi,

I will apply into my-tree after change the subject and fix typo.

Acked-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

On 02/26/2015 03:17 AM, Javier Martinez Canillas wrote:
> Hello Addy,
> 
> On 02/20/2015 03:55 AM, Addy Ke wrote:
>> The STOP command can terminate a data transfer between a memory card and
>> mmc controller.
>>
>> As show in Synopsys DesignWare Cores Mobile Stroage Host Databook:
> 
> s/Stroage/Storage but maybe Ulf can amend the typo when applying?
> 
>> Data timeout and Data end-bit error will terminate further data transfer
>> by mmc controller. So we should not send abort command to terminate a
>> data transfer again if we got DRTO and EBE interrupt.
>>
>> After this patch, all mmc_test cases can pass on RK3288-Pink2 board.
>>
>> Signed-off-by: Addy Ke <addy.ke@rock-chips.com>
> 
> I did not run all the tests listed in /sys/kernel/debug/mmc*/*/testlist
> because some of them will overwrite the data in my card but at least
> the read ones completed successfully and $subject does not cause a
> regression in the Exynos5250 Snow, Exynos5420 Peach Pit and Exynos5800
> Peach Pi Chromebooks where I tested it.
> 
> Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> 
> Best regards,
> Javier
> 
