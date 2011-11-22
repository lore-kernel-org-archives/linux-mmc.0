From: David Fries <david@fries.net>
Subject: Re: [PATCH] sdhci-pci register legacy PCI PM or runtime PM not both
Date: Mon, 21 Nov 2011 18:47:47 -0600
Message-ID: <20111122004747.GN24999@spacedout.fries.net>
References: <20111120212951.GA4577@spacedout.fries.net>
 <4ECA1054.6050805@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from SpacedOut.fries.net ([67.64.210.234]:60551 "EHLO
	SpacedOut.fries.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752912Ab1KVArz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Nov 2011 19:47:55 -0500
Content-Disposition: inline
In-Reply-To: <4ECA1054.6050805@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Yunpeng Gao <yunpeng.gao@intel.com>

On Mon, Nov 21, 2011 at 10:48:20AM +0200, Adrian Hunter wrote:
> On 20/11/11 23:29, David Fries wrote:
> > From: David Fries <David@Fries.net>
> > 
> > pci_has_legacy_pm_support says to not register both legacy PM
> > and runtime PM callbacks, modified ifdefs.
> 
> Hasn't this already been done in Chris mmc tree i.e.
> 
> commit f353f593fe449178a8cb01cefe559dba125ab8b1
> Author: Manuel Lauss <manuel.lauss@googlemail.com>
> Date:   Thu Nov 3 11:09:45 2011 +0100
> 
>     mmc: sdhci: remove "state" argument from sdhci_suspend_host

Good call.  It looks like a better solution than what I posted.  I
tried it and it also worked.  I would classify this as a regression in
mainline (suspend didn't used to generate warnings) until a fix is
merged.  I'm good for now, but I doubt I'll be the only one running
into it.

-- 
David Fries <david@fries.net>    PGP pub CB1EE8F0
http://fries.net/~david/
