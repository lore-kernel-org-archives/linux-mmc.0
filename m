From: "Zhang, Sonic" <Sonic.Zhang@analog.com>
Subject: RE: [PATCH 1/4] mmc: bfin_sdh: limit mmc DMA segment len to 1 for
 bf518.
Date: Tue, 7 Aug 2012 23:39:49 -0400
Message-ID: <DB904C5425BA6F4E8424B3B51A1414D1714D286429@NWD2CMBX1.ad.analog.com>
References: <1344309015-13248-1-git-send-email-sonic.adi@gmail.com>
	<CAJxxZ0M9oReELfJ_ncu=eHd=Qy0Bpx=06Jv3MzvOPbRTh_h-jg@mail.gmail.com>
 <87zk66vz45.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe010.messaging.microsoft.com ([216.32.180.30]:17895
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751787Ab2HHDkK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 7 Aug 2012 23:40:10 -0400
In-Reply-To: <87zk66vz45.fsf@octavius.laptop.org>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Sonic Zhang <sonic.adi@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Bob Liu <liubbo@gmail.com>, "uclinux-dist-devel@blackfin.uclinux.org" <uclinux-dist-devel@blackfin.uclinux.org>

Hi Chris,

Cliff Cai was not working for Analog Devices since 2011. I take over this SD driver now. I will revise the maintainer for bfin_sdh.c soon.


Regards,

Sonic


>-----Original Message-----
>From: Chris Ball [mailto:cjb@laptop.org]
>Sent: Wednesday, August 08, 2012 11:31 AM
>To: Sonic Zhang
>Cc: linux-mmc@vger.kernel.org; Bob Liu; uclinux-dist-devel@blackfin.uclinux.org;
>Zhang, Sonic; Cliff Cai
>Subject: Re: [PATCH 1/4] mmc: bfin_sdh: limit mmc DMA segment len to 1 for
>bf518.
>
>Hi,
>
>On Tue, Aug 07 2012, Sonic Zhang wrote:
>> Could you review this series of patches for Blackfin on-chip SD
>> controller? The head file and new BF60x machine code have been merged
>> upstream. These patches are necessary to get SD driver built on BF60x.
>
>I see that Cliff Cai <cliff.cai@analog.com> is listed as the maintainer
>of bfin_sdh.c in MAINTAINERS -- is it possible for you to get his ACK?
>
>Thanks,
>
>- Chris.
>--
>Chris Ball   <cjb@laptop.org>   <http://printf.net/>
>One Laptop Per Child


