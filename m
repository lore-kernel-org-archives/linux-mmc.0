From: Vitaly Wool <vitalywool@gmail.com>
Subject: Re: [PATCH v4 3/8] wireless: wl1271: add platform driver to get board
	data
Date: Wed, 11 Aug 2010 23:34:49 +0200
Message-ID: <AANLkTinu8vvPRf=78n2LaX4KQMS9tQRCbg7UUHG1ZO5W@mail.gmail.com>
References: <1281550913-17633-1-git-send-email-ohad@wizery.com>
	<1281550913-17633-4-git-send-email-ohad@wizery.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB0324110ABD@dbde02.ent.ti.com>
	<20100811184742.GA21778@nokia.com>
	<AANLkTikLbiJ8PsUbSnmYrfY6oNW4okejf-UdyQyfYbUz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <AANLkTikLbiJ8PsUbSnmYrfY6oNW4okejf-UdyQyfYbUz@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Kalle Valo <kalle.valo@iki.fi>, "Pandita, Vikram" <vikram.pandita@ti.com>, "Coelho Luciano (Nokia-MS/Helsinki)" <Luciano.Coelho@nokia.com>, Nicolas Pitre <nico@fluxnic.net>, Tony Lindgren <tony@atomide.com>, "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "Quadros Roger (Nokia-MS/Helsinki)" <roger.quadros@nokia.com>, "ext DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, Ido Yariv <ido@wizery.com>, San Mehat <san@google.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, felipe.balbi@nokia.com, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

Hi Ohad,

On Wed, Aug 11, 2010 at 10:10 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> Think of several wl1271 devices, each of which is represented by two
> devices; an SDIO function, and a platform device. The SDIO function
> stands for a specific MMC controller the device is hardwired to, and
> the platform device stands for the external irq line that the device
> is hardwired to.

my view on this is that you're hunting the false problem here. I
wonder how likely it is that two hardwired WL12xx chips are there on
the same board.

It's theoretically possible that there's one hardwired device and one
hot-pluggable one but the latter one can't have platform_data anyway.

So in my opinion, we either should keep things simple and consider 2
hardwired WL12XX's to be a very very unlikely case, or we'll end up
discussing board_info once again.

Thanks,
   Vitaly
