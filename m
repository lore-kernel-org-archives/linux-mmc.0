From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 04/15] mmc: mmci: Add support for setting pad type via pinctrl
Date: Wed, 17 Jan 2018 10:34:46 +0100
Message-ID: <CAPDyKFoVT7rqLVzYVrO8JTD_MVLxr_R8PO=fWqLVG4DB1MpnTQ@mail.gmail.com>
References: <1516105859-3525-1-git-send-email-patrice.chotard@st.com> <1516105859-3525-5-git-send-email-patrice.chotard@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1516105859-3525-5-git-send-email-patrice.chotard@st.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Patrice CHOTARD <patrice.chotard@st.com>
Cc: Russell King <linux@armlinux.org.uk>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexandre Torgue <alexandre.torgue@st.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-clk <linux-clk@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, Andrea Merello <andrea.merello@gmail.com>
List-Id: linux-mmc@vger.kernel.org

[...]

>         /*
> @@ -1616,6 +1625,32 @@ static int mmci_probe(struct amba_device *dev,
>         host = mmc_priv(mmc);
>         host->mmc = mmc;
>
> +       /*
> +        * Some variant (STM32) doesn't have opendrain bit, nevertheless
> +        * pins can be set accordingly using pinctrl
> +        */
> +       if (!variant->opendrain) {
> +               host->pinctrl = devm_pinctrl_get(&dev->dev);
> +               if (IS_ERR(host->pinctrl)) {
> +                       dev_err(&dev->dev, "failed to get pinctrl");
> +                       goto host_free;
> +               }
> +
> +               host->pins_default = pinctrl_lookup_state(host->pinctrl,
> +                                                         PINCTRL_STATE_DEFAULT);
> +               if (IS_ERR(host->pins_default)) {
> +                       dev_warn(mmc_dev(mmc), "Can't select default pins\n");
> +                       host->pins_default = NULL;

This is wrong, I think you should bail out and return the error code instead.

Moreover, calling pinctrl_select_state() from ->set_ios by using a
NULL state, will likely trigger a NULL pointer deference bug in the
pinctrl layer.

> +               }
> +
> +               host->pins_opendrain = pinctrl_lookup_state(host->pinctrl,
> +                                                           MMCI_PINCTRL_STATE_OPENDRAIN);
> +               if (IS_ERR(host->pins_opendrain)) {
> +                       dev_warn(mmc_dev(mmc), "Can't select opendrain pins\n");
> +                       host->pins_opendrain = NULL;

Ditto.

> +               }
> +       }
> +

[...]

Kind regards
Uffe
