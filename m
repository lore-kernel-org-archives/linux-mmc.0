From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH -next] mmc: aspeed: Fix return value check in
 aspeed_sdc_probe()
Date: Tue, 27 Aug 2019 08:47:04 +0800 (CST)
Message-ID: <alpine.DEB.2.21.1908270845410.2537@hadrien>
References: <20190826120013.183435-1-weiyongjun1@huawei.com>
 <20190826130343.GA23584@kadam>
 <629128e7-cc91-412f-8946-668fac2eb3b9@www.fastmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <629128e7-cc91-412f-8946-668fac2eb3b9@www.fastmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andrew Jeffery <andrew@aj.id.au>
Cc: linux-arm-kernel@lists.infradead.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-aspeed@lists.ozlabs.org, kernel-janitors@vger.kernel.org, linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Wei Yongjun <weiyongjun1@huawei.com>, Joel Stanley <joel@jms.id.au>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: linux-mmc@vger.kernel.org



On Tue, 27 Aug 2019, Andrew Jeffery wrote:

>
>
> On Mon, 26 Aug 2019, at 22:34, Dan Carpenter wrote:
> > > Fixes: 09eed7fffd33 ("mmc: Add support for the ASPEED SD controller")
> >                         ^^^^
> > When we're adding new files, could we use the prefix for the new driver
> > instead of just the subsystem?  "mmc: aspeed: Add new driver"?
> > Otherwise it's tricky to know what people want for the driver.
>
> I don't have any issue with the request, but I don't understand this last
> bit. What do you mean by "it's tricky to know what people want for the
> driver"?

There is no obvious algorithm that tells how to go from a file name to an
appropriate subject line prefix.

julia
