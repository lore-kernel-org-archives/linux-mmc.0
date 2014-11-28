From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: Re: [PATCH] mmc: atmel-mci: use probe deferring if dma controller is
 not ready yet
Date: Fri, 28 Nov 2014 14:53:08 +0100
Message-ID: <20141128135308.GF2714@ldesroches-Latitude-E6320>
References: <CAPDyKFq-0EaGSf9Mn7aMa1s9CCP5hxqRCkKrZrAnSs-h5OFmxw@mail.gmail.com>
 <1416925541-6857-1-git-send-email-ludovic.desroches@atmel.com>
 <CAPDyKFr5GBuWW4UxvAKz6++Qc=wACtn-+c4_s0tNLLjL3mhhMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:43508 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163AbaK1Nwo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Nov 2014 08:52:44 -0500
Content-Disposition: inline
In-Reply-To: <CAPDyKFr5GBuWW4UxvAKz6++Qc=wACtn-+c4_s0tNLLjL3mhhMA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Ludovic Desroches <ludovic.desroches@atmel.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Chris Ball <chris@printf.net>, Nicolas Ferre <nicolas.ferre@atmel.com>, Arnd Bergmann <arnd@arndb.de>

On Fri, Nov 28, 2014 at 12:09:47PM +0100, Ulf Hansson wrote:
> On 25 November 2014 at 15:25, Ludovic Desroches
> <ludovic.desroches@atmel.com> wrote:
> > Return probe defer if requesting a dma channel without a dma controller
> > probed.
> >
> > Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> > ---
> >
> > Hi Ulf,
> >
> > I didn't send the whole set of patches for this small change, tell me if you
> > want a new series.
> 
> I tried to apply the patchset and get two problems.
> 
> 1) This patch 4 has checkpatch errors.

Strange, I did it and I only had a 80 columns warning, I'll check if I
didn't do something wrong.

> 2) I hit conflicts on patch2.
> 

Ok I'll rebase it on your next branch.

> Please resend the complete patchset fixing the above.

Regards

Ludovic
