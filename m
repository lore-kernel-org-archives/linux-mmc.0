From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 17/22] mmc: tmio: move TMIO_MASK_{READOP,WRITEOP}
 handling to correct place
Date: Tue, 16 Jan 2018 09:01:01 +0100
Message-ID: <20180116080101.264qbj5inn76abom@ninjato>
References: <1511540697-27387-1-git-send-email-yamada.masahiro@socionext.com>
 <1511540697-27387-18-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ygmavdhedxhpgfij"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1511540697-27387-18-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-mmc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org


--ygmavdhedxhpgfij
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 25, 2017 at 01:24:52AM +0900, Masahiro Yamada wrote:
> This driver was largely extended by Renesas, but actually used by
> several SoC vendors.  The current code does not work for UniPhier
> SoCs at least.

Do you insist on this paragraph? All people working on the code so far
tried hard to make it work on all devices they had access to. So far, I
can't recall one of the several SoC vendors contacting upstream to get
their support merged (until now, of course) or even to file bugs.
Because I can't guess unknown stuff, I'd prefer to skip this paragraph.

> The DMA mode for UniPhier SoCs failed with the following error message:
>   PIO IRQ in DMA mode!
>=20
> For UniPhier SoCs, the TMIO_MASK_{READOP,WRITEOP} are asserted in the
> DMA mode as well.

Sure, that we need to fix! Note that both Renesas DMA drivers also
enable DATAEND and disable RXRDY | TXRQ on their own, too. So, probably
the same issue? And IIUC we can decide now to prepare the irqs like this
in tmio_core because all known DMA engines need it. Or we keep it that
DMA engines set up irqs themselves. More flexible but maybe
over-engineered?

> In fact, the code is very strange.

Yes.

> The TMIO_MASK_{READOP,WRITEOP} IRQs are set as follows:
>=20
>     /* Unmask the IRQs we want to know about */
>     if (!_host->chan_rx)
>             irq_mask |=3D TMIO_MASK_READOP;
>     if (!_host->chan_tx)
>             irq_mask |=3D TMIO_MASK_WRITEOP;
>=20
> At this point, _host->{chan_rx,chan_tx} are _always_ NULL because
> tmio_mmc_request_dma() is called after this code.  Consequently,
> TMIO_MASK_{READOP,WRITEOP} are set whether DMA is used or not.

Yes :( Bummer.

> tmio_mmc_cmd_irq() enables TMIO_MASK_{READOP,WRITEOP}, but never
> disables them.  This does not take care of a case where ->force_pio
> is set, but unset later.

force_pio gets disabled within the same request? I may be overlooking
something but I only see code paths where force_pio gets cleared and a
little later the request gets finished. Can you give me a pointer?

> After all, the correct place to handle those flags is just before
> starting the data transfer.

While I totally agree the code below can be improved for sure, I'd
prefer to keep the design pattern that irqs get disabled once they are
not actively used. Generally spoken, I think it makes sense to keep
regressions on old platforms low. Any chance this can be achieved?
Other than that, fixing/removing this irq_mask handling from probe() is
really good.

>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>=20
> Changes in v2:
>   - Newly added
>=20
>  drivers/mmc/host/tmio_mmc_core.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc=
_core.c
> index 7d169ed..345e379 100644
> --- a/drivers/mmc/host/tmio_mmc_core.c
> +++ b/drivers/mmc/host/tmio_mmc_core.c
> @@ -621,15 +621,19 @@ static void tmio_mmc_cmd_irq(struct tmio_mmc_host *=
host, unsigned int stat)
>  	 */
>  	if (host->data && (!cmd->error || cmd->error =3D=3D -EILSEQ)) {
>  		if (host->data->flags & MMC_DATA_READ) {
> -			if (host->force_pio || !host->chan_rx)
> +			if (host->force_pio || !host->chan_rx) {
>  				tmio_mmc_enable_mmc_irqs(host, TMIO_MASK_READOP);
> -			else
> +			} else {
> +				tmio_mmc_disable_mmc_irqs(host, TMIO_MASK_READOP);
>  				tasklet_schedule(&host->dma_issue);
> +			}
>  		} else {
> -			if (host->force_pio || !host->chan_tx)
> +			if (host->force_pio || !host->chan_tx) {
>  				tmio_mmc_enable_mmc_irqs(host, TMIO_MASK_WRITEOP);
> -			else
> +			} else {
> +				tmio_mmc_disable_mmc_irqs(host, TMIO_MASK_WRITEOP);
>  				tasklet_schedule(&host->dma_issue);
> +			}
>  		}
>  	} else {
>  		schedule_work(&host->done);
> @@ -1285,12 +1289,6 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_hos=
t,
>  	_host->sdcard_irq_mask =3D sd_ctrl_read16_and_16_as_32(_host, CTL_IRQ_M=
ASK);
>  	tmio_mmc_disable_mmc_irqs(_host, TMIO_MASK_ALL);
> =20
> -	/* Unmask the IRQs we want to know about */
> -	if (!_host->chan_rx)
> -		irq_mask |=3D TMIO_MASK_READOP;
> -	if (!_host->chan_tx)
> -		irq_mask |=3D TMIO_MASK_WRITEOP;
> -
>  	_host->sdcard_irq_mask &=3D ~irq_mask;
> =20
>  	if (_host->native_hotplug)
> --=20
> 2.7.4
>=20

--ygmavdhedxhpgfij
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlpdsTkACgkQFA3kzBSg
KbaHxQ//X8opOoryELYxuADAV4M525e33c9nvfFG8Mxv4mAxoojXzRAOA6ttY4+u
sDqsUZNF3NV0ZzejynUcCwN94UU7AzIeLnno1aIaTPGXBpnkPJqpDYMMvfPqqwG5
kB/BGszYj9avQlJr6owNuUCM0T1Hn0IchhfhymOWOLV9m/KYXJCLIcp9XRHuMZa/
P2MU/aMvu83FFPbImxUob7UuitNr4wcsCXdMjN5J9gCivxGik29isZ4sPy2+AS0Y
7rdEAptpmzJsWejP7S9PEFA0oS9U9OG1K2nkE8+NvtffRoIrBUjz7IiRPuf2gTtZ
QtqcZqZqJS5OWJ9pqECDq4WDSlNDMZqvj7BB8nCckV4KBOnoSn7U0imK1bCRkbQS
L5+oLlB4MpXYSR5tLdGH4D1axrDE1vUb4slqnS3ZhK0upaO+Js0/eF2bqoxzwTHn
zCWTf5oVXQdfPUoIUMziEc1p8K0OF37Yao128YohYaY0FUO5bAk+N6AKSRgcFN8n
JMu4BvfcTOhIu4gTgbLoKcoqoYpKCZ8am3Z4Xvpt45q6AuG70GeI7Prk6KH9gv5b
if1rxUwiG7FmKokZYVdt3qSsvKc0gbwjfjElFDuvQ67R0Vo6/w7+Gc89MukUrLIq
o/6RF4K8UXZhgGsyIkcbF6Z6OztByxa0vzO9U2H3kj1GAYB49k0=
=ufKO
-----END PGP SIGNATURE-----

--ygmavdhedxhpgfij--
