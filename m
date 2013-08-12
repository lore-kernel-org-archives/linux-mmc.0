From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/3 V2] mmc:core: parse voltage from device-tree
Date: Mon, 12 Aug 2013 11:11:29 -0500
Message-ID: <1376323889.20487.7.camel@snotra.buserror.net>
References: <1375251927-3330-1-git-send-email-Haijun.Zhang@freescale.com>
	 <733059D3-105A-437B-B330-763D2C1859B2@kernel.crashing.org>
	 <52084C7E.9000706@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-db9lp0253.outbound.messaging.microsoft.com ([213.199.154.253]:46780
	"EHLO db9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755995Ab3HLQLn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Aug 2013 12:11:43 -0400
In-Reply-To: <52084C7E.9000706@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhang Haijun <B42677@freescale.com>
Cc: Kumar Gala <galak@kernel.crashing.org>, Haijun Zhang <Haijun.Zhang@freescale.com>, linux-mmc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, cjb@laptop.org, cbouatmailru@gmail.com

On Mon, 2013-08-12 at 10:46 +0800, Zhang Haijun wrote:
> On 08/09/2013 10:48 PM, Kumar Gala wrote:
> 
> > On Jul 31, 2013, at 1:25 AM, Haijun Zhang wrote:
> > 
> > > Add function to support get voltage from device-tree.
> > > If there are voltage-range specified in device-tree node, this function
> > > will parse it and return the avail voltage mask.
> > > 
> > > Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
> > > ---
> > > changes for v2:
> > > 	- Update the parameters of function
> > > 
> > > drivers/mmc/core/core.c  | 46 ++++++++++++++++++++++++++++++++++++++++++++++
> > > include/linux/mmc/core.h |  1 +
> > > 2 files changed, 47 insertions(+)
> > There should be a device tree binding spec update to go with this patch series.
> > 
> > - k
> Hi, kumar
> 
> I'll update this tree binding spec after the patch set is accept by
> Anton.

Bindings should come first (or at least, at the same time).

-Scott



