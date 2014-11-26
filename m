From: Vadivelan M <Vadivelan.Mani@toshiba-tsip.com>
Subject: RE: eMMC write error in IMX6 Sabre AI board
Date: Wed, 26 Nov 2014 03:21:47 +0000
Message-ID: <0CE86CAC7146084190A01E87F7DCD5E908A19241@TOSBLRMBX01.TOSHIBA-TSIP.COM>
References: <loom.20141107T122543-102@post.gmane.org>
 <CAOMZO5D1n7JutWCJAVafFSOKPZaS_HJjLPp26ROR-Gk12=b0yw@mail.gmail.com>
 <0CE86CAC7146084190A01E87F7DCD5E908A0CFA5@TOSBLRMBX01.TOSHIBA-TSIP.COM>
 <20141125210410.GG28355@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.soc-soft.com ([202.56.254.199]:8825 "EHLO
	peak.toshiba-tesi.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751414AbaKZDZt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Nov 2014 22:25:49 -0500
In-Reply-To: <20141125210410.GG28355@pengutronix.de>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Robert Schwebel' <r.schwebel@pengutronix.de>
Cc: 'Fabio Estevam' <festevam@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

I understand. Ok then let me try to solve the issue by myself.

Thanks,
Vadivelan.

-----Original Message-----
From: Robert Schwebel [mailto:r.schwebel@pengutronix.de] 
Sent: 26 November 2014 02:34
To: Vadivelan M
Cc: 'Fabio Estevam'; linux-mmc@vger.kernel.org
Subject: Re: eMMC write error in IMX6 Sabre AI board

On Mon, Nov 10, 2014 at 08:44:29AM +0000, Vadivelan M wrote:
> Thanks for your suggestion. But my kernel is fixed to version 3.0.35 
> and hence unable to use a different kernel. Please tell what is the 
> problem in this kernel version if you already know. That would be very 
> helpful.

If you use such an old kernel, you are basically on your own; community development & support takes place on top-of-tree.

Note that 3.0.35 is 227048 patches behind 3.18-rc6, and this does not even take into account that you are probably using 3.0.35 plus thousands of vendor patches. You can't seriously expect anyone in the community to help you with issues which have long been solved.

Regards,
Robert
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
The information contained in this e-mail message and in any
attachments/annexure/appendices is confidential to the 
recipient and may contain privileged information. 
If you are not the intended recipient, please notify the
sender and delete the message along with any 
attachments/annexure/appendices. You should not disclose,
copy or otherwise use the information contained in the
message or any annexure. Any views expressed in this e-mail 
are those of the individual sender except where the sender 
specifically states them to be the views of 
Toshiba Software India Pvt. Ltd. (TSIP),Bangalore.

Although this transmission and any attachments are believed to be
free of any virus or other defect that might affect any computer 
system into which it is received and opened, it is the responsibility
of the recipient to ensure that it is virus free and no responsibility 
is accepted by Toshiba Embedded Software India Pvt. Ltd, for any loss or
damage arising in any way from its use.

