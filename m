From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: USB SDIO/SD/MMC Host Controller (VUB300) driver
Date: Thu, 6 Jan 2011 04:56:11 +0000
Message-ID: <20110106045611.GB17617@void.printf.net>
References: <20B0EAA71DD7413A9A29D0493C6C1D87@AN00536> <20101116150022.GA27726@void.printf.net> <27884BED0E3C489C8849EE12A803F536@AN00536> <m3oc9pnt6g.fsf@pullcord.laptop.org> <4CE41BE3.1060806@elandigitalsystems.com> <m3oc9n241c.fsf@pullcord.laptop.org> <4CEA86D4.9050109@elandigitalsystems.com> <20101130061532.GA4331@void.printf.net> <4CF4ECAA.70806@csr.com> <4D10C1DE.3080200@elandigitalsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:47126 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752637Ab1AFE4N (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 5 Jan 2011 23:56:13 -0500
Content-Disposition: inline
In-Reply-To: <4D10C1DE.3080200@elandigitalsystems.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Olech <tony.olech@elandigitalsystems.com>
Cc: David Vrabel <david.vrabel@csr.com>, linux-mmc@vger.kernel.org

Hi David,

On Tue, Dec 21, 2010 at 03:03:58PM +0000, Tony Olech wrote:
>>> Any interest in reviewing this USB-SD driver?  I'm especially curious
>>> about whether you think there are worthwhile possibilities to share
>>> code with USHC.
>> A quick look suggests that there is unlikely to be any commonality
>> between the two drivers.
>>
>> Tony, where can I find the datasheet or developer's manual describing
>> the protocol/operation of this chip?
>
> I finally persuaded my boss that our interface document should put released.
> It is the PDF in  
> http://www.elandigitalsystems.com/eng/drivers/vub300/Linux-v2-10.zip
> and it describes the protocol between the customized SMSC chip and the  
> host PC.
> And I agree that there will be virtually nothing in common with the USHC  
> driver.

Might you be able to find time to review this soon?

Thanks very much,

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
