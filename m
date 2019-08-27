From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH -next] mmc: aspeed: Fix return value check in
 aspeed_sdc_probe()
Date: Tue, 27 Aug 2019 15:49:43 +0200
Message-ID: <CAPDyKFqXLG7VCh+9oQQ4HD=6dHQLY1PHEkmC+atnB-zDntKULA@mail.gmail.com>
References: <20190826120013.183435-1-weiyongjun1@huawei.com>
 <20190826130343.GA23584@kadam>
 <629128e7-cc91-412f-8946-668fac2eb3b9@www.fastmail.com>
 <alpine.DEB.2.21.1908270845410.2537@hadrien>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <alpine.DEB.2.21.1908270845410.2537@hadrien>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Julia Lawall <julia.lawall@lip6.fr>, Dan Carpenter <dan.carpenter@oracle.com>, Andrew Jeffery <andrew@aj.id.au>, Wei Yongjun <weiyongjun1@huawei.com>
Cc: linux-aspeed <linux-aspeed@lists.ozlabs.org>, linux-mmc <linux-mmc@vger.kernel.org>, kernel-janitors@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Joel Stanley <joel@jms.id.au>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, 27 Aug 2019 at 02:47, Julia Lawall <julia.lawall@lip6.fr> wrote:
>
>
>
> On Tue, 27 Aug 2019, Andrew Jeffery wrote:
>
> >
> >
> > On Mon, 26 Aug 2019, at 22:34, Dan Carpenter wrote:
> > > > Fixes: 09eed7fffd33 ("mmc: Add support for the ASPEED SD controller")
> > >                         ^^^^
> > > When we're adding new files, could we use the prefix for the new driver
> > > instead of just the subsystem?  "mmc: aspeed: Add new driver"?
> > > Otherwise it's tricky to know what people want for the driver.
> >
> > I don't have any issue with the request, but I don't understand this last
> > bit. What do you mean by "it's tricky to know what people want for the
> > driver"?
>
> There is no obvious algorithm that tells how to go from a file name to an
> appropriate subject line prefix.

For MMC we normally use the name of the host driver file (excluding
".c") as part of the prefix.

For this case that means I amended the header into: mmc:
sdhci-of-aspeed: Fix return value check in aspeed_sdc_probe() and
applied it for next.

I also took the liberty to change this for the other related patches
for the "aspeed" driver to follow the same pattern.

Kind regards
Uffe
