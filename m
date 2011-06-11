From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: Re: [PATCH 4/4] mmc: sdhci-esdhc-imx: extend card_detect and write_protect support
Date: Sat, 11 Jun 2011 13:59:54 +0200
Message-ID: <877h8slgsl.fsf@lebrac.rtp-net.org>
References: <1307702572-22066-1-git-send-email-shawn.guo@linaro.org>
	<1307702572-22066-5-git-send-email-shawn.guo@linaro.org>
	<87boy4lnp9.fsf@lebrac.rtp-net.org>
	<20110611115031.GA29093@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lebrac.rtp-net.org ([88.191.135.105]:44116 "EHLO
	lebrac.rtp-net.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754704Ab1FKMAF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 11 Jun 2011 08:00:05 -0400
In-Reply-To: <20110611115031.GA29093@S2100-06.ap.freescale.net> (Shawn Guo's
	message of "Sat, 11 Jun 2011 19:50:33 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Wolfram Sang <w.sang@pengutronix.de>, Eric Benard <eric@eukrea.com>, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, patches@linaro.org

Shawn Guo <shawn.guo@freescale.com> writes:

> On Sat, Jun 11, 2011 at 11:30:42AM +0200, Arnaud Patard wrote:
>> Shawn Guo <shawn.guo@linaro.org> writes:
>> 
>> Hi,
>> 
>> > The patch extends card_detect and write_protect support to get mx5
>> > family and more scenarios supported.  The changes include:
>> >
>> >  * Turn platform_data from optional to mandatory
>> >  * Add cd_types and wp_types into platform_data to cover more use
>> >    cases
>> >  * Remove the use of flag ESDHC_FLAG_GPIO_FOR_CD
>> >  * Adjust machine codes to adopt the platform_data changes
>> 
>> Before I go and test theses patches, I'd like to get some
>> clarification. From what I see, you've modified all over the place the
>> code to provide a platform_data, setting wp/cd type to type "NONE", as
>> if it was the default you choose. Why this default and not considerer
>> the "SIGNAL" type being the default ? Is this choice the safest one when
>> one doesn't know what type to choose or can it have some bad side
>> effects ?
>
> The mx51_babbage is the only board support I'm concerned about in
> this patch.  For other boards, I chose to translate the NULL pdata
> into "NONE" for both wp/cd types as the safest one, because I do not
> have (or care to check) the board schematics telling how wp/cd are
> routed on those boards.  The patch ensures there is no regression
> for those boards, and let people who have schematics to set up wp/cd
> types later.

ok. Thanks for making things clear. I see some changes for
loco/imx53qsb. Do you need testers for it too or you've tested it ?

>
>> Also, why didn't you modify the imx*_add_sdhci_esdhc_imx() functions to
>> provide the default platform_data by themselves that if the 2nd argument
>> was NULL instead of modifying all theses machines files ?
>> 
> As I said above, the wp/cd "NONE" types translated from NULL pdata
> will be set up properly later by people who have schematics.

You're not answering my question about moving the NULL-> "NONE" type
from *all* modified machine file into the imx*add_sdhci_esdhc_imx(). If
it's the default, why all machines file have to be modified to set it ?
Moreover, *nothing* AFAICS is preventing to call theses functions will
NULL. What will happen ? An oops ? To me, a default is the value set
when nothing is set, and clearly modifying all functions call site due
to having to provide the default seems imho wrong.

Thanks,
Arnaud
