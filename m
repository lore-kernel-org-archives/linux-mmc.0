From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v2] mmc: omap_hsmmc: devm_pinctrl_get returns ERR_PTR
 upon error
Date: Wed, 23 Mar 2016 23:10:09 +0300
Message-ID: <20160323201009.GB5273@mwanda>
References: <1458761316-11706-1-git-send-email-afenkart@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:42908 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755848AbcCWUKM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Mar 2016 16:10:12 -0400
Content-Disposition: inline
In-Reply-To: <1458761316-11706-1-git-send-email-afenkart@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andreas Fenkart <afenkart@gmail.com>
Cc: linux-mmc@vger.kernel.org

On Wed, Mar 23, 2016 at 08:28:36PM +0100, Andreas Fenkart wrote:
> keystone_defconfig can be compiled without PINCTRL support
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Andreas Fenkart <afenkart@gmail.com>

Just add a depend or a select in the Kconfig.

regards,
dan carpenter

