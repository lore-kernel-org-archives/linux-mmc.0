From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v1 1/1] mmc: core: control EXT_CSD_CACHE_CTRL from device tree
Date: Tue, 4 Dec 2018 15:19:48 +0100
Message-ID: <CAPDyKFrrxQOz89kW9rXNRFoeVmw7r0=94Yo4-Dq9W8VEdRtLvg@mail.gmail.com>
References: <c0e11e0a23fbb6b9867963c4b143fcb1c60b403c.1542744186.git.lsun@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c0e11e0a23fbb6b9867963c4b143fcb1c60b403c.1542744186.git.lsun@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liming Sun <lsun@mellanox.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, David Woods <dwoods@mellanox.com>, Shawn Lin <shawn.lin@rock-chips.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, 20 Nov 2018 at 21:06, Liming Sun <lsun@mellanox.com> wrote:
>
> Currently the EXT_CSD_CACHE_CTRL register is controlled by API
> mmc_card_broken_hpi(), which only works for the quirks settings.
> This commit enhances it to use card->ext_csd.hpi instead. This
> flag works for both the quirks and the broken-hpi configuration
> in the device tree.
>
> Signed-off-by: Liming Sun <lsun@mellanox.com>

I realize that the code around the HPI support needs some additional
love. Let me post some patches in a day or two, then you can have a
look a let me know your thoughts.

> ---
>  drivers/mmc/core/mmc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index bc1bd2c..2f2b65c 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1791,8 +1791,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>          * If cache size is higher than 0, this indicates
>          * the existence of cache and it can be turned on.
>          */
> -       if (!mmc_card_broken_hpi(card) &&
> -           card->ext_csd.cache_size > 0) {
> +       if (card->ext_csd.hpi && card->ext_csd.cache_size > 0) {

Actually, I don't see a reason to why we should limit to use the
cache, to whether HPI is supported or not.

I guess the thinking behind this, was that we wanted an option to
abort the cache flush as there is no timeout available for that
operation. However, I don't see whenever we should allow a cache flush
to be aborted, as it would introduce a potential option of getting
corrupt data on the flash.

>                 err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>                                 EXT_CSD_CACHE_CTRL, 1,
>                                 card->ext_csd.generic_cmd6_time);
> --
> 1.8.3.1
>

Kind regards
Uffe
