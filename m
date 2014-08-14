From: Alexandre Courbot <gnurou@gmail.com>
Subject: Re: [PATCH 3/4] mmc: host: switch OF parser to use gpio descriptors
Date: Thu, 14 Aug 2014 07:33:42 -0700
Message-ID: <CAAVeFuJ-HrQFRMt5x8Kk6TZWPbNt+N8mJDoCB9LuahE8i2tDqg@mail.gmail.com>
References: <1407864355-21545-1-git-send-email-linus.walleij@linaro.org> <1407864355-21545-3-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:61046 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755016AbaHNOeD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Aug 2014 10:34:03 -0400
In-Reply-To: <1407864355-21545-3-git-send-email-linus.walleij@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>

On Tue, Aug 12, 2014 at 10:25 AM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> This switches the central MMC OF parser to use gpio descriptors
> instead of grabbing GPIOs explicitly from the device tree.
> This strips out an unecessary use of the integer-based GPIO
> API that we want to get rid of, cuts down on code as the
> gpio descriptor code will handle active low flags.
>
> As it is in no way a bug not to supply CD/WP GPIOs the messages
> about them not being specified have been depromoted from
> dev_err() to dev_dbg().

Acked-by: Alexandre Courbot <acourbot@nvidia.com>
