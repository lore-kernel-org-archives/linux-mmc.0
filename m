From: Scott Wood <scottwood@freescale.com>
Subject: Re: [v3, 4/5] powerpc: dts: t4240: add syscon support for DCFG node
Date: Fri, 11 Dec 2015 02:29:04 -0600
Message-ID: <1449822544.15946.285.camel@freescale.com>
References: <1448594417-22515-1-git-send-email-yangbo.lu@freescale.com>
	 <1448594417-22515-5-git-send-email-yangbo.lu@freescale.com>
	 <1449596781.15946.126.camel@freescale.com>
	 <BLUPR0301MB2065B5878A43F66982D6B30BF2E80@BLUPR0301MB2065.namprd03.prod.outlook.com>
	 <1449635607.15946.165.camel@freescale.com>
	 <BLUPR0301MB206558CB317D48AC5CEF3642F2E80@BLUPR0301MB2065.namprd03.prod.outlook.com>
	 <1449680419.15946.176.camel@freescale.com>
	 <CAPDyKFpMruD0M+JB9jwuk1xTRcVRpJYNh7+DAT+22Tu2orS9wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1bon0146.outbound.protection.outlook.com ([157.56.111.146]:47779
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753901AbbLKI3U (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 11 Dec 2015 03:29:20 -0500
In-Reply-To: <CAPDyKFpMruD0M+JB9jwuk1xTRcVRpJYNh7+DAT+22Tu2orS9wg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Lu Yangbo-B47093 <yangbo.lu@freescale.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Xie Xiaobo-R63061 <X.Xie@freescale.com>, Li Yang-Leo-R58472 <LeoLi@freescale.com>

On Fri, 2015-12-11 at 09:26 +0100, Ulf Hansson wrote:
> [...]
> 
> > > > > The fsl_get_svr() you suggested is also an idea for this.
> > > > > Then, may I know is there a guts driver in kernel?
> > > > > Thanks a lot.
> > > > 
> > > > There isn't, but there should be.
> > > > 
> > > > -Scott
> > > 
> > > [Lu Yangbo-B47093] Ok, I'd like to try. But can you suggest where we
> > > should
> > > put the guts driver in kernel?
> > > Thanks.
> > 
> > drivers/soc/fsl/
> > 
> 
> Okay, go ahead and have a try.
> 
> BTW, there is actually also a corresponding include directory to use
> 
> /include/linux/soc/..

OK, but we already have an include/linux/fsl and not an include/linux/soc/fsl.

-Scott

