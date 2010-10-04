From: Peppe CAVALLARO <peppe.cavallaro@st.com>
Subject: Re: [PATCH (mmc-next) 1/3] mmc: add suspend/resume in the
	sdhci-pltfm driver (V3)
Date: Mon, 4 Oct 2010 07:36:56 +0200
Message-ID: <4CA967F8.9030005@st.com>
References: <1285663289-20283-1-git-send-email-peppe.cavallaro@st.com>
 <20100930232526.GA29636@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog108.obsmtp.com ([207.126.144.125]:40059 "EHLO
	eu1sys200aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752017Ab0JDFhY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 4 Oct 2010 01:37:24 -0400
In-Reply-To: <20100930232526.GA29636@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "w.sang@pengutronix.de" <w.sang@pengutronix.de>

Hi Chris.

On 10/01/2010 01:25 AM, Chris Ball wrote:
> Looks like we're waiting for a version of your STM driver with final
> changes from Wolfram's review -- do you think you'll submit that soon?

Concerning the stm driver I've a doubt: currently on our platforms I can
use both the sdhci-stm and sdhci-pltfm drivers. The former is not
strictly necessary at this moment because the sdhci-pltfm works fine.
In the near future I'll have to start using SDIO and eMMC devices.
I wonder if I'll be able to continue to use the platform driver or if
I'll need to actually have own driver (to solve specific limits/features
.... due to our Hw) or if we'll extend the sdhci-pltfm d.d.

What do you think?
In any case, no problem to rework and send the sdhci-stm driver again.

Peppe


> - Chris.
> --
> Chris Ball <cjb@laptop.org> <http://printf.net/>
> One Laptop Per Child
> 
