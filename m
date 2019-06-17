From: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [RFC PATCH v6 5/5] mmc: queue: Use bigger segments if IOMMU can
	merge the segments
Date: Mon, 17 Jun 2019 06:46:33 +0000
Message-ID: <OSBPR01MB3590FA5DB10D9EF34F551335D8EB0@OSBPR01MB3590.jpnprd01.prod.outlook.com>
References: <1560421215-10750-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1560421215-10750-6-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<20190614072459.GD8420@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190614072459.GD8420-jcswGhMUV9g@public.gmane.org>
Content-Language: ja-JP
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: "axboe-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org" <axboe-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org>, "linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-block-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-block-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org" <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi Christoph,

> From: Christoph Hellwig, Sent: Friday, June 14, 2019 4:25 PM
> 
> On Thu, Jun 13, 2019 at 07:20:15PM +0900, Yoshihiro Shimoda wrote:
> > +static unsigned int mmc_get_max_segments(struct mmc_host *host)
> > +{
> > +	return host->can_merge ? BLK_MAX_SEGMENTS : host->max_segs;
> > +}
> 
> Note that BLK_MAX_SEGMENTS is really a little misnamed, it just
> is a BLK_DEFAULT_SEGMENTS.  I think you are better of picking your
> own value here (even if 128 ends up ok) than reusing this somewhat
> confusing constant.

Thank you for your comments. I got it. I'll fix this.

> > +	/*
> > +	 * Since blk_mq_alloc_tag_set() calls .init_request() of mmc_mq_ops,
> > +	 * the host->can_merge should be set before to get max_segs from
> > +	 * mmc_get_max_segments().
> > +	 */
> > +	if (host->max_segs < BLK_MAX_SEGMENTS &&
> > +	    device_iommu_mapped(mmc_dev(host)))
> > +		host->can_merge = 1;
> > +	else
> > +		host->can_merge = 0;
> > +
> 
> can_merge seems a little too generic a name to me.  Maybe can_iommu_merge?

I'll fix the name. Also, only the device_iommu_mapped() condition wiil cause
a problem on iommu=pt [1]. So, I'll add another condition here.

[1]
https://marc.info/?l=linux-mmc&m=156050608709643&w=2

Best regards,
Yoshihiro Shimoda
