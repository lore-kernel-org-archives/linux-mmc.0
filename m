From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/3] Optimize voltage switch for the SD controller
Date: Mon, 8 Jul 2019 13:55:40 +0200
Message-ID: <CAPDyKFqQmYpP7i5gG8D0hVaE=UhK4+9zs3jgMxfyOLw0vjqM8Q@mail.gmail.com>
References: <cover.1561094029.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1561094029.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Chunyan Zhang <zhang.lyra@gmail.com>, Orson Zhai <orsonzhai@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, 21 Jun 2019 at 08:12, Baolin Wang <baolin.wang@linaro.org> wrote:
>
> This patch set is used to optimize voltage switch for the
> Spreadtrum SD host controller.
>
> Any comments are welcome. Thanks.
>
> Baolin Wang (3):
>   mmc: sdhci-sprd: Add start_signal_voltage_switch ops
>   dt-bindings: mmc: sprd: Add pinctrl support
>   mmc: sdhci-sprd: Add pin control support for voltage switch
>
>  .../devicetree/bindings/mmc/sdhci-sprd.txt         |    7 ++
>  drivers/mmc/host/sdhci-sprd.c                      |   78 ++++++++++++++++++++
>  2 files changed, 85 insertions(+)
>
> --
> 1.7.9.5
>

Applied for next, thanks!

Kind regards
Uffe
