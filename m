From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2] mmc: sdhci-milbeaut: add Milbeaut SD controller driver
Date: Mon, 29 Apr 2019 12:31:57 +0200
Message-ID: <CAPDyKFrBJeBNOPh9H3Yn-6-um2B-9Gt6_pW8Qh0ZGQB26-tq+Q@mail.gmail.com>
References: <1556244405-15863-1-git-send-email-orito.takao@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1556244405-15863-1-git-send-email-orito.takao@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Takao Orito <orito.takao@socionext.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Masami Hiramatsu <masami.hiramatsu@linaro.org>, Jaswinder Singh <jaswinder.singh@linaro.org>, sugaya.taichi@socionext.com, kasai.kazuhiro@socionext.com, kanematsu.shinji@socionext.com
List-Id: linux-mmc@vger.kernel.org

[...]

> +
> +static void sdhci_milbeaut_power_off(struct sdhci_host *host)
> +{
> +       struct f_sdhost_priv *priv = sdhci_priv(host);
> +
> +       gpiod_set_value(priv->power_gpio, 0);
> +       udelay(1000);
> +}
> +
> +static void sdhci_milbeaut_power_on(struct sdhci_host *host)
> +{
> +       struct f_sdhost_priv *priv = sdhci_priv(host);
> +
> +       gpiod_set_value(priv->power_gpio, 1);
> +}
> +

As stated for the DT doc patch, please use a fixed GPIO regulator
instead. In this way you will also get a the OCR mask based upon the
GPIO regulator, which is parsed out by the mmc core when sdhci calls
mmc_regulator_get_supply().

Otherwise, this looks good to me.

[...]

Kind regards
Uffe
