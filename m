From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH RFC 0/7] Add devfreq based clock scaling support for mmc
Date: Mon, 16 Jul 2018 12:11:38 +0200
Message-ID: <CAPDyKFoe_qeHiMa0QFu7NjTRam_jU6iWYScPPWDZq8V_h-MMKQ@mail.gmail.com>
References: <1531475583-7050-1-git-send-email-sayalil@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1531475583-7050-1-git-send-email-sayalil@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sayali Lokhande <sayalil@codeaurora.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Georgi Djakov <georgi.djakov@linaro.org>, devicetree@vger.kernel.org, Asutosh Das <asutoshd@codeaurora.org>, Sahitya Tummala <stummala@codeaurora.org>, Venkat Gopalakrishnan <venkatg@codeaurora.org>, Vijay Viswanath <vviswana@codeaurora.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Harjani Ritesh <riteshh@codeaurora.org>, vbadigan@codeaurora.org
List-Id: linux-mmc@vger.kernel.org

On 13 July 2018 at 11:52, Sayali Lokhande <sayalil@codeaurora.org> wrote:
> This change adds the use of devfreq based clock scaling to MMC.
> Both eMMC and SD card can use it.
> For some workloads, such as video playback, it isn't necessary
> for these cards to run at high speed. Running at lower frequency,
> in such cases can still meet the deadlines for data transfers.
> Scaling down the clock frequency dynamically has power savings
> not only because the bus is running at lower frequency but also
> has an advantage of scaling down the system core voltage, if supported.
> Provide an ondemand clock scaling support similar to the cpufreq
> ondemand governor having two thresholds, up_threshold and
> down_threshold to decide whether to increase the frequency or
> scale it down respectively as per load.
>
> Sahitya Tummala (1):
>   devfreq: Add new flag to do simple clock scaling
>
> Sayali Lokhande (6):
>   mmc: core: devfreq: Add devfreq based clock scaling support
>   mmc: core: Add sysfs entries for dynamic control of clock scaling
>   mmc: core: add support for devfreq suspend/resume
>   mmc: sdhci-msm: Kconfig: select devfreq ondemand for sdhci-msm
>   mmc: sdhci-msm: Enable clock scaling property
>   mmc: core: Add a debugfs entry to set max clock rate
>
>  .../devicetree/bindings/mmc/sdhci-msm.txt          |  10 +
>  Documentation/mmc/mmc-dev-attrs.txt                |  38 ++
>  drivers/devfreq/governor_simpleondemand.c          |  25 +-
>  drivers/mmc/core/core.c                            | 672 +++++++++++++++++++++
>  drivers/mmc/core/core.h                            |   9 +
>  drivers/mmc/core/debugfs.c                         |  90 +++
>  drivers/mmc/core/host.c                            | 163 ++++-
>  drivers/mmc/core/mmc.c                             | 227 ++++++-
>  drivers/mmc/core/sd.c                              |  85 ++-
>  drivers/mmc/host/Kconfig                           |   2 +
>  drivers/mmc/host/sdhci-msm.c                       |  38 ++
>  drivers/mmc/host/sdhci-pltfm.c                     |  11 +
>  drivers/mmc/host/sdhci.c                           |  27 +
>  drivers/mmc/host/sdhci.h                           |   8 +
>  include/linux/devfreq.h                            |   4 +
>  include/linux/mmc/card.h                           |   5 +
>  include/linux/mmc/host.h                           |  70 +++
>  17 files changed, 1475 insertions(+), 9 deletions(-)
>
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>

Thanks for you patchse! Just wanted to let you know that I am current
in holiday mode, so I needs some more time to review this properly.
Apologize for the inconvenience.

Kind regards
Uffe
