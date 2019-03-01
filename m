From: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
Subject: Re: [PATCH 2/3] dt-bindings: mmc: Add a new property disable-cqe-dcmd.
Date: Fri, 1 Mar 2019 17:45:06 +0100
Message-ID: <676F71CD-2DC6-4775-BB96-FA0253DEBC5A@theobroma-systems.com>
References: <20190301164349.60589-1-christoph.muellner@theobroma-systems.com>
 <20190301164349.60589-2-christoph.muellner@theobroma-systems.com>
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190301164349.60589-2-christoph.muellner@theobroma-systems.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Cc: mark.rutland@arm.com, ulf.hansson@linaro.org, heiko@sntech.de, Viresh Kumar <viresh.kumar@linaro.org>, shawn.lin@rock-chips.com, adrian.hunter@intel.com, Tony Xie <tony.xie@rock-chips.com>, Klaus Goger <klaus.goger@theobroma-systems.com>, Michal Simek <michal.simek@xilinx.com>, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Randy Li <ayaka@soulik.info>, Vicente Bergas <vicencb@gmail.com>, robh+dt@kernel.org, Ezequiel Garcia <ezequiel@collabora.com>, linux-arm-kernel@lists.infradead.org, Lin Huang <hl@rock-chips.com>, linux-mmc@vger.kernel.org, Douglas Anderson <dianders@chromium.org>, Tomasz Figa <tfiga@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>
List-Id: linux-mmc@vger.kernel.org



> On 01.03.2019, at 17:43, Christoph Muellner <christoph.muellner@theobroma-systems.com> wrote:
> 
> This patch documents the new proprty disable-cqe-dcmd

typo: proprty -> property

> for the Arasan eMMC 5.1 driver.
> 
> Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
> Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
> ---
> Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 4 ++++
> 1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> index 1edbb049cccb..ec699bf98b7c 100644
> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> @@ -44,6 +44,10 @@ Optional Properties:
>     properly. Test mode can be used to force the controller to function.
>   - xlnx,int-clock-stable-broken: when present, the controller always reports
>     that the internal clock is stable even when it is not.
> +  - disable-cqe-dcmd: The eMMC 5.1 standard specifies direct commands (DCMDs)
> +    as part of the command queue engine (CQE). On controllers with a CQHCI,
> +    such as the Arasan eMMC 5.1 host controller, the driver has to enable DCMDs.
> +    This is done unless disable-cqe-dcmd is specified.
> 
> Example:
> 	sdhci@e0100000 {
> -- 
> 2.11.0
> 
