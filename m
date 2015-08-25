From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: [PATCH v2] mmc: sdhci-of-esdhc: add workaround for pre divider
 initial value
Date: Tue, 25 Aug 2015 14:00:35 +0000
Message-ID: <1440511235.3349.74.camel@transmode.se>
References: <1439261614-38605-1-git-send-email-yangbo.lu@freescale.com>
	 <CAPDyKFpxcDWARoHhWejg69LxukjctB2iFdECYdSj23-cFjwMhQ@mail.gmail.com>
	 <1440505294.3349.61.camel@transmode.se>
	 <CAPDyKFpYAkU4JKE+RoM0ru2g8EpqwokoK7OLbSW9fXy+b3Z3xQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.transmode.se ([31.15.61.139]:58722 "EHLO smtp.transmode.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751316AbbHYOAi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Aug 2015 10:00:38 -0400
In-Reply-To: <CAPDyKFpYAkU4JKE+RoM0ru2g8EpqwokoK7OLbSW9fXy+b3Z3xQ@mail.gmail.com>
Content-Language: en-US
Content-ID: <9A06895F0ACD3747BF095BE0566C8E3C@transmode.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "yangbo.lu@freescale.com" <yangbo.lu@freescale.com>

On Tue, 2015-08-25 at 15:56 +0200, Ulf Hansson wrote:
> On 25 August 2015 at 14:21, Joakim Tjernlund
> <joakim.tjernlund@transmode.se> wrote:
> > On Tue, 2015-08-25 at 14:05 +0200, Ulf Hansson wrote:
> > > On 11 August 2015 at 04:53, Yangbo Lu <yangbo.lu@freescale.com> wrote:
> > > > For eSDHC(version < 2.3), the pre divider only could divide base clock
> > > > by 2 at least. Add workaround for this to avoid unexpected issue.
> > > > 
> > > > Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
> > > 
> > > Thanks, applied for next!
> > 
> > This should go to linus now for 4.2 as master is broken.
> 
> That wasn't obvious while reading the change log.

hmm, it was visible in the mail thread I think.

> 
> I don't intend to send any more PR with fixes for 4.2, but we could
> apply a fixes tag if there is regression involved. Can you point me to
> the commit it fixes?

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/mmc/host?id=bd455029d01cb55dca6
2129282466ccea3698813
