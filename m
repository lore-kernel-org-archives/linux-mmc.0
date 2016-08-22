From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/1] mmc: core: Add the vmmc/vmmcq regulator info
Date: Mon, 22 Aug 2016 15:39:21 +0200
Message-ID: <CAPDyKFpiariD2+fMUmVH+nMff2hDpxY6eE0zN50nadw1pHA7ag@mail.gmail.com>
References: <1470043331-5123-1-git-send-email-ben.dooks@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1470043331-5123-1-git-send-email-ben.dooks@codethink.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: Rob Herring <robh+dt@kernel.org>, =?UTF-8?Q?Pawe=C5=82_Moll?= <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Kumar Gala <galak@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-kernel@lists.codethink.co.uk, linux-mmc <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 1 August 2016 at 11:22, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> The core MMC code adds two (optional) regulator properites that drivers
> should use to get their supplies. This is not documented anywhere so add
> information on it.
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  Documentation/devicetree/bindings/mmc/mmc.txt | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
> index ed23b9b..8cbcbce 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/mmc.txt
> @@ -71,6 +71,17 @@ Optional SDIO properties:
>  - wakeup-source: Enables wake up of host system on SDIO IRQ assertion
>                  (Legacy property supported: "enable-sdio-wakeup")
>
> +MMC power
> +---------
> +
> +Controllers may implement power control from both the connected cards and
> +the IO signaling (for example to change to high-speed 1.8V signalling). If
> +the system supports this, then the following two properties should point
> +to valid regulator nodes:
> +
> +- vqmmc-supply: supply node for IO line power
> +- vmmc-supply: supply node for card's power
> +
>
>  MMC power sequences:
>  --------------------
> --
> 2.8.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
