From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6 1/2] sdhci-of-arasan: Add device tree parameter
 xlnx-fails-without-test-cd bit
Date: Fri, 16 Sep 2016 14:41:01 -0500
Message-ID: <20160916194101.GA3161@rob-hp-laptop>
References: <1473363766-12652-1-git-send-email-zach.brown@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1473363766-12652-1-git-send-email-zach.brown-acOepvfBmUk@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zach Brown <zach.brown-acOepvfBmUk@public.gmane.org>
Cc: adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Thu, Sep 08, 2016 at 02:42:45PM -0500, Zach Brown wrote:
> The sdhci controller on xilinx zynq devices will not function unless
> the CD bit is provided. http://www.xilinx.com/support/answers/61064.html
> In cases where it is impossible to provide the CD bit in hardware,
> setting the controller to test mode and then setting inserted to true
> will get the controller to function without the CD bit.
> 
> The device property "xlnx-fails-without-test-cd" will let the arasan
> driver know the controller does not have the CD line wired and that the
> controller does not function without it.
> 
> Signed-off-by: Zach Brown <zach.brown-acOepvfBmUk@public.gmane.org>
> ---
> v2:
>  * improved commit messages
>  * removed fake-cd device property
>  * removed fake-cd quirk
>  * use broken-cd device property
>  * documented new usage of broken-cd
> v3:
>  * removed new usage of broken-cd
>  * created fails-without-test-cd device property
>  * created arasan controller specific quirk
> v4:
>  * changed fails-without-test-cd to xlnx-fails-without-test-cd
>  * removed extra blank line
> v5:
>  * Fixed style mistake
>  * Changed (1 << 0 ) to BIT(0)
> v6:
>  * Fixed style mistakes
>  * Condensed unnecessarily long variable names
>  * Removed line wraps that were no longer necessary.
>  * Rebased changes off Ulf's mmc tree's next branch.
> 
> 
>  Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> df --gt /Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> index 3404afa..e71f043 100644
> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> @@ -21,6 +21,10 @@ Required Properties:
>    - interrupts: Interrupt specifier
>    - interrupt-parent: Phandle for the interrupt controller that services
>  		      interrupts for this device.
> +Optional Properties:
> +- xlnx-fails-without-test-cd: when present, the controller doesn't work when

xlnx,fails...

With that,

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
