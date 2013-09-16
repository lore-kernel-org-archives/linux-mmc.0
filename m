From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 0/3] mmc: omap_hsmmc: get rid of ti,non-removable
Date: Mon, 16 Sep 2013 18:05:05 +0530
Message-ID: <5236FAF9.9070303@ti.com>
References: <cover.1379066249.git.nsekhar@ti.com> <20130913153732.GO7189@atomide.com> <52338CB2.1040100@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <52338CB2.1040100-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Device Tree Mailing List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>, Linux MMC Mailing List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Saturday 14 September 2013 03:37 AM, Balaji T K wrote:
> On Friday 13 September 2013 09:07 PM, Tony Lindgren wrote:
>> * Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org> [130913 03:18]:
>>> Get rid of TI specific binding ti,non-removable in favour of the
>>> generic binding present for the same purpose.
>>
>> Looks like there's a different handling in the MMC driver
>> for no_regulator_off_init that's needed for eMMC. That needs to
>> be sorted out and tested first.
>>
> Hi Sekhar,
> 
> no_regulator_off_init is needed for eMMC detection on omap4 platforms.

Okay, and the code currently does:

	if (of_find_property(np, "non-removable", NULL)) {
		pdata->slots[0].nonremovable = true;
		pdata->slots[0].no_regulator_off_init = true;
	}

Is there anything else that needs to be done?

Thanks,
Sekhar

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
