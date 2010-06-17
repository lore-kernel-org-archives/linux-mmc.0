From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v5 1/2] OMAP HSMMC: Adding a Flag to determine the type
 of  Card detect
Date: Thu, 17 Jun 2010 13:19:11 -0700
Message-ID: <20100617131911.de257575.akpm@linux-foundation.org>
References: <43583.10.24.255.17.1276788418.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57110 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933245Ab0FQUTq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Jun 2010 16:19:46 -0400
In-Reply-To: <43583.10.24.255.17.1276788418.squirrel@dbdmail.itg.ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: kishore kadiyala <kishore.kadiyala@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, tony@atomide.com, madhu.cr@ti.com

On Thu, 17 Jun 2010 20:56:58 +0530 (IST)
"kishore kadiyala" <kishore.kadiyala@ti.com> wrote:

> --- a/arch/arm/plat-omap/include/plat/mmc.h
> +++ b/arch/arm/plat-omap/include/plat/mmc.h
> @@ -43,6 +43,9 @@
> 
>  #define OMAP_MMC_MAX_SLOTS	2
> 
> +#define NON_GPIO		0
> +#define GPIO			1

I'm counting about seven different definitions of "GPIO" in the kernel
already.

drivers/hwmon/it87.c:
#define GPIO    0x07

drivers/media/dvb/dvb-usb/ec168.h:
	GPIO                 = 0x04,

drivers/net/hamachi.c:
	GPIO=0x6E

drivers/staging/rtl8187se/r8180_hw.h:
#define GPIO 0x91

etcetera.  It's a crazy identifier to use in a header file, and
the chances of a miscompile-causing collision are increasing.


enum cd_type {
	CD_TYPE_NON_GPIO = 0,
	CD_TYPE_GPIO = 1,
};

perhaps?
