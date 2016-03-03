From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: MMC broken in kernel 4.4
Date: Thu, 3 Mar 2016 14:17:15 +0100
Message-ID: <CAPDyKFooDVdzBw_ygMF67pWmwxiwWpRDQwyToTH4Zi4ek5cdTw@mail.gmail.com>
References: <hubert_tonneau/BJJ9BVJR/0G321OJ19@hubert-tonneau.storga.com>
	<56D44249.7070200@kernel-upstream.org>
	<hubert_tonneau/727MOBXX/0G32U5D@hubert-tonneau.storga.com>
	<56D4FCC2.1020604@kernel-upstream.org>
	<hubert_tonneau/RM1SK4J9/0G33XJU@hubert-tonneau.storga.com>
	<56D56ABA.5020206@kernel-upstream.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:34580 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002AbcCCNRQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Mar 2016 08:17:16 -0500
Received: by mail-wm0-f44.google.com with SMTP id p65so34368586wmp.1
        for <linux-mmc@vger.kernel.org>; Thu, 03 Mar 2016 05:17:16 -0800 (PST)
In-Reply-To: <56D56ABA.5020206@kernel-upstream.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@kernel-upstream.org>, Hubert Tonneau <hubert.tonneau@fullpliant.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Barry Song <Baohua.Song@csr.com>, Carlo Caione <carlo@endlessm.com>

+Carlo

On 1 March 2016 at 11:11, Shawn Lin <shawn.lin@kernel-upstream.org> wrote:
> Thanks for testing and plus Barry.
>
> So Ulf, I can't remember we have a fix into 4.4#[-rc*] for it, right?

This one should fix the problem. It was included as fix in 4.5 rc1 and
tagged @stable.
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit?id=e10c321977091f163eceedec0650e0ef4b3cf4bb

I assume you want it added to the 4.4.x stable tree. Perhaps you can
resend it as stable patch, to make sure the maintainer picks it up.

[...]

Kind regards
Uffe
