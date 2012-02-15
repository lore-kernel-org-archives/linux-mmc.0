From: Danny Kukawka <danny.kukawka@bisect.de>
Subject: Re: [PATCH] sdhci-tegra: fix linux/module.h included twice
Date: Wed, 15 Feb 2012 21:45:42 +0100
Message-ID: <201202152145.43344.danny.kukawka@bisect.de>
References: <1329328466-4627-1-git-send-email-danny.kukawka@bisect.de> <4F3C032D.7080905@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:46544 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754280Ab2BOUqr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Feb 2012 15:46:47 -0500
In-Reply-To: <4F3C032D.7080905@windriver.com>
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Chris Ball <cjb@laptop.org>, Olof Johansson <olof@lixom.net>, Stephen Warren <swarren@nvidia.com>, Russell King <rmk+kernel@arm.linux.org.uk>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On Mittwoch, 15. Februar 2012, Paul Gortmaker wrote:
> On 12-02-15 12:54 PM, Danny Kukawka wrote:
> > Remove double include of linux/module.h.
> >
> > Signed-off-by: Danny Kukawka <danny.kukawka@bisect.de>
>
> Hi Danny,
>
> We've already got these covered all in one go.
>
> https://lkml.org/lkml/2012/2/4/134

Okay, I checked mainline and linux-next and did a fast search over the Subject 
on the ML and couldn't find these fixes. 

Where they already applied to a tree?

Then you may want to ignore these of my mails:
- [PATCH] sdhci-tegra: fix linux/module.h included twice
- [PATCH] dwc3: linux/module.h included twice
  -> https://lkml.org/lkml/2012/2/15/309
- [PATCH] drivers/dma: linux/module.h included twice
  -> https://lkml.org/lkml/2012/2/15/351
- [PATCH] adp1653: included linux/module.h twice
  -> https://lkml.org/lkml/2012/2/15/352
- [PATCH] Staging: sm7xx/smtcfb.c included linux/module.h twice
  -> https://lkml.org/lkml/2012/2/15/355

Danny
