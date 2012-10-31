From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v2] mmc: mxs-mmc: Remove platform data
Date: Wed, 31 Oct 2012 13:49:04 -0200
Message-ID: <CAOMZO5AbyeEhrk1pS2XHhZy0q3Hg887prHG0YUNOWZhoq8xcTQ@mail.gmail.com>
References: <1351682578-12922-1-git-send-email-festevam@gmail.com>
	<20121031154458.GB8358@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:34543 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757618Ab2JaPtG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 31 Oct 2012 11:49:06 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so1569808oag.19
        for <linux-mmc@vger.kernel.org>; Wed, 31 Oct 2012 08:49:04 -0700 (PDT)
In-Reply-To: <20121031154458.GB8358@S2100-06.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: cjb@laptop.org, marex@denx.de, linux-mmc@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

On Wed, Oct 31, 2012 at 1:45 PM, Shawn Guo <shawn.guo@linaro.org> wrote:

> Since you are here, you may also want to remove the "if (np)" check for
> non-dt probe case getting devid and dma_channel.  As the result,
> mxs_ssp_ids can be removed as well.
>
> It could be another patch though, so for this one:
>
> Acked-by: Shawn Guo <shawn.guo@linaro.org>

Ok, will do it as a separate patch after this one gets applied.

Regards,

Fabio Estevam
