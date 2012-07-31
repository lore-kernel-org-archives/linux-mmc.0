From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 3/3] drivers/mmc/host: Add realtek sdmmc interface driver
Date: Tue, 31 Jul 2012 20:11:39 +0200
Message-ID: <20120731181138.GA5825@x1.osrc.amd.com>
References: <1343720576-22181-1-git-send-email-wei_wang@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:46150 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754319Ab2GaSLi (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 31 Jul 2012 14:11:38 -0400
Content-Disposition: inline
In-Reply-To: <1343720576-22181-1-git-send-email-wei_wang@realsil.com.cn>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: wei_wang@realsil.com.cn
Cc: gregkh@linuxfoundation.org, devel@linuxdriverproject.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, arnd@arndb.de, aaron.lu@amd.come

On Tue, Jul 31, 2012 at 03:42:56PM +0800, wei_wang@realsil.com.cn wrote=
:
> From: Wei WANG <wei_wang@realsil.com.cn>
>=20
> Realtek SD/MMC card interface driver is used to access
> SD/MMC card, with the help of Realtek card reader adapter driver.
>=20
> Signed-off-by: Wei WANG <wei_wang@realsil.com.cn>
> ---

[ =E2=80=A6 ]

> +static void __devexit realtek_sdmmc_remove(struct rtsx_dev *sock)
> +{
> +	struct mmc_host *mmc =3D rtsx_get_drvdata(sock);
> +	struct realtek_sdmmc *host;
> +
> +	host =3D mmc_priv(mmc);
> +	host->eject =3D 1;
> +
> +	mutex_lock(&host->host_mutex);
> +	if (host->mrq) {
> +		dev_dbg(&(sock->dev),
> +			"%s: Controller removed during transfer\n",
> +			mmc_hostname(mmc));
> +
> +		rtsx_complete_unfinished_transfer(sock);
> +
> +		host->mrq->cmd->error =3D -ENOMEDIUM;
> +		if (host->mrq->stop)
> +			host->mrq->stop->error =3D -ENOMEDIUM;
> +		mmc_request_done(mmc, host->mrq);
> +	}
> +	mutex_unlock(&host->host_mutex);
> +
> +	mmc_remove_host(mmc);
> +	mmc_free_host(mmc);
> +
> +	pr_info(DRV_NAME
> +		": Realtek SDMMC controller has been removed\n");

Oh and this appears in the logs when I remove the card:

[11721.313471] rtsx_sdmmc: Realtek SDMMC controller has been removed

but it is simply polluting the logs with useless info that a card has
been removed.

If you really need those printk (same with the PCI-E driver) you could
try to use dev_dbg() like you do above.

Same for the probe function.

But, more importantly and while playing with this, I replugged the card
and it said:

[12072.632332] rtsx_core: MMC/SD card detected in socket 0:0
[12072.642855] rtsx_sdmmc: Realtek SDMMC controller found
[12073.839561] mmc0: error -110 whilst initialising SD card
[12075.138833] mmc0: error -110 whilst initialising SD card
[12076.438158] mmc0: error -110 whilst initialising SD card

and now I can't mount the card anymore:

$ mount /dev/mmcblk0 /mnt/tmp/
mount: /dev/mmcblk0 is not a valid block device

$ mount /dev/mmcblk0p1 /mnt/tmp/
mount: /dev/mmcblk0p1 is not a valid block device

Hmm..

--=20
Regards/Gruss,
Boris.
