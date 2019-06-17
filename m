From: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [RFC PATCH v6 4/5] mmc: tmio: Use dma_max_mapping_size() instead
	of a workaround
Date: Mon, 17 Jun 2019 06:54:31 +0000
Message-ID: <OSBPR01MB3590218F1CA8CEE5DCB53065D8EB0@OSBPR01MB3590.jpnprd01.prod.outlook.com>
References: <1560421215-10750-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1560421215-10750-5-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<CAMuHMdXYqgPRX1WfUTRsKHhnSok5vfnr4AY36=vXoUvAxcNyWQ@mail.gmail.com>
	<20190614071800.GB8420@lst.de>
	<CAMuHMdXm5RtDUL5Wkyd6aJihu9nykYOhRf7vN6hOtB-OO8CTQQ@mail.gmail.com>
	<OSBPR01MB3590D4EF069F4554DA5D7ABBD8EB0@OSBPR01MB3590.jpnprd01.prod.outlook.com>
	<CAMuHMdWPUZGFWeKzPK=zkwc5h2SD+aW6ULb8C2rDJSmTWNXjeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAMuHMdWPUZGFWeKzPK=zkwc5h2SD+aW6ULb8C2rDJSmTWNXjeA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: Jens Axboe <axboe-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org>, Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-block-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-block-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi Geert-san,

> From: Geert Uytterhoeven, Sent: Monday, June 17, 2019 3:23 PM
> 
> Hi Shimoda-san,
> 
> On Mon, Jun 17, 2019 at 6:54 AM Yoshihiro Shimoda
> <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org> wrote:
> > > From: Geert Uytterhoeven, Sent: Friday, June 14, 2019 4:27 PM
> > > On Fri, Jun 14, 2019 at 9:18 AM Christoph Hellwig wrote:
> > > > On Thu, Jun 13, 2019 at 10:35:44PM +0200, Geert Uytterhoeven wrote:
<snip>
> > > > This really should use a min_t on size_t.  Otherwise the patch looks
> > > > fine:
> > >
> > > Followed by another min() to make it fit in mmc->max_req_size, which is
> > > unsigned int.
> >
> > Geert-san:
> >
> > I'm afraid, but I cannot understand this means.
> > Is this patch is possible to be upstream? Or, do you have any concern?
> 
> Please disregard my last comment: as the value of "mmc->max_blk_size *
> mmc->max_blk_count" is always 0xffff_ffff or less, "min_t(size_t,
> mmc->max_blk_size * mmc->max_blk_count, dma_max_mapping_size(&pdev->dev))"
> will always be 0xffff_ffff or less, too, so there is no extra step needed
> to make it fit in mmc->max_req_size.

Thank you for your prompt reply! I understood it.

> Sorry for the confusion.

No worries.

Best regards,
Yoshihiro Shimoda
