From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/2] gpio: tegra: Delete tegra_gpio_enable/disable()
Date: Tue, 21 Feb 2012 11:44:35 +0100
Message-ID: <CACRpkdYDVU9TAVAAw=uBp84puED0kGkdSW8goAJRG1Nc=6xCaQ@mail.gmail.com>
References: <1329719263-18971-1-git-send-email-swarren@nvidia.com>
	<1329719263-18971-2-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1329719263-18971-2-git-send-email-swarren@nvidia.com>
Sender: linux-doc-owner@vger.kernel.org
To: Stephen Warren <swarren@nvidia.com>, Olof Johansson <olof@lixom.net>
Cc: Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@stericsson.com>, Randy Dunlap <rdunlap@xenotime.net>, Colin Cross <ccross@android.com>, Chris Ball <cjb@laptop.org>, linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Mon, Feb 20, 2012 at 7:27 AM, Stephen Warren <swarren@nvidia.com> wrote:

> Recent pinctrl discussions concluded that gpio_request() and other gpiolib
> APIs should in fact do whatever is required to mux a GPIO onto pins, by
> calling pinctrl APIs if required. This change implements this for the
> Tegra GPIO driver, and removes the old Tegra-specific APIs which did this.
>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> I don't believe this depends on other patches.
>
> There may be some slight context dependencies; this patch was generated
> against next-20120217, with my recently posted "gpio: tegra: Fix build
> issue due to irq_domain rework." applied on top.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Since it mainly touches mach-tegra stuff I think it's best to take
this through the Tegra tree, Olof can you queue it?

Yours,
Linus Walleij
