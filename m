From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 0/2] mmc: rtsx: add new cmd type handle and modify
 error handle
Date: Thu, 27 Mar 2014 09:11:07 +0100
Message-ID: <CAPDyKFrdddMjtGKutx1=Czbf6GyVu+TA9cBVT6zYE=HnA3abCg@mail.gmail.com>
References: <cover.1395824147.git.micky_ching@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <cover.1395824147.git.micky_ching@realsil.com.cn>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: micky <micky_ching@realsil.com.cn>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Chris Ball <chris@printf.net>, Wei WANG <wei_wang@realsil.com.cn>, Roger <rogerable@realtek.com>, devel@linuxdriverproject.org, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: linux-mmc@vger.kernel.org

On 27 March 2014 06:35,  <micky_ching@realsil.com.cn> wrote:
> From: Micky Ching <micky_ching@realsil.com.cn>
>
> v2:
> fix checkpatch warning.
> WARNING: Missing a blank line after declarations
>
> v1:
> Add new command type(R1 without CRC) handle, without this
> patch mmc card initialize will be failed.
>
> Using a more careful handle in request timeout, this would
> improve error recover capability. Debug info is printed
> using non DMA mode, this would help print more accurately
> for DMA command failed. Smatch warning was removed.
>
> Micky Ching (2):
>   mmc: rtsx: add R1-no-CRC mmc command type handle
>   mmc: rtsx: modify error handle and remove smatch warnings
>
>  drivers/mmc/host/rtsx_pci_sdmmc.c |  122 +++++++++++++++++++++----------------
>  1 file changed, 68 insertions(+), 54 deletions(-)

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

>
> --
> 1.7.9.5
