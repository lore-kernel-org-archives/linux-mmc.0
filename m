From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH 1/3] mmc: dw_mmc: dt-binding: Add tuning related things
Date: Thu, 18 Dec 2014 16:36:14 -0800
Message-ID: <CAD=FV=U_Qqjp6U7Nbu4RwjPf52sv6WHq6-oU3ktuMB67=F8Q0A@mail.gmail.com>
References: <1418943663-10012-1-git-send-email-amstan@chromium.org>
	<1418943663-10012-2-git-send-email-amstan@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f181.google.com ([209.85.220.181]:51791 "EHLO
	mail-vc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751618AbaLSAgP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Dec 2014 19:36:15 -0500
Received: by mail-vc0-f181.google.com with SMTP id le20so2416vcb.40
        for <linux-mmc@vger.kernel.org>; Thu, 18 Dec 2014 16:36:14 -0800 (PST)
In-Reply-To: <1418943663-10012-2-git-send-email-amstan@chromium.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alexandru M Stan <amstan@chromium.org>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Heiko Stuebner <heiko@sntech.de>, addy ke <addy.ke@rock-chips.com>, Andrew Bresticker <abrestic@chromium.org>, Sonny Rao <sonnyrao@chromium.org>, Kever Yang <kever.yang@rock-chips.com>, Mike Turquette <mturquette@linaro.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Alex,

On Thu, Dec 18, 2014 at 3:01 PM, Alexandru M Stan <amstan@chromium.org> wrote:
> Add ciu_drv, ciu_sample clocks and default-sample-phase. This will later be used
> by tuning code.
>
> We do not touch ciu_drive (and by extension define default-drive-phase). Drive
> phase is mostly used to define minimum hold times, while one could write some
> code to determine what phase meets the minimum hold time (ex 10 degrees) this
> will not work with the current clock phase framework (which floors angles, so
> we'll get 0 deg, and there's no way to know what resolution the floors happen
> at). We assume that the default drive angles set by the hardware are good enough.
>
> Signed-off-by: Alexandru M Stan <amstan@chromium.org>
> Suggested-by: Heiko Stuebner <heiko@sntech.de>
> Suggested-by: Doug Anderson <dianders@chromium.org>
> ---
>  Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)

Reviewed-by: Doug Anderson <dianders@chromium.org>
