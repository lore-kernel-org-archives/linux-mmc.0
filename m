From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: [PATCH] sdhci-esdhc: Make 8BIT bus work.
Date: Wed, 22 Jul 2015 12:32:29 +0000
Message-ID: <1437568349.10831.99.camel@transmode.se>
References: <1437409187-7039-1-git-send-email-joakim.tjernlund@transmode.se>
	 <CAPDyKFpzMrzoY3xDHsMTwOUk0Xkp1d-cY_UW7U0EEfoYQakU0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.transmode.se ([31.15.61.139]:57533 "EHLO smtp.transmode.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964802AbbGVMcf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Jul 2015 08:32:35 -0400
In-Reply-To: <CAPDyKFpzMrzoY3xDHsMTwOUk0Xkp1d-cY_UW7U0EEfoYQakU0A@mail.gmail.com>
Content-Language: en-US
Content-ID: <302D92A090D73F4C959EA7F25BA66199@transmode.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "haokexin@gmail.com" <haokexin@gmail.com>

On Wed, 2015-07-22 at 14:18 +0200, Ulf Hansson wrote:
> On 20 July 2015 at 18:19, Joakim Tjernlund
> <joakim.tjernlund@transmode.se> wrote:
> > Support for 8BIT bus with was added some time ago to sdhci-esdhc but
> > then missed to remove the 8BIT from the reserved bit mask which made
> > 8BIT non functional.
> > 
> > Signed-off-by: Joakim Tjernlund <joakim.tjernlund@transmode.se>
> 
> Should this be queued as a fix then? If so, please resend and include
> a fixes tag.

8BIT never worked for this controller, when support for 8BIT was added no one
noticed that it didn't work for sdhci-esdhc. I suspect it was never tested.

If that qualifies as a fix I can add an:

Fixes: 66b50a00992d ("mmc: esdhc: Add support for 8-bit bus width and non-removable card")

> 
> Kind regards
> Uffe
> 
> > ---
> >  drivers/mmc/host/sdhci-esdhc.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mmc/host/sdhci-esdhc.h b/drivers/mmc/host/sdhci-esdhc.h
> > index 3497cfa..a870c42 100644
> > --- a/drivers/mmc/host/sdhci-esdhc.h
> > +++ b/drivers/mmc/host/sdhci-esdhc.h
> > @@ -45,6 +45,6 @@
> >  #define ESDHC_DMA_SYSCTL       0x40c
> >  #define ESDHC_DMA_SNOOP                0x00000040
> > 
> > -#define ESDHC_HOST_CONTROL_RES 0x05
> > +#define ESDHC_HOST_CONTROL_RES 0x01
> > 
> >  #endif /* _DRIVERS_MMC_SDHCI_ESDHC_H */
> > --
> > 2.3.6
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
