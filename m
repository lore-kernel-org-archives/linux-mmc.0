From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH 2/3] mfd: rtsx: implement driving adjustment to
 device-dependent callbacks
Date: Mon, 4 Feb 2013 12:56:33 +0100
Message-ID: <20130204115633.GD8476@sortiz-mobl>
References: <1359963959-2305-1-git-send-email-rogerable@realtek.com>
 <1359963959-2305-3-git-send-email-rogerable@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <1359963959-2305-3-git-send-email-rogerable@realtek.com>
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

On Mon, Feb 04, 2013 at 03:45:58PM +0800, Roger Tseng wrote:
> Implement different ways of selecting driving capability(a necessary adjustment
> along with voltage change). It was origionally in device-independent
> mmc/host/rtsx_pci_sdmmc.c. Moving it here to support devices which may have a
> different way of adjustment.
> 
> Signed-off-by: Roger Tseng <rogerable@realtek.com>
> Reviewed-by: Wei WANG <wei_wang@realsil.com.cn>
> ---
>  drivers/mfd/rtl8411.c | 16 +++++++++++++---
>  drivers/mfd/rts5209.c |  8 ++++++++
>  drivers/mfd/rts5229.c |  8 ++++++++
>  3 files changed, 29 insertions(+), 3 deletions(-)
Applied, thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
