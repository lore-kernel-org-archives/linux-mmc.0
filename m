From: Mark Jackson <mpfj-list-2FZW7xY0fHgqdlJmJB21zg@public.gmane.org>
Subject: Re: [PATCH v2] ARM: dts: add AM33XX MMC support
Date: Wed, 17 Jul 2013 13:08:02 +0100
Message-ID: <51E68922.5020503@newflow.co.uk>
References: <1372303956-30208-1-git-send-email-joelf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1372303956-30208-1-git-send-email-joelf-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Joel Fernandes <joelf-l0cyMroinI0@public.gmane.org>
Cc: Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Devicetree Discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Linux Documentation List <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Gururaja Hebbar <gururaja.hebbar-l0cyMroinI0@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux SPI Devel List <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Balaji TK <balajitk-l0cyMroinI0@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Matt Porter <matt-agtwNxEcTQJWk0Htik3J/w@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 27/06/13 04:32, Joel Fernandes wrote:
> From: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>
> 
> Adds AM33XX MMC support for am335x-bone, am335x-evm, and am335x-evmsk.
> Also added is the DMA binding definitions based on the generic DMA
> request binding.
> 
> The HWMOD data removal was breaking MMC so some new properties like reg,
> interrupt etc were added.
> 
> Changes to DTS:
> Interrupt and reg added by: Joel Fernandes <joelf-l0cyMroinI0@public.gmane.org>
> Compatible added by Balaji TK <balajitk-l0cyMroinI0@public.gmane.org>
> ti,needs-special-hs-handling added by Gururaja Hebbar <gururaja.hebbar-l0cyMroinI0@public.gmane.org>
> 
> Signed-off-by: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>
> Acked-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: Joel Fernandes <joelf-l0cyMroinI0@public.gmane.org>
> ---
>  .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |   26 +++++++++++++-
>  arch/arm/boot/dts/am335x-bone.dts                  |    7 ++++
>  arch/arm/boot/dts/am335x-evm.dts                   |    7 ++++
>  arch/arm/boot/dts/am335x-evmsk.dts                 |    7 ++++
>  arch/arm/boot/dts/am33xx.dtsi                      |   38 ++++++++++++++++++++
>  5 files changed, 84 insertions(+), 1 deletion(-)

Excuse my ignorance, but which git repository is this against ?


------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
