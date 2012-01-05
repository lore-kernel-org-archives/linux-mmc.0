From: Aaron Lu <aaron.lu@amd.com>
Subject: Re: sdhci max_blk_size
Date: Thu, 5 Jan 2012 09:16:35 +0800
Message-ID: <20120105011634.GA32160@ladygaga>
References: <4F0469B3.9080400@parrot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:35166 "EHLO
	TX2EHSOBE007.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757459Ab2AEBQq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Jan 2012 20:16:46 -0500
Content-Disposition: inline
In-Reply-To: <4F0469B3.9080400@parrot.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matthieu CASTET <matthieu.castet@parrot.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Wed, Jan 04, 2012 at 04:01:07PM +0100, Matthieu CASTET wrote:
> Hi,
> 
> our controller set "Max Block Length" to 3 (4096 byte), but the linux driver
> ignore this value [1].
> 
> Is there any reason to do that .

The reason is, sd host controller spec defines 3 as reserved, not 4096.

> Or it is code that was written with an older sdhci spec, and we can ignore this
> check today.

The current sdhci driver follows v3 spec, is the v4 spec out that
defined this bit?

> 
> 
> 
> Matthieu
> 
> PS : please keep me in CC.
> 
> [1]
> if (mmc->max_blk_size >= 3) {
>             pr_warning("%s: Invalid maximum block size, "
>                 "assuming 512 bytes\n", mmc_hostname(mmc));
>             mmc->max_blk_size = 0;
>         }
> --

