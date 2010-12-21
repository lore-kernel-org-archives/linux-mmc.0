From: Tony Olech <tony.olech@elandigitalsystems.com>
Subject: Re: [PATCH] mmc: USB SDIO/SD/MMC Host Controller (VUB300) driver
Date: Tue, 21 Dec 2010 15:03:58 +0000
Message-ID: <4D10C1DE.3080200@elandigitalsystems.com>
References: <20B0EAA71DD7413A9A29D0493C6C1D87@AN00536> <20101116150022.GA27726@void.printf.net> <27884BED0E3C489C8849EE12A803F536@AN00536> <m3oc9pnt6g.fsf@pullcord.laptop.org> <4CE41BE3.1060806@elandigitalsystems.com> <m3oc9n241c.fsf@pullcord.laptop.org> <4CEA86D4.9050109@elandigitalsystems.com> <20101130061532.GA4331@void.printf.net> <4CF4ECAA.70806@csr.com>
Reply-To: tony.olech@elandigitalsystems.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:55174 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752027Ab0LUPED (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Dec 2010 10:04:03 -0500
In-Reply-To: <4CF4ECAA.70806@csr.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Vrabel <david.vrabel@csr.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

On 30/11/2010 12:23, David Vrabel wrote:
> Chris Ball wrote:
>> Hi David,
>>
>> Any interest in reviewing this USB-SD driver?  I'm especially curious
>> about whether you think there are worthwhile possibilities to share
>> code with USHC.
> A quick look suggests that there is unlikely to be any commonality
> between the two drivers.
>
> Tony, where can I find the datasheet or developer's manual describing
> the protocol/operation of this chip?
>
> David
Hi,
I finally persuaded my boss that our interface document should put released.
It is the PDF in 
http://www.elandigitalsystems.com/eng/drivers/vub300/Linux-v2-10.zip
and it describes the protocol between the customized SMSC chip and the 
host PC.
And I agree that there will be virtually nothing in common with the USHC 
driver.
Tony Olech
Elan Digital Systems Limited

