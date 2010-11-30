From: David Vrabel <david.vrabel@csr.com>
Subject: Re: [PATCH] mmc: USB SDIO/SD/MMC Host Controller (VUB300) driver
Date: Tue, 30 Nov 2010 12:23:06 +0000
Message-ID: <4CF4ECAA.70806@csr.com>
References: <20B0EAA71DD7413A9A29D0493C6C1D87@AN00536> <20101116150022.GA27726@void.printf.net> <27884BED0E3C489C8849EE12A803F536@AN00536> <m3oc9pnt6g.fsf@pullcord.laptop.org> <4CE41BE3.1060806@elandigitalsystems.com> <m3oc9n241c.fsf@pullcord.laptop.org> <4CEA86D4.9050109@elandigitalsystems.com> <20101130061532.GA4331@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cluster-g.mailcontrol.com ([208.87.233.190]:35987 "EHLO
	cluster-g.mailcontrol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751059Ab0K3NDo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Nov 2010 08:03:44 -0500
Received: from rly23g.srv.mailcontrol.com (localhost.localdomain [127.0.0.1])
	by rly23g.srv.mailcontrol.com (MailControl) with ESMTP id oAUCQaML013413
	for <linux-mmc@vger.kernel.org>; Tue, 30 Nov 2010 12:26:37 GMT
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by rly23g.srv.mailcontrol.com (MailControl) id oAUCQ0mH002420
	for <linux-mmc@vger.kernel.org>; Tue, 30 Nov 2010 12:26:00 GMT
In-Reply-To: <20101130061532.GA4331@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Tony Olech <tony.olech@elandigitalsystems.com>, linux-mmc@vger.kernel.org

Chris Ball wrote:
> Hi David,
> 
> Any interest in reviewing this USB-SD driver?  I'm especially curious
> about whether you think there are worthwhile possibilities to share 
> code with USHC.

A quick look suggests that there is unlikely to be any commonality
between the two drivers.

Tony, where can I find the datasheet or developer's manual describing
the protocol/operation of this chip?

David
-- 
David Vrabel, Senior Software Engineer, Drivers
CSR, Churchill House, Cambridge Business Park,  Tel: +44 (0)1223 692562
Cowley Road, Cambridge, CB4 0WZ                 http://www.csr.com/


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
