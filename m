From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH 3/3] ARM: dts: rk3288: Add drive/sample clocks for dw_mmc devices
Date: Thu, 18 Dec 2014 16:21:49 -0800
Message-ID: <CAD=FV=XVGCENbiiQS=Zhd2iQ7UuHPbq_f8RfEcWA9qrZRLGfGw@mail.gmail.com>
References: <1418943663-10012-1-git-send-email-amstan@chromium.org>
	<1418943663-10012-4-git-send-email-amstan@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f180.google.com ([209.85.220.180]:62158 "EHLO
	mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751175AbaLSAVu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Dec 2014 19:21:50 -0500
Received: by mail-vc0-f180.google.com with SMTP id im6so2645vcb.11
        for <linux-mmc@vger.kernel.org>; Thu, 18 Dec 2014 16:21:49 -0800 (PST)
In-Reply-To: <1418943663-10012-4-git-send-email-amstan@chromium.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alexandru M Stan <amstan@chromium.org>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Heiko Stuebner <heiko@sntech.de>, addy ke <addy.ke@rock-chips.com>, Andrew Bresticker <abrestic@chromium.org>, Sonny Rao <sonnyrao@chromium.org>, Kever Yang <kever.yang@rock-chips.com>, Mike Turquette <mturquette@linaro.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Alex,

On Thu, Dec 18, 2014 at 3:01 PM, Alexandru M Stan <amstan@chromium.org> wrote:
> The drive/sample clocks can be phase shifted.  The drive clock
> could be used in a future patch to adjust hold times.  The sample
> clock is used for tuning.
>
> Signed-off-by: Alexandru M Stan <amstan@chromium.org>
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> Suggested-by: Heiko Stuebner <heiko@sntech.de>
> Suggested-by: Doug Anderson <dianders@chromium.org>
> ---
>  arch/arm/boot/dts/rk3288.dtsi | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)

I'm not sure I really need a sign-off-by for this since I don't think
I did much besides reupload it once or something.  You can add my
reviewed by instead:

Reviewed-by: Doug Anderson <dianders@chromium.org>
