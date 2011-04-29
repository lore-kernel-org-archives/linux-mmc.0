From: "Nath, Arindam" <Arindam.Nath@amd.com>
Subject: RE: [PATCH] mmc: eMMC signal voltage does not use CMD11
Date: Fri, 29 Apr 2011 00:52:03 -0500
Message-ID: <6C03668EAF45B747AF947A1603D1B300EB8DFE3B@SAUSEXMBP01.amd.com>
References: <ABE44455-4F1B-45A2-AED9-150C8E5DBED0@marvell.com>
 <6C03668EAF45B747AF947A1603D1B300EB72D36F@SAUSEXMBP01.amd.com>
 <390DC252-295C-4B82-8D5F-43E92EA5D3AF@marvell.com>
 <E389301A-B40E-4857-8678-DC806A710BB7@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:28416 "EHLO
	TX2EHSOBE007.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751674Ab1D2FwI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Apr 2011 01:52:08 -0400
In-Reply-To: <E389301A-B40E-4857-8678-DC806A710BB7@marvell.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi Philip,


> -----Original Message-----
> From: Philip Rakity [mailto:prakity@marvell.com]
> Sent: Friday, April 29, 2011 4:16 AM
> To: Nath, Arindam
> Cc: linux-mmc@vger.kernel.org
> Subject: Re: [PATCH] mmc: eMMC signal voltage does not use CMD11
> 
> 
> Hi Arindam,
> 
> Since this mmc_set_signal_voltage() routine will be used by SDIO and
> MMC should the code be moved
> the code core.c ?

Yes, mmc_set_signal_voltage() should be moved to core.c to support SDIO and MMC. Do you want me to do it, or you want to make the changes when posting eMMC patches?

> 
> I am not sure about drive strength or driver type since SDIO handles
> these differently then SD.

I don't think there is much difference in setting Bus Speed Mode and Driver Strength for SDIO3.0 cards, but seems like setting the Current Limit will be a little different from SD3.0. We can work on it after the base support is in the kernel, if that's okay with you.

Thanks,
Arindam


