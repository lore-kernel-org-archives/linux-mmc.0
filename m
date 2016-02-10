From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 9/9] mmc: sdhi: Add r8a7795 support
Date: Wed, 10 Feb 2016 17:36:25 +0100
Message-ID: <20160210163623.GA15453@katana>
References: <1453749316-1848-1-git-send-email-wsa@the-dreams.de>
 <1453749316-1848-10-git-send-email-wsa@the-dreams.de>
 <CAPDyKFo6oXEAy562p7MTxw0eKYZe_nnT2q+hbLKF4Lv2kMUvGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFo6oXEAy562p7MTxw0eKYZe_nnT2q+hbLKF4Lv2kMUvGg@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Dirk Behme <dirk.behme@gmail.com>
List-Id: linux-mmc@vger.kernel.org

^
> I think you should try without MMC_CAP_WAIT_WHILE_BUSY, and then check
> that a following CMD13 command always states that the card isn't busy.
> I think the best path to try this is when sending a big write data
> request, as in that case you can be quite certain that the card gets
> busy between the requests.
> 
> So somewhere in the mmc block layer add some debug prints, that should do it.

I'd think the mmc_test driver already helped me with this. I ran tests
like 31 (Consecutive write performance by transfer size) or 36 (Large
sequential write from scattered pages) which both succeeded without any
warnings printed. And the code explicitly sends a CMD13 after transfer,
checks for busy and prints a warning when MMC_CAP_WAIT_WHILE_BUSY is
set and a busy state is detected. Nice test thing this driver is :)

So, it looks to me that patch 9 is fine to go in?

