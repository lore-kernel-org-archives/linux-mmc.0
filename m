From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: Regarding mmc: queue: let host controllers specify maximum discard
 timeout
Date: Wed, 08 Feb 2012 09:52:53 +0200
Message-ID: <4F3229D5.8010906@intel.com>
References: <CAMKhXhmHvdxsQjm1UzQtqzcPn_mGByW4eJ7XBCBYH63CpPd8pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:63714 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754824Ab2BHHwt (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 8 Feb 2012 02:52:49 -0500
In-Reply-To: <CAMKhXhmHvdxsQjm1UzQtqzcPn_mGByW4eJ7XBCBYH63CpPd8pw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shridhar Rasal <shri.rasal@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 07/02/12 18:33, Shridhar Rasal wrote:
> I was verifying/testing *make_ext4fs* command on android with wipe option.    
> */_
> _/*
> $] make_ext4fs -w <device-path>
> 
> This is taking long time (2 hrs) with Kernel 3.1 code compared to Kernel
> 2.39 (1 min)
> 
> With more debugging, found that  patch [mmc: queue: let host controllers
> specify maximum discard timeout] is culprit.
> 
> In my case following code is executed and [max_discard] always set to
> [card->pref_erase] which is always 4096 and set far less than set in through
> K2.39.
> 
> */+	if (mmc_card_mmc(card) && !(card->ext_csd.erase_group_def & 1))
> +		return card->pref_erase;/*
> 
> *I have verified by, hard coding [max_discard] to [UINT_MAX], it take around
> same time as K2.39.*
> 
> 1. Is there any other patch required in controller apart from this.
> 2. Why are we returning [card->pref_erase] above, can we use some other
> bigger/SpecFollowed/preferred value?
> 3. Any other work around?

One possibility is to enable high-capacity erase size.  There is a patch I
sent very recently that allows the driver to enable it:

	http://permalink.gmane.org/gmane.linux.kernel.mmc/12691

Then you also need to set the capability flag e.g. this is for Medfield eMMC:

	http://permalink.gmane.org/gmane.linux.kernel.mmc/12692

If you try that please enable the following debugging message to see what
the calculation produces:

    pr_debug("%s: calculated max. discard sectors %u for timeout %u ms\n",
		 mmc_hostname(host), max_discard, host->max_discard_to);

Another alternative is to add a quirk to sdhci.c to set max_discard_to to
zero e.g. in sdhci_add_host()

	mmc->max_discard_to = (1 << 27) / host->timeout_clk;
+	if (host->quirks2 & SDHCI_QUIRK2_NO_MAX_DISCARD_TO)
		mmc->max_discard_to;

Then you would need to define the quirk and set it for your host controller.
