From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH V6] SDHCI: S3C: Use generic clock names for sdhci bus clock
 options
Date: Thu, 03 Nov 2011 11:14:41 +0900
Message-ID: <013501cc99ce$58ea8920$0abf9b60$%kim@samsung.com>
References: <1320039876-21148-1-git-send-email-rajeshwari.s@samsung.com>
 <005301cc9958$bcf5aa10$36e0fe30$%kim@samsung.com>
 <m2aa8e9zn3.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:62265 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933049Ab1KCCOn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Nov 2011 22:14:43 -0400
In-reply-to: <m2aa8e9zn3.fsf@bob.laptop.org>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Chris Ball' <cjb@laptop.org>
Cc: 'Rajeshwari Shinde' <rajeshwari.s@samsung.com>, linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Chris Ball wrote:
> 
> Hi Kukjin,
> 
> On Wed, Nov 02 2011, Kukjin Kim wrote:
> >> This patch modifies the driver to stop depending on the clock names
> >> being passed from the platform and switch over to bus clock lookup
> >> using generic clock names.
> >>
> >> V6 Changes:
> >> Changed sprintf to snprintf as suggested by Chris Ball.
> >>
> >> Signed-off-by: Rajeshwari Shinde <rajeshwari.s@samsung.com>
> >
> > Acked-by: Kukjin Kim <kgene.kim@samsung.com>
> >
> > Hi Chirs,
> >
> > Could you please pick this up in your tree for this merge window?
> 
> Might be easier to have you send this, if you don't mind, since I'm
> still traveling and have already sent my main pull request.  Thanks!
> 
> Acked-by: Chris Ball <cjb@laptop.org>
> 
Hi Chris,

OK, I picked this up in my tree.
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

