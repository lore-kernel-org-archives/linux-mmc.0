From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH RFC 1/3] mmc: sdhci: add support for using external DMA devices
Date: Tue, 6 Nov 2018 12:16:00 +0100
Message-ID: <CAK8P3a2aUjLsP70zSjkavR4-mkV9iEVCw96Vces4N15Dno8SHw@mail.gmail.com>
References: <1541387810-24867-1-git-send-email-zhang.chunyan@linaro.org> <1541387810-24867-2-git-send-email-zhang.chunyan@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1541387810-24867-2-git-send-email-zhang.chunyan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chunyan Zhang <zhang.chunyan@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sekhar Nori <nsekhar@ti.com>, Chunyan Zhang <zhang.lyra@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On 11/5/18, Chunyan Zhang <zhang.chunyan@linaro.org> wrote:
> Some standard SD host controller can support both external dma
> controllers as well as ADMA in which the controller acts as
> DMA master.
>
> Currently the generic SDHCI code supports ADMA/SDMA integrated into
> the host controller but does not have any support for external DMA
> controllers implemented using dmaengine meaning that custom code is
> needed for any systems that use a generic DMA controller with SDHCI.
>
> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>

Looks good to me overall, but I think I found one small bug:


> +	dma->rx_chan = dma_request_chan(mmc->parent, "rx");
> +	if (IS_ERR(dma->rx_chan)) {
> +		ret = PTR_ERR(dma->rx_chan);
> +		if (ret == -EPROBE_DEFER && dma->tx_chan)
> +			dma_release_channel(dma->tx_chan);
> +
> +		dma->rx_chan = NULL;
> +		pr_warn("Failed to request RX DMA channel.\n");
> +	}

The error handling looks wrong here: if you get EPROBE_DEFER,
you want to skip the warning message. If you get any other error code,
you want the warning message and also the dma_release_channel()
which should be unconditional here.

        Arnd
