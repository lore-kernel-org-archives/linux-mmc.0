From: Bough Chen <haibo.chen@nxp.com>
Subject: RE: [PATCH] mmc: sdhci: cast unsigned int to unsigned long long to
 avoid unexpeted error
Date: Fri, 14 Oct 2016 09:53:01 +0000
Message-ID: <AM4PR0401MB2324BA6265407D6A4FE3F30190DF0@AM4PR0401MB2324.eurprd04.prod.outlook.com>
References: <1473750418-23111-1-git-send-email-haibo.chen@nxp.com>
 <3603c63f-f007-12cc-677b-f39924628335@intel.com>
 <cd546cd4-e64f-1b86-1cae-08b89dabc410@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-db5eur01on0080.outbound.protection.outlook.com ([104.47.2.80]:9498
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932193AbcJNN0O (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 14 Oct 2016 09:26:14 -0400
In-Reply-To: <cd546cd4-e64f-1b86-1cae-08b89dabc410@intel.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> owner@vger.kernel.org] On Behalf Of Adrian Hunter
> Sent: Friday, October 14, 2016 5:12 PM
> To: Bough Chen <haibo.chen@nxp.com>; ulf.hansson@linaro.org
> Cc: linux-mmc@vger.kernel.org
> Subject: Re: [PATCH] mmc: sdhci: cast unsigned int to unsigned long long =
to
> avoid unexpeted error
>=20
> On 13/09/16 11:36, Adrian Hunter wrote:
> > On 13/09/16 10:06, Haibo Chen wrote:
> >> Potentially overflowing expression 1000000 * data->timeout_clks with
> >> type unsigned int is evaluated using 32-bit arithmetic, and then used
> >> in a context that expects an expression of type unsigned long long.
> >>
> >> To avoid overflow, cast 1000000U to type unsigned long long.
> >> Special thanks to coverity <http://www.coverity.com>
> >
> > Let's leave out the web link - it is enough to say it was found with Co=
verity.
> >
> >>
> >> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
>=20
> Do you plan to re-submit this?
>=20

Yes, I will re-submit this soon.=20

> >
> > Needs a fixes tag and cc stable.
> >
> >> ---
> >>  drivers/mmc/host/sdhci.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> >> index 4805566..0e9f495 100644
> >> --- a/drivers/mmc/host/sdhci.c
> >> +++ b/drivers/mmc/host/sdhci.c
> >> @@ -687,7 +687,7 @@ static u8 sdhci_calc_timeout(struct sdhci_host *ho=
st,
> struct mmc_command *cmd)
> >>  			 * host->clock is in Hz.  target_timeout is in us.
> >>  			 * Hence, us =3D 1000000 * cycles / Hz.  Round up.
> >>  			 */
> >> -			val =3D 1000000 * data->timeout_clks;
> >> +			val =3D (unsigned long long)1000000 * data->timeout_clks;
> >
> > Please use 1000000ULL instead of a cast.
> >
> >>  			if (do_div(val, host->clock))
> >>  				target_timeout++;
> >>  			target_timeout +=3D val;
> >>
> >
> >
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in t=
he
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
