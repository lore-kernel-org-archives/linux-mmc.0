From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH 2/4] mmc: mmc: Add change to set controller to HS400
 frequency in enhanced strobe
Date: Tue, 20 Dec 2016 15:29:55 +0800
Message-ID: <5a9ad9e8-6fc5-1a33-6119-7c411df4b6e0@rock-chips.com>
References: <1482213199-29152-1-git-send-email-riteshh@codeaurora.org>
 <1482213199-29152-3-git-send-email-riteshh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1482213199-29152-3-git-send-email-riteshh@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ritesh Harjani <riteshh@codeaurora.org>, ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc: shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, stummala@codeaurora.org, georgi.djakov@linaro.org, linux-arm-msm@vger.kernel.org, pramod.gurav@linaro.org, jeremymc@redhat.com, venkatg@codeaurora.org, asutoshd@codeaurora.org
List-Id: linux-mmc@vger.kernel.org

On 2016/12/20 13:53, Ritesh Harjani wrote:
> Currently mmc_select_hs400es is not setting the desired frequency
> before sending switch command. This makes CMD13 to timeout on
> some controllers.
> Thus add a change to set the desired HS400 frequency
> in mmc_select_hs400es when the timing is switched to HS400.

What is the desired HS400 freq? I guess it is 200MHz, right?

Well, per the spec, it just say "host *may* changes frequency to
<= 200Mhz". So before setting timing to MMC_TIMING_MMC_HS400, we
already reach ext_csd.hs_max_dtr. So it should meet the spec. If
the fact that some controllers would see CMD13 timeout here, I guess
you wouldn't let folks add max-frequency to the DT as if the max freq
is set to just lower than your *desired HS400 freq* , it the same
failure result even you add this patch, right?

the root cause the controllers see failure for CMD13 is it didn't
configure the right delay phase or something similar to fit the timing
under the freq of hs_max_dtr, I guess.

>
> Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
> ---
>  drivers/mmc/core/mmc.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index b61b52f9..eb69497 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1329,6 +1329,7 @@ static int mmc_select_hs400es(struct mmc_card *card)
>
>  	/* Set host controller to HS400 timing and frequency */
>  	mmc_set_timing(host, MMC_TIMING_MMC_HS400);
> +	mmc_set_bus_speed(card);
>
>  	/* Controller enable enhanced strobe function */
>  	host->ios.enhanced_strobe = true;
>


-- 
Best Regards
Shawn Lin
