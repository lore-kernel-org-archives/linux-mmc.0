From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [PATCH v2] ARM: at91: add atmel-mci support for chips and
 boards which can use it
Date: Mon, 28 May 2012 09:41:33 +0200
Message-ID: <20120528074133.GR3377@game.jcrosoft.org>
References: <1337183519-25459-3-git-send-email-ludovic.desroches@atmel.com>
 <1337595807-8539-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 9.mo3.mail-out.ovh.net ([87.98.184.141]:33520 "EHLO
	mo3.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750791Ab2E1HlZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 May 2012 03:41:25 -0400
Received: from mail91.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo3.mail-out.ovh.net (Postfix) with SMTP id ECABEFF8810
	for <linux-mmc@vger.kernel.org>; Mon, 28 May 2012 09:44:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1337595807-8539-1-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ludovic.desroches@atmel.com
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nicolas.ferre@atmel.com

On 12:23 Mon 21 May     , ludovic.desroches@atmel.com wrote:
> From: Ludovic Desroches <ludovic.desroches@atmel.com>
> 
> Since atmel-mci driver supports all atmel mci version excepted the rm9200 one,
> use it instead of at91_mci driver.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> ---
> V2: add several boards I missed
for the 9g20 and 9260 please drop the old driver support too

for calao bord you can do it too

Best Regards,
J.
