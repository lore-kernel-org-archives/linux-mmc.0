From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH 19/22] OMAP: hsmmc: implement clock switcher
Date: Thu, 5 May 2011 16:34:06 +0300
Message-ID: <BANLkTin7iMibEZihx6nCHibB1GLiuJzCDA@mail.gmail.com>
References: <1304596282-4095-1-git-send-email-adrian.hunter@nokia.com>
	<1304596282-4095-20-git-send-email-adrian.hunter@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1304596282-4095-20-git-send-email-adrian.hunter@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>, Madhusudhan Chikkature <madhu.cr@ti.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
List-Id: linux-mmc@vger.kernel.org

On Thu, May 5, 2011 at 2:51 PM, Adrian Hunter <adrian.hunter@nokia.com>=
 wrote:
> From: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
>
> There are 3 new platform data methods which should help us to do a cl=
ock
> switching when notification is happened or request is started.
>
> The purpose of the patch is to avoid high frequency of MMC controller=
 on low
> OPPs due to an HW bug in OMAP 3630.
>
> The algorithm:
> =A0- the PM governor switches the clock of L3 (and therefore L4) bus =
on demand
> =A0- the MMC controller clock should follow the change
>
> We have considered two OPPs for L3/L4 bus. Thus, we have correspondin=
g flow:
> =A0- OPP1 -> OPP2 (in case of abort - OPP1)
> =A0- OPP2 -> OPP1 (in case of abort - OPP2)
>
> During idle the MMC gates functional clock and we don't care about th=
e
> frequency. Most important to get proper solution when notification co=
mes during
> request. Then:
> =A0- in case of OPP1 -> OPP2 we update frequency limit and it will be=
 used for
> =A0 new coming requests (it assumes the current frequency of the cont=
roller is
> =A0 lower then new one)
> =A0- otherwise we wait until no device has used higher frequency then=
 upcoming
> =A0 one
>
> Known issues and limitations:
> =A0- originally a clock notifier was used for the core L4 iclk but fo=
r upstream
> =A0 Adrian changed to a cpufreq notifier where we assume OPP1 below 4=
00MHz and
> =A0 OPP2 above 400MHz
>
> Signed-off-by: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
> Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
> ---
> =A0arch/arm/mach-omap2/hsmmc.c =A0 =A0 =A0 =A0 =A0 | =A0180 +++++++++=
+++++++++++++++++++++++-
> =A0arch/arm/plat-omap/include/plat/mmc.h | =A0 =A08 ++
> =A02 files changed, 187 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.=
c
> index 6b97fae..34cba89 100644
> --- a/arch/arm/mach-omap2/hsmmc.c
> +++ b/arch/arm/mach-omap2/hsmmc.c

<snip>

> +
> +static int hsmmc_clk_notifier(struct notifier_block *nb, unsigned lo=
ng event,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 void *data)
> +{
> + =A0 =A0 =A0 struct cpufreq_freqs *freqs =3D data;
> + =A0 =A0 =A0 unsigned int threshold =3D 400000; /* between opp1 and =
opp2 */
> +
> + =A0 =A0 =A0 switch (event) {
> + =A0 =A0 =A0 case CPUFREQ_PRECHANGE:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (freqs->new < threshold && freqs->ol=
d > threshold) {

What if we go from 400000 to, say, 200000?

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* opp2 -> opp1 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hsmmc_max_freq =3D HSMM=
C_MAX_FREQ >> 1;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Timeout is 1 sec */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!wait_event_timeout=
(hsmmc_max_freq_wq,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 hsmmc_max_freq_ok(),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 msecs_to_jiffies(1000)))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err(=
"MMC violates maximum frequency "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0"constraint\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case CPUFREQ_POSTCHANGE:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (freqs->old < threshold && freqs->ne=
w > threshold) {

Same here, you could go from 200000 to 400000 and then 600000 and code
would never notice it.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* opp1 -> opp2 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hsmmc_max_freq =3D HSMM=
C_MAX_FREQ;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
