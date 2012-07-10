From: Namjae Jeon <linkinjeon@gmail.com>
Subject: Re: [PATCH v1 5/5] mmc: card: Add RPMB support in IOCTL interface
Date: Tue, 10 Jul 2012 09:37:57 +0900
Message-ID: <CAKYAXd_EPPvC4tRLjugMxy09_2Hd8bsGmkmYrzf_k3L621rPSw@mail.gmail.com>
References: <1341564244-6178-1-git-send-email-loic.pallardy@stericsson.com>
	<1341564244-6178-6-git-send-email-loic.pallardy@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:46751 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752347Ab2GJAh6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Jul 2012 20:37:58 -0400
Received: by wgbds11 with SMTP id ds11so3121640wgb.1
        for <linux-mmc@vger.kernel.org>; Mon, 09 Jul 2012 17:37:57 -0700 (PDT)
In-Reply-To: <1341564244-6178-6-git-send-email-loic.pallardy@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Loic Pallardy <loic.pallardy@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Linus Walleij <linus.walleij@linaro.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>, Ulf Hansson <ulf.hansson@stericcson.com>, Alex Macro <alex.macro@stericsson.com>

>
> +	err = mmc_blk_part_switch(card, md);
> +	if (err)
> +		goto cmd_rel_host;
> +
Should it wrapped by if (is_rpbm) condition ? It can be called in other ioctl.

>  	if (idata->ic.is_acmd) {
>  		err = mmc_app_cmd(card->host, card);
>  		if (err)
>  			goto cmd_rel_host;
>  	}
