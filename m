From: kishore kadiyala <kishorek.kadiyala@gmail.com>
Subject: Re: [PATCH v5] OMAP: Fix for bus width which improves SD card's
	peformance.
Date: Tue, 15 Jun 2010 13:34:49 +0530
Message-ID: <AANLkTiks-UvRtQiZtpp-zwlGhMcGNoPZdHKC29lrlFYr@mail.gmail.com>
References: <003b01cad0f0$6ea78040$544ff780@am.dhcp.ti.com>
	<20100406163211.GA29117@nokia.com>
	<4BBB6767.7010202@ti.com>
	<20100406165720.GA17916@nokia.com>
	<00b401cad5e0$1d1868d0$544ff780@am.dhcp.ti.com>
	<4BBBC628.9030207@ti.com>
	<00c901cad5e7$9de54350$544ff780@am.dhcp.ti.com>
	<4BBBD87C.1040307@ti.com>
	<003601cad73c$98c3aa50$544ff780@am.dhcp.ti.com>
	<s2l7f9d1ffb1004190836l9ba703c5lab13638d968a5c55@mail.gmail.com>
	<h2h7f9d1ffb1004190851gf08897awf198d3c8e5f9dbce@mail.gmail.com>
	<008f01cae1b2$6262c970$544ff780@am.dhcp.ti.com>
	<AANLkTikNlJLiJeXwbBuS_KGPN6soAlKLQH1EUeJCKYi2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <AANLkTikNlJLiJeXwbBuS_KGPN6soAlKLQH1EUeJCKYi2@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Madhusudhan <madhu.cr@ti.com>, akpm@linux-foundation.org, tony@atomide.com, Nishanth Menon <nm@ti.com>, felipe.balbi@nokia.com, Vimal Singh <vimal.newwork@gmail.com>, "S, Venkatraman" <svenkatr@ti.com>, "Lavinen Jarkko (Nokia-D/Helsinki)" <jarkko.lavinen@nokia.com>
List-Id: linux-mmc@vger.kernel.org

Sorry its Line wrapped and please drop this, Will be reposting the same=
=2E

Regards,
Kishore

On Mon, Jun 14, 2010 at 9:40 PM, kishore kadiyala
<kishorek.kadiyala@gmail.com> wrote:
> This patch improves low speeds for SD cards.
> OMAP-MMC controller's can support maximum bus width of '8'.
> when bus width is mentioned as "8" in controller data,the SD
> stack will check whether bus width is "4" and if not it will
> set bus width to "1" and there by degrading performance.
> This patch fixes the issue and improves the performance of
> SD cards.
>
> Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
> Signed-off-by: Venkatraman S <svenkatr@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Acked-by: Madhusudhan Chikkature <madhu.cr@ti.com>
> Tested-by: Jarkko Nikula <jhnikula@gmail.com>
> ---
> In V5 : Rebasing on 2.6.35-rc3
> In V4 : Updated with Nishanth's comments and appened his Signed-off
> =A0 =A0 =A0 =A0http://marc.info/?t=3D127169149300006&r=3D1&w=3D2
> In V3 : Updated =A0with Madhu's comments =A0and appended Tested by Ni=
kula
> In V2 : Appended Signed-off by Venkat and Ack by Madhu
>
> Here are my experiment numbers, on a Class 6 SDHC card:
> Read peformance is increased by 220%
> Write Performance is increased by 52%
>
> =A0drivers/mmc/host/omap_hsmmc.c | =A0 17 +++++++++++++++--
> =A01 files changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hs=
mmc.c
> index b032828..a0c8515 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -2096,10 +2096,23 @@ static int __init omap_hsmmc_probe(struct
> platform_device *pdev)
> =A0 =A0 =A0 =A0mmc->caps |=3D MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGH=
SPEED |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MMC_CAP_WAIT_WHILE_BUSY;
>
> - =A0 =A0 =A0 if (mmc_slot(host).wires >=3D 8)
> + =A0 =A0 =A0 switch (mmc_slot(host).wires) {
> + =A0 =A0 =A0 case 8:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->caps |=3D MMC_CAP_8_BIT_DATA;
> - =A0 =A0 =A0 else if (mmc_slot(host).wires >=3D 4)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Fall through */
> + =A0 =A0 =A0 case 4:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->caps |=3D MMC_CAP_4_BIT_DATA;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case 1:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Nothing to crib here */
> + =A0 =A0 =A0 case 0:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Assuming nothing was given by board,=
 Core use's 1-Bit */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Completely unexpected.. Core goes wi=
th 1-Bit Width */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_crit(mmc_dev(host->mmc), "Invalid w=
idth %d\n used!"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "using 1 instead\n", mm=
c_slot(host).wires);
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0if (mmc_slot(host).nonremovable)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->caps |=3D MMC_CAP_NONREMOVABLE;
> --
> 1.6.3.3
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
