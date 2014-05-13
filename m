From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCHv2] mmc: dw_mmc: change to use recommended reset procedure
Date: Tue, 13 May 2014 10:46:52 +0200
Message-ID: <4576681.G7gtKHPGQn@wuerfel>
References: <1399945121-7387-1-git-send-email-sonnyrao@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1399945121-7387-1-git-send-email-sonnyrao@chromium.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>, linux-samsung-soc@vger.kernel.org, grundler@chromium.org, t.figa@samsung.com, linux-mmc@vger.kernel.org, joshi@samsung.com, dianders@chromium.org, jh80.chung@samsung.com, tgih.jun@samsung.com, kgene.kim@samsung.com, cjb@laptop.org, Sonny Rao <sonnyrao@chromium.org>
List-Id: linux-mmc@vger.kernel.org

On Monday 12 May 2014 18:38:41 Sonny Rao wrote:
> +#ifndef CONFIG_MMC_DW_IDMAC
> +       if (host->use_dma)
> +               flags |= SDMMC_CTRL_DMA_RESET;
> +#endif

Can you change the above like this?

	if (IS_ENABLED(CONFIG_MMC_DW_IDMAC) && host->use_dma)
		flags |= SDMMC_CTRL_DMA_RESET;

That is generally considered the preferred style these days.

	Arnd
