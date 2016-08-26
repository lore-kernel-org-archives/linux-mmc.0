From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH v2 1/2] sdhci-of-arasan: Modify arasan sdhci documentation
 about broken-cd and non-removable properties.
Date: Fri, 26 Aug 2016 09:19:00 +0200
Message-ID: <f2a24bba-3faf-0882-4d7f-6b654247da7f@xilinx.com>
References: <1472166111-28872-1-git-send-email-zach.brown@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1472166111-28872-1-git-send-email-zach.brown@ni.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Zach Brown <zach.brown@ni.com>, adrian.hunter@intel.com
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, michal.simek@xilinx.com, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, soren.brinkmann@xilinx.com
List-Id: linux-mmc@vger.kernel.org

On 26.8.2016 01:01, Zach Brown wrote:
> The sdhci controller on xilinx zynq devices will not function unless
> the CD bit is provided. http://www.xilinx.com/support/answers/61064.html
> In cases where it is impossible to provide the CD bit in hardware,
> setting the controller to test mode and then setting inserted to true
> will get the controller to function without the CD bit.
> 
> Additionally in some situations it will make sense to use the
> "broken-cd" and "non-removable" property together.
> i.e the sd device is non-removable so polling doesn't make sense, but
> the CD is broken and the controller will need to be in test mode to
> function.
> 
> This patch modifies the documentation to reflect those differences
> from the standard behaviours.
> 
> Signed-off-by: Zach Brown <zach.brown@ni.com>
> ---
> v2:
>   * improved commit messages
>   * removed fake-cd device property
>   * removed fake-cd quirk
>   * use broken-cd device property
>   * documented new usage of broken-cd
> 
>  Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> index 3404afa..b41c448 100644
> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> @@ -37,6 +37,14 @@ Optional Properties:
>      in place we will export a clock representing the Card Clock.  This clock
>      is expected to be consumed by our PHY.  You must also specify
>  
> +Card detection:
> +The arasan controller does not work
> +when the CD bit is not supplied unless in test mode.
> +- broken-cd: The CD bit is not supplied and the controller will
> +  need to be set to test mode to function.
> +- non-removable: like normal, except it can now be partnered with
> +  broken-cd, which will turn off polling, but keep test mode on.
> +
>  Example:
>  	sdhci@e0100000 {
>  		compatible = "arasan,sdhci-8.9a";
> @@ -72,4 +80,4 @@ Example:
>  		phy-names = "phy_arasan";
>  		#clock-cells = <0>;
>  		status = "disabled";
> -	};
> +	} ;

Probably you don't need this change.

M
