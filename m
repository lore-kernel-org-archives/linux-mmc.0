From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [PATCH] mmc: atmel-mci: save and restore sdioirq when soft
 reset is performed
Date: Wed, 8 Feb 2012 17:17:17 +0100
Message-ID: <20120208161717.GI15647@game.jcrosoft.org>
References: <1328721759-10124-1-git-send-email-ludovic.desroches@atmel.com>
 <20120208152621.GH15647@game.jcrosoft.org>
 <20120208154528.GC4919@ldesroches-Latitude-E6320>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 18.mo3.mail-out.ovh.net ([87.98.172.162]:36599 "EHLO
	mo3.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754210Ab2BHQWo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Feb 2012 11:22:44 -0500
Received: from mail617.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo3.mail-out.ovh.net (Postfix) with SMTP id C2A491004ADA
	for <linux-mmc@vger.kernel.org>; Wed,  8 Feb 2012 17:22:46 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20120208154528.GC4919@ldesroches-Latitude-E6320>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ludovic Desroches <ludovic.desroches@atmel.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, cjb@laptop.org, nicolas.ferre@atmel.com

On 16:45 Wed 08 Feb     , Ludovic Desroches wrote:
> Hello Jean-Christophe,
> 
> A customer using an Atheros AR6103 SDIO WLAN adapter faces this issue.
> 
> Sometimes we perform a software reset and he noticed that after he didn't get
> sdio irq. The interrupt mask register is also resetted when performing
> software reset.
so put this in the commit

Best Regards,
J.
