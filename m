From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 2/3] mmc: sunxi: Fix DDR MMC timings for A80
Date: Mon, 30 May 2016 13:34:42 +0200
Message-ID: <99d78ff3-db4d-45cc-024a-d94583b56f35@redhat.com>
References: <1464505484-3661-1-git-send-email-wens@csie.org>
 <1464505484-3661-3-git-send-email-wens@csie.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464505484-3661-3-git-send-email-wens@csie.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>, Ulf Hansson <ulf.hansson@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On 29-05-16 09:04, Chen-Yu Tsai wrote:
> The MMC clock timings were incorrectly calculated, when the conversion
> from delay value to delay phase was done.
>
> The 50M DDR and 50M DDR 8bit timings are off, and make eMMC DDR
> unusable. Unfortunately it seems different controllers on the same SoC
> have different timings. The new settings are taken from mmc2, which is
> commonly used with eMMC.

Hmm, I'm not really all that familiar with mmc, but can't an external
sdcard connected to mmc0 use DDR too ? Assuming the answer is yes, then
we really need to update the driver to use the right per controller
timings.

> The settings for the slower timing modes seem to work despite being
> wrong, so leave them be.

If you're sure the timings are wrong, please fix them. Sometimes wrong
timings do seem to work, but lead to unreliable communication, or turn
out to work on some boards and not on others due to routing differences.

Thanks & Regards,

Hans


>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  drivers/mmc/host/sunxi-mmc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index 7fc8b7aa83f0..5873dc344ab2 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -970,8 +970,8 @@ static const struct sunxi_mmc_clk_delay sun9i_mmc_clk_delays[] = {
>  	[SDXC_CLK_400K]		= { .output = 180, .sample = 180 },
>  	[SDXC_CLK_25M]		= { .output = 180, .sample =  75 },
>  	[SDXC_CLK_50M]		= { .output = 150, .sample = 120 },
> -	[SDXC_CLK_50M_DDR]	= { .output =  90, .sample = 120 },
> -	[SDXC_CLK_50M_DDR_8BIT]	= { .output =  90, .sample = 120 },
> +	[SDXC_CLK_50M_DDR]	= { .output =  54, .sample =  36 },
> +	[SDXC_CLK_50M_DDR_8BIT]	= { .output =  72, .sample =  72 },
>  };
>
>  static int sunxi_mmc_resource_request(struct sunxi_mmc_host *host,
>
