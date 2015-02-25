From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: Re: [PATCH 2/2] mmc: dw_mmc: Give a good reset after we give power
Date: Wed, 25 Feb 2015 19:26:19 +0100
Message-ID: <54EE13CB.5040401@collabora.co.uk>
References: <1424458639-23330-1-git-send-email-dianders@chromium.org> <1424458639-23330-2-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424458639-23330-2-git-send-email-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, Sonny Rao <sonnyrao@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Addy Ke <addy.ke@rock-chips.com>, Alexandru Stan <amstan@chromium.org>, chris@printf.net, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hello Doug,

On 02/20/2015 07:57 PM, Doug Anderson wrote:
> We should give dw_mmc a good reset after we apply power.  On some
> boards vqmmc may actually be connected to the IP block in the SoC so
> it's good to reset after power comes in.
> 
> Without this we sometimes see failures enumerating cards on rk3288.
> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>

On an Exynos5250 Snow, Exynos5420 Peach Pit and Exynos5800 Peach Pi:

Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Best regards,
Javier
