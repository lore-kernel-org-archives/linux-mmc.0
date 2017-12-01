From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2 0/2] R-Car D3 (r8a77995) SDHI (eMMC) integration
Date: Fri, 1 Dec 2017 09:20:48 +0100
Message-ID: <20171201082048.faekfpx4jrqs3kft@verge.net.au>
References: <1511971606-580-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:60404 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750988AbdLAIVH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 1 Dec 2017 03:21:07 -0500
Content-Disposition: inline
In-Reply-To: <1511971606-580-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: geert@linux-m68k.org, linux-renesas-soc@vger.kernel.org, wsa@the-dreams.de, magnus.damm@gmail.com, linux-mmc@vger.kernel.org, marek.vasut@gmail.com

On Wed, Nov 29, 2017 at 05:06:44PM +0100, Ulrich Hecht wrote:
> Hi!
> 
> This integrates the SDHI hardware on R-Car D3 and enables the Draak board's
> eMMC drive.
> 
> This revision dumps the two patches that have been applied already, fixes
> the sdhi2_pins voltage, removes the redundant SDHI compatible string and
> makes the internal DMAC whitelisting pattern more conservative.
> 
> CU
> Uli
> 
> 
> Ulrich Hecht (2):
>   mmc: renesas_sdhi: enable R-Car D3 (r8a77995) support
>   arm64: dts: r8a77995: draak: enable SDHI2

Hi Ulrich,

what is the effect of applying patch 2/2 without patch 1/2?
I see that 1/2 has been accepted but ideally I'd like to apply
2/2 to a branch without 1/2 present.
