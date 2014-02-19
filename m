From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v7 4/8] ARM: sunxi: Add driver for SD/MMC
 hosts found on Allwinner sunxi SoCs
Date: Wed, 19 Feb 2014 13:14:58 +0100
Message-ID: <5304A042.7090903@redhat.com>
References: <20140217095907.15040.81893.stgit@pagira.o2s.ch> <20140217100234.15040.84232.stgit@pagira.o2s.ch> <20140218153731.GK3142@lukather> <5303C751.5090809@redhat.com> <20140219094615.GT3142@lukather>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDL4X2GMZUKRBY6ASKMAKGQE3I5KU3Y-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20140219094615.GT3142@lukather>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: =?ISO-8859-1?Q?David_Lanzend=F6rfer?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Simon Baatz <gmbnomis-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?ISO-8859-1?Q?Emilio_L=F3pez?= <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

On 02/19/2014 10:46 AM, Maxime Ripard wrote:
> Hi Hans,
>=20
> On Tue, Feb 18, 2014 at 09:49:21PM +0100, Hans de Goede wrote:
>> Hi,
>>=20
>> On 02/18/2014 04:37 PM, Maxime Ripard wrote:
>>=20
>> <snip>
>>=20
>>>> + +	for (i =3D 0; i < data->sg_len; i++) { +		pdes[i].config =3D SDXC_=
IDMAC_DES0_CH | SDXC_IDMAC_DES0_OWN | +				 SDXC_IDMAC_DES0_DIC; + +		if (d=
ata->sg[i].length =3D=3D max_len) +			pdes[i].buf_size =3D 0; /* 0 =3D=3D m=
ax_len */ +		else +			pdes[i].buf_size =3D data->sg[i].length; + +		pdes[i]=
.buf_addr_ptr1 =3D sg_dma_address(&data->sg[i]); +		pdes[i].buf_addr_ptr2 =
=3D (u32)&pdes_pa[i + 1]; +	} + +	pdes[0].config |=3D SDXC_IDMAC_DES0_FD; +=
	pdes[i - 1].config =3D SDXC_IDMAC_DES0_OWN | SDXC_IDMAC_DES0_LD; + +	wmb()=
; /* Ensure idma_des hit main mem before we start the idmac */
>>>=20
>>> wmb ensure the proper ordering of the instructions, not flushing the ca=
ches like what your comment implies.
>>=20
>> Since I put that comment there, allow me to explain. A modern ARM cpu co=
re has 2 or more units handling stores. One for regular memory stores, and =
one for io-mem stores. Regular mem stores can be re-ordered, io stores cann=
ot. Normally there is no "syncing" between the 2 store units. Cache flushin=
g is not an issue here since the memory holding the descriptors for the idm=
a controller is allocated cache coherent, which on arm means it is not cach=
ed.
>>=20
>> What is an issue here is the io-store starting the idmac hitting the io-=
mem before the descriptors hit the main-mem, the wmb() ensures this does no=
t happen.
>=20
> To expand a bit, my point was not that it was functionnally wrong. Since =
you put a barrier in there, and that it resides in a cache coherent section=
, we're fine.
>=20
> My point was that the comment itself was misleading.

Well as explained above, the purpose of the wmb is to ensure that
the descriptors hit main memory, before the following writel (in the
caller of this function) starts the controller. So I don't see exactly
how the comment is wrong.

If you've a better wording for the comment, suggestions are welcome.

<snip>

>>>> +static void sunxi_mmc_dump_errinfo(struct sunxi_mmc_host *smc_host) +=
{ +	struct mmc_command *cmd =3D smc_host->mrq->cmd; +	struct mmc_data *data=
 =3D smc_host->mrq->data; + +	/* For some cmds timeout is normal with sd/mm=
c cards */ +	if ((smc_host->int_sum & SDXC_INTERRUPT_ERROR_BIT) =3D=3D SDXC=
_RESP_TIMEOUT && +			(cmd->opcode =3D=3D SD_IO_SEND_OP_COND || cmd->opcode =
=3D=3D SD_IO_RW_DIRECT)) +		return; + +	dev_err(mmc_dev(smc_host->mmc),
>>>=20
>>> I'd rather put it at a debug loglevel.
>>=20
>> Erm, this only happens if something is seriously wrong.
>=20
> Still. Something would be seriously wrong in the MMC driver/controller. Y=
ou don't want to bloat the whole kernel logs with the dump of your register=
s just because the MMC is failing. This is of no interest to anyone but som=
eone that would actually try to debug what's wrong.

This is not a complete register dump, this writes a single line to the
kernel log saying that an io error happened, and printing the error flags
set in the status register. We cannot be much shorter then this without
simply not notifying the user that an io error has happened, and not
notifying the user is wrong IMHO.

>=20
>>>> +	/* Make sure the controller is in a sane state before enabling irqs =
*/ +	ret =3D sunxi_mmc_init_host(host->mmc); +	if (ret) +		return ret; + +	=
host->irq =3D platform_get_irq(pdev, 0); +	ret =3D devm_request_irq(&pdev->=
dev, host->irq, sunxi_mmc_irq, 0, +			       "sunxi-mmc", host); +	if (ret =
=3D=3D 0) +		disable_irq(host->irq);
>>>=20
>>> The disable_irq is useless here. Just exit.
>>=20
>> No it is not note the ret =3D=3D 0, this is not an error handling path!
>=20
> Doh... Right. My bad.
>=20
>> This is done under an if because we want to do the sunxi_mmc_exit_host r=
egardless of the request_irq succeeding or not.
>>=20
>>>=20
>>>> + +	/* And put it back in reset */ +	sunxi_mmc_exit_host(host);
>>>=20
>>> Hu? If it's in reset, how can it generate some IRQs?
>>=20
>> Yes, that is why we do the whole dance of init controller, get irq, disa=
ble irq, drop it back in reset (until the mmc subsys does a power on of the=
 mmc card / sdio dev).
>>=20
>> Sometime the controller asserts the irq in reset for some reason, so wit=
hout the dance as soon as we do the devm_request_irq we get an irq, and wor=
se, not only do we get an irq, we cannot clear it since writing to the inte=
rrupt status register does not work when the controller is in reset, so we =
get stuck re-entering the irq handler.
>=20
> Hmmm, I see. It probably deserves some commenting here too then.

This call is the mirror of the sunxi_mmc_init_host a few lines higher, whic=
h
has this comment:

/* Make sure the controller is in a sane state before enabling irqs */

Which attempts to explain why we do the init controller, claim irq,
disable irq, put controller back in reset sequence. Again suggestions
for a better comment are welcome.

<snip>

>>>> +	ret =3D mmc_add_host(mmc); + +	if (ret) +		goto error_free_dma; + +	=
dev_info(&pdev->dev, "base:0x%p irq:%u\n", host->reg_base, host->irq); +	pl=
atform_set_drvdata(pdev, mmc);
>>>=20
>>> This should be before the registration. Otherwise, you're racy.
>>=20
>> Nope, we only need this to get the data on sunxi_mmc_remove, everywhere =
else the data is found through the mmc-host struct.
>=20
> Still, if anyone makes a following patch using the platform_device for so=
me reason, we will have a race condition, without any way to notice it.
>=20
> Plus, you're doing all the other bits of initialization of your structure=
s much earlier, why not be consistent and having all of them at the same pl=
ace?

Most platform drivers I've worked on do platform_set_drvdata as late as pos=
sible,
so that the drvdata does not get set and never cleared in error paths.

This is just following that pattern.

Regards,

Hans
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlMEoDYACgkQF3VEtJrzE/uAggCdGpdcz1Nli6JREPcUcGww7wXk
r4QAoIZfwy2e5GkHjQvrdpz0aT62x9/W
=3Dy0wO
-----END PGP SIGNATURE-----

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/groups/opt_out.
