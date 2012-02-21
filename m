From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/2] Documentation/gpio.txt: Explain expected pinctrl interaction
Date: Tue, 21 Feb 2012 11:46:03 +0100
Message-ID: <CACRpkdbPeVBv5VWefDvib5HmGF0K2gT79Mx7g-yviyQj33+Z-w@mail.gmail.com>
References: <1329719263-18971-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1329719263-18971-1-git-send-email-swarren@nvidia.com>
Sender: linux-doc-owner@vger.kernel.org
To: Stephen Warren <swarren@nvidia.com>, Grant Likely <grant.likely@secretlab.ca>
Cc: Linus Walleij <linus.walleij@stericsson.com>, Randy Dunlap <rdunlap@xenotime.net>, Olof Johansson <olof@lixom.net>, Colin Cross <ccross@android.com>, Chris Ball <cjb@laptop.org>, linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Mon, Feb 20, 2012 at 7:27 AM, Stephen Warren <swarren@nvidia.com> wrote:

> Update gpio.txt based on recent discussions regarding interaction with the
> pinctrl subsystem.
>
> Previously, gpio_request() was described as explicitly not performing any
> required mux setup operations etc.
>
> Now, gpio_request() is explicitly as explicitly performing any required mux
> setup operations where possible. In the case it isn't, platform code is
> required to have set up any required muxing or other configuration prior to
> gpio_request() being called, in order to maintain the same semantics.
>
> This is achieved by gpiolib drivers calling e.g. pinctrl_request_gpio() in
> their .request() operation.
>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Grant can you take this one? I'd prefer for you to have a look at
it as well.

Yours,
Linus Walleij
