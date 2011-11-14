From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH V3] mmc: core: Use delayed work in clock gating framework
Date: Mon, 14 Nov 2011 08:15:13 -0500
Message-ID: <87ehxaluam.fsf@laptop.org>
References: <1321259009-22626-1-git-send-email-sthumma@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:45918 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754404Ab1KNNPM (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 14 Nov 2011 08:15:12 -0500
In-Reply-To: <1321259009-22626-1-git-send-email-sthumma@codeaurora.org> (Sujit
	Reddy Thumma's message of "Mon, 14 Nov 2011 13:53:29 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sujit Reddy Thumma <sthumma@codeaurora.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org

Hi Sujit,

On Mon, Nov 14 2011, Sujit Reddy Thumma wrote:
> Current clock gating framework disables the MCI clock as soon as the
> request is completed and enables it when a request arrives. This aggressive
> clock gating framework, when enabled, cause following issues:
>
> When there are back-to-back requests from the Queue layer, we unnecessarily
> end up disabling and enabling the clocks between these requests since 8MCLK
> clock cycles is a very short duration compared to the time delay between
> back to back requests reaching the MMC layer. This overhead can effect the
> overall performance depending on how long the clock enable and disable
> calls take which is platform dependent. For example on some platforms we
> can have clock control not on the local processor, but on a different
> subsystem and the time taken to perform the clock enable/disable can add
> significant overhead.
>
> Also if the host controller driver decides to disable the host clock too
> when mmc_set_ios function is called with ios.clock=0, it adds additional
> delay and it is highly possible that the next request had already arrived
> and unnecessarily blocked in enabling the clocks. This is seen frequently
> when the processor is executing at high speeds and in multi-core platforms
> thus reduces the overall throughput compared to if clock gating is
> disabled.
>
> Fix this by delaying turning off the clocks by posting request on
> delayed workqueue. Also cancel the unscheduled pending work, if any,
> when there is access to card.
>
> sysfs entry is provided to tune the delay as needed, default
> value set to 200ms.
>
> Signed-off-by: Sujit Reddy Thumma <sthumma@codeaurora.org>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

error: patch failed: drivers/mmc/core/host.c:53
error: drivers/mmc/core/host.c: patch does not apply
error: patch failed: include/linux/mmc/host.h:253
error: include/linux/mmc/host.h: patch does not apply

Please could you resend against current mmc-next?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
