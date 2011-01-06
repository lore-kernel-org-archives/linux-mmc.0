From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 4/4] mmc: add MMC_QUIRK_NONSTD_FUNC_IF
Date: Fri, 7 Jan 2011 01:16:21 +0200
Message-ID: <AANLkTimSEAnQkH9m7DsCM7kOGS8Ffbhx7B9h-GRCS_d2@mail.gmail.com>
References: <1294175416-12358-1-git-send-email-ohad@wizery.com>
 <1294175416-12358-4-git-send-email-ohad@wizery.com> <AANLkTimg7DU=1bYv-k2-WwiSurHmsrjN_+zb_=irZv9n@mail.gmail.com>
 <AANLkTi=HyXUAMALQD4MMZrw=Por8bTkJ6HxSC10UrDt4@mail.gmail.com>
 <AANLkTikwaSmwy2b6if-=BhU9c5Ea_9xyOdKDC0VhpBox@mail.gmail.com>
 <AANLkTik8FNxAhGz8Dzj=h4S1hyDGUYw4HSAhzwHWfWpG@mail.gmail.com>
 <AANLkTinrz+qonuPSo-HOJ2zmjwmyn0YJkMTg+MwKXN2s@mail.gmail.com>
 <AANLkTik7yr6bXcGpNt09zoXU_P03RE=vo2HepDa2fhuW@mail.gmail.com> <AANLkTinmhoY+TqmF_scKnzG-Kjjof=YDf2kzfJfr1gjy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f194.google.com ([209.85.214.194]:34488 "EHLO
	mail-iw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752500Ab1AFXQm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 6 Jan 2011 18:16:42 -0500
Received: by iwb12 with SMTP id 12so153270iwb.1
        for <linux-mmc@vger.kernel.org>; Thu, 06 Jan 2011 15:16:41 -0800 (PST)
In-Reply-To: <AANLkTinmhoY+TqmF_scKnzG-Kjjof=YDf2kzfJfr1gjy@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Pierre Tardy <tardyp@gmail.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, "DE CESCO, Jonathan" <jonathanc@ti.com>

Hi Pierre,

On Wed, Jan 5, 2011 at 2:28 PM, Pierre Tardy <tardyp@gmail.com> wrote:
> Well... TI is selling quirky hw, would make sense that you handle thi=
s. :-)

Heh I'd happily take over - just say the word :)

> Subject: [PATCH] mmc: add per device quirk placeholder
>
> Some cards have quirks valid for every platforms
> using current platform quirk hooks leads to a lot
> of code and debug duplication.
>
> So we inspire a bit from what exists in PCI subsystem
> and do out own per vendorid/deviceid quirk
> We still drop the complexity of the pci quirk system
> (with special section tables, and so on)
> That can be added later if needed.

I like the idea. It would allow us to handle card quirks without
involving board code (and obviously we can't rely on drivers for that
because that may be too late).

> +struct mmc_fixup {
> + =A0 =A0 =A0 u16 vendor, device; =A0 =A0 /* You can use SDIO_ANY_ID =
here of course */
> + =A0 =A0 =A0 void (*hook)(struct mmc_card *card);

Do we really need to hook up code with quirky cards ? why not just
directly indicate the exact MMC_QUIRK_* instead (just like USB is
doing) ? that may simplify the whole thing.

So instead of the ->hook() function pointer, we can just put a uint
quirks member,

> +};
> +
> +static const struct mmc_fixup mmc_fixup_methods[] =3D {
> + =A0 =A0 =A0 { 0 }

=46ill it up here,

> +};
> +
> +void mmc_fixup_device(struct mmc_card *card)
> +{
> + =A0 =A0 =A0 const struct mmc_fixup *f;
> +
> + =A0 =A0 =A0 for (f =3D mmc_fixup_methods; f->hook; f++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((f->vendor =3D=3D card->cis.vendor =
|| f->vendor =3D=3D (u16) SDIO_ANY_ID) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (f->device =3D=3D card->cis.dev=
ice || f->device =3D=3D (u16) SDIO_ANY_ID)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&card->dev, "ca=
lling %pF\n", f->hook);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 f->hook(card);

And then here instead of calling a dedicated ->hook() function, we can
just do something like this:

card->quirks |=3D f->quirks;

This way we don't need to add a function for every quirky card.

And if we will happen to need it in the future we can always bring it
back in, but right now we really only need to specify the relevant
QUIRK(s).

Thanks,
Ohad.
