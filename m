From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH v2 2/3] sdhci-pci : Enable runtime PM support
Date: Fri, 25 Feb 2011 14:54:40 +0000
Message-ID: <20110225145440.GA31620@srcf.ucam.org>
References: <cover.1297014479.git.pierre.tardy@intel.com> <6722fa7986194808f4d69a1e5ba6d3f163b77da9.1297014479.git.pierre.tardy@intel.com> <20110210043718.GA7585@void.printf.net> <AANLkTi=iZ3dzAoRuRdpvQ=uBp4u8O8LtMuu2XdSWeZwr@mail.gmail.com> <20110221204523.GA28419@void.printf.net> <8250E4885F9967469CAC3FB5CBA2CE69935212DEA0@irsmsx501.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:34488 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753792Ab1BYOy5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Feb 2011 09:54:57 -0500
Content-Disposition: inline
In-Reply-To: <8250E4885F9967469CAC3FB5CBA2CE69935212DEA0@irsmsx501.ger.corp.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Tardy, Pierre" <pierre.tardy@intel.com>
Cc: Chris Ball <cjb@laptop.org>, Pierre Tardy <tardyp@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Gao, Yunpeng" <yunpeng.gao@intel.com>

On Fri, Feb 25, 2011 at 07:33:12AM +0000, Tardy, Pierre wrote:

> My understanding is the pci driver is not supposed to do any set_power_state/pci_save_state/wake_enable.
> Everything is supposed to be generically handle by pci frameworks's runtime_pm impl.
> Need confirmation from Rafael.

The core can only enable PME generation, it can't configure what 
generates PMEs. There's a register in sdhci that needs to be programmed 
to enable wakeups on card insert/removal/interrupt. If you don't then 
you won't get a PME no matter what the core does.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
