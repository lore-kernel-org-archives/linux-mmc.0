From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH (mmc-next) 1/3] mmc: add suspend/resume in the
	sdhci-pltfm driver (V3)
Date: Fri, 1 Oct 2010 00:25:26 +0100
Message-ID: <20100930232526.GA29636@void.printf.net>
References: <1285663289-20283-1-git-send-email-peppe.cavallaro@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:36810 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753306Ab0I3XZ1 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 30 Sep 2010 19:25:27 -0400
Content-Disposition: inline
In-Reply-To: <1285663289-20283-1-git-send-email-peppe.cavallaro@st.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Cc: linux-mmc@vger.kernel.org, w.sang@pengutronix.de

Hi Peppe,

On Tue, Sep 28, 2010 at 10:41:27AM +0200, Giuseppe CAVALLARO wrote:
> This patch adds the suspend and resume functions
> in the sdhci-pltfm device driver.
> 
> Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>

Thanks!  I've applied this patchset (1-3) to mmc-next with minor
language changes.

Looks like we're waiting for a version of your STM driver with final
changes from Wolfram's review -- do you think you'll submit that soon?

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
