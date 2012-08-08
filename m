From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 4/4] mmc: bfin_sdh: Reset SD controller when resume from power saving mode.
Date: Wed, 08 Aug 2012 00:20:48 -0400
Message-ID: <87ipcut3of.fsf@octavius.laptop.org>
References: <1344309015-13248-1-git-send-email-sonic.adi@gmail.com>
	<1344309015-13248-4-git-send-email-sonic.adi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:54858 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750749Ab2HHEUy (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 8 Aug 2012 00:20:54 -0400
In-Reply-To: <1344309015-13248-4-git-send-email-sonic.adi@gmail.com> (Sonic
	Zhang's message of "Tue, 7 Aug 2012 11:10:15 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sonic Zhang <sonic.adi@gmail.com>
Cc: linux-mmc@vger.kernel.org, Bob Liu <liubbo@gmail.com>, uclinux-dist-devel@blackfin.uclinux.org, Sonic Zhang <sonic.zhang@analog.com>

Hi,

On Mon, Aug 06 2012, Sonic Zhang wrote:
> From: Sonic Zhang <sonic.zhang@analog.com>
>
> Without reset, SD controller may stay in disable mode, SD card can't
> be detected when resume from power saving mode.
>
> Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>

Thanks, pushed to mmc-next for 3.7.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
