From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 0/3] mmc: omap_hsmmc: get rid of ti,non-removable
Date: Mon, 16 Sep 2013 17:55:32 +0530
Message-ID: <5236F8BC.1000305@ti.com>
References: <cover.1379066249.git.nsekhar@ti.com> <20130913153732.GO7189@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130913153732.GO7189-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Device Tree Mailing List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>, Linux MMC Mailing List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Friday 13 September 2013 09:07 PM, Tony Lindgren wrote:
> * Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org> [130913 03:18]:
>> Get rid of TI specific binding ti,non-removable in favour of the
>> generic binding present for the same purpose.
> 
> Looks like there's a different handling in the MMC driver
> for no_regulator_off_init that's needed for eMMC. That needs to
> be sorted out and tested first.

Okay. I couldn't really get the eMMC on my board to detect, but
apparently Koen has been able to get it to work. I am not really deep
into details of HSMMC driver so will check with Balaji on what needs to
be done here.

>> This patch set does not support the old binding anymore. So, yes,
>> it does introduce an ABI breakage. IMHO, it is not really worth
>> supporting both bindings ATM since DT-usage in OMAP is still very
>> nascent and almost always DTB and uImage are upgraded together.
> 
> The old bindings must be supported. It's not like we can just drop
> them. We should just keep the old binding and parse it the same way
> as the generic binding. That's a minimal amount of code.

Yes, its minimal amount of code but its code that will very likely never
get exercised in future because of the reasons I mentioned above. I fear
in time we will accumulate a lot of unused code this way.

Anyway, since you don't feel its okay to remove the old binding, I will
go ahead and mark the old binding as deprecated. But perhaps we can
come-up with some time frame within which users of old .dtb can upgrade
their .dtb or consider never upgrading to a newer kernel? This sounds
eerily similar to feature-removal-schedule.txt and yeah I am aware of
what happened to that. But I still put it here since this problem of DTB
compatibility is not going to go away.

One thing that might help is a kernel configuration that does not
support deprecated bindings so users of old dtbs can actually see what
deprecated bindings they are using. This way they can probably plan for
a dtb upgrade better. So in driver you would do something like:

	if (of_support_deprecated_bindings() &&
	    of_find_property(np, "ti,non-removable", NULL)) {
		.. do something ..
	}

of_support_deprecated_bindings() would return based on a config option.

Thanks,
Sekhar

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
