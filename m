From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH RESEND V4] mmc: core: HS200 mode support for eMMC 4.5
Date: Wed, 26 Oct 2011 15:53:15 -0400
Message-ID: <m2sjmf4jis.fsf@bob.laptop.org>
References: <1319605188-2909-1-git-send-email-girish.shivananjappa@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:42413 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752304Ab1JZTxY (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 26 Oct 2011 15:53:24 -0400
In-Reply-To: <1319605188-2909-1-git-send-email-girish.shivananjappa@linaro.org>
	(Girish K. S.'s message of "Wed, 26 Oct 2011 10:29:48 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Girish K S <girish.shivananjappa@linaro.org>
Cc: linux-mmc@vger.kernel.org, patches@linaro.org, linux-samsung-soc@vger.kernel.org

Hi Girish,

On Wed, Oct 26 2011, Girish K S wrote:
> This patch adds the support of the HS200 bus speed for eMMC 4.5 devices.
> The eMMC 4.5 devices have support for 200MHz bus speed.The mmc core and
> host modules have been touched to add support for this module.
>
> It is necessary to know the card type in the sdhci.c file to add support
> for eMMC tuning function. So card.h file is included to import the card
> data structure.
>
> cc: Chris Ball <cjb@laptop.org>
> Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>

The long case statements and conditionals in this patch make it pretty
dense/ugly -- can you think of a way to avoid doing this to the code?
Also, it would be good to hear if anyone else has tested/is using this
patch.

Is having a new mmc_card_hs200() test desirable, compared to just
reusing mmc_card_highspeed() and checking the ext_csd.card_type?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
