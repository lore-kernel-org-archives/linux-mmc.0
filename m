From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 1/3] dt-bindings: mmc: Add disable-cqe-dcmd property.
Date: Mon, 25 Mar 2019 14:27:12 +0100
Message-ID: <CAPDyKFqd8LOi=MN9rCKUwgkTxEjikmq3+B1SWGF8z1ykeMfoyg@mail.gmail.com>
References: <20190322113808.16858-1-christoph.muellner@theobroma-systems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190322113808.16858-1-christoph.muellner@theobroma-systems.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Heiko Stuebner <heiko@sntech.de>, Shawn Lin <shawn.lin@rock-chips.com>, Adrian Hunter <adrian.hunter@intel.com>, Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, Michal Simek <michal.simek@xilinx.com>, Viresh Kumar <viresh.kumar@linaro.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Matthias Brugger <matthias.bgg@gmail.com>, Douglas Anderson <dianders@chromium.org>, Klaus Goger <klaus.goger@theobroma-systems.com>, Lin Huang <hl@rock-chips.com>, Randy Li <ayaka@soulik.info>, Tony Xie <tony.xie@rock-chips.com>, Vicente Bergas <vicencb@gmail.com>, Ezequiel Garcia <ezequiel@collabora.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, DTML <devicetree@v>
List-Id: linux-mmc@vger.kernel.org

On Fri, 22 Mar 2019 at 12:39, Christoph Muellner
<christoph.muellner@theobroma-systems.com> wrote:
>
> Add disable-cqe-dcmd as optional property for MMC hosts.
> This property allows to disable or not enable the direct command
> features of the command queue engine.
>
> Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
> Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/mmc.txt | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
> index cdbcfd3a4ff2..c269dbe384fe 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/mmc.txt
> @@ -64,6 +64,8 @@ Optional properties:
>    whether pwrseq-simple is used. Default to 10ms if no available.
>  - supports-cqe : The presence of this property indicates that the corresponding
>    MMC host controller supports HW command queue feature.
> +- disable-cqe-dcmd: This property indicates that the MMC controller's command
> +  queue engine (CQE) does not support direct commands (DCMDs).
>
>  *NOTE* on CD and WP polarity. To use common for all SD/MMC host controllers line
>  polarity properties, we have to fix the meaning of the "normal" and "inverted"
> --
> 2.11.0
>
