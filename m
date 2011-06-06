From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: Re: [PATCH v2 1/3] dmaengine: add new dma API for
 max_segment_number
Date: Mon, 6 Jun 2011 17:06:03 +0900
Message-ID: <20110606170420I.fujita.tomonori@lab.ntt.co.jp>
References: <1307345414-26872-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1307345414-26872-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: shawn.guo@linaro.org
Cc: linux-kernel@vger.kernel.org, vinod.koul@intel.com, dan.j.williams@intel.com, cjb@laptop.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org, gregkh@suse.de
List-Id: linux-mmc@vger.kernel.org

On Mon,  6 Jun 2011 15:30:12 +0800
Shawn Guo <shawn.guo@linaro.org> wrote:

> Like dma_set(get)_max_seg_size for max_segment_size, the patch adds
> max_segment_number into device_dma_parameters and creates the
> corresponding dmaengine API dma_set(get)_max_seg_number for it.

As I wrote in another mail, dma_get|set_max_seg_size and
dma_get|set_seg_boundary are added to the dma mapping API. That is,
they enable the drivers (or subsystems) to tell IOMMUs about the
device dma limitations. When IOMMUs merge scatter list entries, they
look at the limitations.


> Here is the user story that tells the need of the new api.  The
> mxs-mmc is the mmc host controller for Freescale MXS architecture.
> There are a pair of  mmc host specific parameters max_seg_size and
> max_segs that mxs-mmc host driver needs to tell mmc core, so that
> mmc core can know how big each data segment could be and how many
> segments could be handled one time in a scatter list by host driver.
> 
> The mxs-mmc driver is one user of dmaengine mxs-dma, and it will call
> mxs-dma to transfer data in scatter list.  That is to say mxs-mmc has
> no idea of what max_seg_size and max_segs should be, because they are
> all mxs-dma capability parameters, and mxs-mmc needs to query them
> from mxs-dma.

max_segs isn't unrelated with the dma mapping API. I explained above,
IOMMUs doesn't increase the number of segments (could decrease the
number of segments by merging).

The limitation about the number of segment already lives elsewhere
(e.g. queue's limits.max_segments).
