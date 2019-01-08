From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH 1/3] ARM: dts: meson8b: odroidc1: mark the SD card
 detection GPIO active-low
Date: Tue, 8 Jan 2019 23:02:37 +0100
Message-ID: <CAFBinCCRTCV2TUhaDGtjQbXp2bSh4cnP6pW25B0JVpCK64qYVg@mail.gmail.com>
References: <20181229125711.5205-1-martin.blumenstingl@googlemail.com>
 <20181229125711.5205-2-martin.blumenstingl@googlemail.com>
 <CANAwSgQjoXqbV2hDs4W3kR=7ULK0gkR24V6SiEJw2+mYsaNcVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CANAwSgQjoXqbV2hDs4W3kR=7ULK0gkR24V6SiEJw2+mYsaNcVQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Anand Moon <linux.amoon@gmail.com>
Cc: =?UTF-8?Q?Linus_L=C3=BCssing?= <linus.luessing@c0d3.blue>, linux-gpio@vger.kernel.org, balbes-150@yandex.ru, Kevin Hilman <khilman@baylibre.com>, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org, bgolaszewski@baylibre.com, Guenter Roeck <linux@roeck-us.net>, linux-amlogic@lists.infradead.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

Hi Anand,

On Mon, Jan 7, 2019 at 9:51 AM Anand Moon <linux.amoon@gmail.com> wrote:
>
> Hi Martin,
>
> On Sat, 29 Dec 2018 at 18:28, Martin Blumenstingl
> <martin.blumenstingl@googlemail.com> wrote:
> >
> > After commit 89a5e15bcba87d ("gpio/mmc/of: Respect polarity in the device
> > tree") SD cards are not detected anymore.
> >
> > The CD GPIO is "active low" on Odroid-C1. The MMC dt-bindings specify:
> > "[...] using the "cd-inverted" property means, that the CD line is active
> > high, i.e. it is high, when a card is inserted".
> >
> > Fix the description of the SD card by marking it as GPIO_ACTIVE_LOW and
> > drop the "cd-inverted" property. This makes the definition consistent
> > with the existing dt-bindings and fixes the check whether an SD card is
> > inserted.
> >
> > Fixes: e03efbce6bebf5 ("ARM: dts: meson8b-odroidc1: add microSD support")
> > Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > ---
> >  arch/arm/boot/dts/meson8b-odroidc1.dts | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/meson8b-odroidc1.dts b/arch/arm/boot/dts/meson8b-odroidc1.dts
> > index 58669abda259..070d69889f3e 100644
> > --- a/arch/arm/boot/dts/meson8b-odroidc1.dts
> > +++ b/arch/arm/boot/dts/meson8b-odroidc1.dts
> > @@ -273,8 +273,7 @@
> >                 cap-sd-highspeed;
> >                 disable-wp;
> >
> > -               cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
> > -               cd-inverted;
> > +               cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
> >
> >                 vmmc-supply = <&tflash_vdd>;
> >                 vqmmc-supply = <&tf_io>;
> > --
> > 2.20.1
> >
>
> Please add my on my Odroid c1+
>
> Tested-by: Anand Moon <linux.amoon@gmail.com>
thank you for testing this!

> My Odroid C2 is also fails to bootup with out these changes.
> Can you send patch to fix them as well.
I sent a more generic patch (after a discussion with Linus) which will
fix all boards with the "cd-inverted" property even if we don't fix
the .dts files: [0]
(that doesn't mean that this patch is obsolete, but it means that we
restore compatibility with .dts which use the "cd-inverted" property)

it would be great if you could test that on your Odroid-C2 and give
your Tested-by on that as well!


Regards
Martin


[0] https://patchwork.kernel.org/patch/10745961/
