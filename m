From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH-Resend] mmc_test: block addressed cards
Date: Mon, 1 Feb 2010 14:15:17 -0800
Message-ID: <20100201141517.bae3006b.akpm@linux-foundation.org>
References: <4B66C367.7090003@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:39403 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753215Ab0BAWPZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 1 Feb 2010 17:15:25 -0500
In-Reply-To: <4B66C367.7090003@axis.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Johan Kristell <johan.kristell@axis.com>
Cc: linux-mmc@vger.kernel.org

On Mon, 1 Feb 2010 13:04:55 +0100
Johan Kristell <johan.kristell@axis.com> wrote:

> The tests in mmc_test assumes that all cards are byte addressable.
> This patch updates the tests to also work with cards that use block
> addresses.

When fixing a bug, please decribe the bug!  Otherwise it's hard for
others (ie: me) to work out the severity of the bug and hence the
urgency of the fix.

>From the above info, I'm unable to decide whether this fix is needed in
2.6.33 or 2.6.32.

