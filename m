From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 01/12] mmc: mediatek: add support of mt2701/mt2712
Date: Tue, 10 Oct 2017 09:26:03 +0200
Message-ID: <CAPDyKFrqv5tt8Exq1msUBbMEROam2c+YnStazsf5SPj-NLrGSg@mail.gmail.com>
References: <1507604480-23246-1-git-send-email-chaotian.jing@mediatek.com> <1507604480-23246-2-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1507604480-23246-2-git-send-email-chaotian.jing@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chaotian Jing <chaotian.jing@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, yong mao <yong.mao@mediatek.com>, Linus Walleij <linus.walleij@linaro.org>, Heiner Kallweit <hkallweit1@gmail.com>, Phong LE <ple@baylibre.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mediatek@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, srv_heupstream <srv_heupstream@mediatek.com>
List-Id: linux-mmc@vger.kernel.org

[...]

> +
> +static const struct of_device_id msdc_of_ids[] = {
> +       { .compatible = "mediatek,mt8135-mmc", .data = &mt8135_compat},
> +       { .compatible = "mediatek,mt8173-mmc", .data = &mt8173_compat},
> +       { .compatible = "mediatek,mt2701-mmc", .data = &mt2701_compat},
> +       { .compatible = "mediatek,mt2712-mmc", .data = &mt2712_compat},
> +       {}
> +};
> +MODULE_DEVICE_TABLE(of, msdc_of_ids);

As already stated in the other reply. These new compatible changes
needs to be discussed and acked before the driver starts using them.

In other words, make patch3 to precede this one.

[...]

Kind regards
Uffe
