From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH] amba: Ensure drvdata is NULL
Date: Thu, 3 Oct 2013 11:13:05 +0200
Message-ID: <d5a0aab9-f023-4464-b4a1-f7055e6c82d5@CO9EHSMHS010.ehs.local>
References: <1b2479137287fa8dfda3089ca0cb9fba8c4b1f1d.1380524337.git.michal.simek@xilinx.com>
 <20131002202521.GU12758@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20131002202521.GU12758@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-fbdev@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Wim Van Sebroeck <wim@iguana.be>, Jiri Slaby <jslaby@suse.cz>, "zhangwei(Jovi)" <jovi.zhangwei@huawei.com>, Vinod Koul <vinod.koul@intel.com>, Michal Simek <michal.simek@xilinx.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-serial@vger.kernel.org, linux-input@vger.kernel.org, Chris Ball <cjb@laptop.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-watchdog@vger.kernel.org, rtc-linux@googlegroups.com, Mark Brown <broonie@kernel.org>, Dan Williams <dan.j.williams@intel.com>, linux-arm-kernel@lists.infradead.org, Alessandro Zummo <a.zummo@towertech.it>, monstr@monstr.eu, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-spi@vger.kernel.
List-Id: linux-mmc@vger.kernel.org

On 10/02/2013 10:25 PM, Russell King - ARM Linux wrote:
> On Mon, Sep 30, 2013 at 08:59:06AM +0200, Michal Simek wrote:
>> This patch is inpired by the patch for drvdata
>> "device-core: Ensure drvdata = NULL when no driver is bound"
>> (sha1: 0998d0631001288a5974afc0b2a5f568bcdecb4d)
>>
>> Also it fixes all occurences in drivers.
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> ---
>> This patch has been sent as RFC in this thread.
>> http://lkml.org/lkml/2013/9/4/393
> 
> Why not have the driver core do this?  Then it gets applied to all bus
> types uniformly.

ok - I have checked that path and it should be already done
in really_probe function which calls amba_probe() and then driver probe function.

It means that the patch should contain just "amba_set_drvdata(dev, NULL);"
removal and not touching bus.c file.

Thanks,
Michal
