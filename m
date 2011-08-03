From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 12/15] MMC: au1xmmc: remove Alchemy CPU subtype
 dependencies
Date: Wed, 3 Aug 2011 13:06:27 +0100
Message-ID: <20110803120627.GA856@linux-mips.org>
References: <1312307470-6841-1-git-send-email-manuel.lauss@googlemail.com>
 <1312307470-6841-13-git-send-email-manuel.lauss@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from h5.dl5rb.org.uk ([81.2.74.5]:41512 "EHLO linux-mips.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755442Ab1HCMGb (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 3 Aug 2011 08:06:31 -0400
Content-Disposition: inline
In-Reply-To: <1312307470-6841-13-git-send-email-manuel.lauss@googlemail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Manuel Lauss <manuel.lauss@googlemail.com>
Cc: Linux-MIPS <linux-mips@linux-mips.org>, linux-mmc@vger.kernel.org

On Tue, Aug 02, 2011 at 07:51:07PM +0200, Manuel Lauss wrote:

> Replace all occurrences of CONFIG_SOC_AU1??? with runtime feature
> detection.
> 
> Cc: <linux-mmc@vger.kernel.org>
> Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
> ---
> I'd like for this patch to go in via the mips tree since a few more depend
> on it.

Patch is looking ok.  Since MMC is orphaned I've just queued it and it
will go to linux-next after -rc1.

  Ralf
