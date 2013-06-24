From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v12 00/11] DMA Engine support for AM33XX
Date: Mon, 24 Jun 2013 17:09:41 +0530
Message-ID: <51C82FFD.1070100@ti.com>
References: <1371762407-24544-1-git-send-email-joelagnel@ti.com>
 <20130624101903.GV5523@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130624101903.GV5523@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, Sourav Poddar <sourav.poddar@ti.com>
Cc: Joel A Fernandes <joelagnel@ti.com>, Linux DaVinci Kernel List <davinci-linux-open-source@linux.davincidsp.com>, Russell King <linux@arm.linux.org.uk>, Benoit Cousson <b-cousson@ti.com>, Arnd Bergmann <arnd@arndb.de>, Jason Kridner <jkridner@beagleboard.org>, Vinod Koul <vinod.koul@intel.com>, Devicetree Discuss <devicetree-discuss@lists.ozlabs.org>, Linux Documentation List <linux-doc@vger.kernel.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Koen Kooi <koen@beagleboard.org>, Rob Herring <rob.herring@calxeda.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Mark Brown <broonie@kernel.org>, Rob Landley <rob@landley.net>, Linux SPI Devel List <spi-devel-general@lists.sourceforge.net>, Andrew Morton <akpm@linux-foundation.org>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@>
List-Id: linux-mmc@vger.kernel.org

Sourav,

On 6/24/2013 3:49 PM, Tony Lindgren wrote:
> Hi,
> 
> For merging this series, I suggest the following sets:
> 
> * Joel A Fernandes <joelagnel@ti.com> [130620 14:13]:

>>   spi: omap2-mcspi: add generic DMA request support to the DT binding
>>   spi: omap2-mcspi: convert to dma_request_slave_channel_compat()
> 
> 
> The spi changes should get merged via the driver list.

Can you please send just the DT binding patch above to Mark's correct
address with the relevant lists copied.

Thanks,
Sekhar
