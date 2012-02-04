From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v6] mmc:Support of PCI mode for the dw_mmc driver
Date: Sat, 04 Feb 2012 16:55:07 -0500
Message-ID: <m27h02b6x0.fsf@bob.laptop.org>
References: <1326450897-9248-1-git-send-email-shashidharh@vayavyalabs.com>
	<4F1023D9.5050700@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:39135 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754577Ab2BDVz2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 4 Feb 2012 16:55:28 -0500
In-Reply-To: <4F1023D9.5050700@imgtec.com> (James Hogan's message of "Fri, 13
	Jan 2012 12:30:17 +0000")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: James Hogan <james.hogan@imgtec.com>
Cc: Shashidhar Hiremath <shashidharh@vayavyalabs.com>, Shawn Guo <shawn.guo@linaro.org>, Philip Rakity <prakity@marvell.com>, "Mark F. Brown" <mark.brown314@gmail.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Will Newton <will.newton@imgtec.com>, Jaehoon Chung <jh80.chung@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-mmc@vger.kernel.org

Hi,

On Fri, Jan 13 2012, James Hogan wrote:
> On 13/01/12 10:34, Shashidhar Hiremath wrote:
>> Support of PCI mode for the dw_mmc driver. This Patch adds the
>> support for the scenario where the Synopsys Designware IP
>> is present on the PCI bus. The patch adds the minimal modifications
>> necessary for the driver to work on PCI platform. Also added separate
>> files for PCI and PLATFORM modes of operation.
>> 
>> Signed-off-by: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
>
> Acked-by: James Hogan <james.hogan@imgtec.com>

Thanks, pushed to mmc-next for 3.4.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
