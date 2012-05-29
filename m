From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [PATCH v2] ARM: at91: add atmel-mci support for chips and
 boards which can use it
Date: Tue, 29 May 2012 17:57:21 +0200
Message-ID: <20120529155721.GS3377@game.jcrosoft.org>
References: <1337183519-25459-3-git-send-email-ludovic.desroches@atmel.com>
 <1337595807-8539-1-git-send-email-ludovic.desroches@atmel.com>
 <20120528074133.GR3377@game.jcrosoft.org>
 <4FC4AB4A.8060605@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 3.mo3.mail-out.ovh.net ([46.105.44.175]:37491 "EHLO
	mo3.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751030Ab2E2P5O (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 29 May 2012 11:57:14 -0400
Received: from mail91.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo3.mail-out.ovh.net (Postfix) with SMTP id CAF42FFA219
	for <linux-mmc@vger.kernel.org>; Tue, 29 May 2012 18:00:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4FC4AB4A.8060605@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: ludovic.desroches@atmel.com, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 12:56 Tue 29 May     , Nicolas Ferre wrote:
> On 05/28/2012 09:41 AM, Jean-Christophe PLAGNIOL-VILLARD :
> > On 12:23 Mon 21 May     , ludovic.desroches@atmel.com wrote:
> >> From: Ludovic Desroches <ludovic.desroches@atmel.com>
> >>
> >> Since atmel-mci driver supports all atmel mci version excepted the rm9200 one,
> >> use it instead of at91_mci driver.
> >>
> >> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> >> ---
> >> V2: add several boards I missed
> > for the 9g20 and 9260 please drop the old driver support too
> 
> No, we will drop the support for old driver when we finish the
> transition period. We will then drop at91_mci with all configuration
> data in device/board files.
on 9g20 and 9260 the new drivers is present for release

there is no reason to keep one more release

Best Regards,
J.
