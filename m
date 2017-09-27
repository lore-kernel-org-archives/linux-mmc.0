From: Rob Herring <robh@kernel.org>
Subject: Re: [RFC v2 1/2] dt-bindings: mmc: Document the Amlogic Meson8 and
 Meson8b SDIO bindings
Date: Wed, 27 Sep 2017 14:37:16 -0500
Message-ID: <20170927193716.bxqihkm7f3omrnd6@rob-hp-laptop>
References: <20170924190528.21841-1-martin.blumenstingl@googlemail.com>
 <20170924190528.21841-2-martin.blumenstingl@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36224 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751813AbdI0ThS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Sep 2017 15:37:18 -0400
Content-Disposition: inline
In-Reply-To: <20170924190528.21841-2-martin.blumenstingl@googlemail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: ulf.hansson@linaro.org, mark.rutland@arm.com, carlo@caione.org, khilman@baylibre.com, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, Carlo Caione <carlo@endlessm.com>

On Sun, Sep 24, 2017 at 09:05:27PM +0200, Martin Blumenstingl wrote:
> From: Carlo Caione <carlo@endlessm.com>
> 
> This documents the devicetree bindings for the SDIO/MMC host found in
> Amlogic Meson8 and Meson8b SoCs. It supports the SD specification v2.0
> and the eMMC specification v4.41.
> It has an internal "mux" which allows connecting up to three MMC devices
> to it. The maximum supported bus-width is 4-bits.
> 
> Amlogic's GPL kernel sources call it "SDIO" to differentiate it from the
> other MMC controller in (at least the Meson8 and Meson8b) the SoCs (they
> call the other one "SDHC", which supports a bus-width of up to 8-bits).
> 
> Signed-off-by: Carlo Caione <carlo@endlessm.com>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  .../bindings/mmc/amlogic,meson-mx-sdio.txt         | 52 ++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdio.txt

Acked-by: Rob Herring <robh@kernel.org>

