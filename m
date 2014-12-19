From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 2/3] mmc: dw_mmc: Generic MMC tuning with the clock phase
 framework
Date: Fri, 19 Dec 2014 10:29:17 -0800
Message-ID: <54946E7D.1010500@codeaurora.org>
References: <1418943663-10012-1-git-send-email-amstan@chromium.org> <1418943663-10012-3-git-send-email-amstan@chromium.org> <CAD=FV=WhB84enspDCHwkc2TqEFeAr_qiY4m_xYvMYCArUAtPXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:57536 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751165AbaLSS3V (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Dec 2014 13:29:21 -0500
In-Reply-To: <CAD=FV=WhB84enspDCHwkc2TqEFeAr_qiY4m_xYvMYCArUAtPXw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>, Alexandru M Stan <amstan@chromium.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Mike Turquette <mturquette@linaro.org>, Heiko Stuebner <heiko@sntech.de>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Seungwon Jeon <tgih.jun@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, addy ke <addy.ke@rock-chips.com>, Kever Yang <kever.yang@rock-chips.com>, Jaehoon Chung <jh80.chung@samsung.com>, Andrew Bresticker <abrestic@chromium.org>, Sonny Rao <sonnyrao@chromium.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 12/18/2014 04:20 PM, Doug Anderson wrote:
> Alex,
>
> On Thu, Dec 18, 2014 at 3:01 PM, Alexandru M Stan <amstan@chromium.org> wrote:
>> +       blk_test = kmalloc(blksz, GFP_KERNEL);
>> +       if (!blk_test)
>> +               return -ENOMEM;
>> +
>> +       ranges = kmalloc(((NUM_PHASES / 2 + 1) * sizeof(ranges)), GFP_KERNEL);
> sizeof(*ranges)
>
>
> Other than that, this looks good to me and you can add my reviewed-by
> when the above is fixed.
>
>

Might want to use kmalloc_array() too.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

