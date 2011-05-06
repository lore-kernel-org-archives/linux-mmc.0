From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH 08/22] mmc: omap_hsmmc: correct debug report error status
	mnemonics
Date: Fri, 6 May 2011 14:05:44 +0530
Message-ID: <BANLkTim963pDi_awSYefAqMwPSi5L3k_mA@mail.gmail.com>
References: <1304596282-4095-1-git-send-email-adrian.hunter@nokia.com>
	<1304596282-4095-9-git-send-email-adrian.hunter@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1304596282-4095-9-git-send-email-adrian.hunter@nokia.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Madhusudhan Chikkature <madhu.cr@ti.com>
List-Id: linux-mmc@vger.kernel.org

On Thu, May 5, 2011 at 5:21 PM, Adrian Hunter <adrian.hunter@nokia.com> wro=
te:
> CERR and BADA were in the wrong place and there are only
> 32 not 35.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
> ---
> =A0drivers/mmc/host/omap_hsmmc.c | =A0 19 +++++++++++--------
> =A01 files changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index bd52849..a1a1101 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -982,14 +982,14 @@ static void omap_hsmmc_dma_cleanup(struct omap_hsmm=
c_host *host, int errno)
> =A0* Readable error output
> =A0*/
> =A0#ifdef CONFIG_MMC_DEBUG
> -static void omap_hsmmc_report_irq(struct omap_hsmmc_host *host, u32 stat=
us)
> +static void omap_hsmmc_dbg_report_irq(struct omap_hsmmc_host *host, u32 =
status)
> =A0{
> =A0 =A0 =A0 =A0/* --- means reserved bit without definition at documentat=
ion */
> =A0 =A0 =A0 =A0static const char *omap_hsmmc_status_bits[] =3D {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 "CC", "TC", "BGE", "---", "BWR", "BRR", "--=
-", "---", "CIRQ",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 "OBI", "---", "---", "---", "---", "---", "=
ERRI", "CTO", "CCRC",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 "CEB", "CIE", "DTO", "DCRC", "DEB", "---", =
"ACE", "---",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 "---", "---", "---", "CERR", "CERR", "BADA"=
, "---", "---", "---"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "CC" =A0, "TC" =A0, "BGE", "---", "BWR" , "=
BRR" , "---" , "---" ,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "CIRQ", "OBI" , "---", "---", "---" , "---"=
 , "---" , "ERRI",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "CTO" , "CCRC", "CEB", "CIE", "DTO" , "DCRC=
", "DEB" , "---" ,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "ACE" , "---" , "---", "---", "CERR", "BADA=
", "---" , "---"
> =A0 =A0 =A0 =A0};
> =A0 =A0 =A0 =A0char res[256];
> =A0 =A0 =A0 =A0char *buf =3D res;
> @@ -1006,6 +1006,11 @@ static void omap_hsmmc_report_irq(struct omap_hsmm=
c_host *host, u32 status)
>
> =A0 =A0 =A0 =A0dev_dbg(mmc_dev(host->mmc), "%s\n", res);
> =A0}
> +#else
> +static inline void omap_hsmmc_dbg_report_irq(struct omap_hsmmc_host *hos=
t,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0u32 status)
> +{
> +}
> =A0#endif =A0/* CONFIG_MMC_DEBUG */
>
> =A0/*
> @@ -1064,9 +1069,7 @@ static void omap_hsmmc_do_irq(struct omap_hsmmc_hos=
t *host, int status)
> =A0 =A0 =A0 =A0dev_dbg(mmc_dev(host->mmc), "IRQ Status is %x\n", status);
>
> =A0 =A0 =A0 =A0if (status & ERR) {
> -#ifdef CONFIG_MMC_DEBUG
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_hsmmc_report_irq(host, status);
> -#endif
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_hsmmc_dbg_report_irq(host, status);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if ((status & CMD_TIMEOUT) ||
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(status & CMD_CRC)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (host->cmd) {
> --
> 1.7.0.4
>
I checked against the TRM and you are right.
FWIW,
 Reviewed-by: Venkatraman S <svenkatr@ti.com>
