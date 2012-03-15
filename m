From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 5/5] MMC: mmci: Add required documentation for Device
 Tree bindings
Date: Thu, 15 Mar 2012 17:35:08 +0000
Message-ID: <20120315173508.GE15988@n2100.arm.linux.org.uk>
References: <1331734803-17954-1-git-send-email-lee.jones@linaro.org>
 <1331734803-17954-6-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1331734803-17954-6-git-send-email-lee.jones@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lee Jones <lee.jones@linaro.org>
Cc: niklas.hernaeus@linaro.org, cjb@laptop.org, linux-mmc@vger.kernel.org, arnd@arndb.de, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Wed, Mar 14, 2012 at 02:20:03PM +0000, Lee Jones wrote:
> +ux500 variant specific properties:
> +- gpio-en                : contains the level-shifter enable gpio
> +- gpio-vsel              : contains the level-shifter voltage select gpio
> +- tx_dst_dev_type        : contains the tx destination device (DMA) 
> +- rx_src_dev_type        : contains the rx source device (DMA)

So what about the DMA support being proposed elsewhere?

This sounds like we're inventing one DMA solution for one bit of the tree
and another DMA solution for another bit.  This is madness.

Note that ARM boards like Versatile also have DMA support, even though
most of those platforms are diabolically crippled to the point of it being
useless.  I believe it works on a few select boards...
