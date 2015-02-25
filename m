From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: Re: [PATCH 2/2] mmc: dw_mmc: Don't crash if we get an interrupt before
 slot has initted
Date: Wed, 25 Feb 2015 19:52:41 +0100
Message-ID: <54EE19F9.6020302@collabora.co.uk>
References: <1424887912-20015-1-git-send-email-dianders@chromium.org> <1424887912-20015-2-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424887912-20015-2-git-send-email-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, Sonny Rao <sonnyrao@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Addy Ke <addy.ke@rock-chips.com>, Alexandru Stan <amstan@chromium.org>, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, chris@printf.net, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hello Doug,

On 02/25/2015 07:11 PM, Doug Anderson wrote:
> It's unlikely that this is really needed on any single-slot systems
> where we disable card detects until the end of probe, but it still
> seems safer to check to make sure that a slot has been initted before
> we try to dereference it to find the SDIO interrupt mask.
> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>

On an Exynos5250 Snow, Exynos5420 Peach Pit and Exynos5800 Peach Pi:

Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Best regards,
Javier
