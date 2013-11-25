From: Jackey Shen <jackey.shen@amd.com>
Subject: Re: [PATCH 3/3] mmc: add support for hs400 mode of eMMC5.0
Date: Mon, 25 Nov 2013 15:32:07 +0800
Message-ID: <20131125073205.GA10397@ubuntu.amd.com>
References: <1383653403-10049-1-git-send-email-ulf.hansson@linaro.org>
 <003601ceda2a$dd0e8140$972b83c0$%jun@samsung.com>
 <0C8FBB70FF40A94D98BE847F9C171A9803AD4CDD@SCYBEXDAG04.amd.com>
 <003e01cedbad$e3d252c0$ab76f840$%jun@samsung.com>
 <20131108090533.GA6528@ubuntu.amd.com>
 <002201cededc$b5f58160$21e08420$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-db9lp0251.outbound.messaging.microsoft.com ([213.199.154.251]:58664
	"EHLO db9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752051Ab3KYHcE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 25 Nov 2013 02:32:04 -0500
Content-Disposition: inline
In-Reply-To: <002201cededc$b5f58160$21e08420$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: 'Chris Ball' <cjb@laptop.org>, 'Ulf Hansson' <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org

On Mon, Nov 11, 2013 at 09:51:16PM +0900, Seungwon Jeon wrote:
> On Fri, November 08, 2013, Jackey Shen wrote:
> > Hi Seungwon,
> > 
> > Another a little suggestion:
> > It would be better that "hs400" in comments is updated to "HS400",
> > since the symbol is a special one.
> OK.
> 
> > 
> > Does you test this feature on eMMC 5.0 card from
> > http://www.samsung.com/global/business/semiconductor/product/flash-emmc/overview?
> 
> No, it seems not found in list.
> 
> Can you test eMMC5.0 in your side?
Hi Seungwon,

Could you please tell what eMMC 5.0 cards are used for test?
I have not such device at present. I will test the patch once I get one.

BTW, does your eMMC card support "Extended Partitions Attribute" and
"Write Protect management"?

Thanks,
Jackey

