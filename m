From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH v3 0/4] Add device tree probe for sdhci-esdhc-imx
Date: Sun, 10 Jul 2011 09:37:09 +0800
Message-ID: <20110710013708.GA14492@S2100-06.ap.freescale.net>
References: <1309970870-13336-1-git-send-email-shawn.guo@linaro.org>
 <m2pqljje3w.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from db3ehsobe003.messaging.microsoft.com ([213.199.154.141]:25914
	"EHLO DB3EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751467Ab1GJBai (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 9 Jul 2011 21:30:38 -0400
Content-Disposition: inline
In-Reply-To: <m2pqljje3w.fsf@bob.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Shawn Guo <shawn.guo@linaro.org>, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org

Hi Chris,

On Sat, Jul 09, 2011 at 06:14:43PM -0400, Chris Ball wrote:
> Hi Shawn,
> 
> On Wed, Jul 06 2011, Shawn Guo wrote:
> > The first patch copies platform data into driver private data, and
> > do not reference platform data after probe.  The second one removes
> > the uses of cpu_is_mx().  The third one makes a dt related fix on
> > sdhci-pltfm.c, and the last one adds actual device tree probe for
> > sdhci-esdhc-imx driver.
> >
> > Changes since v2:
> >  * Add patch #1
> >  * Do not use Linux details of cd-type and wp-type for binding
> >
> > Changes since v1:
> >  * Address review comments given by Grant
> >
> > Shawn Guo (4):
> >       mmc: sdhci-esdhc-imx: do not reference platform data after probe
> >       mmc: sdhci-esdhc-imx: get rid of the uses of cpu_is_mx()
> >       mmc: sdhci-pltfm: dt device does not pass parent to sdhci_alloc_host
> >       mmc: sdhci-esdhc-imx: add device tree probe support
> 
> These don't apply against mmc-next -- what is your tree based on?
> 
It's based on linux-next with following patch applied.

[PATCH v4 4/4] mmc: sdhci-esdhc-imx: extend card_detect and write_protect support for mx5
http://permalink.gmane.org/gmane.linux.kernel.mmc/8748

You applied the 3 of 4 patches in that series, and expect Sascha to
send this one through his tree after you send those 3.

Now, we got another series pending in the line.

I'm wondering if it works that I create a branch off your mmc-next,
merge Sascha's next, apply my patches on top it, and then send a pull
request for you (and Sascha) to pull the branch.

-- 
Regards,
Shawn

