From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: omap_hsmmc: set dto to 14 for all devices
Date: Thu, 12 Apr 2012 14:19:23 -0400
Message-ID: <87ehrsrexg.fsf@laptop.org>
References: <1330622780-1909-1-git-send-email-Chase.Maupin@ti.com>
	<m2399iqtgf.fsf@bob.laptop.org>
	<alpine.DEB.2.00.1203120435200.11332@utopia.booyaka.com>
	<87bonxcjrh.fsf@laptop.org> <20120405220848.GF3785@atomide.com>
	<87obr57rmh.fsf@laptop.org>
	<alpine.DEB.2.00.1204051743360.10302@utopia.booyaka.com>
	<87k41t7n13.fsf@laptop.org> <4F86A461.4010006@linaro.org>
	<alpine.DEB.2.00.1204121130370.29473@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:50634 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932923Ab2DLSTV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 12 Apr 2012 14:19:21 -0400
In-Reply-To: <alpine.DEB.2.00.1204121130370.29473@utopia.booyaka.com> (Paul
	Walmsley's message of "Thu, 12 Apr 2012 11:56:06 -0600 (MDT)")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tushar Behera <tushar.behera@linaro.org>, Tony Lindgren <tony@atomide.com>, Chase Maupin <Chase.Maupin@ti.com>, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, sakoman@gmail.com

Hi,

On Thu, Apr 12 2012, Paul Walmsley wrote:
>> With this patch, I continuously get following message on my console.
>> (Tested on Origen board, based on EXYNOS4210).
>> 
>> mmc0: Too large timeout requested for CMD25!
>> 
>> So, with this change, should we update sdhci_calc_timeout() also?
>
> Looks like most of the host drivers that range-check the timeout value 
> silently clamp it at the hardware-supported maximum value:

If I understand correctly, the only problem here is the presence of the
warning, so I'm leaning towards just removing it (which we've already
had another request for) or making it pr_debug() instead.  Sound okay?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
