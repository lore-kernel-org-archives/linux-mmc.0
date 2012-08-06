From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] drivers: mmc: bfin_sdh: fix build error
Date: Mon, 06 Aug 2012 11:34:37 -0400
Message-ID: <87y5ls11bm.fsf@octavius.laptop.org>
References: <1343631782-24207-1-git-send-email-lliubbo@gmail.com>
	<CAA_GA1c3w_6Oq7dR+0Exw-warJyL9dr2PKyT6nrkWrDfx=MCKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:35966 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755529Ab2HFPep (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 6 Aug 2012 11:34:45 -0400
In-Reply-To: <CAA_GA1c3w_6Oq7dR+0Exw-warJyL9dr2PKyT6nrkWrDfx=MCKQ@mail.gmail.com>
	(Bob Liu's message of "Mon, 6 Aug 2012 17:27:40 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Bob Liu <lliubbo@gmail.com>
Cc: adrian.hunter@intel.com, ludovic.desroches@atmel.com, rmk+kernel@arm.linux.org.uk, g.liakhovetski@gmx.de, uclinux-dist-devel@blackfin.uclinux.org, Sonic Zhang <sonic.zhang@analog.com>, linux-mmc@vger.kernel.org

Hi Bob,

On Mon, Aug 06 2012, Bob Liu wrote:
> Would you please take a look at this patch?
> Since without this patch, regression test for blackfin will fail:
> http://kisskb.ellerman.id.au/kisskb/matrix/

Thanks, pushed to mmc-next for 3.6 now.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
