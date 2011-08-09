From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH --mmotm v5 0/3] Make fault injection available for MMC IO
Date: Tue, 9 Aug 2011 19:17:05 +0900
Message-ID: <CAC5umyhyRCU9mNCz9Q2Ly1f3+UEv+EOGicd735QXjpKUAvzDzw@mail.gmail.com>
References: <1312834049-29910-1-git-send-email-per.forlin@linaro.org>
	<CAC5umyhWr8t7HyQVEn-W-7HSaeESnTLX8okcQNqPO6mYFuWtUg@mail.gmail.com>
	<CAJ0pr18Mpv7mFHC3NnfqEqtTFd_qgNhH9rZgCENgH0zKmBfFsQ@mail.gmail.com>
	<CAC5umygEJy8he1X2Egiuh16HGCC6=Krxv1F3j=bh7xrZmNTHJg@mail.gmail.com>
	<CAJ0pr182aHm7H+s04Pqg5_CxVQLAhGOwLHQ_-aUS7ZgWKSwMxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:61866 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753168Ab1HIKRG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Aug 2011 06:17:06 -0400
In-Reply-To: <CAJ0pr182aHm7H+s04Pqg5_CxVQLAhGOwLHQ_-aUS7ZgWKSwMxQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Per Forlin <per.forlin@linaro.org>
Cc: akpm@linux-foundation.org, Linus Walleij <linus.ml.walleij@gmail.com>, linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@xenotime.net>, Chris Ball <cjb@laptop.org>, linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org, linaro-dev@lists.linaro.org, linux-mm@kvack.org

2011/8/9 Per Forlin <per.forlin@linaro.org>:

> Do you think it would be possible to get only the export
> fault-injection patch in 3.1? I know it's not a bugfix so I guess it
> wont be accepted.

No modules except mmc plan to use those symbols.  So I think there is
no reason to merge them separately.
