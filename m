From: Niklas =?iso-8859-1?Q?S=F6derlund?=
        <niklas.soderlund@ragnatech.se>
Subject: Re: [PATCH v8 6/6] mmc: sh_mobile_sdhi: Add tuning support
Date: Wed, 11 Jan 2017 09:35:41 +0100
Message-ID: <20170111083541.GB25542@bigcity.dyn.berto.se>
References: <1478182564-18762-1-git-send-email-horms+renesas@verge.net.au>
 <1478182564-18762-7-git-send-email-horms+renesas@verge.net.au>
 <20170110210848.GA25542@bigcity.dyn.berto.se>
 <20170110223043.GA2710@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f44.google.com ([209.85.215.44]:36548 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936380AbdAKIfo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Jan 2017 03:35:44 -0500
Received: by mail-lf0-f44.google.com with SMTP id o140so77023667lff.3
        for <linux-mmc@vger.kernel.org>; Wed, 11 Jan 2017 00:35:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20170110223043.GA2710@katana>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Simon Horman <horms+renesas@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Ai Kyuse <ai.kyuse.uw@renesas.com>

Hi Wolfram,

Thanks for your feedback.

On 2017-01-10 23:30:43 +0100, Wolfram Sang wrote:
> 
> > Oddly enough the error are only printed when I insert the SD card in the 
> > mmc0 slot. I can insert/eject the card multiple times in mmc1 and no 
> > error but the first insertion in mmc0 and boom. Only difference I can 
> > see are the clock speed between mmc0 and mmc1.
> 
> Can you try this patch?
> 
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Date: Sun, 13 Nov 2016 11:10:09 +0100
> Subject: [PATCH] pinctrl: pfc: r8a7795: WIP: hardcode TDSEL value
> 
> Otherwise, AC-180M won't get probed with SDR50 and EMMY-W1 has more
> tuning errors with SDR104.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/pinctrl/sh-pfc/pfc-r8a7795.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c b/drivers/pinctrl/sh-pfc/pfc-r8a7795.c

I'm doing my tests on Koelsch so I'm afraid setting the TDSEL in 
pfc-r8a7795.c won't do much ;-) Nevertheless I tried to mimic the patch 
for Koelsch but found the documentation lacking and where unable to do 
so. That is I found a TDSEL register but no documentation of its 
content.

I could try to run the test on r8a7795 but my understanding is that the 
IPMMU is not 100% OK on ES1.0. That is at least why I stopped testing on 
it a while back. Have this been addressed in a recent firmware I could 
upgrade to?

> index 3f58bfd676ce94..3e3f7585efe8b3 100644
> --- a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
> +++ b/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
> @@ -5416,6 +5416,9 @@ static int r8a7795_pinmux_init(struct sh_pfc *pfc)
>  		pr_info("%s: R-Car H3 >= ES2.0\n", __func__);
>  		// FIXME Fixup r8a7795_pinmux_info for ES2.0
>  	}
> +
> +#define TDSEL 0xe60603c0
> +	sh_pfc_write_reg(pfc, TDSEL, 32, 0xc3);
>  	return 0;
>  }
>  
> -- 
> 2.10.2
> 
> 



-- 
Regards,
Niklas Söderlund
