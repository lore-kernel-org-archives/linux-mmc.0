From: "Andrew Jeffery" <andrew@aj.id.au>
Subject: =?UTF-8?Q?Re:_[PATCH_-next]_mmc:_aspeed:_Fix_return_value_check_in_aspee?=
 =?UTF-8?Q?d=5Fsdc=5Fprobe()?=
Date: Tue, 27 Aug 2019 09:07:17 +0930
Message-ID: <629128e7-cc91-412f-8946-668fac2eb3b9@www.fastmail.com>
References: <20190826120013.183435-1-weiyongjun1@huawei.com>
 <20190826130343.GA23584@kadam>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190826130343.GA23584@kadam>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dan Carpenter <dan.carpenter@oracle.com>, Wei Yongjun <weiyongjun1@huawei.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-aspeed@lists.ozlabs.org, kernel-janitors@vger.kernel.org, linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Joel Stanley <joel@jms.id.au>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org



On Mon, 26 Aug 2019, at 22:34, Dan Carpenter wrote:
> > Fixes: 09eed7fffd33 ("mmc: Add support for the ASPEED SD controller")
>                         ^^^^
> When we're adding new files, could we use the prefix for the new driver
> instead of just the subsystem?  "mmc: aspeed: Add new driver"?
> Otherwise it's tricky to know what people want for the driver.

I don't have any issue with the request, but I don't understand this last
bit. What do you mean by "it's tricky to know what people want for the
driver"?

Andrew
