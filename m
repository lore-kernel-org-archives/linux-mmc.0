From: "Subhash Jadavani" <subhashj@codeaurora.org>
Subject: RE: [PATCH] mmc: core: Fix power_off_notify during suspend
Date: Tue, 15 Nov 2011 20:50:43 +0530
Message-ID: <000b01cca3aa$266cbcd0$73463670$@org>
References: <1321338346-10911-1-git-send-email-girish.shivananjappa@linaro.org> <8739dpjziu.fsf@laptop.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:19281 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756189Ab1KOPUs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Nov 2011 10:20:48 -0500
In-Reply-To: <8739dpjziu.fsf@laptop.org>
Content-Language: en-us
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Chris Ball' <cjb@laptop.org>, 'Girish K S' <girish.shivananjappa@linaro.org>
Cc: linux-mmc@vger.kernel.org, patches@linaro.org, linux-samsung-soc@vger.kernel.org

Chris, Girish,

I have question here. Are these eMMC4.5 related patches are getting tested
with real eMMC4.5 cards?

Regards,
Subhash

> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> owner@vger.kernel.org] On Behalf Of Chris Ball
> Sent: Tuesday, November 15, 2011 6:47 PM
> To: Girish K S
> Cc: linux-mmc@vger.kernel.org; patches@linaro.org; linux-samsung-
> soc@vger.kernel.org
> Subject: Re: [PATCH] mmc: core: Fix power_off_notify during suspend
> 
> Hi,
> 
> On Tue, Nov 15 2011, Girish K S wrote:
> > The eMMC 4.5 devices respond to only RESET and AWAKE command in the
> sleep
> > state. Hence the mmc switch command to notify power off state should
> be sent
> > before the device enters sleep state.
> >
> > This patch fixes the same.
> >
> > Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
> 
> Thanks, pushed to mmc-next for 3.2.
> 
> - Chris.
> --
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

