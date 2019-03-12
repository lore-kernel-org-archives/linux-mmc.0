From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 2/3] dt-bindings: mmc: Add a new property
 disable-cqe-dcmd.
Date: Tue, 12 Mar 2019 14:28:03 -0500
Message-ID: <20190312192803.GA19594@bogus>
References: <20190307084329.25416-1-christoph.muellner@theobroma-systems.com>
 <20190307084329.25416-2-christoph.muellner@theobroma-systems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190307084329.25416-2-christoph.muellner@theobroma-systems.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Cc: mark.rutland@arm.com, heiko@sntech.de, shawn.lin@rock-chips.com, ulf.hansson@linaro.org, adrian.hunter@intel.com, Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, Michal Simek <michal.simek@xilinx.com>, Douglas Anderson <dianders@chromium.org>, Viresh Kumar <viresh.kumar@linaro.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Vicente Bergas <vicencb@gmail.com>, Emil Renner Berthing <kernel@esmil.dk>, Randy Li <ayaka@soulik.info>, Tony Xie <tony.xie@rock-chips.com>, Ezequiel Garcia <ezequiel@collabora.com>, Klaus Goger <klaus.goger@theobroma-systems.com>, Lin Huang <hl@rock-chips.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.or
List-Id: linux-mmc@vger.kernel.org

On Thu, Mar 07, 2019 at 09:43:27AM +0100, Christoph Muellner wrote:
> This patch documents the new property disable-cqe-dcmd
> for the Arasan eMMC 5.1 driver.
> 
> Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
> Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
> ---
>  Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> index 1edbb049cccb..ec699bf98b7c 100644
> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> @@ -44,6 +44,10 @@ Optional Properties:
>      properly. Test mode can be used to force the controller to function.
>    - xlnx,int-clock-stable-broken: when present, the controller always reports
>      that the internal clock is stable even when it is not.
> +  - disable-cqe-dcmd: The eMMC 5.1 standard specifies direct commands (DCMDs)
> +    as part of the command queue engine (CQE). On controllers with a CQHCI,
> +    such as the Arasan eMMC 5.1 host controller, the driver has to enable DCMDs.
> +    This is done unless disable-cqe-dcmd is specified.

Should be common either for all controllers or all SDHCI controllers?
