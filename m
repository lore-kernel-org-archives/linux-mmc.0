From: Ram Pai <linuxram@us.ibm.com>
Subject: Re: [PATCH 4/4] PCI: make cardbus-bridge resources nice-to-have
Date: Tue, 21 Jun 2011 09:23:21 -0700
Message-ID: <20110621162321.GB22917@ram-laptop>
References: <1308610037-6261-1-git-send-email-linuxram@us.ibm.com>
 <1308610037-6261-5-git-send-email-linuxram@us.ibm.com>
 <20110621075659.GA4620@comet.dominikbrodowski.net>
Reply-To: Ram Pai <linuxram@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110621075659.GA4620@comet.dominikbrodowski.net>
Sender: linux-pci-owner@vger.kernel.org
To: Dominik Brodowski <linux@dominikbrodowski.net>, Ram Pai <linuxram@us.ibm.com>, jbarnes@virtuousgeek.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, svenkatr@ti.com, ying
List-Id: linux-mmc@vger.kernel.org

On Tue, Jun 21, 2011 at 09:57:00AM +0200, Dominik Brodowski wrote:
> On Mon, Jun 20, 2011 at 03:47:17PM -0700, Ram Pai wrote:
> > Allocate resources to cardbus bridge only after all other genuine
> > resources requests are satisfied. Dont retry if resource allocation
> > for cardbus-bridge fails.
> 
> Well, for those who use cardbus cards, cardbus resources aren't "nice to
> have", they are absolutely required. Of course, not all cardbus cards need
> as many resources as are currently assigned, so I wouldn't oppose a patch
> which marks _some_ of the currently assigned resources as "nice to have".
> But this approach -- 0 required, all "nice to have" -- seems wrong to me.

Do you know how much minimal resource is good enough?  The value, before
this patch, was 256 for IO ports and  64M for memory.

BTW: If the BIOS has already assigned enough resources for all the devices on
the system, no devices will be starved including the cardbus. The OS intervenes
and is forced to make this hard choice only when it sees unassigned resources to
some devices along with resource contention.

RP
