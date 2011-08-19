From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 0/3] mmc: fixes for aggressive clock gating framework
Date: Fri, 19 Aug 2011 11:58:36 +0200
Message-ID: <CACRpkdbAm5Z4NSZwtMSXSN9zzQW5p=zWmt1922oR1Sj2AbyZnw@mail.gmail.com>
References: <cover.1313664897.git.mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:50886 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751896Ab1HSJ6h (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Aug 2011 05:58:37 -0400
In-Reply-To: <cover.1313664897.git.mika.westerberg@linux.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, linux-kernel@vger.kernel.org

On Thu, Aug 18, 2011 at 2:23 PM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:

> This is an updated series which should fix few races seen when aggressive
> clock gating is active. The first patch actually just renames the gating
> functions to make their use-cases a bit more clear.

Wow excellent work Mika, this is exactly how we should fix this.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Chris: you get to decide whether we push this for the -rc or -next,
since it fixes a regression for Mika I suggest this should go into -rc.

Thanks a *lot* Mika!
Linus Walleij
