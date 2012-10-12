From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] mmc: mmci: Support non-power-of-two block sizes for
 ux500v2 variant
Date: Fri, 12 Oct 2012 23:22:44 +0200
Message-ID: <CACRpkdaaG1d4C9n7=2A_au0D99bVTGW1s2KX4hFHbaDAkeiK0A@mail.gmail.com>
References: <1350050522-8852-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:34324 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752215Ab2JLVWp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 12 Oct 2012 17:22:45 -0400
Received: by mail-vb0-f46.google.com with SMTP id ff1so3473663vbb.19
        for <linux-mmc@vger.kernel.org>; Fri, 12 Oct 2012 14:22:44 -0700 (PDT)
In-Reply-To: <1350050522-8852-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>, Per Forlin <per.forlin@stericsson.com>

On Fri, Oct 12, 2012 at 4:02 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:

> From: Ulf Hansson <ulf.hansson@linaro.org>
>
> For the ux500v2 variant non power of two block sizes are supported.
> This will make it possible to decrease data overhead for SDIO
> transfers. Although we need to put some constraints to the alignment
> of the buffers when enabling this feature.
>
> Buffers must be 4 bytes aligned due to restrictions that the PL18x
> FIFO accesses must be done in a 4 byte aligned manner. Moreover we
> need to enable DMA_REQCTL for SDIO to support write of non 32 bytes
> aligned sg element lengths. In PIO mode any buffer length can be
> handled as long as the buffer address is 4 byte aligned.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Per Forlin <per.forlin@stericsson.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I finally understand how this works now.

Bonus for comments like this:

> +/*
> + * DMA request control is required for write
> + * if transfer size is not 32 byte aligned.
> + * DMA request control is also needed if the total
> + * transfer size is 32 byte aligned but any of the
> + * sg element lengths are not aligned with 32 byte.
> + */
>  #define MCI_ST_DPSM_DMAREQCTL  (1 << 12)

Which make you understand what is actually happening.

Yours,
Linus Walleij
