From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH] mfd:rtsx: Support RTL8411B
Date: Fri, 17 May 2013 00:18:02 +0200
Message-ID: <20130516221802.GX22822@zurbaran>
References: <1366379562-23429-1-git-send-email-rogerable@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1366379562-23429-1-git-send-email-rogerable@realtek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rogerable@realtek.com
Cc: cjb@laptop.org, devel@linuxdriverproject.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, gregkh@linuxfoundation.org, wei_wang@realsil.com.cn
List-Id: linux-mmc@vger.kernel.org

Hi Roger,

On Fri, Apr 19, 2013 at 09:52:42PM +0800, rogerable@realtek.com wrote:
> From: Roger Tseng <rogerable@realtek.com>
> 
> Adding support of model RTL8411B. Since the model is similar to RTL8411,
> differences are implemented in rtl8411.c.
> 
> Signed-off-by: Roger Tseng <rogerable@realtek.com>
> ---
>  drivers/mfd/rtl8411.c        | 132 +++++++++++++++++++++++++++++++++++++++++++
>  drivers/mfd/rtsx_pcr.c       |   5 ++
>  drivers/mfd/rtsx_pcr.h       |   1 +
>  include/linux/mfd/rtsx_pci.h |   1 +
>  4 files changed, 139 insertions(+)
Patch applied to mfd-next, thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
