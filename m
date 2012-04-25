From: "Subhash Jadavani" <subhashj@codeaurora.org>
Subject: RE: [PATCH 1/2] mmc: core: fix the decision of mmc card-type
Date: Wed, 25 Apr 2012 11:40:31 +0530
Message-ID: <000001cd22aa$222e3250$668a96f0$@codeaurora.org>
References: <002f01cd2131$047457a0$0d5d06e0$%jun@samsung.com> <4F965E1A.30009@codeaurora.org> <003e01cd22a2$47e9bf80$d7bd3e80$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:16952 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753210Ab2DYGKi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Apr 2012 02:10:38 -0400
In-Reply-To: <003e01cd22a2$47e9bf80$d7bd3e80$%jun@samsung.com>
Content-language: en-us
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Seungwon Jeon' <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, 'Chris Ball' <cjb@laptop.org>, 'Girish K S' <girish.shivananjappa@linaro.org>

> > > +	if (caps&  MMC_CAP_MMC_HIGHSPEED&&
> > > +			card_type&  EXT_CSD_CARD_TYPE_52)
> > Just from code readability point of view, can we add parenthesis for
> > each conditions within if?
> >                  if ( (xxx) && (xxx))
> Right but '&' is higher than '&&' in priority, so how about keeping on?
Ok.

Regards,
Subhash

