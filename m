From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] mmc: block: release host in case of error
Date: Thu, 17 Nov 2011 08:39:51 +0100
Message-ID: <CACRpkdaCpBx=EkwpX2qDttrHw=f6Emp8p-wR_a=t1e4VAwTOEQ@mail.gmail.com>
References: <1321269166-22128-1-git-send-email-per.forlin@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:36275 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755661Ab1KQHjw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Nov 2011 02:39:52 -0500
Received: by ggnb2 with SMTP id b2so701851ggn.19
        for <linux-mmc@vger.kernel.org>; Wed, 16 Nov 2011 23:39:51 -0800 (PST)
In-Reply-To: <1321269166-22128-1-git-send-email-per.forlin@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Per Forlin <per.forlin@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Sujit Reddy Thumma <sthumma@codeaurora.org>, adrian.hunter@intel.com, Chris Ball <cjb@laptop.org>

On Mon, Nov 14, 2011 at 12:12 PM, Per Forlin <per.forlin@stericsson.com> wrote:

> Host is claimed as long as there are requests in the block queue
> and all request are completed successfully. If an error occur release
> the host in case someone else needs to claim it, for instance if the card
> is removed during a transfer.
>
> Signed-off-by: Per Forlin <per.forlin@stericsson.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks,
Linus Walleij
