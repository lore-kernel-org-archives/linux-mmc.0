From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH V2] mmc: core: Use delayed work in clock gating framework
Date: Fri, 11 Nov 2011 20:00:04 -0500
Message-ID: <87d3cyjgtn.fsf@laptop.org>
References: <1319699643-30700-1-git-send-email-sthumma@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1319699643-30700-1-git-send-email-sthumma@codeaurora.org> (Sujit
	Reddy Thumma's message of "Thu, 27 Oct 2011 12:44:03 +0530")
Sender: linux-arm-msm-owner@vger.kernel.org
To: Sujit Reddy Thumma <sthumma@codeaurora.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Sujit,

On Thu, Oct 27 2011, Sujit Reddy Thumma wrote:
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

Looks good, but please add documentation for the new sysfs node in
Documentation/mmc/mmc-dev-attrs.txt.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
