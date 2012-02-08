From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: Re: [PATCH] mmc: atmel-mci: save and restore sdioirq when soft reset
 is performed
Date: Wed, 8 Feb 2012 16:45:28 +0100
Message-ID: <20120208154528.GC4919@ldesroches-Latitude-E6320>
References: <1328721759-10124-1-git-send-email-ludovic.desroches@atmel.com>
 <20120208152621.GH15647@game.jcrosoft.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:28690 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756689Ab2BHPpm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Feb 2012 10:45:42 -0500
Content-Disposition: inline
In-Reply-To: <20120208152621.GH15647@game.jcrosoft.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: ludovic.desroches@atmel.com, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, cjb@laptop.org, nicolas.ferre@atmel.com

Hello Jean-Christophe,

A customer using an Atheros AR6103 SDIO WLAN adapter faces this issue.

Sometimes we perform a software reset and he noticed that after he didn't get
sdio irq. The interrupt mask register is also resetted when performing
software reset.

Regards

Ludovic

On Wed, Feb 08, 2012 at 04:26:21PM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 18:22 Wed 08 Feb     , ludovic.desroches@atmel.com wrote:
> > From: Ludovic Desroches <ludovic.desroches@atmel.com>
> 
> why do you need this?
> 
> Best Regards,
> J.
> 
