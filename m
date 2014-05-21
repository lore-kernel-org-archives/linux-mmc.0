From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: mmc: moxart: Add MOXA ART SD/MMC driver
Date: Wed, 21 May 2014 14:33:57 +0200
Message-ID: <4199288.qtcULgjJrP@wuerfel>
References: <20140521122825.GE23396@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:62169 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751018AbaEUMeA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 May 2014 08:34:00 -0400
In-Reply-To: <20140521122825.GE23396@mwanda>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: jonas.jensen@gmail.com, linux-mmc@vger.kernel.org

On Wednesday 21 May 2014 15:28:25 Dan Carpenter wrote:
> Hello Jonas Jensen,
> 
> The patch 1b66e94e6b99: "mmc: moxart: Add MOXA ART SD/MMC driver"
> from Apr 9, 2014, leads to the following static checker warning:
> 
>         drivers/mmc/host/moxart-mmc.c:691 moxart_remove()
>         warn: variable dereferenced before check 'mmc' (see line 687)
> 
> drivers/mmc/host/moxart-mmc.c
>    684  static int moxart_remove(struct platform_device *pdev)
>    685  {
>    686          struct mmc_host *mmc = dev_get_drvdata(&pdev->dev);
>    687          struct moxart_host *host = mmc_priv(mmc);
>                                            ^^^^^^^^^^^^^
> Dereference.
> 
>    688  
>    689          dev_set_drvdata(&pdev->dev, NULL);
>    690  
>    691          if (mmc) {
>                     ^^^
> Check.

Right, the check should just be removed, because the moxart_remove
function will not be called unless moxart_probe() has successfully
set the drvdata.


On a related note, I also found two bugs using automated build testing:

a) The driver should use dma_request_slave_channel_reason() instead of
of_dma_request_slave_channel() so it can be compiled when CONFIG_OF is
disabled.

b) moxart_remove() contains an extraneous kfree(host), where host is
a variable that has already been freed at that point.

	Arnd
