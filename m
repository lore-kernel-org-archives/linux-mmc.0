From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH 2/3] ARM: at91: remove mach/atmel-mci.h
Date: Fri, 17 Oct 2014 10:04:45 +0200
Message-ID: <20141017080445.GA32723@piout.net>
References: <1413532366-1317-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1413532366-1317-3-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1413532366-1317-3-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>, Chris Ball <chris@printf.net>, Hans-Christian Egtvedt <egtvedt@samfundet.no>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ludovic Desroches <ludovic.desroches@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-arm-kernel@lists.infradead.org, Haavard Skinnemoen <hskinnemoen@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On 17/10/2014 at 09:52:45 +0200, Alexandre Belloni wrote :
> Use the generic platform_data header file instead of mach/atmel-mci.h
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  arch/arm/mach-at91/at91sam9g45_devices.c    |  2 +-
>  arch/arm/mach-at91/include/mach/atmel-mci.h | 17 -----------------
>  2 files changed, 1 insertion(+), 18 deletions(-)
>  delete mode 100644 arch/arm/mach-at91/include/mach/atmel-mci.h
> 
> diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
> index 21ab782cc8e9..797433a5881a 100644
> --- a/arch/arm/mach-at91/at91sam9g45_devices.c
> +++ b/arch/arm/mach-at91/at91sam9g45_devices.c
> @@ -17,8 +17,8 @@
>  #include <linux/clk.h>
>  #include <linux/platform_device.h>
>  #include <linux/i2c-gpio.h>
> -#include <linux/atmel-mci.h>

I sent the wrong series, I will respin

>  #include <linux/platform_data/crypto-atmel.h>
> +#include <linux/platform_data/mmc-atmel-mci.h>
>  

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
