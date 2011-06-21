From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH 4/4] PCI: make cardbus-bridge resources nice-to-have
Date: Tue, 21 Jun 2011 09:57:00 +0200
Message-ID: <20110621075659.GA4620@comet.dominikbrodowski.net>
References: <1308610037-6261-1-git-send-email-linuxram@us.ibm.com>
 <1308610037-6261-5-git-send-email-linuxram@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1308610037-6261-5-git-send-email-linuxram@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ram Pai <linuxram@us.ibm.com>
Cc: jbarnes@virtuousgeek.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, svenkatr@ti.com, yinghai@kernel.org, cjb@laptop.org, linux-pci@vger.kernel.org, linux-net-drivers@solarflare.com, bhutchings@solarflare.com
List-Id: linux-mmc@vger.kernel.org

On Mon, Jun 20, 2011 at 03:47:17PM -0700, Ram Pai wrote:
> Allocate resources to cardbus bridge only after all other genuine
> resources requests are satisfied. Dont retry if resource allocation
> for cardbus-bridge fails.

Well, for those who use cardbus cards, cardbus resources aren't "nice to
have", they are absolutely required. Of course, not all cardbus cards need
as many resources as are currently assigned, so I wouldn't oppose a patch
which marks _some_ of the currently assigned resources as "nice to have".
But this approach -- 0 required, all "nice to have" -- seems wrong to me.

Best,
	Dominik
