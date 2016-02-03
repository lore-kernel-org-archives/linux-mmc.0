From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v2] mmc-utils: Merge the lsmmc tool into mmc-utils
Date: Wed, 3 Feb 2016 10:34:03 +0800
Message-ID: <CAMz4kuJgiVDy=oN1mioj+SzU601wHx4MD47zMG-oQzm-noryvQ@mail.gmail.com>
References: <d59ece1ff066b7fd7c8b538a560f726751fb1f9a.1454401105.git.baolin.wang@linaro.org>
	<CAAgDR1Mb5utsrVD9V3QOvPPOD+bRfyMwoRfn-B=9OxgY0v=ezQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f174.google.com ([209.85.160.174]:33468 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755289AbcBCCeF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Feb 2016 21:34:05 -0500
Received: by mail-yk0-f174.google.com with SMTP id z13so7578722ykd.0
        for <linux-mmc@vger.kernel.org>; Tue, 02 Feb 2016 18:34:04 -0800 (PST)
In-Reply-To: <CAAgDR1Mb5utsrVD9V3QOvPPOD+bRfyMwoRfn-B=9OxgY0v=ezQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sebastian Rasmussen <sebras@gmail.com>
Cc: Chris Ball <chris@printf.net>, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Mark Brown <broonie@kernel.org>, Linus Walleij <linus.walleij@linaro.org>

On 3 February 2016 at 06:04, Sebastian Rasmussen <sebras@gmail.com> wrote:
>> The original code is created by Sebastian Rasmussen and still lives in
>> private git.
>
> Actually the company at which I developed the code has since been
> dissolved so I believe that the only place where this code currently
> lives is as an attachment in the mail archive of linux-mmc.

Got it.

>
>> It need to be merged into mmc-utils repository, which is
>> convenient for testing MMC device from userspace.
>
> I fully agree. Though maybe the subcommands csd/cid/scr read all should be
> brought to conform to the other subcommands in terms of using e.g.
> CHECK() and checking for errors using perror(). Basically I would want
> the new subcommands to be indistiguishable from the existing commands.
> Even if I developed the code at my previous employer it just looks
> nasty if it is tacked on without being a proper part of the existing
> code. :)
>
> Also I'm a bit wary of that lsmmc.ids database as it is currently not
> installed if you do "make install" as it probably should be. Maybe it
> is better to hardcode this internally in the program and avoid having
> to deal with installation?

OK. So it can remove the '-f' parameter.

>
> Either way, I'm happy to continue working getting this into mmc-utils.

That's great. I think you can continue doing it. Thanks a lot.

>
>  / Sebastian



-- 
Baolin.wang
Best Regards
