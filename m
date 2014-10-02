From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v5 07/11] mmc: sdio: Convert to
 dev_pm_domain_attach|detach()
Date: Wed, 1 Oct 2014 17:27:05 -0700
Message-ID: <20141002002705.GA29177@dtor-ws>
References: <1411151264-16245-1-git-send-email-ulf.hansson@linaro.org>
 <1411151264-16245-8-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1411151264-16245-8-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Chris Ball <chris@printf.net>, Russell King <linux@arm.linux.org.uk>li
List-Id: linux-mmc@vger.kernel.org

Hi Ulf,

On Fri, Sep 19, 2014 at 08:27:40PM +0200, Ulf Hansson wrote:
> Previously only the ACPI PM domain was supported by the sdio bus.
> 
> Let's convert to the common attach/detach functions for PM domains,
> which currently means we are extending the support to include the
> generic PM domain as well.
> 
> Cc: linux-mmc@vger.kernel.org
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Reviewed-by: Kevin Hilman <khilman@linaro.org>
> ---
>  drivers/mmc/core/sdio_bus.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
> index 4fa8fef9..1df0fc6 100644
> --- a/drivers/mmc/core/sdio_bus.c
> +++ b/drivers/mmc/core/sdio_bus.c
> @@ -315,7 +315,7 @@ int sdio_add_func(struct sdio_func *func)
>  	ret = device_add(&func->dev);
>  	if (ret == 0) {
>  		sdio_func_set_present(func);
> -		acpi_dev_pm_attach(&func->dev, false);
> +		dev_pm_domain_attach(&func->dev, false);

Admittedly it is not brought in by your change, but I am a bit worried
about this code. In all other busses we attach power domain to a device
before probing it (and detach if probe fails). Why here we only attach
it to power domain after adding the device to the bus? If driver for the
function has already been loaded the probe() would run without device
being attached to a power domain...

Adding Aaron as he's the author of the original change.

Thanks.

-- 
Dmitry
