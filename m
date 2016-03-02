From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 0/2] mmc, block: override default max_dev_sectors
Date: Wed, 2 Mar 2016 09:12:28 -0800
Message-ID: <20160302171227.GA5229@infradead.org>
References: <cover.1456847028.git.pawelx.wodkowski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:34015 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755116AbcCBRM2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Mar 2016 12:12:28 -0500
Content-Disposition: inline
In-Reply-To: <cover.1456847028.git.pawelx.wodkowski@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Pawel Wodkowski <pawelx.wodkowski@intel.com>
Cc: linux-block@vger.kernel.org, Mateusz Nowak <mateusz.nowak@intel.com>, linux-mmc@vger.kernel.org

On Wed, Mar 02, 2016 at 09:54:15AM +0100, Pawel Wodkowski wrote:
> From: Mateusz Nowak <mateusz.nowak@intel.com>
> 
> commit ca369d51b3e1 ("block/sd: Fix device-imposed transfer length limits")
> introduced max_dev_sectors as upper limit for max_hw_sectors. This caused
> limitation of maximum block size to default max_dev_sectors value - 127,
> causing performance degradation with higher block sizes.
> 
> This patchset is allowing mmc driver to override max_dev_sectors value.

Past commit 5f009d ("block: Initialize max_dev_sectors to 0"), this
should not be needed.
