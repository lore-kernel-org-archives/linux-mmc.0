From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH 02/11] mmc: sdhci-of-arasan: Always power the PHY off/on
 when clock changes
Date: Mon, 13 Jun 2016 16:06:47 -0700
Message-ID: <CAD=FV=V8GumWP0aKQdCyXBEdUcjg7c5BKLu5smUYuZW3C5DHmA@mail.gmail.com>
References: <1465339484-969-1-git-send-email-dianders@chromium.org>
 <1465339484-969-3-git-send-email-dianders@chromium.org> <ae4409b0-48a5-e30f-a244-7a28bd7a9daa@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ae4409b0-48a5-e30f-a244-7a28bd7a9daa@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>, Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>, Ziyuan Xu <xzy.xu@rock-chips.com>, Brian Norris <briannorris@chromium.org>, Adrian Hunter <adrian.hunter@intel.com>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Michal Simek <michal.simek@xilinx.com>, soren.brinkmann@xilinx.com, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Mon, Jun 13, 2016 at 1:08 AM, Shawn Lin <shawn.lin@rock-chips.com> w=
rote:
> =E5=9C=A8 2016/6/8 6:44, Douglas Anderson =E5=86=99=E9=81=93:
>>
>> In commit 802ac39a5566 ("mmc: sdhci-of-arasan: fix set_clock when a =
phy
>> is supported") we added code to power the PHY off and on whenever th=
e
>> clock was changed but we avoided doing the power cycle code when the
>> clock was low speed.  Let's now do it always.
>>
>> Although there may be other reasons for power cycling the PHY when t=
he
>> clock changes, one of the main reasons is that we need to give the D=
LL a
>> chance to re-lock with the new clock.
>>
>> One of the things that the DLL is for is tuning the Receive Clock in
>> HS200 mode and STRB in HS400 mode.  Thus it is clear that we should =
make
>> sure we power cycle the PHY (and wait for the DLL to lock) when we k=
now
>> we'll be in one of these two speed modes.  That's what the original =
code
>> did, though it used the clock rate rather than the speed mode.  Howe=
ver,
>> even in speed modes other than HS200,/HS400 the DLL is used for
>> something since it can be clearly observed that the PHY doesn't func=
tion
>> properly if you leave the DLL off.
>>
>> Although it appears less important to power cycle the PHY and wait f=
or
>> the DLL to lock when not in HS200/HS400 modes (no bugs were reported=
),
>> it still seems wise to let the locking always happen nevertheless.
>>
>
> From the design doc, there is no need to off/on phy when not in
> HS200/400, but maybe someone will limit the clk freq by assigning
> max-frequency in DT when in HS200/400, which will make things worse.
>
> So your patch looks sane.
>
>
>> Note: as part of this, we make sure that we never try to turn the PH=
Y on
>> when the clock is off (when the clock rate is 0).  The PHY cannot wo=
rk
>> when the clock is off since its DLL can't lock.
>>
>> This change requires ("phy: rockchip-emmc: Increase lock time
>> allowance") and will cause problems if picked without that change.
>>
>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
>> ---
>>  drivers/mmc/host/sdhci-of-arasan.c | 23 ++++++++---------------
>>  1 file changed, 8 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-of-arasan.c
>> b/drivers/mmc/host/sdhci-of-arasan.c
>> index 533e2bcb10bc..3ff1711077c2 100644
>> --- a/drivers/mmc/host/sdhci-of-arasan.c
>> +++ b/drivers/mmc/host/sdhci-of-arasan.c
>> @@ -35,11 +35,13 @@
>>  /**
>>   * struct sdhci_arasan_data
>>   * @clk_ahb:   Pointer to the AHB clock
>> - * @phy: Pointer to the generic phy
>> + * @phy:       Pointer to the generic phy
>> + * @phy_on:    True if the PHY is turned on.
>>   */
>>  struct sdhci_arasan_data {
>>         struct clk      *clk_ahb;
>>         struct phy      *phy;
>> +       bool            phy_on;
>>  };
>>
>>  static unsigned int sdhci_arasan_get_timeout_clock(struct sdhci_hos=
t
>> *host)
>> @@ -61,12 +63,10 @@ static void sdhci_arasan_set_clock(struct sdhci_=
host
>> *host, unsigned int clock)
>>  {
>>         struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
>>         struct sdhci_arasan_data *sdhci_arasan =3D
>> sdhci_pltfm_priv(pltfm_host);
>> -       bool ctrl_phy =3D false;
>>
>> -       if (clock > MMC_HIGH_52_MAX_DTR && (!IS_ERR(sdhci_arasan->ph=
y)))
>> -               ctrl_phy =3D true;
>> +       if (sdhci_arasan->phy_on && !IS_ERR(sdhci_arasan->phy)) {
>> +               sdhci_arasan->phy_on =3D false;
>>
>> -       if (ctrl_phy) {
>>                 spin_unlock_irq(&host->lock);
>>                 phy_power_off(sdhci_arasan->phy);
>>                 spin_lock_irq(&host->lock);
>> @@ -74,7 +74,9 @@ static void sdhci_arasan_set_clock(struct sdhci_ho=
st
>> *host, unsigned int clock)
>>
>>         sdhci_set_clock(host, clock);
>>
>> -       if (ctrl_phy) {
>> +       if (host->mmc->actual_clock && !IS_ERR(sdhci_arasan->phy)) {
>> +               sdhci_arasan->phy_on =3D true;
>> +
>>                 spin_unlock_irq(&host->lock);
>>                 phy_power_on(sdhci_arasan->phy);
>>                 spin_lock_irq(&host->lock);
>> @@ -257,12 +259,6 @@ static int sdhci_arasan_probe(struct platform_d=
evice
>> *pdev)
>>                         goto clk_disable_all;
>>                 }
>>
>> -               ret =3D phy_power_on(sdhci_arasan->phy);
>> -               if (ret < 0) {
>> -                       dev_err(&pdev->dev, "phy_power_on err.\n");
>> -                       goto err_phy_power;
>> -               }
>> -
>
>
> Because there is too much dependency between phy and controller, so
> previous solution is to setup clk by firmware. The same case for
> suspend and resume.
>
> Look really good to do it more legit.

Thanks!  I don't see a Reviewed-by tag so I'm not adding it.  If you'd
like your tag added, please let me know and I will add it if I send
out another version.


-Doug
