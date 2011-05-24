From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH V2] mmc: eMMC bus width may not work on all platforms
Date: Tue, 24 May 2011 00:42:52 -0400
Message-ID: <m3wrhgaeur.fsf@pullcord.laptop.org>
References: <2FBABAF6-BFF6-46C9-BE6C-D4CA1EE9BD03@marvell.com>
	<1482D9D127C1754E8684047CF53F7660622B177DBE@pgsmsx505.gar.corp.intel.com>
	<m3fwo7r0nc.fsf@pullcord.laptop.org>
	<15864FE4-25CB-46BC-ACC2-FC24C2E6E241@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:60873 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751127Ab1EXElr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 24 May 2011 00:41:47 -0400
In-Reply-To: <15864FE4-25CB-46BC-ACC2-FC24C2E6E241@marvell.com> (Philip
	Rakity's message of "Sun, 22 May 2011 10:30:44 -0700")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "Mok, Tze Siong" <tze.siong.mok@intel.com>, Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>, Takashi Iwai <tiwai@suse.de>, Mark Brown <mark.brown314@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi Philip,

On Sun, May 22 2011, Philip Rakity wrote:
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index baab027..6db91d6 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -174,14 +174,17 @@ static int mmc_decode_csd(struct mmc_card *card=
)
>  }
> =20
>  /*
> - * Read and decode extended CSD.
> + * Read extended CSD.
>   */
> -static int mmc_read_ext_csd(struct mmc_card *card)
> +static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)

This one doesn't work -- you're missing the half of the patch that hook=
s
up the rest of mmc.c to the new code, which was in v1.  As-is, we get:

drivers/mmc/core/mmc.c: In function =E2=80=98mmc_init_card=E2=80=99:
drivers/mmc/core/mmc.c:621:3: error: too few arguments to function =E2=80=
=98mmc_read_ext_csd=E2=80=99
drivers/mmc/core/mmc.c:240:12: note: declared here
drivers/mmc/core/mmc.c: At top level:
drivers/mmc/core/mmc.c:404:12: warning: =E2=80=98mmc_compare_ext_csds=E2=
=80=99 defined but not used [-Wunused-function]

- Chris.
--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
