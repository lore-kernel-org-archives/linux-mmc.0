From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: Re: [PATCH 1/2] mmc: dw_mmc: Make sure we only adjust the clock when
 power is on
Date: Wed, 25 Feb 2015 19:25:22 +0100
Message-ID: <54EE1392.1020705@collabora.co.uk>
References: <1424458639-23330-1-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424458639-23330-1-git-send-email-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, Sonny Rao <sonnyrao@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Addy Ke <addy.ke@rock-chips.com>, Alexandru Stan <amstan@chromium.org>, chris@printf.net, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hello Doug,

On 02/20/2015 07:57 PM, Doug Anderson wrote:
> It appears that we can confuse things if we try to turn on the MMC
> clock when the power is off.  Adjust is so that we turn the clock on
> (using dw_mci_setup_bus) after power is all the way on and we turn the
> clock off before the power goes off.
> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>

On an Exynos5250 Snow, Exynos5420 Peach Pit and Exynos5800 Peach Pi:

Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Best regards,
Javier
