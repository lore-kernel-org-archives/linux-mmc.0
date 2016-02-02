From: Sebastian Rasmussen <sebras@gmail.com>
Subject: Re: [PATCH v2] mmc-utils: Merge the lsmmc tool into mmc-utils
Date: Tue, 2 Feb 2016 23:04:43 +0100
Message-ID: <CAAgDR1Mb5utsrVD9V3QOvPPOD+bRfyMwoRfn-B=9OxgY0v=ezQ@mail.gmail.com>
References: <d59ece1ff066b7fd7c8b538a560f726751fb1f9a.1454401105.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:34410 "EHLO
	mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754450AbcBBWEn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Feb 2016 17:04:43 -0500
Received: by mail-io0-f194.google.com with SMTP id k127so1516919iok.1
        for <linux-mmc@vger.kernel.org>; Tue, 02 Feb 2016 14:04:43 -0800 (PST)
In-Reply-To: <d59ece1ff066b7fd7c8b538a560f726751fb1f9a.1454401105.git.baolin.wang@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: chris@printf.net, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, broonie@kernel.org, Linus Walleij <linus.walleij@linaro.org>

> The original code is created by Sebastian Rasmussen and still lives in
> private git.

Actually the company at which I developed the code has since been
dissolved so I believe that the only place where this code currently
lives is as an attachment in the mail archive of linux-mmc.

> It need to be merged into mmc-utils repository, which is
> convenient for testing MMC device from userspace.

I fully agree. Though maybe the subcommands csd/cid/scr read all should be
brought to conform to the other subcommands in terms of using e.g.
CHECK() and checking for errors using perror(). Basically I would want
the new subcommands to be indistiguishable from the existing commands.
Even if I developed the code at my previous employer it just looks
nasty if it is tacked on without being a proper part of the existing
code. :)

Also I'm a bit wary of that lsmmc.ids database as it is currently not
installed if you do "make install" as it probably should be. Maybe it
is better to hardcode this internally in the program and avoid having
to deal with installation?

Either way, I'm happy to continue working getting this into mmc-utils.

 / Sebastian
