From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/3] mmc: sdhci-of-esdhc: add workaround for T4240
 incorrect HOSTVER value
Date: Fri, 24 Jul 2015 21:27:22 -0500
Message-ID: <1437791242.2993.268.camel@freescale.com>
References: <1437471937-34218-1-git-send-email-yangbo.lu@freescale.com>
	 <CAPDyKFpf6Ayw28dmbHhLJ8HSOSie60sUjaAnK7qqONHsRN4BDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2on0113.outbound.protection.outlook.com ([207.46.100.113]:57326
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753030AbbGYC1e (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 24 Jul 2015 22:27:34 -0400
In-Reply-To: <CAPDyKFpf6Ayw28dmbHhLJ8HSOSie60sUjaAnK7qqONHsRN4BDA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Yangbo Lu <yangbo.lu@freescale.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, linux-mmc <linux-mmc@vger.kernel.org>

On Tue, 2015-07-21 at 15:02 +0200, Ulf Hansson wrote:
> On 21 July 2015 at 11:45, Yangbo Lu <yangbo.lu@freescale.com> wrote:
> > For T4240-R1.0-R2.0, the HOSTVER register has incorrcet vender
> > version value and sdhc spec version value. This will break down
> > the ADMA data transfer. So add workaround to get right value
> > VVN=0x13, SVN = 0x1.
> 
> So T4240-R1.0-R2.0 is the version of the controller, right?
> 
> If I understand correct you are checking what CPU/SoC you are running
> on, to figure out which controller version you are using, as that
> can't be fetched (trusted) from the registers of the esdhc controller
> itself!?
> 
> Instead, you could deal with this directly in the DTS files. I assume
> you have some DTS file for each SoC/board variant, right?

No, we do not have a separate DTS file for each revision of an SoC -- and if 
we did, we'd constantly have people using the wrong one.

> In principle, in your DTS file specific for the board/SoC that holds
> the T4240-R1.0-R2.0 version of the controller, should add a specific
> esdhc DT property to indicate this errata.

No, because (in addition to the above issue about chip revisions) the device 
tree is stable ABI and errata are often discovered after device trees are 
deployed.

-Scott

