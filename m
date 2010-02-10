From: David Vrabel <david.vrabel@csr.com>
Subject: Re: [PATCH 5/5] SDIO: put active devices into 1-bit mode during suspend
Date: Wed, 10 Feb 2010 16:49:37 +0000
Message-ID: <4B72E3A1.4020902@csr.com>
References: <1265747366-6676-1-git-send-email-nico@fluxnic.net>	<1265747366-6676-6-git-send-email-nico@fluxnic.net>	<4B7298EF.4070604@csr.com> <m38wb115nk.fsf@pullcord.laptop.org>	<4B72D8CC.9030605@csr.com> <m31vgt127c.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cluster-d.mailcontrol.com ([85.115.60.190]:58525 "EHLO
	cluster-d.mailcontrol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754843Ab0BJQur (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Feb 2010 11:50:47 -0500
Received: from rly06d.srv.mailcontrol.com (localhost.localdomain [127.0.0.1])
	by rly06d.srv.mailcontrol.com (MailControl) with ESMTP id o1AGob1a029788
	for <linux-mmc@vger.kernel.org>; Wed, 10 Feb 2010 16:50:43 GMT
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by rly06d.srv.mailcontrol.com (MailControl) id o1AGnlUO024702
	for <linux-mmc@vger.kernel.org>; Wed, 10 Feb 2010 16:49:47 GMT
In-Reply-To: <m31vgt127c.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Nicolas Pitre <nico@fluxnic.net>, Andrew Morton <akpm@linux-foundation.org>, linux-mmc@vger.kernel.org

Chris Ball wrote:
> Hi David,
> 
>    > I couldn't find anything in the SDIO specification (you know the
>    > section number?).  Part A2 has a requirement that the controller
>    > be placed into 1-bit mode but this doesn't mean that the card has
>    > to be.
> 
> I think it's part E1 section 8, and does specify that it's necessary
> for both host and card.

Found it now, thanks.  The patch is fine as is.

(FWIW, my confusion arose because CSR chips can assert interrupts in
4-bit mode even without SDCLK.)

David
-- 
David Vrabel, Senior Software Engineer, Drivers
CSR, Churchill House, Cambridge Business Park,  Tel: +44 (0)1223 692562
Cowley Road, Cambridge, CB4 0WZ                 http://www.csr.com/


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
