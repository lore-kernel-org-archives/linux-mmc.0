From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V11 1/4] dt-bindings: mmc: Add supports-cqe property
Date: Thu, 31 Jan 2019 08:27:53 +0100
Message-ID: <CAPDyKFoX7o8pR7hpVPpnpUDmM4jqdjrg7WKj1zrJ1uXfXoSDTA@mail.gmail.com>
References: <1548271854-1765-1-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1548271854-1765-1-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sowjanya Komatineni <skomatineni@nvidia.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mikko Perttunen <mperttunen@nvidia.com>, Chunyan Zhang <chunyan.zhang@unisoc.com>, Thierry Reding <thierry.reding@gmail.com>, Jon Hunter <jonathanh@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, anrao@nvidia.com, DTML <devicetree@vger.kernel.org>, linux-tegra@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, 23 Jan 2019 at 20:30, Sowjanya Komatineni
<skomatineni@nvidia.com> wrote:
>
> Add supports-cqe optional property for MMC hosts.
>
> This property is used to identify the specific host controller
> supporting command queue.
>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> Reviewed-by: Thierry Reding <treding@nvidia.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  [V11]: Same as V10
>  [V10]: This patch version moves supports-cqe property from vendor
>         specific MMC property to common MMC property.
>
>  Documentation/devicetree/bindings/mmc/mmc.txt | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
> index f5a0923b34ca..cdbcfd3a4ff2 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/mmc.txt
> @@ -62,6 +62,8 @@ Optional properties:
>    be referred to mmc-pwrseq-simple.txt. But now it's reused as a tunable delay
>    waiting for I/O signalling and card power supply to be stable, regardless of
>    whether pwrseq-simple is used. Default to 10ms if no available.
> +- supports-cqe : The presence of this property indicates that the corresponding
> +  MMC host controller supports HW command queue feature.
>
>  *NOTE* on CD and WP polarity. To use common for all SD/MMC host controllers line
>  polarity properties, we have to fix the meaning of the "normal" and "inverted"
> --
> 2.7.4
>
