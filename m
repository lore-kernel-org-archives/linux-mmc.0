From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: dw_mmc: priv->sdr_timing set wrong
Date: Tue, 22 Oct 2013 15:45:42 +0900
Message-ID: <52661F16.3080602@samsung.com>
References: <CANEJEGt+kx3_EjgBGxkZ9TJec9ngf=FOcwhg2+eAtPY9-2xxCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:61970 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750868Ab3JVGpn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Oct 2013 02:45:43 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MV200JGR5G4K730@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 22 Oct 2013 15:45:41 +0900 (KST)
In-reply-to: <CANEJEGt+kx3_EjgBGxkZ9TJec9ngf=FOcwhg2+eAtPY9-2xxCA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Grant Grundler <grundler@chromium.org>, Chris Ball <cjb@laptop.org>, Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>, Seungwon Jeon <tgih.jun@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Sonny Rao <sonnyrao@chromium.org>, ALIM AKHTAR <alim.akhtar@samsung.com>, Douglas Anderson <dianders@chromium.org>

Hi Grant,

Good catch..sdr-timing is set to wrong value.(set to ddr-timing)
Do you have the plan that send the fixing patch at mailing?

Best Regards,
Jaehoon Chung

On 10/19/2013 05:13 AM, Grant Grundler wrote:
> Chris, Yuvaraj, Alim, Jaehoon,
> 
> This patch is wrong:
> https://git.kernel.org/cgit/linux/kernel/git/cjb/mmc.git/commit/?h=mmc-next&id=e6c784eded7b39caeaf2e9206336fa1daeccfd09
> 
> sdr_timing needs to come from the of_property "samsung,dw-mshc-sdr-timing".
> Assignment of priv->sdr_timing needs to move back where it was before.
> 
> Can one of you guys "just fix it" or do you need a patch from me (or Sonny)?
> 
> (This came up during my review of eMMC patches that sonny is
> backporting to ChromeOS-3.8 kernel and I'm not done yet - have a ton
> more to do here.)
> 
> thanks,
> grant
> 

