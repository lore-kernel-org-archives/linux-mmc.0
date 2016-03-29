From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 2/2] mmc: dw_mmc: add resets support to dw_mmc
Date: Tue, 29 Mar 2016 17:30:16 +0900
Message-ID: <56FA3D18.9070600@samsung.com>
References: <1457254062-22677-1-git-send-email-guodong.xu@linaro.org>
 <1457254062-22677-2-git-send-email-guodong.xu@linaro.org>
 <56DC3BAD.8020107@rock-chips.com>
 <CAFGCpxz3GfFeduaz1Dkg0WvRJWs+GHdVu8uY0-wV=RGyRfBE=A@mail.gmail.com>
 <56F9E6E5.9000100@kernel-upstream.org> <56FA3B70.2090902@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:51561 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751358AbcC2IaU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Mar 2016 04:30:20 -0400
In-reply-to: <56FA3B70.2090902@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei <zhangfei.gao@linaro.org>, Shawn Lin <shawn.lin@kernel-upstream.org>, Guodong Xu <guodong.xu@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>
Cc: robh+dt@kernel.org, =?UTF-8?B?UGF3ZcWCIE1vbGw=?= <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, ijc+devicetree@hellion.org.uk, Kumar Gala <galak@codeaurora.org>, Ulf Hansson <ulf.hansson@linaro.org>, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org, Xinwei Kong <kong.kongxinwei@hisilicon.com>

On 03/29/2016 05:23 PM, zhangfei wrote:
> 
> 
> On 03/29/2016 10:22 AM, Shawn Lin wrote:
> 
>>>
>>>
>>>
>>>         +               else if (IS_ERR(host->pdata)) {
>>>                                  dev_err(host->dev, "platform data not
>>>         available\n");
>>>                                  return -EINVAL;
>>>                          }
>>>         @@ -3012,6 +3022,9 @@ int dw_mci_probe(struct dw_mci *host)
>>>                          }
>>>                  }
>>>
>>>         +       if (host->pdata->rstc != NULL)
>>>         +               reset_control_deassert(host->pdata->rstc);
>>>         +
>>>
>>>
>>>     sorry, I can't follow your intention here. Shouldn't it be something
>>>     like "assert mmc -> may need delay -> deassert mmc". As your current
>>>     code, nothing happend right?
> Should be abstracted in reset driver.
> 
>>>
>>>
>>> The chip exits from bootloader with this bit asserted. And when entering
>>> kernel, we only need to deassert.
>>>
>>> In my current code, the driver deassert mmc in _probe(), and assert mmc
>>> in _remove().
>>
>> I catch your point. From the previous discussion, we add it to make sure
>> dw_mmc in good state after leaving bootloader to kernel. But My real
>> question is that you can assert it in  bootloader, so you can also
>> dessert it in bootloaer to make sure dw_mmc work fine when probing
>> in kernel. In that way, we don't need this patch?
> 
> uefi does not have exit point, and kernel may not assume mmc controller state is always correct when boot.
> If Uefi need copy Image from mmc, mmc controller is in working state.
> When jump to kernel, uefi mmc driver can not recover itself.
> If kernel assume mmc controller state is clean, mmc will be in abnormal state.
> Some controller will clear itself when set clock, however, hip660 does not, it need special register to access.
> 
> 
>>
>> More to think, Is it ok to match the behaviour of bootloader stage?
>> My bootloader doesn't assert the reset pin of dw_mmc, so it seams if
>> I want to fix you issue on kernel stage, I need a new round of
>> assert->delay->deassert.
> 
> The process like delay (if required) should be abstracted in reset driver.
> reset framework just export reset_control_assert/reset_control_deassert API.
> Unfortunately not find clear description in Documentation/.
> Suppose deassert is like start, while assert is like stop.

First, this patch need to resend after fixing.
Could you or Guodong resend these patches as V2 or V3?

Best Regards,
Jaehoon Chung

> 
> drivers/reset/core.c
> reset_control_deassert - deasserts the reset line
> reset_control_assert - asserts the reset line
> 
> More example:
> drivers/mmc/host/sdhci-st.c
> drivers/mmc/host/sunxi-mmc.c
> drivers/usb/host/ohci-platform.c
> drivers/i2c/busses/i2c-mv64xxx.c
> 
> Thanks
> 
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

