From: Hein_Tibosch <hein_tibosch@yahoo.es>
Subject: Re: [patch] mmc: fix init f_min
Date: Tue, 28 Sep 2010 11:55:17 +0800
Message-ID: <4CA16725.8050804@yahoo.es>
References: <AANLkTi=8ScP4Lm-an7bjXhj8doUVu+nM0KnVTa3WK4p3@mail.gmail.com>	<4C9770E4.7000801@csr.com>	<AANLkTi=toSZuEUBYBeGi=sq4QNnqZ=c-Ai1L32Bnpi=V@mail.gmail.com>	<4CA064DD.6040705@csr.com> <AANLkTimOHbSTVStnDLUJ+ka62NzmQrAAksrNR1LP_yLo@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bosmailout06.eigbox.net ([66.96.187.6]:53466 "EHLO
	bosmailout06.eigbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751282Ab0I1E3c (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Sep 2010 00:29:32 -0400
Received: from bosmailscan14.eigbox.net ([10.20.15.14])
	by bosmailout06.eigbox.net with esmtp (Exim)
	id 1P0RIj-0003Rq-Ii
	for linux-mmc@vger.kernel.org; Mon, 27 Sep 2010 23:56:21 -0400
In-Reply-To: <AANLkTimOHbSTVStnDLUJ+ka62NzmQrAAksrNR1LP_yLo@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: linux-mmc@vger.kernel.org

 On 28-9-2010 11:34, zhangfei gao wrote:
>
> Just curious how to get 400000, which is slowest speed for
> initializaion, is this OK for all card?
>
Hi Zhangfei,

It looks as if you missed another thread about f_min recently?

See: https://patchwork.kernel.org/patch/177932/

This was in response to complaints about 400 Khz being too high for some ... platforms

But note that 400 Khz is the highest possible speed to initialize an SD card,

Hein Tibosch

