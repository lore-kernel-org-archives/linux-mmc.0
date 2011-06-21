From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH 4/4] PCI: make cardbus-bridge resources nice-to-have
Date: Tue, 21 Jun 2011 14:36:22 -0700
Message-ID: <20110621143622.1fae90b3@jbarnes-desktop>
References: <1308610037-6261-1-git-send-email-linuxram@us.ibm.com>
	<1308610037-6261-5-git-send-email-linuxram@us.ibm.com>
	<20110621075659.GA4620@comet.dominikbrodowski.net>
	<20110621162321.GB22917@ram-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from oproxy4-pub.bluehost.com ([69.89.21.11]:55028 "HELO
	oproxy4-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751613Ab1FUVga (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Jun 2011 17:36:30 -0400
In-Reply-To: <20110621162321.GB22917@ram-laptop>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ram Pai <linuxram@us.ibm.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, svenkatr@ti.com, yinghai@kernel.org, cjb@laptop.org, linux-pci@vger.kernel.org, linux-net-drivers@solarflare.com, bhutchings@solarflare.com

On Tue, 21 Jun 2011 09:23:21 -0700
Ram Pai <linuxram@us.ibm.com> wrote:

> On Tue, Jun 21, 2011 at 09:57:00AM +0200, Dominik Brodowski wrote:
> > On Mon, Jun 20, 2011 at 03:47:17PM -0700, Ram Pai wrote:
> > > Allocate resources to cardbus bridge only after all other genuine
> > > resources requests are satisfied. Dont retry if resource allocation
> > > for cardbus-bridge fails.
> > 
> > Well, for those who use cardbus cards, cardbus resources aren't "nice to
> > have", they are absolutely required. Of course, not all cardbus cards need
> > as many resources as are currently assigned, so I wouldn't oppose a patch
> > which marks _some_ of the currently assigned resources as "nice to have".
> > But this approach -- 0 required, all "nice to have" -- seems wrong to me.
> 
> Do you know how much minimal resource is good enough?  The value, before
> this patch, was 256 for IO ports and  64M for memory.
> 
> BTW: If the BIOS has already assigned enough resources for all the devices on
> the system, no devices will be starved including the cardbus. The OS intervenes
> and is forced to make this hard choice only when it sees unassigned resources to
> some devices along with resource contention.

Dominik, presumably you have a few good cardbus test machines; can you
give Ram's patches a try?  If we know they break existing
configurations, I'm afraid we'll just have to revert the whole
re-allocation patch yet again.  If your stuff survives, I'll ping Linus
to see what he thinks, though he'll probably want to revert in any
case...

Thanks,
-- 
Jesse Barnes, Intel Open Source Technology Center
