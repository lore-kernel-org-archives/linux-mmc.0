From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 2/2] mmc: sdhci-msm: Enable delay circuit calibration
 clocks
Date: Wed, 20 Sep 2017 15:52:38 -0500
Message-ID: <20170920133051.pqmae3ggomr5bm5k@rob-hp-laptop>
References: <20170915233524.1375-1-bjorn.andersson@linaro.org>
 <20170915233524.1375-3-bjorn.andersson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170915233524.1375-3-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Mark Rutland <mark.rutland@arm.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Venkat Gopalakrishnan <venkatg@codeaurora.org>, Ritesh Harjani <riteshh@codeaurora.org>, devicetree@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Fri, Sep 15, 2017 at 04:35:24PM -0700, Bjorn Andersson wrote:
> The delay circuit used to support HS400 is calibrated based on two
> additional clocks. When these clocks are not available and
> FF_CLK_SW_RST_DIS is not set in CORE_HC_MODE, reset might fail. But on
> some platforms this doesn't work properly and below dump can be seen in
> the kernel log.
> 
>   mmc0: Reset 0x1 never completed.
>   mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
>   mmc0: sdhci: Sys addr:  0x00000000 | Version:  0x00001102
>   mmc0: sdhci: Blk size:  0x00004000 | Blk cnt:  0x00000000
>   mmc0: sdhci: Argument:  0x00000000 | Trn mode: 0x00000000
>   mmc0: sdhci: Present:   0x01f80000 | Host ctl: 0x00000000
>   mmc0: sdhci: Power:     0x00000000 | Blk gap:  0x00000000
>   mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00000002
>   mmc0: sdhci: Timeout:   0x00000000 | Int stat: 0x00000000
>   mmc0: sdhci: Int enab:  0x00000000 | Sig enab: 0x00000000
>   mmc0: sdhci: AC12 err:  0x00000000 | Slot int: 0x00000000
>   mmc0: sdhci: Caps:      0x742dc8b2 | Caps_1:   0x00008007
>   mmc0: sdhci: Cmd:       0x00000000 | Max curr: 0x00000000
>   mmc0: sdhci: Resp[0]:   0x00000000 | Resp[1]:  0x00000000
>   mmc0: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
>   mmc0: sdhci: Host ctl2: 0x00000000
>   mmc0: sdhci: ============================================
> 
> Add support for the additional calibration clocks to allow these
> platforms to be configured appropriately.
> 
> Cc: Venkat Gopalakrishnan <venkatg@codeaurora.org>
> Cc: Ritesh Harjani <riteshh@codeaurora.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changes since v1:
> - Add new clocks to DT binding
> 
>  Documentation/devicetree/bindings/mmc/sdhci-msm.txt |  2 ++

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/mmc/host/sdhci-msm.c                        | 12 +++++++++++-
>  2 files changed, 13 insertions(+), 1 deletion(-)
