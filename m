From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH 3/3] mfd: rtsx: support RTS5227
Date: Mon, 4 Feb 2013 12:57:04 +0100
Message-ID: <20130204115704.GE8476@sortiz-mobl>
References: <1359963959-2305-1-git-send-email-rogerable@realtek.com>
 <1359963959-2305-4-git-send-email-rogerable@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <1359963959-2305-4-git-send-email-rogerable@realtek.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
 <mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel/>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
 <mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: "devel" <devel-bounces@linuxdriverproject.org>
To: Roger Tseng <rogerable@realtek.com>
Cc: gregkh@linuxfoundation.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, wei_wang@realsil.com.cn, devel@linuxdriverproject.org, cjb@laptop.org
List-Id: linux-mmc@vger.kernel.org

Hi Roger,

On Mon, Feb 04, 2013 at 03:45:59PM +0800, Roger Tseng wrote:
> Support new model RTS5227.
> 
> Signed-off-by: Roger Tseng <rogerable@realtek.com>
> Reviewed-by: Wei WANG <wei_wang@realsil.com.cn>
> ---
>  drivers/mfd/Makefile         |   2 +-
>  drivers/mfd/rts5227.c        | 234 +++++++++++++++++++++++++++++++++++++++++++
>  drivers/mfd/rtsx_pcr.c       |   5 +
>  drivers/mfd/rtsx_pcr.h       |   1 +
>  include/linux/mfd/rtsx_pci.h |   5 +
>  5 files changed, 246 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/mfd/rts5227.c
Applied as well, thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
