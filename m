From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [PATCH v2] mmc: sdhci: add quirk for broken write protect
 detection
Date: Tue, 4 Mar 2014 11:26:05 -0800
Message-ID: <74003aec-1707-4f43-b947-df148d573fa1@TX2EHSMHS038.ehs.local>
References: <1393759200-22819-1-git-send-email-eli.billauer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]:1895 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751494AbaCDT00 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 4 Mar 2014 14:26:26 -0500
Content-Disposition: inline
In-Reply-To: <1393759200-22819-1-git-send-email-eli.billauer@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Eli Billauer <eli.billauer@gmail.com>
Cc: chris@printf.net, michal.simek@xilinx.com, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Mike Looijmans <mike.looijmans@topic.nl>

Hi Eli,

On Sun, 2014-03-02 at 01:20PM +0200, Eli Billauer wrote:
> The write protection signal is absent on a board based upon Xilinx' Z=
ynq
> processor ("ZyBo"). This leads the kernel to think that the MicroSD c=
ard is
> write protected, and causes a kernel panic during boot, as root fails=
 to
> mount RW.

I talked to some people here at Xilinx. According to them, you have the
option to pin out the WP signal, which would mean the board needs to
tie/connect the signal properly. Or, if you select to not pin out the W=
P
signal, it should be tied to 0 within the chip.
Currently, I have some doubts that is the case, since Mike reported the
same issue, but would you mind double checking?
In theory the signal should default to logic zero which would at most
require to add the, already existing, 'wp-inverted' quirk when using
micro-sd on Zynq.

	Thanks,
	S=C3=B6ren


