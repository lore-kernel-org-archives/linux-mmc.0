From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH V2 07/15] doc: dt: fsl-imx-esdhc: add set tuning start
 point binding
Date: Tue, 12 Jul 2016 15:59:07 +0200
Message-ID: <20160712135907.GA30437@lunn.ch>
References: <1468309584-3591-1-git-send-email-aisheng.dong@nxp.com>
 <1468309584-3591-8-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:40889 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753664AbcGLN7J (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 12 Jul 2016 09:59:09 -0400
Content-Disposition: inline
In-Reply-To: <1468309584-3591-8-git-send-email-aisheng.dong@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <aisheng.dong@nxp.com>
Cc: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, dongas86@gmail.com, chris@printf.net, haibo.chen@nxp.com, adrian.hunter@intel.com, shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Jul 12, 2016 at 03:46:16PM +0800, Dong Aisheng wrote:
> add tuning start point binding
> 
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> index dca56d6248f5..3e29050ec769 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> @@ -28,6 +28,8 @@ Optional properties:
>    transparent level shifters on the outputs of the controller. Two cells are
>    required, first cell specifies minimum slot voltage (mV), second cell
>    specifies maximum slot voltage (mV). Several ranges could be specified.
> +- fsl,tuning-start-tap: Specify the start dealy cell point when send first CMD19
> +  in tuning procedure.
>  - fsl,tuning-step: Specify the increasing delay cell steps in tuning procedure.
>    The uSDHC use one delay cell as default increasing step to do tuning process.
>    This property allows user to change the tuning step to more than one delay

Hi Dong

You say this is a patch which should be part of stable. How does it
fulfil the requirements listed in

Linux/Documentation/stable_kernel_rules.txt

Thanks
	Andrew
