From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH 0/3] ARM: dts: meson: fix SD card cd-gpio (pre v4.21-rc)
Date: Sat, 29 Dec 2018 15:29:20 +0100
Message-ID: <CAFBinCCpsy40NuB124TqDUWy9zogeMrLsCGCanbbvpfd-yVDdQ@mail.gmail.com>
References: <20181229125711.5205-1-martin.blumenstingl@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181229125711.5205-1-martin.blumenstingl@googlemail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-amlogic@lists.infradead.org, khilman@baylibre.com, linus.walleij@linaro.org
Cc: linus.luessing@c0d3.blue, bgolaszewski@baylibre.com, balbes-150@yandex.ru, linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux@roeck-us.net
List-Id: linux-mmc@vger.kernel.org

On Sat, Dec 29, 2018 at 1:57 PM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Today I noticed that my Odroid-C1 doesn't see it's SD card anymore.
> My board is not the only one, Odroid-C1 on KernelCI suffers from the
> same problem:
> v4.20-6428-g00c569b567c7 still sees the SD card (mmc0): [0]
> v4.20-8955-g903b77c63167 doesn't see the SD card (mmc0) anymore: [1]
>
> My Endless Mini (EC-100) is also affected by this issue.
>
> a git bisect run points to this commit:
> 89a5e15bcba87df5120d4656e0ff33d4f7cd6152 ("gpio/mmc/of: Respect polarity
> in the device tree")
>
> and indeed, reverting it makes my Odroid-C1 and EC-100 see the SD card
> again.
I started a separate discussion for that topic on the linux-mmc and
linux-gpio mailing list for this topic: [0]

comments regarding this series are still welcome!


Regards
Martin


[0] https://marc.info/?l=linux-mmc&m=154609359306732&w=3
