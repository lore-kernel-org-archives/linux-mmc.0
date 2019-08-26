From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH -next] mmc: aspeed: Fix return value check in
 aspeed_sdc_probe()
Date: Mon, 26 Aug 2019 16:03:44 +0300
Message-ID: <20190826130343.GA23584@kadam>
References: <20190826120013.183435-1-weiyongjun1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190826120013.183435-1-weiyongjun1@huawei.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wei Yongjun <weiyongjun1@huawei.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-aspeed@lists.ozlabs.org, Andrew Jeffery <andrew@aj.id.au>, kernel-janitors@vger.kernel.org, linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Joel Stanley <joel@jms.id.au>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

> Fixes: 09eed7fffd33 ("mmc: Add support for the ASPEED SD controller")
                        ^^^^
When we're adding new files, could we use the prefix for the new driver
instead of just the subsystem?  "mmc: aspeed: Add new driver"?
Otherwise it's tricky to know what people want for the driver.

I just wrote this same patch and I swear I would have sent my patch
earlier but I spent hours thinking about the patch prefix and then the
census people came to the house and delayed me even more.

regards,
dan carpenter
