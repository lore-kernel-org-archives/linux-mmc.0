From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/3] ARM: dts: meson8b: ec100: mark the SD card detection
 GPIO active-low
Date: Sun, 30 Dec 2018 20:54:31 +0100
Message-ID: <CACRpkdYQLvCEvNaA_O2SP4VXh7Lp7sD31wOBD9ZDoZwx3c+ZuQ@mail.gmail.com>
References: <20181229125711.5205-1-martin.blumenstingl@googlemail.com>
 <20181229125711.5205-3-martin.blumenstingl@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181229125711.5205-3-martin.blumenstingl@googlemail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linus.luessing@c0d3.blue, Bartosz Golaszewski <bgolaszewski@baylibre.com>, balbes-150@yandex.ru, Kevin Hilman <khilman@baylibre.com>, linux-mmc <linux-mmc@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>, "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On Sat, Dec 29, 2018 at 1:57 PM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:

> After commit 89a5e15bcba87d ("gpio/mmc/of: Respect polarity in the device
> tree") SD cards are not detected anymore.
>
> The CD GPIO is "active low" on the EC-100. The MMC dt-bindings specify:
> "[...] using the "cd-inverted" property means, that the CD line is active
> high, i.e. it is high, when a card is inserted".
>
> Fix the description of the SD card by marking it as GPIO_ACTIVE_LOW and
> drop the "cd-inverted" property. This makes the definition consistent
> with the existing dt-bindings and fixes the check whether an SD card is
> inserted.
>
> Fixes: bbedc1f1d90e33 ("ARM: dts: meson8b: Add support for the Endless Mini (EC-100)")
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
