From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mmc: allow for MMC v4.4
Date: Tue, 22 Dec 2009 14:22:30 -0800
Message-ID: <20091222142230.df371d97.akpm@linux-foundation.org>
References: <4B2B74BD.7050405@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:41462 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755201AbZLVWXG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Dec 2009 17:23:06 -0500
In-Reply-To: <4B2B74BD.7050405@nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: Pierre Ossman <pierre@ossman.eu>, Linux MMC Mailing List <linux-mmc@vger.kernel.org>

On Fri, 18 Dec 2009 14:25:33 +0200
Adrian Hunter <adrian.hunter@nokia.com> wrote:

> JEDEC eMMC specification version 4.4 (MMCA 4.4) defines
> Extended CSD structure versions up to 5.

Not such a nice changelog.  It doesn't describe the effects of the
current code's shortcoming so I was unable to decide whether to
recommend that this patch be backported.

