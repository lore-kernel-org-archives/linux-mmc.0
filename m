From: Li Yang <leoyang.li@nxp.com>
Subject: Re: [PATCH v1] mmc: dt: add DT bindings for ls1028a eSDHC host controller
Date: Tue, 30 Apr 2019 18:12:05 -0500
Message-ID: <CADRPPNQ4RYhe5n_ZA_xrhG8VARsvV3cwVgnuinedb2VHKkDzbQ@mail.gmail.com>
References: <20190430051723.31345-1-yinbo.zhu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190430051723.31345-1-yinbo.zhu@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yinbo Zhu <yinbo.zhu@nxp.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Xiaobo Xie <xiaobo.xie@nxp.com>, "Y.b. Lu" <yangbo.lu@nxp.com>, Jiafei Pan <jiafei.pan@nxp.com>
List-Id: linux-mmc@vger.kernel.org

On Tue, Apr 30, 2019 at 12:16 AM Yinbo Zhu <yinbo.zhu@nxp.com> wrote:
>
> From: Yinbo Zhu <yinbo.zhu@nxp.com>

The patch title better to be "dt-bindings: mmc: ..."
>
> Add "fsl,ls1028a-esdhc" bindings for ls1028a eSDHC host controller
>
> Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
> ---
>  .../devicetree/bindings/mmc/fsl-esdhc.txt          |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt b/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
> index 99c5cf8..a7250b9 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
> +++ b/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
> @@ -21,6 +21,7 @@ Required properties:
>         "fsl,ls1043a-esdhc"
>         "fsl,ls1046a-esdhc"
>         "fsl,ls2080a-esdhc"
> +       "fsl,ls1028a-esdhc"

Better to be alphabetical order.

>    - clock-frequency : specifies eSDHC base clock frequency.
>
>  Optional properties:
> --
> 1.7.1
>
