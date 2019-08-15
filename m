From: Li Yang <leoyang.li@nxp.com>
Subject: Re: [PATCH v1 2/4] soc: fsl: guts: Add definition for LS1028A
Date: Thu, 15 Aug 2019 17:40:09 -0500
Message-ID: <CADRPPNSW4A0gkbzcPD=y-J_YHSnbAgP7p=RQnS6i0U-Ze=L6qA@mail.gmail.com>
References: <20190814072649.8237-1-yinbo.zhu@nxp.com> <20190814072649.8237-2-yinbo.zhu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190814072649.8237-2-yinbo.zhu@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yinbo Zhu <yinbo.zhu@nxp.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Claudiu Manoil <claudiu.manoil@nxp.com>, Amit Jain <amit.jain_1@nxp.com>, Yangbo Lu <yangbo.lu@nxp.com>, Vabhav Sharma <vabhav.sharma@nxp.com>, Rajesh Bhagat <rajesh.bhagat@nxp.com>, Ashish Kumar <Ashish.Kumar@nxp.com>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org, Xiaobo Xie <xiaobo.xie@nxp.com>, Jiafei Pan <jiafei.pan@n>
List-Id: linux-mmc@vger.kernel.org

On Wed, Aug 14, 2019 at 2:26 AM Yinbo Zhu <yinbo.zhu@nxp.com> wrote:
>
> Adding compatible string "ls1028a-dcfg" to initialize guts driver
> for ls1028 and SoC die attribute definition for LS1028A
>
> Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>

Applied for next.

> ---
>  drivers/soc/fsl/guts.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
> index 1ef8068c8dd3..34810f9bb2ee 100644
> --- a/drivers/soc/fsl/guts.c
> +++ b/drivers/soc/fsl/guts.c
> @@ -102,6 +102,11 @@ static const struct fsl_soc_die_attr fsl_soc_die[] = {
>           .svr          = 0x87360000,
>           .mask         = 0xff3f0000,
>         },
> +       /* Die: LS1028A, SoC: LS1028A */
> +       { .die          = "LS1028A",
> +         .svr          = 0x870b0000,
> +         .mask         = 0xff3f0000,
> +       },
>         { },
>  };
>
> @@ -224,6 +229,7 @@ static const struct of_device_id fsl_guts_of_match[] = {
>         { .compatible = "fsl,ls1012a-dcfg", },
>         { .compatible = "fsl,ls1046a-dcfg", },
>         { .compatible = "fsl,lx2160a-dcfg", },
> +       { .compatible = "fsl,ls1028a-dcfg", },
>         {}
>  };
>  MODULE_DEVICE_TABLE(of, fsl_guts_of_match);
> --
> 2.17.1
>
