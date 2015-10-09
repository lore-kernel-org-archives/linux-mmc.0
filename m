From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH v2 3/5] ARM: mvebu: set SW polling as SDHCI card
 detection on A388-GP
Date: Fri, 9 Oct 2015 09:52:04 +0200
Message-ID: <20151009095204.41010dd9@free-electrons.com>
References: <1444352635-21965-1-git-send-email-mw@semihalf.com>
	<1444352635-21965-4-git-send-email-mw@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:51588 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755795AbbJIHwI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Oct 2015 03:52:08 -0400
In-Reply-To: <1444352635-21965-4-git-send-email-mw@semihalf.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Marcin Wojtas <mw@semihalf.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, sebastian.hesselbarth@gmail.com, andrew@lunn.ch, jason@lakedaemon.net, gregory.clement@free-electrons.com, nadavh@marvell.com, alior@marvell.com, tawfik@marvell.com, jaz@semihalf.com

Dear Marcin Wojtas,

On Fri,  9 Oct 2015 03:03:53 +0200, Marcin Wojtas wrote:
> The newest revisions of A388-GP (v1.5 and higher) support only
> DAT3-based card detection. Revisions < v1.5 based on GPIO detection
> via I2C expander, but this solution is supposed to be deprecated on
> new boards. In order to satisfy all type of hardware this commit
> changes card detection to use software polling mechanism.
> 
> Signed-off-by: Marcin Wojtas <mw@semihalf.com>

Can we add a comment on the DT that explains why SW polling is used,
and which other mechanism can be used depending on the board revision?

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
