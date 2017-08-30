From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v4 0/4] mmc: sdhci: refactor PM in sdhci-pltfm add support
 PM for cadence port
Date: Wed, 30 Aug 2017 15:13:27 +0200
Message-ID: <CAPDyKFr8RRjDwrbO5w+aOtULrc1BiUK6XGcVK0vftH_375QmxQ@mail.gmail.com>
References: <1503461703-16225-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1503461703-16225-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Barry Song <baohua@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Kevin Hao <haokexin@gmail.com>, Scott Branden <sbranden@broadcom.com>, Christian Daudt <csd@broadcom.com>, Al Cooper <alcooperx@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Hu Ziji <huziji@marvell.com>, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, Zhangfei Gao <zhangfei.gao@marvell.com>, Gregory Fong <gregory.0xf0@gmail.com>, Olof Johansson <olof@lixom.net>, Brian Norris <computersforpeace@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Piotr Sroka <piotrs@cadence.com>
List-Id: linux-mmc@vger.kernel.org

On 23 August 2017 at 06:14, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> [1] implements suspend / resume for sdhci-cadence.c
>
> [2] refactor sdhci-pxav2
>
> [3] add clk handling for suspend/resume hooks of sdhci-pltfm.
>     This also cleans up sdhci-brcmstb.c and sdhci-sirf.c
>
> [4] export sdhci_pltfm_suspend/resume to reduce code duplication
>
>
> Masahiro Yamada (4):
>   mmc: sdhci-cadence: add suspend / resume support
>   mmc: sdhci-pxav2: switch to managed clk and sdhci_pltfm_unregister()
>   mmc: sdhci: enable/disable the clock in sdhci_pltfm_suspend/resume
>   mmc: sdhci-pltfm: export sdhci_pltfm_suspend/resume
>
>  drivers/mmc/host/sdhci-brcmstb.c | 37 +----------------
>  drivers/mmc/host/sdhci-cadence.c | 88 ++++++++++++++++++++++++++++++++++++----
>  drivers/mmc/host/sdhci-pltfm.c   | 28 +++++++++++--
>  drivers/mmc/host/sdhci-pltfm.h   |  2 +
>  drivers/mmc/host/sdhci-pxav2.c   | 30 ++++----------
>  drivers/mmc/host/sdhci-sirf.c    | 39 +-----------------
>  6 files changed, 114 insertions(+), 110 deletions(-)
>

Thanks, applied for next!

Kind regards
Uffe
