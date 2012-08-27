From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: core: Do not rescan non-removable devices
Date: Mon, 27 Aug 2012 19:13:55 -0400
Message-ID: <87ipc4x70s.fsf@octavius.laptop.org>
References: <1345722055-12459-1-git-send-email-johan.rudholm@stericsson.com>
	<CACRpkdaCAinV5v-S-3nHfyWmf8O4QmnbvwGJpUz6SKuT-zR2hA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:38449 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754153Ab2H0XOB (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 27 Aug 2012 19:14:01 -0400
In-Reply-To: <CACRpkdaCAinV5v-S-3nHfyWmf8O4QmnbvwGJpUz6SKuT-zR2hA@mail.gmail.com>
	(Linus Walleij's message of "Thu, 23 Aug 2012 15:56:43 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Johan Rudholm <johan.rudholm@stericsson.com>, linux-mmc@vger.kernel.org, Per Forlin <per.forlin@stericsson.com>, Ulf Hansson <ulf.hansson@stericsson.com>

Hi,

On Thu, Aug 23 2012, Linus Walleij wrote:
> On Thu, Aug 23, 2012 at 1:40 PM, Johan Rudholm
> <johan.rudholm@stericsson.com> wrote:
>
>> If MMC_CAP_NONREMOVABLE is set, only issue a detect job on init.
>>
>> Signed-off-by: Johan Rudholm <johan.rudholm@stericsson.com>
>> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> Seems logical...
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks, pushed to mmc-next for 3.7.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
