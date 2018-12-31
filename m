From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH 0/3] ARM: dts: meson: fix SD card cd-gpio (pre v4.21-rc)
Date: Mon, 31 Dec 2018 12:03:05 +0100
Message-ID: <CAFBinCBG-==df7swBsWvg9banuxH5JFyHRAwv2poZUMa3h3MVw@mail.gmail.com>
References: <20181229125711.5205-1-martin.blumenstingl@googlemail.com>
 <CACRpkdZ4bex+wm4vGWhDLSAsXnaVeHWEp6Rf4g8NQZmXnFfneQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CACRpkdZ4bex+wm4vGWhDLSAsXnaVeHWEp6Rf4g8NQZmXnFfneQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linus.luessing@c0d3.blue, Bartosz Golaszewski <bgolaszewski@baylibre.com>, balbes-150@yandex.ru, Kevin Hilman <khilman@baylibre.com>, linux-mmc <linux-mmc@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>, "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

Hi Linus,

On Sun, Dec 30, 2018 at 8:57 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Sat, Dec 29, 2018 at 1:57 PM Martin Blumenstingl
> <martin.blumenstingl@googlemail.com> wrote:
>
> > However, while reviewing the .dts files for the 32-bit Amlogic Meson
> > boards I found that the cd-gpios are specified incorrectly in the .dts.
> > Documentation/devicetree/bindings/mmc/mmc.txt states: "[...] using the
> > "cd-inverted" property means, that the CD line is active high, i.e. it
> > is high, when a card is inserted".
> > This is not the case on all currently supported 32-bit Meson boards, so
> > this switches the cd-gpios
> > - from GPIO_ACTIVE_HIGH with the "cd-inverted" property being set
> > - to GPIO_ACTIVE_LOW with the "cd-inverted" property being absent
> >
> > This fix also works even if the following two commits are reverted:
> > - 89a5e15bcba87d ("gpio/mmc/of: Respect polarity in the device tree")
> > - 81c85ec15a1946 ("gpio: OF: Parse MMC-specific CD and WP properties")
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
thank you for reviewing my series!

> Thanks for looking into this, I think fixing the device trees is
> orthogonal to fixing the issue I created, let's fix both!
I fully agree. if I still have time I'll look into a patch for the MMC
core later today, otherwise I'll try to do it tomorrow


Regards
Martin
