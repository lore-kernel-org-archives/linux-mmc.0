From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: tmio_mmc: Add MMC_CAP_MMC_HIGHSPEED support
Date: Tue, 16 Feb 2010 14:32:41 -0800
Message-ID: <20100216143241.d915ae54.akpm@linux-foundation.org>
References: <4B790102.4050907@renesas.com>
	<aec7e5c31002150415r1ce02e24ua9aa786d41fea36a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51415 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933126Ab0BPWcs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Feb 2010 17:32:48 -0500
In-Reply-To: <aec7e5c31002150415r1ce02e24ua9aa786d41fea36a@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Yusuke Goda <goda.yusuke@renesas.com>, linux-mmc@vger.kernel.org

On Mon, 15 Feb 2010 21:15:49 +0900
Magnus Damm <magnus.damm@gmail.com> wrote:

> Hi Goda-san,
> 
> 2010/2/15 Yusuke Goda <goda.yusuke@renesas.com>:
> > Enable MMC_CAP_MMC_HIGHSPEED support in the tmio_mmc driver if
> > pdata->cap_highspeed is set.
> >
> > Signed-off-by: Yusuke Goda <goda.yusuke@renesas.com>
> 
> Thanks for your patch, it looks fine to me.
> Acked-by: Magnus Damm <damm@opensource.se>
> 
> If no one objects then I'll hack up a patch for the sh_mobile_sdhi
> driver that sets pdata->cah_highspeed to 1.
> 

Would prefer to see the interrelated patches in a single series please.

Linus Walleij's suggestion sounded good, too.

