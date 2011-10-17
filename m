From: Girish K S <girish.shivananjappa@linaro.org>
Subject: Re: [PATCH V8 RESEND] mmc: core: Add Power Off Notify Feature eMMC 4.5
Date: Mon, 17 Oct 2011 20:30:09 +0530
Message-ID: <CAGxe1ZFGF8vQVHUzx_zmFTPSwTYNXAyK3+yEiqtP7dswPTsS1A@mail.gmail.com>
References: <1318862823-22909-1-git-send-email-girish.shivananjappa@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1318862823-22909-1-git-send-email-girish.shivananjappa@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: kgene.kim@samsung.com, patches@linaro.org, linux-samsung-soc@vger.kernel.org, Girish K S <girish.shivananjappa@linaro.org>, Chris Ball <cjb@laptop.org>, Jaehoon Chung <jh80.chung@samsung.com>
List-Id: linux-mmc@vger.kernel.org

On 17 October 2011 20:17, Girish K S <girish.shivananjappa@linaro.org> =
wrote:
> This patch adds the support for power off notify feature, available i=
n
> eMMC 4.5 devices. If the the host has support for this feature, then =
the
> mmc core will notify it to the device by setting the POWER_OFF_NOTIFI=
CATION
> byte in the extended csd register with a value 1(POWER_ON).
>
> For suspend mode short timeout is used, whereas for the normal powero=
ff long
> timeout is used.
>
> cc: Chris Ball <cjb@laptop.org>
> Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
> Changes in V8:
> =A0 =A0 =A0 =A0Updated with review comments of Chris Ball and rebased=
 to
> =A0 =A0 =A0 =A0chris-mmc/mmc-next branch.
> Changes in V7:
> =A0 =A0 =A0 =A0Rebased to chris-mmc/mmc-next branch. merged to patche=
s
> =A0 =A0 =A0 =A0to single patch.
> Changes in V6:
> =A0 =A0 =A0 =A0Fixes checkpatch errors. The patches are generated aft=
er
> =A0 =A0 =A0 =A0rebasing to chris's mmc-next branch.
> Changes in V5:
> =A0 =A0 =A0 =A0This patch version fixes the problem with power off
> =A0 =A0 =A0 =A0notify function, when called for the first time and
> =A0 =A0 =A0 =A0card is not yet initialised.
> Changes in V4:
> =A0 =A0 =A0 =A0Updated with review comments of Jeon
> Changes in V2:
> =A0 =A0 =A0 =A0Adds poweroff notification handling in suspend/normal.
>
>
> =A0drivers/mmc/core/core.c =A0| =A0 =A06 ++----
> =A0include/linux/mmc/host.h | =A0 =A02 +-
> =A02 files changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index db368b2..b1eca96 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1217,16 +1217,14 @@ void mmc_power_off(struct mmc_host *host)
> =A0 =A0 =A0 =A0unsigned int timeout;
> =A0 =A0 =A0 =A0int err;
>
> - =A0 =A0 =A0 BUG_ON(!host);
> -
> =A0 =A0 =A0 =A0mmc_host_clk_hold(host);
>
> =A0 =A0 =A0 =A0card =3D host->card;
> =A0 =A0 =A0 =A0host->ios.clock =3D 0;
> =A0 =A0 =A0 =A0host->ios.vdd =3D 0;
>
> - =A0 =A0 =A0 if (card !=3D NULL && mmc_card_mmc(card) &&
> - =A0 =A0 =A0 =A0 =A0 (card->poweroff_notify_state =3D=3D MMC_POWERED=
_ON)) {
> + =A0 =A0 =A0 if (card && mmc_card_mmc(card) &&
> + =A0 =A0 =A0 =A0 =A0 card->poweroff_notify_state =3D=3D MMC_POWERED_=
ON) {
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (host->power_notify_type =3D=3D MMC=
_HOST_PW_NOTIFY_SHORT) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0notify_type =3D EXT_CS=
D_POWER_OFF_SHORT;
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 65c47fc..a991ae7 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -243,7 +243,7 @@ struct mmc_host {
> =A0#define MMC_CAP2_POWEROFF_NOTIFY (1 << 2) =A0 =A0 =A0/* Notify pow=
eroff supported */
>
> =A0 =A0 =A0 =A0mmc_pm_flag_t =A0 =A0 =A0 =A0 =A0 pm_caps; =A0 =A0 =A0=
 =A0/* supported pm features */
> - =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0power_notify_type;
> + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0power_notify_type;
> =A0#define MMC_HOST_PW_NOTIFY_NONE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00
> =A0#define MMC_HOST_PW_NOTIFY_SHORT =A0 =A0 =A0 1
> =A0#define MMC_HOST_PW_NOTIFY_LONG =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A02
> --
Ignore this patch. this just gives only the diff with previous patch.
i will resend the complete patch
> 1.7.1
>
>
