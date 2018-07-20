From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH RFC 2/7] mmc: core: devfreq: Add devfreq based clock
 scaling support
Date: Fri, 20 Jul 2018 09:24:36 -0600
Message-ID: <20180720152436.GA4566@rob-hp-laptop>
References: <1531475583-7050-1-git-send-email-sayalil@codeaurora.org>
 <1531475583-7050-3-git-send-email-sayalil@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1531475583-7050-3-git-send-email-sayalil@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sayali Lokhande <sayalil@codeaurora.org>
Cc: adrian.hunter@intel.com, ulf.hansson@linaro.org, mark.rutland@arm.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, devicetree@vger.kernel.org, asutoshd@codeaurora.org, stummala@codeaurora.org, venkatg@codeaurora.org, vviswana@codeaurora.org, bjorn.andersson@linaro.org, riteshh@codeaurora.org, vbadigan@codeaurora.org, Talel Shenhar <tatias@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, Jul 13, 2018 at 03:22:58PM +0530, Sayali Lokhande wrote:
> This change adds the use of devfreq to MMC.
> Both eMMC and SD card will use it.
> For some workloads, such as video playback, it isn't
> necessary for these cards to run at high speed.
> Running at lower frequency, for example 52MHz, in such
> cases can still meet the deadlines for data transfers.
> Scaling down the clock frequency dynamically has power
> savings not only because the bus is running at lower frequency
> but also has an advantage of scaling down the system core
> voltage, if supported.
> Provide an ondemand clock scaling support similar to the
> cpufreq ondemand governor having two thresholds,
> up_threshold and down_threshold to decide whether to
> increase the frequency or scale it down respectively.
> The sampling interval is in the order of milliseconds.
> If sampling interval is too low, frequent switching of
> frequencies can lead to high power consumption and if
> sampling interval is too high, the clock scaling logic
> would take long time to realize that the underlying
> hardware (controller and card) is busy and scale up
> the clocks.
> 
> Signed-off-by: Talel Shenhar <tatias@codeaurora.org>
> Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
> ---
>  .../devicetree/bindings/mmc/sdhci-msm.txt          |  10 +
>  drivers/mmc/core/core.c                            | 560 +++++++++++++++++++++
>  drivers/mmc/core/core.h                            |   7 +
>  drivers/mmc/core/debugfs.c                         |  46 ++
>  drivers/mmc/core/host.c                            |   8 +
>  drivers/mmc/core/mmc.c                             | 200 +++++++-
>  drivers/mmc/core/sd.c                              |  72 ++-
>  drivers/mmc/host/sdhci-msm.c                       |  37 ++
>  drivers/mmc/host/sdhci-pltfm.c                     |  11 +
>  drivers/mmc/host/sdhci.c                           |  27 +
>  drivers/mmc/host/sdhci.h                           |   8 +
>  include/linux/mmc/card.h                           |   5 +
>  include/linux/mmc/host.h                           |  70 +++
>  13 files changed, 1059 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> index 502b3b8..bd8470a 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> @@ -26,6 +26,15 @@ Required properties:
>  	"cal"	- reference clock for RCLK delay calibration (optional)
>  	"sleep"	- sleep clock for RCLK delay calibration (optional)
>  
> +Optional Properties:
> +- qcom,devfreq,freq-table - specifies supported frequencies for clock scaling.
> +				    Clock scaling logic shall toggle between these frequencies based
> +				    on card load. In case the defined frequencies are over or below
> +				    the supported card frequencies, they will be overridden
> +				    during card init. In case this entry is not supplied,
> +				    the driver will construct one based on the card
> +				    supported max and min frequencies.
> +				    The frequencies must be ordered from lowest to highest.

This should be a common binding in which case will just a list of 
frequencies be sufficient.

Rob
