From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH 0/5] make sdhci device drivers self registered
Date: Mon, 21 Mar 2011 13:39:45 +0100
Message-ID: <201103211339.45305.arnd@arndb.de>
References: <1300694823-8300-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1300694823-8300-1-git-send-email-shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Monday 21 March 2011, Shawn Guo wrote:
> This patch set is to take sdhci device driver specific things out
> from sdhci-pltfm.c and make them self registered. Here are the
> differences it makes.
> 
>  * Get the sdhci device driver follow the Linux trend that driver
>    take the registration by its own
>  * sdhci-pltfm.c becomes significantly simpler and only has common
>    support functions there
>  * All sdhci device specific stuff are going back its own driver
>  * The dt and non-dt support share the same pair of .probe and
>    .remove hooks.
> 
> The first one patch adds common support function into sdhci-pltfm.c
> when changing sdhci-esdhc-imx driver, while the last one cleans up
> sdhci-pltfm.c when changing sdhci-tegra driver.
> 
> Only the patch of sdhci-esdhc-imx are tested on hardware, and others
> are just build tested.  And it is based on the tree below.
> 
>   git://git.secretlab.ca/git/linux-2.6.git devicetree/test
> 
> Comments are welcomed and appreciated.

Hi Shawn,

The changes you make look very nice, great work there!

I think the split of the series into five patches is not ideal
because you have more interdependencies than necessary, and it's
not clear that the series can be safely bisected, especially
with the way you do all the Kconfig/Makefile updates at the
end.

A nicer way to partition the series would be

1.   Add sdhci_pltfm_init helper
2-5. Convert each of the users, including the respective
     Kconfig/Makefile changes
6.   remove obsolete code from sdhci-pltfm.c

As I said, that's just a detail and the end result is the same.
If you don't get any other feedback and Chris is happy with the
changes, I wouldn't expect you to reshuffle all the patches just
for this.

Acked-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
