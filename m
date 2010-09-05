From: Matt Fleming <matt@console-pimps.org>
Subject: Re: [PATCH v2] tmio_mmc: Allow 2 byte requests in 4-bit mode
Date: Sun, 5 Sep 2010 21:08:02 +0100
Message-ID: <20100905200802.GA15420@console-pimps.org>
References: <6c0f551ff67fb9f67f4b565fbe4ffdc1f4c8bc49.1283164379.git.matt@console-pimps.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arkanian.console-pimps.org ([212.110.184.194]:35800 "EHLO
	arkanian.console-pimps.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754344Ab0IEUIF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 5 Sep 2010 16:08:05 -0400
Content-Disposition: inline
In-Reply-To: <6c0f551ff67fb9f67f4b565fbe4ffdc1f4c8bc49.1283164379.git.matt@console-pimps.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ian Molton <ian@mnementh.co.uk>
Cc: linux-mmc@vger.kernel.org, Yusuke Goda <yusuke.goda.sx@renesas.com>, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, Arnd Hannemann <arnd@arndnet.de>, Samuel Ortiz <sameo@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>

On Mon, Aug 30, 2010 at 11:50:19AM +0100, Matt Fleming wrote:
> From: Yusuke Goda <yusuke.goda.sx@renesas.com>
> 
> Adjust the tmio_mmc block size check to accept 2-byte requests in 4-bit
> mode if the hardware supports it.
> 
> Tested with the SDHI hardware block included in sh7724.

Ian, have you had a chance to test this yet?
