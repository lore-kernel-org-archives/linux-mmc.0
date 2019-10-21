From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: fix mmc dma operation
Date: Mon, 21 Oct 2019 16:48:37 +0200
Message-ID: <CAPDyKFq_YAB0tycE2ypdJp8gckfeiFRv=A120ZedyDDhu3K17w@mail.gmail.com>
References: <1571637541-119016-1-git-send-email-jianxin.pan@amlogic.com>
 <fc1f61e1-b156-11e6-3f21-c498d2f0a8c6@baylibre.com> <1jwocybgpw.fsf@starbuckisacylon.baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1jwocybgpw.fsf@starbuckisacylon.baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>, Jianxin Pan <jianxin.pan@amlogic.com>, Kevin Hilman <khilman@baylibre.com>, Nan Li <nan.li@amlogic.com>, "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Victor Wan <victor.wan@amlogic.com>
List-Id: linux-mmc@vger.kernel.org

On Mon, 21 Oct 2019 at 11:17, Jerome Brunet <jbrunet@baylibre.com> wrote:
>
>
> On Mon 21 Oct 2019 at 09:57, Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> > Hi,
> >
> > Thanks for the fix.
> >
> > First, you should add "mmc: meson-gx:" in the subject.
> >
> > On 21/10/2019 07:59, Jianxin Pan wrote:
> >> From: Nan Li <nan.li@amlogic.com>
> >>
> >> In MMC dma transfer, the region requested by dma_map_sg() may be released
> >> by dma_unmap_sg() before the transfer is completed.
> >>
> >> Put the unmap operation in front of mmc_request_done() to avoid this.
> >
>
> Since we have seen this problem (yet), could you briefly how you've
> triggered it ?
>
> >
> > You should add a "Fixes:" tag so it can be backported on stable kernels.
> >
> >>
> >> Signed-off-by: Nan Li <nan.li@amlogic.com>
> >> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
> >> ---
> >>  drivers/mmc/host/meson-gx-mmc.c | 15 ++++++++-------
> >>  1 file changed, 8 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> >> index e712315..7667e8a 100644
> >> --- a/drivers/mmc/host/meson-gx-mmc.c
> >> +++ b/drivers/mmc/host/meson-gx-mmc.c
> >> @@ -173,6 +173,7 @@ struct meson_host {
> >>      int irq;
> >>
> >>      bool vqmmc_enabled;
> >> +    bool needs_pre_post_req;
> >>  };
> >>
> >>  #define CMD_CFG_LENGTH_MASK GENMASK(8, 0)
> >> @@ -654,6 +655,8 @@ static void meson_mmc_request_done(struct mmc_host *mmc,
> >>      struct meson_host *host = mmc_priv(mmc);
> >>
> >>      host->cmd = NULL;
> >> +    if (host->needs_pre_post_req)
> >> +            meson_mmc_post_req(mmc, mrq, 0);
> >>      mmc_request_done(host->mmc, mrq);
> >>  }
> >>
> >> @@ -803,25 +806,23 @@ static void meson_mmc_start_cmd(struct mmc_host *mmc, struct mmc_command *cmd)
> >>  static void meson_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
> >>  {
> >>      struct meson_host *host = mmc_priv(mmc);
> >> -    bool needs_pre_post_req = mrq->data &&
> >> +
> >> +    host->needs_pre_post_req = mrq->data &&
> >>                      !(mrq->data->host_cookie & SD_EMMC_PRE_REQ_DONE);
> >>
> >> -    if (needs_pre_post_req) {
> >> +    if (host->needs_pre_post_req) {
> >>              meson_mmc_get_transfer_mode(mmc, mrq);
> >>              if (!meson_mmc_desc_chain_mode(mrq->data))
> >> -                    needs_pre_post_req = false;
> >> +                    host->needs_pre_post_req = false;
> >>      }
> >>
> >> -    if (needs_pre_post_req)
> >> +    if (host->needs_pre_post_req)
> >>              meson_mmc_pre_req(mmc, mrq);
> >>
> >>      /* Stop execution */
> >>      writel(0, host->regs + SD_EMMC_START);
> >>
> >>      meson_mmc_start_cmd(mmc, mrq->sbc ?: mrq->cmd);
> >> -
> >> -    if (needs_pre_post_req)
> >> -            meson_mmc_post_req(mmc, mrq, 0);
> >>  }
>
> The code around all this is getting quite difficult to follow eventhough
> it does not actually do much
>
> The root of the problem seems be that meson_mmc_pre_req() and
> meson_mmc_post_req() are passed to framework but also called manually
> from meson_mmc_request().
>
> Because of this, some code is added to make sure we don't do things twice.
> Maybe I'm missing something but it look weird ? Ulf, could you give us
> your view ?

This is tricky, unfortunately.

The main problem boils done to that, there is no guarantee that the
->pre|post_request() host callbacks is called at all, as that depends
on if the mmc block layer has more than one requests in the pipe to
send. Additionally, that of course varies dynamically on a running
system.

>
> As far as I can tell:
>  * pre_req : determine if we use CHAIN_MODE or not AND
>              dma_map_sg() if we do
>  * post_req : dma_unmap_sg() if previously allocated
>
> Do we really need to do all this meson_mmc_request() ? Shouldn't we let the
> framework do the calls to pre/post_req for us ?

Whether we theoretically could simplify the path, by for example
always calling the ->pre|post_request() callbacks if those exists, is
probably too late to change. Well, unless we can change all host
drivers implementing them as well... so it's probably just easier to
accept this as is.

One thing though, make sure you have a nice self descriptive naming of
variables and functions, to deal with this. That helps a lot.

Kind regards
Uffe
