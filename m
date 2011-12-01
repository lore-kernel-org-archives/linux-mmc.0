From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] ARM: mmci: add capabilities2 for MMC_CAP2
Date: Thu, 01 Dec 2011 12:41:25 -0500
Message-ID: <87liqwmbp6.fsf@laptop.org>
References: <1321268548-21933-1-git-send-email-per.forlin@stericsson.com>
	<CACRpkdYFVfwRxW+XL6GQtE+NxJvM_3gvCn5a9A+pDL4S77BXqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:58496 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755746Ab1LARl0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 1 Dec 2011 12:41:26 -0500
In-Reply-To: <CACRpkdYFVfwRxW+XL6GQtE+NxJvM_3gvCn5a9A+pDL4S77BXqA@mail.gmail.com>
	(Linus Walleij's message of "Wed, 30 Nov 2011 12:39:42 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Per Forlin <per.forlin@stericsson.com>, linux-mmc@vger.kernel.org, ulf.hansson@stericsson.com, linux-arm-kernel@lists.infradead.org, Russell King <rmk+kernel@arm.linux.org.uk>

Hi,

On Wed, Nov 30 2011, Linus Walleij wrote:
> On Mon, Nov 14, 2011 at 12:02 PM, Per Forlin <per.forlin@stericsson.com> wrote:
>
>> Signed-off-by: Per Forlin <per.forlin@stericsson.com>
>> ---
>> This patch depends on patches adding CAP2 available on mmc-next.
>> Chris, would you mind merging this through your tree when it
>> has been accepted.
>
> Chris are you taking this into your tree?

Thanks, pushed to mmc-next for 3.3.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
