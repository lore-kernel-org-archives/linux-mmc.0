From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: Re: [RFC PATCH v5 3/8] iommu: add a new capable IOMMU_CAP_MERGING
Date: Wed, 5 Jun 2019 14:38:08 +0200
Message-ID: <20190605123808.GA12529@lst.de>
References: <1559733114-4221-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1559733114-4221-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<7dfeb7d8-b777-b4af-d892-2829cd05241b@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <7dfeb7d8-b777-b4af-d892-2829cd05241b-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hch-jcswGhMUV9g@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Wed, Jun 05, 2019 at 01:21:59PM +0100, Robin Murphy wrote:
> And if the problem is really that you're not getting merging because of 
> exposing the wrong parameters to the DMA API and/or the block layer, or 
> that you just can't quite express your requirement to the block layer in 
> the first place, then that should really be tackled at the source rather 
> than worked around further down in the stack.

The problem is that we need a way to communicate to the block layer
that more than a single segment is ok IFF the DMA API instance supports
merging.  And of course the answer will depend on futher parameters
like the maximum merged segment size and alignment for the segement.

We'll need some way to communicate that, but I don't really think this
is series is the way to go.

We'd really need something hanging off the device (or through a query
API) how the dma map ops implementation exposes under what circumstances
it can merge.  The driver can then communicate that to the block layer
so that the block layer doesn't split requests up when reaching the
segement limit.
