From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 0/4] mmc: tmio: properly report status from autocmd12
Date: Tue, 14 Mar 2017 17:21:25 +0100
Message-ID: <CAPDyKFpzUm5mFiOeUSi+z6Cwad9P=tdek6vd5KqoFRouu606Hw@mail.gmail.com>
References: <20170314100919.25401-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170314100919.25401-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
List-Id: linux-mmc@vger.kernel.org

On 14 March 2017 at 11:09, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> New in V3:
>
> * rebased to v4.11-rc2 and retested
> * added one more tag from Simon
>
> New in V2:
> * Fix some more comments in patch 2.
> * Add Simon's tags
>
> SDHI automatically sends CMD12 when the desired amount of data was transferred
> after multi block commands. However, the response from that CMD12 was never
> reported back to the mmc core, so that errors like ECC might go unnoticed. This
> series aims to fix that and clean up minor issues on the way when dealing with
> the autocmd12 feature. Testing documentation can be found here [1] and thanks
> must go to Shimoda-san for additional testing. Actually handling the ECC errors
> in the core is a seperate issue and I'll post a patch for it right after this.
>
> The patches are based on mmc-next as of today. A branch can be found here:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/topic/sdhi-autocmd12-resp-v3
>
> Thanks and all the best,
>
>    Wolfram
>
> [1] http://elinux.org/Tests:SDHI-autocmd12-responses
>
> Wolfram Sang (4):
>   mmc: host: tmio: use defines for CTL_STOP_INTERNAL_ACTION values
>   mmc: host: tmio: fix minor typos in comments
>   mmc: host: tmio: don't BUG on unsupported stop commands
>   mmc: host: tmio: fill in response from auto cmd12
>
>  drivers/mmc/host/tmio_mmc.h     | 10 +++++++---
>  drivers/mmc/host/tmio_mmc_pio.c | 16 ++++++++++------
>  2 files changed, 17 insertions(+), 9 deletions(-)
>
> --

Thanks, applied for next!

Kind regards
Uffe
