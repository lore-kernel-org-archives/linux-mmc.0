From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH v2] tmio_mmc: Allow 2 byte requests in 4-bit mode
Date: Fri, 10 Sep 2010 18:58:23 +0200
Message-ID: <20100910165821.GO2561@sortiz-mobl>
References: <6c0f551ff67fb9f67f4b565fbe4ffdc1f4c8bc49.1283164379.git.matt@console-pimps.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:19416 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755536Ab0IJQ6E (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 10 Sep 2010 12:58:04 -0400
Content-Disposition: inline
In-Reply-To: <6c0f551ff67fb9f67f4b565fbe4ffdc1f4c8bc49.1283164379.git.matt@console-pimps.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matt Fleming <matt@console-pimps.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mmc@vger.kernel.org, Yusuke Goda <yusuke.goda.sx@renesas.com>, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, Arnd Hannemann <arnd@arndnet.de>, Ian Molton <ian@mnementh.co.uk>

Hi Matt,

On Mon, Aug 30, 2010 at 11:50:19AM +0100, Matt Fleming wrote:
> From: Yusuke Goda <yusuke.goda.sx@renesas.com>
> 
> Adjust the tmio_mmc block size check to accept 2-byte requests in 4-bit
> mode if the hardware supports it.
> 
> Tested with the SDHI hardware block included in sh7724.
> 
> Signed-off-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
> Signed-off-by: Matt Fleming <matt@console-pimps.org>
> ---
> 
> Andrew, I've added some code to Yusuke's original patch based on
> feedback from Ian Molton saying that the original change didn't work on
> his hardware. I'd really prefer some Tested-by's and Acked-by's before
> you take this patch just so we can make sure that everybody is happy and
> that everybody's hardware still works.
> 
> Magnus was worried that this patch would conflict with the SDHI/MMCIF
> hotplug patches from Arnd (particularly "[PATCH 1/4] tmio_mmc: Allow the
> mfd driver to specify get_cd handler") but I seem to be able to shuffle
> the patches around without any conflicts.
As I'm carrying Arnd patches through my MFD tree, I'm also taking this one.
I applied it while we're waiting for Ian to comment on it.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
