From: Hubert Tonneau <hubert.tonneau@fullpliant.org>
Subject: Re: MMC broken in kernel 4.4
Date: Thu, 3 Mar 2016 16:23:05 +0000
Message-ID: <hubert_tonneau/RM1SK4J9/0G3839T@hubert-tonneau.storga.com>
References: <hubert_tonneau/BJJ9BVJR/0G321OJ19@hubert-tonneau.storga.com>	<56D44249.7070200@kernel-upstream.org>	<hubert_tonneau/727MOBXX/0G32U5D@hubert-tonneau.storga.com>	<56D4FCC2.1020604@kernel-upstream.org>	<hubert_tonneau/RM1SK4J9/0G33XJU@hubert-tonneau.storga.com>	<56D56ABA.5020206@kernel-upstream.org> <CAPDyKFooDVdzBw_ygMF67pWmwxiwWpRDQwyToTH4Zi4ek5cdTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from dc1.fullpliant.org ([213.186.44.166]:35038 "HELO
	storga1.copliant.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751002AbcCCQcH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Mar 2016 11:32:07 -0500
In-Reply-To: <CAPDyKFooDVdzBw_ygMF67pWmwxiwWpRDQwyToTH4Zi4ek5cdTw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Shawn Lin <shawn.lin@kernel-upstream.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Barry Song <Baohua.Song@csr.com>, Carlo Caione <carlo@endlessm.com>

Hi,

Ulf Hansson wrote:
>
> This one should fix the problem. It was included as fix in 4.5 rc1 and
> tagged @stable.
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit?id=e10c321977091f163eceedec0650e0ef4b3cf4bb

This patch do solves the 4.4.X issue on Lenovo Yoga 8 inch tablet.

Regards,
Hubert Tonneau
