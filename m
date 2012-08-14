From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/2] drivers/mfd: Add realtek pcie card reader driver
Date: Tue, 14 Aug 2012 09:32:26 +0000
Message-ID: <201208140932.27276.arnd@arndb.de>
References: <1344922213-19581-1-git-send-email-wei_wang@realsil.com.cn>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:50049 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753519Ab2HNJct (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Aug 2012 05:32:49 -0400
In-Reply-To: <1344922213-19581-1-git-send-email-wei_wang@realsil.com.cn>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: wei_wang@realsil.com.cn
Cc: gregkh@linuxfoundation.org, devel@linuxdriverproject.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, sameo@linux.intel.com, bp@alien8.de

On Tuesday 14 August 2012, wei_wang@realsil.com.cn wrote:
> From: Wei WANG <wei_wang@realsil.com.cn>
> 
> Realtek PCI-E card reader driver adapts requests from upper-level
> sdmmc/memstick layer to the real physical card reader.
> 
> Signed-off-by: Wei WANG <wei_wang@realsil.com.cn>

When you post a new version of patches, please add a version number in the
subject line, like " [PATCH v3 1/2] drivers/mfd: Add realtek pcie card
reader driver", to make it easier for people to know what has changed.
It's also helpful to have a "[PATCH 0/XX]" as 'git format-patch
--cover-letter' generates and list the changes to the previous versions
of your patch in there. Best combine this with 'git send-email --thread
--no-chain-reply', so all patches are sent in the same email thread as
the introductory mail.

Finally, when you get an 'Acked-by' or 'Reviewed-by' tag from someone,
please add that below your Signed-off-by.

Your patches both look fine now, so you can add my

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

	Arnd
