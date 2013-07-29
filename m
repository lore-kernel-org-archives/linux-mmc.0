From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v2] ARM: EDMA: Fix clearing of unused list for DT DMA
 resources
Date: Mon, 29 Jul 2013 12:34:43 +0530
Message-ID: <51F6140B.3070600@ti.com>
References: <1374515989-7391-1-git-send-email-joelf@ti.com>
 <51F4589E.5070108@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <51F4589E.5070108@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: joelf@ti.com
Cc: Balaji TK <balajitk@ti.com>, Arnd Bergmann <arnd@arndb.de>, Mark Jackson <mpfj-list@newflow.co.uk>, Tony Lindgren <tony@atomide.com>, Pantel Antoniou <panto@antoniou-consulting.com>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vinod Koul <vinod.koul@intel.com>, Jason Kridner <jkridner@beagleboard.org>, Benoit Cousson <benoit.cousson@linaro.org>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On Sunday 28 July 2013 05:02 AM, Joel Fernandes wrote:
> Hi Tony or Sekhar,
> 
> If this patch looks ok, could you pick it up for -rc cycle?
> 
> It fixes DMA breakages after the merge window for devices for which DMA
> resources are being populated in device tree instead pdev.

But which DT-enabled platform in kernel is using EDMA? A grep for edma
over arch/arm/boot/dts/* brings up nothing.

Does this really have to go into the -rc cycle or can it wait till v3.12?

Thanks,
Sekhar
