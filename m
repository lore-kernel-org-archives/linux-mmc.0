From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH 2/3] mmc: dw_mmc: Generic MMC tuning with the clock phase framework
Date: Thu, 18 Dec 2014 16:20:15 -0800
Message-ID: <CAD=FV=WhB84enspDCHwkc2TqEFeAr_qiY4m_xYvMYCArUAtPXw@mail.gmail.com>
References: <1418943663-10012-1-git-send-email-amstan@chromium.org>
	<1418943663-10012-3-git-send-email-amstan@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f180.google.com ([209.85.220.180]:45342 "EHLO
	mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751175AbaLSAUQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Dec 2014 19:20:16 -0500
Received: by mail-vc0-f180.google.com with SMTP id im6so2001vcb.11
        for <linux-mmc@vger.kernel.org>; Thu, 18 Dec 2014 16:20:15 -0800 (PST)
In-Reply-To: <1418943663-10012-3-git-send-email-amstan@chromium.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alexandru M Stan <amstan@chromium.org>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Heiko Stuebner <heiko@sntech.de>, addy ke <addy.ke@rock-chips.com>, Andrew Bresticker <abrestic@chromium.org>, Sonny Rao <sonnyrao@chromium.org>, Kever Yang <kever.yang@rock-chips.com>, Mike Turquette <mturquette@linaro.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Alex,

On Thu, Dec 18, 2014 at 3:01 PM, Alexandru M Stan <amstan@chromium.org> wrote:
> +       blk_test = kmalloc(blksz, GFP_KERNEL);
> +       if (!blk_test)
> +               return -ENOMEM;
> +
> +       ranges = kmalloc(((NUM_PHASES / 2 + 1) * sizeof(ranges)), GFP_KERNEL);

sizeof(*ranges)


Other than that, this looks good to me and you can add my reviewed-by
when the above is fixed.
