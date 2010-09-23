From: Peppe CAVALLARO <peppe.cavallaro@st.com>
Subject: Re: [PATCH] mmc: add SDHCI driver for STM platforms (V2)
Date: Thu, 23 Sep 2010 08:48:42 +0200
Message-ID: <4C9AF84A.9010402@st.com>
References: <1284970817-11293-1-git-send-email-peppe.cavallaro@st.com>
 <20100920083842.GA4058@pengutronix.de> <4C98792C.5000900@st.com>
 <20100921094457.GD3168@pengutronix.de> <4C9A0518.3090904@st.com>
 <20100922141223.GF2693@pengutronix.de> <4C9A1427.7030806@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog102.obsmtp.com ([207.126.144.113]:52374 "EHLO
	eu1sys200aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752855Ab0IWGth convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 23 Sep 2010 02:49:37 -0400
In-Reply-To: <4C9A1427.7030806@st.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "matt@console-pimps.org" <matt@console-pimps.org>

On 09/22/2010 04:35 PM, Peppe CAVALLARO wrote:
> No it's not late but I need the dev structure from the platform_device.
> We could add the "struct device dev;" in the sdhci_host structure
> instead of.
> In this case the sdhci_host should be moved within the new
> include/linux/mmc/sdhci.h file.
> Indeed, this could make sense because the drivers/mmc/host/sdhci.h will
> only have the HW register configuration. Shared macros (quirks) and
> structures among sdhci driver based could be moved in
> include/linux/mmc/sdhci.h header.
> 
> What do you think?


Hello!
I've just something working on my ST Linux box (ST40 CPU).
I mean that I'm using the sdhci-pltfm driver with some of the
modifications discussed in this thread.

I'll post some patches asap.

Pepep
