From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RFC] mmc: host: tmio: ensure end of DMA and SD access are in
 sync
Date: Thu, 16 Feb 2017 09:44:07 +0100
Message-ID: <20170216084406.GB1443@katana>
References: <20170215180541.8614-1-wsa+renesas@sang-engineering.com>
 <CAPDyKFotpgrUHtTYQ9QQfzQ0pY6=MtU2JEDAjPX=wh50k=qGjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="yNb1oOkm5a9FJOVX"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFotpgrUHtTYQ9QQfzQ0pY6=MtU2JEDAjPX=wh50k=qGjA@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org


--yNb1oOkm5a9FJOVX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 16, 2017 at 09:28:24AM +0100, Ulf Hansson wrote:
> On 15 February 2017 at 19:05, Wolfram Sang
> <wsa+renesas@sang-engineering.com> wrote:
> > The current code assumes that DMA is finished before SD access end is
> > flagged. Thus, it schedules the 'dma_complete' tasklet in the SD card
> > interrupt routine when DATAEND is set. The assumption is not safe,
> > though. Even by mounting an SD card, it can be seen that sometimes DMA
> > complete is first, sometimes DATAEND. It seems they are usually close
> > enough timewise to not cause problems. However, a customer reported that
> > with CMD53 sometimes things really break apart. As a result, the BSP has
> > a patch which introduces flags for both events and makes sure both flags
> > are set before scheduling the tasklet. The customer accepted the patch,
> > yet it doesn't seem a proper upstream solution to me.
> >
> > This patch refactors the code to replace the tasklet with already
> > existing and more lightweight mechanisms. First of all, we set the
> > callback in a DMA descriptor to automatically get notified when DMA is
> > done. In the callback, we then use a completion to make sure the SD
> > access has already ended. Then, we proceed as before.
>=20
> I have similar experience and a HW behaviour. Your reasoning seems
> correct to me.

Great. Thanks for the review!

> > So, calling for early review here. And opinions how to proceed. I am no=
t sure
> > we want this in renesas-drivers until the SDIO functionality has been v=
erified?
> > Because it is the reason this patch exists in the first place :)
>=20
> If there are no regressions, we could consider this as a nice
> clean-up, instead of waiting for the dependencies to be resolved.

Fine with me. I feel much more comfortable with your experience backing
up ours.

>=20
> Did you run some performance test?

The throughput numbers of 'dd' are exactly the same. But maybe I could
run one or two more tests with specifically testing that.

> > index 2b349d48fb9a8a..891d400d2a7cf2 100644
> > --- a/drivers/mmc/host/tmio_mmc.h
> > +++ b/drivers/mmc/host/tmio_mmc.h
> > @@ -137,7 +137,7 @@ struct tmio_mmc_host {
> >         bool                    force_pio;
> >         struct dma_chan         *chan_rx;
> >         struct dma_chan         *chan_tx;
> > -       struct tasklet_struct   dma_complete;
> > +       struct completion       dma_dataend;
> >         struct tasklet_struct   dma_issue;
>=20
> The next step would be to convert the driver to a use threaded IRQ
> handler in favour of the dma_issue tasklet. That should also work,
> right!? :-)

I'll check. I also identified this tasklet as the next target but I
haven't actually looked into it yet.

Thanks for looking into it right away,

   Wolfram


--yNb1oOkm5a9FJOVX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYpWZWAAoJEBQN5MwUoCm23XQQAKgdFalP3KL3OvJcEEkBdx/0
mzcL4o/miDPlceC6yGXhrL8J8EkhY22NFdxZy37UbA/0OkoTg6hjLlwGwhX0MGQa
CfMRLclSuSHP/4Z9duKXiAZxGOoo94Krj19YEDdpBaBg8ire3BXrI0cZUMgGGSr8
gST9ZOdNHvgzPOl5wL2OSSMIDmG6DBQyTXzUAwzyvo56JM1q+/r3kakX6We5it4c
bG9MWJzgm1C7vruk++r9Do/GKpIG7V4cBVQ1ZddctVxDnQtbuqMJFHh3Bw+b1Q8X
ItUof0EIEn+Cc+Fpy98K+bV8sj0PDmVP0A61jf1/jIGb9o56lKyQuwVeHNw6mZ4g
+AaIK3zxZi0u111xb0+eVdj9eV6kMMNI7IJ6wd/HHhNlehJFs5qWD4o09Tv2jurn
/ROdQPI/utFijOxb+/9jnqr0M9qHoQVZ4wyMFkDvnShXe2rhq4j95YfHuVvU18xG
5fyejkzeeNJENP54/J4b70S9puqx87XYmXWyDnuyZ3iFSVcPBO+VoQo41kOOq8Zp
afuc7+IeXBges0fGEYMA2fobxbRzRSoEBsaDAY8vKXT5fTh4/Lay1nUUyq6DI4/c
rjlkVjpLhKWOwbgEwTDkeaaK6lSolDJ0PzgPfpALsb5sl9HBLhKXRKyunQWGyt2Z
M6kENOwez4Z9HSVyFk5Q
=NZs1
-----END PGP SIGNATURE-----

--yNb1oOkm5a9FJOVX--
