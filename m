From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: Re: [PATCH 4/4] mmc: sdhci-esdhc-imx: extend card_detect and write_protect support
Date: Sat, 11 Jun 2011 11:30:42 +0200
Message-ID: <87boy4lnp9.fsf@lebrac.rtp-net.org>
References: <1307702572-22066-1-git-send-email-shawn.guo@linaro.org>
	<1307702572-22066-5-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lebrac.rtp-net.org ([88.191.135.105]:49606 "EHLO
	lebrac.rtp-net.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753495Ab1FKJgu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 11 Jun 2011 05:36:50 -0400
In-Reply-To: <1307702572-22066-5-git-send-email-shawn.guo@linaro.org> (Shawn
	Guo's message of "Fri, 10 Jun 2011 18:42:52 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Wolfram Sang <w.sang@pengutronix.de>, Eric Benard <eric@eukrea.com>, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, patches@linaro.org

Shawn Guo <shawn.guo@linaro.org> writes:

Hi,

> The patch extends card_detect and write_protect support to get mx5
> family and more scenarios supported.  The changes include:
>
>  * Turn platform_data from optional to mandatory
>  * Add cd_types and wp_types into platform_data to cover more use
>    cases
>  * Remove the use of flag ESDHC_FLAG_GPIO_FOR_CD
>  * Adjust machine codes to adopt the platform_data changes

Before I go and test theses patches, I'd like to get some
clarification. From what I see, you've modified all over the place the
code to provide a platform_data, setting wp/cd type to type "NONE", as
if it was the default you choose. Why this default and not considerer
the "SIGNAL" type being the default ? Is this choice the safest one when
one doesn't know what type to choose or can it have some bad side
effects ?
Also, why didn't you modify the imx*_add_sdhci_esdhc_imx() functions to
provide the default platform_data by themselves that if the 2nd argument
was NULL instead of modifying all theses machines files ?


Last comment: How did you choose the platform_data values ? I mean, for
that the cases I'm mainly take care of (efika mx and sb platforms), you
choose NONE type, while the code has :

        MX51_PAD_GPIO1_0__SD1_CD,
        MX51_PAD_GPIO1_1__SD1_WP,
        MX51_PAD_GPIO1_7__SD2_WP,
        MX51_PAD_GPIO1_8__SD2_CD,

which means that it would rather be the SIGNAL type if I got it
right. Does this mean that you've set the type to NONE for all platforms
you didn't know what the answer was ? (I guess/hope that theses 2
questions will be answered by your answers to my previous questions tbh).

Thanks,
Arnaud
