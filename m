From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] mfd:rtsx: Support RTS5249
Date: Mon, 25 Mar 2013 09:00:38 +0300
Message-ID: <20130325060038.GD9138@mwanda>
References: <1364177636-4294-1-git-send-email-wei_wang@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:39989 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755670Ab3CYGA4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 25 Mar 2013 02:00:56 -0400
Content-Disposition: inline
In-Reply-To: <1364177636-4294-1-git-send-email-wei_wang@realsil.com.cn>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: wei_wang@realsil.com.cn
Cc: cjb@laptop.org, sameo@linux.intel.com, gregkh@linuxfoundation.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, rogerable@realtek.com, devel@linuxdriverproject.org

On Mon, Mar 25, 2013 at 10:13:56AM +0800, wei_wang@realsil.com.cn wrote:
> +static int rts5249_optimize_phy(struct rtsx_pcr *pcr)
> +{
> +	int err;
> +
> +	err = rtsx_pci_write_phy_register(pcr, 0x19, 0xFE46);
> +	if (err < 0)
> +		return err;
> +
> +	mdelay(1);

Why do we have the mdelay() and the later msleep(5)?
rtsx_pci_write_phy_register() busy loops until the write succeeds or
it returns -ETIMEOUT.  The extra wait here seems unnecessary.

regards,
dan carpenter


