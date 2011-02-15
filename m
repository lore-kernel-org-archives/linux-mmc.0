From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 01/12] mmc: sdhci: add support for auto CMD23
Date: Tue, 15 Feb 2011 15:58:35 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1102151556450.14920@xanadu.home>
References: <1297762510-2696-1-git-send-email-arindam.nath@amd.com>
 <1297762510-2696-2-git-send-email-arindam.nath@amd.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:56680 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751894Ab1BOU6j (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Feb 2011 15:58:39 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MRZ20.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LGO00AVIFL9QT50@VL-MR-MRZ20.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Tue, 15 Feb 2011 15:58:22 -0500 (EST)
In-reply-to: <1297762510-2696-2-git-send-email-arindam.nath@amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arindam Nath <arindam.nath@amd.com>
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org, henry.su@amd.com, aaron.lu@amd.com, anath.amd@gmail.com

On Tue, 15 Feb 2011, Arindam Nath wrote:

> Host Controller v3.00 and later support Auto CMD23 in the Transfer
> Mode register. Since Auto CMD23 can be used with or without DMA,
> and if used with DMA, it should _only_ be ADMA, we check against
> SDHCI_USE_SDMA not being set. This flag is reset when SDHCI_USE_ADMA
> is set.
> 
> A new definition for SDHCI_ARGUMENT2 register has been added
> in v3.00 spec, which is the same as SDHCI_DMA_ADDRESS. We program the
> block count for CMD23 in SDHCI_ARGUMENT2, so we don't need CMD12 to
> stop multiple block transfers. But during error recovery procedure,
> we will need to send Abort command, so we use a global variable
> abort_cmd to save the stop command to be used later.

This is wrong.  Don't use global variables for such things.  Imagine 
what might happen if you have more than one sdhci controller in a 
system. This is a per instance issue certainly not a global driver 
issue.


Nicolas
