From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/3] mmc: fix mmc mode selection for HS-DDR and higher
Date: Thu, 2 Jun 2016 10:31:13 +0200
Message-ID: <CAPDyKFriC7i1DtF5d8eoY0baRoZ2VTfhWJznw9SvOnPNYksU5w@mail.gmail.com>
References: <1464505484-3661-1-git-send-email-wens@csie.org>
	<1464505484-3661-2-git-send-email-wens@csie.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464505484-3661-2-git-send-email-wens@csie.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, Hans de Goede <hdegoede@redhat.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-mmc@vger.kernel.org

+ Linus

On 29 May 2016 at 09:04, Chen-Yu Tsai <wens@csie.org> wrote:
> When IS_ERR_VALUE was removed from the mmc core code, it was replaced
> with a simple not-zero check. This does not work, as the value checke=
d
> is the return value for mmc_select_bus_width, which returns the set
> bit width on success. This made eMMC modes higher than HS-DDR unusabl=
e.
>
> Fix this by checking for a positive return value instead.
>
> Fixes: 287980e49ffc ("remove lots of IS_ERR_VALUE abuses")
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  drivers/mmc/core/mmc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index c984321d1881..aafb73d080ca 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1276,7 +1276,7 @@ static int mmc_select_hs200(struct mmc_card *ca=
rd)
>          * switch to HS200 mode if bus width is set successfully.
>          */
>         err =3D mmc_select_bus_width(card);
> -       if (!err) {
> +       if (err > 0) {
>                 val =3D EXT_CSD_TIMING_HS200 |
>                       card->drive_strength << EXT_CSD_DRV_STR_SHIFT;
>                 err =3D __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> @@ -1583,7 +1583,7 @@ static int mmc_init_card(struct mmc_host *host,=
 u32 ocr,
>         } else if (mmc_card_hs(card)) {
>                 /* Select the desired bus width optionally */
>                 err =3D mmc_select_bus_width(card);
> -               if (!err) {
> +               if (err > 0) {

As pointed out in the review by Bj=C3=B6rn, to restore the old behaviou=
r we
should check for "err >=3D 0".
No need to send a new patch, I can amend the current version.

>                         err =3D mmc_select_hs_ddr(card);
>                         if (err)
>                                 goto free_card;
> --
> 2.8.1
>

=46inally, I am a little concerned about the commit 287980e49ffc
("remove lots of IS_ERR_VALUE abuses") which introduced this
regression.

Surprisingly the IS_ERR_VALUE():s aren't being replaced by equivalent
checks, so perhaps there a more regressions. Moreover, I wonder why I
wasn't being on cc/to list when this patch was submitted a few days
ago, perhaps my review could prevented the regression from even
happen.

Anyway, let's fix this now! I will pick up $subject patch as fix asap..=
=2E

and Arnd, can you please double-check that the commit 287980e49ffc
doesn=E2=80=99t seems to regress anything else!?

Kind regards
Uffe
