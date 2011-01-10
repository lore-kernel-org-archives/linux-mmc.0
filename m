From: Pierre Tardy <tardyp@gmail.com>
Subject: Re: [PATCH 2/3] mmc: add MMC_QUIRK_BROKEN_CLK_GATING
Date: Mon, 10 Jan 2011 17:57:07 +0100
Message-ID: <AANLkTimSV07Kdk_xq3nhGa26-SF_u3gxCM+CUhmRJrib@mail.gmail.com>
References: <cover.1294588491.git.tardyp@gmail.com>
	<4663ceeebbd267abb11515570ac17702a6a482f4.1294588491.git.tardyp@gmail.com>
	<ADE0108D-6DF1-4230-B7FB-39D7AC7F63D1@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ADE0108D-6DF1-4230-B7FB-39D7AC7F63D1@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

>
>
> Since the code is not called that often could you change the above co=
de to:
>
>> =A0 =A0 =A0 if (mmc_card_sdio(card))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return !(card->quirks & MMC_QUIRK_BROKEN=
_CLK_GATING);
Well, The comment in the
> =A0 =A0 =A0 =A0return true;
>
> more obvious that quirk only applies to sdio.

Disagree.Actually, before this code, there is a pretty long comment,
that explain that this quirk only apply to sdio.

If we figure out later that some sdcard does not like clock gating
either, we could add this quirk to those bad sdcard as well.

Here is the whole resulting function. I think this is clear enough:

static bool mmc_host_may_gate_card(struct mmc_card *card)
{

        /* If there is no card we may gate it */
        if (!card)
               return true;
        /*
        * Don't gate SDIO cards! These need to be clocked at all times
        * since they may be independent systems generating interrupts
        * and other events. The clock requests counter from the core wi=
ll
        * go down to zero since the core does not need it, but we will =
not
        * gate the clock, because there is somebody out there that may =
still
        * be using it.
        */
        return !(card->quirks & MMC_QUIRK_BROKEN_CLK_GATING);


}
Pierre
