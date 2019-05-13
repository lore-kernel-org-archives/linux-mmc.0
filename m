From: Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH 0/3] mmc: meson-gx: add ddr-access-quirk support
Date: Mon, 13 May 2019 13:28:43 +0200
Message-ID: <10e588ae1e259c2c2bc9cfd0e788aa41735f0f66.camel@baylibre.com>
References: <20190513091548.16674-1-narmstrong@baylibre.com>
         <24b8cd2eb2879378ca0cac6ddfd9c5cae68699bc.camel@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <24b8cd2eb2879378ca0cac6ddfd9c5cae68699bc.camel@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Neil Armstrong <narmstrong@baylibre.com>, ulf.hansson@linaro.org, khilman@baylibre.com
Cc: baylibre-upstreaming@groups.io, linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Mon, 2019-05-13 at 11:58 +0200, Jerome Brunet wrote:
> > The performance hit hasn't been evaluated, but the fix has been tested
> > using a WiFi AP6398S SDIO module, and the iperf3 Bandwidth measurement gave
> > 55.2 Mbits/sec over a 63 Hours long test, with the SDIO ios set as High-Speed
> > at 50MHz clock. It gave around 170 Mbits/sec as SDR104 and 200MHz clock.
> 
> These numbers looks to be limited by the MMC bandwidth of the related modes.
> So, if the SRAM quirk introduce a penalty for the controller, it does not appear
> to be a limiting factor, AFAICT.

Got confused. This comment is completely wrong, please ignore
