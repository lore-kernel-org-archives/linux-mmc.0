From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/1] mmc: sdhci-esdhc: Change delay after setting clock from 100ms to 1ms
Date: Tue, 13 Dec 2011 12:25:48 -0500
Message-ID: <m2iplkl6xv.fsf@bob.laptop.org>
References: <1321944150-12162-1-git-send-email-tony.lin@freescale.com>
	<87vcq0kvs6.fsf@laptop.org>
	<97D3A72708D04647A5AC84A04996E5B526EC0F@039-SN1MPN1-001.039d.mgd.msft.net>
	<8A2FC72B45BB5A4C9F801431E06AE48F1162FCA2@039-SN1MPN1-005.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:49189 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753553Ab1LMRZ7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 13 Dec 2011 12:25:59 -0500
In-Reply-To: <8A2FC72B45BB5A4C9F801431E06AE48F1162FCA2@039-SN1MPN1-005.039d.mgd.msft.net>
	(Huang Changming-R's message of "Fri, 2 Dec 2011 07:13:31 +0000")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Huang Changming-R66093 <r66093@freescale.com>
Cc: Lin Tony-B19295 <B19295@freescale.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Xie Xiaobo-R63061 <r63061@freescale.com>, "avorontsov@ru.mvista.com" <avorontsov@ru.mvista.com>

Hi,

On Fri, Dec 02 2011, Huang Changming-R66093 wrote:
> I don't think it make sense to change the delay time.
> Which will affect all PowerPC eSDHC controller, could you confirm
> which can work on all PowerPC platform?

No, of course not, but that's why I said we can put the patch in
mmc-next and see if anyone complains; mdelay(100) is clearly broken.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
