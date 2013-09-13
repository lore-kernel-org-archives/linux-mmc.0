From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 0/3] mmc: omap_hsmmc: get rid of ti,non-removable
Date: Fri, 13 Sep 2013 08:37:33 -0700
Message-ID: <20130913153732.GO7189@atomide.com>
References: <cover.1379066249.git.nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <cover.1379066249.git.nsekhar-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Cc: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Device Tree Mailing List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>, Linux MMC Mailing List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

* Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org> [130913 03:18]:
> Get rid of TI specific binding ti,non-removable in favour of the
> generic binding present for the same purpose.

Looks like there's a different handling in the MMC driver
for no_regulator_off_init that's needed for eMMC. That needs to
be sorted out and tested first.
 
> This patch set does not support the old binding anymore. So, yes,
> it does introduce an ABI breakage. IMHO, it is not really worth
> supporting both bindings ATM since DT-usage in OMAP is still very
> nascent and almost always DTB and uImage are upgraded together.

The old bindings must be supported. It's not like we can just drop
them. We should just keep the old binding and parse it the same way
as the generic binding. That's a minimal amount of code.

After the issue with no_regulator_off_init has been solved, then
we can naturally update the existing .dts files to use the generic
binding.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
