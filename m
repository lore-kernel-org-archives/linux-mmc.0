From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v3 1/1] mmc: omap_hsmmc: devm_pinctrl_get returns ERR_PTR
 upon error
Date: Thu, 21 Apr 2016 07:32:12 +0300
Message-ID: <20160421043211.GS4247@mwanda>
References: <1461099853-15011-1-git-send-email-afenkart@gmail.com>
 <CALtMJEA0XaekLgZnOVU4XMPmc61VendSCCV2uKjesxzQRcwR8w@mail.gmail.com>
 <20160420151337.GK5973@atomide.com>
 <4155990.SfY6i69ddf@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:23578 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751282AbcDUEcY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Apr 2016 00:32:24 -0400
Content-Disposition: inline
In-Reply-To: <4155990.SfY6i69ddf@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tony Lindgren <tony@atomide.com>, Andreas Fenkart <afenkart@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-omap@vger.kernel.org

On Thu, Apr 21, 2016 at 12:28:05AM +0200, Arnd Bergmann wrote:
> I don't see anything wrong with the devm_pinctrl_get prototype other
> than how it frequently confuses driver writers.

Yeah.  It basically works.  There are a bunch of similar APIs where NULL
vs ERR_PTR is used the same way.

regards,
dan carpenter

