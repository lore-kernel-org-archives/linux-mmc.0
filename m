From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH/RFC v3 1/6] mmc: sh_mobile_sdhi, tmio: make dma more modular
Date: Wed, 06 Jul 2016 22:43:26 +0200
Message-ID: <3888420.7E5mgG7hxa@wuerfel>
References: <1467836610-18539-1-git-send-email-horms+renesas@verge.net.au> <1467836610-18539-2-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1467836610-18539-2-git-send-email-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Wednesday, July 6, 2016 10:23:25 PM CEST Simon Horman wrote:
> 
> +static struct tmio_mmc_dma_ops tmio_dma_ops;
> +
> +void tmio_set_dma_ops(const struct tmio_mmc_dma_ops *ops)
> +{
> +       tmio_dma_ops = *ops;
> +}
> +EXPORT_SYMBOL(tmio_set_dma_ops);
> +
> 

Having a global instance of this pointer seems wrong, why not
store the pointer per device in struct tmio_mmc_host?

It's unlikely to ever clash between two devices in the same system,
but we generally try not to rely on that.

	Arnd
