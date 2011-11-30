From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH 1/1] mmc:Support of PCI mode for the dw_mmc driver
Date: Wed, 30 Nov 2011 15:41:31 +0000
Message-ID: <4ED64EAB.4050405@imgtec.com>
References: <1322656585-8363-1-git-send-email-shashidharh@vayavyalabs.com>	<4ED63861.7030607@imgtec.com> <CANYdXnr1+gNmE0nTf0BOHMFZnwsJgYKk8ZcAJqdutDTx25gnWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:42351 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754360Ab1K3Plf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 30 Nov 2011 10:41:35 -0500
In-Reply-To: <CANYdXnr1+gNmE0nTf0BOHMFZnwsJgYKk8ZcAJqdutDTx25gnWQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
Cc: Chris Ball <cjb@laptop.org>, Shawn Guo <shawn.guo@linaro.org>, Philip Rakity <prakity@marvell.com>, "Mark F. Brown" <mark.brown314@gmail.com>, Wolfram Sang <w.sang@pengutronix.de>, Will Newton <will.newton@imgtec.com>, Jaehoon Chung <jh80.chung@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-mmc@vger.kernel.org

Hi,

On 11/30/2011 03:27 PM, Shashidhar Hiremath wrote:
> Hi James,
>   Sorry for the minor alignment issues.Will fix them .

Thanks

> I actually did
> compile the code but as separate driver not along with the kernel. In
> fact, I have also tested the PCI patch ,but not as separate files but
> with the earlier #ifdef method  I had sent in initial patch .

But the new patch was completely different, you can't just rework the
entire patch and expect it to compile and work without at least trying
it to make sure, as evidenced by the fact that with mmc_next + your
patch, I get:
dw_mmc.c: 7 errors, 22 warnings
dw_mmc-pci.c: 2 errors
dw_mmc-pltfm.c: 6 errors, 1 warning

Cheers
James

> On Wed, Nov 30, 2011 at 7:36 PM, James Hogan <james.hogan@imgtec.com> wrote:
>> *sigh* You haven't actually tried compiling this have you? How do you
>> know whether it works or not? You really really should at least make
>> sure it compiles (for simple changes) and works without breaking
>> anything (for anything non-trivial like adding support for a new bus
>> like PCI)!


