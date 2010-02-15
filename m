From: David Vrabel <david.vrabel@csr.com>
Subject: Re: [PATCH 3/3] [U300] Set f_max to 24 MHz for MMC
Date: Mon, 15 Feb 2010 11:58:06 +0000
Message-ID: <4B7936CE.9020402@csr.com>
References: <1266233040-17124-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cluster-d.mailcontrol.com ([85.115.60.190]:48428 "EHLO
	cluster-d.mailcontrol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755436Ab0BOL7F (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Feb 2010 06:59:05 -0500
Received: from rly13d.srv.mailcontrol.com (localhost.localdomain [127.0.0.1])
	by rly13d.srv.mailcontrol.com (MailControl) with ESMTP id o1FBwqgc007023
	for <linux-mmc@vger.kernel.org>; Mon, 15 Feb 2010 11:59:00 GMT
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by rly13d.srv.mailcontrol.com (MailControl) id o1FBw8Ab002700
	for <linux-mmc@vger.kernel.org>; Mon, 15 Feb 2010 11:58:08 GMT
In-Reply-To: <1266233040-17124-1-git-send-email-linus.walleij@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@stericsson.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org

Linus Walleij wrote:
> 
> +	mmci_card->mmc0_plat_data.f_max = 24*1024*1024;

Is the frequency really 25165824 Hz and not 24000000 Hz?

David
-- 
David Vrabel, Senior Software Engineer, Drivers
CSR, Churchill House, Cambridge Business Park,  Tel: +44 (0)1223 692562
Cowley Road, Cambridge, CB4 0WZ                 http://www.csr.com/


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
