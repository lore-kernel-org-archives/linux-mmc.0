From: David Vrabel <david.vrabel@csr.com>
Subject: Re: [PATCH 5/5] SDIO: put active devices into 1-bit mode during suspend
Date: Wed, 10 Feb 2010 11:30:55 +0000
Message-ID: <4B7298EF.4070604@csr.com>
References: <1265747366-6676-1-git-send-email-nico@fluxnic.net> <1265747366-6676-6-git-send-email-nico@fluxnic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cluster-d.mailcontrol.com ([85.115.60.190]:39947 "EHLO
	cluster-d.mailcontrol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755350Ab0BJLb1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Feb 2010 06:31:27 -0500
Received: from rly08d.srv.mailcontrol.com (localhost.localdomain [127.0.0.1])
	by rly08d.srv.mailcontrol.com (MailControl) with ESMTP id o1ABVJw6011677
	for <linux-mmc@vger.kernel.org>; Wed, 10 Feb 2010 11:31:23 GMT
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by rly08d.srv.mailcontrol.com (MailControl) id o1ABVBGg011187
	for <linux-mmc@vger.kernel.org>; Wed, 10 Feb 2010 11:31:11 GMT
In-Reply-To: <1265747366-6676-6-git-send-email-nico@fluxnic.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mmc@vger.kernel.org

Nicolas Pitre wrote:
> From: Daniel Drake <dsd@laptop.org>
> 
> And bring them back to 4-bit mode during resume.

Why?  Is this for a specific card that doesn't support asynchronous card
interrupts while in 4-bit mode?  If so, I'd suggest a card quirk for
this and only switch modes for these cards.

> +	ctrl |= SDIO_BUS_ASYNC_INT;

This bit is for SPI mode only.  Why are you setting it here?

David
-- 
David Vrabel, Senior Software Engineer, Drivers
CSR, Churchill House, Cambridge Business Park,  Tel: +44 (0)1223 692562
Cowley Road, Cambridge, CB4 0WZ                 http://www.csr.com/


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
