From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 2/2] mmc: mmc: Fix HS setting in mmc_hs400_to_hs200()
Date: Mon, 25 Feb 2019 17:08:14 +0100
Message-ID: <CAPDyKFquyyXx1MqNLVXuFxcEDB9nKzN8LGGNUP2yxoVMQrWiUg@mail.gmail.com>
References: <1550210375-32270-1-git-send-email-chaotian.jing@mediatek.com>
 <1550210375-32270-3-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1550210375-32270-3-git-send-email-chaotian.jing@mediatek.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Chaotian Jing <chaotian.jing@mediatek.com>
Cc: srv_heupstream <srv_heupstream@mediatek.com>, Shawn Lin <shawn.lin@rock-chips.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Avri Altman <avri.altman@wdc.com>, linux-mediatek@lists.infradead.org, Hongjie Fang <hongjiefang@asrmicro.com>, Matthias Brugger <matthias.bgg@gmail.com>, Simon Horman <horms+renesas@verge.net.au>, Kyle Roeschley <kyle.roeschley@ni.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, 15 Feb 2019 at 06:59, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
>
> mmc_hs400_to_hs200() begins with the card and host in HS400 mode.
> before send CMD6 to switch card's timing to HS mode, it reduce clock
> frequency to 50Mhz firstly, the original intention of reduce clock
> is to make "more stable" when doing HS switch. however,reduce clock
> frequency to 50Mhz but without host timming change may cause CMD6
> response CRC error. because host is still running at hs400 mode,
> and it's hard to find a suitable setting for all eMMC cards when
> clock frequency reduced to 50Mhz but card & host still in hs400 mode.
>
> so that We consider that CMD6 response CRC error is not a fatal error,
> if host gets CMD6 response CRC error, it means that card has already
> received this command.
>
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> Fixes: ef3d232245ab ("mmc: mmc: Relax checking for switch errors after HS200 switch")
> ---
>  drivers/mmc/core/mmc.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 09c688f..03d1c17 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1248,8 +1248,25 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
>         err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_HS_TIMING,
>                            val, card->ext_csd.generic_cmd6_time, 0,
>                            true, false, true);
> -       if (err)
> -               goto out_err;
> +       /*
> +        * as we are on the way to do re-tune, so if the CMD6 got response CRC
> +        * error, do not treat it as error.
> +        */
> +       if (err) {
> +               if (err == -EILSEQ) {

Well, I am having seconds thoughts about this. Sorry.

There are different scenarios of why we end up doing a re-tune and
thus call mmc_hs400_to_hs200(). These are:

1) Because of a periodic re-tuning - to avoid CRC errors in the future.
2) Because the host controller needs to do a re-tune when it gets
runtime resumed, due to that it lost its tuning data (and is unable to
restore it).
3) Because we encountered a CRC (-EILSEQ) error for a block I/O
request and want to try re-cover.

I assume you are looking at case 3), because mtk-sd don't use periodic
re-tuning and nor does it need re-tune at runtime resume, right?

So, when thinking a bit about these cases, more closely, I think we
need to admit that these are actually quite fundamentally different
cases. Therefore, we should probably start treat them like that as
well.

For 1), There are no reason to decrease the clock rate before invoking
__mmc_switch(), but rather we should decrease it afterwards instead.
For 2), The clock rate must to be decreased to HS speed (50 MHz),
before invoking __mmc_switch(), as there are really no tuning
parameters available at all to use for the controller.
For 3). Similar to 1) and for the reasons you also have brought up
earlier, the clock rate should remain at HS400 speed before invoking
__mmc_switch(). This is because the controller are still using the
tuned data for the HS400 clock rate. So, even if the conditions
started to become fragile, I think it's better to try with the HS400
MHz than on any other rate.

Moreover, as I stated in an earlier reply, if the call to
__mmc_switch() ends up with a CRC error, how can we ever be sure that
the command was accepted by the card? We can't, hence that solution
will probably never fly.

> +                       /*
> +                        * card will busy after sending out response and host
> +                        * driver may not wait busy de-assert when get
> +                        * response CRC error. so just wait enough time to
> +                        * ensure card leave busy state.
> +                        */
> +                       mmc_delay(card->ext_csd.generic_cmd6_time);
> +                       pr_debug("%s: %s switch to HS got CRC error\n",
> +                                mmc_hostname(host), __func__);
> +               } else {
> +                       goto out_err;
> +               }
> +       }
>
>         mmc_set_timing(host, MMC_TIMING_MMC_DDR52);
>
> --
> 1.8.1.1.dirty
>

If you take into account my comments above, it seems like we need to
add a new tuning flag somewhere, to tell the reason for why the tuning
is needed. Then we can let mmc_hs400_to_hs200() act on that flag, and
depending on its value it can either change the clock rate before or
after the call to __mmc_switch(). If we can make this work, that would
be the best solution, I think.

The fallback method, is to add a specific host cap bit, that instructs
the mmc core to adjust clock rate before/after the switch, but I would
rather avoid this solution, but perhaps there is no other way. Let's
see.

Kind regards
Uffe
