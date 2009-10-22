From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: msm_sdcc.c: add missing include
Date: Thu, 22 Oct 2009 19:51:26 +0100
Message-ID: <20091022185126.GA4401@n2100.arm.linux.org.uk>
References: <20091022072119.GA3285@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:36120 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751675AbZJVSvb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Oct 2009 14:51:31 -0400
Content-Disposition: inline
In-Reply-To: <20091022072119.GA3285@elf.ucw.cz>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-mmc@vger.kernel.org, kernel list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On Thu, Oct 22, 2009 at 09:21:19AM +0200, Pavel Machek wrote:
> 
> Add missing include for	msm_sdcc compilation.
> 
> Signed-off-by: Pavel Machek <pavel@ucw.cz>

I don't think this is the right solution - why should MSM have a
platform specific include in the ARM generic include files?

(If anything, we should be getting rid of any non-shared platform
specific includes in the arch/arm/include/asm/mach directory.)
