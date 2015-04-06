From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 1/3] mmc: dw_mmc: Increase cmd11 timeout to 500ms
Date: Mon, 06 Apr 2015 19:46:41 +0900
Message-ID: <55226411.2060806@samsung.com>
References: <1428084787-8710-1-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:61793 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752654AbbDFKqn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Apr 2015 06:46:43 -0400
In-reply-to: <1428084787-8710-1-git-send-email-dianders@chromium.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, Sonny Rao <sonnyrao@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Addy Ke <addy.ke@rock-chips.com>, Alexandru Stan <amstan@chromium.org>, javier.martinez@collabora.co.uk, linux-rockchip@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Hi, Doug.

On 04/04/2015 03:13 AM, Doug Anderson wrote:
> The Designware databook claims that cmd11 should be finished in 2ms,
> but my testing showed that not to be the case in some situations.
> I've seen cmd11 timeouts of up to 130ms (!) during reboot tests.
> Let's bump the timeout way up so that we're absolutely sure.  CMD11 is
> only sent during card insertion, so this extra timeout shouldn't be
> terrible.

Is it h/w problem? Could you explain to me about "some situations"?
As you said, this timeout only used during card inserting. So, it's not critical..
But there is much different between 2ms and 500ms(or 130ms).

Best Regards,
Jaehoon Chung

> 
> Fixes: 5c935165da79 ("mmc: dw_mmc: Add a timeout for sending CMD11")
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> ---
>  drivers/mmc/host/dw_mmc.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 3883fe6..339a929 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1023,11 +1023,13 @@ static void __dw_mci_start_request(struct dw_mci *host,
>  
>  	if (cmd->opcode == SD_SWITCH_VOLTAGE) {
>  		/*
> -		 * Databook says to fail after 2ms w/ no response; give an
> -		 * extra jiffy just in case we're about to roll over.
> +		 * Databook says to fail after 2ms w/ no response, but evidence
> +		 * shows that sometimes the cmd11 interrupt takes over 130ms.
> +		 * We'll set to 500ms, plus an extra jiffy just in case jiffies
> +		 * is just about to roll over.
>  		 */
>  		mod_timer(&host->cmd11_timer,
> -			  jiffies + msecs_to_jiffies(2) + 1);
> +			  jiffies + msecs_to_jiffies(500) + 1);
>  	}
>  
>  	if (mrq->stop)
> 

