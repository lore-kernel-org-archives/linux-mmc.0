From: Daniel Mack <daniel@caiaq.de>
Subject: Re: libertas: DAT1 signal IRQ in 1-bit SDIO mode
Date: Tue, 30 Mar 2010 19:50:19 +0200
Message-ID: <20100330175019.GW30801@buzzloop.caiaq.de>
References: <20100329182414.GJ30801@buzzloop.caiaq.de>
 <4BB0FE7A.6090709@embwise.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from buzzloop.caiaq.de ([212.112.241.133]:54358 "EHLO
	buzzloop.caiaq.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752447Ab0C3RuZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Mar 2010 13:50:25 -0400
Content-Disposition: inline
In-Reply-To: <4BB0FE7A.6090709@embwise.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alagu Sankar <alagusankar@embwise.com>
Cc: libertas-dev@lists.infradead.org, linux-mmc@vger.kernel.org

On Tue, Mar 30, 2010 at 12:54:42AM +0530, Alagu Sankar wrote:
>    If this is too much try for now and would like to still continue with the
>    1-bit mode, you can try setting the ECSI bit in CCCR - Bus Interface
>    Control Register (This should be done inside the libertas driver once
>    during the initialization).  This has helped us running the card in 1-bit
>    mode and get SDIO interrupts as well.

Great, that did the trick. Thanks a lot for this information :)

Daniel

