From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: Re: [PATCH 1/3] mmc: atmel-mci: correct data timeout computation
Date: Thu, 22 Mar 2012 09:57:37 +0100
Message-ID: <20120322085736.GM11834@ldesroches-Latitude-E6320>
References: <1332344483-3915-1-git-send-email-ludovic.desroches@atmel.com>
 <1332344483-3915-2-git-send-email-ludovic.desroches@atmel.com>
 <4F6A011C.3000900@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:4508 "EHLO sjogate2.atmel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964786Ab2CVI5x (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 22 Mar 2012 04:57:53 -0400
Content-Disposition: inline
In-Reply-To: <4F6A011C.3000900@mvista.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: ludovic.desroches@atmel.com, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, plagnioj@jcrosoft.com, nicolas.ferre@atmel.com

Hello Sergei,

On Wed, Mar 21, 2012 at 07:26:04PM +0300, Sergei Shtylyov wrote:
> Hello.
> 
> On 03/21/2012 06:41 PM, ludovic.desroches@atmel.com wrote:
> 
> >From: Ludovic Desroches<ludovic.desroches@atmel.com>
> 
> >The HSMCI operates at a rate of up to Master Clock divided by two.
> 
> >Signed-off-by: Ludovic Desroches<ludovic.desroches@atmel.com>
> >---
> >  drivers/mmc/host/atmel-mci.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> >diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> >index e4449a5..e161452 100644
> >--- a/drivers/mmc/host/atmel-mci.c
> >+++ b/drivers/mmc/host/atmel-mci.c
> >@@ -480,7 +480,7 @@ err:
> >  static inline unsigned int atmci_ns_to_clocks(struct atmel_mci *host,
> >  					unsigned int ns)
> >  {
> >-	return (ns * (host->bus_hz / 1000000) + 999) / 1000;
> >+	return (ns * ((host->bus_hz/2) / 1000000) + 999) / 1000;
> 
>    Why don't you keep the notation by addign spaces around '/'?
>    BTW, could use DIV_ROUND_UP() here.
> 

Thanks for your comments. BTW I have realized (when testing values return using
DIV_ROUND_UP) that I may have another issue with this timeout calculation.
I will send a new patch.

Regards

Ludovic
