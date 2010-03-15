From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] davinci: MMC: Pass number of SG segments as platform
 data
Date: Mon, 15 Mar 2010 14:40:37 -0700
Message-ID: <20100315144037.bf47d74f.akpm@linux-foundation.org>
References: <1268397249-7654-1-git-send-email-sudhakar.raj@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:34769 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932093Ab0COVko (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Mar 2010 17:40:44 -0400
In-Reply-To: <1268397249-7654-1-git-send-email-sudhakar.raj@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sudhakar Rajashekhara <sudhakar.raj@ti.com>
Cc: linux-kernel@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com, linux-mmc@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>

On Fri, 12 Mar 2010 18:04:09 +0530
Sudhakar Rajashekhara <sudhakar.raj@ti.com> wrote:

> On some platforms like DM355, the number of EDMA parameter
> slots available for EDMA_SLOT_ANY usage are few. In such cases,
> if MMC/SD uses 16 slots for each instance of MMC controller,
> then the number of slots available for other modules will be
> very few.
> 
> By passing the number of EDMA slots to be used in MMC driver
> from platform data, EDMA slots available for other purposes
> can be controlled.

It's unclear what the runtime effects of this change are.  I assumed
(without justification) that they're minor and I scheduled the patch for
2.6.35.

If that was the wrong decision then blame the changelog ;)
