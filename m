From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: tmio_mmc: Add MMC_CAP_MMC_HIGHSPEED support
Date: Mon, 15 Feb 2010 21:15:49 +0900
Message-ID: <aec7e5c31002150415r1ce02e24ua9aa786d41fea36a@mail.gmail.com>
References: <4B790102.4050907@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gx0-f224.google.com ([209.85.217.224]:58585 "EHLO
	mail-gx0-f224.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754078Ab0BOMPu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Feb 2010 07:15:50 -0500
Received: by gxk24 with SMTP id 24so4900646gxk.1
        for <linux-mmc@vger.kernel.org>; Mon, 15 Feb 2010 04:15:49 -0800 (PST)
In-Reply-To: <4B790102.4050907@renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yusuke Goda <goda.yusuke@renesas.com>
Cc: linux-mmc@vger.kernel.org, akpm@linux-foundation.org

Hi Goda-san,

2010/2/15 Yusuke Goda <goda.yusuke@renesas.com>:
> Enable MMC_CAP_MMC_HIGHSPEED support in the tmio_mmc driver if
> pdata->cap_highspeed is set.
>
> Signed-off-by: Yusuke Goda <goda.yusuke@renesas.com>

Thanks for your patch, it looks fine to me.
Acked-by: Magnus Damm <damm@opensource.se>

If no one objects then I'll hack up a patch for the sh_mobile_sdhi
driver that sets pdata->cah_highspeed to 1.

Cheers,

/ magnus
