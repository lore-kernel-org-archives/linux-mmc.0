From: Remi Pommarel <repk@triplefau.lt>
Subject: Re: [PATCH] mmc: meson-gx: Free irq in release() callback
Date: Thu, 10 Jan 2019 23:52:00 +0100
Message-ID: <20190110225200.GC982@voidbox.localdomain>
References: <20190110184908.27413-1-repk@triplefau.lt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190110184908.27413-1-repk@triplefau.lt>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: Elie Roudninski <xademax@gmail.com>, linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Thu, Jan 10, 2019 at 07:49:08PM +0100, Remi Pommarel wrote:
> Because the irq was requested through device managed resources API
> (devm_request_threaded_irq()) it was freed after meson_mmc_remove()
> completion, thus after mmc_free_host() has reclaimed meson_host memory.
> As this irq is IRQF_SHARED, while using CONFIG_DEBUG_SHIRQ, its handler
> get called by free_irq(). So meson_mmc_irq() was called after the
> meson_host memory reclamation and was using invalid memory.
> 
> We ended up with the following scenario:
> device_release_driver()
> 	meson_mmc_remove()
> 		mmc_free_host() /* Freeing host memory */
> 	...
> 	devres_release_all()
> 		devm_irq_release()
> 			__free_irq()
> 				meson_mmc_irq() /* Uses freed memory */
> 
> To avoid this, the irq is released in meson_mmc_remove() before
> mmc_free_host() gets called.
> 

Oups, I missed the fact that the same can happen if probe() callback
fails after allocating the irq.

I will send a V2 for that.

-- 
Remi
