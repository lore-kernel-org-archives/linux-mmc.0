From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 11/36] ARM: s5pv210: split from plat-samsung
Date: Tue, 22 Oct 2019 18:20:41 +0200
Message-ID: <CAK8P3a1mvbss6Q-CQBYRAf7ozYgyOu3WFGkoaSaoJriUbuRACA@mail.gmail.com>
References: <20191010202802.1132272-1-arnd@arndb.de> <20191010203043.1241612-1-arnd@arndb.de>
 <20191010203043.1241612-11-arnd@arndb.de> <20191011055149.4dudr4tk2znpt65u@pengutronix.de>
 <CAK8P3a1st8gR7u+8-oyP6HrzZdmrzhq7PRonYuz0a5O8rfKaSA@mail.gmail.com> <20191022155307.izh4ryorm7thw7tq@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191022155307.izh4ryorm7thw7tq@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Sangbeom Kim <sbkim73@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" <linux-samsung-soc@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linus Walleij <linus.walleij@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Olof Johansson <olof@lixom.net>, Sascha Hauer <s.hauer@pengutronix.de>, =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On Tue, Oct 22, 2019 at 5:53 PM Uwe Kleine-König
<u.kleine-koenig@pengutronix.de> wrote:
> The background of my question was me wondering if builds
> for PLAT_S3C24XX=y (before your patch series) don't need plat-samsung.

What I found is that the DT-based platforms (exynos and s5p) need almost nothing
from plat-samsung, while the board files and the s3c24xx/s3c64xx power
management
needs almost all of it.

      Arnd
