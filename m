From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 0/3] Add modules for realtek USB card reader
Date: Fri, 7 Feb 2014 14:33:37 -0800
Message-ID: <20140207223337.GA21142@kroah.com>
References: <1391697307-23457-1-git-send-email-rogerable@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <1391697307-23457-1-git-send-email-rogerable@realtek.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: rogerable@realtek.com
Cc: Samuel Ortiz <sameo@linux.intel.com>, Alex Dubov <oakad@yahoo.com>, driverdev-devel@linuxdriverproject.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, wei_wang@realsil.com.cn, Chris Ball <cjb@laptop.org>, Lee Jones <lee.jones@linaro.org>, Dan Carpenter <dan.carpenter@oracle.com>, Maxim Levitsky <maximlevitsky@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On Thu, Feb 06, 2014 at 10:35:04PM +0800, rogerable@realtek.com wrote:
> From: Roger Tseng <rogerable@realtek.com>
> 
> This patchset adds modules to support Realtek USB vendor specific class flash
> card reader: one base module in MFD subsystem and two host modules in both mmc
> and memstick subsystems. The architecture is similar to rtsx_pci.
> 
> This work is done primarily to replace the staging driver: staging/rts5139,
> which doesn't utilize mmc nor memstick subsystems. Once the patchset or its
> revision is applied, we may need Greg's help to remove the staging one.
> 
> v2:
> 1. Fix potential buffer overflow in rtsx_usb_seq_write_register()
> 2. Remove unnecessary casting and messages
> 3. Revise coding style and white spaces
> 
> v3:
> 1. Fix MMC detection fail when under xhci
> 2. Minor change of pm_runtime behavior in rtsx_usb_ms to prevent some rare
>    freeze due to erroneous Memstick card(not MS-Pro)
> 3. Further revise coding style as suggested in the thread of v2
> 4. Using managed resources: devm_*
> 5. Change license from "GPL v2 and later" to "GPL v2"
> 
> Roger Tseng (3):
>   mfd: Add realtek USB card reader driver
>   mmc: Add realtek USB sdmmc host driver
>   memstick: Add realtek USB memstick host driver

Looks good to me, thanks for doing this work:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
