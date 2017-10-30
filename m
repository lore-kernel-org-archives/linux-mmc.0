From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 0/5] mmc: dw_mmc: Fix the CTO timer patch, plus the DTO timer
Date: Mon, 30 Oct 2017 12:40:08 +0100
Message-ID: <CAPDyKFqaZxGJyJRB36-K3zVK_-V637ge1S6bpiQjbfDe_5PhLw@mail.gmail.com>
References: <20171012201118.23570-1-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171012201118.23570-1-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Douglas Anderson <dianders@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Ziyuan Xu <xzy.xu@rock-chips.com>, Alexandru Stan <amstan@chromium.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Brian Norris <briannorris@chromium.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, kernel@esmil.dk, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 12 October 2017 at 22:11, Douglas Anderson <dianders@chromium.org> wrote:
> Recently we landed 03de19212ea3 ("mmc: dw_mmc: introduce timer for
> broken command transfer over scheme").  I found a bunch of problems
> with that patch, so this series attempts to solve some of them.
>
> This also fixes the DTO timer in some of the same ways even though I
> haven't personally seen problems with the DTO timer.
>
> NOTE: this series has only been lighly tested so far.  I can at least
> reproduce the need for the CTO timer on one of my devices and so I can
> confirm that part still works.  As mentioned in the 3rd patch I also
> ran the mmc_test kernel module on this and did manage to see the 3rd
> patch doing something useful.
>
> Changes in v2:
> - Removed extra "int i"
> - Fix the DTO timeout calculation new for v2
> - Cleanup the DTO timer new for v2
>
> Douglas Anderson (5):
>   mmc: dw_mmc: cancel the CTO timer after a voltage switch
>   mmc: dw_mmc: Fix the CTO timeout calculation
>   mmc: dw_mmc: Add locking to the CTO timer
>   mmc: dw_mmc: Fix the DTO timeout calculation
>   mmc: dw_mmc: Cleanup the DTO timer like the CTO one
>
>  drivers/mmc/host/dw_mmc.c | 162 +++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 146 insertions(+), 16 deletions(-)
>

Douglas, Jaehoon,

I decided to pick patch 1->4 for fixes and the patch 5 for next, that
should help us to get them more tested, while Jaehoon is still
catching up.

I can add ack/drop patches for yet a couple of days this week.

Kind regards
Uffe
