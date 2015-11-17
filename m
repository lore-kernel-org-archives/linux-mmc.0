From: Anton Bondarenko <anton.bondarenko.sama@gmail.com>
Subject: Re: [PATCH] [media] move media platform data to
 linux/platform_data/media
Date: Tue, 17 Nov 2015 11:43:27 +0100
Message-ID: <564B04CF.1090507@gmail.com>
References: <4d99e49726942dc4d6a6ee1debf6665b2b47908b.1447751746.git.mchehab@osg.samsung.com>
 <7319142.Cp8MurgLWk@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35602 "EHLO
	mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750913AbbKQKnc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Nov 2015 05:43:32 -0500
In-Reply-To: <7319142.Cp8MurgLWk@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Sergey Lapin <slapin@ossfans.org>, Timur Tabi <timur@tabi.org>, Jaroslav Kysela <perex@perex.cz>, Tomas Cech <sleep_walker@suse.com>, Shawn Guo <shawnguo@kernel.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Markus Elfring <elfring@users.sourceforge.net>, Harald Welte <laforge@openezx.org>, openezx-devel@lists.openezx.org, Russell King <linux@arm.linux.org.uk>, Vinod Koul <vinod.koul@intel.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Daniel Ribeiro <drwyrm@gmail.com>, Linux Media Mailing List <linux-media@vger.kernel.org>, Stefan Schmidt <stefan@openezx.org>, Sascha Hauer <kernel@pengutronix.de>, alsa-devel@alsa-project.orgMa


On 17.11.2015 10:23, Arnd Bergmann wrote:
> On Tuesday 17 November 2015 07:15:59 Mauro Carvalho Chehab wrote:
>> Now that media has its own subdirectory inside platform_data,
>> let's move the headers that are already there to such subdir.
>>
>>
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>

Why does dma-imx.h also moved? It's the generic file, not a media specific.

BR, Anton
