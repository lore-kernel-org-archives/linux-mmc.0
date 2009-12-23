From: David Miller <davem@davemloft.net>
Subject: Re: [net-next 3/3] iwmc3200top: simplify imwct_tx
Date: Wed, 23 Dec 2009 14:16:50 -0800 (PST)
Message-ID: <20091223.141650.246536138.davem@davemloft.net>
References: <1260973586-10243-1-git-send-email-tomas.winkler@intel.com>
	<1260973586-10243-2-git-send-email-tomas.winkler@intel.com>
	<1260973586-10243-3-git-send-email-tomas.winkler@intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:44659
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757490AbZLWWQs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Dec 2009 17:16:48 -0500
In-Reply-To: <1260973586-10243-3-git-send-email-tomas.winkler@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: tomas.winkler@intel.com
Cc: netdev@vger.kernel.org, linux-mmc@vger.kernel.org, yi.zhu@intel.com, inaky.perez-gonzalez@intel.com, guy.cohen@intel.com, ron.rindjunsky@intel.com

From: Tomas Winkler <tomas.winkler@intel.com>
Date: Wed, 16 Dec 2009 16:26:26 +0200

> 1. remove address argument since we use same address IWMC_SDIO_DATA_ADDR in
>     all cases
> 2. add __iwmct_tx - non locking tx function for already locked contexts
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

Applied.
