From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] MMC: fix the use of kunmap_atomic() in tmio_mmc.h
Date: Thu, 26 Aug 2010 16:04:58 -0700
Message-ID: <20100826160458.17c45371.akpm@linux-foundation.org>
References: <Pine.LNX.4.64.1008142225120.16329@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59593 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751887Ab0HZXFO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Aug 2010 19:05:14 -0400
In-Reply-To: <Pine.LNX.4.64.1008142225120.16329@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, Ian Molton <spyro@f2s.com>, Magnus Damm <damm@opensource.se>, Eric Miao <eric.y.miao@gmail.com>

On Sat, 14 Aug 2010 22:29:40 +0200 (CEST)
Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:

> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

No changelog :(

- what was wrong with the old code?

- how did the patch fix it?

