From: Sujit Reddy Thumma <sthumma@codeaurora.org>
Subject: Re: [PATCH V3] mmc: core: Use delayed work in clock gating framework
Date: Tue, 15 Nov 2011 10:42:46 +0530
Message-ID: <4EC1F4CE.90706@codeaurora.org>
References: <1321259009-22626-1-git-send-email-sthumma@codeaurora.org> <87ehxaluam.fsf@laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:45302 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811Ab1KOFMu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Nov 2011 00:12:50 -0500
In-Reply-To: <87ehxaluam.fsf@laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org

Hi Chris,

On 11/14/2011 6:45 PM, Chris Ball wrote:
> Hi Sujit,
>
> On Mon, Nov 14 2011, Sujit Reddy Thumma wrote:
>> Current clock gating framework disables the MCI clock as soon as the
>> request is completed and enables it when a request arrives. This aggressive
>> clock gating framework, when enabled, cause following issues:
>>
>> When there are back-to-back requests from the Queue layer, we unnecessarily
>> end up disabling and enabling the clocks between these requests since 8MCLK
>> clock cycles is a very short duration compared to the time delay between
>> back to back requests reaching the MMC layer. This overhead can effect the
>> overall performance depending on how long the clock enable and disable
>> calls take which is platform dependent. For example on some platforms we
>> can have clock control not on the local processor, but on a different
>> subsystem and the time taken to perform the clock enable/disable can add
>> significant overhead.
>>
>> Also if the host controller driver decides to disable the host clock too
>> when mmc_set_ios function is called with ios.clock=0, it adds additional
>> delay and it is highly possible that the next request had already arrived
>> and unnecessarily blocked in enabling the clocks. This is seen frequently
>> when the processor is executing at high speeds and in multi-core platforms
>> thus reduces the overall throughput compared to if clock gating is
>> disabled.
>>
>> Fix this by delaying turning off the clocks by posting request on
>> delayed workqueue. Also cancel the unscheduled pending work, if any,
>> when there is access to card.
>>
>> sysfs entry is provided to tune the delay as needed, default
>> value set to 200ms.
>>
>> Signed-off-by: Sujit Reddy Thumma<sthumma@codeaurora.org>
>> Acked-by: Linus Walleij<linus.walleij@linaro.org>
>
> error: patch failed: drivers/mmc/core/host.c:53
> error: drivers/mmc/core/host.c: patch does not apply
> error: patch failed: include/linux/mmc/host.h:253
> error: include/linux/mmc/host.h: patch does not apply
>
> Please could you resend against current mmc-next?

I see that the patch is already applied on mmc-next, hence the conflicts.

http://git.kernel.org/?p=linux/kernel/git/cjb/mmc.git;a=commit;h=0987075c3c285ba92f93464f7a882515d4a054d1

Can we rebase the tree and apply V3?

>
> Thanks,
>
> - Chris.


-- 
Thanks,
Sujit
