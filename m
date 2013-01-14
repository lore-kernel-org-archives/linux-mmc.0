From: Will Newton <will.newton@gmail.com>
Subject: Re: [PATCH v4 5/5] mmc: dw_mmc: Remove DW_MCI_QUIRK_NO_WRITE_PROTECT
Date: Mon, 14 Jan 2013 10:47:02 +0000
Message-ID: <CAFbHwiTafLhK-uJKjUX4_yLC+27OOUnC2JxYM9-3rHZkPx7s5Q@mail.gmail.com>
References: <1357842269-15062-1-git-send-email-dianders@chromium.org>
	<1357923834-31641-1-git-send-email-dianders@chromium.org>
	<1357923834-31641-5-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1357923834-31641-5-git-send-email-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Thomas Abraham <thomas.abraham@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Will Newton <will.newton@imgtec.com>, Chris Ball <cjb@laptop.org>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, linux-kernel@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>
List-Id: linux-mmc@vger.kernel.org

On Fri, Jan 11, 2013 at 5:03 PM, Doug Anderson <dianders@chromium.org> wrote:
> The original quirk was added in the change 'mmc: dw_mmc: add quirk to
> indicate missing write protect line'.  The original quirk was added at
> a controller level even though each slot has its own write protect (so
> the quirk should be at the slot level).  A recent change (mmc: dw_mmc:
> Add "disable-wp" device tree property) added a slot-level quirk and
> support for the quirk directly to dw_mmc.
>
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> ---
> Changes in v4:
> - New for this version; addresses comments from Olof Johansson about
>   the fact that we shouldn't have both a slot and controller level
>   quirk for the same thing.
>
>  drivers/mmc/host/dw_mmc.c  |    8 +-------
>  include/linux/mmc/dw_mmc.h |    7 -------
>  2 files changed, 1 insertions(+), 14 deletions(-)

Hi Doug,

These changes look ok to me. I don't know if patch 4 made it to the
list, I only got a copy via the cc and the only archive I can find of
linux-mmc (gmane) seems to be missing a lot of messages besides this
one.

So for the dw_mmc parts:

Acked-by: Will Newton <will.newton@imgtec.com>
