From: Peppe CAVALLARO <peppe.cavallaro@st.com>
Subject: Re: [PATCH] mmc: add SDHCI driver for STM platforms.
Date: Mon, 20 Sep 2010 10:21:12 +0200
Message-ID: <4C971978.5020800@st.com>
References: <1280392279-17406-1-git-send-email-peppe.cavallaro@st.com>
 <107012446AC13D4C90B85672EAF5FB0E9C2E08E16C@SAFEX1MAIL3.st.com>
 <20100802134050.GA7944@console-pimps.org>
 <107012446AC13D4C90B85672EAF5FB0E9C2E08E20E@SAFEX1MAIL3.st.com>
 <20100802143631.GB7944@console-pimps.org>
 <20100803152119.0df3d55c.akpm@linux-foundation.org>
 <107012446AC13D4C90B85672EAF5FB0E9C2E08E340@SAFEX1MAIL3.st.com>
 <20100803224425.bf7c4c43.akpm@linux-foundation.org>
 <107012446AC13D4C90B85672EAF5FB0E9C2E08E343@SAFEX1MAIL3.st.com>
 <20100804080302.GA25587@console-pimps.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog104.obsmtp.com ([207.126.144.117]:36312 "EHLO
	eu1sys200aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752719Ab0ITIWI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 20 Sep 2010 04:22:08 -0400
In-Reply-To: <20100804080302.GA25587@console-pimps.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matt Fleming <matt@console-pimps.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 08/04/2010 10:03 AM, Matt Fleming wrote:
> On Wed, Aug 04, 2010 at 07:47:21AM +0200, Peppe CAVALLARO wrote:
>  >
>  > Yes, we can do it. The driver will be merged next. It is not a problem
>  > for me ;-).
> 
> Fantastic!
> 

Hello Matt, Andrew,
I've just reworked the driver removing the invocation to the own
devm_stm_pad_claim function (because it's not yet included in Linus Kernel).
In the new patch, (v2) the claim of the resources is through the platform.

Please let me know if it's ok for you.

Regards,
Giuseppe
