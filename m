From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/3] mmc: atmel-mci: stop using specific initcall
Date: Thu, 20 Nov 2014 12:10:25 +0100
Message-ID: <2176441.d1sGy4JguN@wuerfel>
References: <1416478075-17059-1-git-send-email-ludovic.desroches@atmel.com> <1416478075-17059-2-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:56692 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750958AbaKTLLE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 20 Nov 2014 06:11:04 -0500
In-Reply-To: <1416478075-17059-2-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Ludovic Desroches <ludovic.desroches@atmel.com>, linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, nicolas.ferre@atmel.com, chris@printf.net

On Thursday 20 November 2014 11:07:54 Ludovic Desroches wrote:
> No more use late initcall to manage probing order. Use probe deferring
> if needed. Then use module_platform_driver and clean init/exit
> attributes.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> 

Do we need this backported into stable kernels? It seems that
the __init/__exit annotations will break things if you ever
tried to unbind the device or run into deferred probing on
earlier kernels.

	Arnd
