From: Philip Rakity <prakity@marvell.com>
Subject: Fwd: SD3.0 patches V3
Date: Mon, 21 Mar 2011 10:34:39 -0700
Message-ID: <DFDD9F69-5E92-482B-81B8-9AEDE95C85F7@marvell.com>
References: <6C03668EAF45B747AF947A1603D1B300E3DF5099@SAUSEXMBP01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:47440 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753950Ab1CURjU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 21 Mar 2011 13:39:20 -0400
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Arindam Nath <arindam.nath@amd.com>


FYI to mailing list

Begin forwarded message:

> From: "Nath, Arindam" <Arindam.Nath@amd.com>
> Date: March 19, 2011 9:49:18 AM PDT
> To: Philip Rakity <prakity@marvell.com>
> Subject: RE: SD3.0 patches V3
> 
> Yes, I got your point. Probably it worked before because of the bit positions being separate. I will look into it later, once I fix the culprit which is breaking initialization on our controller.
> 
> Thanks,
> Arindam
> 
>> -----Original Message-----
>> From: Philip Rakity [mailto:prakity@marvell.com]
>> Sent: Saturday, March 19, 2011 10:14 PM
>> To: Nath, Arindam
>> Subject: Re: SD3.0 patches V3
>> 
>> 
>> understand but the code is wrong.   No & test for a value !  Need to
>> check against it.
>> 
>>> 
>>> 
>>>> -----Original Message-----
>>>> From: Philip Rakity [mailto:prakity@marvell.com]
>>>> Sent: Saturday, March 19, 2011 2:16 AM
>>>> To: Nath, Arindam
>>>> Subject: Re: SD3.0 patches V3
>>>> 
>>>> 
>>>> Did not yet look -- but fixed this in sdhci.c   === field is a value
>>>> not a bit field.
>>>> Also cleared added
>>>> 		ctrl_2 &= ~SDHCI_CTRL_UHS_MASK;
>>>> 
>>>> to ensure field is 0 before you set it.
>>>> 
>>>> 		ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
>>>> 		ctrl_2 &= ~SDHCI_CTRL_UHS_MASK;
>>>> 
>>>> 		/* Select Bus Speed Mode for host */
>>>> 		if (ios->timing == MMC_TIMING_UHS_SDR25)
>>>> 			ctrl_2 |= SDHCI_CTRL_UHS_SDR25;
>>>> 
>>>> 
>>>> 
>>>> 
>>>> 	/*
>>>> 	 * Host Controller needs tuning only in case of SDR104 mode
>>>> 	 * and for SDR50 mode when Use Tuning for SDR50 is set in
>>>> 	 * Capabilities register.
>>>> 	 */
>>>> 	if ( (ctrl & SDHCI_CTRL_UHS_MASK) == SDHCI_CTRL_UHS_SDR104 ||
>>>> 	    ((ctrl & SDHCI_CTRL_UHS_MASK) == SDHCI_CTRL_UHS_SDR50 &&
>>>> 	    (host->flags & SDHCI_SDR50_NEEDS_TUNING)))
>>>> 		ctrl |= SDHCI_CTRL_EXEC_TUNING;
>>>> 	else {
>>>> 		spin_unlock_irqrestore(&host->lock, flags);
>>>> 		return;
>>>> 	}
>>>> 
>>>> 
>>>> 
>>>> add SDHCI_CTRL_UHS_MASK to sdhci.h
>>>> #define SDHCI_CTRL_UHS_MASK  0x7
>>>> 

