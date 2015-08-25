From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: [PATCH v2] mmc: sdhci-of-esdhc: add workaround for pre divider
 initial value
Date: Tue, 25 Aug 2015 12:21:35 +0000
Message-ID: <1440505294.3349.61.camel@transmode.se>
References: <1439261614-38605-1-git-send-email-yangbo.lu@freescale.com>
	 <CAPDyKFpxcDWARoHhWejg69LxukjctB2iFdECYdSj23-cFjwMhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.transmode.se ([31.15.61.139]:50370 "EHLO smtp.transmode.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754657AbbHYMVh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Aug 2015 08:21:37 -0400
In-Reply-To: <CAPDyKFpxcDWARoHhWejg69LxukjctB2iFdECYdSj23-cFjwMhQ@mail.gmail.com>
Content-Language: en-US
Content-ID: <BACBF1FB9465544C896E8C0520BDC9EB@transmode.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "yangbo.lu@freescale.com" <yangbo.lu@freescale.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Tue, 2015-08-25 at 14:05 +0200, Ulf Hansson wrote:
> On 11 August 2015 at 04:53, Yangbo Lu <yangbo.lu@freescale.com> wrote:
> > For eSDHC(version < 2.3), the pre divider only could divide base clock
> > by 2 at least. Add workaround for this to avoid unexpected issue.
> > 
> > Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
> 
> Thanks, applied for next!

This should go to linus now for 4.2 as master is broken.
