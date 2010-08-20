From: David Vrabel <david.vrabel@csr.com>
Subject: Re: [PATCH 1/2] mmc: USB SD Host Controller (USHC) driver
Date: Fri, 20 Aug 2010 14:10:04 +0100
Message-ID: <4C6E7EAC.8040706@csr.com>
References: <1282226936-3159-1-git-send-email-david.vrabel@csr.com> <alpine.LFD.2.00.1008191338270.622@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cluster-d.mailcontrol.com ([85.115.60.190]:34937 "EHLO
	cluster-d.mailcontrol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751724Ab0HTNKz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Aug 2010 09:10:55 -0400
Received: from rly11d.srv.mailcontrol.com (localhost.localdomain [127.0.0.1])
	by rly11d.srv.mailcontrol.com (MailControl) with ESMTP id o7KDAoci019995
	for <linux-mmc@vger.kernel.org>; Fri, 20 Aug 2010 14:10:52 +0100
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by rly11d.srv.mailcontrol.com (MailControl) id o7KDA6Om015424
	for <linux-mmc@vger.kernel.org>; Fri, 20 Aug 2010 14:10:06 +0100
In-Reply-To: <alpine.LFD.2.00.1008191338270.622@xanadu.home>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mmc@vger.kernel.org

Nicolas Pitre wrote:
> On Thu, 19 Aug 2010, David Vrabel wrote:
> 
>> +	  Note: Version 2 devices only support SDIO cards/devices.
> 
> Do you mean that only the devices with version 2 do support SDIO, or 
> that devices with version 2 support SDIO only?

I've revised the wording to:

  Note: These controllers only support SDIO cards and do not
  support MMC or SD memory cards.

This is because the protocol doesn't support the long R2 response format.

>> +	mmc->f_min = 0;
>> +	mmc->f_max = 50000000;
> 
> Why are you setting mmc->f_min to zero?  I understand that the 6000000 
> limit is only for commands with data, but a limit of 0 is rather ... 
> unusual.

f_min should be 400 kHz.

I'll wait and see if there are any other review comments before posted
an updated patch.

David
-- 
David Vrabel, Senior Software Engineer, Drivers
CSR, Churchill House, Cambridge Business Park,  Tel: +44 (0)1223 692562
Cowley Road, Cambridge, CB4 0WZ                 http://www.csr.com/


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
