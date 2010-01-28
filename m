From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH-Resend] S3C: sdhci: Enable ADMA feature in S3C sdhci controller.
Date: Thu, 28 Jan 2010 13:37:40 +0100
Message-ID: <874om6pfqj.fsf@macbook.be.48ers.dk>
References: <1264643438-6317-1-git-send-email-thomas.ab@samsung.com>
	<20100128041334.GQ10014@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:58496 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752146Ab0A1Mhp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Jan 2010 07:37:45 -0500
Received: by ewy19 with SMTP id 19so687731ewy.21
        for <linux-mmc@vger.kernel.org>; Thu, 28 Jan 2010 04:37:44 -0800 (PST)
In-Reply-To: <20100128041334.GQ10014@trinity.fluff.org> (Ben Dooks's message
	of "Thu, 28 Jan 2010 04:13:34 +0000")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ben Dooks <ben-linux@fluff.org>
Cc: Thomas Abraham <thomas.ab@samsung.com>, linux-mmc@vger.kernel.org, kgene.kim@samsung.com

>>>>> "Ben" == Ben Dooks <ben-linux@fluff.org> writes:

 Ben> On Thu, Jan 28, 2010 at 10:50:38AM +0900, Thomas Abraham wrote:
 >> This patch enables ADMA feature in S3C SDHCI controller driver. This patch
 >> depends on the following patch.
 >> 
 >> [PATCH] sdhci: Add new quirk in sdhci driver and update ADMA descriptor build.
 >> 
 >> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
 Ben> Acked-by: Ben Dooks <ben-linux@fluff.org>

If this solves the DMA issues, shouldn't we get rid of the
CONFIG_MMC_SDHCI_S3C_DMA kconfig and just always use DMA?

-- 
Bye, Peter Korsgaard
