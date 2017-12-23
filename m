From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v3 00/27] kill devm_ioremap_nocache
Date: Sat, 23 Dec 2017 07:57:40 -0800
Message-ID: <f7632cf5-2bcc-4d74-b912-3999937a1269@roeck-us.net>
References: <1514026525-32538-1-git-send-email-xieyisheng1@huawei.com>
 <20171223134831.GB10103@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20171223134831.GB10103@kroah.com>
Content-Language: en-US
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Greg KH <gregkh@linuxfoundation.org>, Yisheng Xie <xieyisheng1@huawei.com>
Cc: linux-mips@linux-mips.org, ulf.hansson@linaro.org, jakub.kicinski@netronome.com, platform-driver-x86@vger.kernel.org, airlied@linux.ie, linux-wireless@vger.kernel.org, linus.walleij@linaro.org, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-mtd@lists.infradead.org, daniel.vetter@intel.com, dan.j.williams@intel.com, jason@lakedaemon.net, linux-rtc@vger.kernel.org, boris.brezillon@free-electrons.com, mchehab@kernel.org, dmaengine@vger.kernel.org, vinod.koul@intel.com, richard@nod.at, marek.vasut@gmail.com, industrypack-devel@lists.sourceforge.net, linux-pci@vger.kernel.org, dvhart@infradead.org, wg@grandegger.com, linux-media@vger.kernel.org, seanpaul@chromium.org, devel@driverdev.osuosl.org, linux-watchdog@vger.kernel.org, arnd@arndb.de, b.zolnierkie@samsung.com, marc.zyngier@arm.com, jslaby@sus
List-Id: linux-mmc@vger.kernel.org

On 12/23/2017 05:48 AM, Greg KH wrote:
> On Sat, Dec 23, 2017 at 06:55:25PM +0800, Yisheng Xie wrote:
>> Hi all,
>>
>> When I tried to use devm_ioremap function and review related code, I found
>> devm_ioremap and devm_ioremap_nocache is almost the same with each other,
>> except one use ioremap while the other use ioremap_nocache.
> 
> For all arches?  Really?  Look at MIPS, and x86, they have different
> functions.
> 

Both mips and x86 end up mapping the same function, but other arches don't.
mn10300 is one where ioremap and ioremap_nocache are definitely different.

Guenter

>> While ioremap's
>> default function is ioremap_nocache, so devm_ioremap_nocache also have the
>> same function with devm_ioremap, which can just be killed to reduce the size
>> of devres.o(from 20304 bytes to 18992 bytes in my compile environment).
>>
>> I have posted two versions, which use macro instead of function for
>> devm_ioremap_nocache[1] or devm_ioremap[2]. And Greg suggest me to kill
>> devm_ioremap_nocache for no need to keep a macro around for the duplicate
>> thing. So here comes v3 and please help to review.
> 
> I don't think this can be done, what am I missing?  These functions are
> not identical, sorry for missing that before.
> 
> thanks,
> 
> greg k-h
> 
