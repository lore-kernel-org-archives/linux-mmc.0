From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] mmc: Standardise capability type
Date: Thu, 15 Nov 2012 11:47:14 +0000
Message-ID: <201211151147.14858.arnd@arndb.de>
References: <1352896551-17948-1-git-send-email-lee.jones@linaro.org> <CACRpkdZ+V1aiQ-c62v9jdv93wMGu9hrSnXj_a9jx3uOTbot44A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:58966 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993197Ab2KOLrZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Nov 2012 06:47:25 -0500
In-Reply-To: <CACRpkdZ+V1aiQ-c62v9jdv93wMGu9hrSnXj_a9jx3uOTbot44A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linus.walleij@stericsson.com, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

On Thursday 15 November 2012, Linus Walleij wrote:
> 
> On Wed, Nov 14, 2012 at 1:35 PM, Lee Jones <lee.jones@linaro.org> wrote:
> 
> > There are discrepancies with regards to how MMC capabilities
> > are carried throughout the subsystem. Let's standardise them
> > to elevate any confusion.
> >
> > Cc: Chris Ball <cjb@laptop.org>
> > Cc: linux-mmc@vger.kernel.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> Looks good to me, and these are obviously
> u32 bitfields by design, so:
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
