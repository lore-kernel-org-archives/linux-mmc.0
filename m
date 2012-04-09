From: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 07/11] gpio: tegra: Hide tegra_gpio_enable/disable()
Date: Sun, 08 Apr 2012 21:09:08 -0400
Message-ID: <87mx6l1zkb.fsf@laptop.org>
References: <1333148404-17691-1-git-send-email-swarren@wwwdotorg.org>
	<1333148404-17691-8-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1333148404-17691-8-git-send-email-swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
	(Stephen Warren's message of "Fri, 30 Mar 2012 17:00:00 -0600")
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On Fri, Mar 30 2012, Stephen Warren wrote:
> From: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>
> Recent pinctrl discussions concluded that gpiolib APIs should in fact do
> whatever is required to mux a GPIO onto pins, by calling pinctrl APIs if
> required. This change implements this for the Tegra GPIO driver, and removes
> calls to the Tegra-specific APIs from drivers and board files.
>
> Cc: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
> Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Signed-off-by: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
> v2: Adjusted per changes to latest version of Documentation/gpio.txt.
> Fixed tegra_board_pinmux_bus_notify() to still check the device name,
> so it waits for the pinmux device to be registered, not just /any/ device.
> ---
>  arch/arm/mach-tegra/board-dt-tegra20.c        |    1 -
>  arch/arm/mach-tegra/board-harmony-pinmux.c    |   17 -----------
>  arch/arm/mach-tegra/board-paz00-pinmux.c      |   14 ---------
>  arch/arm/mach-tegra/board-pinmux.c            |   33 +++--------------------
>  arch/arm/mach-tegra/board-pinmux.h            |    5 ---
>  arch/arm/mach-tegra/board-seaboard-pinmux.c   |   32 ----------------------
>  arch/arm/mach-tegra/board-seaboard.c          |    1 -
>  arch/arm/mach-tegra/board-trimslice-pinmux.c  |   12 --------
>  arch/arm/mach-tegra/include/mach/gpio-tegra.h |    9 ------
>  arch/arm/mach-tegra/usb_phy.c                 |    1 -
>  drivers/gpio/gpio-tegra.c                     |   36 ++++++++++++------------
>  drivers/mmc/host/sdhci-tegra.c                |   24 +++-------------
>  12 files changed, 27 insertions(+), 158 deletions(-)

For the MMC change:

Acked-by: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>

- Chris.
-- 
Chris Ball   <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>   <http://printf.net/>
One Laptop Per Child
