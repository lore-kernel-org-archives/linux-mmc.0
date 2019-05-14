From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH 3/3] arm64: dts: meson-g12a: add ddr-access-quirk property
 to SDIO controller
Date: Tue, 14 May 2019 19:51:10 +0200
Message-ID: <CAFBinCC5NADRuZkBiD8Zs9efNKp2fhZVqQ8aRnQ1gs+GbQCKdg@mail.gmail.com>
References: <20190513091548.16674-1-narmstrong@baylibre.com> <20190513091548.16674-4-narmstrong@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190513091548.16674-4-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: ulf.hansson@linaro.org, khilman@baylibre.com, baylibre-upstreaming@groups.io, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Mon, May 13, 2019 at 11:17 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> The Amlogic G12A SDIO Controller has a bug preventing direct DDR access,
> mark this specific controller with the amlogic,ddr-access-quirk property.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
