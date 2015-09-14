From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: sdhci: runtime suspend/resume on card insert/removal
Date: Mon, 14 Sep 2015 11:50:14 +0100
Message-ID: <20150914105014.GJ21084@n2100.arm.linux.org.uk>
References: <55F12CF8.50003@linaro.org>
 <20150910153129.07adbe68@xhacker>
 <20150910080233.GH21084@n2100.arm.linux.org.uk>
 <20150910160402.3b78b5c6@xhacker>
 <55F66874.2000609@linaro.org>
 <20150914142838.07ec6a07@xhacker>
 <55F681AC.2010605@linaro.org>
 <20150914161804.101dfc55@xhacker>
 <55F69121.3030700@linaro.org>
 <55F69E4F.8010608@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:47300 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752666AbbINKuY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Sep 2015 06:50:24 -0400
Content-Disposition: inline
In-Reply-To: <55F69E4F.8010608@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Cc: Jisheng Zhang <jszhang@marvell.com>, ulf.hansson@linaro.org, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, nico@fluxnic.net

On Mon, Sep 14, 2015 at 03:45:43PM +0530, Vaibhav Hiremath wrote:
> Came across below lines in the datasheet,
> 
> ========= Copy-n-paste from datasheet============
> 
> All SDH interfaces share the same clock which is enabled when any of the SDH
> clock enables are
> set (from PMUA_SDH1_CLK_RES_CTRL, PMUA_SDH2_CLK_RES_CTRL,
> PMUA_SDH3_CLK_RES_CTRL, PMUA_SDH4_CLK_RES_CTRL,
> PMUA_SDH5_CLK_RES_CTRL), with clock source select and divider ratio
> controlled by
> PMUA_SDH1_CLK_RES_CTRL.
> 
> ==================================================
> 
> 
> And I can confirm that after disabling AXI interface clock for all the
> SDH modules (1-5) I see I get an abort.
> 
> This clearly explains/justifies/proves that the existing code is
> working as expected. I have eMMC mounted on the board, which makes
> clock to always stay ON on SDH3.
> 
> So there is an OR gate implemented inside which takes input from
> SDHx_AXI_EN and feeds back to all SDHx instances. Don't ask me why it
> has been designed that way :)
> 
> And I did some experiment as well, so what I have observed is,
> SDH_AXI_CLOCK is required to generate card detection, without that I do
> not see card detection working.

What that means is that if DT configures the interface to use its
internal card detection, the AXI clock must never shut off when entering
runtime-PM.

Yes, it means you don't get the same savings as you would by turning
off that clock, but that's the choice between using the internal card
detection and a GPIO for this.  The code shouldn't force you to use a
GPIO just because the Linux driver implementation dumbly disables the
AXI clock.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
