From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] dt-bindings: mmc: fsl-imx-esdhc: add imx8m compatible string
Date: Thu, 14 Nov 2019 13:53:23 +0100
Message-ID: <CAPDyKFoL7oJ+2hvi77N9=1hBKFgCXRUppcte1u=eF4z+Fz8TQw@mail.gmail.com>
References: <1572949321-8193-1-git-send-email-peng.fan@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1572949321-8193-1-git-send-email-peng.fan@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peng Fan <peng.fan@nxp.com>
Cc: "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, Abel Vesa <abel.vesa@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, dl-linux-imx <linux-imx@nxp.com>, Aisheng Dong <aisheng.dong@nxp.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, 5 Nov 2019 at 11:23, Peng Fan <peng.fan@nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> Add imx8mq/m/n compatible string
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
> V1:
>  imx8mq/m/n.dtsi already use this compatible string,
>  but not listed in binding doc, so add it.
>
>  Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> index f707b8bee304..2fb466ca2a9d 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> @@ -18,6 +18,9 @@ Required properties:
>                "fsl,imx6ull-usdhc"
>                "fsl,imx7d-usdhc"
>                "fsl,imx7ulp-usdhc"
> +              "fsl,imx8mq-usdhc"
> +              "fsl,imx8mm-usdhc"
> +              "fsl,imx8mn-usdhc"
>                "fsl,imx8qxp-usdhc"
>
>  Optional properties:
> --
> 2.16.4
>
