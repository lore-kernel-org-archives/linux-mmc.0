From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: Re: [PATCH v2] mmc: dw_mmc: Don't start commands while busy
Date: Wed, 25 Feb 2015 19:22:39 +0100
Message-ID: <54EE12EF.20607@collabora.co.uk>
References: <1424464316-4397-1-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:52264 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752503AbbBYSWq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Feb 2015 13:22:46 -0500
In-Reply-To: <1424464316-4397-1-git-send-email-dianders@chromium.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, Sonny Rao <sonnyrao@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Addy Ke <addy.ke@rock-chips.com>, Alexandru Stan <amstan@chromium.org>, chris@printf.net, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Hello Doug,

On 02/20/2015 09:31 PM, Doug Anderson wrote:
> We've seen problems on some WiFi modules where we seem to send a CMD53
> (which requires the data lines) while the module is asserting busy.
> We shouldn't do that.
> 
> The Designware Databook says that before issuing a new data transfer
> command we should check for busy, so that's what we'll do.
> 
> We'll leverage the existing dw_mmc knowledge about whether it should
> wait for the previous command to finish to know whether we should
> check for busy before sending the command.  This means we won't end up
> incorrectly waiting for things like CMD52 (SDIO) or CMD13 (SD) which
> don't use the data line.
> 
> Note that this also has the advantage of making sure that we don't
> change the clock while the card is busy, too.
> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>
>

On an Exynos5250 Snow, Exynos5420 Peach Pit and Exynos5800 Peach Pi:

Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Best regards,
Javier
