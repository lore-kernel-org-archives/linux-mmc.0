From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 5/6] ARM: shmobile: ape6evm: disable MMCIF Command
 Completion Signal
Date: Wed, 25 Sep 2013 16:12:27 +0900
Message-ID: <20130925071226.GP6663@verge.net.au>
References: <1373484077-10460-1-git-send-email-g.liakhovetski@gmx.de>
 <1373484077-10460-6-git-send-email-g.liakhovetski@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1373484077-10460-6-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>, Nobuyuki HIRAI <nobuyuki.hirai.xe@renesas.com>, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On Wed, Jul 10, 2013 at 09:21:16PM +0200, Guennadi Liakhovetski wrote:
> MMCIF on r8a73a4 doesn't support Command Completion Signal, a platform
> parameter has to be added to disable it on ape6evm.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> ---
>  arch/arm/mach-shmobile/board-ape6evm.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/board-ape6evm.c b/arch/arm/mach-shmobile/board-ape6evm.c
> index e9e2108e..96a6994 100644
> --- a/arch/arm/mach-shmobile/board-ape6evm.c
> +++ b/arch/arm/mach-shmobile/board-ape6evm.c
> @@ -77,6 +77,7 @@ static struct sh_mmcif_plat_data mmcif0_pdata = {
>  	.caps		= MMC_CAP_8_BIT_DATA | MMC_CAP_NONREMOVABLE,
>  	.slave_id_tx	= SHDMA_SLAVE_MMCIF0_TX,
>  	.slave_id_rx	= SHDMA_SLAVE_MMCIF0_RX,
> +	.ccs_unsupported = true,
>  };
>  
>  static struct resource mmcif0_resources[] = {

Thanks, I have queued up the following for v3.13.


From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

ARM: shmobile: ape6evm: disable MMCIF Command Completion Signal

MMCIF on r8a73a4 doesn't support Command Completion Signal, a platform
parameter has to be added to disable it on ape6evm.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-ape6evm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/board-ape6evm.c b/arch/arm/mach-shmobile/board-ape6evm.c
index 02be420..0365d2e 100644
--- a/arch/arm/mach-shmobile/board-ape6evm.c
+++ b/arch/arm/mach-shmobile/board-ape6evm.c
@@ -162,6 +162,7 @@ static struct regulator_consumer_supply vcc_sdhi1_consumers[] =
 /* MMCIF */
 static const struct sh_mmcif_plat_data mmcif0_pdata __initconst = {
 	.caps		= MMC_CAP_8_BIT_DATA | MMC_CAP_NONREMOVABLE,
+	.ccs_unsupported = true,
 };
 
 static const struct resource mmcif0_resources[] __initconst = {
-- 
1.8.4

