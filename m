From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v4 0/6] mmc: rtsx: add support for sdio card
Date: Fri, 19 Dec 2014 11:36:46 +0100
Message-ID: <CAPDyKFoGQBgpkYS1AatTSM9y3iaOOCtCGRgw2MOeQEWb_Ca-tw@mail.gmail.com>
References: <cover.1417758564.git.micky_ching@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <cover.1417758564.git.micky_ching@realsil.com.cn>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: micky <micky_ching@realsil.com.cn>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Chris Ball <chris@printf.net>, Wei WANG <wei_wang@realsil.com.cn>, Roger <rogerable@realtek.com>, "driverdev-devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, Lee Jones <lee.jones@linaro.org>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: linux-mmc@vger.kernel.org

On 5 December 2014 at 06:54,  <micky_ching@realsil.com.cn> wrote:
> From: Micky Ching <micky_ching@realsil.com.cn>
>
> v4:
>   split patch in more detailed patches. no code changes diff v3.
>
> v3:
>   rtsx_pci_sdmmc.c:
>     - dump_reg_range
>       - remove unused pointer check
>       - fix start index
> v2:
>   rtsx_pci.h:
>     - remove unused rtsx_pci_write_le32
>     - add SD_CMD_START
>   rtsx_pci_sdmmc.c:
>     - dump_reg_range
>       - alloc data on stack
>     - remove forward declaration
>     - use SD_CMD_START replace magic number 0x40
>     - move initialize assignment to error handling
>
> This patch is used to change transfer mode for sdio card support
> by SD interface.
>
>
>
> Micky Ching (6):
>   mfd: rtsx: add func to split u32 into register
>   mmc: rtsx: add dump_reg_range to simplify dump register
>   mmc: rtsx: init cookie at probe/card_event
>   mmc: rtsx: add helper function to simplify code
>   mmc: rtsx: add support for sdio card
>   mmc: rtsx: swap function position to avoid pre declaration
>
>  drivers/mmc/host/rtsx_pci_sdmmc.c | 522 +++++++++++++++++++++-----------------
>  include/linux/mfd/rtsx_pci.h      |   9 +
>  2 files changed, 296 insertions(+), 235 deletions(-)
>
> --
> 1.9.1
>

Thanks! Queued for 3.20.

Kind regards
Uffe
