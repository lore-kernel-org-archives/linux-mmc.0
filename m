From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 1/3] Documentation: Update Arasan SDHC documentation for
 the APM X-Gene SoC SDHC DTS binding
Date: Mon, 19 May 2014 13:32:30 +0100
Message-ID: <20140519123230.GA3663@leverpostej>
References: <1400398918-1502-1-git-send-email-lho@apm.com>
 <1400398918-1502-2-git-send-email-lho@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1400398918-1502-2-git-send-email-lho@apm.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Loc Ho <lho@apm.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "jcm@redhat.com" <jcm@redhat.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "chris@printf.net" <chris@printf.net>, "michal.simek@xilinx.com" <michal.simek@xilinx.com>, "patches@apm.com" <patches@apm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On Sun, May 18, 2014 at 08:41:56AM +0100, Loc Ho wrote:
> This patch updates Arasan SDHC documentation for the APM X-Gene SoC SDHC controller
> DTS binding.
> 
> Signed-off-by: Loc Ho <lho@apm.com>
> ---
>  .../devicetree/bindings/mmc/arasan,sdhci.txt       |    9 ++++++---
>  1 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> index 98ee2ab..8fc4cc4 100644
> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> @@ -8,14 +8,17 @@ Device Tree Bindings for the Arasan SDHCI Controller
>    [3] Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
>  
>  Required Properties:
> -  - compatible: Compatibility string. Must be 'arasan,sdhci-8.9a'
> +  - compatible: Compatibility string. Must be 'arasan,sdhci-8.9a' or
> +                'xgene,arasan,sdhci-8.9a'

"xgene" is not a vendor, nor is it documented as such.

>    - reg: From mmc bindings: Register location and length.
> -  - clocks: From clock bindings: Handles to clock inputs.
> -  - clock-names: From clock bindings: Tuple including "clk_xin" and "clk_ahb"
>    - interrupts: Interrupt specifier
>    - interrupt-parent: Phandle for the interrupt controller that services
>  		      interrupts for this device.
>  
> +Optional Properties:
> +  - clocks: From clock bindings: Handles to clock inputs.
> +  - clock-names: From clock bindings: Tuple including "clk_xin" and "clk_ahb"

Given that these used to be required, they are presumably still required
in some cases?

If we're going to alter these lines, it'd be nice to clean them up at
the same time (a list is not a tuple, clocks aren't just phandles).

Cheers,
Mark.
