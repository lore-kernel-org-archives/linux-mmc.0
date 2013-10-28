From: "Shen, Jackey" <Jackey.Shen@amd.com>
Subject: RE: [PATCH] mmc: sdhci-pci: identify correct base addresses for
 slots
Date: Mon, 28 Oct 2013 02:04:44 +0000
Message-ID: <0C8FBB70FF40A94D98BE847F9C171A9803AD086D@SCYBEXDAG04.amd.com>
References: <1372670535-2778-1-git-send-email-jackey.shen@amd.com>
 <87iowjld5o.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe002.messaging.microsoft.com ([216.32.181.182]:3895
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755375Ab3J1CEw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 27 Oct 2013 22:04:52 -0400
In-Reply-To: <87iowjld5o.fsf@octavius.laptop.org>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi Chris,

> -----Original Message-----
> From: Chris Ball [mailto:cjb@laptop.org]
> Sent: Sunday, October 27, 2013 9:24 AM
> To: Shen, Jackey
> Cc: linux-mmc@vger.kernel.org
> Subject: Re: [PATCH] mmc: sdhci-pci: identify correct base addresses for slots
> 
> Hi Jackey,
> 
> On Mon, Jul 01 2013, Jackey Shen wrote:
> > A PCI Based SD Host Controller can support up to a total of six SD Slots,
> and
> > the base addresses are specified by Slot Information Register of its PCI
> header.
> > Please refer to C.3.3 of SD Host Controller Standard Specification Version
> 3.0.
> 
> Out of curiosity (and for the patch record), do you have hardware that
> requires this patch that you've tested it on, or is it just theoretical?

I just theoretically wrote this patch according to SD spec.

Thanks,
Jackey 

> 
> Thanks,
> 
> - Chris.
> --
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>


