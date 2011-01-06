From: David Vrabel <david.vrabel@csr.com>
Subject: Re: [PATCH] mmc: USB SDIO/SD/MMC Host Controller (VUB300) driver
Date: Thu, 06 Jan 2011 13:18:21 +0000
Message-ID: <4D25C11D.5020205@csr.com>
References: <20B0EAA71DD7413A9A29D0493C6C1D87@AN00536> <20101116150022.GA27726@void.printf.net> <27884BED0E3C489C8849EE12A803F536@AN00536> <m3oc9pnt6g.fsf@pullcord.laptop.org> <4CE41BE3.1060806@elandigitalsystems.com> <m3oc9n241c.fsf@pullcord.laptop.org> <4CEA86D4.9050109@elandigitalsystems.com> <20101130061532.GA4331@void.printf.net> <4CF4ECAA.70806@csr.com> <4D10C1DE.3080200@elandigitalsystems.com> <20110106045611.GB17617@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cluster-d.mailcontrol.com ([85.115.60.190]:40947 "EHLO
	cluster-d.mailcontrol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752232Ab1AFOYv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 6 Jan 2011 09:24:51 -0500
Received: from rly52d.srv.mailcontrol.com (localhost.localdomain [127.0.0.1])
	by rly52d.srv.mailcontrol.com (MailControl) with ESMTP id p06DIQM1030098
	for <linux-mmc@vger.kernel.org>; Thu, 6 Jan 2011 13:18:30 GMT
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by rly52d.srv.mailcontrol.com (MailControl) id p06DIMUb029335
	for <linux-mmc@vger.kernel.org>; Thu, 6 Jan 2011 13:18:22 GMT
In-Reply-To: <20110106045611.GB17617@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Tony Olech <tony.olech@elandigitalsystems.com>, linux-mmc@vger.kernel.org

Chris Ball wrote:
> Hi David,
> 
> On Tue, Dec 21, 2010 at 03:03:58PM +0000, Tony Olech wrote:
>>>> Any interest in reviewing this USB-SD driver?  I'm especially curious
>>>> about whether you think there are worthwhile possibilities to share
>>>> code with USHC.
>>> A quick look suggests that there is unlikely to be any commonality
>>> between the two drivers.
>>>
>>> Tony, where can I find the datasheet or developer's manual describing
>>> the protocol/operation of this chip?
>> I finally persuaded my boss that our interface document should put released.
>> It is the PDF in  
>> http://www.elandigitalsystems.com/eng/drivers/vub300/Linux-v2-10.zip
>> and it describes the protocol between the customized SMSC chip and the  
>> host PC.
>> And I agree that there will be virtually nothing in common with the USHC  
>> driver.
> 
> Might you be able to find time to review this soon?

There is no useful commonality between this driver and the USHC driver.
 I don't have time to do a detailed code review but I have gone through
and highlighted some potential issues (see other email).

David
-- 
David Vrabel, Senior Software Engineer, Drivers
CSR, Churchill House, Cambridge Business Park,  Tel: +44 (0)1223 692562
Cowley Road, Cambridge, CB4 0WZ                 http://www.csr.com/


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
