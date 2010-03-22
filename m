From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/2] davinci: MMC: updates to suspend/resume
 implementation
Date: Mon, 22 Mar 2010 12:43:33 -0700
Message-ID: <20100322124333.40d728bb.akpm@linux-foundation.org>
References: <1268771425-6277-1-git-send-email-khilman@deeprootsystems.com>
	<1268771425-6277-2-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:45099 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752727Ab0CVToK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Mar 2010 15:44:10 -0400
In-Reply-To: <1268771425-6277-2-git-send-email-khilman@deeprootsystems.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-mmc@vger.kernel.org, Chaithrika U S <chaithrika@ti.com>, Vipin Bhandari <vipin.bhandari@ti.com>, Sudhakar Rajashekhara <sudhakar.raj@ti.com>, linux-kernel@vger.kernel.org

On Tue, 16 Mar 2010 13:30:25 -0700
Kevin Hilman <khilman@deeprootsystems.com> wrote:

> +static struct dev_pm_ops davinci_mmcsd_pm = {
> +	.suspend        = davinci_mmcsd_suspend,
> +	.resume         = davinci_mmcsd_resume,
> +};

checkpatch said

WARNING: struct dev_pm_ops should normally be const
#83: FILE: drivers/mmc/host/davinci_mmc.c:1379:
+static struct dev_pm_ops davinci_mmcsd_pm = {

I'll make that change.  Please check.
