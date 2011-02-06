From: David Vrabel <david.vrabel@csr.com>
Subject: Re: [BUG] CMD52 sent as first command not CMD0
Date: Sun, 06 Feb 2011 16:02:02 +0000
Message-ID: <4D4EC5FA.8000404@csr.com>
References: <C85F98EE-B8C5-4037-A0FF-203265A7575C@marvell.com> <20110206003845.GA15019@void.printf.net> <BC6C6C10-631A-4482-BA1B-C6F0057BC54A@marvell.com> <20110206011514.GA15322@void.printf.net> <173274DF-475D-44FB-8C34-25728D12ADBB@marvell.com> <20110206015003.GA15576@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smarthost01.mail.zen.net.uk ([212.23.3.140]:60087 "EHLO
	smarthost01.mail.zen.net.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752936Ab1BFQCX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 6 Feb 2011 11:02:23 -0500
In-Reply-To: <20110206015003.GA15576@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Philip Rakity <prakity@marvell.com>, Albert Herranz <albert_herranz@yahoo.es>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 06/02/2011 01:50, Chris Ball wrote:
> 
> 
> Thanks.  We have macros for this, but need to add one for combo cards.
> include/linux/mmc/card.h should get:
> 
> #define mmc_card_sd_combo(c)    ((c)->type == MMC_TYPE_SD_COMBO)

How about something like:

#define mmc_card_has_sdio(c) \
    ({ \
        struct mmc_card *__card = (c); \
        mmc_card_sdio(__card) && mmc_card_sd_combo(__card); \
    })

And similarly

#define mmc_card_has_sd(c) ...

David
