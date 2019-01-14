From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: mmc: fsl-imx-esdhc: add imx6ull
 compatible string
Date: Mon, 14 Jan 2019 12:43:54 +0100
Message-ID: <CAPDyKFrOW5tM7ztKzQ2akp6xvVsX72NAc1zmRzcFnt5Q9YrhtA@mail.gmail.com>
References: <20181228033323.32308-1-haibo.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181228033323.32308-1-haibo.chen@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: BOUGH CHEN <haibo.chen@nxp.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "adrian.hunter@intel.com" <adrian.hunter@intel.com>, "rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>, "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, 28 Dec 2018 at 04:26, BOUGH CHEN <haibo.chen@nxp.com> wrote:
>
> Add imx6ull compatible string
>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Applied for next, thanks!

I also amended the changelog by adding some more information about why
this is needed, according to the comment from Fabio.

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> index 9201a7d8d7b0..540c65ed9cba 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> @@ -15,6 +15,7 @@ Required properties:
>                "fsl,imx6q-usdhc"
>                "fsl,imx6sl-usdhc"
>                "fsl,imx6sx-usdhc"
> +              "fsl,imx6ull-usdhc"
>                "fsl,imx7d-usdhc"
>                "fsl,imx8qxp-usdhc"
>
> --
> 2.17.1
>
