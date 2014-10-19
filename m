From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCHv2 0/3] Remove mach/atmel-mci.h
Date: Sun, 19 Oct 2014 22:15:51 +0200
Message-ID: <2020417.En5p6XBEWH@wuerfel>
References: <1413534398-22645-1-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:60970 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751621AbaJSUQI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 19 Oct 2014 16:16:08 -0400
In-Reply-To: <1413534398-22645-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Chris Ball <chris@printf.net>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Ludovic Desroches <ludovic.desroches@atmel.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org

On Friday 17 October 2014 10:26:35 Alexandre Belloni wrote:
> This patch series removes the uses of mach/atmel-mci.h and the files themselves.
> The final goal is to be able to switch AT91 to multiplatform.
> 
> The first patch introduces a new platform_data file and uses it in the driver.
> The two following patches remove the uses of mach/atmel-mci.h and the header
> itself from avR32 and ARM/at91.
> 
> Changes in v2:
>  - include back linux/atmel-mci.h and really remove mach/atmel-mci.h in at91sam9g45_devices.c
> 
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
