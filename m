From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH RFC 10/12] mmc: mmci: Add clock support for Qualcomm.
Date: Tue, 22 Apr 2014 11:03:08 +0100
Message-ID: <53563E5C.1080709@linaro.org>
References: <1398116624-31052-1-git-send-email-srinivas.kandagatla@linaro.org> <1398116945-31640-1-git-send-email-srinivas.kandagatla@linaro.org> <535599BD.1020605@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <535599BD.1020605@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-mmc@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-kernel@vger.kernel.org, agross@quicinc.com, linux-arm-msm@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Thankyou Stephen,

On 21/04/14 23:20, Stephen Boyd wrote:
> Please turn on lockdep (PROVE_LOCKING) and sleeping while atomic checks
> (DEBUG_ATOMIC_SLEEP). You cannot call clk_set_rate() in atomic context.
You are correct, there is a spinlock taken just before entering this 
code. I will fix this in next version by moving clk_set_rate out of this 
lock.

Thanks,
srini
