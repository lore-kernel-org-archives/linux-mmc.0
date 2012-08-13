From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 1/2] drivers/mfd: Add realtek pcie card reader driver
Date: Mon, 13 Aug 2012 09:40:13 +0300
Message-ID: <20120813064012.GC4559@mwanda>
References: <1344823586-2956-1-git-send-email-wei_wang@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:44306 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752799Ab2HMGku (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Aug 2012 02:40:50 -0400
Content-Disposition: inline
In-Reply-To: <1344823586-2956-1-git-send-email-wei_wang@realsil.com.cn>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: wei_wang@realsil.com.cn
Cc: gregkh@linuxfoundation.org, devel@linuxdriverproject.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, arnd@arndb.de, sameo@linux.intel.com, aaron.lu@amd.com, bp@alien8.de

On Mon, Aug 13, 2012 at 10:06:26AM +0800, wei_wang@realsil.com.cn wrote:
> +int rtsx_pci_read_phy_register(struct rtsx_pcr *pcr, u8 addr, u16 *val)
> +{
> +	int err, i, finished = 0;
> +	u16 data = 0;
> +	u8 *ptr, tmp;
> +
> +	rtsx_pci_init_cmd(pcr);
> +
> +	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, PHYADDR, 0xFF, addr);
> +	rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, PHYRWCTL, 0xFF, 0x80);
> +
> +	err = rtsx_pci_send_cmd(pcr, 100);
> +	if (err < 0)
> +		return err;
> +
> +	for (i = 0; i < 100000; i++) {
> +		err = rtsx_pci_read_register(pcr, PHYRWCTL, &tmp);
> +		if (err < 0)
> +			return err;
> +
> +		if (!(tmp & 0x80)) {
> +			finished = 1;
> +			break;
> +		}
> +	}
> +
> +	if (!finished)
> +		return -ETIMEDOUT;
> +
> +	rtsx_pci_init_cmd(pcr);
> +
> +	rtsx_pci_add_cmd(pcr, READ_REG_CMD, PHYDATA0, 0, 0);
> +	rtsx_pci_add_cmd(pcr, READ_REG_CMD, PHYDATA1, 0, 0);
> +
> +	err = rtsx_pci_send_cmd(pcr, 100);
> +	if (err < 0)
> +		return err;
> +
> +	ptr = rtsx_pci_get_cmd_data(pcr);
> +	data = ((u16)ptr[1] << 8) || ptr[0];
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Looks like bitwise OR was intended here.

> +
> +	if (val)
> +		*val = data;
> +
> +	return 0;
> +}

regards,
dan carpenter
