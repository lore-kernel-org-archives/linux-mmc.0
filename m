From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH RFCv2 01/10] mmc: core: Add support to read command queue parameters
Date: Mon, 21 Nov 2016 16:34:40 +0100
Message-ID: <CACRpkdYDfdCoZUOryjVX4byu2BFx9KZx7YKoFG9wESDpaKtirg@mail.gmail.com>
References: <1467033757-32498-1-git-send-email-riteshh@codeaurora.org> <1467033757-32498-2-git-send-email-riteshh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f174.google.com ([209.85.216.174]:35634 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754570AbcKUPel (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Nov 2016 10:34:41 -0500
Received: by mail-qt0-f174.google.com with SMTP id c47so206312737qtc.2
        for <linux-mmc@vger.kernel.org>; Mon, 21 Nov 2016 07:34:41 -0800 (PST)
In-Reply-To: <1467033757-32498-2-git-send-email-riteshh@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ritesh Harjani <riteshh@codeaurora.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Alex Lemberg <alex.lemberg@sandisk.com>, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Asutosh Das <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Sujit Reddy Thumma <sthumma@codeaurora.org>, kdorfman@codeaurora.org, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, venkatg@codeaurora.org, Shawn Lin <shawn.lin@rock-chips.com>, Subhash Jadavani <subhashj@codeaurora.org>

On Mon, Jun 27, 2016 at 3:22 PM, Ritesh Harjani <riteshh@codeaurora.org> wrote:

> From: Asutosh Das <asutoshd@codeaurora.org>
>
> eMMC cards with EXT_CSD version >= 8, optionally support command
> queuing feature as defined by JEDEC eMMC5.1. Add support for probing
> command queue feature for such type of cards.
>
> Signed-off-by: Sujit Reddy Thumma <sthumma@codeaurora.org>
> Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
> Signed-off-by: Venkat Gopalakrishnan <venkatg@codeaurora.org>
> [subhashj@codeaurora.org: fixed trivial merge conflicts]
> Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
> Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Even if we don't merge the specific mechanism provided by the
rest of the patches, this patch just make us know more about
the capabilities of the hardware we're running on, which is good.

WIll it be reported properly by the lsmmc command too?

Yours,
Linus Walleij
