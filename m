From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] dt-bindings: mmc: add DT bindings for ls1028a eSDHC
 host controller
Date: Mon, 6 May 2019 11:51:37 +0200
Message-ID: <CAPDyKFrcFo_zCy5q2VkUP+SxOTogmAsys-X_yBrARLE1dTcqqw@mail.gmail.com>
References: <20190505055858.37509-1-yinbo.zhu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190505055858.37509-1-yinbo.zhu@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yinbo Zhu <yinbo.zhu@nxp.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Leo Li <leoyang.li@nxp.com>, Xiaobo Xie <xiaobo.xie@nxp.com>, "Y.b. Lu" <yangbo.lu@nxp.com>, Jiafei Pan <jiafei.pan@nxp.com>
List-Id: linux-mmc@vger.kernel.org

On Sun, 5 May 2019 at 07:57, Yinbo Zhu <yinbo.zhu@nxp.com> wrote:
>
> From: Yinbo Zhu <yinbo.zhu@nxp.com>
>
> Add "fsl,ls1028a-esdhc" bindings for ls1028a eSDHC host controller
>
> Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Change in v2:
>                 as alphabetical order to update dt-bindings
>                 update the commit information.
>
>  Documentation/devicetree/bindings/mmc/fsl-esdhc.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt b/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
> index 99c5cf8507e8..edb8cadb9541 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
> +++ b/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
> @@ -17,6 +17,7 @@ Required properties:
>         "fsl,t4240-esdhc"
>      Possible compatibles for ARM:
>         "fsl,ls1012a-esdhc"
> +       "fsl,ls1028a-esdhc"
>         "fsl,ls1088a-esdhc"
>         "fsl,ls1043a-esdhc"
>         "fsl,ls1046a-esdhc"
> --
> 2.17.1
>
