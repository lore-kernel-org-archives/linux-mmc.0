From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH 4/4] mmc: sdhci-esdhc-imx: extend card_detect and
 write_protect support
Date: Sat, 11 Jun 2011 19:50:33 +0800
Message-ID: <20110611115031.GA29093@S2100-06.ap.freescale.net>
References: <1307702572-22066-1-git-send-email-shawn.guo@linaro.org>
 <1307702572-22066-5-git-send-email-shawn.guo@linaro.org>
 <87boy4lnp9.fsf@lebrac.rtp-net.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe006.messaging.microsoft.com ([216.32.180.16]:40871
	"EHLO VA3EHSOBE009.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754547Ab1FKLrk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 11 Jun 2011 07:47:40 -0400
Content-Disposition: inline
In-Reply-To: <87boy4lnp9.fsf@lebrac.rtp-net.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnaud Patard <arnaud.patard@rtp-net.org>
Cc: Shawn Guo <shawn.guo@linaro.org>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Wolfram Sang <w.sang@pengutronix.de>, Eric Benard <eric@eukrea.com>, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, patches@linaro.org

On Sat, Jun 11, 2011 at 11:30:42AM +0200, Arnaud Patard wrote:
> Shawn Guo <shawn.guo@linaro.org> writes:
> 
> Hi,
> 
> > The patch extends card_detect and write_protect support to get mx5
> > family and more scenarios supported.  The changes include:
> >
> >  * Turn platform_data from optional to mandatory
> >  * Add cd_types and wp_types into platform_data to cover more use
> >    cases
> >  * Remove the use of flag ESDHC_FLAG_GPIO_FOR_CD
> >  * Adjust machine codes to adopt the platform_data changes
> 
> Before I go and test theses patches, I'd like to get some
> clarification. From what I see, you've modified all over the place the
> code to provide a platform_data, setting wp/cd type to type "NONE", as
> if it was the default you choose. Why this default and not considerer
> the "SIGNAL" type being the default ? Is this choice the safest one when
> one doesn't know what type to choose or can it have some bad side
> effects ?

The mx51_babbage is the only board support I'm concerned about in
this patch.  For other boards, I chose to translate the NULL pdata
into "NONE" for both wp/cd types as the safest one, because I do not
have (or care to check) the board schematics telling how wp/cd are
routed on those boards.  The patch ensures there is no regression
for those boards, and let people who have schematics to set up wp/cd
types later.

> Also, why didn't you modify the imx*_add_sdhci_esdhc_imx() functions to
> provide the default platform_data by themselves that if the 2nd argument
> was NULL instead of modifying all theses machines files ?
> 
As I said above, the wp/cd "NONE" types translated from NULL pdata
will be set up properly later by people who have schematics.

> 
> Last comment: How did you choose the platform_data values ? I mean, for
> that the cases I'm mainly take care of (efika mx and sb platforms), you
> choose NONE type, while the code has :
> 
>         MX51_PAD_GPIO1_0__SD1_CD,
>         MX51_PAD_GPIO1_1__SD1_WP,
>         MX51_PAD_GPIO1_7__SD2_WP,
>         MX51_PAD_GPIO1_8__SD2_CD,
> 
> which means that it would rather be the SIGNAL type if I got it
> right. Does this mean that you've set the type to NONE for all platforms
> you didn't know what the answer was ? (I guess/hope that theses 2
> questions will be answered by your answers to my previous questions tbh).
> 
I hope you have got the answers to these 2 questions from above
answer.  Otherwise, please let me know.

-- 
Regards,
Shawn

