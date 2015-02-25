From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: Re: [PATCH 1/2] mmc: dw_mmc: Only enable CD after setup and only
 if needed
Date: Wed, 25 Feb 2015 19:52:25 +0100
Message-ID: <54EE19E9.9090501@collabora.co.uk>
References: <1424887912-20015-1-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:52347 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752739AbbBYSwc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Feb 2015 13:52:32 -0500
In-Reply-To: <1424887912-20015-1-git-send-email-dianders@chromium.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, Sonny Rao <sonnyrao@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Addy Ke <addy.ke@rock-chips.com>, Alexandru Stan <amstan@chromium.org>, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, chris@printf.net, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Hello Doug,

On 02/25/2015 07:11 PM, Doug Anderson wrote:
> We really don't want to get a card detect interrupt during probe time
> since it can confuse things.  Let's disable the card detect interrupt
> until we're in a really good place: the end of probe.  Let's also
> simply avoid enabling the card detect interrupt if it's not used.
> 
> It appears that (at least on rk3288) when vqmmc is turned on it can
> cause a bogus "card detect" interrupt.  That meant that we were
> getting a predictable card detect interrupt while we were in
> mmc_add_host().  On the version of the kernel I'm working with at
> least (3.14), this is not a great time to get a card detect interrupt
> since I think that we don't grab all the needed locks in
> mmc_add_host() and children.  I put stack dumps in dw_mci_setup_bus()
> and found that I could see two distinct stack crawls that looked like:
> 
> Caller one:
> * dw_mci_setup_bus
> * dw_mci_set_ios
> * mmc_power_up
> * mmc_start_host
> * mmc_add_host
> 
> Caller two:
> * dw_mci_setup_bus
> * dw_mci_set_ios
> * mmc_set_chip_select
> * mmc_go_idle
> * mmc_rescan
> * process_one_work
> * worker_thread
> * kthread
> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>
>

On an Exynos5250 Snow, Exynos5420 Peach Pit and Exynos5800 Peach Pi:

Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Best regards,
Javier

