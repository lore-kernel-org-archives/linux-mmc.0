From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 1/2] mfd: rtsx: add func to split u32 into register
Date: Thu, 27 Nov 2014 18:23:42 +0300
Message-ID: <20141127152342.GA4860@mwanda>
References: <cover.1417056337.git.micky_ching@realsil.com.cn>
 <51dde5250305623c420e78fa555800ef8fef0a09.1417056337.git.micky_ching@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <51dde5250305623c420e78fa555800ef8fef0a09.1417056337.git.micky_ching@realsil.com.cn>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: micky_ching@realsil.com.cn
Cc: ulf.hansson@linaro.org, sameo@linux.intel.com, gregkh@linuxfoundation.org, linux-mmc@vger.kernel.org, chris@printf.net, linux-kernel@vger.kernel.org, wei_wang@realsil.com.cn, devel@linuxdriverproject.org, rogerable@realtek.com, lee.jones@linaro.org
List-Id: linux-mmc@vger.kernel.org

On Thu, Nov 27, 2014 at 10:53:58AM +0800, micky_ching@realsil.com.cn wrote:
> +static inline void rtsx_pci_write_be32(struct rtsx_pcr *pcr, u16 reg, u32 val)
> +{
> +	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, reg,     0xFF, val >> 24);
> +	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, reg + 1, 0xFF, val >> 16);
> +	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, reg + 2, 0xFF, val >> 8);
> +	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, reg + 3, 0xFF, val);

This assumes the cpu is little endian.  First convert to big endian
using cpu_to_be32() and then write it out.

	__be32 be_val = cpu_to_be32()

	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, reg,     0xFF, be_val);
	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, reg + 1, 0xFF, be_val >> 8);
	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, reg + 2, 0xFF, be_val >> 16);
	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, reg + 3, 0xFF, be_val >> 24);

(Written hurredly in my mail client.  May be wrong).

> +}
> +
> +static inline void rtsx_pci_write_le32(struct rtsx_pcr *pcr, u16 reg, u32 val)
> +{
> +	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, reg,     0xFF, val);
> +	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, reg + 1, 0xFF, val >> 8);
> +	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, reg + 2, 0xFF, val >> 16);
> +	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, reg + 3, 0xFF, val >> 24);
> +}

We don't have a user for rtsx_pci_write_le32() so don't add it.

regards,
dan carpenter
