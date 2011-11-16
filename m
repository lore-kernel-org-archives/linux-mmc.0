From: NamJae Jeon <linkinjeon@gmail.com>
Subject: Re: [PATCH 4/4] mmc: Add mmc_host_<level> logging
Date: Wed, 16 Nov 2011 10:14:04 +0900
Message-ID: <CAKYAXd9iQzvZBJL+0xPhKyC5hf-frPpMLhdWr3ygbztGiYtNJQ@mail.gmail.com>
References: <cover.1321398814.git.joe@perches.com>
	<631c53d126feff0a99b61d9c9a00b308d2b638ee.1321398815.git.joe@perches.com>
	<CAKYAXd_wtGVQYgr_MUtVGGpkpqJgF56bfm0zO-nnAK0YpkT+bg@mail.gmail.com>
	<1321405049.21286.35.camel@Joe-Laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1321405049.21286.35.camel@Joe-Laptop>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, David Brown <davidb@codeaurora.org>, Daniel Walker <dwalker@fifo99.com>, Bryan Huntsman <bryanh@codeaurora.org>, Nicolas Pitre <nico@fluxnic.net>, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ian Molton <ian@mnementh.co.uk>, Bruce Chang <brucechang@via.com.tw>, Harald Welte <HaraldWelte@viatech.com>, Pierre Ossman <pierre@ossman.eu>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

2011/11/16 Joe Perches <joe@perches.com>:
> On Wed, 2011-11-16 at 09:52 +0900, NamJae Jeon wrote:
>> 2011/11/16 Joe Perches <joe@perches.com>:
>> > Centralize the pr_<level> uses of mmc_hostname into specific
>> > mmc_host_<level> calls to allow a flexible presentation style
>> > and shorten the code a bit.
>
>> I don't know why pr_info should be surely replaced by mmc_host_info.
>> if it is needed for only host name, I think that existing
>> pr_info/err/debug is sufficient.
>
> Please trim your replies and read the patch description.
my concern is that they feel confuse when coder add print code because
they should use mmc_host<level> for hostname, and pr_<level> is used
in the other case.
>
>
>
