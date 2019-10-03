From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 0/2] mmc: sdhci-milbeaut: add Milbeaut SD driver
Date: Thu, 3 Oct 2019 12:00:57 +0200
Message-ID: <CAPDyKFq6wbscGGq_0Q3_8eGLXk-+xBtmPbjq97jiejR7Qd_QbA@mail.gmail.com>
References: <1568079631-28808-1-git-send-email-orito.takao@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1568079631-28808-1-git-send-email-orito.takao@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Takao Orito <orito.takao@socionext.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Masami Hiramatsu <masami.hiramatsu@linaro.org>, Jaswinder Singh <jaswinder.singh@linaro.org>, sugaya.taichi@socionext.com, kasai.kazuhiro@socionext.com, kanematsu.shinji@socionext.com
List-Id: linux-mmc@vger.kernel.org

On Tue, 10 Sep 2019 at 03:39, Takao Orito <orito.takao@socionext.com> wrote:
>
> The following patches add driver for SD Host controller on
> Socionext's Milbeaut M10V platforms.
>
> SD Host controller on Milbeaut consists of two controller parts.
> One is core controller F_SDH30, this is similar to sdhci-fujitsu
> controller.
> Another is bridge controller. This bridge controller is not compatible
> with sdhci-fujitsu controller. This is special for Milbeaut series.
>
> It has the several parts,
>  - reset control
>  - clock enable / select for SDR50/25/12
>  - hold control of DATA/CMD line
>  - select characteristics for WP/CD/LED line
>  - Re-tuning control for mode3
>  - Capability setting
>    Timeout Clock / Base Clock / Timer Count for Re-Tuning /
>    Debounce period
> These requires special procedures at reset or clock enable/change or
>  further tuning of clock.
>
> Takao Orito (2):
>   dt-bindings: mmc: add DT bindings for Milbeaut SD controller
>   mmc: sdhci-milbeaut: add Milbeaut SD controller driver
>
>  .../devicetree/bindings/mmc/sdhci-milbeaut.txt     |  30 ++
>  drivers/mmc/host/Kconfig                           |  11 +
>  drivers/mmc/host/Makefile                          |   1 +
>  drivers/mmc/host/sdhci-milbeaut.c                  | 362 +++++++++++++++++++++
>  drivers/mmc/host/sdhci_f_sdh30.c                   |  26 +-
>  drivers/mmc/host/sdhci_f_sdh30.h                   |  32 ++
>  6 files changed, 437 insertions(+), 25 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-milbeaut.txt
>  create mode 100644 drivers/mmc/host/sdhci-milbeaut.c
>  create mode 100644 drivers/mmc/host/sdhci_f_sdh30.h
>
> --
> 1.9.1
>
>

Applied for next, thanks!

Kind regards
Uffe
