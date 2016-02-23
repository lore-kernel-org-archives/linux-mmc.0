From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v3] mmc-utils: Merge the lsmmc tool into mmc-utils
Date: Tue, 23 Feb 2016 13:23:32 +0800
Message-ID: <CAMz4ku+Q9gappVUmw9tKMCNn=Phyzhha3+D8HVnz1viXMB8wdA@mail.gmail.com>
References: <4230761e156940906a837686e1cc780f417567b7.1456194879.git.baolin.wang@spreadtrum.com>
	<86bn78dpq6.fsf@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f172.google.com ([209.85.161.172]:33378 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754855AbcBWFXd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 23 Feb 2016 00:23:33 -0500
Received: by mail-yw0-f172.google.com with SMTP id u200so138427053ywf.0
        for <linux-mmc@vger.kernel.org>; Mon, 22 Feb 2016 21:23:33 -0800 (PST)
In-Reply-To: <86bn78dpq6.fsf@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Mark Brown <broonie@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Sebastian Rasmussen <sebras@gmail.com>

Hi Chris,

On 23 February 2016 at 12:18, Chris Ball <chris@printf.net> wrote:
> Hi Baolin,
>
> What is the difference between v2 and v3?  It's good to include a
> changelog with each new patch.

Oh, sorry. I would add a changelog in next version. This version I
changed the ext_csd read command replacing with the parser in lsmmc.c.
It is not sensible if we combine the different extcsd parse style
together.

>
> Regarding the merge, I don't think it makes sense to merge in lsmmc.c
> if the entire EXT_CSD parser inside it can't be used right now.
> We might as well just leave it out altogether until it's ready to
> be used.  I don't think there's any point in adding a lot of new
> unused code just because we might want to use it later.
>
> Does that make sense?  Thanks,

OK. I'll remove the EXT_CSD parser from lsmmc.c code. Thanks for your comments.

>
> - Chris.
> --
> Chris Ball   <http://printf.net/>



-- 
Baolin.wang
Best Regards
