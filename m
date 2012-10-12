From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] mmc: mmci: Fixup and cleanup code for DMA handling
Date: Fri, 12 Oct 2012 23:32:31 +0200
Message-ID: <CACRpkdZqe3uB9wGM5g5LUJuZEtzeBW=Hs5RF=5_CKU0CBWJRyA@mail.gmail.com>
References: <1350056012-18625-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:63869 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752414Ab2JLVcc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 12 Oct 2012 17:32:32 -0400
Received: by mail-vc0-f174.google.com with SMTP id fo13so3980294vcb.19
        for <linux-mmc@vger.kernel.org>; Fri, 12 Oct 2012 14:32:31 -0700 (PDT)
In-Reply-To: <1350056012-18625-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>, Per Forlin <per.forlin@stericsson.com>

On Fri, Oct 12, 2012 at 5:33 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:

> From: Ulf Hansson <ulf.hansson@linaro.org>
>
> The cookie is now used to indicate if dma_unmap_sg shall be
> done in post_request. At DMA errors, the DMA job is immediately
> not only terminated but also unmapped. To indicate that this
> has been done the cookie is reset to zero. post_request will
> thus only do dma_umap_sg for requests which has a cookie not set
> to zero.
>
> Some corresponding duplicated code could then be removed and
> moreover some corrections at DMA errors for terminating the same
> DMA job twice has also been fixed.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Per Forlin <per.forlin@stericsson.com>

It looks like it's both factoring out code and also adding some unmapping
in hithereto unhandled cases, correct? It looks OK to me now atleast so
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
